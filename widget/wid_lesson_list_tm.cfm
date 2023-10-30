<cfsilent>

<cfif show_tab eq "0">

	<cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT status_id, status_name_#SESSION.LANG_CODE# as status_name, status_css, status_bootstrap FROM lms_lesson_status <!---WHERE status_id <> 3---> 
	UNION (SELECT 0 as status_id, "#obj_translater.get_translate('global_all')#" as status_name, "" as status_css, "" as status_bootstrap) 
	ORDER BY status_id
	</cfquery>

	<cfoutput query="get_lesson_status">

		<cfif isdefined("period_month")>
			<cfset "get_lesson_#status_id#" = obj_query.oget_lessons(st_id="#status_id#",period_month="#period_month#",list_account="#al_id#",tm="1")>
		<cfelse>
			<cfset "get_lesson_#status_id#" = obj_query.oget_lessons(st_id="#status_id#",list_account="#al_id#",tm="1")>
		</cfif>

	</cfoutput>

<cfelseif show_tab neq "0" AND show_tab neq "week" AND show_tab neq "today">

	<cfquery name="get_lesson_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
	SELECT status_id, status_name_fr as status_name, status_css, status_bootstrap FROM lms_lesson_status WHERE status_id <> 3 UNION (SELECT 0 as status_id, "#obj_translater.get_translate('global_all')#" as status_name, "" as status_css, "" as status_bootstrap) ORDER BY status_id
	</cfquery>
	
	<cfif isdefined("period_month")>
		<cfset "get_lesson_#show_tab#" = obj_query.oget_lessons(st_id="#show_tab#",period_month="#period_month#",list_account="#al_id#",tm="1")>
	<cfelse>
		<cfset "get_lesson_#show_tab#" = obj_query.oget_lessons(st_id="#show_tab#",list_account="#al_id#",tm="1")>
	</cfif>	
	
<cfelseif show_tab eq "week">

	<cfset diff = 2 - DayOfWeek(now())>
	<cfset mondayDate = dateAdd("d", diff, now())>
	<cfset sundayDate = dateAdd("d", 5, mondayDate)>
			
	<cfset get_lesson_week = obj_query.oget_lessons(start_range="#mondayDate#",end_range="#sundayDate#",list_account="#al_id#",tm="1")>
		
<cfelseif show_tab eq "today">
			
	<cfset get_lesson_week = obj_query.oget_lessons(start_range="#now()#",end_range="#now()#",list_account="#al_id#",tm="1")>
	
</cfif>

</cfsilent>

<cfif show_tab eq "0">
<cfparam name="st_id" default="0">
<ul class="nav nav-tabs" role="tablist" id="tabs_lessons">

	<cfoutput query="get_lesson_status">
	<li class="nav-item">
		<a class="nav-link <cfif st_id eq status_id>active</cfif>" 
			href="##tab_#status_id#" 
			role="tab" 
			data-toggle="tab" id="title_#status_id#">#status_name#
		</a>
	</li>
	</cfoutput>

</ul>
</cfif>

<cfif show_tab neq "week" AND show_tab neq "today">

<div class="tab-content">

	<cfloop query="get_lesson_status">
	<cfif show_tab eq "0">
	<div class="tab-pane fade <cfif get_lesson_status.status_id eq st_id>show active</cfif>" <cfoutput>id="tab_#get_lesson_status.status_id#"</cfoutput> role="tabpanel">
	</cfif>
		<cfif show_tab eq get_lesson_status.status_id OR show_tab eq "0">
		<cfif evaluate("get_lesson_#status_id#.recordcount") neq "0">
		<div class="row">
			<div class="col-md-12" style="margin-top:25px">		
				<div class="table table-responsive-sm">
				<table class="table table-hover">
				
					<tbody>
					<cfset table_display = "header">
					<cfinclude template="./tab_lesson_tm_list.cfm">
			
					
					<cfoutput query="get_lesson_#status_id#">
					
					<cfset table_display = "body">
					<cfinclude template="./tab_lesson_tm_list.cfm">
					
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
	<table class="table table-hover">

		<tbody>		
		<cfset table_display = "header">
		<cfinclude template="./tab_lesson_tm_list.cfm">
		
		<cfoutput query="get_lesson_week">		
		<cfset table_display = "body">
		<cfinclude template="./tab_lesson_tm_list.cfm">		
		</cfoutput>		
		</tbody>
		
	</table>	
	</div>
			
</cfif>
	