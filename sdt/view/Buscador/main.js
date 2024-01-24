$(() => {
	const form = $('#form-buscador')

	const dep = $('#select-UG')
	fetch('public.json')
		.then((response) => response.json())
		.then((data) => {
			addOption(data.department, dep)
		})
		.catch((error) => console.error('Error: ', error))

	function addOption(iterator, append) {
		iterator.forEach((element) => {
			const option = $('<option></option>')
			option.val(element.id).text(element.value)
			append.append(option)
		})
	}
	form.off('submit').on('submit', (event) => {
		event.preventDefault()

		const formData = new FormData(form[0])

		$.ajax({
			url: 'https://dgec.gob.ar/buscador/php/main.php?op=insert_cuadro',
			type: 'POST',
			data: formData,
			contentType: false,
			processData: false,
			statusCode: {
				404: function (jqXHR) {
					const errorResponse = JSON.parse(jqXHR.responseText)
					message(errorResponse)
				},
			},
			success: function (response) {
				message(response)
			},
			error: function (error) {
				// Handle Ajax request errors
				console.error(error)
			},
		})
	})

	function message(element) {
		Swal.fire({
			title: element.title,
			text: element.data,
			icon: element.icon,
			didClose: function () {
				form.trigger('reset')
			},
		})
	}
})
