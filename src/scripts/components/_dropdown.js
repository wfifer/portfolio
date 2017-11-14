/* 
 *	_dropdown.js
 */

const dropdown = (function () {
	'use strict';

	const toggleDropdown = function ($dropdown, close) {
		if ($dropdown.data().open || close) {
			$dropdown.data('open', false);

			$dropdown.removeClass('-active')
				.find('.dropdown-options').attr('aria-hidden', true);

			$dropdown.find('.dropdown-item').removeClass('-selected');

			$dropdown.blur();
		}
		else if (!$(this).is('.-active')) {
			$('.js-dropdown').not($dropdown).removeClass('-active')
				.find('.dropdown-options').attr('aria-hidden', true);

			$dropdown.addClass('-active')
				.find('.dropdown-options').attr('aria-hidden', false);

			setTimeout(function () {
				$dropdown.data('open', true);
			}, 100);
		}
	};

	const navigateDropdown = function ($dropdown, direction) {
		let $selected = $dropdown.find('.-selected').eq(0),
			index = $dropdown.find('.dropdown-item').index($selected);

		if ($selected && $selected.length > 0) {
			$selected.removeClass('-selected');
			$dropdown.find('.dropdown-item').eq(index + direction).addClass('-selected');
		}
		else {
			$dropdown.find('.dropdown-item').eq(0).addClass('-selected');
		}
	};

	const init = function () {
		$(document).on('click', '.js-open-dropdown', function (e) {
			e.stopPropagation();

			toggleDropdown($(this).closest('.dropdown'));

		}).on('click', function () {
			$('.js-dropdown').removeClass('-active').data('open', false)
				.find('.dropdown-options').attr('aria-hidden', true);
		
		}).on('click', '.dropdown-item', function () {
			let $dropdown = $(this).closest('.js-dropdown'),
				$label = $dropdown.find('.dropdown-label .text'),
				$input = $dropdown.find('.dropdown-label input'),
				value = $(this).data().value,
				text = $(this).data().title;

			$label.text(text);
			$input.val(value);

			toggleDropdown($(this).closest('.dropdown'));

		}).on('focus', '.js-dropdown', function () {
			// toggleDropdown($(this));
		}).on('blur', '.js-dropdown', function () {
			$('.js-dropdown:not(.refine-search)').removeClass('-active').data('open', false)
				.find('.dropdown-options').attr('aria-hidden', true);
		}).on('keydown', function (e) {
			let $dropdown = $('.js-dropdown.-active').eq(0);
			let active = $dropdown.length > 0;

			$dropdown = $dropdown.length > 0 ? $dropdown : $('.js-dropdown:focus').eq(0);

			if ($dropdown.length > 0) {
				if (e.which == 38 || e.which == 40) {
					e.preventDefault();

					if (!$dropdown.is('.-active')) {
						toggleDropdown($dropdown);
					}

					let direction = e.which - 39;

					navigateDropdown($dropdown, direction);
				}

				if (e.which == 27) {
					toggleDropdown($dropdown, true);
				}

				if (e.which == 13 || e.which == 32) {
					e.preventDefault();
					
					if (active) {
						if ($dropdown.data().role == 'filter') {
							window.location = $dropdown.find('.dropdown-item.-selected a').attr('href');
						}
						else {
							let $active = $dropdown.find('.dropdown-item.-selected');

							let href = $active.find('a').attr('href');
							if (href && href.length > 0) {
								window.location = href;
							}

							$active.trigger('click');
						}
						toggleDropdown($dropdown, true);
					}
					else {
						toggleDropdown($dropdown);
					}
				}
			}
		});
	};

	return {
		init: init
	};

}());