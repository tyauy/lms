<cfsilent>

<cfif show_tab eq "0">

	<cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT status_id, status_name_#SESSION.LANG_CODE# as status_name, status_css, status_bootstrap 
	FROM lms_lesson_status 
	WHERE status_id <> 3 
	UNION (SELECT 0 as status_id, "#obj_translater.get_translate('global_all')#" as status_name, "" as status_css, "" as status_bootstrap) 
	ORDER BY status_id
	</cfquery>

	<cfoutput query="get_lesson_status">

		<cfif isdefined("period_month")>
			<cfset "get_lesson_#status_id#" = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",st_id="#status_id#",period_month="#period_month#")>
		<cfelse>
			<cfset "get_lesson_#status_id#" = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",st_id="#status_id#")>
		</cfif>
		
	</cfoutput>

<cfelseif show_tab neq "0" AND show_tab neq "week" AND show_tab neq "today">

	<cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT status_id, status_name_fr as status_name, status_css, status_bootstrap 
	FROM lms_lesson_status 
	UNION (SELECT 0 as status_id, "Tous" as status_name, "" as status_css, "" as status_bootstrap) 
	ORDER BY status_id
	</cfquery>
	
	<cfif isdefined("period_month")>
		<cfset "get_lesson_#show_tab#" = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",st_id="#show_tab#",period_month="#period_month#")>
	<cfelse>
		<cfset "get_lesson_#show_tab#" = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",st_id="#show_tab#")>
	</cfif>
	
<cfelseif show_tab eq "week">

	<cfset diff = 2 - DayOfWeek(now())>
	<cfset mondayDate = dateAdd("d", diff, now())>
	<cfset sundayDate = dateAdd("d", 5, mondayDate)>
		
	<cfset get_lesson_week = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",start_range="#mondayDate#",end_range="#sundayDate#")>
		
<cfelseif show_tab eq "today">
		
	<cfset get_lesson_week = obj_query.oget_lessons(u_id="#SESSION.USER_ID#",start_range="#now()#",end_range="#now()#")>
	
</cfif>

<cfset p_id = SESSION.USER_ID>

<cfif isdefined("get_tp.tp_id") AND get_tp.recordcount neq "0">
	<cfset tpcor = get_tp.tp_id>
<cfelse>
	<cfset tpcor = 0>
</cfif>


</cfsilent>

<cfif show_tab eq "0">
	<cfparam name="st_id" default="0">
	<ul class="nav nav-tabs" role="tablist" id="tabs_lessons">

		<cfoutput query="get_lesson_status">
		<li class="nav-item">
			<a class="nav-link <cfif st_id eq status_id>active</cfif>" href="##tab_#tpcor#_#status_id#" role="tab" data-toggle="tab" id="title_#status_id#">#status_name#</a>
		</li>
		</cfoutput>

	</ul>
</cfif>

<cfif show_tab neq "week" AND show_tab neq "today">

<div class="tab-content" id="myTabContent">

	<cfloop query="get_lesson_status">
	<cfif show_tab eq "0">
	<div class="tab-pane fade <cfif get_lesson_status.status_id eq st_id>show active</cfif>" <cfoutput>id="tab_#tpcor#_#get_lesson_status.status_id#"</cfoutput> role="tabpanel" aria-labelledby="home-tab" id="title_#status_id#">
	</cfif>
		<cfif show_tab eq get_lesson_status.status_id OR show_tab eq "0">
		<cfif evaluate("get_lesson_#status_id#.recordcount") neq "0">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">		
				<div class="table table-responsive-sm">
				<table class="table table-hover">
				
					<tbody>
					<cfset table_display = "header">
					<cfinclude template="./tab_lesson_learner_list.cfm">
			
					
					<cfoutput query="get_lesson_#status_id#">
					
					<cfset table_display = "body">
					<cfinclude template="./tab_lesson_learner_list.cfm">
					
					</cfoutput>
					</tbody>
					
				</table>
				</div>
		
			</div>
		</div>
		<cfelse>
		<div class="row justify-content-md-center" style="margin-top:15px">

			<div class="col-md-6">
				<div class="alert alert-secondary" role="alert">
					<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_data')#</cfoutput></em></div>
				</div>
			</div>

		</div>
		</cfif>
		</cfif>
	<cfif show_tab eq "0">
	</div>
	</cfif>
	</cfloop>

</div>

<cfelse>

	<div class="table table-responsive-sm">
	<table class="table table-sm table-hover">

		<tbody>		

		
			<cfset table_display = "header_mini">
			<cfinclude template="./tab_lesson_learner_list.cfm">
			<cfif get_lesson_week.recordcount neq "0">
			<cfoutput query="get_lesson_week">		
			<cfset table_display = "body_mini">
			<cfinclude template="./tab_lesson_learner_list.cfm">		
			</cfoutput>
			<cfelse>
			-
			</cfif>
		
		</tbody>
		
	</table>		
	</div>
	
</cfif>

	