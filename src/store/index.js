'use strict';

import Vue from 'vue';
import Vuex from 'vuex';
import app from './modules/app/index';
import projects from './modules/projects/index';

Vue.use(Vuex);

export default new Vuex.Store({
	modules: {
		app,
		projects
	},
	strict: process.env.NODE_ENV !== 'production'
});