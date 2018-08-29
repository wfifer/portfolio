<template>
	<div>
		<Projects />

		<CategoryThumbnails />
	</div>
</template>

<script>
import Projects from '../components/Projects';
import CategoryThumbnails from '../components/CategoryThumbnails';
// import ProjectContent from '../components/ProjectContent';

export default {
	name: 'Home',
	components: {
		Projects,
		CategoryThumbnails
		// ProjectContent
	}
};
</script>
