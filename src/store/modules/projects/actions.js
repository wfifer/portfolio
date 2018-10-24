'use strict';

import * as type from './types';
import axios from 'axios';
import helpers from '@/store/helpers';

const actions = {
	navigateProjects ({ commit, state, dispatch }, direction) {
		commit(type.NAVIGATE_PROJECTS, {
			direction
		});

		if (state.selected >= 0) {
			dispatch('enterProject', { index: state.active, entryId: state.projects[state.active].entryId });
		}
	},
	goToProject ({ commit, state, dispatch }, index) {
		commit(type.GO_TO_PROJECT, {
			index
		});

		if (state.selected >= 0) {
			dispatch('enterProject', { index: state.active, entryId: state.projects[state.active].entryId });
		}
	},
	enterProject ({ commit, dispatch, state }, { index, entryId, delay = 0 }) {
		window.setTimeout(() => {
			commit(type.ENTER_PROJECT, {
				index
			});
		}, delay);

		if (state.fetched.indexOf(entryId) < 0) {
			dispatch('wait/start', type.ADD_PROJECT, { root: true });

			axios.get(helpers.getApiUrl(`project/${ entryId }.json`))
				.then(response => {
					commit(type.ADD_PROJECT, {
						response,
						index,
						entryId
					});
				})
				.finally(() => {
					dispatch('wait/end', type.ADD_PROJECT, { root: true });
				});
		}
	},
	exitProject ({ commit }) {
		commit(type.EXIT_PROJECT);
	},
	getProjects ({ commit }) {
		axios.get(helpers.getApiUrl('projects.json'))
			.then(response => {
				commit(type.GET_PROJECTS, {
					response
				});
			}
		);
	},
	getCategories ({ commit }) {
		axios.get(helpers.getApiUrl('categories.json'))
			.then(response => {
				commit(type.GET_CATEGORIES, {
					response
				});
			}
		);
	},
	showCategory ({ commit }, category) {
		commit(type.SHOW_CATEGORY, {
			category
		});
	},
	clearCategory ({ commit }) {
		commit(type.CLEAR_CATEGORY);
	}
};

export default actions;
