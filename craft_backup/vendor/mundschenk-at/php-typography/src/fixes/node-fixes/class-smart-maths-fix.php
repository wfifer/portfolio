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
use \PHP_Typography\U;

/**
 * Applies smart math (if enabled).
 *
 * @author Peter Putzer <github@mundschenk.at>
 *
 * @since 5.0.0
 */
class Smart_Maths_Fix extends Abstract_Node_Fix {
	// First, let's find math equations.
	const MATH_EQUATION = "/
		(?<=\A|\s)										# lookbehind assertion: proceeded by beginning of string or space
		[\.,\'\"\¿\¡" . U::ELLIPSIS . U::SINGLE_QUOTE_OPEN . U::DOUBLE_QUOTE_OPEN . U::GUILLEMET_OPEN . U::GUILLEMET_CLOSE . U::SINGLE_LOW_9_QUOTE . U::DOUBLE_LOW_9_QUOTE . ']*
														# allowed proceeding punctuation
		[\-\(' . U::MINUS . ']*                  # optionally proceeded by dash, minus sign or open parenthesis
		[0-9]+                                          # must begin with a number
		(\.[0-9]+)?                                     # optionally allow decimal values after first integer
		(                                               # followed by a math symbol and a number
			[\/\*x\-+=\^' . U::MINUS . U::MULTIPLICATION . U::DIVISION . ']
														# allowed math symbols
			[\-\(' . U::MINUS . ']*              # opptionally preceeded by dash, minus sign or open parenthesis
			[0-9]+                                      # must begin with a number
			(\.[0-9]+)?                                 # optionally allow decimal values after first integer
			[\-\(\)' . U::MINUS . "]*			# opptionally preceeded by dash, minus sign or parenthesis
		)+
		[\.,;:\'\"\?\!" . U::ELLIPSIS . U::SINGLE_QUOTE_CLOSE . U::DOUBLE_QUOTE_CLOSE . U::GUILLEMET_OPEN . U::GUILLEMET_CLOSE . ']*
														# allowed trailing punctuation
		(?=\Z|\s)                                       # lookahead assertion: followed by end of string or space
	/ux';

	// Revert 4-4 to plain minus-hyphen so as to not mess with ranges of numbers (i.e. pp. 46-50).
	const REVERT_RANGE = '/
			(
				(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
				\d+
			)
			[\-' . U::MINUS . "]
			(
				\d+
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';
	// Revert fractions to basic slash.
	const REVERT_FRACTION = "/
			(
				(?<=\s|\A|\'|\"|" . U::NO_BREAK_SPACE . ')
				\d+
			)
			' . U::DIVISION . "
			(
				\d+
				(?:st|nd|rd|th)?
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';
	// YYYY-MM-DD.
	const REVERT_DATE_YYYY_MM_DD = '/
			(
				(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
				[12][0-9]{3}
			)
			[\-' . U::MINUS . ']
			(
				(?:[0]?[1-9]|[1][0-2])
			)
			[\-' . U::MINUS . "]
			(
				(?:[0]?[1-9]|[12][0-9]|[3][0-1])
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';
	// MM-DD-YYYY or DD-MM-YYYY.
	const REVERT_DATE_MM_DD_YYYY = '/
			(?:
				(?:
					(
						(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
						(?:[0]?[1-9]|[1][0-2])
					)
					[\-' . U::MINUS . ']
					(
						(?:[0]?[1-9]|[12][0-9]|[3][0-1])
					)
				)
				|
				(?:
					(
						(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
						(?:[0]?[1-9]|[12][0-9]|[3][0-1])
					)
					[\-' . U::MINUS . ']
					(
						(?:[0]?[1-9]|[1][0-2])
					)
				)
			)
			[\-' . U::MINUS . "]
			(
				[12][0-9]{3}
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';
	// YYYY-MM or YYYY-DDD next.
	const REVERT_DATE_YYYY_MM = '/
			(
				(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
				[12][0-9]{3}
			)
			[\-' . U::MINUS . "]
			(
				(?:
					(?:[0][1-9]|[1][0-2])
					|
					(?:[0][0-9][1-9]|[1-2][0-9]{2}|[3][0-5][0-9]|[3][6][0-6])
				)
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';

	// MM/DD/YYYY or DD/MM/YYYY.
	const REVERT_DATE_MM_DD_YYYY_SLASHED = '/
			(?:
				(?:
					(
						(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
						(?:[0][1-9]|[1][0-2])
					)
					[\/' . U::DIVISION . ']
					(
						(?:[0][1-9]|[12][0-9]|[3][0-1])
					)
				)
				|
				(?:
					(
						(?<=\s|\A|' . U::NO_BREAK_SPACE . ')
						(?:[0][1-9]|[12][0-9]|[3][0-1])
					)
					[\/' . U::DIVISION . ']
					(
						(?:[0][1-9]|[1][0-2])
					)
				)
			)
			[\/' . U::DIVISION . "]
			(
				[12][0-9]{3}
				(?=\s|\Z|\)|\]|\.|\,|\?|\;|\:|\'|\"|\!|" . U::NO_BREAK_SPACE . ')
			)
		/xu';

	/**
	 * Apply the fix to a given textnode.
	 *
	 * @param \DOMText $textnode Required.
	 * @param Settings $settings Required.
	 * @param bool     $is_title Optional. Default false.
	 */
	public function apply( \DOMText $textnode, Settings $settings, $is_title = false ) {
		if ( empty( $settings['smartMath'] ) ) {
			return;
		}

		// First, let's find math equations.
		$textnode->data = preg_replace_callback( self::MATH_EQUATION, function( array $matches ) {
			$matches[0] = str_replace( '-', U::MINUS,          $matches[0] );
			$matches[0] = str_replace( '/', U::DIVISION,       $matches[0] );
			$matches[0] = str_replace( 'x', U::MULTIPLICATION, $matches[0] );
			$matches[0] = str_replace( '*', U::MULTIPLICATION, $matches[0] );

			return $matches[0];

		}, $textnode->data );

		// Revert 4-4 to plain minus-hyphen so as to not mess with ranges of numbers (i.e. pp. 46-50).
		$textnode->data = preg_replace( self::REVERT_RANGE, '$1-$2', $textnode->data );

		// Revert fractions to basic slash.
		// We'll leave styling fractions to smart_fractions.
		$textnode->data = preg_replace( self::REVERT_FRACTION, '$1/$2', $textnode->data );

		// Revert date back to original formats.
		// YYYY-MM-DD.
		$textnode->data = preg_replace( self::REVERT_DATE_YYYY_MM_DD,         '$1-$2-$3',     $textnode->data );
		// MM-DD-YYYY or DD-MM-YYYY.
		$textnode->data = preg_replace( self::REVERT_DATE_MM_DD_YYYY,         '$1$3-$2$4-$5', $textnode->data );
		// YYYY-MM or YYYY-DDD next.
		$textnode->data = preg_replace( self::REVERT_DATE_YYYY_MM,            '$1-$2',        $textnode->data );
		// MM/DD/YYYY or DD/MM/YYYY.
		$textnode->data = preg_replace( self::REVERT_DATE_MM_DD_YYYY_SLASHED, '$1$3/$2$4/$5', $textnode->data );
	}
}
