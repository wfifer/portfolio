<template>
	<div class="category-thumbnails">
		<transition name="t-thumbnails">
			<div class="thumbnails-view" v-if="currentCategory">
				<div style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px">
					<img v-for="project in projects" :src="project.thumbnail.url" :key="`thumbnail-${ project.id }`" :alt="project.title" />
				</div>

				<div class="thumbnails-inner">
					<div class="thumbnail-scroll">
						<ul class="thumbnail-list list">
							<li v-for="(project, index) in projects" class="thumbnail" v-if="isActive(project) && index !== 0" :key="`thumbnail-${ project.id }`">
								<a class="thumbnail-inner" :href="project.website" target="_blank" :title="`View ${ project.title } website`">
									<div class="thumbnail-image">
										<img :src="project.thumbnail.url" :alt="project.title" />
									</div>

									<div class="thumbnail-content">
										<span class="text">{{ project.title }}</span>
									</div>
								</a>
							</li>
						</ul>
					</div>

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