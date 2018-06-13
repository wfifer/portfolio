<template>
	<div id="app" :class="appClass">
		<router-view/>
		<resize-observer @notify="resize"/>
	</div>
</template>

<script>
import { mapActions } from 'vuex';

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
			return !!window.chrome && !!window.chrome.webstore ? 'browser-chrome' : 'browser-other';
		}
	}
};
</script>

<style>
	#app {
		position: relative;
	}
</style>