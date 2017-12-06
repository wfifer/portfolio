<template>
	<section class="site-header" @mousemove="onMouseMove">
		<div class="inner">
			<div v-for="(project, index) in projects" class="project-mask" :class="{ '-active': index == activeProject }" :key="index">
				<div class="mask-inner">
					<div class="mask-svg">
						<svg x="0px" y="0px" viewBox="0 0 800 800" style="enable-background:new 0 0 800 800;" xml:space="preserve">
					 		<defs>
								<linearGradient :id="`gradient-bg-${ index }`" x1="0%" y1="0%" x2="100%" y2="0%">
									<stop v-for="(stop, stopIndex) in project.heroBackground.stops" :offset="`${ stop.position }%`" :key="stopIndex" :stop-color="stop.color"/>
								</linearGradient>
							</defs>

							<mask maskUnits="userSpaceOnUse" x="-446" y="-61" width="1822.8" height="968" :id="`text-mask-${ index }`">
								<g class="text-mask">
									<text transform="matrix(1 0 0 1 400 758.3994)" text-anchor="middle">{{ projectInitial[index] }}</text>
								</g>
							</mask>

							<g :style="`mask: url(#text-mask-${ index });`">
								<rect x="-446" y="-33" width="1728" height="940" style="fill: white" />

								<rect x="400" y="400" width="1500" height="1500" :style="gradientTransform[index]" />

								<g class="project-hero" :style="backgroundPosition">
									<image width="800" height="800" style="overflow:visible;" :xlink:href="project.heroImage.url" x="400" y="400"></image>
								</g>

								<rect x="400" y="400" width="1500" height="1500" :style="'mix-blend-mode: hue; opacity: 0.5; ' + gradientTransform[index]" />
							</g>

							<text @click="index == 0 ? enterAbout : enterProject" transform="matrix(1 0 0 1 400 758.3994)" text-anchor="middle" style="fill: transparent">{{ projectInitial[index] }}</text>
						</svg>
					</div>
				</div>

				<div class="project-info">
					<h2 class="project-title" @click="index == 0 ? enterAbout : enterProject" v-html="titleHtml[index]"></h2>
				</div>

				<nav class="project-nav">
					<button @click="navigateProjects(-1)" type="button" class="btn nav-item nav-prev"></button>

					<button @click="navigateProjects(1)" type="button" class="btn nav-item nav-next"></button>

					<div :style="backgroundPosition"></div>
				</nav>
			</div>

		</div>
	</section>
</template>

<script>
import { mapState, mapActions } from 'vuex';

export default {
	name: 'Projects',
	mounted () {
		this.getProjects();
	},
	methods: {
		enterAbout () {
			console.log('about');
		},
		enterProject () {
			console.log('project');
		},
		onMouseMove (e) {
			const mouse = {
				x: e.pageX,
				y: e.pageY
			};

			this.updateProjectMouse(mouse);
		},
		...mapActions([
			'navigateProjects',
			'getProjects',
			'updateProjectMouse'
		])
	},
	computed: {
		gradientTransform () {
			return this.projects.map(function (project, index) {
				return `fill: url(#gradient-bg-${ index }); transform: ${ project.heroBackground.angle.length ? 'rotate(' + project.heroBackground.angle + ')' : '' } translate(-50%, -50%)`;
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
		backgroundPosition () {
			const x = (this.window.width / 2 - this.mouse.x) / this.window.width * 50;
			const y = (this.window.width / 2 - this.mouse.y) / this.window.width * 50;

			return `transform: translate3d(${ x }px, ${ y }px, 0)`;
		},
		...mapState({
			activeProject: state => state.projects.active,
			projects: state => state.projects.projects,
			mouse: state => state.projects.mouse,
			window: state => state.app.window
		})
	}
};
</script>

<style src="../styles/components/projects.scss" lang="scss"></style>