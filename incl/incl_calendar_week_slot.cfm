<cfparam name="date_ref" default="#now()#">
<cfparam name="interval" default="0,1,2,3,4,5,6,7">
<cfparam name="date_add" default="0">
<cfparam name="jump" default="0">
<cfparam name="tp_date_start" default="#SESSION.tp_date_start#">
<cfparam name="tp_date_end" default="#SESSION.tp_date_end#">
<!--- <cfparam name="tp_date_end" default="#dateformat(dateadd("yyyy",1,now()),'yyyy-mm-dd')#"> --->


<cfquery name="get_first_lesson_verif" datasource="#SESSION.BDDSOURCE#">
	SELECT l.lesson_id, l.lesson_start FROM  lms_tpsession ts
	INNER JOIN lms_lesson2 l  ON ts.session_id = l.session_id
	WHERE ts.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.TP_ID#">
	AND ts.sessionmaster_id = 695
	AND l.status_id <> 3
	LIMIT 1
</cfquery>

<cfset first_lesson_date_limit = "">
<cfif get_first_lesson_verif.recordCount gt 0>
	<cfset first_lesson_date_limit = get_first_lesson_verif.lesson_start>
</cfif>

<cfset nb_h_shift = 5>
<cfset day_to_check = 7>
<cfset display_more = 0>

<cfif interval eq "">
	<cfset interval = "0,1,2,3,4,5,6,7">
</cfif>
<!--- test --->
<!--- <cfset interval = "2,4"> --->


<cfif tp_date_end eq "">
	<cfset tp_date_end = dateformat(dateadd("yyyy",1,now()),'yyyy-mm-dd')>
</cfif>

<cfset prev_tp_start = 0>
<cfif DateCompare(tp_date_start, date_ref) eq 1>
	<cfset date_ref = tp_date_start>
	<cfset prev_tp_start = 1>
</cfif>

<cfif isdefined("date_add")>
	<cfset date_ref = dateadd("d",date_add,date_ref)>
</cfif>

<!--- <cfif interval neq "">
	<cfset dayOfWeek = dayOfWeek(date_ref)>
	<cfset todaydayOfWeek = dayOfWeek(now())>
	<cfset _monday = dateAdd("d", (2-dayOfWeek), date_ref)>
	<cfset _today = dateAdd("d", (todaydayOfWeek-dayOfWeek), date_ref)>
</cfif> --->

<cfif jump eq 1>

	<cfset dayOfWeek = dayOfWeek(date_ref)>
	<cfset todaydayOfWeek = dayOfWeek(now())>
	<!--- <cfset _monday = dateAdd("d", (2-dayOfWeek), date_ref)> --->
	<!--- <cfset _today = dateAdd("d", (todaydayOfWeek-dayOfWeek), date_ref)> --->

	<cfif dayOfWeek LT todaydayOfWeek>
		<cfset _today = dateAdd("d", (todaydayOfWeek-dayOfWeek) - 7, date_ref)>
	<cfelse>
		<cfset _today = dateAdd("d", (todaydayOfWeek-dayOfWeek), date_ref)>
	</cfif>

	<cfset date_ref = _today>

</cfif>

<cfoutput>

