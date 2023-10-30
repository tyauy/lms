
	
<!---<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Orders [<cfoutput>#get_orders.recordcount#</cfoutput>]</h6> 
		<span class="badge badge-success"></span>
		<cfoutput><!---<a class="btn btn-sm btn-info" href="##">#get_orders.recordcount#</a>---><a class="btn btn-sm btn-default" href="crm_order_edit.cfm?a_id=#a_id#"><i class="fas fa-plus-circle"></i></a></cfoutput>
	</div>
	<div class="card-body">--->

<cfif get_orders.recordcount neq "0">

	<cfif isdefined("view_full_order")>
		<cfset limitrows = get_orders.recordcount>
	<cfelse>
		<cfset limitrows = "5">
	</cfif>	
	
	<table class="table">
	
		<cfif isdefined("view_full_order")>
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
	
		<cfoutput query="get_orders" startrow="1" maxrows="#limitrows#">
		<tr>
			<td><span class="badge badge-pill text-white badge-default">#order_ref#</span></td>
			<td><span class="badge badge-pill text-white badge-#status_finance_css#">#status_finance_name#</span></td>	
			<td>
			<cfif task_id neq ""><a class="btn btn-sm btn-default">POT#task_id#</a>	</cfif>
			</td>
			<td>
			#dateformat(order_start,'dd/mm/yyyy')#		
			</td>
			<td>
			#dateformat(order_end,'dd/mm/yyyy')#
			</td>
			<td>
			<a class="btn btn-sm btn-default" href="./tpl/convention_container.cfm?o_id=#order_id#">CV</a>
			<a class="btn btn-sm btn-default">CV S</a>
			<a class="btn btn-sm btn-default">APC</a>
			</td>
			<td>
				<a class="btn btn-sm btn-default" href="crm_order_edit.cfm?a_id=#a_id#&o_id=#order_id#" id="o_#order_id#"><i class="fas fa-edit"></i></a>
				<!---<a class="btn btn-sm btn-default" onclick="if(confirm('Souhaitez-vous effacer ce contact ?')){document.location.href='updater_crm.cfm?account_id=#a_id#&contact_id=##&del_contact=1'}"><span class="glyphicon glyphicon-remove"></span></a>--->
			</td>
		</tr>
	</cfoutput>
	</table>

		<cfif not isdefined("view_full_order") AND get_orders.recordcount gt 5>
		<div class="card-footer" style="text-align:right">
			<div class="stats">
			<a href="#" class="btn_order_plus">[plus d'orders]</a>
			</div>
		</div>
		</cfif>
	<cfelse>
	<em>Aucun order cr&eacute;&eacute;</em>
	</cfif>

<!---
	</div>
</div>
--->
