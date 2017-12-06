'use strict';

import * as type from './types';
import actions from './actions';

const state = {
	class: [],
	window: {
		width: window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
		height: window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
	}
};

const mutations = {
	[type.RESIZE] (state) {
		state.window = {
			width: window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,
			height: window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
		};
	}
};

export default {
	state,
	mutations,
	actions
};