<div class="d-flex">
	
	<!--- <cfset date_ref = evaluate("date_ref_#user_id#")> --->
	<input type="hidden" name="date_ref_#user_id#" id="date_ref_#user_id#" value="#dateformat(date_ref,'yyyy-mm-dd')#">
	
	<div class="avail_prev">
		<i class="fas fa-chevron-left btn_avail_prev cursored" <cfif DateCompare(date_ref, now()) neq 1 OR prev_tp_start eq 1>style="pointer-events: none; color:##B9B9B9;"</cfif> id="availprev_#user_id#"></i>
	</div>

	<cfset week_check = 0>

	<!--- <cfdump var="#dayOfWeek#">
	<cfdump var="#todaydayOfWeek#"> --->
	<!--- <cfdump var="#date_ref#">
	<cfdump var="#dayOfWeek#">
	<cfdump var="#todaydayOfWeek#">
	<cfdump var="#_monday#">
	<cfdump var="#_today#"> --->

	<!---  step="#interval#" --->

	<cfset cor = 0>
	<cfloop condition="cor LT day_to_check">

		<!--- <cfset date_display = dateformat(dateadd("d",cor,date_ref),'dd/mm/yyyy')> --->
		<cfset date_link = dateformat(dateadd("d",cor,date_ref),'yyyy-mm-dd')>	

		<cfset _day = dayOfWeek(date_link)>	
		<!--- <cfdump var="#_day#"> --->
		<cfif listFindNoCase(interval, _day)>

			<cfif DateCompare(date_link, tp_date_end) neq 1>
				<cfinvoke component="api/users/user_trainer_get" method="get_calendar_dispo" returnvariable="available_date_list">
					<cfinvokeargument name="date_link" value="#date_link#">
					<cfinvokeargument name="user_id" value="#user_id#">
					<cfif s_dur neq "">
						<cfinvokeargument name="s_dur" value="#s_dur#">
					</cfif>
				</cfinvoke>
			<cfelse>
				<cfset available_date_list = []>
			</cfif>

			<!--- perf --->
			<!--- <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
				SELECT 
				t.tp_id,
				l.lesson_id, l.lesson_start, l.lesson_end,
				sm.sessionmaster_id, sm.sessionmaster_name,
				ul.user_firstname, ul.user_name,
				ut.user_id as planner_id,
				ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css
				FROM lms_lesson2 l
				INNER JOIN lms_tpsession s ON l.session_id = s.session_id
				INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
				INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
				INNER JOIN lms_tp t ON t.tp_id = s.tp_id
				INNER JOIN user ul ON ul.user_id = l.user_id
				INNER JOIN user ut ON ut.user_id = l.planner_id
				
				WHERE t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_id#"> 
				AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				
				AND DATE_FORMAT(lesson_start,'%Y-%m-%d') = '#date_link#' 
				AND (l.status_id <> "3")
				<!---AND s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">--->
				ORDER BY lesson_start ASC
			</cfquery> --->

			<!--- test --->
			<!--- <cfif isDefined("SESSION.LAUNCH_MULTI")>

				<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#" >
					SELECT l2.lesson_id, s.session_rank, l2.lesson_start, s.session_duration
					FROM lms_lesson2 l2 
					INNER JOIN lms_tpsession s ON s.session_id = l2.session_id
					WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
					AND l2.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
					AND l2.status_id = 1
					AND DATE_FORMAT(l2.lesson_start,'%Y-%m-%d') = <cfqueryparam cfsqltype="cf_sql_date" value="#date_link#">
				</cfquery>
				<!--- <cfdump var="#get_lesson#">  --->

			</cfif> --->
			
			<!--- <cfdump var="#available_date_list#"> --->
			
			

			<cfset counter = 0>
			

			<div class="avail_day" align="center">

				<cfset cur_date = dateadd("d",cor,date_ref)>
			
				<strong>#LSDateFormat(cur_date,"ddd",'#SESSION.LANG_CODE#')#</strong>
				<br>
				#dateformat(cur_date,"dd/mm")#

				<div id="as_#user_id#_#dateformat(cur_date,"yyyy-mm-dd")#">

				</div>
				
				<div class="avail_slots">

					<cfif structKeyExists(SESSION.booking_array, dateformat(cur_date,'yyyy-mm-dd'))>
	
						<!--- <cfdump var="#SESSION.booking_array[dateformat(cur_date,"yyyy-mm-dd")]#"> --->
						<!--- <h6 class="text-warning mt-3">#obj_translater.get_translate('modal_planning_title')#</h6> --->

						<cfloop array="#SESSION.booking_array[dateformat(cur_date,"yyyy-mm-dd")]#" index="currentStruct">
						
							<!--- <a href="##" id="a_#dateformat(get_lesson.lesson_start,'yyyy-mm-dd')#_#timeformat(get_lesson.lesson_start,'HH')#_#timeformat(get_lesson.lesson_start,'mm')#_#get_lesson.planner_id#" 
							class="btn mt-1 m-0 py-2 a_#dateformat(get_lesson.lesson_start,'yyyy-mm-dd')#_#timeformat(get_lesson.lesson_start,'HH')#_#timeformat(get_lesson.lesson_start,'mm')# btn-info btn_book_lesson" 
							style="width:100px; background-color:##DE9F21;">
								#timeformat(get_lesson.lesson_start,'HH:mm')#
							</a> --->
							<cfif currentStruct.id eq user_id>
								<a href="##" id="a_#currentStruct.date#_#currentStruct.hour#_#currentStruct.min#_#currentStruct.id#" class="btn btn-warning mt-1 m-0 py-0 a_#currentStruct.date#_#currentStruct.hour#_#currentStruct.min#" style="width:80px">#currentStruct.hour#:#currentStruct.min#</a>
								<div class="clearfix"></div>
							</cfif>

							<!--- comment to display all booked + 5 free spot --->
							<!--- <cfset counter++> --->
								
						</cfloop>
						<!--- <div class="border-bottom border-info mb-1"></div>
						<div class="border-bottom border-warning mb-1"></div> --->

					</cfif>


					<cfloop array="#available_date_list#" index="temp"> 
						<!--- <cfset date_compare = "#date_link# #timeformat(temp,'HH:mm:00')#"> --->
	
						<!--- #counter# --->
						<!--- #temp# // #date_ref# // #dateadd('h',7,date_ref)# --->
						<cfif temp gt dateadd('h',nb_h_shift,now())>
							<a href="##" id="a_#dateformat(temp,'yyyy-mm-dd')#_#timeformat(temp,'HH')#_#timeformat(temp,'mm')#_#user_id#" 
							class="btn mt-1 m-0 py-0 a_#dateformat(temp,'yyyy-mm-dd')#_#timeformat(temp,'HH')#_#timeformat(temp,'mm')# <cfif first_lesson_date_limit eq "" OR (first_lesson_date_limit neq "" AND first_lesson_date_limit LT temp)>btn-outline-info btn_book_lesson<cfelse>disbaled</cfif> <cfif counter gte 5>collapse avail_display_add_#user_id#</cfif>" 
							style="width:80px">
								#timeformat(temp,'HH:mm')#
							</a>
							<div class="clearfix"></div>
							<cfset counter++>
							<cfset week_check++>
						</cfif>

						
					</cfloop>
					

					<cfif counter eq "0">
						
						<!--- <div class="alert alert-secondary mt-3" role="alert"> --->
							<div class="avail_slot_empty">
								<div class="avail_slot_empty_dash"></div>
							</div>
							<!--- <div class="text-center"><em>#__alert_no_avail#</em></div> --->
						<!--- </div> --->
					<cfelseif counter GT 5>
						<cfset display_more++>
					</cfif>	

				</div>	

			</div>
		<cfelseif day_to_check LT 30>
			<!--- pushing away the limit --->
			<cfset day_to_check = day_to_check + 1>
		</cfif>

		<cfset cor = cor + 1> 

	</cfloop>

	<div class="next">
		<i class="fas fa-chevron-right btn_avail_next cursored" <cfif DateCompare(date_link, tp_date_end) GT -1>style="pointer-events: none; color:##B9B9B9;"</cfif> id="availnext_#user_id#"></i>
	</div>

