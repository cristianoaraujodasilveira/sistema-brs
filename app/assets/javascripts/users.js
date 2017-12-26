$(document).ready(function () {

	$("#user_password").bind('input', function () {
		set_value_to_password(this.value);
	});

	function set_value_to_password(value){
		$("#user_password_to_save").val(value);
	}

	// TELEFONE 
	$("#add_new_phone").on('click', function(e) {

		var value_new_object = $("#phones_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel user_phone_users_phone"});
		var id = "user_phone_users_attributes_{x}_phone".replace("{x}",value_new_object);
		var name = "user[phone_users_attributes][{x}][phone]".replace("{x}",value_new_object);
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

	$(".edit_user").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	$(".new_user").on('click', '.delete_phone', function(e) {
		$(this).parent().remove();
	});

	// EMAIL
	$("#add_new_email").on('click', function(e) {
		var value_new_object = $("#emails_counter").val();

		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel user_email_users_email"});
		var id = "user_email_users_attributes_{x}_email".replace("{x}",value_new_object);
		var name = "user[email_users_attributes][{x}][email]".replace("{x}",value_new_object);
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+value_new_object, "class": "delete_email"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails").append($div_row);
		var value_new_object = $("#emails_counter").val(Number(value_new_object)+1);
	});

	$(".edit_user").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});

	$(".new_user").on('click', '.delete_email', function(e) {
		$(this).parent().remove();
	});

});
