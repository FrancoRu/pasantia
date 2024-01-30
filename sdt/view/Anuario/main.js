$(function () {
	const chapter = $('#chapters')
	const subChapters = $('#subChapters')
	const changes = $('#optionChanges')
	const actions = $('#action_id')
	const form = $('#form')

	// const message = $('#message')
	localStorage.clear()
	modifiedJSON()
	//traer datos para ingresar cuadros

	fetch('ingresar.json')
		.then((response) => response.json())
		.then((data) => {
			localStorage.setItem('data-ingress', JSON.stringify(data))
			handleActionChange()
			setForm(false)
		})
		.catch((error) => console.error('Error fetching data:', error))

	//traer datos para modificar cuadros

	function modifiedJSON() {
		fetch('modificar.json')
			.then((response) => response.json())
			.then((data) => {
				// localStorage.clear()
				if (data && Object.keys(data).length !== 0) {
					setForm(false)
					localStorage.setItem('data-modified', JSON.stringify(data))

					chargeChapters(data.chapter)
					chargeSubChapters(data.chapter[0].subchapter)
					if (actions.val() == 0) {
						addSelectQuadro()
					}
				} else {
					setForm(true)
				}
			})
			.catch((error) => {
				setForm(true)
				console.error('Error fetching data:', error)
			})
	}
	// modifiedJSON()

	//Funcion para cambiar logos y direccionamiento

	$(document).on('click', '#btnsoporte', () => {
		if (actions.val() == 0) {
			setForm(false)
			$('#lbltitulo').html('Ingreso de cuadro')
			$('#btnsoporte').html('Actualizar cuadro')
			actions.val(1)
			$('#imgtipo').attr('src', '../../public/img/storage.svg')
		} else {
			$('#lbltitulo').html('Actualizar cuadro')
			$('#btnsoporte').html('Ingreso de cuadro')
			actions.val(0)
			$('#imgtipo').attr('src', '../../public/img/update.svg')
		}
		handleActionChange()
	})

	//Manejador de cambio de informacion

	function handleActionChange() {
		removeChild(changes)
		if (actions.val() == 0) {
			modifiedJSON()
			addFiles('data-modified')
			subChapters.off('change').on('change', addSelectQuadro)
		} else {
			addFiles('data-ingress')
			subChapters.off('change')
			addInputText()
		}
		// handleSubmit(path)
	}
	//Envio de data
	form.off('submit').on('submit', (event) => {
		event.preventDefault()
		const formData = new FormData(form[0])

		path = actions.val() == 0 ? 'update' : 'insert'
		$.ajax({
			url: `../../controller/anuario.php?op=${path}`,
			type: 'POST',
			data: formData,
			contentType: false,
			processData: false,
			statusCode: {
				400: function (jqXHR) {
					const errorResponse = JSON.parse(jqXHR.responseText)
					messages('Error!!', errorResponse.message, 'error')
				},
				403: function (jqXHR) {
					const errorResponse = JSON.parse(jqXHR.responseText)
					messages('Error!!', errorResponse.message, 'error')
				},
				404: function (jqXHR) {
					const errorResponse = JSON.parse(jqXHR.responseText)
					messages('Error!!', errorResponse.message, 'error')
				},
				500: function (jqXHR) {
					const errorResponse = JSON.parse(jqXHR.responseText)
					messages('Error!!', errorResponse.message, 'error')
				},
			},
			success: function (data) {
				try {
					const res = JSON.parse(data)
					messages('Exito!!', res.message, 'success')
					modifiedJSON()
					consult()
				} catch (error) {
					messages('ERROR INTERNO', error, 'error')
				}
			},
		})
	})

	//Mostrar cartel de repuesta
	function messages(title, data, icon) {
		Swal.fire({
			title: title,
			text: data,
			icon: icon,
			didClose: function () {
				form.trigger('reset')
			},
		})
	}
	//Manejadores de cambio de los select

	chapter.on('change', handleChapterChange)

	function handleChapterChange() {
		const value = actions.val() > 0 ? 'data-ingress' : 'data-modified'
		const data = JSON.parse(localStorage.getItem(value))
		const index = findIndexJSON(data.chapter, chapter.val())
		chargeSubChapters(data.chapter[index].subchapter)
		if (value === 'data-modified') addSelectQuadro()
	}

	function addSelectQuadro() {
		removeChild(changes)
		const inputSelect = $(
			'<div class="form-group"><label for="quadros">Codigo de cuadro: </label><select id="quadros" name="quadro" class="form-control"></select></div>'
		)
		const inputTitleSelect = $(
			'<div class="form-group"><label for="titles">Titulo: </label><select id="titles" name="title" class="form-control"></select></div>'
		)
		changes.append(inputSelect)
		changes.append(inputTitleSelect)
		const data = JSON.parse(localStorage.getItem('data-modified'))
		const index = findIndexJSON(data.chapter, chapter.val())
		const indexSubChapter = findIndexJSON(
			data.chapter[index].subchapter,
			subChapters.val()
		)
		addOption(
			data.chapter[index].subchapter[indexSubChapter].quadro,
			$('#quadros')
		)

		$('#quadros')
			.off('change')
			.on('change', () => {
				eventSelect(data.chapter[index].subchapter[indexSubChapter].quadro)
			})
		eventSelect(data.chapter[index].subchapter[indexSubChapter].quadro)
	}

	function eventSelect(element) {
		const quadros = $('#quadros')
		removeChild($('#titles'))
		if (quadros.val() !== '') {
			const index = findIndexJSON(element, quadros.val())
			addOption(element[index].title, $('#titles'))
		}
	}

	function addInputText() {
		const inputQuasdro = $(
			'<div class="form-group"><label for"quadro">Codigo de cuadro: </label> <input name="quadro" type="number" min="1" max="100" value="1" class="form-control clean" required /></div>'
		)
		const inputTitulo = $(
			'<div class="form-group"><label for="title">Titulo: </label><input name="title" type="text" class="form-control clean" placeholder="Ingrese el titulo" required /></div>'
		)
		changes.append(inputQuasdro, inputTitulo)
	}

	//Funciones de carga
	function addFiles(file) {
		const data = JSON.parse(localStorage.getItem(file))
		chargeChapters(data.chapter)
		chargeSubChapters(data.chapter[0].subchapter)
	}

	function chargeChapters(data) {
		removeChild(chapter)
		addOption(data, chapter)
	}

	function chargeSubChapters(data) {
		removeChild(subChapters)
		addOption(data, subChapters)
	}

	//Funciones generales

	function findIndexJSON(contain, val) {
		return contain.findIndex((element) => element.value == val)
	}

	function addOption(iterator, append) {
		iterator.forEach((element) => {
			const option = $('<option></option>')
			option.val(element.value).text(element.description)
			append.append(option)
		})
	}

	function removeChild(element) {
		element.empty()
	}

	function setForm(band) {
		chapter.attr({
			disabled: band,
		})
		subChapters.attr({
			disabled: band,
		})
		$('#file').attr({
			disabled: band,
		})
		$('#btn-submit')
			.attr({
				disabled: band,
			})
			.css('display', band ? 'none' : 'block')
	}
})
