
	
<!---
<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Contacts [<cfoutput>#get_contact.recordcount#</cfoutput>]</h6> 
		<!---<a class="btn btn-sm btn-info" href="#"><cfoutput>#get_contact.recordcount#</cfoutput></a>---><a class="btn btn-sm btn-default btn_create_ctc" href="#"><i class="fas fa-plus-circle"></i></a>
	</div>
	<div class="card-body">
--->

<cfif get_contact.recordcount neq "0">

	<cfif isdefined("view_full_contact")>
		<cfset limitrows = get_contact.recordcount>
	<cfelse>
		<cfset limitrows = "5">
	</cfif>				

	<table class="table table-sm">
		<cfif isdefined("view_full_contact")>
		<tr class="bg-light">
			<!--- <th>TM</th> --->
			<th>REFERENT</th>
			<th></th>
			<th>FACTU</th>
			<th>CONTACT</th>
			<th>FONCTION</th>
			<th>T&Eacute;L.1</th>
			<th>T&Eacute;L.2</th>
			<th>EMAIL</th>
			<th>ACTION</th>
		</tr>
		</cfif>
	
		<cfif get_contact.recordcount neq "0">
		<cfoutput query="get_contact" startrow="1" maxrows="#limitrows#">
		<tr>
			<td>
			<cfif contact_active eq "1">
				<span class="badge badge-pill text-white bg-success">Actif</span>			
			<cfelse>
				<span class="badge badge-pill text-white  bg-dark">Inactif</span>			
			</cfif>
			</td>
			<td>
				<cfif contact_lead eq "1"><i class="fa-solid fa-star text-warning btn_switch_lead" id="ctc_#contact_id#_0"></i><cfelse><i class="fa-light fa-star text-warning btn_switch_lead" id="ctc_#contact_id#_1"></i></cfif>
			</td>
			<td><cfif contact_invoice eq 1>Factu</cfif></td>
			<td>#contact_firstname# #ucase(contact_name)#</td>
			<td>#function_name#</td>
			<td>#contact_tel1#</td>
			<td>#contact_tel2#</td>
			<td>#contact_email#</td>
			<td align="right">
			<a class="btn btn-sm btn-default btn_edit_ctc" href="##" id="c_#contact_id#"><i class="fas fa-edit"></i></a>
			<!---<a class="btn btn-sm btn-default btn_del_ctc" href="##" onclick="if(confirm('Souhaitez-vous effacer ce contact ?')){document.location.href='updater_crm.cfm?account_id=#account_id#&contact_id=#contact_id#&del_contact=1'}"><i class="far fa-trash-alt"></i></a>--->
			</td>
		</tr>
		</cfoutput>
		</cfif>

		<cfif isdefined("view_full_contact")>
			<cfset limitrows = get_contact.recordcount>
		<cfelse>
			<cfset limitrows = "5">
		</cfif>			

		<!--- <cfif get_user_account.recordcount neq "0">
		<cfoutput query="get_user_account" startrow="1" maxrows="#limitrows#">
			<tr>
				<td>
				<cfif user_status_id eq "4">
					<span class="badge badge-pill text-white bg-success">Actif</span>			
				<cfelse>
					<span class="badge badge-pill text-white  bg-dark">Inactif</span>			
				</cfif>
				</td>
				<td>
				
				</td>
				<td>
				<a class="btn btn-sm btn-info p-1" href="#SESSION.BO_ROOT_URL#/index.cfm?user_name=#user_email#&upass=#user_password#" id="sm_#user_id#">#profile_name#</a>
				
				<!---</cfif>--->
				</td>
				<td></td>
				<td>#user_firstname# #ucase(user_name)#</td>
				<td></td>
				<td></td>
				<td></td>
				<td>#user_email#</td>
				<td align="right">
				<a class="btn btn-sm btn-default btn_edit_ctc" href="##" id="u_#user_id#"><i class="fas fa-edit"></i></a>
				<!---<a class="btn btn-sm btn-default btn_del_ctc" href="##" onclick="if(confirm('Souhaitez-vous effacer ce contact ?')){document.location.href='updater_crm.cfm?account_id=#account_id#&contact_id=#contact_id#&del_contact=1'}"><i class="far fa-trash-alt"></i></a>--->
				</td>
			</tr>
			</cfoutput>
			</cfif> --->

	</table>

		<cfif not isdefined("view_full_ctc") AND (get_contact.recordcount) gt 5>
		<div class="card-footer" style="text-align:right">
			<div class="stats">
			<a href="#" class="btn_ctc_plus">[plus de contacts]</a>
			</div>
		</div>
		</cfif>
	<cfelse>
	<em>Aucun contact cr&eacute;&eacute;</em>
	</cfif>

	<!---</div>
</div>--->