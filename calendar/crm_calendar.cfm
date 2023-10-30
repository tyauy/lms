<cfparam name="view" default="sales">

<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Activit&eacute;</h6>
		<div class="btn-group" role="group">
			<label class="btn btn-sm label_task btn-warning">
				<input type="checkbox" value="task" class="btn_task active" name="test" id="task" checked="checked"> Tasks
			</label>

			<label class="btn btn-sm label_opport btn-success">
				<input type="checkbox" value="opport" class="btn_opport" name="test" id="opport" checked="checked"> Opportunit&eacute;s
			</label>
		</div>	
		
	</div>
	<div class="card-body">

		<div id="calendar"></div> 	
	
	</div>
</div>	




























<!-----------









<cfif view eq "invoicing">
<div class="row">
	
	<div class="col-md-3">

		<h3>Afficher</h3>
		<hr>					
			<!----<label class="btn btn-sm btn-info label_devis">
				<input type="checkbox" value="devis" class="btn_devis" name="test" id="devis"> Devis
			</label>--->
			<div class="row" style="padding-bottom:5px">
				<div class="col-md-12">
					<label class="btn btn-xs btn-warning label_supply">
						<input type="checkbox" value="supply" class="btn_supply" name="test" id="supply"> Commande
					</label>
				</div>
			</div>			

			<div class="row" style="padding-bottom:5px">
				<div class="col-md-12">
					<label class="btn btn-xs btn-danger label_deliver">
						<input type="checkbox" value="deliver" class="btn_deliver" name="test" id="deliver"> Livraison
					</label>
				</div>
			</div>
			
			<div class="row" style="padding-bottom:5px">
				<div class="col-md-12">
					<label class="btn btn-xs btn-success label_order">
						<input type="checkbox" value="order" class="btn_order" name="test" id="order"> Paiement
					</label>
				</div>
			</div>
	
	</div>
	
	<div class="col-md-9">
	
		<h3>Calendrier</h3>
		<hr>
						
		<div id="calendar"></div> 

	</div>

</div>

	
<script>

var currentTimezone = false;

$('#calendar').fullCalendar({
		
			schedulerLicenseKey: '0542611006-fcs-1459164489',
			
			<!---<cfoutput>lang:'#SESSION.LANG_CODE#',</cfoutput>--->
			defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
			defaultView: 'month',
			nowIndicator:true,
			header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek'
				},
			editable: false,
			eventLimit: true, // allow "more" link when too many events
			selectable: true,
			selectHelper: true,
			firstDay: 1,
			allDaySlot: false,
			height:600,
			slotDuration: '00:30:00',
			
			eventSources: [
				"get_datacalendar.cfm"
			],
			/*eventConstraint: 'sconstraint',*/
			selectConstraint: 'trainer_available',
						
			eventClick: function(event) {
			
				var start = $.fullCalendar.moment(event.start).format('YYYY-MM-DD_HH-mm-ss');
				var end = $.fullCalendar.moment(event.end).format('YYYY-MM-DD_HH-mm-ss');
				var data_send = '?updt=1&start='+start+'&end='+end+'&eventid='+event.id+'&session_id='+event.session_id;
				
				$('#window_item').modal({
					remote:"modal_content.cfm"+data_send
				});
				/*$('#window_item').on('hidden', function() {
					$(this).removeData('modal');
				});*/
		
			},

 

	
			select: function(start,end,allday) {

				var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
				var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');
				var data_send = 'ins=1&start='+start_send+'&end='+end_send;
				alert(start_send);
				
				$.ajax({
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
				 ;
				 
				 
				 
			},

		
			
		});

		/**************** PARAM CHECKBOX FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
		/*$('label > input[type=checkbox]').on('change', function () {
		
		var todisplay = $(this).attr('id');
		displayid = 'get_datacalendar.cfm?get_'+todisplay+'=1';
		
		if($(this).is(':checked'))
		{		
		$('#calendar').fullCalendar('addEventSource', displayid);
		}
		else{
		$('#calendar').fullCalendar('removeEventSource', displayid);
		}*/
});
		

