# Change History

## 5.2.2 - November 25, 2017
*   _Bugfix_: Remove some ambiguous diacritics replacements from the German language file.

## 5.2.1 - October 27, 2017
*   _Bugfix_: Dewidow didn't honor narrow spaces.

## 5.2.0 - September 30, 2017
*   _Change_: `Hyphenator_Cache` has been moved to `Hyphenator\Cache`.
*   _Change_: New method `has_changed` for `Hyphenator\Cache`.
*   _Change_: Properties `Settings::inappropriate_tags` and `Settings::self_closing_tags` have been deprecated.
*   _Bugfix_: Settings hash omitted some properties (props @shimikano).

## 5.1.0 - September 10, 2017

*   _Feature_: New hyphenation language "Swiss-German (Traditional)" added.
*   _Feature_: Dewidowing can now be applied to the final 1–3 words.
*   _Change_: Started adding some benchmarks.
*   _Change_: Updated HTML5 parser (html5-php) to 2.3.0:
    -   Tokenizer performance improved by 20 percent.
    -   Various small bugfixes.

## 5.0.2. - August 28, 2017

*   _Bugfix_: Fatal error on PHP 5.6.x (caused by using `__METHOD__` as a variable function) fixed.

## 5.0.1. - August 26, 2017

*   _Bugfix_: Hyphenator caching was not really working.

## 5.0.0. - August 13, 2017

*   _Feature_: Use Composer for dependencies.
*   _Change_: API refactoring:
    -   Core API refactored and minimum PHP version increased to 5.6.0
    -   PHP_Typography broken into smaller classes (one for each "fix").
    -   Default Settings removed.
*   _Bugfix_: French punctuation spacing after links (and other inline tags) fixed.
*   _Bugfix_: Lone ampersands are treated as single-character words.
*   _Bugfix_: Hyphenated words are properly de-widowed.

## 4.2.1 - June 9, 2017

*   _Bugfix_: Prevent crash on PHP 5.x when building the hyphenation trie.

## 4.2.0 - June 8, 2017

*   _Feature_: Prevent line-breaks in numbered abbreviations (e.g. `ISO 9001`).
*   _Change_: Core API refactored and minimum PHP version increased to 5.4.0.
*   _Change_: Updated hyphenation patterns:
    -   German
    -   German (Traditional)
    -   Latin
    -   Latin (Liturgical)
*   _Change_: Updated list of valid top-level domains.

## 4.1.2 - May 26, 2017

*   _Bugfix_: Hyphenation patterns at the end of word were accidentally ignored.
*   _Bugfix_: Diacritics replacement does not count soft hyphens as word boundaries anymore.

## 4.1.1 - March 19, 2017

*   _Bugfix_: Performance issue accidentally introduced in 4.1.0 fixed.

## 4.1.0 - March 18, 2017

*   _Feature_: Hyphenator instance has been made cacheable.
*   _Bugfix_: Incorrect replacement of initial hyphens fixed.
*   _Bugfix_: French spacing rules improved.
*   _Bugfix_: Proper dashes for German date intervals.

## 4.0.1 - January 7, 2017

*   _Bugfix_: Workaround for PHP 5.3 issue in `dewidow` callback.

## 4.0.0 - January 6, 2017

*   _Feature_: New Settings API added.
*   _Feature_: New hyphenation languages
    -   Hindi,
    -   Marathi,
    -   Occitan,
    -   Oriya,
    -   Panjabi,
    -   Tamil,
    -   Telugu.
*   _Change_: Updated list of valid top-level domains.

## 3.5.3 - December 17, 2016

*   _Bugfix_: Remove ambiguous entries from German diacritics replacement file.

## 3.5.2

_Skipped._

## 3.5.1 - November 05, 2016

*   _Bugfix_: Quotes ending in numbers were sometimes interpreted as primes.

## 3.5.0 - October 21, 2016

*   _Feature_: Added "Latin (Liturgical)" as a new hyphenation language.
*   _Change_: Updated list of valid top-level domains.
*   _Change_: Updated HTML5 parser (html5-php) to 2.2.2.
*   _Bugfix_: Custom hyphenations with more than one hyphenation point were not working properly.
*   _Bugfix_: The `min_after` hyphenation setting was off by one.
*   _Bugfix_: Fractions did not play nice with prime symbols.

## 3.4.0 - July 10, 2016

*   Store hyphenation patterns as JSON files instead of PHP.
*   Updated list of valid top-level domains.

## 3.3.0 - June 27, 2016

*   Updated HTML parser (html5-php) to 2.2.1.
*   Updated list of valid top-level domains.
*   Prevent references to US non-profit organizations like `501(c)(3)` being replaced with the copyright symbol (props @randybruder).
*   Added CSS classes for smart fractions ("numerator", "denominator") and ordinal suffixes ("ordinal").
*   Fixed « and » spacing when French punctuation style is enabled.

