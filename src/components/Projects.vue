<template>
	<section class="site-header" :class="headerClass" @mousemove="/*onMouseMove*/">
		<Spinner :class="projectReady ? '-loaded' : ''" :width="svg.width" :height="svg.height" :font-size="fontSize" />

		<transition name="fade">
		<div class="inner" v-show="projectReady">
			<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="projects && projects.length > 0 ? projects[0].heroImage.url : ''" @load="imageLoaded" />

			<nav class="project-nav" :class="navActive ? null: '-disabled'">
				<div class="theme-selection">
					<label for="theme">
						<Icon :icon="['far', 'paint-brush']" />
					</label>
					<div class="select">
						<select @change="setTheme" name="theme" id="theme" aria-label="Color scheme (accessibility)" :value="theme">
							<option value="DEFAULT">Default Theme</option>
							<option value="ACCESSIBLE">High Contrast</option>
							<!-- <option value="LIGHT">Light Mode</option> -->
						</select>

						<Icon class="icon" :icon="['far', 'chevron-down']" />
					</div>
				</div>

				<ButtonDefault class="btn-thumbnails" title="View all projects" icon="list" @click.native="navActive ? showCategory(categoryAll) : null" />

				<ButtonDefault class="btn nav-item nav-prev" :title="`Previous project: ${ projectTitle(activeProject - 1) }`" icon="arrow-left" @click.native="navActive ? navigate(-1) : null" />

				<ButtonDefault class="btn nav-item nav-next" :title="`Next project: ${ projectTitle(activeProject + 1) }`" icon="arrow-right" @click.native="navActive ? navigate(1) : null" />
			</nav>

			<div class="project-list">
				<div v-for="(project, index) in projects" class="project-mask" :class="projectClass[project.entryId]" :key="project.entryId">
					<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="project.heroImage.url" />

					<button type="button" class="btn btn-enter-project" @click="projectClickHandler({ index, entryId: project.entryId })" :title="`View project '${ project.title }'`" tabindex="-1">
						<div class="button-inner">
							<div class="text">Enter project</div>
						</div>
					</button>

					<div class="mask-inner">
						<div class="svg-container">
							<div class="mask-svg">
								<div class="svg-inner" :style="selectedProject !== null ? `transform: translateY(${ bannerTranslateY }%) translateZ(0);` : null">
									<svg class="svg" x="0px" y="0px" :viewBox="`0 0 ${ svg.width } ${ svg.height }`" :style="`enable-background: new 0 0 ${ svg.width } ${ svg.height };`" xml:space="preserve" tabindex="-1">
								 		<defs>
											<linearGradient :id="`gradient-bg-${ index }`" x1="0%" y1="0%" x2="100%" y2="0%">
												<stop v-for="(stop, stopIndex) in project.heroBackground.stops" :offset="`${ stop.position }%`" :key="stopIndex" :stop-color="stop.color"/>
											</linearGradient>

											<clipPath clipPathUnits="userSpaceOnUse" :id="`text-clip-${ index }`">
												<text class="text-mask" :x="svg.width / 2" :y="svg.height / 2" text-anchor="middle" :style="`font-size: ${fontSize}px; dominant-baseline: central; letter-spacing: -0.125em;`" fill="#FFFFFF">
													<tspan :style="`font-size: ${fontSize / 2}px; opacity: 0;`" class="initial-dot">.</tspan>
													<tspan>{{ projectInitial[project.entryId] }}</tspan>
													<tspan :dy="`${fontSize * 0.175}px`" :style="`font-size: ${fontSize / 2}px;`" class="initial-dot">.</tspan>
												</text>
											</clipPath>

											<mask maskUnits="userSpaceOnUse" x="0" y="0" :width="svg.width" :height="svg.height" :id="`text-mask-${ index }`">
												<g class="text-mask">
													<text :transform="`matrix(1 0 0 1 ${ svg.width / 2 } ${ svg.height / 2 + fontSize / 2.8 })`" text-anchor="middle" :style="`font-size: ${fontSize}px`">
														<tspan :style="`font-size: ${fontSize / 2}px; opacity: 0;`" class="initial-dot">.</tspan>
														<tspan>{{ projectInitial[project.entryId] }}</tspan>
														<tspan :dy="`${fontSize * 0.175}px`" :style="`font-size: ${fontSize / 2}px;`" class="initial-dot">.</tspan>
													</text>
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
							<div class="label">{{ index === 0 ? 'Like' : 'Tags' }}</div>

							<CategoryButtons :categories="project.categories" class="icon-list icon-list-categories" :tabindex="tabindex(project.entryId)" />

							<div class="project-buttons">
								<ButtonDefault class="btn btn-enter" :tabindex="tabindex(project.entryId)" :icon="['far', index === 0 ? 'user-circle' : 'eye']" @click.native="projectClickHandler({ index, entryId: project.entryId })">{{ index === 0 ? 'About Will' : 'View project' }}</ButtonDefault>

								<ButtonDefault class="btn btn-exit" :tabindex="tabindex(project.entryId)" :icon="['far', 'arrow-circle-up']" @click.native="projectClickHandler({ entryId: project.entryId })">All projects</ButtonDefault>
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
		</div>
		</transition>
	</section>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import VueScrollTo from 'vue-scrollto';
