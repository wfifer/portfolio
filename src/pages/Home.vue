<template>
	<v-touch @swipeleft="navActive ? navigate(1) : null" @swiperight="navActive ? navigate(-1) : null" :swipe-options="{ direction: 'horizontal' }">
		<Projects @nav-active="updateNavActive" :set-theme="setTheme" :theme="theme" />

		<CategoryThumbnails />

		<ProjectContent />
	</v-touch>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import VueScrollTo from 'vue-scrollto';
import Projects from '@/components/Projects';
import CategoryThumbnails from '@/components/CategoryThumbnails';
import ProjectContent from '@/components/ProjectContent';

const saveTheme = value => {
	switch (value) {
		case 'ACCESSIBLE':
			document.documentElement.classList.add('--accessible');
			document.documentElement.classList.remove('--light');
			break;
		case 'LIGHT':
			document.documentElement.classList.remove('--accessible');
			document.documentElement.classList.add('--light');
			break;
		case 'DEFAULT':
		default:
			document.documentElement.classList.remove('--accessible', '--light');
	}
	window.localStorage.setItem('theme', value);
};

export default {
	name: 'Home',
	components: {
		Projects,
		CategoryThumbnails,
		ProjectContent
	},
	data () {
		return {
			navActive: true,
			theme: 'DEFAULT'
		};
	},
	mounted () {
		const theme = window.localStorage.getItem('theme');
		saveTheme(theme);
		this.theme = theme;
	},
	computed: {
		...mapState({
			selected: state => state.projects.selected
		})
	},
	methods: {
		setTheme (e) {
			saveTheme(e.target.value);
			this.theme = e.target.value;
		},
		keyupHandler (e) {
			if (this.navActive) {
				switch (e.which) {
					case 37:
						this.navigate(-1);
						break;

					case 39:
						this.navigate(1);
						break;

					default:
						break;
				}
			}
		},
		updateNavActive (active) {
			this.navActive = active;
		},
		navigate (direction) {
			if (window.scrollY !== 0) {
				VueScrollTo.scrollTo(document.documentElement, 350, {
					onDone: () => {
						this.navigateProjects(direction);
					},
					onCancel: () => {
						this.navigateProjects(direction);
					},
					easing: 'ease-out'
				});
			} else {
				this.navigateProjects(direction);
			}
		},
		...mapActions([
			'navigateProjects'
		])
	}
};
</script>
