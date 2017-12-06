<?php
/**
 *  This file is part of PHP-Typography.
 *
 *  Copyright 2014-2017 Peter Putzer.
 *  Copyright 2009-2011 KINGdesk, LLC.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *  ***
 *
 *  @package mundschenk-at/php-typography
 *  @license http://www.gnu.org/licenses/gpl-2.0.html
 */

namespace PHP_Typography\Fixes\Node_Fixes;

use \PHP_Typography\DOM;
use \PHP_Typography\RE;
use \PHP_Typography\Settings;
use \PHP_Typography\Strings;
use \PHP_Typography\U;

/**
 * Applies smart quotes (if enabled).
 *
 * @author Peter Putzer <github@mundschenk.at>
 *
 * @since 5.0.0
 */
class Smart_Quotes_Fix extends Abstract_Node_Fix {

	const APOSTROPHE_EXCEPTIONS = [
		"'tain" . U::APOSTROPHE . 't' => U::APOSTROPHE . 'tain' . U::APOSTROPHE . 't',
		"'twere"                      => U::APOSTROPHE . 'twere',
		"'twas"                       => U::APOSTROPHE . 'twas',
		"'tis"                        => U::APOSTROPHE . 'tis',
		"'til"                        => U::APOSTROPHE . 'til',
		"'bout"                       => U::APOSTROPHE . 'bout',
		"'nuff"                       => U::APOSTROPHE . 'nuff',
		"'round"                      => U::APOSTROPHE . 'round',
		"'cause"                      => U::APOSTROPHE . 'cause',
		"'splainin"                   => U::APOSTROPHE . 'splainin',
	];

	const NUMBERS_BEFORE_PRIME = '\b(?:\d+\/)?\d{1,3}';

	const DOUBLE_PRIME                  = '/(' . self::NUMBERS_BEFORE_PRIME . ")''(?=\W|\Z)/u";
	const DOUBLE_PRIME_COMPOUND         = '/(' . self::NUMBERS_BEFORE_PRIME . ")''(?=-\w)/u";
	const DOUBLE_PRIME_1_GLYPH          = '/(' . self::NUMBERS_BEFORE_PRIME . ')"(?=\W|\Z)/u';
	const DOUBLE_PRIME_1_GLYPH_COMPOUND = '/(' . self::NUMBERS_BEFORE_PRIME . ')"(?=-\w)/u';
	const SINGLE_PRIME                  = '/(' . self::NUMBERS_BEFORE_PRIME . ")'(?=\W|\Z)/u";
	const SINGLE_PRIME_COMPOUND         = '/(' . self::NUMBERS_BEFORE_PRIME . ")'(?=-\w)/u";
	const SINGLE_DOUBLE_PRIME           = '/(' . self::NUMBERS_BEFORE_PRIME . ")'(\s*)(\b(?:\d+\/)?\d+)''(?=\W|\Z)/u";
	const SINGLE_DOUBLE_PRIME_1_GLYPH   = '/(' . self::NUMBERS_BEFORE_PRIME . ")'(\s*)(\b(?:\d+\/)?\d+)\"(?=\W|\Z)/u";

	const SINGLE_QUOTED_NUMBERS      = "/(?<=\W|\A)'([^\"]*\d+)'(?=\W|\Z)/u";
	const DOUBLE_QUOTED_NUMBERS      = '/(?<=\W|\A)"([^"]*\d+)"(?=\W|\Z)/u';
	const COMMA_QUOTE                = '/(?<=\s|\A),(?=\S)/';
	const APOSTROPHE_WORDS           = "/(?<=[\w])'(?=[\w])/u";
	const APOSTROPHE_DECADES         = "/'(\d\d\b)/";
	const SINGLE_QUOTE_OPEN          = "/'(?=[\w])/u";
	const SINGLE_QUOTE_CLOSE         = "/(?<=[\w])'/u";
	const SINGLE_QUOTE_OPEN_SPECIAL  = "/(?<=\s|\A)'(?=\S)/"; // like _'¿hola?'_.
	const SINGLE_QUOTE_CLOSE_SPECIAL = "/(?<=\S)'(?=\s|\Z)/";
	const DOUBLE_QUOTE_OPEN          = '/"(?=[\w])/u';
	const DOUBLE_QUOTE_CLOSE         = '/(?<=[\w])"/u';
	const DOUBLE_QUOTE_OPEN_SPECIAL  = '/(?<=\s|\A)"(?=\S)/';
	const DOUBLE_QUOTE_CLOSE_SPECIAL = '/(?<=\S)"(?=\s|\Z)/';


	/**
	 * Apostrophe exceptions matching array.
	 *
	 * @var array
	 */
	protected $apostrophe_exception_matches;

	/**
	 * Apostrophe exceptions replacement array.
	 *
	 * @var array
	 */
	protected $apostrophe_exception_replacements;

	/**
	 * Cached primary quote style.
	 *
	 * @var \PHP_Typography\Settings\Quotes|null
	 */
	protected $cached_primary_quotes;

