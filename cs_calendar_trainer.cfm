<!DOCTYPE html>

<cfsilent>

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
		
			<div class="row">
			
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
				
				
			</div>
			
			<div class="row">
			
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

	$('.change_learner').change(function(){
		document.location.href="trainer_calendar.cfm?u_id="+$(this).val();	
	})

})
</script>

</body>
</html>