## 3.2.7 - April 14, 2016

*   "Duplicate ID" warnings should be gone now, regardless of the installed libXML version.

## 3.2.1–3.2.6

_Skipped._

## 3.2.0 - March 20, 2016

*   Added support for the French punctuation style (thin non-breakable space before `;:?!`).
*   Added proper hyphenation of hyphenated compound words (e.g. `editor-in-chief`).
*   Added partial support for styling hanging punctuation.

## 3.1.3 - January 13, 2016

*   Pre­vent in­cor­rect re­place­ment of straight quotes with primes (e.g. `"number 6"` is not re­placed with `“num­ber 6″` but with `“num­ber 6”`).
*   Fixed a bug that pre­vented header tags (`<h1>` … `<h6>`) that were set as “tags to ig­nore” from ac­tu­ally be­ing left alone by the plu­gin.

## 3.1.2

_Skipped._

## 3.1.1 - January 5, 2016

*   Fixed fatal error when running on PHP 5.3 (use of $this in anonymous function).

## 3.1.0 - January 3, 2016

*   Minimum PHP version updated to 5.3.4 (from 5.3.0) to ensure consistent handling of UTF-8 regular expressions.
*   Fixed diacritics replacement for UTF-8 strings
*   Date-like values (e.g. "during the fiscal year 2015/2016") are not converted to smart fractions anymore.
*   Added ability to switch between dash styles: both traditional US (em dash without spacing) and international usage (en dash with spaces) can be selected.
*   Various white-space fixes related to dash styling.
*   Fixed a bug where block-level tags where not detected corrected.
*   Added workaround for duplicate ID warnings generated by some versions of libXML.
*   Updated all hyphenation files and added the following new languages:
    -   Afrikaans,
    -   Armenian,
    -   Dutch,
    -   Georgian,
    -   German (Traditional),
    -   Latin (Classical),
    -   Latvian,
    -   Thai, and
    -   Turkmen.

## 3.0.4 - December 12, 2015

*   Prevent accidentally invalid XPath queries from being fatal on the frontend.

## 3.0.3 - December 8, 2015

*   Fixed a bug in the XPath expression for ignoring tags by CSS ID.

## 3.0.2 - December 3, 2015

*   A typo prevented custom quote styles from working.

## 3.0.1

_Skipped._

## 3.0.0 - December 2, 2015

*   DOM-based HTML parsing with HTML5-PHP
*   Added German as a diacritics language (mainly for French words).
*   Various optimizations (hyphenation is still slow, though)
*   Fixed custom hyphenation patterns.
*   Adopted semantic versioning for the project.

## 2.0 - July 7, 2010

*   Simplified acronym identification to not include some obscure uppercase characters. This will reduce support for some non-English languages, but it resolves an issue of catastrophic failure (where the entire page fails to load) with certain server configurations.
*   Security Fix: Prevented comments with exceptionally long strings from causing fatal PHP error.

## 1.22 - March 4, 2010

*   Fixed bug that caused occasional hyphenation errors for non-English languages.

## 1.21 - December 31, 2009

*   Fixed bug in custom diacritic handling

## 1.20 - December 20, 2009

*   Resolved uninitialized variable
*   Added HTML5 elements to parsing algorithm for greater contextual awareness

## 1.19 - December 1, 2009

*   Fixed bug where dewidow functionality would add broken no-break spaces to the end of texts, and smart_exponents would drop some of the resulting text.
*   Declared encoding in all instances of mb_substr to avoid conflicts
*   Corrected a few instances of undeclared variables.

## 1.18 - November 10, 2009

*   Added Norwegian Hyphenation Patterns

## 1.17 - November 9, 2009

*   Fixed bug in diacritic handling.

## 1.16 - November 4, 2009

*   Added automated diacritic replacements (i.e. "creme brulee" becomes "crème brûlée").
*   Improved smart quotes and smart dashes with sensitivity to adjacent diacritic characters.

## 1.15 - October 21, 2009

*   Replaced quotation language styles with individual selection of primary and secondary quotation styles.

## 1.14 - September 8, 2009

*   Improved space collapse functionality.
*   Corrected bug in smart quote and single character word handling where the "0" character may be improperly duplicated

## 1.13 - August 31, 2009

*   Added option to collapse adjacent space characters to a single character

## 1.12 - August 17, 2009

*   Corrected multibyte character handling error that could cause some text to not display properly

## 1.11 - August 14, 2009

*   Added language specific quote handling (for single quotes, not just double) for English, German and French quotation styles

