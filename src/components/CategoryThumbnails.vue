<template>
	<div class="category-thumbnails">
		<transition name="t-thumbnails">
			<div class="thumbnails-view" v-if="currentCategory">
				<div style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px">
					<img v-for="project in projects" :src="project.thumbnail.url" :key="`thumbnail-${ project.entryId }`" :alt="project.title" />
				</div>

				<div class="thumbnails-inner">
					<div class="thumbnail-scroll">
						<transition-group name="t-thumbnail-item" class="thumbnail-list list" tag="ul">
							<li v-for="(project, index) in projects" class="thumbnail" v-if="isActive(project) && index !== 0" :key="`thumbnail-${ project.id }`">
								<a class="thumbnail-inner" :href="project.website" target="_blank" :title="`View ${ project.title } website`" :style="`background: ${ getThumbnailBackground(project) }`">
									<div class="thumbnail-image" :style="`background: linear-gradient(${ getGradient(project) })`">
										<img :src="project.thumbnail.url" :alt="project.title" />
									</div>

									<div class="thumbnail-content">
										<span class="text">{{ project.title }}</span>
									</div>
								</a>
							</li>
						</transition-group>
					</div>

					<!-- tools -->

					<h2 class="category-heading">
						<span class="label">Projects in:</span>
						<span class="title">{{ currentCategory.title }}</span>
					</h2>

					<button @click="clearCategory" type="button" class="btn btn-exit" aria-label="Exit category thumbnail view"></button>

					<CategoryButtons :categories="categories" class="category-nav icon-list icon-list-categories" />
				</div>
			</div>
		</transition>
	</div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import CategoryButtons from '@/components/CategoryButtons';

export default {
	name: 'CategoryThumbnails',
	components: {
		CategoryButtons
	},
	computed: {
		...mapState({
			currentCategory: state => state.projects.currentCategory,
			projects: state => state.projects.projects,
			categories: state => state.projects.categories
		})
	},
	methods: {
		isActive (project) {
			let categories = project.categories.map((category) => category.id);

			return categories.indexOf(this.currentCategory.id) >= 0;
		},
		getGradient (project) {
			// let angle = project.heroBackground.angle;
			let angle = '37deg';
			let stops = project.heroBackground.stops.slice(0, 2);

			let gradient = angle && angle.length
				? angle
				: 'to right';

			stops.forEach((stop, i) => {
				gradient += `, ${ stop.color } ${ 20 + i * 60 }%`;
			});

			return gradient;
		},
		getThumbnailBackground (project) {
			let color = parseInt(project.heroBackground.stops[0].color.replace('#', ''), 16);

			let r = color >> 16 & 255;
			let g = color >> 8 & 255;
			let b = color & 255;

			return `rgba(${ [r, g, b].join(',') }, 0.9 )`;
		},
		...mapActions([
			'clearCategory'
		])
	}
};
</script>

<style src="../styles/components/icon-list.scss" lang="scss"></style>
<style src="@/styles/components/category-thumbnails.scss" lang="scss" scoped></style>