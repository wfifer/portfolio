'use strict';

import Vue from 'vue';
import router from './router';
import store from './store/index';
import { sync } from 'vuex-router-sync';
import VueResize from 'vue-resize';
import App from './App';
import 'babel-polyfill';

Vue.use(VueResize);

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