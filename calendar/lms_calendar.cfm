<cfparam name="view_select" default="calendar">
<!---<cfparam name="tz_id" default="#SESSION.USER_TIMEZONE_ID#">--->
<!---<cfset obj_getevent = createobject("component", "manager.lms.remote")>--->

<!---
<cfquery name="get_timezone" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_timezone
</cfquery>--->

<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<div id="calendar"></div> 
	
<cfelse>
<div class="card">

	<div class="card-body">
						
		<div class="row">
			
			<div class="col-md-12">

				<cfif SESSION.USER_PROFILE eq "learner">
					<h4 class="card-title">Mon calendrier</h4>
					<br>
					<br>
					
					<div id="calendar"></div> 
					
					<!---<h4 class="card-title">Calendrier</h4>
					<br>
					<div class="btn-group" data-toggle="buttons">
					<cfoutput query="get_trainer_user">
					<a class="btn btn-sm btn-info">
						<input type="radio" class="select_trainer_availability <cfif isdefined("t_id") AND t_id eq user_id>focus active</cfif>" name="select_trainer_availability" id="avail_#user_id#" value="#user_id#" <cfif isdefined("t_id") AND t_id eq user_id>checked</cfif>> #obj_lms.get_thumb(user_id="#user_id#",size="30")# #user_firstname#
					</a>
					<!----<input class="select_trainer_availability" id="#user_id#" type="checkbox" value="#user_id#"><label for="#user_id#">#obj_lms.get_thumb(user_id="#user_id#",size="30")# #user_firstname# #user_name#</label>---> 
					</cfoutput>
					</div>
					<br><br>--->
					
				<cfelseif SESSION.USER_PROFILE eq "trainer">
				
					<cfif isdefined("display_lesson")>
						<div class="row">			
							<div class="col-md-12 mb-3">
								<cfform>
								<cfselect id="change_learner" name="change_learner" query="get_learner_trainer" display="user_contact" value="user_id" class="form-control change_learner" selected="#u_id#">
								<option value="0" <cfif u_id eq "0">selected</cfif>>---ALL MY LEARNERS---</option>
								</cfselect>
								</cfform>				
							</div>
						</div>
					<cfelseif isdefined("display_avail")>
						<h4 class="card-title mt-0 mr-3 float-left"></h4>
						
						
						
						<!---<div class="float-left"><select name="avail_choice" id="avail_choice" class="form-control"><option value="remove">Enlever dispo</option><option value="add">Ajouter dispo</option></select></div>--->
											
		
<!---
<div class="btn-group btn-group-toggle" data-toggle="buttons">
<cfoutput>	
<label class="btn btn-info avail_choice">
	<input type="radio" name="avail_choice_check" id="avail_choice_check_1" value="add"> #obj_translater.get_translate('card_trainer_avail_add')#
</label>
<label class="btn btn-info avail_choice">
	<input type="radio" name="avail_choice_check" id="avail_choice_check_2" value="remove"> #obj_translater.get_translate('card_trainer_avail_remove')#
</label>
</cfoutput>	
</div>--->
<cfoutput>

<label><h5 class="m-0"><input type="radio" class="avail_choice_check" name="avail_choice_check" id="avail_choice_check_1" value="add"> #obj_translater.get_translate('card_trainer_avail_add')#</h5></label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<label><h5 class="m-0"><input type="radio" class="avail_choice_check" name="avail_choice_check" id="avail_choice_check_2" value="remove" checked="yes"> #obj_translater.get_translate('card_trainer_avail_remove')#</h5></label>

</cfoutput>



						
						<div class="clearfix" style="height:30px"></div>
						
						
					
					</cfif>
					
					<div id="calendar"></div> 

				</cfif>

	
<!----<cfform>
<cfselect name="tz_id" id="tz_id" query="get_timezone" value="timezone_id" display="timezone_text" selected="#tz_id#"></cfselect>
</cfform>
		<br><br>--->
		

		
		<!---
<select id='timezone-selector'>
	<option value='' selected>none</option>
	<option value='local'>local</option>
	<option value='UTC'>UTC</option>
	<option value='America/Chicago'>America/Chicago</option>

</select>--->
		
		<!---<h3>Calendar</h3>
		<hr>--->


				

				<!---<br><br>
				
				<cfloop query="get_lesson_status">
				<cfoutput>
				<span class="badge badge-#get_lesson_status.status_css#">#get_lesson_status.status_name#</span>
				</cfoutput>
				</cfloop>--->
			</div>

		</div>
				
		
	</div>

</div>
</cfif>