	/**
	 * Cached secondary quote style.
	 *
	 * @var \PHP_Typography\Settings\Quotes|null
	 */
	protected $cached_secondary_quotes;

	/**
	 * Brackets matching array (depending on quote styles).
	 *
	 * @var array
	 */
	protected $brackets_matches;

	/**
	 * Brackets replacement array (depending on quote styles).
	 *
	 * @var array
	 */
	protected $brackets_replacements;

	/**
	 * Creates a new fix instance.
	 *
	 * @param bool $feed_compatible Optional. Default false.
	 */
	public function __construct( $feed_compatible = false ) {
		parent::__construct( $feed_compatible );

		$this->apostrophe_exception_matches      = array_keys( self::APOSTROPHE_EXCEPTIONS );
		$this->apostrophe_exception_replacements = array_values( self::APOSTROPHE_EXCEPTIONS );
	}

	/**
	 * Apply the fix to a given textnode.
	 *
	 * @param \DOMText $textnode Required.
	 * @param Settings $settings Required.
	 * @param bool     $is_title Optional. Default false.
	 */
	public function apply( \DOMText $textnode, Settings $settings, $is_title = false ) {
		if ( empty( $settings['smartQuotes'] ) ) {
			return;
		}

		// Clone the node's data attribute for the duration.
		$node_data = $textnode->data;

		// Need to get context of adjacent characters outside adjacent inline tags or HTML comment
		// if we have adjacent characters add them to the text.
		$previous_character = DOM::get_prev_chr( $textnode );
		$next_character     = DOM::get_next_chr( $textnode );
		$node_data          = "{$previous_character}{$node_data}{$next_character}";

		// Various special characters and regular expressions.
		$double = $settings->primary_quote_style();
		$single = $settings->secondary_quote_style();

		// Mark quotes to ensure proper removal of replaced adjacent characters.
		$double_open  = RE::ESCAPE_MARKER . $double->open() . RE::ESCAPE_MARKER;
		$double_close = RE::ESCAPE_MARKER . $double->close() . RE::ESCAPE_MARKER;
		$single_open  = RE::ESCAPE_MARKER . $single->open() . RE::ESCAPE_MARKER;
		$single_close = RE::ESCAPE_MARKER . $single->close() . RE::ESCAPE_MARKER;

		if ( $double != $this->cached_primary_quotes || $single != $this->cached_secondary_quotes ) { // WPCS: loose comparison ok.
			$this->update_smart_quotes_brackets( $double_open, $double_close, $single_open, $single_close );
			$this->cached_primary_quotes   = $double;
			$this->cached_secondary_quotes = $single;
		}

		// Before primes, handle quoted numbers (and quotes ending in numbers).
		$node_data = preg_replace( self::SINGLE_QUOTED_NUMBERS, "{$single_open}\$1{$single_close}", $node_data );
		$node_data = preg_replace( self::DOUBLE_QUOTED_NUMBERS, "{$double_open}\$1{$double_close}", $node_data );

		// Guillemets.
		$node_data = str_replace( '<<',       U::GUILLEMET_OPEN,  $node_data );
		$node_data = str_replace( '&lt;&lt;', U::GUILLEMET_OPEN,  $node_data );
		$node_data = str_replace( '>>',       U::GUILLEMET_CLOSE, $node_data );
		$node_data = str_replace( '&gt;&gt;', U::GUILLEMET_CLOSE, $node_data );

		// Primes.
		$node_data = preg_replace( self::SINGLE_DOUBLE_PRIME,           '$1' . U::SINGLE_PRIME . '$2$3' . U::DOUBLE_PRIME, $node_data );
		$node_data = preg_replace( self::SINGLE_DOUBLE_PRIME_1_GLYPH,   '$1' . U::SINGLE_PRIME . '$2$3' . U::DOUBLE_PRIME, $node_data );
		$node_data = preg_replace( self::DOUBLE_PRIME,                  '$1' . U::DOUBLE_PRIME,                            $node_data ); // should not interfere with regular quote matching.
		$node_data = preg_replace( self::SINGLE_PRIME,                  '$1' . U::SINGLE_PRIME,                            $node_data );
		$node_data = preg_replace( self::SINGLE_PRIME_COMPOUND,         '$1' . U::SINGLE_PRIME,                            $node_data );
		$node_data = preg_replace( self::DOUBLE_PRIME_COMPOUND,         '$1' . U::DOUBLE_PRIME,                            $node_data );
		$node_data = preg_replace( self::DOUBLE_PRIME_1_GLYPH,          '$1' . U::DOUBLE_PRIME,                            $node_data ); // should not interfere with regular quote matching.
		$node_data = preg_replace( self::DOUBLE_PRIME_1_GLYPH_COMPOUND, '$1' . U::DOUBLE_PRIME,                            $node_data );

		// Backticks.
		$node_data = str_replace( '``', $double_open,  $node_data );
		$node_data = str_replace( '`',  $single_open,  $node_data );
		$node_data = str_replace( "''", $double_close, $node_data );

		// Comma quotes.
		$node_data = str_replace( ',,', U::DOUBLE_LOW_9_QUOTE, $node_data );
		$node_data = preg_replace( self::COMMA_QUOTE, U::SINGLE_LOW_9_QUOTE, $node_data ); // like _,¿hola?'_.

		// Apostrophes.
		$node_data = preg_replace( self::APOSTROPHE_WORDS,   U::APOSTROPHE,        $node_data );
		$node_data = preg_replace( self::APOSTROPHE_DECADES, U::APOSTROPHE . '$1', $node_data ); // decades: '98.
		$node_data = str_replace( $this->apostrophe_exception_matches, $this->apostrophe_exception_replacements, $node_data );

		// Quotes.
		$node_data = str_replace( $this->brackets_matches, $this->brackets_replacements, $node_data );
		$node_data = preg_replace( self::SINGLE_QUOTE_OPEN,          $single_open,  $node_data );
		$node_data = preg_replace( self::SINGLE_QUOTE_CLOSE,         $single_close, $node_data );
		$node_data = preg_replace( self::SINGLE_QUOTE_OPEN_SPECIAL,  $single_open,  $node_data ); // like _'¿hola?'_.
		$node_data = preg_replace( self::SINGLE_QUOTE_CLOSE_SPECIAL, $single_close, $node_data );
		$node_data = preg_replace( self::DOUBLE_QUOTE_OPEN,          $double_open,  $node_data );
		$node_data = preg_replace( self::DOUBLE_QUOTE_CLOSE,         $double_close, $node_data );
		$node_data = preg_replace( self::DOUBLE_QUOTE_OPEN_SPECIAL,  $double_open,  $node_data );
		$node_data = preg_replace( self::DOUBLE_QUOTE_CLOSE_SPECIAL, $double_close, $node_data );

		// Quote catch-alls - assume left over quotes are closing - as this is often the most complicated position, thus most likely to be missed.
		$node_data = str_replace( "'", $single_close, $node_data );
		$node_data = str_replace( '"', $double_close, $node_data );

		// Check if adjacent characters where replaced with multi-byte replacements.
		$quotes          = [ $double_open, $double_close, $single_open, $single_close ];
		$func            = Strings::functions( $node_data );
		$substr          = $func['substr'];
		$strlen          = $func['strlen'];
		$previous_length = self::calc_adjacent_length( $strlen( $previous_character ), $previous_character, $node_data, $quotes, $substr, $strlen, false );
		$next_length     = self::calc_adjacent_length( $strlen( $next_character ), $next_character, $node_data, $quotes, $substr, $strlen, true );

		// If we have adjacent characters, remove them from the text.
		$node_data      = self::remove_adjacent_characters( $node_data, $previous_length, $next_length );

		// Remove the escape markers and restore the text to the actual node.
		$textnode->data = str_replace( RE::ESCAPE_MARKER, '', $node_data );
	}

