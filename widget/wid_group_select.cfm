
	
<!---<div class="card">

	<div class="card-body">--->


<cfif get_account_group.recordcount neq "0">
							

	<table class="table table-sm">
		<!---<tr bgcolor="#F3F3F3">
			<th><cfoutput>#group_name#</cfoutput></th>
			<th>Activit&eacute;</th>
			<th>Nb learner</th>
		</tr>--->
		
		<cfoutput query="get_account_group">
		
		<cfset get_todo = obj_task_get.oget_log(a_id="#account_id#",category="TO DO",log_status="0",o_by="log_remind")>
		<cfset get_feedback = obj_task_get.oget_log(a_id="#account_id#",category="FEEDBACK",o_by="date_desc")>

		<tr>
			<td width="45%"><img src="./assets/img/training_#get_account_group.provider_code#.png" width="25"> <a href="crm_account_edit.cfm?a_id=#get_account_group.account_id#" <cfif get_account_group.account_id eq a_id>class="text-dark font-weight-bold"</cfif>>#get_account_group.account_name#</a></td>
			<td width="10%"><span class="badge text-white" style="background-color:###get_account_group.account_manager_color#;">#get_account_group.account_manager#</span></td>
			<td width="10%"><span class="badge text-white bg-#type_css#">#get_account_group.type_name#</span></td>
			<td width="10%" align="right" class="font-weight-bold">#nb# users</td>
			<td width="35%" align="right" class="font-weight-bold">
				<a class="btn btn-sm btn-warning btn_view_log_account" id="a_#account_id#" href="##"><i class="fal fa-book" aria-hidden="true"></i> #get_todo.recordcount#</a>
				<a class="btn btn-sm btn-info btn_view_log_account" id="a_#account_id#" href="##"><i class="fal fa-edit" aria-hidden="true"></i> #get_feedback.recordcount#</a>
				<a class="btn btn-sm btn-success btn_copy_account" id="a_#account_id#" href="##"><i class="fal fa-copy" aria-hidden="true"></i> </a>
				<cfif SESSION.USER_ID==202> <a class="btn btn-sm btn-danger btn_delete_account" id="a_#account_id#" href="##"><i class="fal fa-trash" aria-hidden="true"></i> </a></cfif>
			</td>
		</tr>
		</cfoutput>
	</table>

</cfif>

	<!---</div>
</div>--->