<template>
	<div>
		<!-- <SiteLogo class="site-logo"/> -->
		<Projects/>

		<ProjectContent/>
	</div>
</template>

<script>
// import SiteLogo from '../assets/svg/logo.svg';
import Projects from '../components/Projects';
import ProjectContent from '../components/ProjectContent';

export default {
	name: 'Home',
	components: {
		// SiteLogo,
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
