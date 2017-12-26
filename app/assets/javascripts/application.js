// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require bootstrap-sprockets
//= require gritter
//= require tinymce
//= require moment 
//= require fullcalendar
//= require_tree .

$(document).ready(function () {

    // Barra de rolagem (overflow: scroll) customizada
    $(".custom-scroll").mCustomScrollbar({
        theme:"minimal-dark"
    });

    // Nao fechar o modal de notificacao apos clicar no checkbox
    $(document).on('click', '.dropdown-container.custom-scroll', function (e) {
        e.stopPropagation();
    });

    // Multi level dropdown
    $('.dropdown-submenu a.sub-menu').on("click", function(e){
        $(this).next('ul').toggle();
        e.stopPropagation();
        e.preventDefault();
    });

    // Fechar o multi level dropdown ao clicar em outro item do menu
    $('.dropdown').on("click", function(e){
        $('.submenu-style').hide();
    });

    // Se estivermos em determinada url, fazer determinada coisa (alterar o footer dependendo da url)
    if (window.location.pathname === '/bidding' || window.location.pathname === '/bidding/new' || window.location.pathname === '/journal_of_bidding' || window.location.pathname === '/official_diary' || window.location.pathname === '/portal' ) {
        $('#footer').css('display','none');
        $('#show-version').css('display','block');
    } else {
        $('#footer').css('display','block');
        $('#show-version').css('display','none');
    };

    // Desabilitar zoom do mapa ao passar o mouse sobre o mesmo
    $('#maps').click(function(e) {
        $(this).find('div').css('pointer-events', 'auto');
    }).mouseleave(function(e) {
        $(this).find('div').css('pointer-events', 'none');
    });

    $("#new_contracts_grid .pre_established_initial_date").addClass("datepicker");
    $(".visits_reports_grid .date_filter").addClass("datepicker");
    $(".calendar_events_grid input.initial_date.date_filter").addClass("datepicker");

    $("[value='Select Some Options']").val("-- Selecione --");

    // $('.client_client_contacts_phone_users_phone, .client_client_contacts_email_users_email').addClass('inline');

    $('.popup-modal').magnificPopup({
        type: 'inline',
        preloader: false,
        focus: '#username',
        modal: true
    });
    $(document).on('click', '.popup-modal-dismiss', function (e) {
        e.preventDefault();
        $.magnificPopup.close();
    });

    // Tab Panel
    $('.panel .nav-tabs').on('click', 'a', function(e){
      var tab  = $(this).parent(),
      tabIndex = tab.index(),
      tabPanel = $(this).closest('.panel'),
      tabPane = tabPanel.find('.tab-pane').eq(tabIndex);
      tabPanel.find('.active').removeClass('active');
      tab.addClass('active');
      tabPane.addClass('active');
  });

    // Adicionar classe 'form-control datepicker' nos inputs de data no datagrid-filter
    $(".datagrid-filter .created_at").addClass("form-control datepicker");

    // Remover classe 'required'
    $("input, textarea, div, select").removeClass("required");
    $("input, textarea, div, select").removeAttr("required");
    $("input, textarea, div, select").removeAttr("size");
    $("input, textarea, div, select").removeAttr("minlength");
    $("input, textarea, div, select").removeAttr("maxlength");
    
    $(".email").removeAttr("type");
    $(".email").removeAttr("type");
    $(".email").removeAttr("type");

    $('#grid_total_events_filter').hide();
    // $(".field_with_errors").removeClass("field_with_errors");
    
    $(".input.tel.field_with_errors.string.form-control").hide();

    // Se estivermos em determinada url, fazer determinada coisa
    if (window.location.pathname === '/login' || window.location.pathname === '/sessions'|| window.location.pathname === '/admin/sessions' || window.location.pathname === '/' || window.location.pathname === '/recover_pass' || window.location.pathname === '/edit_pass' || window.location.pathname === '/recovery_pass' ) {
        // BG do login
        $('body').css('background','#3E3E3E');
        $('#footer p').css('color','white');
    } else {
        // BG do site geral
        $('body').css('background','#FAFAFA');
        $('#footer p').css('color','#3E3E3E');
    }

    // Tooltip
    $('[data-toggle="tooltip"]').tooltip(); 

    // Abrir o grafico ao clicar na imagem
    $('.open-graph').on('click', function () {
        $('#graph').slideToggle();
    });

    // Datepicker normal
    $(".datepicker").datepicker({
        format: "dd/mm/yyyy",
        language: "pt-BR",
        autoclose: true,
        todayHighlight: true
    });

    // Datepicker range
    moment.locale('pt-BR');
    $('.daterange').daterangepicker({
        locale: {
            format: 'DD-MM-YYYY',
            applyLabel: 'Aplicar',
            cancelLabel: 'Cancelar'

        }
    });

    // Datetimepicker
    $('.datetimepicker').datetimepicker({
        locale: 'pt-BR'
    });

    // Datetimepicker
    $('.date_filter').datepicker({
        format: "dd/mm/yyyy",
        locale: 'pt-BR'
    });

    // Masks
    $(".money").maskMoney({
        prefix: "R$ ",
        decimal: ",",
        thousands: "."
    });
    $(".percent").mask("99,99%");
    $(".percent").on("blur", function() {
        var jObj = $(this);
        var jVal = jObj.val();
        jObj.val((jVal.length === 4) ? jVal + '%' : jVal);
    });
    $('.cpf').mask('999.999.999-99');
    $(".cnpj, #clients_grid_cnpj_").mask("99.999.999/9999-99");
    $(".cep").mask("99.999-999");
    $('.rg').mask('aa 99.999.999');
    $(".custom-tel").inputmask({
        mask: ["(99) 9999-9999", "(99) 99999-9999", ],
        keepStatic: true
    }); 

    $(".row_with_observation").hide();
    $(".slide_historic_observations").click(function () {
        $(".row_with_observation").slideToggle();
    });

});

