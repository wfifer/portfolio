<template>
	<section class="site-header" :class="headerClass" @mousemove="/*onMouseMove*/">
		<Spinner :class="projects && projects.length > 0 ? '-loaded' : ''" :width="svg.width" :height="svg.height" :font-size="fontSize" />

		<transition name="fade">
		<div class="inner" v-show="projects && projects.length > 0" :style="`--color-project-bg: ${projectBackgroundColor}`">
			<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="projects && projects.length > 0 ? projects[0].heroImage.url : ''" @load="imageLoaded" />

			<nav class="project-nav" :class="navActive ? null: '-disabled'">
				<!-- <div class="theme-selection">
					<label for="theme">
						<Icon :icon="['far', 'paint-brush']" />
					</label>
					<div class="select">
						<v-select 
							@option:selected="setTheme" 
							name="theme" 
							id="theme" 
							aria-label="Color scheme (accessibility)" 
							:value="themeOptions.find(t => t.value === theme)"
							:options="themeOptions"
							:components="{OpenIndicator}"
							:clearable="false"
						></v-select>
					</div>
				</div> -->

				<ButtonDefault :disabled="!navActive" class="btn-thumbnails" title="View all projects" icon="list" @click.native="navActive ? showCategory(categoryAll) : null" />

				<ButtonDefault :disabled="!navActive" class="btn nav-item nav-prev" :title="`Previous project: ${ prevProject.title }`" icon="arrow-left" @click.native="navActive ? navigate(-1) : null" />

				<ButtonDefault :disabled="!navActive" class="btn nav-item nav-next" :title="`Next project: ${ nextProject.title }`" icon="arrow-right" @click.native="navActive ? navigate(1) : null" />
			</nav>

			<div class="project-list">
				<div v-for="(project, index) in projects" class="project-mask" :class="projectClass[project.entryId]" :key="project.entryId" :style="`--color-project-bg: ${project.backgroundColor}; --color-project-accent: ${project.heroBackground.stops[1].color};`">
					<img style="opacity: 0; visibility: hidden; position: absolute; z-index: -10; width: 1px" :src="project.heroImage.url" />

					<button type="button" class="btn btn-enter-project" @click="projectClickHandler({ index, entryId: project.entryId })" :title="`View project '${ project.title }'`" tabindex="-1">
						<div class="button-inner">
							<div class="text">Enter project</div>
						</div>
					</button>

					<div class="mask-inner">
						<div class="hero-image-container">
							<div class="hero-image">
								<img :src="project.heroImage.url" />
							</div>
							
							<div class="hero-image">
								<img :src="project.heroImage.url" />
							</div>
						</div>

						<div class="svg-container">
							<div class="mask-svg">
								<div class="svg-inner" :style="selectedProject !== null ? `transform: translateY(${ bannerTranslateY }%) translateZ(0);` : null">
									<!-- <svg class="svg hero-image-svg" x="0px" y="0px" :viewBox="`0 0 ${ svg.width } ${ svg.height }`" :style="`enable-background: new 0 0 ${ svg.width } ${ svg.height };`" xml:space="preserve" tabindex="-1">
										<filter id="desaturate">
											<feColorMatrix in="SourceGraphic" type="multiply" values="0" />
										</filter>

										<g class="project-hero">
											<image :width="svgImage(project.heroImage).width" :height="svgImage(project.heroImage).height" style="overflow:visible;" :xlink:href="project.heroImage.url" :x="svgImage(project.heroImage).x" :y="svgImage(project.heroImage).y"></image>
										</g>
									</svg> -->

									<svg class="svg" x="0px" y="0px" :viewBox="`0 0 ${ svg.width } ${ svg.height }`" :style="`enable-background: new 0 0 ${ svg.width } ${ svg.height };`" xml:space="preserve" tabindex="-1">
								 		<defs>
											<linearGradient :id="`gradient-bg-${ index }`" x1="0%" y1="0%" x2="100%" y2="100%">
												<stop v-for="(stop, stopIndex) in project.heroBackground.stops" :offset="`${ stop.position }%`" :key="stopIndex" :stop-color="stop.color"/>
											</linearGradient>

											<clipPath clipPathUnits="userSpaceOnUse" :id="`text-clip-${ index }`">
												<text class="text-mask" :x="svg.width / 2" :y="svg.height * 0.8" text-anchor="middle" :style="`font-size: ${fontSize}px; dominant-baseline: central;`" fill="#FFFFFF">
													<tspan>{{ projectInitial[project.entryId] }}</tspan>
												</text>
											</clipPath>

											<mask maskUnits="userSpaceOnUse" x="0" y="0" :width="svg.width" :height="svg.height" :id="`text-mask-${ index }`">
												<g class="text-mask">
													<text :transform="`matrix(1 0 0 1 ${ svg.width / 2 } ${ svg.height / 2 + fontSize / 2.8 })`" text-anchor="middle" :style="`font-size: ${fontSize}px`">
														<tspan>{{ projectInitial[project.entryId] }}</tspan>
													</text>
												</g>
											</mask>
										</defs>

										<g :style="`clip-path: url(#text-clip-${ index }); mask: url(#text-mask-${ index });`" class="svg-clipped">
											<!-- <rect x="0" y="0" :width="svg.width" :height="svg.height" style="fill: white" class="gradient-backdrop" /> -->

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" r="1600" :style="`fill: url(#gradient-bg-${ index });`" />

											<!-- <g>
												<g class="project-hero">
													<image filter="url(#desaturate)" :width="svgImage(project.heroImage).width" :height="svgImage(project.heroImage).height" style="overflow:visible;" :xlink:href="project.heroImage.url" :x="svgImage(project.heroImage).x" :y="svgImage(project.heroImage).y"></image>
												</g>
											</g> -->

											<circle class="gradient-overlay" :cx="svg.width / 2" :cy="svg.height / 2" r="1600" :style="`fill: url(#gradient-bg-${ index }); mix-blend-mode: hue; opacity: 0.5;`" />
										</g>
									</svg>
								</div>
							</div>
						</div>
					</div>

					<div class="project-info">
						<h3 v-if="index == 0" class="project-subtitle">Hi, my name is</h3>

						<h2 class="project-title">{{ index === 0 && selectedProject === null ? categoryTitle : project.title }}</h2>

						<div class="project-tools">
							<!-- <div class="label">{{ index === 0 ? 'Like' : 'Tags' }}</div> -->

							<CategoryButtons :emitOnly="index === 0 && selectedProject === null" @rollover="updateCategoryTitle" :categories="project.categories" class="icon-list icon-list-categories" :tabindex="tabindex(project.entryId)" />

							<div class="project-buttons">
								<ButtonDefault class="btn btn-enter" :tabindex="tabindex(project.entryId)" :icon="['far', index === 0 ? 'user-circle' : 'eye']" @click.native="projectClickHandler({ index, entryId: project.entryId })" @mouseenter.native="updateCategoryTitle({ slug: null })">{{ index === 0 ? 'About' : 'Info' }}</ButtonDefault>

								<ButtonDefault class="btn btn-exit" :tabindex="tabindex(project.entryId)" :icon="['far', 'arrow-circle-up']" @click.native="projectClickHandler({ entryId: project.entryId })">All</ButtonDefault>
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
			bannerTranslateY: 0,
			OpenIndicator: {
				render: createElement => createElement(Icon, {
					props: {
						icon: ['far', 'chevron-down']
					}
				})
			},
			categoryTitle: 'Will Fifer',
			categoryTitleTimeout: null,
			themeOptions: [
				{ value: 'DEFAULT', label: 'Default Theme' },
				{ value: 'ACCESSIBLE', label: 'High Contrast' }
			]
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

			if (!ticking && this.viewport.width > 768) {
				requestAnimationFrame(scrollListener);
			}
			ticking = true;
		});
	},
	methods: {
		updateCategoryTitle (category) {
			this.categoryTitle = this.mapCategoryToTitle(category.slug);
		},
		mapCategoryToTitle (slug) {
			const titleMap = {
				'product-design': 'Designer',
				'ui-design': 'UI Designer',
				'development': 'Developer',
				'graphic-design': 'Graphic Designer',
				'illustration': 'Illustrator', 
				'identity': 'Identi...fier?',
				'chef': 'Home Cook'
			};
			return titleMap[slug] || 'Will Fifer';
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
			const BASE_WIDTH = 1200;

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
			this.transitionClass = this.projects.reduce((acc, { entryId }) => {
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
				this.transitionClass = this.projects.reduce((acc, { entryId }) => {
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
		nextProject () {
			const all = this.projects.slice();
			const index = all.findIndex(p => p.entryId === this.activeProject);
			const next = all.slice(index + 1)
				.find(p => p.featured);
			return next || this.projectsById[this.featuredIds[0]] || { title: '' };
		},
		prevProject () {
			const all = this.projects.slice().reverse();
			const index = all.findIndex(p => p.entryId === this.activeProject);
			const prev = all.slice(index + 1)
				.find(p => p.featured);
			return prev || this.projectsById[this.featuredIds[this.featuredIds.length - 1]] || { title: '' };
		},
		projectClass () {
			const p = this.projects.reduce((acc, { entryId }) => {
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
			return this.projects.reduce((acc, { entryId, title }) => {
				return { ...acc, [entryId]: title.replace(/the /i, '').slice(0, 1) };
			}, {});
		},
		fontSize () {
			const BASE_SIZE = 1080;

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
		projectBackgroundColor () {
			const currentProject = this.projects.find(p => p.entryId === this.activeProject);
			return currentProject ? currentProject.backgroundColor : '#fffff';
		},
		...mapState({
			activeProject: state => state.projects.active,
			lastProject: state => state.projects.last,
			selectedProject: state => state.projects.selected,
			direction: state => state.projects.direction,
			projectsById: state => state.projects.byId,
			projects: state => state.projects.all,
			featuredIds: state =>state.projects.featuredIds,
			currentCategory: state => state.projects.currentCategory,
			categories: state => state.projects.categories,
			viewport: state => state.app.window
		})
	}
};
</script>

<style src="../styles/components/icon-list.scss" lang="scss"></style>
<style src="../styles/components/projects.scss" lang="scss"></style>