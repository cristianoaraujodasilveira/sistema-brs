$(document).ready(function () {

	// Adicionando telefone dinamicamente aos responsáveis do portal
	$(".add_new_phone_dynamic_responsible_bidding").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel optional portal_responsibles_phones_phone"});
		var id = "bidding_bidding_proposals_attributes_{x}_phones_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "bidding[bidding_proposals_attributes][{x}][phones_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string tel optional width-input form-control tel_dynamic", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_responsibles_"+position_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 

	});

	// Adicionando email dinamicamente aos responsáveis do portal
	$(".add_new_email_dynamic_responsible_bidding").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel optional portal_responsibles_emails_email"});
		var id = "bidding_bidding_proposals_attributes_{x}_emails_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "bidding[bidding_proposals_attributes][{x}][emails_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string width-input form-control", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_responsibles_"+position_value).val(Number(value_new_object)+1);
	});

	// Removendo telefone do responsável do portal
	$(".edit_bidding").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone do responsável do bidding
	$(".new_bidding").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do bidding
	$(".edit_bidding").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do bidding
	$(".new_bidding").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".row_with_observation_1").hide();
	$(".slide_historic_observations_1").click(function () {
		$(".row_with_observation_1").slideToggle();
	});

	$(".row_with_observation_2").hide();
	$(".slide_historic_observations_2").click(function () {
		$(".row_with_observation_2").slideToggle();
	});

	$(".row_with_observation_3").hide();
	$(".slide_historic_observations_3").click(function () {
		$(".row_with_observation_3").slideToggle();
	});

	$(".row_with_observation_4").hide();
	$(".slide_historic_observations_4").click(function () {
		$(".row_with_observation_4").slideToggle();
	});

	$(".group_proposal").hide();
	$(".show_group_proposals").click(function () {
		var id = this.id.split('_')[2];
		$(".group_proposal_"+id).slideToggle();
	});

	$('#bidding_catch_capture_form_id').on('change', function(){
		set_view_by_capture_form(this.value);
	});

	$('#bidding_read_sample').on('change', function(){
		set_visible_by_checkbox(this.checked, 'read_delivery_time');
	});

	$('#bidding_read_survey').on('change', function(){
		set_visible_by_checkbox(this.checked, 'read_deadline');
	});

	$('#bidding_read_judgment_form_id').on('change', function(){
		if(this.value == 15) {
			$('#read_other_judgment_form').show();
			$('#read_other_judgment_form').removeAttr('hidden');
		} else {
			$('#read_other_judgment_form').hide();
			$('#read_other_judgment_form').attr("hidden","true");
		}
	});

	function set_visible_by_checkbox(checked, div_id) {
		if(checked) {
			$('#'+div_id).show();
			$('#'+div_id).removeAttr('hidden');
		} else {
			$('#'+div_id).hide();
			$('#'+div_id).attr("hidden","true");
		}
	}

	function set_view_by_capture_form(selected_id) {

		$(".inputs_by_capture_form_selected").hide();
		$('.inputs_by_capture_form_selected').attr("hidden","true");
		
		switch(selected_id) {
			case '1':
			$('.catch_capture_form_presencial').show();
			$('.catch_capture_form_presencial').removeAttr('hidden');
			$('.catch_cost').show();
			$('.catch_cost').removeAttr('hidden');
			break;
			case '3':
			$('.catch_bid_newspaper').show();
			$('.catch_bid_newspaper').removeAttr('hidden');
			break;
			case '6':
			$('.catch_date_organ').show();
			$('.catch_date_organ').removeAttr('hidden');
			break;
			case '7':
			$('.catch_other_capture_form').show();
			$('.catch_other_capture_form').removeAttr('hidden');
			$('.catch_cost').show();
			$('.catch_cost').removeAttr('hidden');
			break;
			default:
		}
	}

	$('#bidding_read_proposal_guarantee').on('change', function(){
		if(this.value == 1) {
			$('.group_proposal_guarantee').show();
			$('.group_proposal_guarantee').removeAttr('hidden');
		} else {
			$('.group_proposal_guarantee').hide();
			$('.group_proposal_guarantee').attr("hidden","true");
		}
	});

	$('#bidding_read_guarantee_contractual').on('change', function(){
		if(this.value == 1) {
			$('.group_guarantee_contractual').show();
			$('.group_guarantee_contractual').removeAttr('hidden');
		} else {
			$('.group_guarantee_contractual').hide();
			$('.group_guarantee_contractual').attr("hidden","true");
		}
	});

	$('#bidding_read_claritication').on('change', function(){
		if(this.value == 1) {
			$('.group_read_claritication').show();
			$('.group_read_claritication').removeAttr('hidden');
		} else {
			$('.group_read_claritication').hide();
			$('.group_read_claritication').attr("hidden","true");
		}
	});

	$('#bidding_read_impugnment').on('change', function(){
		if(this.value == 1) {
			$('.group_read_impugnment').show();
			$('.group_read_impugnment').removeAttr('hidden');
		} else {
			$('.group_read_impugnment').hide();
			$('.group_read_impugnment').attr("hidden","true");
		}
	});

	$('#bidding_participation_resource').on('change', function(){
		if(this.value == 1) {
			$('#bidding_resources_group_1').show();
			$('#bidding_resources_group_1').removeAttr('hidden');
		} else {
			$('#bidding_resources_group_1').hide();
			$('#bidding_resources_group_1').attr("hidden","true");
		}
	});

	$('#bidding_participation_against_reason').on('change', function(){
		if(this.value == 1) {
			$('#bidding_resources_group_2').show();
			$('#bidding_resources_group_2').removeAttr('hidden');
		} else {
			$('#bidding_resources_group_2').hide();
			$('#bidding_resources_group_2').attr("hidden","true");
		}
	});

	$('#bidding_participation_partner_participation_id').on('change', function(){
		if(this.value == 2) {
			$('#div_with_participation_partner_participation_justification').show();
			$('#div_with_participation_partner_participation_justification').removeAttr('hidden');
		} else {
			$('#div_with_participation_partner_participation_justification').hide();
			$('#div_with_participation_partner_participation_justification').attr("hidden","true");
		}
	});

	$('#bidding_catch_modalidate_id').on('change', function(){
		if(this.value == 17) {
			$('#div_modalidate_other').show();
			$('#div_modalidate_other').removeAttr('hidden');
		} else {
			$('#div_modalidate_other').hide();
			$('#div_modalidate_other').attr("hidden","true");
		}
	});

	$(".historic_motivations").hide();
	$(".show_motivitations").click(function () {
		var class_name = this.className.split(' ')[1];
		var id = class_name.split('_')[4];
		$(".row_with_observation_resource_"+id).slideToggle();
	});

	$(".qualifications").hide();
	$(".show_qualifications").click(function () {
		var class_name = this.className.split(' ')[1];
		class_name = class_name.replace('show_','');
		$("#"+class_name).slideToggle();
	});

	$('.change_provenance').on('change', function(){
		var class_name = this.className.split(' ')[7];
		var position = class_name.replace('provenance_position_','');
		if(this.value == 2) {
			$('#group_with_country_'+position).show();
			$('#group_with_country_'+position).removeAttr('hidden');
		} else {
			$('#group_with_country_'+position).hide();
			$('#group_with_country_'+position).attr("hidden","true");
		}
	});

	$(".save-edit-qualifications").on('click', function(e) {

		var element_id = this.id;

		var type = 0;
		var text = '';
		var id = null;

		if(element_id.indexOf('good_habit') > 0) {
			type = 1;
			id = element_id.split('_')[4];
			text = $("#good_habit_"+id).val();
		} else if((element_id.indexOf('accreditation') > 0)) {
			type = 2;
			id = element_id.split('_')[4];
			text = $("#accreditation_presential_"+id).val();
		} else if((element_id.indexOf('habilitation') > 0)) {
			type = 3;
			id = element_id.split('_')[3];
			text = $("#habilitation_"+id).val();
		}

		if(id != null && text.length > 0 && type != 0){
			var url = '/save_edit_qualifications/:type/:id'.replace(':type',type).replace(':id',id);
			$.post(url, {text: text}, 
				function(returnedData){
					var result = returnedData.result;
					if(result){
						jQuery.gritter.add({ image: '/assets/success-0b8a2dedd729f28e513472812f5483ae2817ae482c0b744c3ce56c9dd2b2bc1d.png', title: 'Sucesso', text: 'Edição salva com sucesso!'});
						if(type == 1){
							$("[for=bidding_good_habit_ids_"+id+"]").text(text.toUpperCase());
							$("#good_habit_participation_"+id).text(text.toUpperCase());
						} else if(type == 2){
							$("[for=bidding_accreditation_presential_ids_"+id+"]").text(text.toUpperCase());
							$("#accreditation_presential_participation_"+id).text(text.toUpperCase());
						} else if(type == 3){
							$("[for=bidding_habilitation_ids_"+id+"]").text(text.toUpperCase());
							$("#habilitation_participation_"+id).text(text.toUpperCase());
						}
					} else {
						alert('Preencha o campo corretamente para salvar');
					}
				});
		} else {
			alert('Preencha o campo corretamente para salvar');
		}

	});


});

