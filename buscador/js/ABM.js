$(document).ready(function () {
	$('.svg-item').css('opacity', 0)

	const selects = $('select')
	const url = 'buscador/../php/main.php/form?'

	const btnAdd = $('#btn_add')
	const btnModify = $('#btn_modify')
	// Función para agregar opciones a un select
	function addOption(iterator, index) {
		for (let i = index; i < selects.length; i++) {
			selects.eq(i).addClass('hidden').children(':not(.keep)').remove()
		}

		selects.eq(index).removeClass('hidden')

		iterator.forEach((element) => {
			const option = $('<option>', {
				value: element.value,
				text: element.value,
			})
			selects.eq(index).append(option)
		})
		$('#File').addClass('hidden')
		btnAdd.addClass('hidden')
	}

	// Función para manejar eventos de cambio en los select
	function addEvents(iterator) {
		iterator.each(function (index, element) {
			$(element).on('change', function (event) {
				event.preventDefault()

				$('.svg-item').css('opacity', 0)
				const newUrl =
					url +
					selects
						.slice(0, selects.index(this) + 1)
						.map(function () {
							return $(this).attr('name') + '=' + $(this).val()
						})
						.get()
						.join('&')

				fetch(newUrl)
					.then((response) => response.json())
					.then((data) => {
						if (!data.response) {
							$.notify(data.message, 'warn')
							return
						}
						startAnimation().then(() => {
							addOption(data.data.value, index + 1)
							selects.eq(index + 1).removeClass('hidden')

							$.notify(data.message, 'success')
						})
					})
					.catch((error) => console.error('Error', error))
			})
		})
	}

	selects.eq(selects.length - 1).on('change', function (event) {
		fetch()
		$('.svg-item').css('opacity', 0)
		startAnimation().then(() => {
			event.preventDefault()
			$('#File').removeClass('hidden')
			$('.div-check').removeClass('hidden')
			$.notify('Consultation Completed Successfuly', 'success')
		})
	})

	$('#File').on('change', function (event) {
		event.preventDefault()
		btnAdd.removeClass('hidden')
	})

	fetch(url)
		.then((response) => response.json())
		.then((data) => {
			if (!data.response) {
				$.notify(data.message, 'warn')
				return
			}
			addOption(data.data.value, 0)
			addEvents(selects.slice(0, -1))
		})
		.catch((error) => console.error('Error', error))
	
	
})
