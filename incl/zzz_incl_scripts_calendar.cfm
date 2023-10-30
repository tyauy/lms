<cfif view_select eq "calendar">

<script>
$(document).ready(function() {


// load the list of available timezones
<!---$.getJSON('get_timezones.php', function(timezones) {
	$.each(timezones, function(i, timezone) {
		if (timezone != 'UTC') { // UTC is already in the list
			$('#timezone-selector').append(
				$("<option/>").text(timezone).attr('value', timezone)
			);
		}
	});
});
--->



<!-------------- DRAG AND DROP ------------->
$('.fc-drag').data('duration', '01:00'); 
$('.fc-drag').each(function() {

	// store data so the calendar knows to render an event upon drop
	$(this).data('event', {
		/*title: $.trim($(this).text()),*/ // use the element's text as the event title
		id:'12',
		title: $.trim($(this).text()),
		stick: true, // maintain when user navigates (see docs on the renderEvent method),
		constraint: 'trainer_available'
	});

	// make the event draggable using jQuery UI
	$(this).draggable({
		zIndex: 999,
		revert: true,      // will cause the event to go back to its
		revertDuration: 0  //  original position after the drag
	});

});





var currentTimezone = "local";


function renderCalendar() {
	
$('#calendar').fullCalendar({

	/**************COMMON****************/
	schedulerLicenseKey: '0542611006-fcs-1459164489',
	defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
	aspectRatio: 3,
	businessHours: {
		dow: [1,2,3,4,5],
		start: '9:00',
		end: '20:00'
	},
	eventLimit: true,
	<cfoutput>lang:'#lcase(SESSION.LANG_CODE)#',</cfoutput>
	axisFormat: 'HH:mm',
	nowIndicator:true,
	selectHelper: true,	
	firstDay: 1,
	slotDuration: '00:15:00',
	scrollTime: '08:45:00',
	navLinks: true,
	height:600,
	editable: true,
	eventLimit: true, 
	selectable: true,
	droppable: true,
	/**************END COMMON****************/
	
	
	
	/**************CUSTOM PARAMS****************/
	allDaySlot: false,
	selectConstraint: 'trainer_available',
	/*eventConstraint: 'sconstraint',*/
	defaultEventMinutes:60,
	timezone: currentTimezone,
	defaultView: 'agendaWeek',
	header: {
		left: 'prev,next today',
		center: 'title',
		right: 'month,agendaWeek'
	},	
	/**************END CUSTOM PARAMS****************/
	
	
	
	
	/**************SOURCE****************/	
	eventSources: [
		<!---"get_events.php?timezone=America/Chicago",---->
		<!----<cfoutput>"get_datacalendar.cfm?get_availability=1&user_id=118"</cfoutput>---->
		<!---"get_events.php"---->
		<!---<cfoutput>'remote.cfc?method=getEvents'</cfoutput>--->
		
		<!---- DISPLAY LEARNER ---->
		<cfif isdefined("u_id") AND u_id neq "0"><cfoutput>"get_datacalendar.cfm?get_lesson=1&user_id=#u_id#"</cfoutput></cfif>
		<!---- DISPLAY LEARNER ---->
		<cfif isdefined("planner_id") AND planner_id neq "0"><cfoutput>"get_datacalendar.cfm?get_lesson=1&planner_id=#planner_id#"</cfoutput></cfif>
	],		
	/**************END SOURCE****************/
	

	
	
	
	
	
	/**************ACTION****************/	
	
	
	/*events:[{title:"event1",start:"2017-01-14T07:00:00Z",end:"2017-01-12T14:00:00Z",timezone:"UTC"}],*/
	
	drop: function(date) {
		var start_send = $.fullCalendar.moment(date).format('YYYY-MM-DD_HH-mm-ss');
		var end_send = $.fullCalendar.moment(date).format('YYYY-MM-DD_HH-mm-ss');
		
		/*alert(end_send);*/
		
		$('#window_item_lg').modal({
			keyboard: true,
			remote:"modal_window_event.cfm?start="+start_send+"&end="+end_send			
		});	
	},

	
	
	eventClick: function(event) {
	
		$('#window_item_lg').modal({
		
			keyboard: true,
			remote:"modal_window_event.cfm?lesson_id="+event.id
		});

	},
	
	

	select: function(start,end,allday) {

		var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
		var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');
				
		$('#window_item_lg').modal({
			keyboard: true,
			remote:"modal_window_event.cfm?start="+start_send+"&end="+end_send			
		});	
		 
	},
	
	eventRender: function(event, el) {
		// render the timezone offset below the event title
		if (event.start.hasZone()) {
			el.find('.fc-title').after(
				$('<div class="tzo"/>').text(event.start.format('Z'))
			);
		}
	},

	eventDrop: function(event, delta, revertFunc) {

		var start_send = $.fullCalendar.moment(event.start).format('YYYY-MM-DD_HH-mm-ss');
		
		if(event.end){
			var end_send = $.fullCalendar.moment(event.end).format('YYYY-MM-DD_HH-mm-ss');
			var data_send = 'updt_quick="1"&task_date_start='+ start_send +'&task_date_end='+ end_send +'&lesson_id='+ event.id;
		}
		else{
			var data_send = 'updt_quick="1"&task_date_start='+ start_send +'&lesson_id='+ event.id;
		}
					
		
		if (!confirm("Confirmer le changement de date ?")) {
			revertFunc();
		}
		else{
			$.ajax({
				url: 'updater_lesson.cfm',
				data: data_send,
				type: "POST",
				success: function() {
					
				}
			});
		}
		
	}	
	/**************END ACTION****************/	
	
	
});

}

/**************** PARAM MULTIPLE TRAINER FOR CS FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	


/**************** PARAM RADIO FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
$('.select_trainer_availability').on('change', function () {

	var todisplay = $(this).attr('id');
	
	display_availability = 'get_datacalendar.cfm?get_availability=1&user_id='+todisplay;
	display_lesson = 'get_datacalendar.cfm?get_lesson=1&planner_id='+todisplay;
	
	if($(this).is(':checked'))
	{	
		$('#calendar').fullCalendar('addEventSource', display_availability);
		$('#calendar').fullCalendar('addEventSource', display_lesson);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
	}
	else{		
		$('#calendar').fullCalendar('removeEventSource', display_availability);
		$('#calendar').fullCalendar('removeEventSource', display_lesson);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
	}
});
		
		
/**************** PARAM RADIO FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
/*$('.select_trainer_availability').on('change', function () {

	var todisplay = $(this).attr('id');
	
	alert("todisplay");
	if(this.checked) {
	
    }
	
	display_availability = 'get_datacalendar.cfm?get_availability=1&user_id='+todisplay;
	display_lesson = 'get_datacalendar.cfm?get_lesson=1&planner_id='+todisplay;
	
	if($(this).is(':checked'))
	{	
		$('#calendar').fullCalendar('addEventSource', display_availability);
		$('#calendar').fullCalendar('addEventSource', display_lesson);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
	}
	else{		
		$('#calendar').fullCalendar('removeEventSource', display_availability);
		$('#calendar').fullCalendar('removeEventSource', display_lesson);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
	}
});*/
	
	
	
	

/* when the timezone selector changes, rerender the calendar
$('#timezone-selector').on('change', function() {
	currentTimezone = this.value || false;
	$('#calendar').fullCalendar('destroy');
	renderCalendar();
});
*/
	
renderCalendar();

});
</script>

