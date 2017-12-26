$(document).ready(function () {

	// Adicionando telefone dinamicamente aos responsáveis do contrato
	$(".add_new_phone_dynamic_contract_responsible").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_contract_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel client_contract_responsibles_phone_users_phone"});
		var id = "client_contract_responsibles_attributes_{x}_phone_users_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[contract_responsibles_attributes][{x}][phone_users_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input tel tel_dynamic", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_contract_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_contract_responsibles_"+position_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	// Adicionando email dinamicamente aos responsáveis do contrato
	$(".add_new_email_dynamic_contract_responsible").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_contract_responsibles_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel client_contract_responsibles_email_users_email"});
		var id = "client_contract_responsibles_attributes_{x}_email_users_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[contract_responsibles_attributes][{x}][email_users_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input-2", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_contract_responsibles_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_contract_responsibles_"+position_value).val(Number(value_new_object)+1);
	});

	$(".add_new_phone_dynamic_contract_responsible_financial").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_contract_responsible_financials_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel client_contract_responsible_financials_phone_users_phone"});
		var id = "client_contract_responsible_financials_attributes_{x}_phone_users_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[contract_responsible_financials_attributes][{x}][phone_users_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input tel", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_contract_responsible_financials_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_contract_responsible_financials_"+position_value).val(Number(value_new_object)+1);
	});

	// Adicionando email dinamicamente aos responsáveis do contrato
	$(".add_new_email_dynamic_contract_responsible_financial").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_contract_responsible_financials_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel client_contract_responsible_financials_email_users_email"});
		var id = "client_contract_responsible_financials_attributes_{x}_email_users_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[contract_responsible_financials_attributes][{x}][email_users_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input-2", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_contract_responsible_financials_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_contract_responsible_financials_"+position_value).val(Number(value_new_object)+1);
	});
	/* ------------------------------------------- */


	// Removendo telefone dos responsáveis do contrato
	$(".edit_contract").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo telefone dos responsáveis do contrato
	$(".new_contract").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email dos responsáveis do contrato
	$(".edit_contract").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	// Removendo email dos responsáveis do contrato
	$(".new_contract").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$("#print_draft_contract").on('click', function(e) {
		printPDF($("#contract_draft_contact").val());
	});

	function printPDF(htmlPage){
		var w = window.open("about:blank");
		w.document.write(htmlPage);
		if (navigator.appName == 'Microsoft Internet Explorer') window.print();
		else w.print();
	}

	$(".select_all_scope").on('change', function(e) {
		var id = this.id.split('_')[4];
		var select_all = this.checked;
		$("#contract_contract_payments_attributes_"+id+"_payment_scope_ids option").prop('selected', select_all);
		$("#contract_contract_payments_attributes_"+id+"_payment_scope_ids").trigger("chosen:updated");
	});

	/* Usuário */
	$('#contract_proposal_id').on('change', function(){
	    // ID do cliente selecionado
	    var proposal_id = $(this).find(":selected").val();

	    // URL da requisição
	    var url = '/get_informations_proposal/:proposal_id/proposal.json'.replace(':proposal_id', proposal_id);
	    // Realiza a requisição
	    $.getJSON(url, function (result) {
	    	if(result != null){
	    		$("#contract_title").val(result.title);
	    		$("#contract_title").text(result.title);
	    	}
	    });
	});

	$('#contract_undetermined').on('change', function(){
		var checked = this.checked;
		if(checked){
			$(".first_initial_date").val("");
			$(".first_initial_date").text("");
			$("#contract_pre_established_final_date").val("");
			$("#contract_pre_established_final_date").text("");
			$(".first_initial_date").prop('disabled', true);
			$("#contract_pre_established_final_date").prop('disabled', true);
			$(".second_initial_date").prop('disabled', false);
		} else {
			$(".second_initial_date").val("");
			$(".second_initial_date").text("");
			$(".first_initial_date").prop('disabled', false);
			$("#contract_pre_established_final_date").prop('disabled', false);
			$(".second_initial_date").prop('disabled', true);
		}
	});


	$('.delete_attachment_contract').on('click', function(){
		result = window.confirm('Certeza que deseja excluir?');
		if(result) {
			var element_id = this.id;
			var id = element_id.split('_')[3];
			if( id != null && id != ""){
				var url = '/delete_attachment_contract/:attachment_id'.replace(':attachment_id',id);
				$.ajax({
					url: url,
					type: 'DELETE',
					success: function(result) {
						if(result.result) {
							$('#div_with_attachment_contract_'+id).remove();
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
