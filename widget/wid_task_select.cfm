
	
<!---<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Tasks [<cfoutput>#get_task.recordcount#</cfoutput>]</h6>
		<!---<a class="btn btn-sm btn-info" href="#"><cfoutput>#get_task.recordcount#</cfoutput></a>---><a class="btn btn-sm btn-default btn_create_task" href="#"><i class="fas fa-plus-circle"></i></a>
		<div class="float-right"></div>
	</div>
	<div class="card-body">--->

<cfif get_tasks.recordcount neq "0">

	<cfif isdefined("view_full_task")>
		<cfset limitrows = get_tasks.recordcount>
	<cfelse>
		<cfset limitrows = "10">
	</cfif>	

<!---<div class="table-responsive">--->									
	<table class="table">
		<cfif isdefined("view_full_task")>
		<tr bgcolor="#F3F3F3">
			<th>R&eacute;f.</th>
			<th>CS</th>
			<th>FIN</th>
			<th>Opport</th>
			<th>D&eacute;b.</th>
			<th>Fin</th>
			<th>Docs</th>
			<th>Action</th>
		</tr>
		</cfif>
		
		<cfoutput query="get_tasks" startrow="1" maxrows="#limitrows#">

		<cfquery name="get_logs" datasource="#SESSION.BDDSOURCE#">
		SELECT log_date, log_text, u.user_alias FROM logs l
		INNER JOIN user u ON u.user_id = l.user_id
		WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">	
		ORDER BY log_id DESC
		</cfquery>	

		<tr>
			<td><span class="badge">#task_type_name#</span></td>
			<td><cfif task_alert eq "1"><i class="fas fa-bell"></i>&nbsp;</cfif></td>
			<td>#dateformat(task_date_deadline,'dd/mm/yyyy')#</td>
			<td>#account_name#</td>
			<td>#task_name#</td>
			<td align="right">
<cfset go = '<strong>Type : </strong>#task_type_name#<br><strong>Cr&eacute;ation : </strong>#dateformat(task_date_creation,'dd/mm/yyyy')#<br><strong>&Eacute;ch&eacute;ance : </strong>#dateformat(task_date_deadline,'dd/mm/yyyy')#<br><strong>Dur&eacute;e : </strong>#timeformat(task_date_start,'HH:mm')# - #timeformat(task_date_end,'HH:mm')#'>
<cfif task_name neq ""><cfset go = go & '<br><strong>Objet : </strong>#task_name#'></cfif>
<cfif contact_id neq "0"><cfset go = go & '<br><strong>Contact : </strong>#contact_firstname# #contact_name#'></cfif>
<cfif contact_tel1 neq ""><cfset go = go & '<br><strong>T&eacute;l : </strong>#contact_tel1#'></cfif>
<button type="button" class="btn btn-sm btn-secondary" data-container="body" data-toggle="popover" data-placement="right" data-content="#go#">
<i class="far fa-eye"></i>
</button>		
			</td>
			<!---<td>
			<cfif get_logs.recordcount neq "0">
			<a class="btn btn-sm btn-info btn_edit_opport" id="t_#task_id#" style="cursor:pointer" href="">#get_logs.recordcount#</a>
			</cfif>
			</td>
			<td>

				<a class="btn btn-sm btn-info btn_view_task" href="crm_account_edit.cfm?a_id=#account_id#"><i class="fas fa-building"></i></a>
				<a class="btn btn-sm btn-info btn_edit_task" href="##" id="t_#task_id#"><i class="fas fa-edit"></i></a>
				<a class="btn btn-sm btn-info btn_del_task" href="##" onclick="if(confirm('Souhaitez-vous effacer cette task ?')){document.location.href='updater_crm.cfm?task_id=#task_id#&del_task=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>'}"><i class="fa fa-trash-alt"></i></a>
			</td>--->
		</tr>
	</cfoutput>
	</table>
	<!---</div>--->
		
				<!---
				<table class="table table-sm">								
					<tr>
						<td>
							<strong>Type : </strong>#task_type_name#<br>
							<strong>Cr&eacute;ation : </strong>#dateformat(task_date_creation,'dd/mm/yyyy')#<br>
							<strong>&Eacute;ch&eacute;ance : </strong>#dateformat(task_date_deadline,'dd/mm/yyyy')#<br>
							<strong>Dur&eacute;e : </strong>#timeformat(task_date_start,'HH:mm')# - #timeformat(task_date_end,'HH:mm')#<br>
						</td>
						<td>
							<cfif task_name neq ""><strong>Objet : </strong>#task_name#<br></cfif>
							<cfif contact_id neq "0"><strong>Contact : </strong>#contact_firstname# #contact_name#<br>
							<cfif contact_tel1 neq ""><strong>T&eacute;l : </strong>#contact_tel1#<br></cfif></cfif>
							<cfif get_logs.recordcount neq "0"><strong>Suivi : </strong><a class="btn_edit_task" id="t_#task_id#">#get_logs.recordcount# commentaire<cfif get_logs.recordcount neq "1">s</cfif></cfif>
						</td>							
					</tr>					
				</table>
				--->
		<cfif not isdefined("view_full_task") AND get_tasks.recordcount gt 10>
		<div class="card-footer" style="text-align:right">
			<div class="stats">
			<a href="crm_tasks_list.cfm">[plus de tasks]</a>
			</div>
		</div>
		</cfif>
	<cfelse>
	<em>Aucune t&acirc;che planifi&eacute;e</em>
	</cfif>
	<!---
	</div>
</div>
--->
	
