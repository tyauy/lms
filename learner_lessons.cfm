<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,7,9">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

<cfset get_lessons_scheduled = obj_query.oget_lessons_scheduled(u_id="#SESSION.USER_ID#",tselect="#tselect#")>
<cfset get_lessons_missed = obj_query.oget_lessons_missed(u_id="#SESSION.USER_ID#",tselect="#tselect#")>
<cfset get_lessons_inprogress = obj_query.oget_lessons_inprogress(u_id="#SESSION.USER_ID#",tselect="#tselect#")>
<cfset get_lessons_completed = obj_query.oget_lessons_completed(u_id="#SESSION.USER_ID#",tselect="#tselect#")>

<cfif get_lessons_scheduled.m neq ""><cfset lesson_scheduled = get_lessons_scheduled.m><cfelse><cfset lesson_scheduled = 0></cfif>
<cfif get_lessons_inprogress.m neq ""><cfset lesson_inprogress = get_lessons_inprogress.m><cfelse><cfset lesson_inprogress = 0></cfif>
<cfif get_lessons_missed.m neq ""><cfset lesson_missed = get_lessons_missed.m><cfelse><cfset lesson_missed = 0></cfif>
<cfif get_lessons_completed.m neq ""><cfset lesson_completed = get_lessons_completed.m><cfelse><cfset lesson_completed = 0></cfif>

<cfset learner_lesson_done = lesson_inprogress+lesson_completed>
<cfset trainer_lesson_done = lesson_completed>

<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>

<cfset __btn_support_short = obj_translater.get_translate('btn_support_short')>
<cfset __btn_notes_short = obj_translater.get_translate('btn_notes_short')>
</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
	h1,h2,h3,h4,h5,h6{
		font-family: 'Titillium Web', sans-serif;
	}
</style>

<body>

<div class="wrapper">
    
	
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<!--- <cfset title_page = "#obj_translater.get_translate('title_page_activity_report')#"> --->
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
            <cfinclude template="./incl/incl_nav_visio.cfm">

			<div class="row mt-3">
			
				<div class="col-md-12 mb-3">

					<div class="card-deck">
						
						<div class="card mb-3 border">
							<div class="card-body">
								
								<h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_trainer_period')#</cfoutput> : <strong class="text-red"><cfoutput>#mlongsel# #ysel#</cfoutput></strong></h5>
								<hr class="mt-0 border-red">


								<!--- <div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-calendar-lines-pen fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_trainer_period')#</cfoutput> : <strong class="text-danger"><cfoutput>#mlongsel# #ysel#</cfoutput></strong></h5>
									<hr class="border-dark mb-1 mt-2">
								</div> --->

								<div class="row">
									<div class="col-md-12 mt-4">
									<cfform action="learner_lessons.cfm">
									<div class="form-row">
										<div class="col">
										
											<select class="form-control" name="msel">

											<cfloop from="1" to="12" index="m">
											<cfoutput>
												<cfif SESSION.LANG_CODE neq "fr">
												<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
												<cfelse>
												<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
												</cfif>
												
												
											</cfoutput>
											</cfloop>
											</select>
										</div>
										
										<div class="col">
										
											<select class="form-control" name="ysel">
											<cfloop from="2019" to="#year(now())+1#" index="y">
											<cfoutput>
												<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
											</cfoutput>
											</cfloop>
											</select>
										</div>
										
										<div class="col">
											<input type="submit" value="GO" class="btn btn-sm btn-info">
											<a href="learner_lessons.cfm" class="btn btn-sm btn-outline-info"><cfoutput>#obj_translater.get_translate('btn_trainer_thismonth')#</cfoutput></a>
										</div>
									</div>
									</cfform>
									</div>
								</div>
							</div>
						</div>

						<div class="card mb-3 border">
							<div class="card-body">

								<h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_tp_hours')#</cfoutput></h5>
								<hr class="mt-0 border-red">

								<!--- <div class="w-100">
									<h5 class="d-inline"><i class="fa-thin fa-chart-column fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_tp_hours')#</cfoutput></strong></h5>
									<hr class="border-dark mb-3 mt-2">
								</div> --->

								<cfoutput>	
								<button type="button" class="btn btn btn-warning p-2" onclick="location.href='learner_lessons.cfm?st_id=1'"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-capitalize"><cfif lesson_scheduled neq "0">#obj_lms.get_format_hms(toformat="#lesson_scheduled#",unit="min")#<cfelse>-</cfif></h3></button>
								<button type="button" class="btn btn btn-success p-2" onclick="location.href='learner_lessons.cfm?st_id=2'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_inprogress')#<br><h3 class="m-0 text-capitalize"><cfif lesson_inprogress neq "0">#obj_lms.get_format_hms(toformat="#lesson_inprogress#",unit="min")#<cfelse>-</cfif></h3></button>
								<button type="button" class="btn btn btn-success p-2" onclick="location.href='learner_lessons.cfm?st_id=5'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif lesson_completed neq "0">#obj_lms.get_format_hms(toformat="#lesson_completed#",unit="min")#<cfelse>-</cfif></h3></button>
								<button type="button" class="btn btn btn-danger p-2" onclick="location.href='learner_lessons.cfm?st_id=4'"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-capitalize"><cfif lesson_missed neq "0">#obj_lms.get_format_hms(toformat="#lesson_missed#",unit="min")#<cfelse>-</cfif></h3></button>
								</cfoutput>
							</div>
						</div>
					</div>
				</div>				
			</div>
			
			
			
			<div class="row">
			
				<div class="col-md-12">
					<div class="card mb-3 border">
						<div class="card-body">
							
							<!--- <div class="w-100">
								<h5 class="d-inline"><i class="fa-thin fa-list-ul fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('global_details')#</cfoutput></strong></h5>
								<hr class="border-dark mb-3 mt-2">
							</div> --->
								
							<h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('global_details')#</cfoutput></h5>
							<hr class="mt-0 border-red">
							
							<cfset show_tab = "0">
							<cfset period_month = "#ysel#-#msel#">
							
							<cfinclude template="./widget/wid_lesson_list_learner.cfm">
							
						</div>
					</div>
				
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


</body>
</html>