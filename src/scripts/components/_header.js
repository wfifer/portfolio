/* 
 *	_header.js
 */

const header = (function () {
	'use strict';

	let $active = $('.site-header .project-mask.-active'),
		$projects = $('.project-mask'),
		mouse = {},
		ready = true;

	const parallax = function () {
		requestAnimationFrame(parallax);

		let x = (project.doc.width / 2 - mouse.x) / project.doc.width * 50,
			y = (project.doc.width / 2 - mouse.y) / project.doc.width * 50;

		$active.find('.project-hero').css({
			transform: 'translate3d(' + x + 'px, ' + y + 'px, 0)'
		});

		x *= 0.5;
		y *= 0.5;

		// $active.find('svg').css({
		// 	transform: 'translate3d(' + x + 'px, ' + y + 'px, 0)'
		// });
	};

	const changeSlide = function (current, direction = 1) {
		if (ready) {
			ready = false;

			$projects.find('.mask-inner').off('transitionend');

			var $current = $projects.eq(current),
				directionClass = direction == 1 ? 'left' : 'right';
				
			// var	DOMURL = window.URL || window.webkitURL || window,
			// 	canvasEl = $current.find('.mask-canvas').get(0),
			// 	ctx = canvasEl.getContext('2d'),
			// 	svgData = $current.find('.mask-svg').html(),
			// 	img = new Image(),
			// 	svg = new Blob([svgData], {type: 'image/svg+xml'}),
			// 	url = DOMURL.createObjectURL(svg);

			// console.log(url);

			// img.onload = function () {
			// 	ctx.drawImage(img, 0, 0);
			// 	DOMURL.revokeObjectURL(url);
			// };

			// img.src = url;
			
			$active = $projects.eq((current + direction) % $projects.length);

			$active.addClass('-animate-in');

			$current.addClass('-animate-out -' + directionClass)
				.find('.mask-inner').on('transitionend', function () {
				$(this).off('transitionend');

				setTimeout(function () {
					ready = true;

					$current.removeClass('-animate-out -left -right -active');

					$active.removeClass('-animate-in').addClass('-active');
				}, 1000);
			});
		}
	};

	const init = function () {
		console.log('header.init');

		Gator(document).on('mousemove', '.site-header', function (e) {
			mouse = {
				x: e.pageX,
				y: e.pageY
			};

		}).on('click', '.project-mask .project-nav .nav-item', function () {
			changeSlide($(this).closest('.project-mask').index(), $(this).index() * 2 - 1);

		}).on('click', '.js-enter-project', function () {
			$('html').addClass('-project');

		}).on('click', '.js-about', function () {
			$('html').addClass('-about');
		});

		requestAnimationFrame(parallax);
	};

	return {
		init: init
	};

}());