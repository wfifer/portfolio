<template>
	<div id="app" class="portfolio" :class="appClass" @mousedown="clickHandler" @keyup="keyupHandler">
		<Home />
	</div>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import Home from '@/pages/Home';

export default {
	name: 'app',
	components: { Home },
	mounted () {
		window.addEventListener('touchstart', () => {
			this.touchHandler();
		});

		this.resize();
		window.addEventListener('resize', () => {
			this.resize();
		});

		this.getCategories();
	},
	methods: {
		...mapActions([
			'clickHandler',
			'touchHandler',
			'keyupHandler',
			'getCategories',
			'resize'
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
			userInteraction: state => state.app.userInteraction,
			viewport: state => state.app.window
		})
	},
	watch: {
		viewport (_, newValue) {
			let vh = newValue.height * 0.01;
			document.documentElement.style.setProperty('--vh', `${ vh }px`);
		}
	}
};
</script>

<style src="@/styles/global.scss" lang="scss"></style>
<style src="@/styles/components/portfolio.scss" lang="scss"></style>