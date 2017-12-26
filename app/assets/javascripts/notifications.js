$(document).ready(function () {

	$(window).on('load', function(){
		get_new_notifications();
	});

	setInterval(function () {
		get_new_notifications();
	}, 120000);

	var updating_notifications = false;
	function get_new_notifications(){
		if(updating_notifications){
			return;
		}
		updating_notifications = true;
		var user_id = get_logged_user_id();
		var url = '/get_new_notifications';
		$.getJSON(url,
			{user_id: user_id}, 
			function(result){
				draw_screen_with_notifications(result);
				updating_notifications = false;
			});
	}

	function get_logged_user_id(){
		return $('#current_user_id').val();
	}

	function draw_screen_with_notifications(result){
		clear_notifications();
		if(result.notifications_unread.length > 0){
			$('.notification-circle').show();
			$('.notification-circle').removeAttr('hidden');
			$('#navigations_length').text(result.notifications_unread_length)
		} else {
			$('#navigations_length').text("0");
			$('.notification-circle').hide();
			$('.notification-circle').attr("hidden","true");
		}
		if(result.notifications_unread.length > 0){
			for(var i = 0; i < result.notifications_unread.length; i++){
				add_notification_on_screen(result.notifications_unread[i]);
			}
		}
	}

	function clear_notifications(){
		$('#group_notifications').empty();
	}

	function add_notification_on_screen(notification){
		var $initial_div = $("<div>");
		var $text_p = $("<p>").html(notification.text);
		var $text_span = $("<span>", {"text": notification.date});

		var $div_form_group = $("<div>", {"class":"form-group"});

		var $text_span_read = $("<span>", {"text": 'Marcar como lida?'});

		var $input_checkbox_yes = $("<input>", {"type": 'checkbox', "class": "change_checkbox_notification", "id":"checkbox_notification_yes_"+notification.id});
		var $label_yes = $("<label>", {"class": 'checkbox-inline', "text": 'Sim'});
		$label_yes.append($input_checkbox_yes);

		var $input_checkbox_no = $("<input>", {"type": 'checkbox', "class": "change_checkbox_notification", "id":"checkbox_notification_no_"+notification.id});
		var $label_no = $("<label>", {"class": 'checkbox-inline', "text": 'Não'});
		$label_no.append($input_checkbox_no);

		if(notification.unread) {
			$input_checkbox_no.attr('checked','checked');
		} else {
			$input_checkbox_yes.attr('checked','checked');
		}

		$div_form_group.append($text_span_read);
		$div_form_group.append($label_yes);
		$div_form_group.append($label_no);

		$initial_div.append($text_p);
		$initial_div.append($text_span);
		$initial_div.append($div_form_group);

		var $hr = $("<hr>");

		$("#group_notifications").append($initial_div);
		$("#group_notifications").append($hr);
	}

	$(document).on("click", ".mark_as_read", function(){
		result = window.confirm('Certeza que deseja marcar como lida?');
		if(result) {
			var notification_id = this.id.split('_')[2];
			mark_as_read(notification_id);
		}
	});

	function mark_as_read(notification_id){
		var url = '/mark_as_read';
		$.getJSON(url,
			{notification_id: notification_id}, 
			function(result){
				jQuery.gritter.add({ image: '/assets/success-0b8a2dedd729f28e513472812f5483ae2817ae482c0b744c3ce56c9dd2b2bc1d.png', title: 'Sucesso', text: 'Marcada como lida com sucesso!'});
				draw_screen_with_notifications(result);
				update_screen_after_update_read(notification_id, true);
			});
	}

	$(document).on("click", ".mark_as_unread", function(){
		result = window.confirm('Certeza que deseja marcar como não lida?');
		if(result) {
			var notification_id = this.id.split('_')[2];
			mark_as_unread(notification_id);
		}
	});

	function mark_as_unread(notification_id){
		var url = '/mark_as_unread';
		$.getJSON(url,
			{notification_id: notification_id}, 
			function(result){
				jQuery.gritter.add({ image: '/assets/success-0b8a2dedd729f28e513472812f5483ae2817ae482c0b744c3ce56c9dd2b2bc1d.png', title: 'Sucesso', text: 'Marcada como não lida com sucesso!'});
				draw_screen_with_notifications(result);
				update_screen_after_update_read(notification_id, false);
			});
	}

	$(document).on("click", ".change_checkbox_notification", function(){
		if($('#'+this.id).is(":checked")){
			var notification_id = this.id.split('_')[3];
			var type = this.id.split('_')[2];
			if(type == 'yes'){
				$("#checkbox_notification_no_"+notification_id).attr('checked',false);
				mark_as_read(notification_id);
			} else {
				$("#checkbox_notification_yes_"+notification_id).attr('checked',false);
				mark_as_unread(notification_id);
			}
		} else {
			event.preventDefault();
			event.stopPropagation();
			$('#'+this.id).attr('checked','checked');
		}
	});

	function update_screen_after_update_read(notification_id, was_read){
		var read = '';
		var text = '';
		var label_current_id = '';
		var label_new_id = '';
		var a_current_id = '';
		var a_new_id = '';
		var remove_class = '';
		var add_class = '';
		if(was_read){
			read = 'Sim';
			text = 'Marcar como não lida'
			label_current_id = 'label_unread_no_'+notification_id;
			label_new_id = 'label_unread_yes_'+notification_id;
			a_current_id = 'unread_notification_'+notification_id;
			a_new_id = 'read_notification_'+notification_id;
			remove_class = 'mark_as_read';
			add_class = 'mark_as_unread';
			$("#checkbox_notification_yes_"+notification_id).attr('checked',true);
			$("#checkbox_notification_no_"+notification_id).attr('checked',false);
		} else {
			read = 'Não';
			text = 'Marcar como lida'
			label_current_id = 'label_unread_yes_'+notification_id;
			label_new_id = 'label_unread_no_'+notification_id;
			a_current_id = 'read_notification_'+notification_id;
			a_new_id = 'unread_notification_'+notification_id;
			remove_class = 'mark_as_unread';
			add_class = 'mark_as_read';
			$("#checkbox_notification_yes_"+notification_id).attr('checked',false);
			$("#checkbox_notification_no_"+notification_id).attr('checked',true);
		}
		$("#"+label_current_id).text(read);
		$("#"+a_current_id).text(text);
		$("#"+a_current_id).removeClass(remove_class);
		$("#"+a_current_id).addClass(add_class);
		$("#"+a_current_id).attr('id', a_new_id);
		$("#"+label_current_id).attr('id', label_new_id);


	}


});
