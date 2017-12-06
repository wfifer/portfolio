'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	active: 0,
	projects: [],
	mouse: {}
};

const mutations = {
	[type.NAVIGATE_PROJECTS] (state, action) {
		state.active = (state.active + action.direction + state.projects.length) % state.projects.length;
		console.log(state.projects.length, state.active);
	},
	[type.GET_PROJECTS] (state, action) {
		state.projects = action.response.data.data;
	},
	[type.UPDATE_PROJECT_MOUSE] (state, action) {
		state.mouse = action.mouse;
	}
};

export default {
	state,
	mutations,
	actions
};
