<template>
	<section class="site-header" :class="headerClass" @mousemove="/*onMouseMove*/">
		<Spinner :class="projectReady ? '-loaded' : ''" :width="svg.width" :height="svg.height" :font-size="fontSize" />

		<transition name="fade">
		<v-touch @swipeleft="navActive ? navigate(1) : null" @swiperight="navActive ? navigate(-1) : null" class="inner" v-show="projectReady">
			<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="projects && projects.length > 0 ? projects[0].heroImage.url : ''" @load="imageLoaded" />

			<nav class="project-nav" :class="navActive ? null: '-disabled'">
				<ButtonDefault class="btn-thumbnails" title="View all projects" font-icon="list" @click.native="navActive ? showCategory(categoryAll) : null" />

				<ButtonDefault class="btn nav-item nav-prev" :title="`Previous project: ${ projectTitle(activeProject - 1) }`" font-icon="arrow-left" @click.native="navActive ? navigate(-1) : null" />
				
				<ButtonDefault class="btn nav-item nav-next" :title="`Next project: ${ projectTitle(activeProject + 1) }`" font-icon="arrow-right" @click.native="navActive ? navigate(1) : null" />
			</nav>

			<div class="project-list">
				<div v-for="(project, index) in projects" class="project-mask" :class="projectClass[index]" :key="project.entryId" v-if="showProject(index)">
					<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="project.heroImage.url" />

					<button type="button" class="btn btn-enter-project" @click="projectClickHandler({ index, entryId: project.entryId })" :title="`View project '${ project.title }'`" tabindex="-1">
						<div class="button-inner">
							<div class="text">Enter project</div>
						</div>
					</button>
					
					<div class="mask-inner">
						<div class="svg-container">
							<div class="mask-svg">
								<div class="svg-inner" :style="selectedProject >= 0 ? `transform: translateY(${ bannerTranslateY }%) translateZ(0);` : null">
									<svg class="svg" x="0px" y="0px" :viewBox="`0 0 ${ svg.width } ${ svg.height }`" :style="`enable-background: new 0 0 ${ svg.width } ${ svg.height };`" xml:space="preserve" tabindex="-1">
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
											<!-- <rect x="0" y="0" :width="svg.width" :height="svg.height" style="fill: white" class="gradient-backdrop" /> -->

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" r="800" :style="`fill: url(#gradient-bg-${ index });`" />

											<g>
												<g class="project-hero">
													<image :width="svgImage(project.heroImage).width" :height="svgImage(project.heroImage).height" style="overflow:visible;" :xlink:href="project.heroImage.url" :x="svgImage(project.heroImage).x" :y="svgImage(project.heroImage).y"></image>
												</g>
											</g>

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" r="800" :style="`fill: url(#gradient-bg-${ index }); mix-blend-mode: hue; opacity: 0.5;`" />
										</g>
									</svg>
								</div>
							</div>
						</div>
					</div>

					<div class="project-info">
						<h2 class="project-title">{{ project.title }}</h2>

						<div class="project-tools">
							<div class="tool-label">{{ index === 0 ? 'Such as' : 'Tags' }}</div>

							<CategoryButtons :categories="project.categories" class="icon-list icon-list-categories" :tabindex="tabindex(index)" />

							<div class="project-buttons">
								<ButtonDefault class="btn btn-enter" :tabindex="tabindex(index)" :font-icon="index === 0 ? 'user-circle' : 'eye'" @click.native="projectClickHandler({ index, entryId: project.entryId })">{{ index === 0 ? 'About Will' : 'View project' }}</ButtonDefault>

								<ButtonDefault class="btn btn-exit" :tabindex="tabindex(index)" font-icon="grid" @click.native="projectClickHandler({ index, entryId: project.entryId })">All projects</ButtonDefault>
							</div>
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
	data: function () {
		return {
			svg: { width: 2400, height: 1600 },
			transitionClass: [ [ '-active' ] ],
			bgCoords: { x: 0, y: 0 },
			navActive: true,
			projectReady: false,
			bannerTranslateY: 0
		};
	},
	created () {
		this.getProjects();

		window.addEventListener('keyup', this.keyupHandler);
	},
	mounted () {
		let ticking = false;

		const scrollListener = () => {
			ticking = false;

			const BANNER_HEIGHT = 400;
			const MAX_PERCENTAGE = 8;
			this.bannerTranslateY = window.scrollY / BANNER_HEIGHT * MAX_PERCENTAGE;
		};

		window.addEventListener('scroll', (e) => {
			this.scrollY = window.scrollY;

			if (!ticking) {
				requestAnimationFrame(scrollListener);
			}
			ticking = true;
		});
	},
	methods: {
		layerPosition (depth) {
			const x = this.bgCoords.x * (-depth / Math.abs(depth));
			const y = this.bgCoords.y * (-depth / Math.abs(depth));
			return `transform: translate3d(${ x }px, ${ y }px, 0)`;
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
			this.projectReady = true;
		},
		showProject (index) {
			// let total = this.projects.length;
			// let ap = this.activeProject;
			// let range = 2;

			// return (index >= (ap - range) && index <= (ap + range)) || (index >= (ap - range + total) && index <= (ap + range + total)) || (index >= (ap - range - total) && index <= (ap + range - total));
			return true;
		},
		tabindex (index) {
			return index === this.activeProject ? 0 : -1;
		},
		projectClickHandler (options) {
			if (this.selectedProject > -1) {
				window.scrollTo(0, 0);

				this.exitProject();
			} else {
				this.enterProject(options);
			}
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
		navigate (direction) {
			window.scrollTo(0, 0);
			this.navigateProjects(direction);
		},
		...mapActions([
			'navigateProjects',
			'getProjects',
			'showCategory',
			'enterProject',
			'exitProject'
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

				if (!document.activeElement.classList.contains('nav-item') && this.$refs.activeButton) {
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
				let pClass = this.transitionClass[index]
					? this.transitionClass[index]
					: [];

				let sIndex = pClass.indexOf('-selected');

				if (index === this.selectedProject) {
					if (sIndex === -1) {
						pClass.push('-selected');
					}
				} else if (sIndex >= 0) {
					pClass.splice(sIndex, 1);
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
		headerClass () {
			return this.selectedProject >= 0
				? '-banner'
				: this.currentCategory
					? '-thumbnails-open'
					: null;
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