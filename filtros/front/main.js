let departament = document.getElementById('departament')
let survey = document.getElementById('theme')
let listTheme = document.getElementById('quadro')
let button = document.getElementById('submit')

button.addEventListener('submit', (event) => {
	event.preventDefault()
})

//inicio de script
function init() {
	jurisdicciones()
	surveys()
	themes()
}
//carga de modulos
function surveys() {
	fetch('./utils/survey.json')
		.then((response) => response.json())
		.then((data) => {
			let surveyModules = data.modules
			addOption(surveyModules, survey)
		})
}
//carga de jurisdicciones
function jurisdicciones() {
	fetch('./utils/departament.json')
		.then((response) => response.json())
		.then((data) => {
			var departaments = data.departaments
			addOption(departaments, departament)
		})
		.catch((error) => console.error('Error:', error))
}
//carga de temas
function themes() {
	fetch('./utils/survey.json')
		.then((response) => response.json())
		.then((data) => {
			let module = document.getElementById('theme').value
			let theme = data.modules.find((element) => element.value === module).tema
			console.log(theme)
			addOption(theme, listTheme)
		})
		.catch((error) => console.error('Error:', error))
}
survey.addEventListener('change', (event) => {
	event.preventDefault()
	removeChild(listTheme)
	themes()
})
function addOption(iterator, append) {
	iterator.forEach((element) => {
		let option = document.createElement('option')
		option.value = element.value
		option.text = element.value
		append.appendChild(option)
	})
}

function removeChild(parentElement) {
	while (parentElement.firstChild) {
		parentElement.removeChild(parentElement.firstChild)
	}
}
init()
