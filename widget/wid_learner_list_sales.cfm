<div class="table-responsive">
<table width="3000" class="table bg-white">
	<tbody>
	<tr class="bg-light" align="center">
		<!---<th>ID</th>--->
		<th width="100">TYPE</th>
		<!--- <th width="100">STATUS</th> --->
		<th width="100">CR&Eacute;ATION/LMS</th>
		<th width="170">LEARNER</th>
		<th width="120">SITUATION</th>
		<th width="230">COORD</th>
		<th width="130">COMPTE</th>
		<th width="120">PT</th>
		<th width="30">LST</th>
		<th width="50">CERTIF</th>
		<th width="100">DROITS CPF</th>
		<th width="100">RECH FORM</th>
		<th width="150">TASKS</th>
		<th width="10"></th>
	</tr>
	<cfset counter = 0>
	

	<cfloop query="get_learner">
	<cfset counter ++>
	<cfset get_tp = obj_tp_get.oget_tp(u_id="#get_learner.user_id#")>
	<cfoutput>
	<tr>
		
		<!---<td width="1%">
			#get_learner.user_id#
		</td>--->
		<td>
			<span class="badge badge-pill badge-#profile_css# text-white">#profile_name#</span>
		</td>
		<!--- <td> --->
			<!--- <span class="badge badge-pill text-white badge-#user_status_css#">#get_learner.user_status_name#</span> --->
		<!--- </td> --->
		<td>
			#dateformat(user_create,'dd/mm/yyyy')# <small><strong>#timeformat(user_create,'HH:nn')#</strong></small>	<cfif user_elapsed neq ""><br><small><strong>#replace(obj_lms.get_format_hms(toformat="#user_elapsed#")," ","","ALL")#</strong></small><cfelse>-</cfif>
		</td>
		<td>			
			<a href="common_learner_account.cfm?u_id=#user_id#" class="text-dark">#get_learner.user_firstname#<br><strong>#ucase(get_learner.user_name)#</strong></a>
		</td>
		<td>			
			<small><strong>#situation_name_fr#</strong></small>
		</td>
		<td>			
			#get_learner.user_phone#<br>
			<small>#get_learner.user_email#</small>
		</td>
		<td>
			<small><strong><a href="crm_account_edit.cfm?a_id=#account_id#">#mid(get_learner.account_name,1,20)#</a></strong></small>
		</td>
		<td>
			<cfloop list="en,de,fr,es,it" index="cor">
				<cfif evaluate("user_qpt_#cor#") neq "">
					<span class="badge bg-success text-white"> <span class="lang-xs" style="top:0px" lang="<cfoutput>#cor#</cfoutput>"></span> #evaluate("user_qpt_#cor#")# <cfif evaluate("user_qpt_lock_#cor#") eq "0">[no end]</cfif></span>
				</cfif>
			</cfloop>
												
			<!--- <span class="badge badge-pill <cfif user_qpt eq "A0">bg-danger<cfelseif user_qpt eq "A1">bg-success<cfelseif user_qpt eq "A2">bg-success<cfelseif user_qpt eq "B1">bg-info<cfelseif user_qpt eq "B2">bg-info<cfelseif user_qpt eq "C1">bg-warning<cfelseif user_qpt eq "C2">bg-warning</cfif> text-white">#user_qpt# <cfif user_qpt_lock eq "0">[en cours]</cfif> --->
			
		</td>
		<td><cfif user_lst neq ""><span class="badge bg-success text-white">DONE</span><cfelse>-</cfif></td>

		<cfquery name="get_certif" datasource="#SESSION.BDDSOURCE#">
		SELECT c.certif_alias 
		FROM lms_list_certification c 
		LEFT JOIN lms_list_token t ON t.certif_id = c.certif_id
		WHERE t.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
		</cfquery>

		<cfset certif_alias = get_certif.certif_alias>

		<cfif certif_alias eq "">
			<!--- <cfdump var="#certif_alias#"> --->
			<cfquery name="get_certif_from_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT `lms_list_certification`.`certif_alias` FROM `lms_tp` 
				LEFT JOIN `lms_list_certification` ON `lms_list_certification`.`certif_id` = `lms_tp`.`certif_id` 
				WHERE `lms_tp`.`user_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
				AND `lms_tp`.`certif_id` IS NOT NULL
			</cfquery>

			<!--- <cfset certif_alias = get_certif_from_tp.certif_alias> --->
			<td>
				<cfloop query="get_certif_from_tp">
					<span class="badge bg-success text-white">#certif_alias#</span>
				</cfloop>
			</td>
		<cfelse>
			<td><cfif certif_alias neq ""><span class="badge bg-success text-white">#certif_alias#</span></cfif></td>
		</cfif>
		
		
		<td>#user_ctc_cpf#</td>
		<td>#user_ctc_formation#</td>
		
		<cfset get_todo = obj_task_get.oget_log(u_id="#user_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
		<cfset get_feedback = obj_task_get.oget_log(u_id="#user_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
	
		<td align="right">

			<div class="btn-group">
				<button type="button" class="btn <cfif get_feedback.recordcount eq "0">btn-outline-info<cfelse>btn-info</cfif> btn-sm btn_view_log" id="u_#user_id#">
				<i class="fal fa-book"></i> #get_feedback.recordcount#
				</button>
				
				<cfif get_todo.recordcount neq "0">
				<button type="button" class="btn btn-warning btn-sm btn_view_log" id="u_#user_id#">
				<i class="fal fa-edit"></i> #get_todo.recordcount#
				</button>
				</cfif>
				
				<button type="button" class="btn btn-outline-danger btn-sm btn_email_b2c_prospect" id="u_#user_id#">
				<i class="fal fa-envelope"></i>
				</button>

				<button type="button" class="btn btn-sm btn-outline-info btn-sm btn_remove_users" data-id='#user_id#'>
				DEL
				</button>
			</div>
		</td>
		
	</tr>
	</cfoutput>
	</cfloop>
	
</table>
</div>



	