</script>

</cfif>

































































<cfif view eq "logistic">
<div class="row">
	
	<div class="col-md-3">

		<h3>Afficher</h3>
		<hr>					
			<!----<label class="btn btn-sm btn-info label_devis">
				<input type="checkbox" value="devis" class="btn_devis" name="test" id="devis"> Devis
			</label>--->
			<div class="row" style="padding-bottom:5px">
				<div class="col-md-12">
					<label class="btn btn-xs btn-warning label_supply">
						<input type="checkbox" value="supply" class="btn_supply" name="test" id="supply"> Commande
					</label>
				</div>
			</div>			

			<div class="row" style="padding-bottom:5px">
				<div class="col-md-12">
					<label class="btn btn-xs btn-danger label_deliver">
						<input type="checkbox" value="deliver" class="btn_deliver" name="test" id="deliver"> Livraison
					</label>
				</div>
			</div>

	
	</div>
	
	<div class="col-md-9">
	
		<h3>Calendrier</h3>
		<hr>
						
		<div id="calendar"></div> 

	</div>

</div>

	
<script>

var currentTimezone = false;

$('#calendar').fullCalendar({
		
			schedulerLicenseKey: '0542611006-fcs-1459164489',
			
			<!---<cfoutput>lang:'#SESSION.LANG_CODE#',</cfoutput>--->
			defaultDate: <cfoutput>'#dateformat(now(),"yyyy-mm-dd")#'</cfoutput>,
			defaultView: 'month',
			nowIndicator:true,
			header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek'
				},
			editable: false,
			eventLimit: true, // allow "more" link when too many events
			selectable: true,
			selectHelper: true,
			firstDay: 1,
			allDaySlot: false,
			height:600,
			slotDuration: '00:30:00',
			
			eventSources: [
				"get_datacalendar.cfm"
			],
			/*eventConstraint: 'sconstraint',*/
			/*selectConstraint: 'trainer_available',*/
			
			
			
			/*monthNames: ['Janvier', 'F&eacute;vrier', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Ao&ucirc;t', 'Septembre', 'Octobre', 'Novembre', 'D&eacute;cembre'],
			monthNamesShort: ['Jan', 'F&eacute;v', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Ao&ucirc;t', 'Sept', 'Oct', 'Nov', 'D&eacute;c'],
			dayNames: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],*/
			
				 
				/*$('#window_item').modal({
					remote:"modal_content.cfm?start="+start+"&end="+end
				});*/
				
							 
			
				
				
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
			

			
			eventClick: function(event) {
			
				var start = $.fullCalendar.moment(event.start).format('YYYY-MM-DD_HH-mm-ss');
				var end = $.fullCalendar.moment(event.end).format('YYYY-MM-DD_HH-mm-ss');
				var data_send = '?updt=1&start='+start+'&end='+end+'&eventid='+event.id+'&session_id='+event.session_id;
				
				$('#window_item').modal({
					remote:"modal_content.cfm"+data_send
				});
				/*$('#window_item').on('hidden', function() {
					$(this).removeData('modal');
				});*/
		
			},



	
			select: function(start,end,allday) {

				var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
				var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');
				var data_send = 'ins=1&start='+start_send+'&end='+end_send;
				alert(start_send);
				
				$.ajax({
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
				});
				 
			},
			
		});

		/**************** PARAM CHECKBOX FOR DISPLAYING EVENT LAYER ON CALENDAR*********************/	
		/*$('label > input[type=checkbox]').on('change', function () {
		
		var todisplay = $(this).attr('id');
		displayid = 'get_datacalendar.cfm?get_'+todisplay+'=1';
		alert(displayid);
		if($(this).is(':checked'))
		{		
		$('#calendar').fullCalendar('addEventSource', displayid);
		}
		else{
		$('#calendar').fullCalendar('removeEventSource', displayid);
		}*/
});
		

</script>

</cfif>---->