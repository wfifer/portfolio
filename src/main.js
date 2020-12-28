'use strict';

import 'es6-promise/auto';
import Vue from 'vue';
import router from './router';
import store from './store/index';
import { sync } from 'vuex-router-sync';
import VueResize from 'vue-resize';
import VueTouch from 'vue-touch';
import VueWait from 'vue-wait';
import { library } from '@fortawesome/fontawesome-svg-core';
import {
	faFingerprint,
	faEnvelope,
	faList,
	faArrowLeft,
	faArrowRight,
	faTimes
} from '@fortawesome/pro-solid-svg-icons';
import { 
	faLaptopCode,
	faLightbulbOn,
	faCrop,
	faPencilAlt,
	faVectorSquare,
	faExternalLink,
	faTaco,
	faUserCircle,
	faArrowCircleUp,
	faEye,
	faBorderAll,
	faStreetView,
	faChevronDown,
	faPaintBrush
} from '@fortawesome/pro-regular-svg-icons';
import { 
	faBehance,
	faLinkedinIn 
} from '@fortawesome/free-brands-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import App from './App';
import 'babel-polyfill';

Vue.use(VueResize);
Vue.use(VueTouch);
Vue.use(VueWait);


library.add(
	faExternalLink,
	faLaptopCode,
	faLightbulbOn,
	faTaco,
	faVectorSquare,
	faFingerprint,
	faPencilAlt,
	faCrop,
	faBehance,
	faLinkedinIn,
	faEnvelope,
	faList,
	faUserCircle,
	faArrowLeft,
	faArrowRight,
	faTimes,
	faBorderAll,
	faEye,
	faArrowCircleUp,
	faStreetView,
	faChevronDown,
	faPaintBrush
);

Vue.component('font-awesome-icon', FontAwesomeIcon);

// Vue.config.productionTip = false;

sync(store, router);

new Vue({
	el: '#app',
	store,
	wait: new VueWait({
		useVuex: true
	}),
	router,
	template: '<App/>',
	components: { App }
});