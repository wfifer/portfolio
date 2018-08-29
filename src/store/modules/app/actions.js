'use strict';

import * as type from './types';

const actions = {
	resize ({ commit }) {
		commit(type.RESIZE);
	},
	keyupHandler ({ commit }, event) {
		commit(type.KEYUP, { event });
	},
	clickHandler ({ commit }, event) {
		commit(type.CLICK, { event });
	},
	touchHandler ({ commit }, event) {
		commit(type.TOUCH, { event });
	}
};

export default actions;
