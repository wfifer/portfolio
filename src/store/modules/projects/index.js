'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	active: null,
	last: null,
	selected: null,
	direction: 0,
	byId: {},
	all: [],
	featuredIds: [],
	currentCategory: null,
	fetched: []
};

const mutations = {
	[type.NAVIGATE_PROJECTS] (state, action) {
		state.last = state.active;
		const all = state.all.slice();
		if (action.direction < 0) all.reverse();
		const index = all.findIndex(p => p.entryId === state.last);
		const next = all.slice(index + 1)
			.find(p => p.featured);
		state.active = next ? next.entryId : action.direction === 1 ? state.featuredIds[0] : state.featuredIds[state.featuredIds.length - 1];
		state.direction = action.direction;
	},
	[type.GO_TO_PROJECT] (state, action) {
		state.last = state.active;
		state.active = action.entryId;
	},
	[type.ENTER_PROJECT] (state, action) {
		state.selected = action.entryId;
	},
	[type.EXIT_PROJECT] (state, action) {
		state.selected = null;
	},
	[type.ADD_PROJECT] (state, action) {
		const project = { ...state.byId[action.entryId], ...action.response };

		state.byId = { ...state.byId, [action.entryId]: project };

		const index = state.all.findIndex(project => project.entryId === action.entryId);
		state.all = [...state.all.slice(0, index), project, ...state.all.slice(index + 1)];

		const fetched = [ ...state.fetched, action.entryId ];

		state.fetched = fetched;
	},
	[type.GET_PROJECTS] (state, action) {
		const projects = action.response.data.map((project) => {
			return {
				...project,
				client: {},
				intro: '',
				pageContent: []
			};
		});
		const byId = projects.reduce((acc, project) => ({ ...acc, [project.entryId]: project }), {});

		state.byId = byId;
		state.all = projects;

		state.featuredIds = projects
			.filter(project => project.featured)
			.map(project => project.entryId);
		state.active = state.featuredIds[0];
	},
	[type.GET_CATEGORIES] (state, action) {
		const all = {
			title: 'All',
			slug: 'all',
			id: 99999,
			fontIcon: 'border-all',
			fontIconStyle: 'far'
		};

		state.categories = [ all, ...action.response.data ];
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
