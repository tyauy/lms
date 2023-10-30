<div class="table-responsive">
<table width="3000" class="table table-sm bg-white">
	<tbody>
	<tr class="bg-light" align="center">
		<!---<th>ID</th>--->
		<th>TYPE</th>
		<th>STATUS</th>
		<th>CR&Eacute;ATION/LMS</th>
		<th width="250">LEARNER</th>
		<th>ENTIT&Eacute;</th>
		<th>PT</th>
		<th>LST</th>
		<th colspan="2">ORDER</th>
		<th>TP</th>
		<th>TP STATUS</th>
		<th>PROGRESS</th>
		<th>H.Tr</th>
		<th>Tr2</th>
		<th>Tr3</th>
		<th colspan="4">TP HOURS</th>
		<th>LL</th>
		<th>NL</th>
		<th>Alert</th>
		<th width=100>Comments</th>
	</tr>
	<cfset counter = 0>
	

	<cfloop query="get_learner">
	<cfset counter ++>
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#get_learner.user_id#", o_by="t_id")>
	
	<tr>
		<cfoutput>
		<!---<td width="1%">
			#get_learner.user_id#
		</td>--->
		<td width="100">
			<span class="badge badge-pill badge-#profile_css# text-white">#profile_name#</span>
		</td>
		<td width="100">
			<span class="badge badge-pill text-white badge-#user_status_css#">#get_learner.user_status_name#</span>
		</td>
		<td width="100">
		#dateformat(user_create,'dd/mm/yyyy')#	<cfif user_elapsed neq ""><br><small><strong>#replace(obj_lms.get_format_hms(toformat="#user_elapsed#")," ","","ALL")#</strong></small><cfelse>-</cfif>
		</td>
		
		<!---<td width="150">
			<cfif user_steps eq "">
				<span class="badge badge-pill badge-warning text-white">OK</span>
			<cfelse>
				<cfif listfind(user_steps,"1")><span class="badge badge-pill badge-secondary text-white">PT</span><cfelse><span class="badge badge-pill badge-primary text-white">PT</span></cfif>
				<cfif listfind(user_steps,"2")><span class="badge badge-pill badge-secondary text-white">LST</span><cfelse><span class="badge badge-pill badge-primary text-white">LST</span></cfif>
				<cfif listfind(user_steps,"3")><span class="badge badge-pill badge-secondary text-white">RB</span><cfelse><span class="badge badge-pill badge-primary text-white">RB</span></cfif>
			</cfif>
			
		</td>--->
		<td width="250">			
			<a href="common_learner_account.cfm?u_id=#user_id#" class="text-dark">#get_learner.user_firstname#<br><strong>#ucase(get_learner.user_name)#</strong></a>
		</td>
		<td width="200">
			<small><strong><a href="crm_account_edit.cfm?a_id=#account_id#">#mid(get_learner.account_name,1,20)#</a></strong></small>
		</td>
		<td><span class="badge badge-pill <cfif user_qpt eq "A0">bg-danger<cfelseif user_qpt eq "A1">bg-success<cfelseif user_qpt eq "A2">bg-success<cfelseif user_qpt eq "B1">bg-info<cfelseif user_qpt eq "B2">bg-info<cfelseif user_qpt eq "C1">bg-warning<cfelseif user_qpt eq "C2">bg-warning</cfif> text-white">#user_qpt# <cfif user_qpt_lock eq "0">[en cours]</cfif></td>
		<td><cfif user_lst neq ""><span class="badge badge-pill bg-success text-white">DONE</span><cfelse>-</cfif></td>
		</cfoutput>
		
		
		
		
		
		<!---<cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM user u 
		LEFT JOIN user_elapsed ue ON ue.user_id = u.user_id
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>

		<cfquery name="get_mock" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM lms_quiz_user qu 
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
		WHERE (q.quiz_type = "toeic" OR q.quiz_type like "%bright%")
		AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>

		<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
		SELECT *
		FROM lms_quiz_user qu 
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id 
		WHERE (q.quiz_type = "exercice" OR q.quiz_type = "unit")
		AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>--->

		<cfif get_tp.recordcount neq "0">
		<cfoutput query="get_tp" startrow="1" maxrows="1">												
			<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
			<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
			<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
			<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
			<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
			<cfif tp_signed eq ""><cfset tp_signed_go = "0"><cfelse><cfset tp_signed_go = tp_signed></cfif>
			
			<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
			<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go-tp_signed_go>
			
			<cfset tp_done_go = tp_completed_go+tp_inprogress_go+tp_signed_go>
			<td class="bg-light"><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
			<td class="bg-light"><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_alias#</span></td>
			<td width="200"><a class="btn btn-sm btn-info m-0 p-1 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif get_tp.method_id eq "11"><i class="fal fa-users fa-lg" aria-hidden="true"></i>&nbsp;</cfif><cfif get_tp.tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></a></td>
			<td width="110"><span class="badge badge-pill badge-#tp_status_css# text-white">#status_name#</span></td>
			<td width="100">
				<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_signed="#tp_signed_go#",tp_duration="#tp_duration#")>
				<cfif method_id neq "3">#temp#</cfif>
			</td>
			<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
			<cfloop query="tp_trainer">
				<td width="40"><cfif (get_tp.method_id eq 1 OR get_tp.method_id eq 2)>#obj_lms.get_thumb(user_id="#planner_id#",size="35",responsive="no",display_title="#planner#")#</cfif></td>
			</cfloop>

			<td width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="far fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>
			<td width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="far fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>
			<td width="2%">	
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="far fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
				</cfif>
			</td>
			<!---<td class="border-0" width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fas fa-window-close"></i> <cfif tp_cancelled_go neq "">#obj_lms.get_formath(tp_cancelled_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>--->
			<td width="2%">	
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fas fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
				</cfif>
			</td>
			
			<td><cfif last_lesson neq "">#dateformat(last_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
			<td><cfif next_lesson neq "">#dateformat(next_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
			
			<td align="center">
			<cfif next_lesson eq "" AND (method_id eq "1" OR method_id eq "2") AND (tp_status_id eq "2" OR tp_status_id eq "7")>
				<cfif last_lesson lt DateAdd("m",-2,now())>
				<a class="btn btn-sm btn-danger text-white"><i class="fas fa-exclamation-triangle"></i> BL</a>
				<cfelse>
				<a class="btn btn-sm btn-warning text-white"><i class="fas fa-exclamation-triangle"></i> NNL</a>
				</cfif>
			</cfif>
			</td>
			<!---<td class="border-0" width="150">#dateformat(tp_date_end,'dd/mm/yyyy')#</td>--->
			<!---<td class="border-0" width="190">
			<a href="common_learner_account.cfm?u_id=#user_id#&tab=3" class="btn btn-sm btn-outline-info"><i class="fas fa-edit"></i></a>
			<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-tachometer-alt"></i></a>
			<cfif method_scheduler eq "scheduler"><a href="common_tp_calendar.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="far fa-calendar-alt"></i></a></cfif>
			<!---<a href="./tpl/as_container.cfm?u_id=#user_id#" class="btn btn-sm btn-outline-info">AS</a>--->
			</td>--->
		</cfoutput>
		<cfelse>
		<td colspan="15"></td>
			
		</cfif>
		
		<td align="right">
		
		<cfset get_todo = obj_task_get.oget_log(u_id="#user_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
		<cfset get_feedback = obj_task_get.oget_log(u_id="#user_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
			
		
		<cfoutput>
		<cfif get_todo.recordcount neq "0">
		<button type="button" class="btn btn-warning btn-sm btn_view_log" id="u_#user_id#">
		<i class="fas fas fa-edit"></i> #get_todo.recordcount#
		</button>
		</cfif>
		<button type="button" class="btn <cfif get_feedback.recordcount eq "0">btn-outline-info<cfelse>btn-info</cfif> btn-sm btn_view_log" id="u_#user_id#">
		<i class="fad fa-book"></i> #get_feedback.recordcount#
		</button>
		</cfoutput>
		</td>
			
	</tr>
		<cfoutput query="get_tp" startrow="2" maxrows="10">
			
			<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
			<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
			<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
			<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
			<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
			<cfif tp_signed eq ""><cfset tp_signed_go = "0"><cfelse><cfset tp_signed_go = tp_signed></cfif>
			
			<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
			<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go-tp_signed_go>
			
			<cfset tp_done_go = tp_completed_go+tp_inprogress_go+tp_signed_go>
			
			<tr>
			<td class="border-0" colspan="7"></td>
			<td class="border-0 bg-light"><span class="badge badge-pill text-white badge-default btn_read_order" id="o_#order_id#" style="cursor:pointer">#order_ref#</span></td>
			<td class="border-0 bg-light"><span class="badge badge-pill text-white badge-#status_finance_css# btn_read_order" id="o_#order_id#" style="cursor:pointer">#status_finance_alias#</span></td>
			<td class="border-0" width="200"><a class="btn btn-sm btn-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif get_tp.method_id eq "11"><i class="fal fa-users fa-lg" aria-hidden="true"></i>&nbsp;</cfif><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></a></td>
			<td class="border-0" width="110"><span class="badge badge-pill badge-#tp_status_css# text-white">#status_name#</span></td>
			<td class="border-0" width="100">
				<cfset temp = obj_lms.get_progress_bar(met_id="#method_id#",tp_status="#tp_status_id#",tp_scheduled="#tp_scheduled_go#",tp_inprogress="#tp_inprogress_go#",tp_missed="#tp_missed#",tp_cancelled="#tp_cancelled_go#",tp_completed="#tp_completed_go#",tp_signed="#tp_signed_go#",tp_duration="#tp_duration#")>
				<cfif method_id neq "3">#temp#</cfif>
			</td>
			<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
			<cfloop query="tp_trainer">
				<td class="border-0" width="40"><cfif (get_tp.method_id eq 1 OR get_tp.method_id eq 2)>#obj_lms.get_thumb(user_id="#planner_id#",size="35",display_title="#planner#")#</cfif></td>
			</cfloop>

			<td class="border-0" width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="far fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>
			<td class="border-0" width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="far fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>
			<td class="border-0" width="2%">	
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="far fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
				</cfif>
			</td>
			<!---<td class="border-0" width="2%">
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fas fa-window-close"></i> <cfif tp_cancelled_go neq "">#obj_lms.get_formath(tp_cancelled_go)#<cfelse>-</cfif> </button>
				</cfif>
			</td>--->
			<td class="border-0" width="2%">	
				<cfif method_scheduler eq "scheduler">
				<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fas fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
				</cfif>
			</td>
			
			<td class="border-0"><cfif last_lesson neq "">#dateformat(last_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
			<td class="border-0"><cfif next_lesson neq "">#dateformat(next_lesson,'dd/mm/yyyy')#<cfelse>-</cfif></td>
			
			<td class="border-0" align="center">
			<cfif next_lesson eq "" AND (method_id eq "1" OR method_id eq "2") AND (tp_status_id eq "2" OR tp_status_id eq "7")>
				<cfif last_lesson lt DateAdd("m",-2,now())>
				<a class="btn btn-sm btn-danger text-white"><i class="fas fa-exclamation-triangle"></i> BL</a>
				<cfelse>
				<a class="btn btn-sm btn-warning text-white"><i class="fas fa-exclamation-triangle"></i> NNL</a>
				</cfif>
			</cfif>
			</td>
			
			<!---<td class="border-0" width="150">#dateformat(tp_date_end,'dd/mm/yyyy')#</td>--->
			<!---<td class="border-0" width="190">
			<a href="common_learner_account.cfm?u_id=#user_id#&tab=3" class="btn btn-sm btn-outline-info"><i class="fas fa-edit"></i></a>
			<a href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="fas fa-tachometer-alt"></i></a>
			<cfif method_scheduler eq "scheduler"><a href="common_tp_calendar.cfm?t_id=#tp_id#&u_id=#user_id#" class="btn btn-sm btn-outline-info"><i class="far fa-calendar-alt"></i></a></cfif>
			</td>--->
			</tr>
			</cfoutput>
	</cfloop>
	
</table>
</div>



	