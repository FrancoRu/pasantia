const button =
	$('#rol_id').val() == 2
		? [
				{
					text: 'Descargar',
					action: function (e, dt, node, config) {
						const usuId = $('#usu_id').val()

						const linkElement = $('<a>', {
							href: `../../controller/anuario.php?op=download&usu_id=${usuId}`,
							download: '',
							target: '_blank',
						})

						$('body').append(linkElement)

						linkElement[0].click()

						linkElement.remove()
						Swal.fire({
							title: 'Exito!!',
							text: 'Iniciando Descarga',
							icon: 'success',
						})
					},
				},
		  ]
		: []
$.ajax({
	url: '../../controller/anuario.php?op=listar',
	type: 'GET',
	statusCode: {
		400: function (jqXHR) {
			const errorResponse = JSON.parse(jqXHR.responseText)
			Swal.fire({
				title: 'Error!!',
				text: errorResponse.message,
				icon: 'error',
			})
		},
	},
	success: function (data) {
		const dataParsed = JSON.parse(data)
		console.log(dataParsed)
		const dataTable = $('#cuadro_data').DataTable({
			buttons: button,
			dom: 'Bfrtip',
			language: {
				sProcessing: 'Procesando...',
				sLengthMenu: 'Mostrar _MENU_ registros',
				sZeroRecords: 'No se encontraron resultados',
				sEmptyTable: 'Ning&#1043;&#1108;n dato disponible en esta tabla',
				sInfo: 'Mostrando un total de _TOTAL_ registros',
				sInfoEmpty: 'Mostrando un total de 0 registros',
				sInfoFiltered: '(filtrado de un total de _MAX_ registros)',
				sInfoPostFix: '',
				sSearch: 'Buscar:',
				sUrl: '',
				sInfoThousands: ',',
				sLoadingRecords: 'Cargando...',
				scrollX: true,
				oPaginate: {
					sFirst: 'Primero',
					sLast: '&#1043;&#1113;ltimo',
					sNext: 'Siguiente',
					sPrevious: 'Anterior',
				},
				oAria: {
					sSortAscending:
						': Activar para ordenar la columna de manera ascendente',
					sSortDescending:
						': Activar para ordenar la columna de manera descendente',
				},
			},
		})

		dataTable.rows.add(dataParsed).draw()
		dataTable.order([5, 'desc']).draw()
	},
})

function consult() {
	$.ajax({
		url: '../../controller/anuario.php?op=LastInsert',
		type: 'GET',
		statusCode: {
			400: function (jqXHR) {
				const errorResponse = JSON.parse(jqXHR.responseText)
				Swal.fire({
					title: 'Error!!',
					text: errorResponse.message,
					icon: 'error',
				})
			},
		},
		success: function (data) {
			const dataParsed = JSON.parse(data)
			const dataTable = $('#cuadro_data').DataTable()
			dataTable.row.add(...dataParsed).draw()
			dataTable.order([5, 'desc']).draw()
		},
	})
}
