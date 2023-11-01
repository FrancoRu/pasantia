const tbodyElement = document.getElementById('tbody-titles')
const theadElement = document.getElementById('thead-titles')

function createTable(data) {
	$('#contain-table').empty()
	$('#contain-table').append(data)
	$('#table').DataTable({
		searching: false,
		columnDefs: [
			{ targets: [0, 2], orderable: false }, // Desactiva el ordenamiento en la primera (0) y tercera (2) columna
		],
	})
}
