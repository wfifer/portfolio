'use strict';

import 'es6-promise/auto';
import Vue from 'vue';
import store from '@/store';
import VueTouch from 'vue-touch';
import VueWait from 'vue-wait';
import VueSelect from 'vue-select';
import 'vue-select/dist/vue-select.css';
import { library } from '@fortawesome/fontawesome-svg-core';
import {
    faFingerprint,
    faEnvelope,
    faList,
    faArrowLeft,
    faArrowRight,
    faTimes
} from '@fortawesome/pro-solid-svg-icons';
import {
    faLaptopCode,
    faLightbulbOn,
    faCrop,
    faPencilAlt,
    faVectorSquare,
    faExternalLink,
    faTaco,
    faUserCircle,
    faArrowCircleUp,
    faEye,
    faBorderAll,
    faStreetView,
    faChevronDown,
    faPaintBrush,
    faHandsHelping,
    faBrowser,
    faBuilding,
    faPanFood,
    faMobileScreenButton
} from '@fortawesome/pro-regular-svg-icons';
import { faBehance, faLinkedinIn } from '@fortawesome/free-brands-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import App from './App';

Vue.use(VueTouch);
Vue.use(VueWait);

library.add(
    faExternalLink,
    faLaptopCode,
    faLightbulbOn,
    faTaco,
    faVectorSquare,
    faFingerprint,
    faPencilAlt,
    faCrop,
    faBehance,
    faLinkedinIn,
    faEnvelope,
    faList,
    faUserCircle,
    faArrowLeft,
    faArrowRight,
    faTimes,
    faBorderAll,
    faEye,
    faArrowCircleUp,
    faStreetView,
    faChevronDown,
    faPaintBrush,
    faHandsHelping,
    faBrowser,
    faBuilding,
    faPanFood,
    faMobileScreenButton
);

Vue.component('font-awesome-icon', FontAwesomeIcon);
Vue.component('v-select', VueSelect);

// Vue.config.productionTip = false;

new Vue({
    el: '#app',
    store,
    wait: new VueWait({
        useVuex: true
    }),
    template: '<App/>',
    components: { App }
});
