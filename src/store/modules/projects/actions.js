'use strict';

import * as type from './types';
import axios from 'axios';
import helpers from '@/store/helpers';

const actions = {
	navigateProjects ({ commit }, direction) {
		commit(type.NAVIGATE_PROJECTS, {
			direction
		});
	},
	goToProject ({ commit }, index) {
		commit(type.GO_TO_PROJECT, {
			index
		});
	},
	enterProject ({ commit }, { index, entryId, delay }) {
		delay = delay || 0;

		window.setTimeout(() => {
			commit(type.ENTER_PROJECT, {
				index
			});
		}, delay);

		axios.get(helpers.getApiUrl(`project/${ entryId }.json`))
			.then(response => {
				console.log(response);

				commit(type.SHOW_PROJECT, {
					response
				});
			}
		);
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
