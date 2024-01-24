$(document).ready(function () {
	$('form').submit(async function (event) {
		event.preventDefault()
		try {
			const data = await handleSubmit()
			console.log(data)
			if (data !== false) {
				await createTable(data)
			}
		} catch (error) {
			$.notify('Busqueda sin resultados', 'warn')
			console.error('Error:', error)
		}
	})
})

async function handleSubmit() {
	const formData = new FormData(form)
	const url = 'buscador/../php/main.php?op=get_cuadro'
	formDataInitial = JSON.parse(localStorage.getItem('body-form'))
	formDataObject = transformFormToObject(formData)
	if (
		!equalFormData(formDataObject, formDataInitial) ||
		formDataInitial === null
	) {
		reCharge()
		storageForm(formDataObject)
		return fetch(url, {
			method: 'POST',
			body: formData,
		})
			.then((response) => response.json())
			.catch((error) => {
				console.error('Error:', error)
				throw error
			})
	} else {
		return false
	}
}

function storageForm(formDataObject) {
	localStorage.removeItem('body-form')
	localStorage.setItem('body-form', JSON.stringify(formDataObject))
}

function transformFormToObject(formData) {
	const formDataObject = {}
	formData.forEach((value, key) => {
		formDataObject[key] = value
	})
	return formDataObject
}

function equalFormData(formCurrent, formInitial) {
	return JSON.stringify(formCurrent) === JSON.stringify(formInitial)
}
