'use strict';

import * as type from './types';

const actions = {
	resize ({ commit }) {
		commit(type.RESIZE);
	}
};

export default actions;
