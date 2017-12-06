<template>
	<div>
		<!-- <SiteLogo class="site-logo"/> -->
		<Projects/>
	</div>
</template>

<script>
// import SiteLogo from '../assets/svg/logo.svg';
import Projects from '../components/Projects';

export default {
	name: 'HelloWorld',
	components: {
		// SiteLogo,
		Projects
	}
};
</script>

<style scoped>
.site-logo {
	width: 300px;
}
</style>
