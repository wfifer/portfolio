<template>
	<div>
		<!-- <SiteLogo class="site-logo"/> -->
		<Projects/>

		<ProjectContent/>
	</div>
</template>

<script>
import Projects from '../components/Projects';
import ProjectContent from '../components/ProjectContent';

export default {
	name: 'Home',
	components: {
		Projects,
		ProjectContent
	}
};
</script>

<style scoped>
.site-logo {
	width: 300px;
}
</style>
