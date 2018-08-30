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
								<a class="thumbnail-inner" :href="project.website" target="_blank" :title="`View ${ project.title } website`" :style="`background: ${ getThumbnailBackground(project) }`">
									<div class="thumbnail-image" :style="`background: linear-gradient(${ getGradient(project) })`">
										<img :src="project.thumbnail.url" :alt="project.title" />
									</div>

									<div class="thumbnail-content">
										<span class="text">{{ project.title }}</span>
										<!-- <span class="text" :style="`text-shadow: 0 0 8px ${ project.heroBackground.stops[0].color };`">{{ project.title }}</span> -->
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
		getGradient (project) {
			// let angle = project.heroBackground.angle;
			let angle = '37deg';
			let stops = project.heroBackground.stops.slice(0, 2);

			let gradient = angle && angle.length
				? angle
				: 'to right';

			stops.forEach((stop, i) => {
				gradient += `, ${ stop.color } ${ stop.position }%`;
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

<style src="@/styles/components/category-thumbnails.scss" lang="scss" scoped></style>