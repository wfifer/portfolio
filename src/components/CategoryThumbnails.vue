<template>
	<div class="category-thumbnails">

	</div>
</template>

<script>
import { mapState } from 'vuex';
import filter from 'lodash/filter';

export default {
	name: 'CategoryThumbnails',
	computed: {
		categoryProjects () {
			return filter(this.projects, function (project, i) {
				return project.slug === this.currentCategory;
			});
		},
		...mapState({
			currentCategory: state => state.projects.currentCategory,
			projects: state => state.projects.projects
		})
	}
};
</script>

<style src="@/styles/components/category-thumbnails.scss" lang="scss" scoped></style>