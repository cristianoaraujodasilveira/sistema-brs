$(document).ready(function () {

	$('.delete_attachment_piece').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[3];
			if( id != null && id != ""){
				var url = '/delete_attachment_piece/:attachment_id'.replace(':attachment_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_attachment_piece_'+id).remove();
							jQuery.gritter.add({ image: '/assets/success-0b8a2dedd729f28e513472812f5483ae2817ae482c0b744c3ce56c9dd2b2bc1d.png', title: 'Sucesso', text: 'Arquivo removido com sucesso!'});
						} else {
							alert('Arquivo não removido');
						}
					}
				});
			} else{
				alert('Arquivo não válido para ser removido');
			}
		}
	});

	$('#piece_piece_process_file_id').on('change', function(){
		if(this.value == 0) {
			$('#div_with_folder_name').show();
			$('#div_with_folder_name').removeAttr('hidden');
		} else {
			$('#div_with_folder_name').hide();
			$('#div_with_folder_name').attr("hidden","true");
		}
	});

	$(".div_with_piece_process_files").hide();
	$(".show_div_with_piece_process_files").click(function () {
		var id = this.id.split('_')[6];
		$("#div_with_piece_process_files_"+id).slideToggle();
	});
	
	$('.delete_historic_situation_piece').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[4];
			if( id != null && id != ""){
				var url = '/delete_historic_situation_piece/:historic_situation_id'.replace(':historic_situation_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_historic_piece_'+id).remove();
							jQuery.gritter.add({ image: '/assets/success-0b8a2dedd729f28e513472812f5483ae2817ae482c0b744c3ce56c9dd2b2bc1d.png', title: 'Sucesso', text: 'Histórico removido com sucesso!'});
						} else {
							alert('Histórico não removido');
						}
					}
				});
			} else{
				alert('Histórico não válido para ser removido');
			}
		}
	});

});
