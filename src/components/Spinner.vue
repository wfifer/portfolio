<template>
	<div class="spinner">
		<svg class="spinner-icon" x="0px" y="0px" viewBox="0 0 200 200" style="enable-background: new 0 0 100 100" xml:space="preserve">
			<defs>
				<linearGradient id="spinner-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
					<stop data-v-1d558ce8="" offset="10%" stop-color="#9822ff"></stop>
					<stop data-v-1d558ce8="" offset="80%" stop-color="#0065ff"></stop>
				</linearGradient>
			</defs>

			<text x="50%" y="65%" class="text" style="stroke: url('#spinner-gradient')">W</text>
		</svg>
	</div>
</template>

<script>
	export default {
		name: 'Spinner'
	};
</script>

<style src="@/styles/components/spinner.scss" lang="scss" scoped></style>