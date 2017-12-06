<template>
	<div id="app">
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
	}
};
</script>

<style>
	#app {
		position: relative;
	}
</style>