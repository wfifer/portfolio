<template>
	<div>
		<Projects />

		<CategoryThumbnails />

		<div class="page-container" :class="selected >= 0 ? '-active' : null">
			<ProjectContent />
		</div>
	</div>
</template>

<script>
import { mapState } from 'vuex';
import Projects from '@/components/Projects';
import CategoryThumbnails from '@/components/CategoryThumbnails';
import ProjectContent from '@/components/ProjectContent';

export default {
	name: 'Home',
	components: {
		Projects,
		CategoryThumbnails,
		ProjectContent
	},
	computed: {
		...mapState({
			selected: state => state.projects.selected
		})
	}
};
</script>
