<!-- Add these dependencies for 'qtip' -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/qtip2/3.0.3/jquery.qtip.min.js"></script>

<!------- PARAM VIEW TO GET RID OF USELESS SPACE IN CALENDAR ----->
<cfif SESSION.USER_PROFILE eq "TRAINER" OR listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("p_id")>
	<cfset p_id = iif(SESSION.USER_PROFILE eq "TRAINER", SESSION.USER_ID, p_id)>

	<cfquery name="get_working_hour" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM user_business_hours
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>
	
	<cfset starting_list = []>
	<cfset ending_list = []>
	
	<cfloop query="get_working_hour">
		<cfset ArrayAppend(starting_list, get_working_hour.start_time)>
		<cfset ArrayAppend(ending_list, get_working_hour.end_time)>
	</cfloop>
	
	<cfif arrayLen(starting_list) neq 0>
		<cfset ArraySort(starting_list, "text", "asc")>
		<cfset start_view_hour = timeformat(dateadd("h", -3, starting_list[1]), 'HH:mm:ss')>
	
		<cfset ArraySort(ending_list, "text", "desc")>
		<cfif timeformat(ending_list[1], 'HH') LT 21>
			<cfset ending_view_hour = timeformat(dateadd("h", 3, ending_list[1]), 'HH:mm:ss')>
		<cfelse>
			<cfset ending_view_hour = "24:00:00">
		</cfif>
	</cfif>
</cfif>

<script>


<cfif not isdefined("picker")>
<cfset picker = dateformat(now(),"yyyy-mm-dd")>
</cfif>

var avail_choice = "remove";
var currentTimezone = "UTC";


