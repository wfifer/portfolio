'use strict';

import * as type from './types';
import axios from 'axios';

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

		axios.get(`http://api.portfolio.local/project/${ entryId }.json`)
			.then(response => {
				console.log(response);

				commit(type.SHOW_PROJECT, {
					response
				});
			}
		);
	},
	getProjects ({ commit }) {
		axios.get('http://api.portfolio.local/projects.json')
			.then(response => {
				commit(type.GET_PROJECTS, {
					response
				});
			}
		);
	},
	updateProjectMouse ({ commit }, mouse) {
		commit(type.UPDATE_PROJECT_MOUSE, {
			mouse
		});
	}
};

export default actions;