import Spinner from '@/components/Spinner';
import Icon from '@/components/Icon';
import CategoryButtons from '@/components/CategoryButtons';
import ButtonDefault from '@/components/ButtonDefault';

export default {
	name: 'Projects',
	components: {
		Spinner,
		CategoryButtons,
		ButtonDefault,
		Icon
	},
	props: {
		setTheme: Function,
		theme: String
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
			const MAX_PERCENTAGE = 12;
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
		tabindex (entryId) {
			return entryId === this.activeProject ? 0 : -1;
		},
		projectClickHandler (options) {
			if (this.selectedProject !== null) {
				if (window.scrollY !== 0) {
					VueScrollTo.scrollTo(document.documentElement, 350, {
						onDone: () => {
							this.exitProject();
						},
						onCancel: () => {
							this.exitProject();
						},
						easing: 'ease-out'
					});
				} else {
					this.exitProject();
				}
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
			'navigateProjects',
			'getProjects',
			'showCategory',
			'enterProject',
			'exitProject'
		])
	},
	watch: {
		activeProject: function (newValue, oldValue) {
			this.transitionClass = Object.keys(this.projectsById).reduce((acc, entryId) => {
				let pClass = [];

				if (this.activeProject === entryId) {
					pClass.push('-animate-in');
				} else if (this.lastProject === entryId) {
					pClass.push('-active', '-animate-out');

					pClass.push(this.direction === 1 ? '-left' : '-right');
				}
				return { ...acc, [entryId]: pClass };
			}, {});

			this.navActive = false;
			this.$emit('navActive', false);

			setTimeout(() => {
				this.transitionClass = Object.keys(this.projectsById).reduce((acc, entryId) => {
					let pClass = this.activeProject === entryId ? ['-active'] : [];
					return { ...acc, [entryId]: pClass };
				}, {});

				this.navActive = true;
				this.$emit('navActive', true);

				if (!document.activeElement.classList.contains('nav-item') && this.$refs.activeButton) {
					this.$refs.activeButton[0].focus = true;
				}
			}, 2000);
		}
	},
	computed: {
		projects () {
			return Object.keys(this.projectsById).map(id => this.projectsById[id]);
		},
		projectClass () {
			const p = Object.keys(this.projectsById).reduce((acc, entryId) => {
				let pClass = this.transitionClass[entryId] || [];

				let sIndex = pClass.indexOf('-selected');

				if (entryId === this.selectedProject) {
					if (sIndex === -1) {
						pClass.push('-selected');
					}
				} else if (sIndex >= 0) {
					pClass.splice(sIndex, 1);
				}

				return { ...acc, [entryId]: pClass };
			}, {});
			return p;
		},
		projectInitial () {
			return Object.keys(this.projectsById).reduce((acc, entryId) => {
				return { ...acc, [entryId]: this.projectsById[entryId].title.replace(/the /i, '').slice(0, 1) };
			}, {});
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
			return this.selectedProject !== null
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
			projectsById: state => state.projects.byId,
			viewport: state => state.app.window,
			currentCategory: state => state.projects.currentCategory,
			categories: state => state.projects.categories
		})
	}
};
</script>

<style src="../styles/components/icon-list.scss" lang="scss"></style>
<style src="../styles/components/projects.scss" lang="scss"></style>