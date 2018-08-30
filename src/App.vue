<template>
	<div id="app" :class="appClass" @mousedown="clickHandler" @keyup="keyupHandler">
		<router-view/>
		<resize-observer @notify="resize"/>
	</div>
</template>

<script>
import { mapActions, mapState } from 'vuex';

export default {
	name: 'app',
	mounted () {
		window.addEventListener('touchstart', () => {
			this.touchHandler();
		});
	},
	methods: {
		...mapActions([
			'clickHandler',
			'touchHandler',
			'keyupHandler',
			'resize'
		])
	},
	computed: {
		appClass () {
			let appClass = (!!window.chrome && !!window.chrome.webstore) ? 'animate-mask' : 'no-animate-mask';

			appClass += this.userInteraction === 'click'
				? ' -hide-focus'
				: this.userInteraction === 'touch'
				? ' -hide-focus -hide-hover'
				: ' -show-focus';

			return appClass;
		},
		...mapState({
			viewport: state => state.app.window,
			userInteraction: state => state.app.userInteraction
		})
	}
};
</script>

<style>
	#app {
		position: relative;
	}
</style>