'use strict';

import 'es6-promise/auto';
import Vue from 'vue';
import router from './router';
import store from './store/index';
import { sync } from 'vuex-router-sync';
import VueResize from 'vue-resize';
import VueTouch from 'vue-touch';
import VueWait from 'vue-wait';
import App from './App';
import 'babel-polyfill';

Vue.use(VueResize);
Vue.use(VueTouch);
Vue.use(VueWait);

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