<!-----
$('#tz_id').on('change', function() {
	$('#calendar').fullCalendar('destroy');
	renderCalendar();
});----->
<!--- <cfelseif view_select eq "ressource">

<script>
$(document).ready(function() {

	function renderCalendar() {

		$('#calendar').fullCalendar({
			schedulerLicenseKey: '0542611006-fcs-1459164489',
			defaultView: 'agendaDay',
			defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
			
			editable: true,
			selectable: true,
			eventLimit: true, // allow "more" link when too many events
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'agendaDay,agendaTwoDay,agendaWeek,month'
			},
			views: {
				agendaTwoDay: {
					type: 'agenda',
					duration: { days: 2 },

					// views that are more than a day will NOT do this behavior by default
					// so, we need to explicitly enable it
					groupByResource: true

					//// uncomment this line to group by day FIRST with resources underneath
					//groupByDateAndResource: true
				}
			},

			resources: "get_datacalendar.cfm?get_planner=1",			
			
			events: "get_datacalendar.cfm?get_lesson=1&get_resource=1",
			
			
			select: function(start, end, jsEvent, view, resource) {
				console.log(
					'select',
					start.format(),
					end.format(),
					resource ? resource.id : '(no resource)'
				);
			},
			dayClick: function(date, jsEvent, view, resource) {
				console.log(
					'dayClick',
					date.format(),
					resource ? resource.id : '(no resource)'
				);
			},
			
			
			eventClick: function(event) {

				$('#window_item_lg').modal({
					keyboard: true,
					remote:"modal_window_event.cfm?lesson_id="+event.id
				});

			}

		});
	
	}
	
	/**************** PARAM CHECKBOX FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
	$('.select_trainer_availability').on('change', function () {

		var todisplay = $(this).attr('id');
		
		display_resource = 'get_datacalendar.cfm?get_planner=1&user_id='+todisplay;
		/*display_lesson = 'get_datacalendar.cfm?get_lesson=1&planner_id='+todisplay;*/
		
		if($(this).is(':checked'))
		{	
			$('#calendar').fullCalendar('addResource', display_resource);
			/*$('#calendar').fullCalendar('addEventSource', display_lesson);*/
			$('#calendar').fullCalendar('rerenderEvents');
			$('#calendar').fullCalendar('refetchEvents');
		}
		else{		
			$('#calendar').fullCalendar('removeResource', display_resource);
			/*$('#calendar').fullCalendar('removeEventSource', display_lesson);*/
			$('#calendar').fullCalendar('rerenderEvents');
			$('#calendar').fullCalendar('refetchEvents');
		}
	});

