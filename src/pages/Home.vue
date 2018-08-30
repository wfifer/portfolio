<template>
	<div>
		<Projects />

		<CategoryThumbnails />
	</div>
</template>

<script>
import Projects from '../components/Projects';
import CategoryThumbnails from '../components/CategoryThumbnails';

export default {
	name: 'Home',
	components: {
		Projects,
		CategoryThumbnails
	}
};
</script>
