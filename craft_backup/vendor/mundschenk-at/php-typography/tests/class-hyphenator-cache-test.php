<?php
/**
 *  This file is part of PHP-Typography.
 *
 *  Copyright 2016-2017 Peter Putzer.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  of the License, or ( at your option ) any later version.
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
 *  @package mundschenk-at/php-typography/tests
 *  @license http://www.gnu.org/licenses/gpl-2.0.html
 */

namespace PHP_Typography\Tests;

/**
 * Test Hyphenator_Cache class.
 *
 * @coversDefaultClass \PHP_Typography\Hyphenator_Cache
 * @usesDefaultClass \PHP_Typography\Hyphenator_Cache
 *
 * @uses PHP_Typography\Hyphenator
 */
class Hyphenator_Cache_Test extends PHP_Typography_Testcase {
	/**
	 * Hyphenator_Cache fixture.
	 *
	 * @var \PHP_Typography\Hyphenator_Cache|null
	 */
	protected $c;

	/**
	 * Sets up the fixture, for example, opens a network connection.
	 * This method is called before a test is executed.
	 */
	protected function setUp() {
		$this->c = new \PHP_Typography\Hyphenator_Cache();
	}

	/**
	 * Tears down the fixture, for example, closes a network connection.
	 * This method is called after a test is executed.
	 */
	protected function tearDown() {
		$this->c = null;
	}

	/**
	 * Tests set_hyphenator.
	 *
	 * @covers ::set_hyphenator
	 * @covers ::get_hyphenator
	 */
	public function test_hyphenator_cache() {
		$hyphenator = new \PHP_Typography\Hyphenator();

		$this->assertSame( null, $this->c->get_hyphenator( 'de' ) );
		$this->c->set_hyphenator( 'de', $hyphenator );
		$this->assertSame( $hyphenator, $this->c->get_hyphenator( 'de' ) );
		$this->assertSame( null, $this->c->get_hyphenator( 'foobar' ) );
	}
}
