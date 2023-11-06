$(document).ready(function () {
	$('.accordion-title').click(function () {
		var $item = $(this).parent()

		if (!$item.hasClass('active')) {
			$('.accordion-item').removeClass('active')
			$item.addClass('active')
			$('.accordion-content').slideUp()
			$item.find('.accordion-content').slideDown()

			$('.toggle-icon').text('+') // Cambia todos los íconos a "+"
			$item.find('.toggle-icon').text('-') // Cambia el ícono del elemento actual a "-"
		} else {
			$('.toggle-icon').text('+')
			$item.removeClass('active')
			$item.find('.accordion-content').slideUp()
		}
	})
})
