$(document).ready(function () {

	$(".add_new_phone_dynamic_client_contact").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#phones_counter_client_contacts_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_phone = $("<div>", {"class": "input tel custom-tel client_client_contacts_phone_users_phone"});
		var id = "client_client_contacts_attributes_{x}_phone_users_attributes_{y}_phone".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[client_contacts_attributes][{x}][phone_users_attributes][{y}][phone]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_phone_input = $("<input>", {id: id, "class": "string form-control width-input tel tel_dynamic", name: name});
		$div_phone.append($div_phone_input);

		var $div_delete = $("<a>", {id: "delete_phone_"+position_value+"_"+value_new_object, "class": "delete_phone_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_phone);
		$div_row.append($div_delete);
		$("#group_phones_client_contacts_"+position_value).append($div_row);
		var value_new_object = $("#phones_counter_client_contacts_"+position_value).val(Number(value_new_object)+1);

		$(".tel_dynamic").inputmask({
			mask: ["(99) 9999-9999", "(99) 99999-9999", ],
			keepStatic: true
		}); 
	});

	$(".add_new_email_dynamic_client_contact").on('click', function(e) {
		var position_value = this.id.split('_')[4]; 
		var value_new_object = $("#emails_counter_client_contacts_"+position_value).val();
		var $div_row = $("<div>", {"class": "inline"});

		var $div_email = $("<div>", {"class": "input tel custom-tel client_client_contacts_email_users_email"});
		var id = "client_client_contacts_attributes_{x}_email_users_attributes_{y}_email".replace("{x}",position_value).replace("{y}",value_new_object);
		var name = "client[client_contacts_attributes][{x}][email_users_attributes][{y}][email]".replace("{x}",position_value).replace("{y}",value_new_object);;
		var $div_email_input = $("<input>", {id: id, "class": "string form-control width-input", name: name});
		$div_email.append($div_email_input);

		var $div_delete = $("<a>", {id: "delete_email_"+position_value+"_"+value_new_object, "class": "delete_email_dynamic"});
		$div_delete.append("x");

		$div_row.append($div_email);
		$div_row.append($div_delete);
		$("#group_emails_client_contacts_"+position_value).append($div_row);
		var value_new_object = $("#emails_counter_client_contacts_"+position_value).val(Number(value_new_object)+1);
	});


	$(".edit_client").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".new_client").on('click', '.delete_phone_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".edit_client").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$(".new_client").on('click', '.delete_email_dynamic', function(e) {
		$(this).parent().remove();
	});

	$("#close_ok").on('click', function(e) {
		$("#notification_ok").hide();
	});

	$("#close_need_update").on('click', function(e) {
		$("#notification_outstanding").hide();
	});

	$("#close_already_expired").on('click', function(e) {
		$("#already_expired").hide();
	});

	$('#client_proposal_id').on('change', function(){
		var proposal_id = $(this).find(":selected").val();

		var url = '/get_informations_proposal/:id/proposal.json'.replace(':id', proposal_id);
		$.getJSON(url, function (result) {
			if(result != null){
				$("#client_cnpj").val(result.cnpj);
				$("#client_cnpj").text(result.cnpj);
				$("#client_fantasy_name").val(result.fantasy_name);
				$("#client_fantasy_name").text(result.fantasy_name);
				$("#client_social_name").val(result.social_name);
				$("#client_social_name").text(result.social_name);
			}
		});
	});

	$('#client_client_contability_attributes_intern_contability').on('change', function(){
		if(this.checked){
			$('#client_client_contability_attributes_extern_contability').prop('checked', false);
		}
	});

	$('#client_client_contability_attributes_extern_contability').on('change', function(){
		if(this.checked){
			$('#client_client_contability_attributes_intern_contability').prop('checked', false);
		}
	});

	$('#document_type_id').on('change', function(){
		var id = this.value;
		$(".group_with_documents").hide();
		$('.group_with_documents').attr("hidden","true");
		$('#group_with_documents_'+id).show();
		$('#group_with_documents_'+id).removeAttr('hidden');
		if(id != null && id != ''){
			$("#alone_button_save").hide();
			$('#alone_button_save').attr("hidden","true");
		} else {
			$('#alone_button_save').show();
			$('#alone_button_save').removeAttr('hidden');
		}
	});

	$(window).load(function() {
		var pathname = window.location.pathname;	
		if(pathname.includes('clients/')){
			var document_type = $("#tag_to_scroll").val();
			if(document_type != null && document_type != ''){
				$('#document_type_id option[value='+document_type+']').attr('selected','selected');
				$('#document_type_id').trigger("chosen:updated");
				$("html, body").animate({ scrollTop: $(document).height() }, 10);
			}
		} else if (pathname.includes('clients.')){
			$("html, body").animate({ scrollTop: $(document).height() }, 10);
		}
	});

	$('#document_type_id_on_clients_list').on('change', function(){
		var id = this.value;
		$(".group_documents_on_clients_list").hide();
		$('.group_documents_on_clients_list').attr("hidden","true");
		$('#group_documents_on_clients_list_'+id).show();
		$('#group_documents_on_clients_list_'+id).removeAttr('hidden');
	});

	$('.table_documents_client').DataTable({
		responsive: {
			details: false
		},
		"pageLength": 50,
		"language": {
			"sEmptyTable": "Nenhum registro encontrado",
			"sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
			"sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
			"sInfoFiltered": "(Filtrados de _MAX_ registros)",
			"sInfoPostFix": "",
			"sInfoThousands": ".",
			"sLengthMenu": "_MENU_ resultados",
			"sLoadingRecords": "Carregando...",
			"sProcessing": "Processando...",
			"sZeroRecords": "Nenhum registro encontrado",
			"sSearch": "Pesquisar",
			"oPaginate": {
				"sNext": "Próximo",
				"sPrevious": "Anterior",
				"sFirst": "Primeiro",
				"sLast": "Último"
			},
			"oAria": {
				"sSortAscending": ": Ordenar colunas de forma ascendente",
				"sSortDescending": ": Ordenar colunas de forma descendente"
			}
		}
	});

	$(".row_with_subfolder").hide();
	$(".slide_subfolder_documents").click(function () {
		var class_name = this.className.split(' ')[2];
		var id = class_name.split('_')[3];
		$(".row_with_subfolder_"+id).slideToggle();
	});

	$('.change_client_document_type').on('change', function(){
		var client_document_type_id = $(this).find(":selected").val();
		var id = this.id.split('_')[4];
		var subfolder_document_id = "#subfolder_client_document_type_"+id;
		fill_subfolder_document(client_document_type_id, subfolder_document_id);
	});

	var fill_subfolder_document = function(client_document_type_id, subfolder_document_id){
		var url = '/client_document_types/:client_document_type_id/subfolders.json'.replace(':client_document_type_id', client_document_type_id);
		$.getJSON(url, function (subfolders) {

			var option_template = '<option :selected value=":id">:text</option>';

			var options = [];
			options.push(option_template.replace(':id', "").replace(':text', "-- Selecione uma subpasta --").replace(':selected', ""));

			$.each(subfolders, function (index, subfolder) {
				selected = ""
				options.push(option_template.replace(':id', subfolder.id).replace(':text', subfolder.name).replace(':selected', selected));
			});
			$(subfolder_document_id).html(options.join(''));
			$(subfolder_document_id).trigger("chosen:updated");
		});
	};

});
