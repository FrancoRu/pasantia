$(document).ready(function () {
	$('.svg-item').css('opacity', 0)
	const censo = $('#select-censo')
	const department = $('#select-UG')
	const theme = $('#select-UR')
	const quadro = $('#select-Theme')
	const title = $('#select-Title')

	const arrayEvents = [censo, department, theme, quadro]

	const selects = $('select')
	const url = 'buscador/../php/main.php/form?'

	const btnAdd = $('#btn_add')
	const btnModify = $('#btn_modify')
	// Función para agregar opciones a un select
	function addOption(iterator, parent) {
		parent.children(':not(.keep)').remove()
		const select = $(parent)

		iterator.forEach((element) => {
			const option = $('<option></option>', {
				value: element.value,
				text: element.value,
			})
			select.append(option)
		})
	}

	// Función para manejar eventos de cambio en los select
	function addEvents(iterator) {
		iterator.forEach((element, index) => {
			element.on('change', function (event) {
				event.preventDefault()

				$('.svg-item').css('opacity', 0)
				// Construir la URL actualizando todos los parámetros hasta el select actual
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
						startAnimation().then(() => {
							if (index !== arrayEvents.length - 1) {
								addOption(data.value, arrayEvents[index + 1])
								arrayEvents[index + 1].removeClass('hidden')
							} else {
								addOption(data.value, title)
								title.removeClass('hidden')
							}
						})
					})
					.catch((error) => console.error('Error', error))
			})
		})
	}

	title.on('change', (event) => {
		event.preventDefault()

		$('.svg-item').css('opacity', 0)
		startAnimation().then(() => {
			btnAdd.removeClass('hidden')
		})
	})

	fetch(url)
		.then((response) => response.json())
		.then((data) => {
			console.log(data)
			addOption(data.value, arrayEvents[0])
			addEvents(arrayEvents)
		})
		.catch((error) => console.error('Error', error))
})
