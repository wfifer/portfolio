<?php
/**
 *  This file is part of PHP-Typography.
 *
 *  Copyright 2017 Peter Putzer.
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
use \PHP_Typography\Settings;
use \PHP_Typography\Strings;
use \PHP_Typography\U;

/**
 * Wraps hanging punctuation in <span class="pull-*"> and <span class="push-*">, if enabled.
 *
 * @author Peter Putzer <github@mundschenk.at>
 *
 * @since 5.0.0
 */
class Style_Hanging_Punctuation_Fix extends Classes_Dependent_Fix {

	/**
	 * CSS class for single-width punctuation marks.
	 *
	 * @var string
	 */
	protected $push_single_class;

	/**
	 * CSS class for double-width punctuation marks.
	 *
	 * @var string
	 */
	protected $push_double_class;

	/**
	 * CSS class for single-width punctuation marks.
	 *
	 * @var string
	 */
	protected $pull_single_class;

	/**
	 * CSS class for double-width punctuation marks.
	 *
	 * @var string
	 */
	protected $pull_double_class;


	// Hanging punctuation.
	const _DOUBLE_HANGING_PUNCTUATION =
		'"' .
		U::DOUBLE_QUOTE_OPEN .
		U::DOUBLE_QUOTE_CLOSE .
		U::DOUBLE_LOW_9_QUOTE .
		U::DOUBLE_PRIME; // requires modifiers: x (multiline pattern) u (utf8).

	const _SINGLE_HANGING_PUNCTUATION =
		"'" .
		U::SINGLE_QUOTE_OPEN .
		U::SINGLE_QUOTE_CLOSE .
		U::SINGLE_LOW_9_QUOTE .
		U::SINGLE_PRIME .
		U::APOSTROPHE; // requires modifiers: x (multiline pattern) u (utf8).

	// Style hanging punctuation.
	const STYLE_DOUBLE = '/(\s)([' . self::_DOUBLE_HANGING_PUNCTUATION . '])(\w+)/u';
	const STYLE_SINGLE = '/(\s)([' . self::_SINGLE_HANGING_PUNCTUATION . '])(\w+)/u';
	const STYLE_INITIAL_DOUBLE = '/(?:\A)([' . self::_DOUBLE_HANGING_PUNCTUATION . '])(\w+)/u';
	const STYLE_INITIAL_SINGLE = '/(?:\A)([' . self::_SINGLE_HANGING_PUNCTUATION . '])(\w+)/u';

	/**
	 * Creates a new classes dependent fix.
	 *
	 * @param string $push_single_class Required.
	 * @param string $push_double_class Required.
	 * @param string $pull_single_class Required.
	 * @param string $pull_double_class Required.
	 * @param bool   $feed_compatible   Optional. Default false.
	 */
	public function __construct( $push_single_class, $push_double_class, $pull_single_class, $pull_double_class, $feed_compatible = false ) {
		parent::__construct( [ $pull_single_class, $pull_double_class ], $feed_compatible );

		$this->push_single_class = $push_single_class;
		$this->push_double_class = $push_double_class;
		$this->pull_single_class = $pull_single_class;
		$this->pull_double_class = $pull_double_class;
	}

	/**
	 * Apply the fix to a given textnode.
	 *
	 * @param \DOMText $textnode Required.
	 * @param Settings $settings Required.
	 * @param bool     $is_title Optional. Default false.
	 */
	public function apply_internal( \DOMText $textnode, Settings $settings, $is_title = false ) {
		if ( empty( $settings['styleHangingPunctuation'] ) ) {
			return;
		}

		// Clone the node's data attribute for the duration.
		$node_data = $textnode->data;

		// We need the parent.
		$block     = DOM::get_block_parent( $textnode );
		$firstnode = ! empty( $block ) ? DOM::get_first_textnode( $block ) : null;

		// Need to get context of adjacent characters outside adjacent inline tags or HTML comment
		// if we have adjacent characters add them to the text.
		$next_character = DOM::get_next_chr( $textnode );
		$node_data      = "{$node_data}{$next_character}"; // We have no interest in preceeding characters for this fix.

		$node_data = preg_replace( self::STYLE_DOUBLE, '$1<span class="' . $this->push_double_class . '"></span>' . U::ZERO_WIDTH_SPACE . '<span class="' . $this->pull_double_class . '">$2</span>$3', $node_data );
		$node_data = preg_replace( self::STYLE_SINGLE, '$1<span class="' . $this->push_single_class . '"></span>' . U::ZERO_WIDTH_SPACE . '<span class="' . $this->pull_single_class . '">$2</span>$3', $node_data );

		if ( empty( $block ) || $firstnode === $textnode ) {
			$node_data = preg_replace( self::STYLE_INITIAL_DOUBLE, '<span class="' . $this->pull_double_class . '">$1</span>$2', $node_data );
			$node_data = preg_replace( self::STYLE_INITIAL_SINGLE, '<span class="' . $this->pull_single_class . '">$1</span>$2', $node_data );
		} else {
			$node_data = preg_replace( self::STYLE_INITIAL_DOUBLE, '<span class="' . $this->push_double_class . '"></span>' . U::ZERO_WIDTH_SPACE . '<span class="' . $this->pull_double_class . '">$1</span>$2', $node_data );
			$node_data = preg_replace( self::STYLE_INITIAL_SINGLE, '<span class="' . $this->push_single_class . '"></span>' . U::ZERO_WIDTH_SPACE . '<span class="' . $this->pull_single_class . '">$1</span>$2', $node_data );
		}

		// Remove any added characters.
		$strlen         = Strings::functions( $node_data )['strlen'];
		$textnode->data = self::remove_adjacent_characters( $node_data, 0, $strlen( $next_character ) );
	}
}
