<template>
	<font-awesome-icon :icon="icon" />
</template>

<script>

export default {
	name: 'Icon',
	props: {
		icon: String | Array
	}
};

</script>