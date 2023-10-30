
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />


  <title>
   LMS ALPHA
  </title>




  <style>

    html, body {
      margin: 0;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;
    }

    #calendar {
      max-width: 1100px;
      margin: 40px auto;
    }

  </style>



  <link href='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.8.0/main.min.js'></script>

  


  <script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
height:'auto',
editable:true,
headerToolbar: false,
allDaySlot:false,
		events : [{
		start : "2021-06-24T04:30:00Z",
		end: "2021-06-24T05:30:00Z",
		resourceId:"1"		
		}],
		
		
	
		select: function(info) {
	


	 
        <!--- alert('selected ' + info.startStr + ' to ' + info.endStr + ' on resource ' + info.resource.id); --->
		<!--- var title = prompt("event content :"); --->
		<!--- if(title){ --->
		eventData = {
		start : info.startStr,
		end: info.endStr,
		resourceId: info.resource.id,
		eventBackgroundColor:'FFA000'
		<!--- } --->
		
		}
		<!--- alert(eventData.start); --->
	  calendar.addEvent(eventData);
      },
	selectable:true,
	selectOverlap:false,
	slotMinTime: '06:00:00',
	slotMaxTime: '23:00:00',
	slotDuration:'00:30:00',
		schedulerLicenseKey: '0280993211-fcs-1624293316',
		timeZone: 'UTC',
		initialView: 'resourceTimeGridDay',
		resources: [
		{ id: '1', title: 'Monday' },
		{ id: '2', title: 'Tuesday'},
		{ id: '3', title: 'Wednesday' },
		{ id: '4', title: 'Thursday' },
		{ id: '5', title: 'Friday' },
		{ id: '6', title: 'Saturday' },
		{ id: '7', title: 'Sunday' },
		],
		
		
		
    });

    calendar.render();
	
	
	 
	 
  });

</script>
<style>

  .fc-today {
    background: transparent !important; /* hack. because demo will always start out on current day */
  }

</style>

</head>
<body>


  <div id='calendar'></div>
</body>

</html>





<cfabort>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />


  <title>

  </title>




  <style>

    html, body {
      margin: 0;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;
    }

    #calendar {
      max-width: 1100px;
      margin: 40px auto;
    }

  </style>



<link href='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.8.0/main.min.js'></script>





  <script>

  document.addEventListener('DOMContentLoaded', function() {
  
	schedulerLicenseKey: '0280993211-fcs-1624293316',
	
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      timeZone: 'UTC',
      initialView: 'resourceTimeGridDay',
      resources: [
		{id: 'a', title: 'Lundi'},
		{id: 'b', title: 'Mardi'},
		{id: 'c', title: 'Mercredi'},
		{id: 'd', title: 'Jeudi'},
		{id: 'e', title: 'Vendredi'},
		{id: 'f', title: 'Samedi'},
		{id: 'g', title: 'Dimanche'}
      ],
	  selectable:true,
	  select: function(start,end,allday) {

			<!--- var start_send = $.fullCalendar.moment(start).format('YYYY-MM-DD_HH-mm-ss'); --->
			<!--- var end_send = $.fullCalendar.moment(end).format('YYYY-MM-DD_HH-mm-ss'); --->
			
			<!--- $('#window_item_lg').modal({keyboard: true}); --->
			<!--- if(avail_choice == "remove") --->
			<!--- { --->
				<!--- $('#modal_title_lg').text("Retirer disponibilit\u00e9"); --->
			<!--- } --->
			<!--- else --->
			<!--- { --->
				<!--- $('#modal_title_lg').text("Ajouter disponibilit\u00e9"); --->
			<!--- } --->
			<!--- $('#modal_body_lg').load("modal_window_blocker.cfm?start="+start_send+"&end="+end_send+"&p_id=<cfoutput>#p_id#</cfoutput>&avail_choice="+avail_choice, function() {}) --->
				
		},
		
      events: 'https://fullcalendar.io/demo-events.json?with-resources=4&single-day'
    });

    calendar.render();
  });

</script>
<style>

  .fc-today {
    background: transparent !important; /* hack. because demo will always start out on current day */
  }

</style>

</head>
<body>
  <div class='demo-topbar'>
  <button data-codepen class='codepen-button'>Edit in CodePen</button>

  

  
    1-day vertical resource view
  
</div>

  <div id='calendar'></div>
</body>

</html>
