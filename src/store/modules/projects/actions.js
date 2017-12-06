'use strict';

import * as type from './types';
import axios from 'axios';

const actions = {
	navigateProjects ({ commit }, direction) {
		commit(type.NAVIGATE_PROJECTS, {
			direction
		});
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
