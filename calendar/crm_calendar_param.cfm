<script>

var currentTimezone = false;

$('#calendar').fullCalendar({
		
	/**************COMMON****************/
	themesystem:'bootstrap4',
	/*schedulerLicenseKey: '0542611006-fcs-1459164489',*/
	schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
	defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
	aspectRatio: 3,
	businessHours: {
		dow: [1,2,3,4,5],
		start: '9:00',
		end: '20:00'
	},
	eventLimit: true,
	<cfoutput>locale:'#lcase(SESSION.LANG_CODE)#',</cfoutput>
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
	hiddenDays: [0,6],
	
	/**************END COMMON****************/
	
	
	/**************CUSTOM****************/
	/*eventConstraint: 'sconstraint',*/
	/*selectConstraint: 'trainer_available',*/
	allDaySlot: true,
	timezone: false,
	defaultEventMinutes:15,
	header: {
			left: 'prev,next today',
			center: 'title',
			<cfif view neq "invoicing">right: 'agendaDay,agendaWeek,month'</cfif>
		},
				
	<cfif view eq "sales">
		defaultView: 'agendaWeek',
		editable: true,
		selectable: true,
	<cfelseif view eq "invoicing">
		defaultView: 'month',
	<cfelseif view eq "logistic">
		defaultView: 'month',
	</cfif>
	/**************END CUSTOM****************/

	
	
	/**************SOURCE****************/
	eventSources: [
		
		<cfif view eq "sales">
		
			<cfif isdefined("a_id")>
				<cfoutput>"get_datacalendar.cfm?a_id=#a_id#&get_task=1"</cfoutput>,
				<cfoutput>"get_datacalendar.cfm?a_id=#a_id#&get_opport=1"</cfoutput>
			<cfelse>
				"get_datacalendar.cfm?get_task=1",
				"get_datacalendar.cfm?get_opport=1"
				/*"get_datacalendar.cfm?get_order_1=1",
				"get_datacalendar.cfm?get_order_2=1",
			    "get_datacalendar.cfm?get_order_3=1",*/
			</cfif>
		
		<cfelseif view eq "invoicing">
			
			"get_datacalendar.cfm?get_order_1=1",
			"get_datacalendar.cfm?get_order_2=1",
			"get_datacalendar.cfm?get_order_3=1",
			"get_datacalendar.cfm?get_order_5=1",
			"get_datacalendar.cfm?get_order_6=1",
		
		<cfelseif view eq "logistic">
		
			"get_datacalendar.cfm?get_supply=1",
			"get_datacalendar.cfm?get_delivery=1",
			
		</cfif>
		
	],		
	/**************END SOURCE****************/
	
	
	
	/**************ACTION****************/	
	eventClick: function(event) {
			
		<cfif view eq "invoicing">
			$('#window_item').modal({
			remote:"pdf_container.cfm?remote_view=1&o_id="+event.id
			});
		<cfelseif view eq "sales">
			$('#window_item_lg').modal({
			<cfif isdefined("a_id")>
				<cfoutput>remote:"modal_window_crm.cfm?task_edit=1&task_id="+event.id+"&a_id="+#a_id#</cfoutput>
			<cfelse>
				remote:"modal_window_crm.cfm?task_edit=1&task_id="+event.id
			</cfif>
			});
		<cfelseif view eq "logistic">
		
		
		</cfif>

	},
	<cfif view eq "sales">
	select: function(start,end,allday) {

		var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
		var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');
		
		$('#window_item_lg').modal({
			keyboard: true
		});	
		
		$('.modal-title').empty();
		$('.modal-title').text("Cr\u00e9er opportunit\u00e9");
		$('.modal-body').load("modal_window_crm.cfm?tab_selectall=1&task_date_start="+start_send+"&task_date_end="+end_send+"&task_create=1<cfif isdefined("a_id")><cfoutput>&a_id=#a_id#</cfoutput></cfif>");
	
	},
	
	dayClick: function(date, jsEvent, view) {
		var start_send = $.fullCalendar.moment(date).format('YYYY-MM-DD_HH-mm-ss');
		var end_send = $.fullCalendar.moment(date).format('YYYY-MM-DD_HH-mm-ss');
		
		$('#window_item_lg').modal({
			keyboard: true,
			<cfif isdefined("a_id")>
				remote:"modal_window_crm.cfm?tab_selectall=1&task_date_start="+start_send+"&task_date_end="+end_send+"&opport_create=1&a_id="+<cfoutput>#a_id#</cfoutput>
			<cfelse>
				remote:"modal_window_crm.cfm?tab_selectall=1&task_date_start="+start_send+"&task_date_end="+end_send+"&opport_create=1"
			</cfif>
			
		});	
	},
	
	
	
	eventDrop: function(event, delta, revertFunc) {

		var start_send = $.fullCalendar.moment(event.start).format('YYYY-MM-DD_HH-mm-ss');
		
		if(event.end){
			var end_send = $.fullCalendar.moment(event.end).format('YYYY-MM-DD_HH-mm-ss');
			var data_send = 'updt_quick="1"&task_date_start='+ start_send +'&task_date_end='+ end_send +'&task_id='+ event.id;
		}
		else{
			var data_send = 'updt_quick="1"&task_date_start='+ start_send +'&task_id='+ event.id;
		}
					
		
		if (!confirm("Confirmer le changement de date ?")) {
			revertFunc();
		}
		else{
			$.ajax({
				url: 'updater_crm.cfm',
				data: data_send,
				type: "POST",
				success: function() {
					
				}
			});
		}
		
	},
			
	eventResize: function(event, delta, revertFunc) {

		var start_send = $.fullCalendar.moment(event.start).format('YYYY-MM-DD_HH-mm-ss');
		var end_send = $.fullCalendar.moment(event.end).format('YYYY-MM-DD_HH-mm-ss');
		var data_send = 'updt_quick="1"&task_date_start='+ start_send +'&task_date_end='+ end_send +'&task_id='+ event.id;
		
		if (!confirm("Confirmer le changement de date ?")) {
			revertFunc();
		}
		else{
			$.ajax({
				url: 'updater_crm.cfm',
				data: data_send,
				type: "POST",
				success: function() {
					
				}
			});
		}
	}
	</cfif>
	
	/**************END ACTION****************/	
	
		/*eventConstraint: 'sconstraint',*/
		/*selectConstraint: 'trainer_available',*/

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


		/*
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