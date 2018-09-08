<template>
	<component :is="tag" class="button-default" :class="buttonClass" :type="isButton ? 'button' : null" :tabindex="tabindex" :aria-label="isButton ? title : null" :title="isButton ? null : title" :href="isButton ? null : href" :target="newTab && !isButton ? '_blank' : null">
		<div class="button-icon" :data-label="label">
			<CategoryIcon :fontIcon="fontIcon" :style="getIconTransform" />

			<span v-if="text && text.length > 0" class="text">{{ text }}</span>
		</div>
	</component>
</template>

<script>
import CategoryIcon from '@/components/CategoryIcon';

export default {
	name: 'ButtonDefault',
	components: {
		CategoryIcon
	},
	props: {
		text: String,
		label: String,
		title: String,
		href: String,
		newTab: {
			type: Boolean,
			default: false
		},
		fontIcon: String,
		tag: {
			type: String,
			default: 'button'
		},
		buttonColor: {
			type: String,
			default: 'default'
		},
		tabindex: {
			type: Number,
			default: 0
		},
		iconTransform: Object,
		active: {
			type: Boolean,
			default: false
		}
	},
	computed: {
		buttonClass () {
			let classString = this.label && this.label.length > 0
				? '-with-label'
				: '';

			classString += this.text && this.text.length > 0
				? ' -with-text'
				: '';

			classString += this.active
				? ' -active'
				: '';

			classString += ` -color-${ this.buttonColor }`;

			return classString;
		},
		getIconTransform () {
			if (this.iconTransform) {
				let x = this.iconTransform.x;
				let y = this.iconTransform.y;

				return `transform: translate(${ x || 0 }, ${ y || 0 })`;
			}

			return null;
		},
		isButton () {
			return this.tag === 'button';
		}
	}
};
</script>

<style src="@/styles/components/button-default.scss" lang="scss"></style>