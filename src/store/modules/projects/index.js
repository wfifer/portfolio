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
	currentCategory: null,
	fetched: []
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
	[type.ADD_PROJECT] (state, action) {
		let project = { ...state.projects[action.index], ...action.response.data };

		state.projects = [ ...state.projects.slice(0, action.index), project, ...state.projects.slice(action.index + 1, state.projects.length) ];

		let fetched = [ ...state.fetched, action.entryId ];

		state.fetched = fetched;
	},
	[type.GET_PROJECTS] (state, action) {
		let projects = action.response.data.data.map((project) => {
			return {
				...project,
				client: {},
				intro: '',
				pageContent: []
			};
		});

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
