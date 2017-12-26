$(document).ready(function () {

	// Adicionando telefone dinamicamente aos responsáveis do diário oficial
	$(".add_new_phone_dynamic_responsible_official_diary").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel optional official_diary_responsibles_phones_phone"});
		var id = "official_diary_responsibles_attributes_{x}_phones_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "official_diary[responsibles_attributes][{x}][phones_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string tel optional tel size-width-default form-control new-margin tel_dynamic", name: name});
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

	// Adicionando email dinamicamente aos responsáveis do diário oficial
	$(".add_new_email_dynamic_responsible_official_diary").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel optional official_diary_responsibles_emails_email"});
		var id = "official_diary_responsibles_attributes_{x}_emails_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "official_diary[responsibles_attributes][{x}][emails_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string size-width-default form-control new-margin", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_responsibles_"+position_value).val(Number(value_new_object)+1);
	});

	// Adicionando skype dinamicamente aos responsáveis do diário oficial
	$(".add_new_skype_dynamic_responsible_official_diary").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#skypes_counter_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_skype = $("<div>", {"class": "input tel optional official_diary_responsibles_skypes_skype"});
		var id = "official_diary_responsibles_attributes_{x}_skypes_attributes_{y}_skype".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "official_diary[responsibles_attributes][{x}][skypes_attributes][{y}][skype]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_skype_input = $("<input>", {id: id, "class": "string size-width-default form-control new-margin", name: name});
		$div_skype.append($div_skype_input);

		var $div_delete = $("<a>", {id: "delete_skype_"+position_value+"_"+value_new_object, "class": "delete_skype_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_skype);
		$div_row.append($div_delete);
		$("#group_skypes_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#skypes_counter_responsibles_"+position_value).val(Number(value_new_object)+1);
	});

	/* ------------------------------------------- */

	// Removendo telefone do responsável do diário oficial
	$(".edit_official_diary").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone do responsável do diário oficial
	$(".new_official_diary").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do diário oficial
	$(".edit_official_diary").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do diário oficial
	$(".new_official_diary").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo skype do responsável do diário oficial
	$(".edit_official_diary").on('click', '.delete_skype_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo skype do responsável do diário oficial
	$(".new_official_diary").on('click', '.delete_skype_dynamic', function(e) {
		$(this).parent().remove();
	});

});
