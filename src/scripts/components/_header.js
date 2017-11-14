/* 
 *	_header.js
 */

const header = (function () {
	'use strict';

	let $hero = $('.site-header .project-mask .project-hero'),
		$title = $('.site-header .project-title'),
		mouse = {};

	const parallax = function () {
		requestAnimationFrame(parallax);

		let x = (project.doc.width / 2 - mouse.x) / project.doc.width * 50,
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

	const init = function () {
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

}());