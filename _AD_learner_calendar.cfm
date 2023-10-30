<!DOCTYPE html>

<cfsilent>

<cfif SESSION.USER_PROFILE eq "trainer">

	<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#SESSION.USER_ID#")>
	
</cfif>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_trainer_calendar')#">
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">
			
			
			<cfif SESSION.USER_PROFILE eq "trainer">
			<div class="row mb-3">			
				<div class="col-md-6">
					<cfform>
					<cfselect id="change_learner" name="change_learner" query="get_learner_trainer" display="user_contact" value="user_id" class="form-control change_learner" selected="#u_id#">
					</cfselect>
					</cfform>				
				</div>
			</div>
			</cfif>
			
			<div class="row">	
			
				<div class="col-md-12" align="center">				
					
					<div class="btn-group btn-group-toggle" data-toggle="buttons">
						<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">
						<label class="btn btn-info" onClick="document.location.href='common_tp_details.cfm'">
							<input type="radio" autocomplete="off" checked> <i class="fas fa-tasks mr-1"></i> <cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput>
						</label>
						<label class="btn btn-info active" onclick="document.location.href='learner_calendar.cfm'">
							<input type="radio" autocomplete="off"> <i class="far fa-calendar-alt mr-1"></i> <cfoutput>#obj_translater.get_translate('card_tp_calendar')#</cfoutput>
						</label>
						<cfelse>
						<cfoutput>
						<label class="btn btn-info" onClick="document.location.href='common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#'">
							<input type="radio" autocomplete="off" checked> <i class="fas fa-tasks mr-1"></i> <cfoutput>#obj_translater.get_translate('table_th_program_short')#</cfoutput>
						</label>
						<label class="btn btn-info active" onclick="document.location.href='learner_calendar.cfm?t_id=#t_id#&u_id=#u_id#'">
							<input type="radio" autocomplete="off"> <i class="far fa-calendar-alt mr-1"></i> <cfoutput>#obj_translater.get_translate('card_tp_calendar')#</cfoutput>
						</label>
						<label class="btn btn-info" onclick="document.location.href='common_learner_account.cfm?u_id=#u_id#'">
							<input type="radio" autocomplete="off"> <i class="fas fa-user mr-1"></i></i> <cfoutput>#obj_translater.get_translate('btn_view_profile')#</cfoutput>
						</label>
						</cfoutput>
						</cfif>
					</div>
					
				</div>
				
			</div>
			
			<div class="row mt-3">
			
				<div class="col-md-12">

					<div id="calendar"></div> 
				
				</div>
				
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<cfinclude template="./calendar/lms_calendar_param.cfm">

<script>
$( document ).ready(function() {

	<cfif SESSION.USER_PROFILE eq "trainer">
	
	$('.change_learner').change(function(){
		document.location.href="common_tp_details.cfm?u_id="+$(this).val();	
	})
	
	</cfif>
	
})
</script>

</body>
</html>