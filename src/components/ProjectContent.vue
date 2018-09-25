<template>
	<transition name="t-project-content">
	<section v-if="selected > -1" class="project-content">
		<div class="project-header">
			<div class="inner">
				<div class="categories">
					<span v-for="(cat, index) in project.categories">{{ cat.title }}  </span>
				</div>
			</div>
		</div>

		<div class="project-intro" v-if="project.intro">
			<div class="inner">
				<div v-html="currentProject.intro"></div>
			</div>
		</div>

		<div class="project-body">
			<div class="inner">
				<div v-for="(block, index) in pageContent" class="content-block" :key="index">
					<div v-if="block.type == 'wysiwyg'" v-html="block.body">
					</div>
				</div>
			</div>
		</div>
	</section>
	</transition>
</template>

<script>
import { mapState } from 'vuex';

export default {
	name: 'ProjectContent',
	data: function () {
		return {};
	},
	computed: {
		pageContent () {
			return this.project.pageContent;
		},
		...mapState({
			selected: state => state.projects.selected,
			project: state => state.projects.currentProject
		})
	}
};
</script>

<style src="@/styles/components/project-content.scss" lang="scss"></style>