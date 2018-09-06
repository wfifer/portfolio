<template>
	<!-- <section class="site-header" :class="selectedProject >= 0 ? '-banner' : ''" @mousemove="/*onMouseMove*/"> -->
	<section class="site-header" :class="currentCategory ? '-thumbnails-open' : ''" @mousemove="/*onMouseMove*/">
		<Spinner :class="projectReady ? '-loaded' : ''"/>

		<transition name="fade">
		<v-touch @swipeleft="navActive ? navigateProjects(-1) : null" @swiperight="navActive ? navigateProjects(1) : null" class="inner" v-show="projectReady">
			<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="projects && projects.length > 0 ? projects[0].heroImage.url : ''" @load="imageLoaded" />

			<nav class="project-nav" :class="navActive ? null: '-disabled'">
				<ButtonDefault class="btn nav-item nav-prev" :title="`Previous project: ${ projectTitle(activeProject - 1) }`" font-icon="arrow-left" @click.native="navActive ? navigateProjects(-1) : null" />
				
				<ButtonDefault class="btn nav-item nav-next" :title="`Previous project: ${ projectTitle(activeProject - 1) }`" font-icon="arrow-right" @click.native="navActive ? navigateProjects(1) : null" />
				
				<ButtonDefault class="btn-thumbnails" title="View all projects" font-icon="grid" @click.native="navActive ? showCategory(categoryAll) : null" />
			</nav>

			<div class="project-list">
				<div v-for="(project, index) in projects" class="project-mask" :class="projectClass[index]" :key="project.entryId" v-if="showProject(index)">
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
						<h2 class="project-title">{{ project.title }}</h2>

						<div class="project-tools">
							<ul class="icon-list icon-list-website" v-if="index == 0">
								<li class="list-item">
									<ButtonDefault :tabindex="index === activeProject ? 0 : -1" button-color="reverse" title="Check me out on LinkedIn" font-icon="hand-peace" @click.native="enterAbout" text="About" :ref="index === activeProject ? 'activeButton' : null"/>
								</li>
							</ul>

							<ul class="icon-list icon-list-website" v-else-if="project.website && project.website.length">
								<li class="list-item">
									<ButtonDefault tag="a" :title="`View website for ${ project.title }`" :href="project.website" :newTab="true" :tabindex="index === activeProject ? 0 : -1" :ref="index === activeProject ? 'activeButton' : null" text="View website" font-icon="link" button-color="reverse" />
								</li>
							</ul>

							<ul class="icon-list icon-list-collab" v-if="project.collaborators.length > 0">
								<li v-for="(collaborator, i) in project.collaborators" class="list-item" :key="i">
									<ButtonDefault tag="a":title="`View website for ${ collaborator.title }`" :href="collaborator.website" :newTab="true" :tabindex="index === activeProject ? 0 : -1" :label="`Credit: ${ collaborator.title }`" font-icon="heart" :icon-transform="{ x: 0, y: '5%' }" button-color="reverse" />
								</li>
							</ul>

							<CategoryButtons :categories="project.categories" class="icon-list icon-list-categories" :tabindex="index === activeProject ? 0 : -1" />
						</div>
					</div>

					<div class="project-shadow">
						<div class="shadow shadow-left">
						</div>

						<div class="shadow shadow-right">
						</div>
					</div>
				</div>
			</div>
		</v-touch>
		</transition>
	</section>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import Spinner from '@/components/Spinner';
import CategoryButtons from '@/components/CategoryButtons';
import ButtonDefault from '@/components/ButtonDefault';

export default {
	name: 'Projects',
	components: {
		Spinner,
		CategoryButtons,
		ButtonDefault
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

			let width = BASE_WIDTH;

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
		showProject (index) {
			// let total = this.projects.length;
			// let ap = this.activeProject;
			// let range = 2;

			// return (index >= (ap - range) && index <= (ap + range)) || (index >= (ap - range + total) && index <= (ap + range + total)) || (index >= (ap - range - total) && index <= (ap + range - total));
			return true;
		},
		...mapActions([
			'navigateProjects',
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
		fontSize () {
			const BASE_SIZE = 1350;

			let fontSize = BASE_SIZE;

			return fontSize;
		},
		categoryAll () {
			return this.categories.filter((cat, i) => {
				return cat.slug === 'all';
			})[0];
		},
		...mapState({
			activeProject: state => state.projects.active,
			lastProject: state => state.projects.last,
			selectedProject: state => state.projects.selected,
			direction: state => state.projects.direction,
			projects: state => state.projects.featuredProjects,
			viewport: state => state.app.window,
			currentCategory: state => state.projects.currentCategory,
			categories: state => state.projects.categories
		})
	}
};
</script>

<style src="../styles/components/icon-list.scss" lang="scss"></style>
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