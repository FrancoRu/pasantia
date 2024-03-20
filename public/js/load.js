$(document).ready(function () {
	const department = $('#department')
	const survey = $('#theme')
	const listTheme = $('#quadro')
	const censo_anio = $('#censo')

	function chargeData() {
		localStorage.removeItem('body-form')
		localStorage.removeItem('data')
		const url = 'buscador/../public.json'
		fetch(url, {
			method: 'GET'
		})
			.then((response) => response.json())
			.then((data) => {
				localStorage.setItem('data', JSON.stringify(data))
				init()
			})
			.catch((error) => {
				console.error('Error', error)
			})
	}
	//Carga de unidad de relevamiento
	function surveys(data) {
		const selectedYear = censo_anio.val()
		const selectedDepa = department.val()
		const indexYear = findIndexP(data['censos'], selectedYear)
		const indexDep = findIndexP(
			data['censos'][indexYear].departments,
			selectedDepa
		)
		const surveyModules =
			data['censos'][indexYear]['departments'][indexDep].themes
		sortSelect(surveyModules)
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
		const indexYear = findIndexP(data['censos'], selectedYear)
		console.log(indexYear)
		const departments = data['censos'][indexYear].departments
		sortSelect(departments)
		addOption(departments, department)
	}

	//Carga de temas
	function themes(data) {
		const selectedYear = censo_anio.val()
		const selectedDepa = department.val()
		const selectedTheme = survey.val()
		const indexYear = findIndexP(data['censos'], selectedYear)
		const indexDep = findIndexP(
			data['censos'][indexYear].departments,
			selectedDepa
		)
		const indexTheme = findIndexP(
			data['censos'][indexYear]['departments'][indexDep].themes,
			selectedTheme
		)
		const theme =
			data['censos'][indexYear]['departments'][indexDep]['themes'][indexTheme]
				.tables

		sortSelect(theme)
		addOption(theme, listTheme)
	}

	function findIndexP(data, value) {
		return data.findIndex((element) => element.id == value)
	}

	// Agregar opciones a los select
	function addOption(iterator, append) {
		iterator.forEach((element) => {
			const option = $('<option></option>')
			option.val(element.id).text(element.value)
			append.append(option)
		})
	}

	// Inicio de script
	function init() {
		data = JSON.parse(localStorage.getItem('data'))
		anio(data)
		jurisdicciones(data)
		surveys(data)
		themes(data)
	}

	function attachChangeEvent(selector, fx, remove) {
		selector.on('change', function (event) {
			event.preventDefault()
			fx.forEach((element, index) => change(element, remove[index]))
		})
	}

	function change(fx, remove) {
		removeChild(remove)
		const data = localStorage.getItem('data')
		fx(JSON.parse(data))
	}

	function removeChild(element) {
		element.empty() // Limpia el contenido del elemento hijo
	}

	// Attach change events
	attachChangeEvent(
		censo_anio,
		[jurisdicciones, surveys, themes],
		[department, survey, listTheme]
	)
	attachChangeEvent(department, [surveys, themes], [survey, listTheme])
	attachChangeEvent(survey, [themes], [listTheme])

	function sortSelect(iterator) {
		console.log(iterator)
		iterator.sort((a, b) => a.value.localeCompare(b.value))
		const allOption = iterator.find((option) => option.value === 'Todos')
		if (allOption) {
			// Remover la opción "Todos" de su posición actual
			const index = iterator.indexOf(allOption)
			if (index !== -1) {
				iterator.splice(index, 1)
			}
			// Agregar la opción "Todos" al principio del array
			iterator.unshift(allOption)
		}
	}
	chargeData()
})
