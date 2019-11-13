<template>
	<div id="app" class="portfolio" :class="appClass" @mousedown="clickHandler" @keyup="keyupHandler">
		<router-view/>

		<div style="position: relative">
			<resize-observer @notify="resize" />
		</div>
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

		this.getCategories();
	},
	methods: {
		...mapActions([
			'clickHandler',
			'touchHandler',
			'keyupHandler',
			'resize',
			'getCategories'
		])
	},
	computed: {
		appClass () {
			let appClass = window.chrome ? 'animate-mask' : 'no-animate-mask';

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

<style src="@/styles/global.scss" lang="scss"></style>
<style src="@/styles/components/portfolio.scss" lang="scss"></style>