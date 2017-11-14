'use strict';

var _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

// Globals
var project = project || {
	doc: {
		width: 0,
		height: 800
	},
	desktop: true,
	isTouch: false,
	viewChange: true
},
    breakpoint = {
	tablet: 1000,
	portrait: 4 / 5,
	landscape: 5 / 4
},
    storage = Storages.localStorage;

var twig = Twig.twig;

// Components
(function ($) {

	project.isTouch = 'ontouchstart' in window || navigator.msMaxTouchPoints;

	if (project.isTouch) {
		$('html').removeClass('no-touch').addClass('touch');
	}

	/* 
 *	_modal.js
 */

	var modal = function () {
		'use strict';

		var $body = $('body'),
		    $tabs = void 0,
		    $noTabs = void 0,
		    tabIndex = [],
		    $lastFocus = void 0;

		var openModal = function openModal($btn) {
			$lastFocus = $('*:focus');

			$('.js-modal').not('[data-modal=\'' + $btn.attr('data-modal') + '\']').removeClass('-active');

			var $modal = $('.js-modal').filter('[data-modal=\'' + $btn.attr('data-modal') + '\']').eq(0);

			$modal.toggleClass('-active');

			setTimeout(function () {
				$modal.find('.modal-header').eq(0).focus();
				$modal.find('input').eq(0).focus();
			}, 100);

			$body.toggleClass('-modal');

			$tabs = $modal.add('.site-header, .primary-nav').find('input, .btn, [role=\'button\'], a');
			$noTabs = $('input, .btn, [role=\'button\'], a').not($tabs);

			$noTabs.each(function (i) {
				tabIndex[i] = $(this).attr('tabindex');
			}).attr('tabindex', '-1');
		};

		var closeModal = function closeModal($modal) {
			$modal = $modal || $('.js-modal');

			$modal.removeClass('-active');
			$body.removeClass('-modal');
			$lastFocus.focus();

			$noTabs.each(function (i) {
				if (tabIndex[i]) {
					$(this).attr('tabindex', tabIndex[i]);
				} else {
					$(this).removeAttr('tabindex');
				}
			});
			tabIndex = [];
		};

		var init = function init() {
			console.log('modal.init');

			$(document).on('click', '.js-btn-modal', function (e) {
				e.stopPropagation();

				openModal($(this));
			}).on('click', '.js-modal', function (e) {
				e.stopPropagation();
			}).on('keypress', '.js-keypress-modal', function (e) {
				if (e.which == 13) {
					e.stopPropagation();

					openModal($(this));
				}
			}).on('keyup', function (e) {
				if (e.which == 27 && $('.js-modal.-active').length > 0 && $('.js-tooltip').length === 0) {
					closeModal();
				}
			}).on('click', function () {
				if (!($(this).is('.js-no-modal') || $(this).closest('.js-no-modal').length > 0) && $('.js-modal.-active').length > 0) {
					closeModal();
				}
			}).on('click', '.js-modal-exit', function () {
				closeModal($(this).closest('.modal'));
			}).on('click', '.modal-panel', function (event) {
				event.stopPropagation();
			});
		};

		return {
			init: init,
			closeModal: closeModal,
			openModal: openModal
		};
	}();
	/* 
 *	_dropdown.js
 */

	var dropdown = function () {
		'use strict';

		var toggleDropdown = function toggleDropdown($dropdown, close) {
			if ($dropdown.data().open || close) {
				$dropdown.data('open', false);

				$dropdown.removeClass('-active').find('.dropdown-options').attr('aria-hidden', true);

				$dropdown.find('.dropdown-item').removeClass('-selected');

				$dropdown.blur();
			} else if (!$(this).is('.-active')) {
				$('.js-dropdown').not($dropdown).removeClass('-active').find('.dropdown-options').attr('aria-hidden', true);

				$dropdown.addClass('-active').find('.dropdown-options').attr('aria-hidden', false);

				setTimeout(function () {
					$dropdown.data('open', true);
				}, 100);
			}
		};

		var navigateDropdown = function navigateDropdown($dropdown, direction) {
			var $selected = $dropdown.find('.-selected').eq(0),
			    index = $dropdown.find('.dropdown-item').index($selected);

			if ($selected && $selected.length > 0) {
				$selected.removeClass('-selected');
				$dropdown.find('.dropdown-item').eq(index + direction).addClass('-selected');
			} else {
				$dropdown.find('.dropdown-item').eq(0).addClass('-selected');
			}
		};

		var init = function init() {
			$(document).on('click', '.js-open-dropdown', function (e) {
				e.stopPropagation();

				toggleDropdown($(this).closest('.dropdown'));
			}).on('click', function () {
				$('.js-dropdown').removeClass('-active').data('open', false).find('.dropdown-options').attr('aria-hidden', true);
			}).on('click', '.dropdown-item', function () {
				var $dropdown = $(this).closest('.js-dropdown'),
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
				$('.js-dropdown:not(.refine-search)').removeClass('-active').data('open', false).find('.dropdown-options').attr('aria-hidden', true);
			}).on('keydown', function (e) {
				var $dropdown = $('.js-dropdown.-active').eq(0);
				var active = $dropdown.length > 0;

				$dropdown = $dropdown.length > 0 ? $dropdown : $('.js-dropdown:focus').eq(0);

				if ($dropdown.length > 0) {
					if (e.which == 38 || e.which == 40) {
						e.preventDefault();

						if (!$dropdown.is('.-active')) {
							toggleDropdown($dropdown);
						}

						var direction = e.which - 39;

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
							} else {
								var $active = $dropdown.find('.dropdown-item.-selected');

								var href = $active.find('a').attr('href');
								if (href && href.length > 0) {
									window.location = href;
								}

								$active.trigger('click');
							}
							toggleDropdown($dropdown, true);
						} else {
							toggleDropdown($dropdown);
						}
					}
				}
			});
		};

		return {
			init: init
		};
	}();
	/* 
 *	_header.js
 */

	var header = function () {
		'use strict';

		var $hero = $('.site-header .project-mask .project-hero'),
		    $title = $('.site-header .project-title'),
		    mouse = {};

		var parallax = function parallax() {
			requestAnimationFrame(parallax);

			var x = (project.doc.width / 2 - mouse.x) / project.doc.width * 50,
			    y = (project.doc.width / 2 - mouse.y) / project.doc.width * 50;

			$hero.css({
				transform: 'translate3d(' + x + 'px, ' + y + 'px, 0)'
			});

			x *= -0.25;
			y *= -0.25;

			// $title.css({
			// 	transform: 'translate3d(' + x + 'px, ' + y + 'px, 0)'
			// });
		};

		var init = function init() {
			console.log('header.init');

			$(document).on('mousemove', '.site-header', function (e) {
				mouse = {
					x: e.pageX,
					y: e.pageY
				};
			});

			requestAnimationFrame(parallax);
		};

		return {
			init: init
		};
	}();

	project = _extends({}, project, {
		modal: modal,
		dropdown: dropdown,
		header: header
	});

	project.doc.width = $(window).width();
	project.doc.height = $(window).height();
	project.heroWidth = $('.project-mask svg').width();

	$(window).resize(function () {
		project.doc.width = $(window).width();
		project.doc.height = $(window).height();
		project.heroWidth = $('.project-mask svg').width();
	});

	$(document).ready(function () {

		project.modal.init();
		project.header.init();
	});
})(jQuery);