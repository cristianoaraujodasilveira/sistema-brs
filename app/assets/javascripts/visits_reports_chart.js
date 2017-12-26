$(document).ready(function () {

	$('#open_visit_report_chart').on('click', function(){
		get_values_to_chart();
		$('#div_chart_visits_report').show();
	});

	function initialize_chart(data){
		$('#chart_visits_reports').highcharts({
			chart: {
				plotBackgroundColor: 'rgb(250, 250, 250)',
				backgroundColor: 'rgb(250, 250, 250)',
				plotBorderWidth: null,
				plotShadow: false,
				type: 'pie'
			},
			title: {
				text: ''
			},
			tooltip: {
				pointFormat: '{series.name}: {point.y} - <b>{point.percentage:.1f}%</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					dataLabels: {
						enabled: true,
						format: '<b>{point.name}</b>: {point.y}',
						style: {
							color: '{point.color}' || 'black'
						},
						connectorColor: 'silver'
					}
				}
			},
			series: [{
				name: 'Intermediador',
				data: JSON.parse(data)
			}]
		});
	}

	function get_values_to_chart(){
		$.getJSON(
			'/get_visits_reports_values_to_graphic',
			function(data){
				var values = JSON.stringify(data);
				initialize_chart(values);
			});
	}

});
