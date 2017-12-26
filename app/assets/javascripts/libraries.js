
$(document).ready(function () {

	$(window).on('load', function(){
		var pathname = window.location.pathname;	
		var search = window.location.search;	
		if( (pathname.includes('show_library')) && (search.includes('?text_to_find=') || search.includes('?state_id=')) ){
			get_value_by_location('text_to_find');
			get_value_by_location('state_id');
		}
	});

	function get_value_by_location(filter){
		var location = window.location.href;
		if(location != null){
			var location_split = location.split(filter);
			if(typeof location_split[1] != 'undefined') {
				var value = location_split[1].split('&')[0].replace('=','');
				if(value != ''){
					if(filter == 'text_to_find') {
						$("#"+filter).val(value); 
					} else {
						value = decodeURIComponent(value);
						$("#"+filter).val(value); 
						$("#"+filter).trigger("chosen:updated");
					}
				}
			}
		}
	}

});

