const department = document.getElementById('department')
const survey = document.getElementById('theme')
const listTheme = document.getElementById('quadro')
const form = document.getElementById('form')

form.addEventListener('submit', function (event) {
	event.preventDefault()
	handleSubmit()
		.then((data) => {
			// Guarda los datos en una variable de sesión del lado del cliente
			localStorage.setItem('data', JSON.stringify(data))
			window.open('view.html', '_blank')
		})
		.catch((error) => {
			console.error('Error:', error)
		})
})

async function handleSubmit() {
	const formData = new FormData(form)
	// Construye la URL con los datos del formulario
	const url = 'main.php?' + new URLSearchParams(formData).toString()
	return fetch(url, {
		method: 'GET',
	})
		.then((response) => response.json())
		.catch((error) => {
			console.error('Error:', error)
			throw error // Re-lanza el error para que pueda ser manejado por el código que llama a esta función
		})
}

//inicio de script
function init() {
	jurisdicciones()
	surveys()
	themes()
}
//carga de modulos
function surveys() {
	fetch('./utils/private/survey.json')
		.then((response) => response.json())
		.then((data) => {
			const surveyModules = data.modules
			addOption(surveyModules, survey)
		})
}
//carga de jurisdicciones
function jurisdicciones() {
	fetch('./utils/public/department.json')
		.then((response) => response.json())
		.then((data) => {
			const departments = data.departments
			addOption(departments, department)
		})
		.catch((error) => console.error('Error:', error))
}
//carga de temas
function themes() {
	fetch('./utils/private/survey.json')
		.then((response) => response.json())
		.then((data) => {
			const module = survey.value
			const theme = data.modules.find(
				(element) => element.value === module
			).tema
			addOption(theme, listTheme)
		})
		.catch((error) => console.error('Error:', error))
}

//Cargar la escucha de evento de cambio
survey.addEventListener('change', (event) => {
	event.preventDefault()
	removeChild(listTheme)
	themes()
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

init()
