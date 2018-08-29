'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	active: 0,
	last: 0,
	selected: -1,
	direction: 0,
	projects: [],
	currentProject: {},
	currentCategory: null
};

const mutations = {
	[type.NAVIGATE_PROJECTS] (state, action) {
		state.last = state.active;
		state.active = (state.active + action.direction + state.projects.length) % state.projects.length;
		state.direction = action.direction;
	},
	[type.ENTER_PROJECT] (state, action) {
		state.selected = action.index;
	},
	[type.SHOW_PROJECT] (state, action) {
		state.currentProject = action.response.data;
	},
	[type.GET_PROJECTS] (state, action) {
		state.projects = action.response.data.data;
	},
	[type.SHOW_CATEGORY] (state, action) {
		state.currentCategory = action.category;
	},
	[type.CLEAR_CATEGORY] (state, action) {
		state.currentCategory = null;
	}
};

export default {
	state,
	mutations,
	actions
};
