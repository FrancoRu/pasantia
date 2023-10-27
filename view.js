const tbodyElement = document.getElementById('tbody-titles')

const error = [
	{
		cuadro_titulo: 'No se encontraron cuadros con la información proporcionada',
		url_cuadro: '',
		departamento_cuadro: '',
		cuadro_tematica: '',
	},
]

document.addEventListener('DOMContentLoaded', function () {
	let data = localStorage.getItem('data')
	if (data) {
		let jsonData = JSON.parse(data)
		localStorage.clear()
		updateTable(jsonData)
	} else {
		updateTable(error)
	}
})
// Creación de tabla dinámica
function updateTable(data) {
	data.forEach((element) => {
		const rowElement = createRowElement(
			element.cuadro_titulo,
			element.url_cuadro,
			element.departamento_cuadro,
			element.cuadro_tematica
		)
		tbodyElement.appendChild(rowElement)
	})
}

// Plantilla templatizada de filas de tablas
function createRowElement(title, link, department, quadro) {
	const rowElement = document.createElement('tr')
	if (quadro !== '') {
		rowElement.innerHTML = `
		<td>Cuadro ${quadro} ${department}-${title}</td>
		<td>
			<a href="${link}" download="Cuadro ${quadro}-${department}">
				<img src="img/excel-icon.svg" alt="Icono de Excel">
			</a>
			
		</td>
	  `
	} else {
		window.close()
	}
	return rowElement
}

function closeTab() {
	window.close()
}
