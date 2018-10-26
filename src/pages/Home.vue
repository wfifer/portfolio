<template>
	<v-touch @swipeleft="navActive ? navigate(1) : null" @swiperight="navActive ? navigate(-1) : null" :swipe-options="{ direction: 'horizontal' }">
		<Projects @nav-active="updateNavActive" />

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

export default {
	name: 'Home',
	components: {
		Projects,
		CategoryThumbnails,
		ProjectContent
	},
	data () {
		return {
			navActive: true
		};
	},
	computed: {
		...mapState({
			selected: state => state.projects.selected
		})
	},
	methods: {
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