</div>

<cfif week_check eq 0>

	<cfloop condition="week_check eq 0 AND day_to_check LT 37">
		
		<cfset date_link = dateformat(dateadd("d",day_to_check,date_ref), 'yyyy-mm-dd')>	

		<cfinvoke component="api/users/user_trainer_get" method="get_calendar_dispo" returnvariable="available_date_list">
			<cfinvokeargument name="date_link" value="#date_link#">
			<cfinvokeargument name="user_id" value="#user_id#">
			<cfinvokeargument name="s_dur" value="#s_dur#">
		</cfinvoke>
		
		<cfif ArrayLen(available_date_list) GT 0>
			<div align="center">
				<button class="btn btn-outline-warning btn_jump_next_avail" id="jump_#user_id#" name="#floor(day_to_check / 7)#"><cfoutput>#obj_translater.get_translate('btn_next_avail')#</cfoutput> #obj_dater.get_dateformat(date_link)#</button>
			</div>
			<cfset week_check++>
		</cfif>

		<cfset day_to_check++>

	</cfloop>

</cfif>

<hr aria-hidden="true">

<!--- <cfdump var="#available_date_list#"> --->

<cfif display_more GT 0>
	<div align="center">
		<button class="btn btn-link btn_display_avail" id="btn_#user_id#" role="button" type="button"><i class="fas fa-chevron-down"></i>&nbsp;&nbsp;#obj_translater.get_translate('btn_more_avail')#</span></button>
	</div>
</cfif>

</cfoutput>