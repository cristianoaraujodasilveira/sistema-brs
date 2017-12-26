$(document).ready(function () {

	$(".group_process").hide();
	$(".show_group_process").click(function () {
		var position = this.id.split('_')[3];
		$("#group_process_"+position).slideToggle();
	});

	$(".group_proposal").hide();
	$(".show_group_proposal").click(function () {
		var process_counter = this.id.split('_')[3];
		var proposal_counter = this.id.split('_')[4];
		$("#group_proposal_"+process_counter+'_'+proposal_counter).slideToggle();
	});

	$(".show_content_third").click(function () {
		var process_counter = this.id.split('_')[3];
		$("#row_with_observation_"+process_counter).slideToggle();
	});

	$('.change_ride_in_process').on('change', function(){
		var class_name = this.className.split(' ')[7];
		var position = class_name.replace('change_ride_in_process_','');
		if(this.value == 1) {
			$('#organ_ride_'+position).show();
			$('#organ_ride_'+position).removeAttr('hidden');
		} else {
			$('#organ_ride_'+position).hide();
			$('#organ_ride_'+position).attr("hidden","true");
		}
	});

	$('.change_modalidate').on('change', function(){
		var class_name = this.className.split(' ')[7];
		var position = class_name.replace('change_modalidate_','');
		if(this.value == 17) {
			$('#div_modalidate_other_'+position).show();
			$('#div_modalidate_other_'+position).removeAttr('hidden');
		} else {
			$('#div_modalidate_other_'+position).hide();
			$('#div_modalidate_other_'+position).attr("hidden","true");
		}
	});

	$('.delete_attachment_financial').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[3];
			if( id != null && id != ""){
				var url = '/delete_attachment_financial/:attachment_id'.replace(':attachment_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_attachment_financial_'+id).remove();
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

	$('.change_third_type').on('change', function(){
		var position = this.id.split('_')[4];
		if(this.value == 4) {
			$('#group_thirds_'+position).hide();
			$('#group_thirds_'+position).attr("hidden","true")
			$('#group_lawyers_'+position).show();
			$('#group_lawyers_'+position).removeAttr('hidden');
		} else {
			$('#group_thirds_'+position).show();
			$('#group_thirds_'+position).removeAttr('hidden');
			$('#group_lawyers_'+position).hide();
			$('#group_lawyers_'+position).attr("hidden","true")
			get_thirds_by_type(this.value, position)
		}
	});

	$('.change_third').on('change', function(){
		var position = this.id.split('_')[4];
		var text = $("#"+this.id+" :selected").text().split('/');
		if(text.length == 1){
			$('#financial_financial_thirds_attributes_'+position+'_name').val(text[0]);
			$('#financial_financial_thirds_attributes_'+position+'_name').text(text[0]);
		} else {
			$('#financial_financial_thirds_attributes_'+position+'_name').val(text[1]);
			$('#financial_financial_thirds_attributes_'+position+'_name').text(text[1]);
			$('#financial_financial_thirds_attributes_'+position+'_fantasy_name').val(text[2]);
			$('#financial_financial_thirds_attributes_'+position+'_fantasy_name').text(text[2]);
			$('#financial_financial_thirds_attributes_'+position+'_social_name').val(text[3]);
			$('#financial_financial_thirds_attributes_'+position+'_social_name').text(text[3]);
		}
	});

	function get_thirds_by_type(third_type, position){
		var url = '/thirds/:third_type/thirds.json'.replace(':third_type', third_type);
		$.getJSON(url, function (thirds) {

			var option_template = '<option :selected value=":id">:text</option>';

			var options = [];
			options.push(option_template.replace(':id', "").replace(':text', "-- Selecione --").replace(':selected', ""));

			$.each(thirds, function (index, object) {
				options.push(option_template.replace(':id', object.id).replace(':text', object.register_number+' / '+object.name+' / '+object.fantasy_name+' / '+object.social_name));
			});
			$('#financial_financial_thirds_attributes_'+position+'_third_id').html(options.join(''));
			$('#financial_financial_thirds_attributes_'+position+'_third_id').trigger("chosen:updated");
		});
	};

	$(".group_thirds").hide();
	$(".show_group_third").click(function () {
		var position = this.id.split('_')[3];
		$("#group_thirds_geral_"+position).slideToggle();
	});


});

