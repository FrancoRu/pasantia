$(document).ready(function () {
	const department = $('#department')
	const survey = $('#theme')
	const listTheme = $('#quadro')
	const censo_anio = $('#censo')
	function surveys(data) {
		const surveyModules = data.modules
		addOption(surveyModules, survey)
	}

	//Carga de año
	function anio(data) {
		const censos = data.censos
		addOption(censos, censo_anio)
	}

	//Carga de jurisdicciones
	function jurisdicciones(data) {
		const selectedYear = censo_anio.val()
		const departments =
			selectedYear === '2022'
				? data.departments.filter((element) => element.value === 'Entre Rios')
				: data.departments.filter((element) => element.value !== 'Entre Rios')
		addOption(departments, department)
	}

	//Carga de temas
	function themes(data) {
		const module = survey.val()
		const theme = data.modules.find((element) => element.value === module).tema
		addOption(theme, listTheme)
	}

	// Agregar opciones a los select
	function addOption(iterator, append) {
		iterator.forEach((element) => {
			const option = $('<option></option>')
			option.val(element.value).text(element.value)
			append.append(option)
		})
	}

	// Remover los hijos anteriores
	function removeChild(parentElement) {
		parentElement.empty()
	}

	// Inicio de script
	function init() {
		data = JSON.parse(localStorage.getItem('data'))
		anio(data)
		jurisdicciones(data)
		surveys(data)
		themes(data)
	}

	// Cargar la escucha de eventos de cambio
	survey.on('change', function (event) {
		event.preventDefault()
		removeChild(listTheme)
		data = localStorage.getItem('data')
		themes(JSON.parse(data))
	})

	censo_anio.on('change', function (event) {
		event.preventDefault()
		removeChild(department)
		data = localStorage.getItem('data')
		jurisdicciones(JSON.parse(data))
	})
	init()
})
