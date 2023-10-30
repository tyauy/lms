<!DOCTYPE html>

<cfsilent>

    <cfif SESSION.USER_PROFILE eq "trainer">
        <cfset p_id=SESSION.USER_ID>
    </cfif>

    <cfset get_learner_trainer=obj_query.oget_learner_trainer(p_id=Val("#p_id#"))>
</cfsilent>

<html lang="fr">

    <head>
    
        <cfinclude template="./incl/incl_head.cfm">
    
        <style>
        .card {
            border-radius: 2px !important;
            box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
        }
        .nav-link {
            color: #999 !important;
        }
        .nav-link.active
        {
            color:#51BCDA !important;
        }
        .fc-today {
        background-color: inherit !important;
      }
        </style>
    
    </head>
<body>
    <div class="wrapper">
        <cfinclude template="./incl/incl_sidebar.cfm">
            <div class="main-panel">
                <cfset title_page = "Vacays">
        
		<cfinclude template="./incl/incl_nav.cfm">
                        <div class="content"> 
                            <cfinclude template="./incl/incl_nav_trainer.cfm">
                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <div id="calendar2"></div>
                                    <cfoutput> <input type="hidden" id="p_id" value="#p_id#"></cfoutput>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="confirm-delete-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Confirm Delete</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    </div>
                                    <div id="alert-container-delete"></div>
                                    <div class="modal-body">
										<cfoutput>#obj_translater.get_translate('modal_vacay_delete')#</cfoutput> 
										</div>
                                    <div class="modal-footer">
										<button type="button" class="btn btn-outline-danger" id="confirm-delete"><cfoutput>#obj_translater.get_translate('btn_delete')#</cfoutput></button>
										<button type="button" class="btn btn-default" data-dismiss="modal" ><cfoutput>#obj_translater.get_translate('btn_cancel_short')#</cfoutput></button>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="confirm-add-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content p-0">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Confirm Vacations</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    </div>
                                    <div id="alert-container-add"></div>
                                    <div class="modal-body">
                                        Are you sure you want to add these vacations for the following dates:
                                        <br>
                                        <br>
                                        <strong>Start Date:</strong> <span id="start-date"></span>
                                        <br>
                                        <strong>End Date:</strong> <span id="end-date"></span>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-danger confirm_holidays" id="confirm-add">Add</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <cfinclude template="./incl/incl_footer.cfm">
            </div>
    </div>

    <cfinclude template="./incl/incl_scripts.cfm">
        <cfinclude template="./incl/incl_scripts_param.cfm">
            <cfinclude template="./incl/incl_scripts_modal.cfm">

                <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.31/moment-timezone-with-data.min.js"></script>
                <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
                <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-auth.js"></script>


                <script>
                    $(document).ready(function() {

                        const getParameterByName = (name, url = window.location.href) => {
        name = name.replace(/[[\]]/g, '\\$&');
        const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
        const results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }
    const p_id = getParameterByName("p_id");
/* //HOLIDAYS TRANSLATION
function translateEventNames(events, lang, apiKey) {
    // Check if translation is needed
    if (lang === 'fr') {
        return events; // No translation needed
    }

    // Translate using the Google Translate API
    return events.map(event => {
        const url = `https://translation.googleapis.com/language/translate/v2?key=${apiKey}&target=${lang}&source=fr&q=${encodeURIComponent(event.title)}`;

        return fetch(url)
            .then(response => response.json())
            .then(data => {
                if (data && data.data && data.data.translations && data.data.translations[0]) {
                    event.title = data.data.translations[0].translatedText;
                }
                return event;
            })
            .catch(err => {
                console.error('Error translating event title:', err);
                return event;
            });
    });
}
 */
                        //gestion des timezones
                        var currentTimezone = "UTC";
                        var start_send = "";
                        var end_send = "";
                        var _start = "";
                        var _end = "";
                        //set default picker to today
                        if (typeof $.picker === 'undefined') {
                            var date = new Date();
                            var month = ("0" + (date.getMonth() + 1)).slice(-2);
                            var day = ("0" + date.getDate()).slice(-2);
                            var year = date.getFullYear();
                            var formattedDate = year + "-" + month + "-" + day;
                            $.picker = formattedDate;
                        }
                        // set the date for location reload
                        var lastMonth = sessionStorage.getItem("lastMonth");
                        var lastYear = sessionStorage.getItem("lastYear");
                        var picker = lastMonth && lastYear ? moment({
                            year: lastYear,
                            month: lastMonth
                        }).format("YYYY-MM-DD") : moment().format("YYYY-MM-DD");


                        var addFromModal = function(event) {

                            console.log("yo")
                            var p_id = parseInt($("#p_id").val());
                            console.log(start_send, end_send, p_id);


                            $.ajax({
                                type: 'POST',
                                url: "./api/trainerscal/vacation_post.cfc?method=addHolidays",
                                data: {
                                    start_send,
                                    end_send,
                                    p_id
                                },
                                success: function(response) {

                                    console.log(response);
                                    $('#alert-container-add').html('<div class="alert alert-success">Vacations added</div>');
                                    $('#calendar2').fullCalendar('renderEvent', {
                                        id: response,
                                        start: _start,
                                        end: _end,
                                        title: "VACATION",
                                        color: '#00BFFF'
                                    });
                                    setTimeout(function() {
                                        $('#confirm-add-modal').modal('hide');
                                        $('#alert-container-add').html('');
                                    }, 1500);

                                },

                                error: function(xhr, status, error) {
                                    $('#alert-container-add').html('<div class="alert alert-danger">Vacations not added</div>');
                                    setTimeout(function() {
                                        $('#confirm-add-modal').modal('hide');
                                        $('#alert-container-add').html('');
                                    }, 1500);

                                }


                            });
                        }
                        function getHolidayCalendarUrls() {
                            return [
                                'https://www.googleapis.com/calendar/v3/calendars/fr.french#holiday@group.v.calendar.google.com/events',
                                'https://www.googleapis.com/calendar/v3/calendars/de.german#holiday@group.v.calendar.google.com/events'
                            ];
                        }


                        var holidayCalendarUrls = getHolidayCalendarUrls();


                        function renderCalendar() {

                            var p_id = parseInt($("#p_id").val());

                            $('#calendar2').fullCalendar({

                                schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
                                defaultDate: picker,
                                timeFormat: 'H(:mm)',
                                lang: '<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
                                axisFormat: 'HH:mm',
                                allDaySlot: true,
                                timezone: currentTimezone,
                                defaultView: 'month',
                                selectHelper: true,
                                firstDay: 1,
                                navLinks: true,
                                selectable: true,
                                height: 800,
                                aspectRatio: 5,
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: '',
                                },
                                eventClick: function(event) {
                                    var currentEvent = event;
                                    // Check if the event title is "VACATION"
                                    if (currentEvent.title === "VACATION") {
                                        $('#confirm-delete-modal').modal('show');
                                        $('#confirm-delete').click(function() {
                                            // delete the event using the id
                                            $.ajax({
                                                type: 'POST',
                                                url: "./api/trainerscal/vacation_post.cfc?method=deleteHolidays",
                                                data: {
                                                    id: currentEvent.id,
                                                    p_id:p_id
                                                },
                                                success: function(response) {
                                                    $('#alert-container-delete').html('<div class="alert alert-success">Vacations deleted</div>');
                                                    $('#calendar2').fullCalendar('removeEvents', currentEvent.id);
                                                    setTimeout(function() {
                                                        $('#confirm-delete-modal').modal('hide');
                                                        $('#alert-container-delete').html('');
                                                    }, 1300);

                                                },

                                                error: function(xhr, status, error) {
                                                    $('#alert-container-delete').html('<div class="alert alert-danger">Vacations not delete</div>');
                                                }

                                            });

                                        });
                                    }
                                    // If it's not a vacation event, do nothing
                                    else {
                                        return;
                                    }
                                },
                                eventSources: [{
                                        url: './calendar/_EM_get_data_lms_calendar.cfm',
                                        type: 'GET',
                                        data: {
                                            get_lesson: 1,
                                            p_id: p_id,
                                            low_info: 1
                                        },
                                        success: function(events) {
                                            console.log(events);

                                        },
                                        failure: function(err) {
                                            console.log(err);
                                        }
                                    },
                                    {
                                        url: './calendar/_EM_get_data_lms_calendar.cfm',
                                        type: 'GET',
                                        display: 'block',
                                        data: {
                                            get_holidays: 1,
                                            p_id: p_id
                                        },
                                        success: function(events, allDay) {
                                            console.log(events);

                                        },
                                        error: function(err) {
                                            console.log(err);
                                        }
                                    },
                                    {
                                        url: holidayCalendarUrls[0], // French holiday calendar
                                        type: 'google',
                                        googleCalendarApiKey: 'AIzaSyDufCMhVbWprzAnjBY2iuZ0oK17Vo55rMY',
                                        success: function(events) {
                                            console.log(events);
                                        },
                                        error: function(err) {
                                            console.log(err);
                                        }
                                    },
                                    {
                                        url: holidayCalendarUrls[1], // German holiday calendar
                                        type: 'google',
                                        googleCalendarApiKey: 'AIzaSyDufCMhVbWprzAnjBY2iuZ0oK17Vo55rMY',
                                        success: function(events) {
                                            console.log(events);
                                        },
                                        error: function(err) {
                                            console.log(err);
                                        }
                                    }
                                ],

                                select: function(start, end) {
                                    start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD');
                                    end_send = $.fullCalendar.moment(end).subtract(1, 'days').format('YYYY-MM-DD');
                                    _start = start;
                                    _end = end;
                                    console.log(start_send, end_send);
                                    console.log(start, end);
                                    // Get the current month and year from the fullcalendar.js
                                    var currentDate = moment($('#calendar2').fullCalendar('getDate'));
                                    var currentMonth = currentDate.month();
                                    var currentYear = currentDate.year();
                                    var view = $('#calendar2').fullCalendar('getView');

                                    // Store the current month and year in session storage
                                    sessionStorage.setItem("lastMonth", currentMonth);
                                    sessionStorage.setItem("lastYear", currentYear);

                  /*                   $('#confirm-add-modal').on('show.bs.modal', function(e) {
                                        $('#start-date').text($.fullCalendar.moment(start).format('YYYY-MM-DD'));
                                        $('#end-date').text($.fullCalendar.moment(end).subtract(1, 'days').format('YYYY-MM-DD'));
                                        $(".confirm_holidays").off("click");
                                        $(".confirm_holidays").bind("click", addFromModal);
                                    });
                                    $('#confirm-add-modal').modal('show');
                                    $('#confirm-add').click(function() {


                                    }); */

                                    $('#window_item_lg').modal({keyboard: true});

                                    	$('#modal_title_lg').text("Add vacation");

                                    	$('#modal_body_lg').load("modal_window_vacay.cfm?start="+start_send+"&end="+end_send+"&p_id="+p_id)

                                }
                            });
                            sessionStorage.removeItem("lastMonth");
                            sessionStorage.removeItem("lastYear");
                        }



                        renderCalendar();


                    });
                </script>
</body>

</html>