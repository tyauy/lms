<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Aper&ccedil;u calendrier">
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">
		
			<!---<div class="row">
			
				<div class="col-md-4">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">S&eacute;lection statut</h6>
							<cfoutput query="get_lesson_status">
							<input type="checkbox" name="" value="#status_id#">#status_name#
							</cfoutput>
						</div>
					</div>
					
				</div>
				
				<div class="col-md-4">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">S&eacute;lection trainer</h6>
							<!---<cfform>
							<cfselect id="change_learner" name="change_learner" query="get_learner_trainer" display="user_contact" value="user_id" class="form-control change_learner mt-2" selected="#u_id#">
							<option value="0" <cfif u_id eq "0">selected</cfif>>---ALL MY LEARNERS---</option>
							</cfselect>
							</cfform>--->
						</div>
					</div>
					
				</div>
				
				<div class="col-md-4">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">Gestion dispo</h6>
							<!---<br>
							<cfoutput>
	
							<label class="mt-2"><h6 class="m-0"><input type="radio" class="avail_choice_check" name="avail_choice_check" id="avail_choice_check_1" value="add"> #obj_translater.get_translate('card_trainer_avail_add')#</h6></label>
							<br>
							<label><h6 class="m-0"><input type="radio" class="avail_choice_check" name="avail_choice_check" id="avail_choice_check_2" value="remove" checked="yes"> #obj_translater.get_translate('card_trainer_avail_remove')#</h6></label>

							</cfoutput>--->
						</div>
					</div>
					
				</div>
				
				
			</div>--->
			
			<div class="row">
			
				<div class="col-md-12">
					<cfset cal_view = "basicWeek">
					<div id="calendar"></div> 
				
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">


<cfinclude template="./incl/incl_scripts_modal.cfm">

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
	allDaySlot: false,	
	defaultEventMinutes:15,
	timezone: currentTimezone,
	<cfif isdefined("cal_view")>
	defaultView: '<cfoutput>#cal_view#</cfoutput>',
	<cfelse>
	defaultView: 'agendaWeek',
	</cfif>	
	selectHelper: false,	
	firstDay: 1,
	minTime: '06:00:00',
	maxTime: '23:00:00',
	slotDuration: '00:15:00',
	navLinks: true,
	editable: false,
	eventStartEditable: false,
	eventResizableFromStart: false,
	eventDurationEditable: false,
	droppable: false,

	height:800,aspectRatio: 5,
		
	header: {
		left: 'prev,next today',
		center: 'title',

			right: 'basicDay,basicWeek,month,agendaWeek'
		
	},		

		
		/**************SOURCE****************/	
		eventSources: [

			<cfoutput>

			<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
				"./calendar/get_data_lms_calendar.cfm?get_task=1",		
			</cfif>
			
			</cfoutput>
		],		
		/**************END SOURCE****************/

		
		eventClick: function(event) {

			if($.isNumeric(event.user_id))
			{
				$('#modal_title_xl').text("Commentaires Apprenant");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_log.cfm?u_id="+event.user_id, function() {})
			}
			
		},
			
	  
	<cfif ((listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND findnocase("common_trainer_blocker.cfm",SCRIPT_NAME)) OR (SESSION.USER_PROFILE eq "trainer" AND findnocase("trainer_calendar.cfm",SCRIPT_NAME))>
		
		eventRender: function(event, element) {
			if(event.icon && event.b_id){         
				element.find(".fc-title").after('<div align="right" style="float:right"><a class="text-danger">[remove]</a></div>');
			}
		}
	
	</cfif>
	
});

	
}


renderCalendar();

});
</script>

</body>
</html>