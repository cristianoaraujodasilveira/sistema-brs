$(document).ready(function () {


	$(window).on('load', function(){
		var pathname = window.location.pathname;	
		var search = window.location.search;	
		if(pathname.includes('calendar_events') && search.includes('?calendar_events_grid') ){
			get_value_by_location('name',1);
			get_value_by_location('initial_date',1);
			get_value_by_location('initial_date',2);
		}
	});


	function get_value_by_location(filter, position){
		var location = window.location.href;
		if(location != null){
			var location_split = location.split(filter);
			if(typeof location_split[position] != 'undefined') {
				var value = location_split[position].split('&')[0].replace('=','');
				value = decodeURIComponent(value);
				value = value.replace('[','');
				value = value.replace(']','');
				value = value.replace(']','');
				if(value != ''){
					if(filter == 'name'){
						$("#calendar_events_grid_name").val(value); 
					} else if(position == 1){
						$("#initial_date_form_calendar").val(value); 
					} else {
						$("#final_date_form_calendar").val(value); 
					}
				}
			}
		}
	}

	$('#grid_total_events').DataTable({
		responsive: {
			details: false
		},
		"language": {
			"sEmptyTable": "Nenhum registro encontrado",
			"sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
			"sInfoFiltered": "(Filtrados de _MAX_ registros)",
			"sInfoPostFix": "",
			"sInfoThousands": ".",
			"sLengthMenu": "_MENU_ resultados",
			"sLoadingRecords": "Carregando...",
			"sProcessing": "Processando...",
			"sZeroRecords": "Nenhum registro encontrado",
			"sSearch": "Pesquisar",
			"oPaginate": {
				"sNext": "Próximo",
				"sPrevious": "Anterior",
				"sFirst": "Primeiro",
				"sLast": "Último"
			},
			"oAria": {
				"sSortAscending": ": Ordenar colunas de forma ascendente",
				"sSortDescending": ": Ordenar colunas de forma descendente"
			}
		}
	});

	$(".check_day").on('click', function(e) {
		var repetition_id = $("#calendar_event_calendar_repetition_id").val();
		if(repetition_id != 6){
			alert("Não é possível selecionar os dias sem selecionar 'Dia da semana específico' no campo de 'Repetir'")
			this.checked = false;
		}
	});

	/* Usuário */
	$('#calendar_event_calendar_repetition_id').on('change', function(){
		var id = this.value
		if (id == 1){
			$('#calendar_event_quantity_repetition').val("");
			$('#calendar_event_quantity_repetition').text("");
		} else if(id == 6){
			if(!$('#calendar_event_repeat').is(":checked")){
				$('#calendar_event_repeat').prop('checked', true);
			}
		} else if(id != null) {
			$('.check_day').prop('checked', false);
			if(!$('#calendar_event_repeat').is(":checked")){
				$('#calendar_event_repeat').prop('checked', true);
			}
		}
	});

	$("#calendar_event_shared").on('click', function(e) {
		if(this.checked) {
			$("#calendar_event_user_ids").prop('disabled', false);
		} else {
			$("#calendar_event_user_ids").prop('disabled', true);
		}
		$("#calendar_event_user_ids option").prop('selected', false);
		$("#calendar_event_user_ids").trigger("chosen:updated");
	});


});
