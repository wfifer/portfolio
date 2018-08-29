<template>
	<!-- <section class="site-header" :class="selectedProject >= 0 ? '-banner' : ''" @mousemove="/*onMouseMove*/"> -->
	<section class="site-header" :class="currentCategory ? '-thumbnails-open' : ''" @mousemove="/*onMouseMove*/">
		<Spinner :class="projectReady ? '-loaded' : ''"/>

		<transition name="fade">
		<div class="inner" v-show="projectReady">
			<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="projects && projects.length > 0 ? projects[0].heroImage.url : ''" @load="imageLoaded" />

			<nav class="project-nav" :class="navActive ? null: '-disabled'">
				<button @click="navActive ? navigateProjects(-1) : null" type="button" class="btn nav-item nav-prev" :aria-label="`Previous project: ${ projectTitle(activeProject - 1) }`">
					<div class="nav-icon"></div>
				</button>

				<button @click="navActive ? navigateProjects(1) : null" type="button" class="btn nav-item nav-next" :aria-label="`Next project: ${ projectTitle(activeProject + 1) }`">
					<div class="nav-icon"></div>
				</button>
			</nav>

			<div class="project-list">
				<div v-for="(project, index) in projects" class="project-mask" :class="projectClass[index]" :key="index">
					<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="project.heroImage.url" />

					<div class="mask-inner">
						<div class="svg-container">
							<div class="mask-svg">
								<div class="svg-inner">
									<svg class="svg" x="0px" y="0px" :viewBox="`0 0 ${ svg.width } ${ svg.height }`" :style="`enable-background: new 0 0 ${ svg.width } ${ svg.height };`" xml:space="preserve">
								 		<defs>
											<linearGradient :id="`gradient-bg-${ index }`" x1="0%" y1="0%" x2="100%" y2="0%">
												<stop v-for="(stop, stopIndex) in project.heroBackground.stops" :offset="`${ stop.position }%`" :key="stopIndex" :stop-color="stop.color"/>
											</linearGradient>

											<clipPath clipPathUnits="userSpaceOnUse" :id="`text-clip-${ index }`">
												<text class="text-mask" :x="svg.width / 2" :y="svg.height / 2" text-anchor="middle" :style="`font-size: ${fontSize}px; dominant-baseline: central;`" fill="#FFFFFF">{{ projectInitial[index] }}</text>
											</clipPath>

											<mask maskUnits="userSpaceOnUse" x="0" y="0" :width="svg.width" :height="svg.height" :id="`text-mask-${ index }`">
												<g class="text-mask">
													<text :transform="`matrix(1 0 0 1 ${ svg.width / 2 } ${ svg.height / 2 + fontSize / 2.8 })`" text-anchor="middle" :style="`font-size: ${fontSize}px`">{{ projectInitial[index] }}</text>
												</g>
											</mask>
										</defs>

										<g :style="`clip-path: url(#text-clip-${ index }); mask: url(#text-mask-${ index });`" class="svg-clipped">
											<rect x="0" y="0" :width="svg.width" :height="svg.height" style="fill: white" />

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" :r="svgImage(project.heroImage).width * 0.625" :style="`fill: url(#gradient-bg-${ index });`" />

											<g>
												<g class="project-hero">
													<image :width="svgImage(project.heroImage).width" :height="svgImage(project.heroImage).height" style="overflow:visible;" :xlink:href="project.heroImage.url" :x="svgImage(project.heroImage).x" :y="svgImage(project.heroImage).y"></image>
												</g>
											</g>

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" :r="svgImage(project.heroImage).width * 0.625" :style="`fill: url(#gradient-bg-${ index }); mix-blend-mode: hue; opacity: 0.5;`" />
										</g>
									</svg>
								</div>
							</div>
						</div>
					</div>

					<div class="project-info">
						<h2 class="project-title" v-html="titleHtml[index]"></h2>

						<div class="project-tools">
							<ul class="icon-list icon-list-website" v-if="index == 0">
								<li class="list-item">
									<button class="btn" @click="enterAbout" :tabindex="index === activeProject ? 0 : -1" :ref="index === activeProject ? 'activeButton' : null">
										<div class="item-icon">
											<Icon name="hand-peace" />

											<span class="text">About</span>
										</div>
									</button>
								</li>
							</ul>

							<ul class="icon-list icon-list-website" v-else-if="project.website && project.website.length">
								<li class="list-item">

									<a :href="project.website" target="_blank" :tabindex="index === activeProject ? 0 : -1" :ref="index === activeProject ? 'activeButton' : null">
										<div class="item-icon">
											<Icon name="link" />

											<span class="text">View website</span>
										</div>
									</a>
								</li>
							</ul>

							<ul class="icon-list icon-list-collab">
								<li v-for="(collaborator, i) in project.collaborators" class="list-item" :key="i">
									<a tabindex="-1" :title="collaborator.title" :href="collaborator.website" target="_blank" :tabindex="index === activeProject ? 0 : -1">
										<div class="item-icon" :aria-label="`Credit: ${collaborator.title}`">
											<Icon name="heart" style="transform: translateY(6%)" />

											<span class="text">Credit: {{ collaborator.title }}</span>
										</div>
									</a>
								</li>
							</ul>

							<ul class="icon-list icon-list-categories">
								<li v-for="(cat, i) in project.categories" class="list-item" :key="i">
									<button class="btn" :title="cat.title" @click="showCategory(cat.slug)" :tabindex="index === activeProject ? 0 : -1">
										<div v-if="cat.icon" class="item-icon" :aria-label="cat.title">
											<img class="icon" :src="cat.icon" />
										</div>

										<div v-else class="item-icon" :aria-label="cat.title">
											<Icon :name="mapIcons(cat.fontIcon)" />
										</div>
									</button>
								</li>
							</ul>
						</div>
					</div>

					<div class="nav-animation">
						<div class="nav-item nav-prev">
						</div>

						<div class="nav-item nav-next">
						</div>
					</div>
				</div>
			</div>
		</div>
		</transition>
	</section>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import 'vue-awesome/icons';