$(document).ready(function() {
	
function renderCalendar() {
	
$('#calendar').fullCalendar({

	/**************COMMON****************/
	/*schedulerLicenseKey: '0542611006-fcs-1459164489',*/
	/*themeSystem: 'bootstrap4',*/
	/*nowIndicator:true,*/
	/*eventConstraint: "blocker",*/
	
	schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
	defaultDate: '<cfoutput>#picker#</cfoutput>',	
	timeFormat: 'H(:mm)',
	hiddenDays: [],
	lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
	axisFormat: 'HH:mm',
	allDaySlot: true,	
	defaultEventMinutes:15,
	timezone: currentTimezone,
	<cfif isdefined("cal_view")>
	defaultView: '<cfoutput>#cal_view#</cfoutput>',
	<cfelse>
	defaultView: 'agendaWeek',
	</cfif>	
	selectHelper: true,	
	firstDay: 1,
	<cfif SESSION.USER_PROFILE eq "trainer" OR ((listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND isdefined("p_id"))>
	<cfif isdefined("start_view_hour") AND start_view_hour neq "">
		<cfif start_view_hour gt ending_view_hour>
			minTime: '<cfoutput>#start_view_hour#</cfoutput>',
		<cfelse>
			minTime: '<cfoutput>#start_view_hour#</cfoutput>',
			maxTime: '<cfoutput>#ending_view_hour#</cfoutput>',
		</cfif>
		<cfelse>	
			minTime: '07:00:00',
			maxTime: '22:00:00',
		</cfif>
	<cfelse>
		minTime: '07:00:00',
		maxTime: '22:00:00',
	</cfif>
	slotDuration: '00:15:00',
	navLinks: true,
	editable: true,
	eventStartEditable: true,
	eventResizableFromStart: true,
	eventDurationEditable: true,
	droppable: true,
	selectable: true,
	
	<cfif !listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<cfif isdefined("cal_height")>
		height:<cfoutput>#cal_height#</cfoutput>,aspectRatio: 5,
		<cfelse>
		height:800,aspectRatio: 5,
		</cfif>
	<cfelse>
	height:800,aspectRatio: 5,
	</cfif>
	
		
	header: {
		left: 'prev,next today',
		center: 'title',
		<cfif isdefined("cal_view")>
			right: 'basicDay,basicWeek'
		<cfelse>
			right: 'month,agendaWeek'
		</cfif>
		
	},		

		
		/**************SOURCE****************/	
		eventSources: [
    <cfoutput>
        <cfset commaNeeded = false>
        <cfif SESSION.USER_PROFILE eq "LEARNER">
            "./calendar/get_data_lms_calendar.cfm?get_lesson=1&u_id=#SESSION.USER_ID#&user_side=learner"
            <cfset commaNeeded = true>
        <cfelseif SESSION.USER_PROFILE eq "TRAINER">
            <cfif (u_id eq "0" OR not isdefined("u_id"))>
                <cfif isdefined("fullview")>
					"./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#SESSION.USER_ID#"
                <cfelse>
					 "./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#SESSION.USER_ID#&short=1"
                </cfif>
                <cfset commaNeeded = true>
            <cfelseif isdefined("u_id") AND u_id neq SESSION.USER_ID>
                "./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#SESSION.USER_ID#&u_id=#u_id#"
                <cfset commaNeeded = true>
            <cfelse>
                "./calendar/get_data_lms_calendar.cfm?get_lesson=1&u_id=#SESSION.USER_ID#&user_side=trainer"
				"./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#SESSION.USER_ID#&u_id=#u_id#"
            </cfif>
            <cfif commaNeeded>, </cfif>
            "./calendar/get_data_lms_calendar.cfm?get_avail=1&p_id=#SESSION.USER_ID#",
            "./calendar/get_data_lms_calendar.cfm?get_blocker=1&p_id=#SESSION.USER_ID#&user_side=trainer",
			
            <cfset commaNeeded = false>
        <cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
            <cfif findnocase("cs_calendar.cfm",SCRIPT_NAME) OR findnocase("index.cfm",SCRIPT_NAME)>
                "./calendar/get_data_lms_calendar.cfm?get_lesson=1",
                "./calendar/get_data_lms_calendar.cfm?get_now=1"
                <cfset commaNeeded = true>
            <cfelseif findnocase("common_trainer_blocker.cfm",SCRIPT_NAME)>
                <cfif isdefined("p_id")>
                    "./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#p_id#",
                    "./calendar/get_data_lms_calendar.cfm?get_avail=1&p_id=#p_id#",
                    "./calendar/get_data_lms_calendar.cfm?get_blocker=1&p_id=#p_id#&user_side=trainer",
                    "./calendar/get_data_lms_calendar.cfm?get_lesson=1&u_id=#p_id#"
                </cfif>
            <cfelse>
                <cfif isdefined("p_id")>
                    "./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=#p_id#",
                    "./calendar/get_data_lms_calendar.cfm?get_avail=1&p_id=#p_id#",
                    "./calendar/get_data_lms_calendar.cfm?get_blocker=1&p_id=#p_id#&user_side=trainer",
                    "./calendar/get_data_lms_calendar.cfm?get_lesson=1&u_id=#p_id#"
                </cfif>
            </cfif>
        </cfif>
    </cfoutput>
],


		/**************END SOURCE****************/

		
		eventClick: function(event) {
			/*window.open(event.url, 'gcalevent', 'width=700,height=600');	*/

			if($.isNumeric(event.id))
			{
				$('#modal_title_lg').text("R\u00e9servation");
				$('#window_item_lg').modal({keyboard: true});
				$('#modal_body_lg').load("modal_window_event_light2.cfm?lesson_id="+event.id, function() {})
			}
			else{
			/*alert(event.icon);*/
				if(confirm("Remove blocker ?"))
				{
				document.location.href='updater_avail.cfm?del_blocker=1&p_id='+event.p_id+'&b_id='+event.b_id;
				}
			}
			
		},
		<cfif not isDefined("fullview")>
		eventRender: function(event, element) {
            // Add tooltip using 'qtip'
            element.qtip({
                content: {
                    text: event.titleWithBr // Use titleWithBr for the tooltip content
                },
                position: {
                    my: 'bottom center',
                    at: 'top center'
                },
                style: {
                    classes: 'qtip-bootstrap' // Use Bootstrap theme
                }
            });

            // Add the remove link if the event has icon and b_id properties
            if (event.icon && event.b_id) {
                element.find(".fc-title").after('<div align="right" style="float:right"><a class="text-danger">[remove]</a></div>');
            }
			// Add a line break in the event title
			var titleParts = event.title.split(' ');
			var firstWord = titleParts[0];
			var prefix = (firstWord.startsWith('[')) ? '' : '<strong>- ';

			var newTitle = prefix + firstWord + '</strong> ' + titleParts.slice(1, 3).join(' ') + '<br>' + titleParts.slice(3).join(' ');
			if (!firstWord.startsWith('[')) {
				newTitle += '</strong>';
			}
			element.find('.fc-title').html(newTitle);

        },
	</cfif>
	<cfif ((listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND findnocase("common_trainer_blocker.cfm",SCRIPT_NAME)) OR (SESSION.USER_PROFILE eq "trainer" AND findnocase("trainer_calendar.cfm",SCRIPT_NAME))>
		<cfif not isDefined("fullview")>
		eventRender: function(event, element) {
            // Add tooltip using 'qtip'
            element.qtip({
                content: {
                    text: event.titleWithBr // Use titleWithBr for the tooltip content
                },
                position: {
                    my: 'bottom center',
                    at: 'top center'
                },
                style: {
                    classes: 'qtip-bootstrap' // Use Bootstrap theme
                }
            });

            // Add the remove link if the event has icon and b_id properties
            if (event.icon && event.b_id) {
                element.find(".fc-title").after('<div align="right" style="float:right"><a class="text-danger">[remove]</a></div>');
            }

				// Add a line break in the event title
				var titleParts = event.title.split(' ');
				var firstWord = titleParts[0];
				var prefix = (firstWord.startsWith('[')) ? '' : '<strong>-';

				var newTitle = prefix + firstWord + '</strong> ' + titleParts.slice(1, 3).join(' ') + '<br>' + titleParts.slice(3).join(' ');
				if (!firstWord.startsWith('[')) {
					newTitle += '</strong>';
				}
				element.find('.fc-title').html(newTitle);


        },</cfif>
		select: function(start,end,allday) {

			var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss');
			var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss');
			
			$('#window_item_lg').modal({keyboard: true});
			if(avail_choice == "remove")
			{
				$('#modal_title_lg').text("Retirer disponibilit\u00e9");
			}
			else
			{
				$('#modal_title_lg').text("Ajouter disponibilit\u00e9");
			}
			$('#modal_body_lg').load("modal_window_blocker.cfm?start="+start_send+"&end="+end_send+"&p_id=<cfoutput>#p_id#</cfoutput>&avail_choice="+avail_choice, function() {})
				
		}
	
	</cfif>
	
});

	
}
/* $('#calendar').fullCalendar({
    // your other options here
    eventDrop: function(event, delta, revertFunc) {
      // validate the start date
      if (event.start.isBefore(moment())) {
          alert("You can't move events to past dates!");
          revertFunc();
      }
      // validate the end date
      else if(event.start.isAfter(event.end)){
          alert("The start date should be less than the end date");
          revertFunc();
      }
      // if the inputs are valid, send the updated event data to the server
      else {
          updateEvent(event);
      }
    },
  });
 */
	
$('.avail_choice_check').click(function() {

	var temp = $("input:radio[name='avail_choice_check']:checked").val();   
   
	if($(this).val() == "remove")
	{
		avail_choice = "remove";
		$('#calendar').fullCalendar('option','selectable',true);
		$('#calendar').fullCalendar('option','selectConstraint','trainer_avail');
		$('#calendar').fullCalendar('option','selectOverlap',true);
	}
	else
	{
		avail_choice = "add";
		$('#calendar').fullCalendar('option','selectable',true);
		$('#calendar').fullCalendar('option','selectOverlap','inverse-background');
	}
	
  
	renderCalendar();
})

renderCalendar();

});
</script>