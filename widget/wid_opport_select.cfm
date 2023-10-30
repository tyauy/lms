<cfquery name="get_opport" datasource="#SESSION.BDDSOURCE#">
SELECT t.*, tt.*, ac.contact_firstname, ac.contact_name, a.account_name FROM task t
INNER JOIN task_type tt ON tt.task_type_id = t.task_type_id
LEFT JOIN account_contact ac ON ac.contact_id = t.contact_id
LEFT JOIN account a ON a.account_id = t.account_id
WHERE 1 = 1
<cfif isdefined("a_id") AND not isdefined("all_account")>
AND t.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
</cfif>
AND tt.task_group = "opport"
</cfquery>
	
<!---<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Opportunit&eacute;s [<cfoutput>#get_opport.recordcount#</cfoutput>]</h6> 
		<!---<a class="btn btn-sm btn-info" href="#"><cfoutput>#get_opport.recordcount#</cfoutput></a>---><a class="btn btn-sm btn-default btn_create_opport" href="#"><i class="fas fa-plus-circle"></i></a>
	</div>
	<div class="card-body">--->

<cfif get_opport.recordcount neq "0">

	<cfif isdefined("view_full_opport")>
		<cfset limitrows = get_opport.recordcount>
	<cfelse>
		<cfset limitrows = "5">
	</cfif>						
			
		<!---<div class="table-responsive">--->
		
	<table class="table table-sm">
	
		<cfif isdefined("view_full_opport")>
		<tr bgcolor="#F3F3F3">
			<th>R&eacute;f.</th>
			<th>Date</th>
			<th>Status</th>
			<th>Montant</th>
			<th>Titre</th>
			<th>Fin</th>
			<th>Suivi</th>
			<th>Action</th>
		</tr>
		</cfif>
		
		<cfoutput query="get_opport" startrow="1" maxrows="#limitrows#">

		<cfquery name="get_logs" datasource="#SESSION.BDDSOURCE#">
		SELECT log_date, log_text, u.user_alias FROM logs l
		INNER JOIN user u ON u.user_id = l.user_id
		WHERE task_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">	
		ORDER BY log_id DESC
		</cfquery>	

		<tr>
			<td><span class="badge">#task_type_name#</span></td>
			<!---<td><cfif task_alert eq "1"><i class="fas fa-bell"></i>&nbsp;</cfif>POT#task_id#</td>--->
			<td>#dateformat(task_date_deadline,'dd/mm/yyyy')#</td>
			<td>#account_name#</td>
			<td><strong>#task_amount# &euro;</strong></td>
			<td>#task_name#</td>
			<td>
			<cfif get_logs.recordcount neq "0">
			<a class="btn btn-sm btn-info btn_edit_opport" id="t_#task_id#" style="cursor:pointer" href="">#get_logs.recordcount#</a>
			</cfif>
			</td>			
			<td align="right">
			<a class="btn btn-sm btn-default btn_edit_opport" id="t_#task_id#" href="##"><i class="fas fa-edit"></i></a>
			</td>
		</tr>

				<!---<div class="pull-right">
				
				<a class="btn btn-xs btn-default btn_view_opport" href="crm_account_edit.cfm?a_id=#account_id#"><span class="glyphicon glyphicon-edit glyphicon-eye-open"></span></a>
				<a class="btn btn-xs btn-default btn_edit_opport" id="t_#task_id#"><span class="glyphicon glyphicon-edit"></span></a>
				<a class="btn btn-xs btn-default btn_del_opport" onclick="if(confirm('Souhaitez-vous effacer cette opportunit&##233; ?')){document.location.href='updater_crm.cfm?task_id=#task_id#&del_opport=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>'}"><span class="glyphicon glyphicon-remove"></span></a>
				<a class="btn btn-xs btn-default btn_switch_order" id="t_#task_id#"><span class="glyphicon glyphicon-send"></span></a>
				</div>
				<table class="table table-condensed borderless">														
					<tr>
						<td>
							<strong>Type : </strong>#task_type_name#<br>
							<strong>Cr&eacute;ation : </strong>#dateformat(task_date_creation,'dd/mm/yyyy')#<br>
							<strong>&Eacute;ch&eacute;ance : </strong>#dateformat(task_date_deadline,'dd/mm/yyyy')#<br>
						</td>
						<td>
							<cfif task_name neq ""><strong>Objet : </strong><br></cfif>
							<cfif task_amount neq ""><strong>Montant : </strong>#task_amount# &euro;<br></cfif>
							<cfif task_probability neq "" AND task_probability neq "0"><strong>Proba : </strong><br></cfif>
							<cfif get_logs.recordcount neq "0"><strong>Suivi : </strong><a class="btn_edit_task" id="t_#task_id#">#get_logs.recordcount# commentaire<cfif get_logs.recordcount neq "1">s</cfif></cfif>
						</td>							
					</tr>														
				</table>														
			</div>
		</div>												
	</div>--->
	</cfoutput>
	</table>
	<!----</div>--->
	
		<cfif not isdefined("view_full_opport") AND get_opport.recordcount gt 5>
		<div class="card-footer" style="text-align:right">
			<div class="stats">
			<a href="crm_opport_list.cfm">[plus d'opportunit&eacute;s]</a>
			</div>
		</div>
		</cfif>
	<cfelse>
	<em>Aucune opportunit&eacute; planifi&eacute;e</em>
	</cfif>

	<!---</div>
</div>--->