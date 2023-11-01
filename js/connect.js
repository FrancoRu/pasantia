window.onload = function () {
	const url = 'buscador/../public.json'
	fetch(url, {
		method: 'GET',
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

form.addEventListener('submit', function (event) {
	event.preventDefault()
	handleSubmit()
		.then((data) => {
			if (data[0].url_cuadro === '') alert(data[0].cuadro_titulo)
			else {
				console.log('lanzado')
				createTable(data)
			}
		})
		.catch((error) => {
			console.error('Error:', error)
		})
})

async function handleSubmit() {
	const formData = new FormData(form)
	const url = 'buscador/../php/main.php'
	return fetch(url, {
		method: 'POST',
		body: formData,
	})
		.then((response) => response.json())
		.catch((error) => {
			console.error('Error:', error)
			throw error // Re-lanza el error para que pueda ser manejado por el código que llama a esta función
		})
}
