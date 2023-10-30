<!DOCTYPE html>

<cfsilent>
<cfif SESSION.USER_PROFILE eq "trainer">
	<cfset p_id = 140>
</cfif>

<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id=Val("#p_id#"))>
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
 
    .day {
        width: 30px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        border-radius: 50%;
        border: 1px solid #ccc;
        cursor: pointer;
		margin-right: 5px !important;
    }
    .table-container {
        display: flex;
        align-items: flex-start;
    }
    .table-responsive {
        margin-right: 16px;
    }


	</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
	  
		<cfset title_page = "#obj_translater.get_translate('title_page_common_trainer')# : #obj_translater.get_translate('title_page_trainer_avail')#">
		<cfinclude template="./incl/incl_nav.cfm">
		<div class="content">
		
			<cfinclude template="./incl/incl_nav_trainer.cfm">
		

			<div class="row">
			
				
				
				
				<div class="col-md-12">
				
					<cfset u_id = 0>
					<cfset display_avail = "1">
					<div class="row">
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
				  Are you sure you want to delete this week type day?
				</div>
				<div class="modal-footer">
				  <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				  <button type="button" class="btn btn-danger" id="confirm-delete">Delete</button>
				</div>
			  </div>
				</div>
			</div>
					
		  <div class="modal fade" id="confirm-add-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
			  <div class="modal-content">
				<div class="modal-header">
				  <h4 class="modal-title" id="myModalLabel">Confirm Weekday</h4>
				  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div id="alert-container-add"></div> 
				<div class="modal-body">
					Are you sure you want to add a weektype day for the following day and hours:
					<br>
					<br>
					<strong>Day:</strong> <span id="weekday" value="weekday"></span>
					<br>
					<strong>Start time:</strong> <span id="start-date" value="start-date"></span>
					<br>
					<strong>End time:</strong> <span id="end-date" value="end-date"></span>
		</div>
			
				<div class="modal-footer">
				  <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				  <button type="button" class="btn btn-danger confirm_day" id="confirm-add">Add</button>
				</div>
			  </div>
			</div>
		  </div>
      
		<cfinclude template="./incl/incl_footer.cfm">
	</div>
</div>
</body> 
  
<cfinclude template="./incl/incl_scripts.cfm">
<cfinclude template="./incl/incl_scripts_param.cfm">
<cfinclude template="./incl/incl_scripts_modal.cfm">

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.31/moment-timezone-with-data.min.js"></script>

<script>

