$(document).ready(function () {

	/* --------- UNIDADE PRINCIPAL ------------ */
	// Adicionando telefone a unidade principal 
	$("#add_new_phone_registration_unit").on('click', function(e) {
		var value_new_object = $("#phones_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel user_phone_users_phone"});
		var id = "registration_unit_phone_users_attributes_{x}_phone".replace("{x}",value_new_object);
		var name = "registration_unit[phone_users_attributes][{x}][phone]".replace("{x}",value_new_object);
		var $div_phone_input = $("<input>", {id: id, "class": "string tel form-control width-input tel_dynamic", name: name, type: "tel"});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+value_new_object, "class": "delete_phone"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones").append($div_row);
		var value_new_object = $("#phones_counter").val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	// Adicionando email a unidade principal
	$("#add_new_email_registration_unit").on('click', function(e) {
		var value_new_object = $("#emails_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel user_email_users_email"});
		var id = "registration_unit_email_users_attributes_{x}_email".replace("{x}",value_new_object);
		var name = "registration_unit[email_users_attributes][{x}][email]".replace("{x}",value_new_object);
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+value_new_object, "class": "delete_email"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails").append($div_row);
		var value_new_object = $("#emails_counter").val(Number(value_new_object)+1);
	});

	/* ----------------------------------------- */


	/* --------- UNIDADES FILHAS --------------- */

	// Adicionando telefone dinamicamente as unidades filhas
	$(".add_new_phone_dynamic_registration_unit").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_registration_units_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input phone registration_unit_registration_units_phone_registration_units_phone"});
		var id = "registration_unit_registration_units_attributes_{x}_phone_registration_units_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "registration_unit[registration_units_attributes][{x}][phone_registration_units_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_registration_units_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_registration_units_"+position_value).val(Number(value_new_object)+1);
	});

	// Adicionando email dinamicamente as unidades filhas
	$(".add_new_email_dynamic_registration_unit").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_registration_units_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input email registration_unit_registration_units_email_registration_units_email"});
		var id = "registration_unit_registration_units_attributes_{x}_email_registration_units_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "registration_unit[registration_units_attributes][{x}][email_registration_units_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_registration_units_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_registration_units_"+position_value).val(Number(value_new_object)+1);
	});

	/* ----------------------------------------- */


	/* --------- RESPONSÁVEIS UNIDADE ------------ */

	// Adicionando telefone dinamicamente aos responsáveis da unidade
	$(".add_new_phone_dynamic_responsible_registration_unit").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_responsible_registration_units_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input phone registration_unit_responsible_registration_units_phone_responsible_registration_units_phone"});
		var id = "registration_unit_responsible_registration_units_attributes_{x}_phone_responsible_registration_units_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "registration_unit[responsible_registration_units_attributes][{x}][phone_responsible_registration_units_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_responsible_registration_units_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_responsible_registration_units_"+position_value).val(Number(value_new_object)+1);
	});

	// Adicionando email dinamicamente aos responsáveis da unidade
	$(".add_new_email_dynamic_responsible_registration_unit").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_responsible_registration_units_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input email registration_unit_responsible_registration_units_email_responsible_registration_units_email"});
		var id = "registration_unit_responsible_registration_units_attributes_{x}_email_responsible_registration_units_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "registration_unit[responsible_registration_units_attributes][{x}][email_responsible_registration_units_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_responsible_registration_units_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_responsible_registration_units_"+position_value).val(Number(value_new_object)+1);
	});
	/* ------------------------------------------- */


	/* ----------- REMOÇÃO GLOBAL -----------------*/

	// Removendo telefone da unidade principal
	$(".edit_registration_unit").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone da unidade principal
	$(".new_registration_unit").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	// Removendo email da unidade principal
	$(".edit_registration_unit").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});

	// Removendo email da unidade principal
	$(".new_registration_unit").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone da unidade principal
	$(".edit_registration_unit").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone da unidade principal
	$(".new_registration_unit").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email da unidade principal
	$(".edit_registration_unit").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email da unidade principal
	$(".new_registration_unit").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	/* ------------------------------------------- */


});