## 1.10 - August 14, 2009

*   Added language specific quote handling for English, German and French quotation styles
*   Corrected multibyte character handling error that could cause some text to not display properly
*   Expanded the multibyte character set recognized as valid word characters for improved hyphenation

## 1.9 - August 12, 2009

*   Added option to force single character words to wrap to new line (unless they are widows).
*   Fixed bug where hyphenation pattern settings were not initialized with multiple phpTypography class instances.

## 1.8 - August 4, 2009

*   Corrected math and dash handling of dates
*   Styling of uppercase words now plays nicely with soft-hyphens

## 1.7 - July 29, 2009

*   Reformatted language files for increased stability and to bypass a false positive from Avira's free antivirus software

## 1.6 - July 28, 2009

*   Efficiency Optimizations ( approximately 25% speed increase ). Thanks Jenny!

## 1.5 - July 27, 2009

*   Added the ability to exclude hyphenation of capitalized (title case) words to help protect proper nouns
*   Added Hungarian hyphenation patterns

## 1.4 - July 23, 2009

*   Fixed an instance where pre-hyphenated words were hyphenated again

## 1.3 - July 23, 2009

*   Removed two uses of create_function() for improved performance
*   Corrected many uninitialized variables
*   Corrected two variables that were called out of scope

## 1.2 - July 23, 2009

*   moved the processing of widow handling after hyphenation so that max-pull would not be compared to the length of the adjacent word, but rather the length of the adjacent word segment (i.e. that after a soft hyphen)

## 1.1 - July 22, 2009

*   By default, when class phpTypography is constructed, set_defaults is called.  However, if you are going to manually set all settings, you can now bypass the set_defaults call for slightly improved performance.  Just call `$typo ## new phpTypography(FALSE)`.
*   Decoded special HTML characters (for feeds only) to avoid invalid character injection (according to XML's specs)

## 1.0.3 - July 17, 2009

*   Reverted use of the hyphen character to the basic minus-hyphen in words like "mother-in-law" because of poor support in IE6

## 1.0.2 - July 16, 2009

*   Fixed smart math handling so it can be turned off.
*   Corrected smart math handling to not convert slashes in URLs to division signs

## 1.0.1 - July 15, 2009

*   Corrected label in admin interface that indicated pretty fractions were part of basic math handling.

## 1.0 - July 15, 2009

*   Added test to phpTypography methods `process()` and `process_feed()` to skip processing if `$isTitle` parameter is `TRUE` and `h1` or `h2` is an excluded HTML tag

## 1.0 beta 9 - July 14, 2009

*   Added catch-all quote handling, now any quotes that escape previous filters will be assumed to be closing quotes

## 1.0 beta 8 - July 13, 2009

*   Changed thin space injection behavior so that for text such as "...often-always?-judging...", the second dash will be wrapped in thin spaces
*   Corrected error where fractions were not being styled because of a zero-space insertion with the wrap hard hyphens functionality
*   Added default class to exclude: `noTypo`

## 1.0 beta 7 - July 10, 2009

*   Added "/" as a valid word character so we could capture "this/that" as a word for processing (similar to "mother-in-law")
*   Corrected error where characters from the Latin 1 Supplement Block were not recognized as word characters
*   Corrected smart quote handling for strings of numbers
*   Added smart guillemet conversion: `&lt;&lt;` and `&gt;&gt;` to `&laquo;` and `&raquo;`
*   Added smart Single Low 9 Quote conversion as part of smart quotes: comma followed by non-space becomes Single Low 9 Quote
*   Added Single Low 9 Quote, Double Low 9 Quote and &raquo; to style_initial_character functionality
*   Added a new phpTypography method smart_math that assigns proper characters to minus, multiplication and division characters
*   Depreciated the phpTypography method smart_multiplication in favor of smart_math
*   Cleaned up some smart quote functionality
*   Added ability to wrap after "/" if set_wrap_hard_hyphen is TRUE (like "this/that")

## 1.0 beta 6 - July 9, 2009

*   Critical bug fix:  RSS feeds were being disabled by previous versions.  This has been corrected.

## 1.0 beta 5 - July 8, 2009

*   Corrected error where requiring  Em/En dash thin spacing "word-" would become "word &ndash;" instead of "word&ndash;"

## 1.0 beta 4 - July 7, 2009

*   Added default encoding value to smart_quote handling to avoid PHP warning messages

## 1.0 beta 3 - July 6, 2009

*   Corrected curling quotes at the end of block level elements

## 1.0 beta 2 - July 6, 2009

*   Corrected multibyte character conflict in smart-quote handling that caused infrequent dropping of text
*   Thin space injection included for en-dashes

## 1.0 beta 1 - July 3, 2009

*   Initial release