renderCalendar();

});
</script> --->


<cfelseif view_select eq "ressource2">

<script>

$(document).ready(function() {

	function renderCalendar() {
	
		$('#calendar').fullCalendar({
			schedulerLicenseKey: '0542611006-fcs-1459164489',
			defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
			
			editable: true, // enable draggable events
			scrollTime: '11:00:00', // undo default 6am scrollTime
			minTime: '11:00:00', // undo default 6am scrollTime
			header: {
				left: 'today prev,next',
				center: 'title',
				right: 'timelineDay,timelineThreeDays,agendaWeek,month'
			},
			defaultView: 'timelineDay',
			views: {
				timelineThreeDays: {
					type: 'timeline',
					duration: { days: 3 }
				}
			},
			resourceLabelText: 'Trainers',
			
			resources: "get_datacalendar.cfm?get_planner=1",			
			
			events: "get_datacalendar.cfm?get_lesson=1&get_resource=1",
			
			
			eventClick: function(event) {
	
				$('#window_item_lg').modal({
					keyboard: true,
					remote:"modal_window_event.cfm?lesson_id="+event.id
				});

			}
			
		});
	
	});

	});
</script>

<cfelseif view_select eq "list">


</cfif>










<!----
<script>

var currentTimezone = false;

$('#calendar').fullCalendar({
		
			schedulerLicenseKey: '0542611006-fcs-1459164489',
			
			<!---<cfoutput>lang:'#SESSION.LANG_CODE#',</cfoutput>--->
			defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
			defaultView: 'agendaWeek',
			nowIndicator:true,
			header: {
					left: 'prev,next today',
					center: 'title',
					right: 'agendaDay,agendaWeek,month'
				},
			editable: true,
			eventLimit: true, 
			selectable: true,
			selectHelper: true,
			firstDay: 1,
			allDaySlot: false,
			height:500,
			slotDuration: '00:30:00',
			
			eventSources: [
				<!---<cfif isdefined("a_id")>
					<cfoutput>"get_datacalendar.cfm?a_id=#a_id#&get_task=1&get_opport=1"</cfoutput>
				<cfelse>
					"get_datacalendar.cfm?get_task=1&get_opport=1"
				</cfif>--->
				"session_get4.cfm"
			],
			

			
			eventClick: function(event) {
			
				$('#window_item').modal({
					keyboard: true,
					<cfif isdefined("a_id")>
						<cfoutput>remote:"modal_window.cfm?task_edit=1&task_id="+event.id+"&a_id="+#a_id#</cfoutput>
					<cfelse>
						remote:"modal_window.cfm?task_edit=1&task_id="+event.id
					</cfif>
				});
		
			},
			
			select: function(start,end,allday) {

				var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
				var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');

				
				$('#window_item').modal({
					keyboard: true,
					<cfif isdefined("a_id")>
						remote:"modal_window.cfm?tab_selectall=1&task_date_start="+start_send+"&task_date_end="+end_send+"&task_create=1&a_id="+<cfoutput>#a_id#</cfoutput>
					<cfelse>
						remote:"modal_window.cfm?tab_selectall=1&task_date_start="+start_send+"&task_date_end="+end_send+"&task_create=1"
					</cfif>
					
				});	
				
			
				
				
					
					
					
				/*$.ajax({
				 url: 'session_update.cfm',
				 data: data_send,
				 type: 'POST',
				 dataType: 'json',				 
				 success: function(response){
					$('#calendar').fullCalendar('rerenderEvents');
					$('#calendar').fullCalendar('refetchEvents');
				   if(response.status != 'success')
					$('#calendar').fullCalendar('rerenderEvents');
					$('#calendar').fullCalendar('refetchEvents');
					
				},
				 error: function(e){	
					$('#calendar').fullCalendar('unselect');
					$('#calendar').fullCalendar('rerenderEvents');
					$('#calendar').fullCalendar('refetchEvents');
				  }
				 })
				 ;*/
				 
				 
				 
			},
			
			
			/*eventConstraint: 'sconstraint',*/
			/*selectConstraint: 'trainer_available',*/
			
			
			
			/*monthNames: ['Janvier', 'F&eacute;vrier', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Ao&ucirc;t', 'Septembre', 'Octobre', 'Novembre', 'D&eacute;cembre'],
			monthNamesShort: ['Jan', 'F&eacute;v', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Ao&ucirc;t', 'Sept', 'Oct', 'Nov', 'D&eacute;c'],
			dayNames: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],*/
			
				 

							 
			
				
				
				/*var title = prompt('Event Title:');
				var eventData;
				if (title) {
					eventData = {
						title: title,
						start: start,
						end: end
					};
					$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
				}
				$('#calendar').fullCalendar('unselect');
			},
*/
			/*eventConstraint:  {start: '11:00', end: '18:00'},*/
			
			
			
		/*	 resources: [{'id':'r1','name':'Resource 1'},{'id':'r2', 'name':'Resource 2'}],
  //resources: 'https://data-url'  //you can use just a url to your resources data if you want 
  events: [
  {
    title: 'R1-R2: Lunch 14.00-15.00',
    start: '2013-08-21T14:00:00.000Z',
    end: '2013-08-21T15:00:00.000Z',
    resources: ['r1','r2']
  }*/
  
  
			
			/*events: [
	
				
				
				{
					title: 'Business Lunch',
					start: '2016-01-03T13:00:00',
					constraint: 'businessHours'
				},
				{
					title: 'Meeting',
					start: '2016-01-13T11:00:00',
					constraint: 'availableForMeeting', // defined below
					color: '#257e4a'
				},
				{
					title: 'Conference',
					start: '2016-01-18',
					end: '2016-01-20'
				},
				{
					title: 'Party',
					start: '2016-01-29T20:00:00'
				},

				

				// red areas where no events can be dropped
				
			],*/

			/*eventDrop: function(event, delta) {
			 start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
			 end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
			 $.ajax({
			 url: 'http://localhost/fullcalendar/update_events.php',
			 data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
			 type: "POST",
			 success: function(json) {
			 alert("OK");
			 }
			 });
			},*/
			
			 /*
			droppable: true, // this allows things to be dropped onto the calendar
			drop: function() {
				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}
				$(this).remove();
			},*/
			

			
			



	
			

		
			
		});

		/**************** PARAM CHECKBOX FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
		$('label > input[type=checkbox]').on('change', function () {
		
		var todisplay = $(this).attr('id');
		displayid = 'get_datacalendar.cfm?get_'+todisplay+'=1';

		if($(this).is(':checked'))
		{	
		$('#calendar').fullCalendar('addEventSource', displayid);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
		}
		else{		
		$('#calendar').fullCalendar('removeEventSource', displayid);
		$('#calendar').fullCalendar('rerenderEvents');
		$('#calendar').fullCalendar('refetchEvents');
		}
});
		

</script>
---->