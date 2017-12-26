$(document).ready(function () {

  /* Usuário */
  $('#proposal_visits_report_id').on('change', function(){
    // ID do visits_reporte selecionado
    var visits_report_id = $(this).find(":selected").val();

    // URL da requisição
    var url = '/get_informations_visits_report/:visits_report_id/visits_report.json'.replace(':visits_report_id', visits_report_id);
    // Realiza a requisição
    $.getJSON(url, function (result) {
    	if(result != null){
    		$("#proposal_cnpj").val(result.cnpj);
    		$("#proposal_cnpj").text(result.cnpj);
    		$("#proposal_fantasy_name").val(result.fantasy_name);
            $("#proposal_fantasy_name").text(result.fantasy_name);
            $("#proposal_social_name").val(result.social_name);
    		$("#proposal_social_name").text(result.social_name);
    	}
    });
  });

});
