<template>
	<div>
		<!-- <SiteLogo class="site-logo"/> -->
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

<style scoped>
.site-logo {
	width: 300px;
}
</style>
