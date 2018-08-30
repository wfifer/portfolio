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
	enterProject ({ commit }, { index, entryId }) {
		commit(type.ENTER_PROJECT, {
			index
		});

		axios.get(helpers.getApiUrl(`project/${ entryId }.json`))
			.then(response => {
				console.log(response);

				commit(type.SHOW_PROJECT, {
					response
				});
			}
		);
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
