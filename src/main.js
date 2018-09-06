'use strict';

import Vue from 'vue';
import router from './router';
import store from './store/index';
import { sync } from 'vuex-router-sync';
import VueResize from 'vue-resize';
import VueTouch from 'vue-touch';
import App from './App';
import 'babel-polyfill';

Vue.use(VueResize);
Vue.use(VueTouch);

// Vue.config.productionTip = false;

sync(store, router);

new Vue({
	el: '#app',
	store,
	router,
	template: '<App/>',
	components: { App },
	resolve: {
		alias: {
			styles: require('./styles/global.scss')
		}
	}
});