import Icon from 'vue-awesome/components/Icon';
import Spinner from '@/components/Spinner';

Icon.register({
	react: {
		width: 512,
		height: 512,
		d: 'M418.2 177.2c-5.4-1.8-10.8-3.5-16.2-5.1.9-3.7 1.7-7.4 2.5-11.1 12.3-59.6 4.2-107.5-23.1-123.3-26.3-15.1-69.2.6-112.6 38.4-4.3 3.7-8.5 7.6-12.5 11.5-2.7-2.6-5.5-5.2-8.3-7.7-45.5-40.4-91.1-57.4-118.4-41.5-26.2 15.2-34 60.3-23 116.7 1.1 5.6 2.3 11.1 3.7 16.7-6.4 1.8-12.7 3.8-18.6 5.9C38.3 196.2 0 225.4 0 255.6c0 31.2 40.8 62.5 96.3 81.5 4.5 1.5 9 3 13.6 4.3-1.5 6-2.8 11.9-4 18-10.5 55.5-2.3 99.5 23.9 114.6 27 15.6 72.4-.4 116.6-39.1 3.5-3.1 7-6.3 10.5-9.7 4.4 4.3 9 8.4 13.6 12.4 42.8 36.8 85.1 51.7 111.2 36.6 27-15.6 35.8-62.9 24.4-120.5-.9-4.4-1.9-8.9-3-13.5 3.2-.9 6.3-1.9 9.4-2.9 57.7-19.1 99.5-50 99.5-81.7 0-30.3-39.4-59.7-93.8-78.4zM282.9 92.3c37.2-32.4 71.9-45.1 87.7-36 16.9 9.7 23.4 48.9 12.8 100.4-.7 3.4-1.4 6.7-2.3 10-22.2-5-44.7-8.6-67.3-10.6-13-18.6-27.2-36.4-42.6-53.1 3.9-3.7 7.7-7.2 11.7-10.7zm-130 189.1c4.6 8.8 9.3 17.5 14.3 26.1 5.1 8.7 10.3 17.4 15.8 25.9-15.6-1.7-31.1-4.2-46.4-7.5 4.4-14.4 9.9-29.3 16.3-44.5zm0-50.6c-6.3-14.9-11.6-29.5-16-43.6 14.4-3.2 29.7-5.8 45.6-7.8-5.3 8.3-10.5 16.8-15.4 25.4-4.9 8.5-9.7 17.2-14.2 26zm11.4 25.3c6.6-13.8 13.8-27.3 21.4-40.6 7.6-13.3 15.8-26.2 24.4-38.9 15-1.1 30.3-1.7 45.9-1.7 15.6 0 31 .6 45.9 1.7 8.5 12.6 16.6 25.5 24.3 38.7 7.7 13.2 14.9 26.7 21.7 40.4-6.7 13.8-13.9 27.4-21.6 40.8-7.6 13.3-15.7 26.2-24.2 39-14.9 1.1-30.4 1.6-46.1 1.6-15.7 0-30.9-.5-45.6-1.4-8.7-12.7-16.9-25.7-24.6-39-7.7-13.3-14.8-26.8-21.5-40.6zm180.6 51.2c5.1-8.8 9.9-17.7 14.6-26.7 6.4 14.5 12 29.2 16.9 44.3-15.5 3.5-31.2 6.2-47 8 5.4-8.4 10.5-17 15.5-25.6zm14.4-76.5c-4.7-8.8-9.5-17.6-14.5-26.2-4.9-8.5-10-16.9-15.3-25.2 16.1 2 31.5 4.7 45.9 8-4.6 14.8-10 29.2-16.1 43.4zM256.2 118.3c10.5 11.4 20.4 23.4 29.6 35.8-19.8-.9-39.7-.9-59.5 0 9.8-12.9 19.9-24.9 29.9-35.8zM140.2 57c16.8-9.8 54.1 4.2 93.4 39 2.5 2.2 5 4.6 7.6 7-15.5 16.7-29.8 34.5-42.9 53.1-22.6 2-45 5.5-67.2 10.4-1.3-5.1-2.4-10.3-3.5-15.5-9.4-48.4-3.2-84.9 12.6-94zm-24.5 263.6c-4.2-1.2-8.3-2.5-12.4-3.9-21.3-6.7-45.5-17.3-63-31.2-10.1-7-16.9-17.8-18.8-29.9 0-18.3 31.6-41.7 77.2-57.6 5.7-2 11.5-3.8 17.3-5.5 6.8 21.7 15 43 24.5 63.6-9.6 20.9-17.9 42.5-24.8 64.5zm116.6 98c-16.5 15.1-35.6 27.1-56.4 35.3-11.1 5.3-23.9 5.8-35.3 1.3-15.9-9.2-22.5-44.5-13.5-92 1.1-5.6 2.3-11.2 3.7-16.7 22.4 4.8 45 8.1 67.9 9.8 13.2 18.7 27.7 36.6 43.2 53.4-3.2 3.1-6.4 6.1-9.6 8.9zm24.5-24.3c-10.2-11-20.4-23.2-30.3-36.3 9.6.4 19.5.6 29.5.6 10.3 0 20.4-.2 30.4-.7-9.2 12.7-19.1 24.8-29.6 36.4zm130.7 30c-.9 12.2-6.9 23.6-16.5 31.3-15.9 9.2-49.8-2.8-86.4-34.2-4.2-3.6-8.4-7.5-12.7-11.5 15.3-16.9 29.4-34.8 42.2-53.6 22.9-1.9 45.7-5.4 68.2-10.5 1 4.1 1.9 8.2 2.7 12.2 4.9 21.6 5.7 44.1 2.5 66.3zm18.2-107.5c-2.8.9-5.6 1.8-8.5 2.6-7-21.8-15.6-43.1-25.5-63.8 9.6-20.4 17.7-41.4 24.5-62.9 5.2 1.5 10.2 3.1 15 4.7 46.6 16 79.3 39.8 79.3 58 0 19.6-34.9 44.9-84.8 61.4zM256 210.2c25.3 0 45.8 20.5 45.8 45.8 0 25.3-20.5 45.8-45.8 45.8-25.3 0-45.8-20.5-45.8-45.8 0-25.3 20.5-45.8 45.8-45.8'
	},
	'hand-peace': {
		width: 448,
		height: 512,
		d: 'M408 216c-22.092 0-40 17.909-40 40h-8v-32c0-22.091-17.908-40-40-40s-40 17.909-40 40v32h-8V48c0-26.51-21.49-48-48-48s-48 21.49-48 48v208h-13.572L92.688 78.449C82.994 53.774 55.134 41.63 30.461 51.324 5.787 61.017-6.356 88.877 3.337 113.551l74.765 190.342-31.09 24.872c-15.381 12.306-19.515 33.978-9.741 51.081l64 112A39.998 39.998 0 0 0 136 512h240c18.562 0 34.686-12.77 38.937-30.838l32-136A39.97 39.97 0 0 0 448 336v-80c0-22.091-17.908-40-40-40z'
	},
	vuejs: {
		width: 448,
		height: 512,
		d: 'M356.9 64.3H280l-56 88.6-48-88.6H0L224 448 448 64.3h-91.1zm-301.2 32h53.8L224 294.5 338.4 96.3h53.8L224 384.5 55.7 96.3z'
	},
	'pencil-alt': {
		width: 512,
		height: 512,
		d: 'M497.9 142.1l-46.1 46.1c-4.7 4.7-12.3 4.7-17 0l-111-111c-4.7-4.7-4.7-12.3 0-17l46.1-46.1c18.7-18.7 49.1-18.7 67.9 0l60.1 60.1c18.8 18.7 18.8 49.1 0 67.9zM284.2 99.8L21.6 362.4.4 483.9c-2.9 16.4 11.4 30.6 27.8 27.8l121.5-21.3 262.6-262.6c4.7-4.7 4.7-12.3 0-17l-111-111c-4.8-4.7-12.4-4.7-17.1 0zM124.1 339.9c-5.5-5.5-5.5-14.3 0-19.8l154-154c5.5-5.5 14.3-5.5 19.8 0s5.5 14.3 0 19.8l-154 154c-5.5 5.5-14.3 5.5-19.8 0zM88 424h48v36.3l-64.5 11.3-31.1-31.1L51.7 376H88v48z'
	}
});

