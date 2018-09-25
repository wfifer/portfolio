'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	active: 0,
	last: 0,
	selected: -1,
	direction: 0,
	projects: [],
	featuredProjects: [],
	currentProject: {},
	currentCategory: null
};

const mutations = {
	[type.NAVIGATE_PROJECTS] (state, action) {
		state.last = state.active;
		state.active = (state.active + action.direction + state.featuredProjects.length) % state.featuredProjects.length;
		state.direction = action.direction;
	},
	[type.GO_TO_PROJECT] (state, action) {
		state.last = state.active;
		state.active = action.index;
	},
	[type.ENTER_PROJECT] (state, action) {
		state.selected = action.index;
	},
	[type.EXIT_PROJECT] (state, action) {
		state.selected = -1;
	},
	[type.SHOW_PROJECT] (state, action) {
		state.currentProject = action.response.data;
	},
	[type.GET_PROJECTS] (state, action) {
		let projects = action.response.data.data;

		state.projects = projects;

		state.featuredProjects = projects.filter((project) => {
			return project.featured;
		});
	},
	[type.GET_CATEGORIES] (state, action) {
		let all = {
			title: 'All projects',
			slug: 'all',
			id: '99999',
			icon: null,
			fontIcon: 'grid'
		};

		state.categories = [ all, ...action.response.data.data ];
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