	/**
	 * Calculates the adjacent character length.
	 *
	 * @param  int      $current_length     The current length of the adjacent character(s).
	 * @param  string   $adjacent_character The adjacent character.
	 * @param  string   $haystack           The complete string.
	 * @param  string[] $needles            The replacement(s) to look for.
	 * @param  callable $substr             A `substr`-like function.
	 * @param  callable $strlen             A 'strlen'-like function.
	 * @param  bool     $reverse            Optional. Default false.
	 *
	 * @return int
	 */
	private static function calc_adjacent_length( $current_length, $adjacent_character, $haystack, array $needles, callable $substr, callable $strlen, $reverse = false ) {
		if ( $current_length > 0 && $adjacent_character !== $substr( $haystack, $reverse ? -$current_length : $current_length ) ) {
			foreach ( $needles as $needle ) {
				$len = $strlen( $needle );

				if ( $needle === $substr( $haystack, ( $reverse ? -$len : 0 ), $len ) ) {
					return $len;
				}
			}
		}

		return $current_length;
	}

	/**
	 * Update smartQuotesBrackets component after quote style change.
	 *
	 * @param  string $primary_open    Primary quote style open.
	 * @param  string $primary_close   Primary quote style close.
	 * @param  string $secondary_open  Secondary quote style open.
	 * @param  string $secondary_close Secondary quote style close.
	 */
	private function update_smart_quotes_brackets( $primary_open, $primary_close, $secondary_open, $secondary_close ) {
		$brackets = [
			// Single quotes.
			"['"  => '[' . $secondary_open,
			"{'"  => '{' . $secondary_open,
			"('"  => '(' . $secondary_open,
			"']"  => $secondary_close . ']',
			"'}"  => $secondary_close . '}',
			"')"  => $secondary_close . ')',

			// Double quotes.
			'["'  => '[' . $primary_open,
			'{"'  => '{' . $primary_open,
			'("'  => '(' . $primary_open,
			'"]'  => $primary_close . ']',
			'"}'  => $primary_close . '}',
			'")'  => $primary_close . ')',

			// Quotes & quotes.
			"\"'" => $primary_open . $secondary_open,
			"'\"" => $secondary_close . $primary_close,
		];

		$this->brackets_matches      = array_keys( $brackets );
		$this->brackets_replacements = array_values( $brackets );
	}
}
