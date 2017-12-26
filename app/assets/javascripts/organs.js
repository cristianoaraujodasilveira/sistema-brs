$(document).ready(function () {

	// TELEFONE 
	$(".add_new_phone_dynamic").on('click', function(e) {
		var sector_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_organs_"+sector_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel organ_sectors_phone_sectors_phone"});
		var id = "organ_sectors_attributes_{x}_phone_sectors_attributes_{y}_phone".replace("{x}",sector_value).replace("{y}",value_new_object);
		var name = "organ[sectors_attributes][{x}][phone_sectors_attributes][{y}][phone]".replace("{x}",sector_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string tel form-control width-input tel_dynamic", name: name, type: "tel"});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+sector_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_"+sector_value).append($div_row);
		var value_new_object = $("#phones_counter_organs_"+sector_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	$(".edit_organ").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".edit_organ").on('click', '.delete_phone_dynamic_specific', function(e) {
		var sector_position = this.id.split("_")[3];
		var phone_position = this.id.split("_")[4];
		var id_input = "organ_sectors_attributes_{x}_phone_sectors_attributes_{y}_phone".replace("{x}",sector_position).replace("{y}",phone_position);
		var input = $("#"+id_input).parent().remove();
		$("#"+this.id).remove();
		$(".tooltip").remove();
	});

	$(".new_organ").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".new_organ").on('click', '.delete_phone_dynamic_specific', function(e) {
		var sector_position = this.id.split("_")[3];
		var phone_position = this.id.split("_")[4];
		var id_input = "organ_sectors_attributes_{x}_phone_sectors_attributes_{y}_phone".replace("{x}",sector_position).replace("{y}",phone_position);
		var input = $("#"+id_input).parent().remove();
		$("#"+this.id).remove();
		$(".tooltip").remove();
	});

	// EMAIL
	$(".add_new_email_dynamic").on('click', function(e) {
		var sector_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_organs_"+sector_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input email organ_sectors_email_sectors_email"});
		var id = "organ_sectors_attributes_{x}_email_sectors_attributes_{y}_email".replace("{x}",sector_value).replace("{y}",value_new_object);
		var name = "organ[sectors_attributes][{x}][email_sectors_attributes][{y}][email]".replace("{x}",sector_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+sector_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_"+sector_value).append($div_row);
		var value_new_object = $("#emails_counter_organs_"+sector_value).val(Number(value_new_object)+1);
	});

	$(".edit_organ").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".edit_organ").on('click', '.delete_email_dynamic_specific', function(e) {
		var sector_position = this.id.split("_")[3];
		var email_position = this.id.split("_")[4];
		var id_input = "organ_sectors_attributes_{x}_email_sectors_attributes_{y}_email".replace("{x}",sector_position).replace("{y}",email_position);
		var input = $("#"+id_input).parent().remove();
		$("#"+this.id).remove();
		$(".tooltip").remove();
	});

	$(".new_organ").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".new_organ").on('click', '.delete_email_dynamic_specific', function(e) {
		var sector_position = this.id.split("_")[3];
		var email_position = this.id.split("_")[4];
		var id_input = "organ_sectors_attributes_{x}_email_sectors_attributes_{y}_email".replace("{x}",sector_position).replace("{y}",email_position);
		var input = $("#"+id_input).parent().remove();
		$("#"+this.id).remove();
		$(".tooltip").remove();
	});

});
