<template>
	<ul class="category-buttons">
		<li v-for="(cat, i) in categories" class="list-item" :key="i">
			<ButtonDefault :round="true" :tabindex="tabindex" :label="cat.title" :title="`View projects in ${ cat.title }`" :icon="[cat.fontIconStyle || 'fas', cat.fontIcon]" @click.native="showCategory(cat)" :active="activeCategory && activeCategory === cat.id" />
		</li>
	</ul>
</template>

<script>
import { mapActions } from 'vuex';
import ButtonDefault from '@/components/ButtonDefault';

export default {
	name: 'CategoryButtons',
	components: {
		ButtonDefault
	},
	props: {
		categories: {
			type: Array,
			default: []
		},
		tabindex: {
			type: Number,
			default: 0
		},
		activeCategory: {
			type: String,
			default: null
		}
	},
	methods: {
		...mapActions([
			'showCategory'
		])
	}
};
</script>

<style src="../styles/components/projects.scss" lang="scss"></style>