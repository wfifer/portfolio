<template>
	<transition name="t-project">
	<section v-if="selected !== null" class="project-content" :class="$wait.waiting('ADD_PROJECT') ? '-loading' : null">
		<transition-group name="t-project-content">
		<article class="content" :ref='`project-${ project.entryId }`' :key="project.entryId">
			<div class="content-inner">
				<header class="project-header">
					<div class="inner">
						<h1 class="project-title">{{ project.title }}</h1>
						
						<div class="project-intro" v-if="project.intro && project.intro.length > 0">
							<div v-html="typogrify(project.intro)"></div>
						</div>

						<div class="project-specs"
							 v-if="project.client && Object.keys(project.client).length > 0
							 || project.website && project.website.length > 0
							 || project.app && project.app.length > 0
							 || project.collaborators && project.collaborators.length > 0" :style="`--color-project: ${color}`">
							<div class="project-spec" v-if="project.app && project.app.length > 0" aria-label="App">
								<Icon :icon="['far', 'mobile-screen-button']" class="icon" title="App" />

								<p>
									<span>
										<a :href="project.app" :title="`View app for ${ project.title }`" target="_blank" class="-overflow-ellipsis">
											<span class="text">App</span>
											<div class="link-icon">
												<Icon :icon="['far', 'external-link']" />
											</div>
										</a>
									</span>
								</p>
							</div>

							<div class="project-spec" v-if="project.website && project.website.length > 0" aria-label="Website">
								<Icon :icon="['far', 'browser']" class="icon" title="Website" />

								<p>
									<span>
										<a :href="project.website" :title="`View website for ${ project.title }`" target="_blank" class="-overflow-ellipsis">
											<span class="text">Website</span>
											<div class="link-icon">
												<Icon :icon="['far', 'external-link']" />
											</div>
										</a>
									</span>
								</p>
							</div>

							<div class="project-spec" v-if="project.client && Object.keys(project.client).length > 0" aria-label="for">
								<Icon :icon="['far', 'building']" class="icon" title="Client" />

								<p>
									<span v-if="project.client.website && project.client.website.length > 0">
										<a :href="project.client.website" :title="`View website for ${ project.client.title }`" target="_blank" class="-overflow-ellipsis">
											<span class="text">{{ project.client.title }}</span>

											<span class="link-icon">
												<Icon :icon="['far', 'external-link']" />
											</span>
										</a>
									</span>

									<span v-else>{{ project.client.title }}</span>
								</p>
							</div>

							<div class="project-spec" v-if="project.collaborators && project.collaborators.length > 0" aria-label="in collaboration with">
								<Icon :icon="['far', 'hands-helping']" class="icon" title="Collaborator" />

								<p v-for="(collab, index) in project.collaborators" :key="index">
									<span v-if="collab.website && collab.website.length > 0">
										<a :href="collab.website" :title="`View website for ${ collab.title }`" target="_blank" class="-overflow-ellipsis">
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

						<!-- <hr /> -->
					</div>
				</header>
				

				<div class="project-body" v-if="project.intro && project.intro.length || project.pageContent && project.pageContent.length">
					<div class="inner">
						<div v-for="(block, index) in project.pageContent" class="content-block" :key="index">
							<div v-if="block.type === 'wysiwyg'" v-html="block.data.body" class="block wysiwyg">
							</div>
							<div v-else-if="block.type === 'projects'" class="block block-projects">
								<div v-for="entry in block.data.projects" :key="entry.entryId" 
									class="block-project"
									:style="{ background: getGradient(entry.heroBackground.stops )}"
								>
									<div class="project-bg" 
										:style="{
											backgroundImage: `url('${entry.heroImage.url}')`
										}"
									/>
									<h2 class="text">{{ entry.title }}</h2>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="project-tags">
					<div class="inner">
						<span class="label">Tags</span>
						<CategoryButtons 
							:categories="project.categories" 
							class="icon-list icon-list-categories"
							:asText="true"
						/>
					</div>
				</div>

				<footer class="project-footer">
					<div class="dots">
						<div v-for="i in 5" :style="{ background: color }" :key="i" class="dot" />
					</div>

					<ul class="social-list list">
						<li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="https://www.linkedin.com/in/will-fifer/" class="btn" :icon="['fab', 'linkedin-in']" />
						</li>

						<!-- <li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="https://www.behance.net/wfifer" :reverse="true" class="btn" :icon="['fab', 'behance']" />
						</li> -->

						<li class="list-item">
							<ButtonDefault target="_blank" tag="a" href="mailto:wfifer@gmail.com" class="btn" icon="envelope" />
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
import CategoryButtons from '@/components/CategoryButtons';
import ButtonDefault from '@/components/ButtonDefault';
import Icon from '@/components/Icon';

const typogrify = text => {
	const parts = text.split(' ');
	return parts.reduce((acc, part, index) => `${ acc }${ index >= parts.length - 1 ? '&nbsp;' : ' ' }${ part }`, '');
};

const getLuminanceFromHex = color => {
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

export default {
	name: 'ProjectContent',
	components: {
		ButtonDefault,
		CategoryButtons,
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
		color () {
			let luminance = getLuminanceFromHex(this.project.heroBackground.stops[0].color);
			let stop = luminance > 0.5 ? 1 : 0;
			return this.project.heroBackground.stops[stop].color;
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
		typogrify (text) {
			return typogrify(text);
		},
		getGradient (stops) {
			// let angle = project.heroBackground.angle;
			let angle = '37deg';

			let gradient = angle && angle.length
				? angle
				: 'to right';

			console.log(stops);

			stops.forEach((stop, i) => {
				gradient += `, ${ stop.color } ${ stop.position }%`;
			});

			return `linear-gradient(${ gradient }`;
		},
		updateLinkBorder () {
			let project = this.projectsById[this.selected];

			let $loaderStyle = document.getElementById('project-loader-style');
			if ($loaderStyle) {
				$loaderStyle.parentNode.removeChild($loaderStyle);
			}

			let createLinkStyle = () => {
				let rule = 
					`.portfolio:not(.-hide-hover) a:hover,
					.-show-focus a:focus, 
					.-hide-hover a:active { 
						border-bottom-color: ${ this.color } 
					} 
					.project-spec a .link-icon { 
						color: ${ this.color } 
					}
					.project-content hr {
						border-color: ${ this.color }
					}
					.wysiwyg ul li::before {
						background: ${ this.color };
					}
					.project-tags .btn:hover {
						background: ${ this.color };
						box-shadow: 0 0 0 1px ${ this.color } inset;
						color: white;
					}
					`;
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