<template>
	<transition name="t-project">
	<section v-if="selected !== null" class="project-content" :class="$wait.waiting('ADD_PROJECT') ? '-loading' : null">
		<transition-group name="t-project-content">
		<article class="content" :ref='`project-${ project.entryId }`' :key="project.entryId">
			<div class="content-inner">
				<header class="project-header">
					<div class="inner">
						<h1 class="project-title">{{ project.title }}</h1>

						<div class="project-specs">
							<div class="project-spec" v-if="project.client && Object.keys(project.client).length > 0">
								<h2>Client</h2>

								<p>
									<span v-if="project.client.website && project.client.website.length > 0">
										<a :href="project.client.website" :title="`View website for ${ project.client.title }`" target="_blank">
											<span class="text">{{ project.client.title }}</span>

											<span class="link-icon">
												<Icon :icon="['far', 'external-link']" />
											</span>
										</a>
									</span>

									<span v-else>{{ project.client.title }}</span>
								</p>
							</div>

							<div class="project-spec" v-if="project.website && project.website.length > 0">
								<h2>Website</h2>

								<p>
									<a :href="project.website" :title="`View website for ${ project.title }`" target="_blank" class="-overflow-ellipsis">
										<span class="text">{{ displayUrl(project.website) }}</span>
										<div class="link-icon">
											<Icon :icon="['far', 'external-link']" />
										</div>
									</a>
								</p>
							</div>

							<div class="project-spec" v-if="project.collaborators && project.collaborators.length > 0">
								<h2>Credit</h2>

								<p v-for="(collab, index) in project.collaborators" :key="index">
									<span v-if="collab.website && collab.website.length > 0">
										<a :href="collab.website" :title="`View website for ${ collab.title }`" target="_blank">
											<span class="text">{{ collab.title }}</span>

											<span class="link-icon">
												<Icon :icon="['far', 'external-link']" />
											</span>
										</a>
									</span>

									<span v-else>{{ collab.title }}</span>
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
							<div v-if="block.type === 'wysiwyg'" v-html="block.body" class="block">
							</div>
						</div>
					</div>
				</div>

				<footer class="project-footer">
					<ul class="social-list list">
						<li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="https://www.linkedin.com/in/will-fifer/" :reverse="true" class="btn" :icon="['fab', 'linkedin-in']" />
						</li>

						<li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="https://www.behance.net/wfifer" :reverse="true" class="btn" :icon="['fab', 'behance']" />
						</li>

						<li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="mailto:wfifer@gmail.com" :reverse="true" class="btn" icon="envelope" />
						</li>
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
import Icon from '@/components/Icon';

export default {
	name: 'ProjectContent',
	components: {
		ButtonDefault,
		Icon
	},
	data: function () {
		return {};
	},
	computed: {
		project () {
			return this.projectsById[this.selected];
		},
		pageContent () {
			return this.project.pageContent;
		},
		...mapState({
			selected: state => state.projects.selected,
			projectsById: state => state.projects.byId,
			projects: state => state.projects.all
		})
	},
	mounted () {
	},
	methods: {
		updateLinkBorder () {
			let project = this.projectsById[this.selected];

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

				let rule = `.portfolio:not(.-hide-hover) a:hover, .-show-focus a:focus, .-hide-hover a:active { border-bottom-color: ${ color } } .project-spec a .link-icon { color: ${ color } }`;
				let $style = document.createElement('style');
				let txtNode = document.createTextNode(rule);
				$style.append(txtNode);
				this.$refs[`project-${ project.entryId }`].append($style);
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
				if (this.selected) {
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