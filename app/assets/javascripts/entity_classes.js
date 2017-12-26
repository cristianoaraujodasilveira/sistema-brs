$(document).ready(function () {

	// Adicionando telefone dinamicamente aos responsáveis do contrato
	$(".add_new_phone_dynamic_entity_class_responsible").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_entity_class_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel client_entity_class_responsibles_phone_users_phone"});
		var id = "client_entity_class_responsibles_attributes_{x}_phone_users_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[entity_class_responsibles_attributes][{x}][phone_users_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input tel tel_dynamic", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_entity_class_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_entity_class_responsibles_"+position_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	// Adicionando email dinamicamente aos responsáveis do contrato
	$(".add_new_email_dynamic_entity_class_responsible").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_entity_class_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel client_entity_class_responsibles_email_users_email"});
		var id = "client_entity_class_responsibles_attributes_{x}_email_users_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[entity_class_responsibles_attributes][{x}][email_users_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input-2", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_entity_class_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_entity_class_responsibles_"+position_value).val(Number(value_new_object)+1);
	});
	/* ------------------------------------------- */


	// Removendo telefone dos responsáveis do contrato
	$(".edit_entity_class").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone dos responsáveis do contrato
	$(".new_entity_class").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email dos responsáveis do contrato
	$(".edit_entity_class").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email dos responsáveis do contrato
	$(".new_entity_class").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

});
