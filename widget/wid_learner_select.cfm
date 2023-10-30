<!---
<div class="card">
	<div class="card-header">
		<h6 class="card-title d-inline">Learners </h6><a class="btn btn-sm btn-info" href="#"><cfoutput>#get_learner.recordcount#</cfoutput></a>
		<!---<div class="float-right"><a class="btn btn-sm btn-info btn_create_opport" href="#"><i class="fas fa-plus-circle"></i> Ajouter</a></div>--->
	</div>
	<div class="card-body">--->

<cfif get_learner.recordcount neq "0">

	<cfif isdefined("view_full_learner")>
		<cfset limitrows = get_learner.recordcount>
	<cfelse>
		<cfset limitrows = "10">
	</cfif>										

	<table class="table">
		<cfif isdefined("view_full_learner")>
		<tr bgcolor="#F3F3F3">
			<th>ID</th>
			<th>Contact</th>
			<th></th>
			<th></th>
			<th>Action</th>
		</tr>
		</cfif>
	
		<cfoutput query="get_learner" startrow="1" maxrows="#limitrows#">
		<tr>
			<td>#obj_lms.get_thumb(user_id="#user_id#",size="25",responsive="yes")#	</td>
			<td><span class="badge badge-pill text-white badge-#user_status_css#">#get_learner.user_status_name#</span></td>
			<td>#user_contact#</td>
			<td><!---<cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id,tp_rank,formation_code,method_id,tp_duration)#<cfelse>-</cfif>--->#profile_name#</td>
			<td></td>
			<td align="right">
			<a class="btn btn-sm btn-default btn_edit_learner" id="u_#user_id#" href="common_learner_account.cfm?u_id=#user_id#"><i class="fas fa-edit"></i></a>
			</td>
		</tr>
		</cfoutput>
	</table>
	
	<cfif not isdefined("view_full_learner") AND get_learner.recordcount gt 5>
		<div class="card-footer" style="text-align:right">
			<div class="stats">
			<a href="#" class="btn_learner_plus">[plus de learners]</a>
			</div>
		</div>
		</cfif>
	<cfelse>
	<em>Aucun learner cr&eacute;&eacute;</em>
	</cfif>

	<!---</div>
</div>--->