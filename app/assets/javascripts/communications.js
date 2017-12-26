$(document).ready(function () {

	$('.delete_attachment_communication').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[3];
			if( id != null && id != ""){
				var url = '/delete_attachment_communication/:attachment_id'.replace(':attachment_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_attachment_communication_'+id).remove();
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


});
