<!DOCTYPE html>

<cfsilent>
<cfif SESSION.USER_PROFILE eq "trainer">
	<cfset p_id = 140>
</cfif>


<cfquery name="get_user_slots" datasource="#SESSION.BDDSOURCE#">
    SELECT MIN(DATE(slot_start)) as earliest_date, MAX(DATE(slot_end)) as latest_date
    FROM user_slots
    WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>

<cfquery name="get_user_workingHours" datasource="#SESSION.BDDSOURCE#">
    SELECT *
    FROM user_business_hours ubh
    left join user u on u.user_id = ubh.user_id
    WHERE ubh.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>

<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id=Val("#p_id#"))>
</cfsilent>

<html lang="fr">
<cfset lang="#SESSION.LANG_CODE#">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
 #popover-btn {
    border: none;
    background-color: orange;
    border-radius: 2px !important;
  }
.small-card {
    width: 100px; 
    font-size: 0.8em; 
}


.btn.btn-danger.remove-time-slot {
    padding: 8px;
      margin-bottom: 5px; }
table,  td {
    border: none!important;
}
span {
    padding-left: .5em!important;
    padding-right: .5em!important;
}


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

   <!-- jQuery and Bootstrap JS -->
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

   <script>
 $(function () {
  $('.example-popover').popover({
    container: 'body'
  })
})
    </script>

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
			
					<div class="container">
                        <div class="row">
                            
                            <div class="container d-flex justify-content-center align-items-center">
                                <div class="row">
                                    <form action="" method="post" class="text-center">
                                        
                                            <label for="weekdate"><h4>1)Pick a week to see the availabilites for that week </h4></label><br>
                                       
                                        <input type="date" id="weekdate" name="weekdate">
                                       
                                    </form>
                                </div>
                            </div>
                            
                            
                            <div class=" ml-auto card bg-light col-12 ">
                                <div class="card-title text-center"><h4> 2) Insert new availabilities</h4></div>
                            
                                <div class="row justify-content-center">
                                    <div class="col-md-4 ">
                                        <div class="control-group">
                                            <label for="date_schedule_from" class="control-label"><cfoutput>#obj_translater.get_translate('short_between')#</cfoutput></label>
                                            <div class="controls">
                                                <div class="input-group">
                                                    <input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" />
                                                    <label for="date_schedule_from" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <label for="date_schedule_to" class="control-label"><cfoutput>#obj_translater.get_translate('short_and')#</cfoutput></label>
                                            <div class="controls">
                                                <div class="input-group">
                                                    <input id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" autocomplete="off" />
                                                    <label for="date_schedule_to" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                            
                                <div class="card-body">
                                    <div id="alert-container-add"></div>
                                    <div id="days" class="d-flex justify-content-center mb-3">
                            
                                        <!-- Add days of the week with their abbreviations -->
                                        <div class="day" data-day="Sunday" data-day-num="0" data-active="false">D</div>
                                        <div class="day" data-day="Monday" data-day-num="1" data-active="false">L</div>
                                        <div class="day" data-day="Tuesday" data-day-num="2" data-active="false">M</div>
                                        <div class="day" data-day="Wednesday" data-day-num="3" data-active="false">M</div>
                                        <div class="day" data-day="Thursday" data-day-num="4" data-active="false">J</div>
                                        <div class="day" data-day="Friday" data-day-num="5" data-active="false">V</div>
                                        <div class="day" data-day="Saturday" data-day-num="6" data-active="false">S</div>
                                    </div> <cfset letters = listToArray(evaluate('SESSION.DAYWEEK_#SESSION.LANG_CODE#_SHORT'))>

                                    <div class="table-container">
                                            <table class="table table-bordered">
                                                <tbody>
                                                    <!-- Table rows will be added dynamically -->
                                                </tbody>
                                                <cfoutput> <input type="hidden" id="#p_id#" value="#p_id#">
                                                    <input type="hidden" id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" />
                                                    <input type="hidden" id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" autocomplete="off" />
                                                </cfoutput>
                                            </table>

                                    </div>
                                  
                                      
                              
                                    <div class="d-flex justify-content-center">
                                       
                                            <input type="hidden" id="populate_avail" name="populate_avail" type="text" />
                                            <button id="submit_avail" type="submit" class="btn btn-primary" title="This populate availability slots but not update the business hours calendar.">Populate Availabilities</button>
                                   
                                </div>
                                </div>
                            </div>
                        </div>
					</div>
				</div>
				
				<div class="col-md-12">
				
					<cfset u_id = 0>
					<cfset display_avail = "1">
					
		
      
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
    $(document).ready(() => {

   
        window.onload = function() {
        var date = new Date();
        var day = ("0" + date.getDate()).slice(-2);
        var month = ("0" + (date.getMonth() + 1)).slice(-2);
        var today = date.getFullYear()+"-"+(month)+"-"+(day) ;
        document.getElementById("weekdate").value = today;
    };

        $('#weekdate').change(function() {
           
           updateDateLabel();
           // Clear the existing rows from the table
           
            $('tbody').empty();
            $('#alert-container-add').hide();
            updateBusinessHoursTable();
            $('.day').removeClass('bg-primary text-white')
            let dayElement = $('.day[data-day="' + weekdays[day] + '"]');
            // Add classes and attributes to the day element to indicate it is active
            dayElement.addClass('bg-primary text-white').attr('data-active', 'true');
        });

        function updateDateLabel() {
        var dateInput = document.getElementById('weekdate');
     
        var selectedDate = new Date(dateInput.value);
        var formattedDate = formatDate(selectedDate);
        dateInput.value = formattedDate;
        console.log("selected date: "+formattedDate)
    }

    function formatDate(date) {
        var dd = String(date.getDate()).padStart(2, '0');
        var mm = String(date.getMonth() + 1).padStart(2, '0'); //Months are zero based
        var yyyy = date.getFullYear();
        return yyyy + '-' + mm  + '-' + dd ;
    }

   



      /*   <cfoutput><cfset weekdays = listToArray(evaluate('SESSION.DAYWEEK_#SESSION.LANG_CODE#'))></cfoutput> */
    const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const p_id = <cfoutput>#p_id#</cfoutput>;
    let dataChanged = false;
   // Now using the values from the datepicker input fields
   let selectedFromDate = new Date();
    let selectedToDate = new Date();
    selectedToDate.setFullYear(selectedToDate.getFullYear() + 1);
    
    // Datepickers for the start and end dates
$("#date_schedule_from").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
                selectedFromDate = $(this).datepicker('getDate');
                console.log(selectedFromDate);
			$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_schedule_to").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
            // When the datepicker is closed, the minDate of the "to" datepicker is set to the selected date
			onClose: function( selectedDate ) {
                selectedToDate = $(this).datepicker('getDate');
                console.log(selectedToDate);
			$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
			}
		}); 
    
    const getParameterByName = (name, url = window.location.href) => {
        name = name.replace(/[[\]]/g, '\\$&');
        const regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)');
        const results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    };

   

    const fetchWorkingHours = async () => {
    const p_id = getParameterByName("p_id");
    let weekdate_input = document.getElementById('weekdate') ? document.getElementById('weekdate').value : null;

    // If weekdate_input is null or undefined, set it to today's date
    if (!weekdate_input) {
        let today = new Date();
        weekdate_input = `${today.getFullYear()}-${('0' + (today.getMonth()+1)).slice(-2)}-${('0' + today.getDate()).slice(-2)}`;
    }

    const weekdate = moment(weekdate_input, "YYYY-MM-DD").format("YYYY-MM-DD");
    console.log("weekdate in fetch working hours: "+weekdate)

    try {
        const response = await fetch(`./calendar/_EM_get_data_lms_calendar.cfm?get_slots=1&p_id=${p_id}&weekdate=${weekdate}`);
        if (!response.ok) throw new Error(`Error status code: ${response.status}`);
        const data = await response.json();
        console.log(data)
        const workingHours = data.map(item => ({ start: item.start, end: item.end, id: item.id, day: item.daysOfWeek }));
        return workingHours;
    } catch (error) {
        console.error("Error fetching working hours:", error);
        return [];
    }
}




    // Table row operations
    const addTimeSlot = (row, timeSlot = {}) => { console.log('Row: ', row);
        // The lastEndTime variable is set to '17:00' if no row with class 'time-slots' exists. If such a row exists, it will take the value of the last time slot's end time.
        let lastEndTime = (row && row.find('.time-slots .input-group').length > 0) ? 
            row.find('.time-slots .input-group:last .end-time').val() : 
            '17:00';

            // The lastEndTime variable is split into its constituent parts (hours and minutes).
        let lastEndTimeParts = lastEndTime.split(':');

        // defaultStartTimeDate is initialized to an hour later than the last end time.
        // A new date is created for 1970-01-01T and the lastEndTimeParts for hour and minute is concatenated to it.
        // 60*60*1000 milliseconds (1 hour) is added to get the default start time.
        let defaultStartTimeDate = new Date(new Date('1970-01-01T' + lastEndTimeParts[0] + ':' + lastEndTimeParts[1]).getTime() + 60 * 120 * 1000);
        
        // If the hour of default start time is more than or equal to 24,
        // the time is adjusted to be 23:59 to stay within a valid 24-hour range.
        if (defaultStartTimeDate.getHours() >= 24) {
            defaultStartTimeDate.setHours(23);
            defaultStartTimeDate.setMinutes(59);
        }
        
        // defaultStartTime is extracted from defaultStartTimeDate and converted to a string.
        let defaultStartTime = defaultStartTimeDate.toISOString().substr(11, 5);
        // defaultEndTimeDate is set to be an hour after defaultStartTimeDate
        let defaultEndTimeDate = new Date(defaultStartTimeDate.getTime() + 60 * 60 * 1000);
        
        // Ensure the default end time is within the valid range
        if (defaultEndTimeDate.getHours() >= 24) {
            defaultEndTimeDate.setHours(23);
            defaultEndTimeDate.setMinutes(59);
        }
        
        let defaultEndTime = defaultEndTimeDate.toISOString().substr(11, 5);

        // A new div element with class 'input-group' is created.
        // This div element contains start time and end time input fields and a remove button for this time slot.
        // The start time and end time values are set to the values passed in the timeSlot parameter, or they default to defaultStartTime and defaultEndTime.
        // An onChange event listener is added to update the database whenever a value in this div changes.
        let inputGroup = $('<div>').addClass('input-group').append(
            $('<span>').addClass('input-group-addon').text('From'),
            $('<input>').addClass('form-control start-time').attr({
                'type': 'time',
                'step': '1800',
                'value': timeSlot.startTime || defaultStartTime
            }),
            $('<span>').addClass('input-group-addon').text('to'),
            $('<input>').addClass('form-control end-time').attr({
                'type': 'time',
                'step': '1800',
                'value': timeSlot.endTime || defaultEndTime
            }),
            $('<span>').addClass('input-group-btn').append(
                $('<button>').addClass('btn btn-danger remove-time-slot').text('-')
            )
        ).on('change', function() {
            toggleMinusButton(row);
            
        });
        
        if (row) {
        let timeSlotsDiv = row.find('.time-slots');
        if (timeSlotsDiv.length === 0) {
            // If .time-slots div does not exist, create it and append it to row
            timeSlotsDiv = $('<div>').addClass('time-slots');
            row.append(timeSlotsDiv);
        }
        // Append the new inputGroup to the .time-slots div
        timeSlotsDiv.append(inputGroup);
    }


        return inputGroup;
};

    const removeTableRow = (day) => {  let row = $('tbody tr[data-day="' + day + '"]');
        if (row.length) {
            row.remove();
        } };
    
  

        const addTableRow = (day, startTime, endTime) => {
    console.log('addTableRow - day:', day, 'startTime:', startTime, 'endTime:', endTime);

    let weekday = weekdays[day];
    let row = $('tbody tr ').filter(function () {
        return $(this).find('td:first').text() === (weekday || day);
    });

    // Log how many rows matched the filter
    console.log("Filtered rows: " + row.length);

    if (row.length) {
        addTimeSlot(row, { startTime, endTime });
    } else {
        // Create .time-slots div, add the first time slot into it
        let timeSlotsDiv = $('<div>').addClass('time-slots').append(addTimeSlot(null, { startTime: startTime || '09:00', endTime: endTime || '17:00' }));

        row = $('<tr>').attr({
            'data-day': weekday,
            'data-day-num': day,
            'data-add': "yes"
        }).append(
            $('<td>').text(weekday || day),
            $('<td>').append(timeSlotsDiv),
            $('<td>').append($('<button type="button">').addClass('add-time-slot btn btn-primary').text('+'))
        );

        // Log the details of the row being added
        console.log("Adding row with day: " + weekday + " and times: " + startTime + "-" + endTime);

        let inserted = false;
        $('tbody tr').each(function () {
            let currentDay = $(this).attr('data-day');
            if (weekdays.indexOf(weekday) < weekdays.indexOf(currentDay)) {
                $(this).before(row);
                inserted = true;
                return false;
            }
        });

        if (!inserted) {
            $('tbody').append(row);
        }
    }

    return row;
};




    const toggleMinusButton = (row) => { let timeSlots = row.find('.time-slots .input-group');
	if (timeSlots.length > 1) {
		timeSlots.find('.remove-time-slot').show();
	} else {
		timeSlots.find('.remove-time-slot').hide();
	} };


   const updateBusinessHoursTable = async () => { console.log("calling update function");
        let workingHoursArray = [];
            // Fetch the working hours data asynchronously
            workingHoursArray = await fetchWorkingHours();
            console.log("Working hours array:", workingHoursArray);
            // Create an object to store the working hours for each day
            const dayHours = {};
            // Iterate over the working hours data array
            workingHoursArray.forEach(eventData => {
                // Destructure the eventData object to extract relevant properties
                const { day, start: startTime, end: endTime, id } = eventData;
                // If the day is not already in dayHours, initialize it as an empty array
                if (!dayHours[day]) dayHours[day] = [];
                // Push the working hours for the current day to the dayHours object
                dayHours[day].push({ startTime, endTime, id });
            });


            // Iterate over the dayHours object using Object.entries to get [day, hours] pairs
            Object.entries(dayHours).forEach(([day, hours]) => {
                // Iterate over the working hours for the current day
                hours.forEach(({ startTime, endTime, id }) => {
                    console.log(`Day: ${day}, Start time: ${startTime}, End time: ${endTime}, ID: ${id}`);
                    // Add a table row for the current working hours
                    let row = addTableRow(day, startTime, endTime);
                    console.log("addTableRow function called");
                    // Find the day element with the corresponding data-day attribute
                    let dayElement = $('.day[data-day="' + weekdays[day] + '"]');
                    // Add classes and attributes to the day element to indicate it is active
                    dayElement.addClass('bg-primary text-white').attr('data-active', 'true');
            
                });
            }); 
    };
    //Call the updateBusinessHoursTable function once the document is ready
    updateBusinessHoursTable();
  
    // On click event handlers
    $('.day').on('click', function () { let day = $(this).data('day');
    let isActive = $(this).data('active');
    let row = $('tbody tr[data-day="' + day + '"]');
    $(this).data('active', !isActive);
    $(this).toggleClass('bg-primary text-white');
    

    if (!isActive) {
        addTableRow(weekdays.indexOf(day));
    } else {
        removeTableRow(day);
    } })
    $('table').on('click', '.add-time-slot', function() {let row = $(this).closest('tr');
	addTimeSlot(row);

    console.log("addTimeSlot function triggered")})
    
    $('table').on('click', '.remove-time-slot', function() { $(this).closest('.input-group').remove();
	toggleMinusButton($(this).closest('tr'));})


    // Track changes in time inputs
    $('input[type="time"]').on('change', () => dataChanged = true);

    $("#submit_avail").off("click").on("click", async (e) => {  e.preventDefault(); 

            // Create an array to hold the data
            var workingHours = [];
            console.log($("tr[data-add='yes']").length + " rows found.");

            // Iterate over each table row
            $("tr[data-add='yes']").each(function()  {
                console.log($(this).find(".input-group").length + " input groups found in this row.");
                console.log('Row:', this);
                var day = $(this).data("day-num");

                // Find each input-group within the row
                $(this).find(".input-group").each(function() {
                    console.log('Input group:', this);
                    // Get the start and end times from the input-group
                    var startTime = $(this).find(".start-time").val();
                    var endTime = $(this).find(".end-time").val();
                    // Check if this entry already exists in the array
                    var duplicate = workingHours.find(function(item) {
                                return item.day === day && item.start_send === startTime && item.end_send === endTime;
                            });

                        
                // If this entry doesn't already exist, add it to the array
                    if (!duplicate) {
                        workingHours.push({
                            day: day,
                            start_send: startTime,
                            end_send: endTime
                        });
                    }
                });
            });
            console.log(workingHours)
            selectedFromDate = $('#date_schedule_from').val();
            selectedToDate = $('#date_schedule_to').val();
                const data = {
                    
                    from: selectedFromDate,
                    to: selectedToDate,
                    p_id: p_id, 
                    workingHours: JSON.stringify(workingHours)
                };
                console.log(data);

                // Send it to the server
                $.ajax({
                    url: './api/trainerscal/_EM_weektypePost.cfc?method=insertAvails',
                    type: 'POST',
                    data: data,
                    success: function(response)  {
                    $('#alert-container-add').html('<div class="alert alert-success">Avail slot added</div>');
                    console.log(response)
                    // Create an empty string to hold the HTML
                    let html = '';

                    // Append the recordCount
                    html += `<div class="alert alert-success">${response.recordCount}</div>`;

                    // Append the deleted slots
                    html += 'Deleted slots:<br>';
                    for (let i = 0; i < response.deletedSlots.length; i++) {
                        let slot = response.deletedSlots[i];
                        html += `From ${slot.slot_start} to ${slot.slot_end}<br>`;
                    }

                    // Append the new slots
                    html += 'New slots:<br>';
                    for (let i = 0; i < response.slots.length; i++) {
                        let slot = response.slots[i];
                        html += `From ${slot.slot_start} to ${slot.slot_end}<br>`;
                    }

                    // Set the HTML of the #bdd-info div
                    $('#bdd-info').html(html);
                },
                    error: function() {
                        $('#alert-container-add').html('<div class="alert alert-danger">Avail slot not added</div>');
                    
                    }
                }); 
                

                // Reset the flag after the AJAX request
                dataChanged = false; })
});


</script>

</body>
</html>