<template>
	<div class="spinner">
		<svg class="spinner-icon" x="0px" y="0px" :viewBox="`0 0 ${ width } ${ height }`" :style="`enable-background: new 0 0 ${ width } ${ height }`" :width="width" :height="height" xml:space="preserve">
			<defs>
				<linearGradient id="spinner-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
					<stop data-v-1d558ce8="" offset="10%" stop-color="#9822ff"></stop>
					<stop data-v-1d558ce8="" offset="80%" stop-color="#0065ff"></stop>
				</linearGradient>

				<clipPath clipPathUnits="userSpaceOnUse" id="spinner-clip">
					<text class="text" :x="width / 2" :y="height / 2" :style="`font-size: ${ fontSize }px;`" text-anchor="middle">W</text>
				</clipPath>
			</defs>

			<text class="text text-stroke" :x="width / 2" :y="height / 2" style="stroke: url('#spinner-gradient')" :style="`font-size: ${ fontSize }px;`" text-anchor="middle">W</text>
		</svg>

		<img class="spinner-gif" :src="require('@/assets/img/spinner.gif')" title="Loading..." alt="Loading" />
	</div>
</template>

<script>
	export default {
		name: 'Spinner',
		props: {
			width: {
				default: 200,
				type: Number
			},
			height: {
				default: 200,
				type: Number
			},
			fontSize: {
				default: 100,
				type: Number
			}
		}
	};
</script>

<style src="@/styles/components/spinner.scss" lang="scss" scoped></style>