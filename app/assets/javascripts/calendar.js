$(document).ready(function() {
    var mode_selected = 2;

    function build_calendar(){
        $('#calendar').fullCalendar({
            lang: "pt-br",
            defaultView: 'agendaWeek',
            allDaySlot: false,
            editable: false,
            slotLabelFormat: "HH:mm",
            dayOfMonthFormat: 'ddd DD/MM',
            timeFormat: 'H(:mm)',
            monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
            monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
            dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
            dayNamesShort: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            buttonIcons: false, 
            selectable: true,
            eventRender: function(event, element)
            { 
                element.find('.fc-title').append(event.name); 
                element.tooltip({title: event.name});
                element.find('.fc-content').append(event.name); 

            },
            eventClick: function(event, element) {
                if(event.type == 'calendar_event'){
                    // $('#my-modal').modal("show");
                    if(event.parent_id == null){
                        window.location = 'calendar_events/'+event.id+/edit/ 
                    } else {
                        window.location = 'calendar_events/'+event.parent_id+/edit/ 
                    }
                } else if(event.type == 'visit'){
                    // $('#show_actions_visit').modal();
                    window.location = 'visits_reports/'+event.id+/edit/ 
                }
            },
            select: function(start, end) {
                if(mode_selected == 1){
                    alert("Para criar um novo evento deve se selecionar a visualização diária ou semanal")
                } else {
                    window.location = 'calendar_events/new/?start='+start+'&end='+end 
                }
            }
        });
    }

    function get_user_id(){
        return $('#user_id_calendar').val();
    }

    $('#user_id_calendar').change( function(){
        $('#calendar').fullCalendar('destroy');
        var events = {
            url: '/events_marked/'+get_user_id(),
            type: 'GET'
        }
        var events_2 = {
            url: '/visits_report_marked/'+get_user_id(),
            type: 'GET'
        }
        build_calendar();
        $('#calendar').fullCalendar( 'removeEventSource', events);
        $('#calendar').fullCalendar( 'removeEventSource', events_2);
        $('#calendar').fullCalendar( 'addEventSource', events);         
        $('#calendar').fullCalendar( 'addEventSource', events_2);         
        $('#calendar').fullCalendar( 'refetchEvents' );
    }).change();


    $(".fc-month-button").on('click', function(){
        mode_selected = 1;
    });

    $(".fc-agendaWeek-button").on('click', function(){
        mode_selected = 2;
    });

    $(".fc-agendaDay-button").on('click', function(){
        mode_selected = 3;
    });

});
