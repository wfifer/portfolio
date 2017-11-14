/* 
 *	_home.js
 */

project.home = (function () {
	'use strict';

	var template = twig({
	    id: "home",
	    href: "assets/templates/pages/home.twig"
	});

	var loadPage = function () {
		var html = twig({ref: 'home'}).render();

		$('#page').html(html);
	};

	var init = function () {
		
	};

	return {
		init: init,
		loadPage: loadPage
	};

}());