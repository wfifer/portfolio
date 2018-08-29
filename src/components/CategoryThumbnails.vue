<template>
	<div class="category-thumbnails">
		<transition name="t-thumbnails">
			<div class="thumbnails-view" v-if="currentCategory">
				<div class="thumbnails-inner">
					<ul class="thumbnail-list list">
						<li v-for="project in projects" class="thumbnail" v-if="isActive(project)" :key="`thumbnail-${ project.id }`">
							<div class="thumbnail-inner">
								<div class="thumbnail-image">
									<img :src="project.thumbnail.url" :alt="project.title" />
								</div>

								<div class="thumbnail-content">
									{{ project.title }}
								</div>
							</div>
						</li>
					</ul>

					<button @click="clearCategory" type="button" class="btn btn-exit" aria-label="Exit category thumbnail view"></button>
				</div>
			</div>
		</transition>
	</div>
</template>

<script>
import { mapState, mapActions } from 'vuex';

export default {
	name: 'CategoryThumbnails',
	computed: {
		...mapState({
			currentCategory: state => state.projects.currentCategory,
			projects: state => state.projects.projects
		})
	},
	methods: {
		isActive (project) {
			let categories = project.categories.map((category) => category.slug);

			return categories.indexOf(this.currentCategory) >= 0;
		},
		...mapActions([
			'clearCategory'
		])
	}
};
</script>

<style src="@/styles/components/category-thumbnails.scss" lang="scss" scoped></style>