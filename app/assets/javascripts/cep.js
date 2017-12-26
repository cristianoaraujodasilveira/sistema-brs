$(document).ready(function() {

  /* ================= BUSCA POR CEP ======================== */

  /* busca o CEP para usuário */
  $('#user_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#user_address').val(data.address.address);
        $('#user_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#user_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#user_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#user_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#user_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para orgão */
  $('#organ_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#organ_address').val(data.address.address);
        $('#organ_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#organ_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#organ_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#organ_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#organ_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para unidade de cadastramento */
  $('#registration_unit_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#registration_unit_address').val(data.address.address);
        $('#registration_unit_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#registration_unit_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#registration_unit_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#registration_unit_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#registration_unit_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para contabilidade */
  $('#client_client_contability_attributes_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#client_client_contability_attributes_address').val(data.address.address);
        $('#client_client_contability_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#client_client_contability_attributes_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#client_client_contability_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#client_client_contability_attributes_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#client_client_contability_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para entidade de classe */
  $('#entity_class_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#entity_class_address').val(data.address.address);
        $('#entity_class_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#entity_class_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#entity_class_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#entity_class_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#entity_class_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para entidade de classe */
  $('#calendar_event_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#calendar_event_address').val(data.address.address);
        $('#calendar_event_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#calendar_event_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#calendar_event_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#calendar_event_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#calendar_event_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para relatório de visita */
  $('#visits_report_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        if(data != null && data.address != null){
          var address = data.address.address+", "+data.address.neighborhood+", "+data.address.city
          get_coordinates_maps(address);
        }
        $('#visits_report_address').val(data.address.address);
        $('#visits_report_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#visits_report_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#visits_report_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#visits_report_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#visits_report_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para relatório de visita */
  $('#lawyer_addresses_attributes_0_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#lawyer_addresses_attributes_0_address').val(data.address.address);
        $('#lawyer_addresses_attributes_0_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#lawyer_addresses_attributes_0_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#lawyer_addresses_attributes_0_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#lawyer_addresses_attributes_0_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#lawyer_addresses_attributes_0_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para relatório de visita */
  $('#lawyer_addresses_attributes_1_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#lawyer_addresses_attributes_1_address').val(data.address.address);
        $('#lawyer_addresses_attributes_1_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#lawyer_addresses_attributes_1_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#lawyer_addresses_attributes_1_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#lawyer_addresses_attributes_1_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#lawyer_addresses_attributes_1_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para relatório de visita */
  $('#third_address_attributes_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#third_address_attributes_address').val(data.address.address);
        $('#third_address_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#third_address_attributes_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#third_address_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#third_address_attributes_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#third_address_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* atualiza posição no maps baseado no número */
  $('#visits_report_number').blur(function(event) {
    get_values_to_find();
  });

  $(window).on('load', function(){
    var pathname = window.location.pathname;  
    if(pathname.includes('visits_reports/') && pathname.includes('/edit')){
      var lat = $('#visits_report_lat').val();
      var lng = $('#visits_report_lng').val();
      if(lat != null && lng != null){
        initMap(parseFloat(lat), parseFloat(lng));
      }
    }
  });

  function get_values_to_find(){
    var number = $('#visits_report_number').val();
    if(number != null && number != ""){
      var address = $('#visits_report_address').val();
      if(address != null && address != ""){
        var district = $('#visits_report_district').val();
        if(district != null && district != ""){
          var city = $("#visits_report_city_id option:selected").text();
          if(city != null && city != ""){
            var requisition = address+" "+number+", "+district+", "+city;
            get_coordinates_maps(requisition);
          }
        }
      }
    }
  }

  /* Pesquisa as coordenadas no maps */
  function get_coordinates_maps(address){
    $.getJSON(
      'https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key=AIzaSyAWkttWM1Katt-SN1lHs6GTS5LY6fIfaTE',
      function(result){
        if(result != null && result.results.length > 0 && result.results[0].geometry){
          var lat = result.results[0].geometry.location.lat;
          var lng = result.results[0].geometry.location.lng;
          $('#visits_report_lat').val(lat);
          $('#visits_report_lng').val(lng);
          initMap(lat, lng);
        }
      }
      );
  }

  /* Inicia o maps */
  function initMap(lat, lng) {
    var address = {lat: lat, lng: lng};
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 18,
      center: address
    });
    // var marker = new google.maps.Marker({
    //   position: address,
    //   map: map
    // });
    var panorama = new google.maps.StreetViewPanorama(
      document.getElementById('pano'), {
        position: address,
        pov: {
          heading: 34,
          pitch: 10
        }
      });
    map.setStreetView(panorama);
  }

  /* busca o CEP dinâmico para filiais de orgãos */
  $('.dynamic_cep_filial').blur(function(event) {
    cep = $(this).val();
    position_cep = this.id.split('_')[3];
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#organ_organs_attributes_'+position_cep+'_address').val(data.address.address);
        $('#organ_organs_attributes_'+position_cep+'_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $('#organ_organs_attributes_'+position_cep+'_state_id').find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#organ_organs_attributes_'+position_cep+'_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $('#organ_organs_attributes_'+position_cep+'_city_id').find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#organ_organs_attributes_'+position_cep+'_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP dinâmico para unidades de cadastramentos de unidades de cadastramento */
  $('.dynamic_cep_registration_unit').blur(function(event) {
    cep = $(this).val();
    position_cep = this.id.split('_')[5];
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#registration_unit_registration_units_attributes_'+position_cep+'_address').val(data.address.address);
        $('#registration_unit_registration_units_attributes_'+position_cep+'_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $('#registration_unit_registration_units_attributes_'+position_cep+'_state_id').find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#registration_unit_registration_units_attributes_'+position_cep+'_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $('#registration_unit_registration_units_attributes_'+position_cep+'_city_id').find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#registration_unit_registration_units_attributes_'+position_cep+'_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP dinâmico para endereços de contato do cliente */
  $('.dynamic_cep_client_contact').blur(function(event) {
    cep = $(this).val();
    position_cep = this.id.split('_')[4];
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#client_client_contacts_attributes_'+position_cep+'_address').val(data.address.address);
        $('#client_client_contacts_attributes_'+position_cep+'_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $('#client_client_contacts_attributes_'+position_cep+'_state_id').find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#client_client_contacts_attributes_'+position_cep+'_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $('#client_client_contacts_attributes_'+position_cep+'_city_id').find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#client_client_contacts_attributes_'+position_cep+'_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para portais */
  $('#portal_address_attributes_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#portal_address_attributes_address').val(data.address.address);
        $('#portal_address_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#portal_address_attributes_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#portal_address_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#portal_address_attributes_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#portal_address_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para diários oficiais */
  $('#official_diary_address_attributes_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#official_diary_address_attributes_address').val(data.address.address);
        $('#official_diary_address_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#official_diary_address_attributes_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#official_diary_address_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#official_diary_address_attributes_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#official_diary_address_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para jornais de licitação */
  $('#bid_newspaper_address_attributes_zipcode').blur(function(event) {
    cep = $(this).val();
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#bid_newspaper_address_attributes_address').val(data.address.address);
        $('#bid_newspaper_address_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $("#bid_newspaper_address_attributes_state_id").find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#bid_newspaper_address_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $("#bid_newspaper_address_attributes_city_id").find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#bid_newspaper_address_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* busca o CEP para jornais de licitação */
  $('.change_cep_financial_bidding').blur(function(event) {
    cep = $(this).val();
    var position = this.id.split('_')[5];
    $.getJSON(
      '/find_cep',
      {cep: cep},
      function(data){
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_address').val(data.address.address);
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_district').val(data.address.neighborhood);

        var selectState = data.address.state
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_state_id').find("option").filter(function(index) {
          return selectState === $(this).text();
        }).prop("selected", "selected");
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_state_id').trigger("chosen:updated");

        var selectCity = data.address.city;
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_city_id').find("option").filter(function(index) {
          return selectCity === $(this).text();
        }).prop("selected", "selected");
        $('#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_city_id').trigger("chosen:updated");
      }
      );
  });

  /* ========================================================= */


  /* ================= BUSCA POR ESTADO ======================== */

  /* Usuário */
  $('#user_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#user_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Escritório do usuário */
  $('#user_office_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#user_office_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Orgão */
  $('#organ_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#organ_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Contabilidade */
  $('#client_client_contability_attributes_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#client_client_contability_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Entidade de classe */
  $('#entity_class_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#entity_class_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Entidade de classe */
  $('#calendar_event_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#calendar_event_city_id';
    fill_city(state_id, city_to_populate);
  });
  
  /* Entidade de classe */
  $('#visits_report_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#visits_report_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filial de orgão dinâmico */
  $('.dynamic_state_filial').on('change', function(){
    position_filial = this.id.split('_')[3];
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#organ_organs_attributes_'+position_filial+'_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filial de orgão dinâmico */
  $('.dynamic_state_registration_unit').on('change', function(){
    position_filial = this.id.split('_')[5];
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#registration_unit_registration_units_attributes_'+position_filial+'_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filial de orgão dinâmico */
  $('.dynamic_state_client_contact').on('change', function(){
    position_filial = this.id.split('_')[4];
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#client_client_contacts_attributes_'+position_filial+'_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Portal */
  $('#portal_address_attributes_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#portal_address_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Diário Oficial */
  $('#official_diary_address_attributes_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#official_diary_address_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Jornal de Licitação */
  $('#bid_newspaper_address_attributes_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#bid_newspaper_address_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#lawyers_grid_state').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#lawyers_grid_city';
    fill_city(state_id, city_to_populate);
  });


  /* Filtro de advogados */
  $('#lawyer_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#lawyer_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#lawyer_addresses_attributes_0_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#lawyer_addresses_attributes_0_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#lawyer_addresses_attributes_1_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#lawyer_addresses_attributes_1_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#library_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#library_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#thirds_grid_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#thirds_grid_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('#third_address_attributes_state_id').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#third_address_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  /* Filtro de advogados */
  $('.change_state_financial_bidding').on('change', function(){
    // ID do estado selecionado
    var state_id = $(this).find(":selected").val();
    var position = this.id.split('_')[5];
    // ID ou classe CSS do objeto(s) que deverá(ão) ser preenchidos
    var city_to_populate = '#financial_client_attributes_biddings_attributes_'+position+'_address_attributes_city_id';
    fill_city(state_id, city_to_populate);
  });

  var fill_city = function(state_id, city_to_populate, city_to_select){
    // URL da requisição
    var url = '/states/:state_id/cities.json'.replace(':state_id', state_id);
    // Realiza a requisição
    $.getJSON(url, function (cities) {

      // Template do <option> a ser utilizado
      var option_template = '<option :selected value=":id">:text</option>';

      // Guardará as opções
      var options = [];
      options.push(option_template.replace(':id', "").replace(':text', "-- Selecione uma Cidade --").replace(':selected', ""));

      // Monta a marcação
      $.each(cities, function (index, city) {
        selected = ""
        if (city.id == city_to_select) {
          selected = "selected"
        }
        options.push(option_template.replace(':id', city.id).replace(':text', city.name).replace(':selected', selected));
      });
      // Adiciona as opções
      $(city_to_populate).html(options.join(''));
      $(city_to_populate).trigger("chosen:updated");
    });
  };

  /* ========================================================= */


});




