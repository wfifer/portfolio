<template>
	<div class="category-thumbnails" :class="currentCategory ? '-active' : '-inactive'">
		<div class="thumbnails-inner">
			<ul class="thumbnail-list list">
				<li v-for="project in categoryProjects" class="thumbnail">
					<div class="thumbnail-inner">
						<div class="thumbnail-image" :style="`background-image: url(${ project.heroImage.url })`">
						</div>

						<div class="thumbnail-content">
							{{ project.title }}
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
import { mapState } from 'vuex';
import filter from 'lodash/filter';

export default {
	name: 'CategoryThumbnails',
	computed: {
		categoryProjects () {
			return filter(this.projects, (project, i) => {
				let categories = project.categories.map((category) => category.slug);

				return categories.indexOf(this.currentCategory) >= 0;
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