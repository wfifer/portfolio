// Globals
let project = project || {
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

let twig = Twig.twig;

// Components
(function ($) {
	
	project.isTouch = 'ontouchstart' in window || navigator.msMaxTouchPoints;

	if (project.isTouch) {
		$('html').removeClass('no-touch').addClass('touch');
	}
	
	// import('components/_modal.js');
	// import('components/_dropdown.js');
	// import('components/_header.js');

	project = { 
		...project, 
		...{ 
			modal,
			dropdown,
			header
		} 
	};

	
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