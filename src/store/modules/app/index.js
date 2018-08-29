'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	class: [],
	window: {
		width: window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
		height: window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
	},
	userInteraction: 'tab'
};

const mutations = {
	[type.RESIZE] (state) {
		state.window = {
			width: window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
			height: window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
		};
	},
	[type.KEYUP] (state, action) {
		if (action.event.which === 9) {
			state.userInteraction = 'tab';
		}
	},
	[type.CLICK] (state, action) {
		state.userInteraction = state.userInteraction === 'touch'
			? 'touch'
			: 'click';
	},
	[type.TOUCH] (state, action) {
		state.userInteraction = 'touch';
	}
};

export default {
	state,
	mutations,
	actions
};
