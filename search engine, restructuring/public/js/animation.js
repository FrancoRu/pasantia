const svgs = document.querySelectorAll('.svg-item')

function startAnimation() {
	return new Promise((resolve) => {
		svgs.forEach((svg, index) => {
			anime({
				targets: svg,
				opacity: 1,
				translateX: 0,
				duration: 1500,
				delay: index * 200,
			})
		})
		setTimeout(() => {
			$('#charge').addClass('hidden')
			$('#content-charge').addClass('hidden')
			$('#img-static').removeClass('hidden')
			resolve()
		}, 2300)
	})
}
