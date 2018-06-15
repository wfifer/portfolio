<template>
	<div id="app" :class="appClass">
		<router-view/>
		<resize-observer @notify="resize"/>
	</div>
</template>

<script>
import { mapActions, mapState } from 'vuex';

export default {
	name: 'app',
	mounted () {

	},
	methods: {
		...mapActions([
			'resize'
		])
	},
	computed: {
		appClass () {
			return (!!window.chrome && !!window.chrome.webstore) ? 'animate-mask' : 'no-animate-mask';
		},
		...mapState({
			viewport: state => state.app.window
		})
	}
};
</script>

<style>
	#app {
		position: relative;
	}
</style>