<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<cfquery name="get_ctc" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM account_contact WHERE contact_active = 1
</cfquery>

<cfquery name="get_account_all" datasource="#SESSION.BDDSOURCE#">
SELECT account_id, account_name
FROM account ORDER BY account_name
</cfquery>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "TM LIST WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">
	  			
			<!---<div class="row">
			
				<div class="col-md-10">	
				
					<div class="card">
					
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">			
									<!---<cfoutput><h5>#get_count.nb# learners</h5></cfoutput>--->
									<!---<cfoutput>
									<a href="cs_accounts.cfm" class="btn btn-sm <cfif pf_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-graduation-cap"></i>&nbsp;ALL</a>
									</cfoutput>
									
									<cfoutput query="get_user_profile">
									<a href="cs_accounts.cfm" class="btn btn-sm <cfif pf_id eq profile_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;#profile_name#</a>
									</cfoutput>--->
								</div>
							</div>
							
							
						</div>
						
					</div>
					
				</div>
				
				
				
			</div>--->
			
			<!---<ul class="nav nav-tabs" id="tp_list" role="tablist">
				<!---<li class="nav-item">		
					<a href="#g_solo" id="t_#tp_id#" class="nav-link <cfif view eq "solo">active</cfif>" role="tab" data-toggle="tab">
					My groups
					</a>
				</li>--->
				<li class="nav-item">		
					<a href="#g_all" id="t_#tp_id#" class="nav-link <cfif isdefined("view")>active</cfif>" role="tab" data-toggle="tab">
					All groups
					</a>
				</li>
				<cfoutput query="get_user">
				<li class="nav-item">		
					<a href="##g_#user_id#" class="nav-link <cfif get_user.user_id eq SESSION.USER_ID OR (isdefined("u_id") AND u_id eq get_user.user_id)>active</cfif>" role="tab" data-toggle="tab">
					#user_firstname#
					</a>
				</li>
				</cfoutput>
			</ul>

			<div class="tab-content">

				<div role="tabpanel" class="tab-pane fade <cfif isdefined("view")>active show</cfif>" id="g_all" style="margin-top:15px">
						--->	
					<div class="row">
					
						<div class="col-md-12">

						<table class="table table-bordered bg-white">
							<tbody>
								<tr class="bg-light">
									<th width="2%"><label>CTC_ID</label></th>
									<th width="2%"><label>Opt'in</label></th>
									<th width="2%"><label>Issue</label></th>
									<th width="7%"><label>TM Status</label></th>
									<th width="10%"><label>TM Firstname</label></th>
									<th width="10%"><label>TM Name</label></th>
									<th width="20%"><label>Account</label></th>
									<th width="20%"><label>Email</label></th>
									<th width="12%"><label>T&eacute;l 1</label></th>
									<th width="12%"><label>T&eacute;l 2</label></th>
									<th width="5%"><label>TM acc</label></th>
									<th width="5%"><label>TM acc</label></th>
									<th width="12%"><label>Action</label></th>
								</tr>
							<cfoutput query="get_ctc">
							
							<cfif account_id neq "">
							<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
							SELECT account_id, account_name
							FROM account WHERE account_id IN (#account_id#)
							</cfquery>
							</cfif>

							<tr>
								<td width="2%" align="center">
								#contact_id#
								</td>
								<td width="2%" align="center">
								<cfif contact_optin eq "0"><a class="btn btn-sm btn-warning" href="updater_crm.cfm?ctc_id=#contact_id#&updt_optin=1"><i class="fas fa-exclamation-triangle"></i></a><cfelse><a class="btn btn-sm btn-success" href="updater_crm.cfm?ctc_id=#contact_id#&updt_optin=0"><i class="far fa-thumbs-up"></i></a></cfif>
								</td>
								<td width="2%" align="center">
								<cfif contact_issue eq "1"><a class="btn btn-sm btn-danger" href="updater_crm.cfm?ctc_id=#contact_id#&updt_issue=0"><i class="fas fa-exclamation-triangle"></i></a><cfelse><a class="btn btn-sm btn-success" href="updater_crm.cfm?ctc_id=#contact_id#&updt_issue=1"><i class="far fa-thumbs-up"></i></a></cfif>
								</td>
								<td align="center">
								<cfif contact_active eq "1">
								<span class="badge badge-pill text-white bg-success">Actif</span>			
								<cfelse>
								<span class="badge badge-pill text-white  bg-dark">Inactif</span>			
								</cfif>
								</td>
								<td>#contact_firstname#
								</td>
								<td>#contact_name#</td>
								<td>
								<cfif account_id neq "" AND account_id neq "0">
									<cfloop query="get_account">
									<a href="crm_account_edit.cfm?a_id=#get_account.account_id#">#get_account.account_name#</a><br>
									</cfloop>
								<cfelse>
									<form action="updater_crm.cfm" method="post" class="d-inline">
										<select name="a_id" class="form-control d-inline" style="width:120px">
										<cfloop query="get_account_all">
										<option value="#account_id#">#account_name#</option>
										</cfloop>
										</select>									
										<input type="hidden" name="link_contact" value="1">
										<input type="hidden" name="contact_id" value="#contact_id#">
										<input class="btn btn-sm d-inline" type="submit" value="LINK">
									</form>								
								</cfif>
								</td>
								<td>#contact_email#</td>
								<td>#contact_tel1#</td>
								<td>#contact_tel2#</td>
								<td>
									<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
									SELECT u.user_id, u.user_email, u.user_password, up.profile_name
									FROM user u
									INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
									INNER JOIN user_profile up ON upc.profile_id = up.profile_id
									WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_email#">
									</cfquery>
									<cfif get_user.recordcount neq "0">
									<cfloop query="get_user">
									<a class="btn btn-sm btn-info p-1" href="#SESSION.BO_ROOT_URL#/index.cfm?user_name=#get_user.user_email#&upass=#get_user.user_password#" id="tm_#get_user.user_id#">#get_user.profile_name#</a>
									</cfloop>
									</cfif>
								</td>
								<td>
								<cfif contact_active eq "1">
								<a href="updater_crm.cfm?ctc_id=#contact_id#&a_id=#account_id#&inactive_contact=1" class="btn btn-sm btn-outline-info p-1">D&eacute;sactiver</a>
								<cfelse>
								<a href="updater_crm.cfm?ctc_id=#contact_id#&a_id=#account_id#&active_contact=1" class="btn btn-sm btn-outline-info p-1">Activer</a>
								</cfif>
								</td>
								<td>
								<a class="btn btn-sm btn-default btn_edit_ctc" href="##" id="c_#account_id#_#contact_id#"><i class="fas fa-edit"></i></a>
								</td>
							</tr>
							
							</cfoutput>
							
							
						
							</tbody>
						</table>
						
								
						</div>
					</div>
				
			</div>
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {
	$('.btn_edit_ctc').click(function(event) {
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var ctc_id = idtemp[2];	
	var a_id = idtemp[1];		
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_title_lg').text("\u00c9diter contact");
	$('#modal_body_lg').load("modal_window_crm.cfm?ctc_edit=1&contact_id="+ctc_id+"&a_id="+a_id, function() {});
	});	
})
</script>

</body>
</html>