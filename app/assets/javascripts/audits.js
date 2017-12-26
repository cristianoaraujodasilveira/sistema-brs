$(document).ready(function () {
	
	$(window).on('load', function(){
		var pathname = window.location.pathname;	
		if(pathname.includes('/audits.')){
			set_value_to_user_audits(pathname);
		}
	});

	function set_value_to_user_audits(pathname){
		var user_id = pathname.split('.')[1];
		$("#audits_grid_user_id").find("option").filter(function(index) {
			return user_id === $(this).val();
		}).prop("selected", "selected");
		$('#audits_grid_user_id').trigger("chosen:updated");
	}

});