$(document).ready(function() {

		// Days of Week logic to have the week_day show at the right place on the calendar
		Date.prototype.getDaysOfCurrentWeek = function(start) {
				// Array of all days of week with their corresponding day numbers
				var days = [ 
					{ name: "Sunday", dayNumber: 0 }, 
					{ name: "Monday", dayNumber: 1 }, 
					{ name: "Tuesday", dayNumber: 2 }, 
					{ name: "Wednesday", dayNumber: 3 }, 
					{ name: "Thursday", dayNumber: 4 }, 
					{ name: "Friday", dayNumber: 5 }, 
					{ name: "Saturday", dayNumber: 6 }
				];

				// Calculates date of first day of current week
				start = start || 0;
				var today = new Date(this.setHours(0, 0, 0, 0));
				var day = today.getDay() - start;
				var date = today.getDate() - day;

				// Then calculate all dates of current week and then reformat them into ISO
				var daysOfWeek = new Object();
				for(i = 0; i < 7; i++) {
					tmp = new Date(today.setDate(date + i));
					daysOfWeek[days[i].name] = {
						date: tmp.getFullYear() + '-' + (tmp.getMonth() + 1) + '-' + tmp.getDate(),
						dayNumber: days[i].dayNumber
					};
				}
				return daysOfWeek;
		}
		
				//proto gestion des timezones
				var currentTimezone = "UTC";
				//initialisation des variables
				var start_send = "";
				var end_send = "";
				var _start = "";
				var _end = "";
				var p_id = parseInt($("#p_id").val());

		function renderCalendar() {
			var p_id = parseInt($("#p_id").val());
		/* 	var selectedTimezone = timezoneSelect.value;  */
			$('#calendar2').fullCalendar({
				schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',	
				timeFormat: 'H(:mm)',
				lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
				axisFormat: 'HH:mm',
				timezone: currentTimezone,
				defaultView: 'agendaWeek',
				firstDay: 1,
				columnFormat: 'dddd',
				todayHighlight: false,
				selectable: true,
				height:500,aspectRatio: 1,
				header: false,
				allDaySlot: false,
				eventClick: function(event){
					var currentEvent = event;
					$('#confirm-delete-modal').modal('show');
					$('#confirm-delete').click(function() {
					// delete the event using the id
					$.ajax({
						type: 'POST',
						url: "./api/trainerscal/_EM_weektypePost.cfc?method=deleteWorkingHours",
						data: { id: currentEvent.id },
						success: function(response) {
							$('#alert-container-delete').html('<div class="alert alert-success">Working hours deleted</div>');
							$('#calendar2').fullCalendar('removeEvents', currentEvent.id);
							setTimeout(function() {
							$('#confirm-delete-modal').modal('hide');
							$('#alert-container-delete').html('');
							}, 1300);
						},
						error: function(xhr, status, error) {
							$('#alert-container-delete').html('<div class="alert alert-danger">Working hours not deleted</div>');
							$('#alert-container-delete').html('');
						}
					});
				});
			},
				
			eventSources: [
				{
					url: './calendar/_EM_get_data_lms_calendar.cfm',
					type: 'GET',
					data: {
					get_working_hours: 1,
					p_id: p_id
					},
					error: function() {
					alert('there was an error while fetching events!');
					},
					eventDataTransform: function(eventData) {
					// Set the 'dow' property to the 'daysOfWeek' property from the event data
					eventData.dow = eventData.daysOfWeek;			
					return eventData;
					}
				}
				],

				select: function(start,end, allday) {
					_start=start;
					_end=end;
					var selectedWeekday = moment(start).weekday() + 1;
					var selectedWeekdayN = moment(start).format("dddd");
					var start_send = $.fullCalendar.moment(start).format('HH:mm');
					var end_send = $.fullCalendar.moment(end).format('HH:mm');
					
					$('#confirm-add-modal').on('show.bs.modal', function (e) {
						$('#weekday').text(selectedWeekdayN);
						$('#weekday').val(selectedWeekday);
						$('#start-date').text($.fullCalendar.moment(start).format('HH:mm'));
						$('#end-date').text($.fullCalendar.moment(end).format('HH:mm'));
						$('#status').val('available');
						$(".confirm_day").off("click");
						$(".confirm_day").bind("click",addFromModal);
					});
					$('#confirm-add-modal').modal('show');
					$('#confirm-add').click(function() {
						var eventData = {
						title: title,
						start: start,
						end: end,
						daysOfWeek: [selectedWeekday]
						};

					});
				 },
			});								
		}

		renderCalendar();

		var addFromModal = function(event) {	
		start_send = $("#start-date").text()
		end_send = $("#end-date").text()
		weekday = $("#weekday").val()

			$.ajax({
					type:'POST',
					url: "./api/trainerscal/_EM_weektypePost.cfc?method=insertWorkingHours",
					data: { 
						start_send: start_send, 
						end_send: end_send, 
						p_id: p_id, 
						repeat_type: 'weekly', 
						status:'available', 
						weekday: weekday },
					success: function(response) {
					$('#alert-container-add').html('<div class="alert alert-success">Working hours added</div>');
					$('#calendar2').fullCalendar('renderEvent', {id: response, weekday: weekday, start:_start, end:_end, title: "WORKING HOURS", color: '#0070C0'});
					setTimeout(function() {
					$('#confirm-add-modal').modal('hide');
					$('#alert-container-add').html('');
					location.reload(); // Reload the page
					}, 1500);
						},

					error: function(xhr, status, error) {
							$('#alert-container-add').html('<div class="alert alert-danger">Working hours not added</div>');
							setTimeout(function() {
							$('#confirm-add-modal').modal('hide');
							$('#alert-container-add').html('');
							}, 1500);	
						}
				});
		}
	});
	</script>

</body>
</html>