export default {
	name: 'Projects',
	components: {
		Icon,
		Spinner
	},
	created () {
		this.getProjects();

		window.addEventListener('keyup', this.keyupHandler);
	},
	data: function () {
		return {
			svg: { width: 2400, height: 1600 },
			transitionClass: [ '-active' ],
			bgCoords: { x: 0, y: 0 },
			navActive: true,
			projectReady: false
		};
	},
	methods: {
		enterAbout () {
			window.open('http://www.linkedin.com/in/will-fifer', '_blank');
		},
		enterProject (options) {
			if (options.index === 0) {
				this.enterAbout();
			} else {
				const project = this.projects[options.index];
				window.open(project.website);
			}
		},
		layerPosition (depth) {
			const x = this.bgCoords.x * (-depth / Math.abs(depth));
			const y = this.bgCoords.y * (-depth / Math.abs(depth));
			return `transform: translate3d(${ x }px, ${ y }px, 0)`;
		},
		mapIcons (icon) {
			if (icon) {
				if (icon.length === 1) {
					return icon[0];
				}
				return icon;
			}
			return 'cog';
		},
		keyupHandler (e) {
			if (this.navActive) {
				switch (e.which) {
					case 37:
						this.navigateProjects(-1);
						break;

					case 39:
						this.navigateProjects(1);
						break;

					default:
						break;
				}
			}
		},
		svgImage (image) {
			const BASE_WIDTH = 1720;

			let aspectRatio = image.width / image.height;

			let portrait = this.viewport.width / this.viewport.height < this.svg.width / this.svg.height;

			let width = this.viewport.width <= 1000
				? BASE_WIDTH * 1.5
				: portrait
				? BASE_WIDTH
				: this.viewport.height >= 1000
				? BASE_WIDTH * this.svg.width / this.svg.height * 1000 / this.viewport.width
				: this.viewport.height <= 500
				? BASE_WIDTH * this.svg.width / this.svg.height * 500 / this.viewport.width
				: BASE_WIDTH * this.svg.width / this.svg.height * this.viewport.height / this.viewport.width;

			let height = width / aspectRatio;

			let x = (this.svg.width - width) / 2;
			let y = (this.svg.height - (width / aspectRatio)) / 2;

			return {
				width: width,
				height: height,
				x: x,
				y: y
			};
		},
		projectTitle (index) {
			if (index < 0) {
				index += this.projects.length;
			}

			let project = this.projects[index % this.projects.length];

			let title = project ? project.title : '';

			return title;
		},
		imageLoaded () {
			window.setTimeout(() => {
				this.projectReady = true;
			}, 2000);
		},
		...mapActions([
			'navigateProjects',
			// 'enterProject',
			'getProjects',
			'showCategory'
		])
	},
	watch: {
		activeProject: function (newValue, oldValue) {
			this.transitionClass = this.projects.map((project, index) => {
				let pClass = [];

				if (this.activeProject === index) {
					pClass.push('-animate-in');
				} else if (this.lastProject === index) {
					pClass.push('-active', '-animate-out');

					pClass.push(this.direction === 1 ? '-left' : '-right');
				}
				return pClass;
			});

			this.navActive = false;

			setTimeout(() => {
				this.transitionClass = this.projects.map((project, index) => {
					let pClass = this.activeProject === index ? ['-active'] : [];
					return pClass;
				});

				this.navActive = true;

				if (!document.activeElement.classList.contains('nav-item')) {
					console.log(this.$refs.activeButton);

					this.$refs.activeButton[0].focus = true;
				}
			}, 2000);
		}
	},
	computed: {
		gradientTransform () {
			return this.projects.map((project, index) => {
				let bg = `fill: url(#gradient-bg-${ index }); transform: translate(${ this.svg.width / 2 }px, ${ this.svg.height / 2 }px)`;

				if (this.selectedProject >= 0) {
					bg += ' scale(3)';
				}

				bg += project.heroBackground.angle.length ? ' rotate(' + project.heroBackground.angle + ')' : '';
				return bg;
			});
		},
		projectClass () {
			return this.projects.map((project, index) => {
				let pClass = this.transitionClass[index];
				if (index === this.selectedProject) {
					pClass.push('-selected');
				}
				return pClass;
			});
		},
		projectInitial () {
			return this.projects.map(function (project) {
				return project.title.replace(/the /i, '').slice(0, 1);
			});
		},
		titleHtml () {
			return this.projects.map(function (project) {
				return project.title.replace(/(\S)/g, '<span>$1</span>').replace(/(\S+)/g, '<div>$1</div>');
			});
		},
		fontSize () {
			const BASE_SIZE = 1350;

			let fontSize = BASE_SIZE;

			if (this.viewport.width <= 1000) {
				fontSize = BASE_SIZE * 1.5;
			} else if (this.viewport.width / this.viewport.height > this.svg.width / this.svg.height) {
				if (this.viewport.height >= 1000) {
					fontSize = BASE_SIZE * this.svg.width / this.svg.height * 1000 / this.viewport.width;
				} else if (this.viewport.height <= 500) {
					fontSize = BASE_SIZE * this.svg.width / this.svg.height * 500 / this.viewport.width;
				} else {
					fontSize = BASE_SIZE * this.svg.width / this.svg.height * this.viewport.height / this.viewport.width;
				}
			}

			return fontSize;
		},
		...mapState({
			activeProject: state => state.projects.active,
			lastProject: state => state.projects.last,
			selectedProject: state => state.projects.selected,
			direction: state => state.projects.direction,
			projects: state => state.projects.projects,
			viewport: state => state.app.window,
			currentCategory: state => state.projects.currentCategory
		})
	}
};
</script>

<style src="../styles/components/projects.scss" lang="scss"></style>

<style lang="scss" scoped>

.fade-enter-active {
	transition: opacity 1s;
	will-change: opacity;
}

.fade-enter-to {
	opacity: 1;
}

.fade-enter {
	opacity: 0;
}

</style>