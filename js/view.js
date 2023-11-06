async function createTable(data) {
	$('#contain-table').empty()
	startAnimation()
		.then(() => {
			$('#contain-table').append(data)
			$('#table').DataTable({
				searching: false,
				lengthChange: false,
				columnDefs: [{ targets: [0, 2], orderable: false }],
				scrollY: '650px',
				scrollX: '900px',
				language: {
					decimal: '',
					emptyTable: 'No hay información',
					info: 'Mostrando _START_ a _END_ de _TOTAL_ Entradas',
					infoEmpty: 'Mostrando 0 to 0 of 0 Entradas',
					infoFiltered: '(Filtrado de _MAX_ total entradas)',
					infoPostFix: '',
					thousands: ',',
					lengthMenu: 'Mostrar _MENU_ Entradas',
					loadingRecords: 'Cargando...',
					processing: 'Procesando...',
					search: 'Buscar:',
					zeroRecords: 'Sin resultados encontrados',
					paginate: {
						first: 'Primero',
						last: 'Ultimo',
						next: 'Siguiente',
						previous: 'Anterior',
					},
				},
			})
		})
		.catch((error) => {
			console.error('Error:', error)
		})
}

function changeClass() {
	$('#logo').removeClass('contenedor').addClass('ocultar')
	$('#text').addClass('ocultar')
	$('#charge').removeClass('ocultar')
	$('#glosario').remove()
}

function reboot() {
	$('#text').removeClass('ocultar')
	$('#logo').removeClass('ocultar').addClass('contenedor')
	$('#text').removeClass('ocultar')
}

$(document).ready(function () {
	$('#submit').on('click', function () {
		$('.svg-item').css('opacity', 0)
		reboot()
		changeClass()
	})
})
