/* 
 *	_modal.js
 */

const modal = (function () {
	'use strict';

	let $body = $('body'),
		$tabs, $noTabs, 
		tabIndex = [],
		$lastFocus;

	const openModal = function ($btn) {
		$lastFocus = $('*:focus');

		$('.js-modal').not('[data-modal=\'' + $btn.attr('data-modal') + '\']').removeClass('-active');

		let $modal = $('.js-modal').filter('[data-modal=\'' + $btn.attr('data-modal') + '\']').eq(0);

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

	const closeModal = function ($modal) {
		$modal = $modal || $('.js-modal');

		$modal.removeClass('-active');
		$body.removeClass('-modal');
		$lastFocus.focus();

		$noTabs.each(function (i) {
			if (tabIndex[i]) {
				$(this).attr('tabindex', tabIndex[i]);
			}
			else {
				$(this).removeAttr('tabindex');
			}
		});
		tabIndex = [];
	};

	const init = function () {
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

}());