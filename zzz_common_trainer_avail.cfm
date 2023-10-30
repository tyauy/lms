<!DOCTYPE html>

<cfsilent>

<cfquery name="get_workinghour" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user_workinghour WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>

<cfif get_workinghour.recordcount eq "0" AND isdefined("create")>
<cfquery name="ins_workinghour" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user_workinghour 
(
user_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
)
</cfquery>

<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
SELECT max(workinghour_id) as id FROM user_workinghour
</cfquery>

<cfquery name="get_workinghour" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user_workinghour WHERE workinghour_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
</cfquery>
</cfif>



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
	</style>

</head>



<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfoutput><cfset title_page = #obj_translater.get_translate("title_page_common_trainer_avail")#></cfoutput>
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif isdefined("k")>
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em><cfoutput>#obj_translater.get_translate("alert_modif_ok")#</cfoutput></em></div>
			</div>
			</cfif>
		
			<cfinclude template="./incl/incl_nav_trainer.cfm">

			
			<cfset list_day = "mon,tue,wed,thu,fri,sat,sun">
			<form action="updater_avail.cfm" method="post" id="scheduler_go">
			<div class="row">
	
				<div class="col-md-6">
				
					<div class="card border">
						<div class="card-body">
							<cfif get_workinghour.recordcount neq "0">
								<cfset planner_view = "edit"> 
								<cfinclude template="./widget/wid_planner.cfm">			
							<cfelse>
								<div class="alert alert-info">
								<cfoutput>
								#obj_translater.get_translate("alert_no_workinghour")# <a href="common_trainer_avail.cfm?p_id=#p_id#&create=1" class="btn">#obj_translater.get_translate("btn_create_profil")#</a>
								</cfoutput>
								</div>
							</cfif>									
						</div>
					</div>
				
				</div>
				
				<div class="col-md-6">
				
					<div class="card border">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#obj_translater.get_translate("card_trainer_edit_workinghour")#</cfoutput></h6>
							<br><br>
							
							<div class="border p-2">
								<label><h6><input type="radio" class="choice_calendar" name="choice_calendar" value="maj_only"> <cfoutput>#obj_translater.get_translate_complex('choice1_calendar_title')#</cfoutput></h6></label>
								<br>
								<small>
								
								<cfoutput>#obj_translater.get_translate_complex('choice1_calendar_explain')#</cfoutput>
								
								</small>
							</div>
							
							<div class="border p-2 mt-2">
								<label><h6><input type="radio" class="choice_calendar" name="choice_calendar" value="maj_both"> <cfoutput>#obj_translater.get_translate_complex('choice2_calendar_title')#</cfoutput></h6></label>
								<br>
								<small>
								
								<cfoutput>#obj_translater.get_translate_complex('choice2_calendar_explain')#</cfoutput>
								
								</small>
								<div class="control-group">
									<label for="date_schedule_from" class="control-label"><cfoutput>#obj_translater.get_translate('short_between')#</cfoutput></label>
									<div class="controls">
										<div class="input-group">
											<input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" />
											<label for="date_schedule_from" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
										</div>
									</div>
								</div>

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
							
							<!----<div class="border p-2 mt-2">
								<label><h6><input type="radio" name="choice_calendar">Effacer le planning &agrave; venir et appliquer ce calendrier</h6></label>
							</div>---->
							
							<div class="border p-2 mt-2">
								<label><h6><input type="radio" class="choice_calendar" name="choice_calendar" value="maj_adjust"> <cfoutput>#obj_translater.get_translate_complex('choice3_calendar_title')#</cfoutput></h6></label>
								<br><small>
								
								<cfoutput>#obj_translater.get_translate_complex('choice3_calendar_explain')#</cfoutput>
								
								</small>
								<div class="control-group">
									<label for="date_adjust_from" class="control-label"><cfoutput>#obj_translater.get_translate('short_between')#</cfoutput></label>
									<div class="controls">
										<div class="input-group">
											<input id="date_adjust_from" name="date_adjust_from" type="text" class="datepicker form-control" autocomplete="off" />
											<label for="date_adjust_from" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
										</div>
									</div>
								</div>

								<div class="control-group">
									<label for="date_adjust_to" class="control-label"><cfoutput>#obj_translater.get_translate('short_and')#</cfoutput></label>
									<div class="controls">
										<div class="input-group">
											<input id="date_adjust_to" name="date_adjust_to" type="text" class="datepicker form-control" autocomplete="off" />
											<label for="date_adjust_to" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
										</div>
									</div>
								</div>
								
							</div>
																
							
							<cfoutput>
								<input type="hidden" name="p_id" value="#p_id#">
								<input type="hidden" name="availability_updt" value="1">
								<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
							</cfoutput>
							
							
							<br>
						</div>
					</div>
				
				</div>
			</div>
			</form>
			
			
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
	$(function() {
		$("#date_schedule_from").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_schedule_to").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
		
		$("#date_adjust_from").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_adjust_to" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_adjust_to").datepicker({
			firstDay: 1,
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
			$( "#date_adjust_from" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
	
		$(".select_day").change(function() {
			if($(this).is(':checked'))
			{
				$("#colday_"+$(this).attr("id")).removeClass("bg-disabled");
				$("#colday_"+$(this).attr("id")).addClass("bg-white");
				
				$("#select_am_"+$(this).attr("id")).prop('disabled', false);
				$("#select_pm_"+$(this).attr("id")).prop('disabled', false);
				
				
				/*$("#start_am_"+$(this).attr("id")).prop('disabled', false);
				$("#end_am_"+$(this).attr("id")).prop('disabled', false);*/
			}
			else{
			
			
			
				
				$("#colday_"+$(this).attr("id")).removeClass("bg-white");
				$("#colday_"+$(this).attr("id")).addClass("bg-disabled");
				$("#colam_"+$(this).attr("id")).removeClass("bg-white");
				$("#colam_"+$(this).attr("id")).addClass("bg-disabled");
				$("#colpm_"+$(this).attr("id")).removeClass("bg-white");
				$("#colpm_"+$(this).attr("id")).addClass("bg-disabled");
				
				
				$("#select_am_"+$(this).attr("id")).prop('checked', false);
				$("#select_am_"+$(this).attr("id")).prop('disabled', true);
				$("#select_pm_"+$(this).attr("id")).prop('checked', false);
				$("#select_pm_"+$(this).attr("id")).prop('disabled', true);
				
				$("#day_"+$(this).attr("id")+"_start_am").prop('disabled', true);
				$("#day_"+$(this).attr("id")+"_end_am").prop('disabled', true);
				
				$("#day_"+$(this).attr("id")+"_start_pm").prop('disabled', true);
				$("#day_"+$(this).attr("id")+"_end_pm").prop('disabled', true);
				
				
				/*$("#start_am_"+$(this).attr("id")).prop('disabled', true);
				$("#end_am_"+$(this).attr("id")).prop('disabled', true);*/
			}
			
		});
		
		$(".select_am").change(function() {
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);
	
			if($(this).is(':checked'))
			{
				
				$("#colam_"+idtemp).removeClass("bg-disabled");
				$("#colam_"+idtemp).addClass("bg-white");
				$("#day_"+idtemp+"_start_am").prop('disabled', false);
				$("#day_"+idtemp+"_end_am").prop('disabled', false);
			}
			else{
				$("#colam_"+idtemp).removeClass("bg-white");
				$("#colam_"+idtemp).addClass("bg-disabled");
				$("#day_"+idtemp+"_start_am").prop('disabled', true);
				$("#day_"+idtemp+"_end_am").prop('disabled', true);
			}
		
		});
		
		$(".select_pm").change(function() {
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);
	
			if($(this).is(':checked'))
			{
				$("#colpm_"+idtemp).removeClass("bg-disabled");
				$("#colpm_"+idtemp).addClass("bg-white");
				$("#day_"+idtemp+"_start_pm").prop('disabled', false);
				$("#day_"+idtemp+"_end_pm").prop('disabled', false);
			}
			else{
				$("#colpm_"+idtemp).removeClass("bg-white");
				$("#colpm_"+idtemp).addClass("bg-disabled");
				$("#day_"+idtemp+"_start_pm").prop('disabled', true);
				$("#day_"+idtemp+"_end_pm").prop('disabled', true);
			}
		
		});
		
		$( "#scheduler_go" ).submit(function( event ) {
			if(!$('.choice_calendar').is(':checked'))
			{
			 alert("Faire un choix SVP...");
			 return false;
			}
		});
		
		
		
	});
</script>
	
</body>
</html>