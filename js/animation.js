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
			$('#charge').addClass('ocultar')
			resolve() // Resuelve la Promesa cuando la animación ha terminado
		}, 2300)
	})
}
