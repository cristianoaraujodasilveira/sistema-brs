$(document).ready(function () {

	// TELEFONE 
	$("#add_new_phone_third").on('click', function(e) {

		var value_new_object = $("#phones_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel third_phones_phone"});
		var id = "third_phones_attributes_{x}_phone".replace("{x}",value_new_object);
		var name = "third[phones_attributes][{x}][phone]".replace("{x}",value_new_object);
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

	$(".edit_third").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	$(".new_third").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	// EMAIL 
	$("#add_new_email_third").on('click', function(e) {

		var value_new_object = $("#emails_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input custom-email third_emails_email"});
		var id = "third_emails_attributes_{x}_email".replace("{x}",value_new_object);
		var name = "third[emails_attributes][{x}][email]".replace("{x}",value_new_object);
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+value_new_object, "class": "delete_email"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails").append($div_row);
		var value_new_object = $("#emails_counter").val(Number(value_new_object)+1);
	});

	$(".edit_third").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});

	$(".new_third").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});


	// Adicionando telefone dinamicamente aos responsáveis do diário oficial
	$(".add_new_phone_dynamic_responsible_third").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_responsible_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel optional third_responsible_phones_phone"});
		var id = "third_responsible_attributes_{x}_phones_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "third[responsible_attributes][{x}][phones_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string tel optional tel size-width-default form-control new-margin tel_dynamic", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_responsible_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_responsible_"+position_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	// Adicionando email dinamicamente aos responsáveis do diário oficial
	$(".add_new_email_dynamic_responsible_third").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_responsible_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel optional third_responsible_emails_email"});
		var id = "third_responsible_attributes_{x}_emails_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "third[responsible_attributes][{x}][emails_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string size-width-default form-control new-margin", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_responsible_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_responsible_"+position_value).val(Number(value_new_object)+1);
	});

	// Adicionando skype dinamicamente aos responsáveis do diário oficial
	$(".add_new_skype_dynamic_responsible_third").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#skypes_counter_responsible_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_skype = $("<div>", {"class": "input tel optional third_responsible_skypes_skype"});
		var id = "third_responsible_attributes_{x}_skypes_attributes_{y}_skype".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "third[responsible_attributes][{x}][skypes_attributes][{y}][skype]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_skype_input = $("<input>", {id: id, "class": "string size-width-default form-control new-margin", name: name});
		$div_skype.append($div_skype_input);

		var $div_delete = $("<a>", {id: "delete_skype_"+position_value+"_"+value_new_object, "class": "delete_skype_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_skype);
		$div_row.append($div_delete);
		$("#group_skypes_responsible_"+position_value).append($div_row);
		var value_new_object = $("#skypes_counter_responsible_"+position_value).val(Number(value_new_object)+1);
	});

	/* ------------------------------------------- */

	// Removendo telefone do responsável do diário oficial
	$(".edit_third").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone do responsável do diário oficial
	$(".new_third").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do diário oficial
	$(".edit_third").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email do responsável do diário oficial
	$(".new_third").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo skype do responsável do diário oficial
	$(".edit_third").on('click', '.delete_skype_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo skype do responsável do diário oficial
	$(".new_third").on('click', '.delete_skype_dynamic', function(e) {
		$(this).parent().remove();
	});

	$('.delete_attachment_third').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[3];
			if( id != null && id != ""){
				var url = '/delete_attachment_third/:attachment_id'.replace(':attachment_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_attachment_third_'+id).remove();
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
