async function createTable(data) {
	startAnimation()
		.then(() => {
			$('#contain-table').append(data)
			$('#contain-div-table').removeClass('hidden')
			$('#table').DataTable({
				searching: false,
				lengthChange: false,
				showing: false,
				dom: '<"wrapper"lrtip>',
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
						next: '<button type="button" class="btn btn-outline-success">Siguiente</button>',
						previous:
							'<button type="button" class="btn btn-outline-success">Anterior</button>',
						first:
							'<button type="button" class="btn btn-outline-success">Primero</button>',
						last: '<button type="button" class="btn btn-outline-success">Ultimo</button>',
					},
				},
			})
		})
		.catch((error) => {
			console.error('Error:', error)
		})
}

function destroyTable() {
	if ($.fn.DataTable.isDataTable('#table')) {
		$('#table').DataTable().destroy()
	}

	$('#contain-table').empty()
}

function changeClass() {
	$('#logo').removeClass('container').addClass('hidden')
	$('#text').addClass('hidden')
	$('#charge').removeClass('hidden')
	$('#glosario').remove()
	$('#contain-div-table').addClass('hidden')
	$('#content-charge').removeClass('hidden')
	$('#img-static').addClass('hidden')
}

function reboot() {
	$('#text').removeClass('hidden')
	$('#logo').removeClass('hidden').addClass('container')
	$('#text').removeClass('hidden')
}

function reCharge() {
	$('.svg-item').css('opacity', 0)
	destroyTable()
	reboot()
	changeClass()
}
