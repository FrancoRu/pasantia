const department = document.getElementById('department')
const survey = document.getElementById('theme')
const listTheme = document.getElementById('quadro')
const form = document.getElementById('form')
const censo_anio = document.getElementById('censo')

//Cara de unidad de relevamiento
function surveys(data) {
	const surveyModules = data.modules
	addOption(surveyModules, survey)
}

//carga de año
function anio(data) {
	const censos = data.censos
	addOption(censos, censo_anio)
}
//carga de jurisdicciones
function jurisdicciones(data) {
	const departments =
		censo_anio.options[censo_anio.selectedIndex].value === '2022'
			? data.departments.filter((element) => element.value === 'Entre Rios')
			: data.departments.filter((element) => element.value !== 'Entre Rios')
	addOption(departments, department)
}

//carga de temas
function themes(data) {
	const module = survey.value
	const theme = data.modules.find((element) => element.value === module).tema
	addOption(theme, listTheme)
}

//Cargar la escucha de evento de cambio
survey.addEventListener('change', (event) => {
	event.preventDefault()
	removeChild(listTheme)
	data = localStorage.getItem('data')
	themes(JSON.parse(data))
})
censo_anio.addEventListener('change', (event) => {
	event.preventDefault()
	removeChild(department)
	data = localStorage.getItem('data')
	jurisdicciones(JSON.parse(data))
})

//Agregar opciones a los select
function addOption(iterator, append) {
	iterator.forEach((element) => {
		const option = document.createElement('option')
		option.value = element.value
		option.text = element.value
		append.appendChild(option)
	})
}

//Remover los hijos anteriores
function removeChild(parentElement) {
	while (parentElement.firstChild) {
		parentElement.removeChild(parentElement.firstChild)
	}
}

//inicio de script
function init() {
	data = JSON.parse(localStorage.getItem('data'))
	anio(data)
	jurisdicciones(data)
	surveys(data)
	themes(data)
}
