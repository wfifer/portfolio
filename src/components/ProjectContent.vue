<template>
	<transition name="t-project">
	<section v-if="selected > -1" class="project-content" :class="$wait.waiting('ADD_PROJECT') ? '-loading' : null">
		<transition-group name="t-project-content">
		<article class="content" v-for="(project, index) in projects" :ref='`project-${ project.entryId }`' :key="project.entryId" v-if="index === selected">
			<div class="content-inner">
				<header class="project-header" v-if="index !== 0">
					<div class="inner">
						<h1 class="project-title">{{ project.title }}</h1>

						<div class="project-specs">
							<div class="project-spec" v-if="project.client && Object.keys(project.client).length > 0">
								<h2>Client</h2>

								<p>
									<a v-if="project.client.website && project.client.website.length > 0" :href="project.client.website" :title="`View website for ${ project.client.title }`" target="_blank">{{ project.client.title }}</a>

									<span v-else>{{ project.client.title }}</span>
								</p>
							</div>

							<div class="project-spec" v-if="project.website && project.website.length > 0">
								<h2>Website</h2>

								<p>
									<a :href="project.website" :title="`View website for ${ project.title }`" target="_blank" class="-overflow-ellipsis">
										<span class="text">{{ displayUrl(project.website) }}</span>
									</a>
								</p>
							</div>

							<div class="project-spec" v-if="project.collaborators && project.collaborators.length > 0">
								<h2>Credit</h2>

								<p v-for="collab in project.collaborators">
									<a :href="collab.website" :title="`View website for ${ collab.title }`" target="_blank">{{ collab.title }}</a>
								</p>
							</div>
						</div>
					</div>
				</header>

				<div class="project-intro" v-if="project.intro && project.intro.length > 0">
					<div class="inner">
						<div v-html="project.intro"></div>
					</div>
				</div>

				<div class="project-body" v-if="project.pageContent && project.pageContent.length > 0">
					<div class="inner">
						<div v-for="(block, index) in project.pageContent" class="content-block" :key="index">
							<div v-if="block.type === 'wysiwyg'" v-html="block.body">
							</div>
						</div>
					</div>
				</div>

				<footer class="project-footer">
					<ul class="social-links">
						<ButtonDefault :reverse="true" class="btn" font-icon="linkedin" />
					</ul>
				</footer>
			</div>
		</article>
		</transition-group>
	</section>
	</transition>
</template>

<script>
import { mapState } from 'vuex';
import ButtonDefault from '@/components/ButtonDefault';

export default {
	name: 'ProjectContent',
	components: {
		ButtonDefault
	},
	data: function () {
		return {};
	},
	computed: {
		pageContent () {
			return this.project.pageContent;
		},
		...mapState({
			selected: state => state.projects.selected,
			projects: state => state.projects.projects
		})
	},
	mounted () {
	},
	methods: {
		updateLinkBorder () {
			let project = this.projects[this.selected];

			let $loaderStyle = document.getElementById('project-loader-style');
			if ($loaderStyle) {
				$loaderStyle.parentNode.removeChild($loaderStyle);
			}

			let createLinkStyle = () => {
				const getLuminanceFromHex = (color) => {
					let rgb = parseInt(color.replace('#', ''), 16);
					let r = rgb >> 16 & 255;
					let g = rgb >> 8 & 255;
					let b = rgb & 255;

					let a = [r, g, b].map(function (v) {
						v /= 255;
						return v <= 0.03928
							? v / 12.92
							: Math.pow((v + 0.055) / 1.055, 2.4);
					});
					return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
				};

				let luminance = getLuminanceFromHex(project.heroBackground.stops[0].color);
				let stop = luminance > 0.5 ? 1 : 0;
				let color = project.heroBackground.stops[stop].color;

				let rule = `.portfolio:not(.-hide-hover) a:hover, .-show-focus a:focus, .-hide-hover a:active { border-bottom-color: ${ color } } .project-spec a::after { color: ${ color } }`;
				let $style = document.createElement('style');
				let txtNode = document.createTextNode(rule);
				$style.append(txtNode);
				this.$refs[`project-${ project.entryId }`][0].append($style);
			};

			let createLoaderStyle = () => {
				let stops = project.heroBackground.stops.slice(0, 2);
				let gradient = 'to right';

				stops.forEach((stop, i) => {
					gradient += `, ${ stop.color } ${ 20 + i * 60 }%`;
				});

				let rule = `.project-content::before { background: linear-gradient(${ gradient }) }`;
				let $style = document.createElement('style');
				$style.id = 'project-loader-style';
				let txtNode = document.createTextNode(rule);
				$style.append(txtNode);
				this.$el.append($style);
			};

			this.$nextTick()
				.then(() => {
					createLinkStyle();
					createLoaderStyle();
				});
		},
		displayUrl (url) {
			return url ? url.replace(/https*:\/\/|\/$|www\./g, '').split('/')[0] : '';
		}
	},
	watch: {
		selected: {
			handler: function (newProject, oldProject) {
				if (this.selected >= 0) {
					this.$nextTick()
						.then(() => {
							this.updateLinkBorder();
						});
				}
			},
			deep: true
		}
	}
};
</script>

<style src="@/styles/components/project-content.scss" lang="scss"></style>