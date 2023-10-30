<!DOCTYPE html>

<cfsilent>
	
<cfquery name="get_account_group" datasource="#SESSION.BDDSOURCE#">
SELECT a.account_id, a.account_name, g.group_name, g.group_id, g.group_type
FROM account a 
INNER JOIN account_group g ON g.group_id = a.group_id
WHERE g.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
</cfquery>

<cfset a_id = get_account_group.account_id>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "GROUP LIST WEFIT">
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
			
			<ul class="nav nav-tabs" id="tp_list" role="tablist">
				<cfoutput query="get_account_group">
				<li class="nav-item">		
					<a href="##a_#account_id#" class="nav-link <cfif get_account_group.account_id eq a_id>active</cfif>" role="tab" data-toggle="tab">
					#account_name#
					</a>
				</li>
				</cfoutput>
			</ul>

			<div class="tab-content">

				<cfoutput query="get_account_group">
				
<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT u.*, tp.*, f.formation_name_fr
FROM user u
LEFT JOIN lms_tp tp ON tp.user_id = u.user_id
LEFT JOIN lms_formation f ON f.formation_id = tp.formation_id
WHERE u.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">
<!---AND tp.method_id = 3 AND tp.formation_id = 2--->
</cfquery>

				<div role="tabpanel" class="tab-pane fade <cfif get_account_group.account_id eq a_id>active show</cfif>" id="a_#account_id#" style="margin-top:15px">
							
					<div class="row">
					
						<div class="col-md-12">

							<table class="table table-bordered table-striped bg-white">
								<tbody>
									<tr class="bg-light">
										<th>Pr&eacute;nom</th>
										<th>Nom</th>
										<th>Langue</th>
										<th>Fin</th>
										<th>Fin</th>
										<th>Niveau (Placement Test)</th>
										<th>Mock Tests</th>
										<th>Nb cours</th>										
										<th>Nb quiz</th>	
										<th>Total LMS</th>
										<th>Derni&egrave;re connexion</th>
									</tr>
								<cfloop query="get_user">
								
								<cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
								SELECT sm_id, SUM(sm_elapsed) as timego
								FROM user_elapsed ue
								INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ue.sm_id 
								INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
								INNER JOIN lms_tpmaster2 tp ON tc.tpmaster_id = tp.tpmaster_id	
								WHERE ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
								GROUP BY sm_id
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
								</cfquery>


								<tr>
									<td><a href="common_learner_account.cfm?u_id=#user_id#">#get_user.user_firstname#</a></td>
									<td><a href="common_learner_account.cfm?u_id=#user_id#">#get_user.user_name#</a></td>
									<td>#formation_name_fr#</td>
									<td>#dateformat(tp_date_start,'dd/mm/yyyy')#</td>
									<td>#dateformat(tp_date_end,'dd/mm/yyyy')#</td>
									<td><span class="badge badge-pill <cfif get_user.user_qpt eq "A0">bg-danger<cfelseif get_user.user_qpt eq "A1">bg-success<cfelseif get_user.user_qpt eq "A2">bg-success<cfelseif get_user.user_qpt eq "B1">bg-info<cfelseif get_user.user_qpt eq "B2">bg-info<cfelseif get_user.user_qpt eq "C1">bg-warning<cfelseif get_user.user_qpt eq "C2">bg-warning</cfif> text-white">#get_user.user_qpt# <cfif get_user.user_qpt_lock eq "0">[en cours]</cfif></td>
									<td>
									<cfloop query="get_mock">
										#ucase(quiz_type)# : <cfif get_mock.quiz_user_end eq "">Non fini<cfelse>ok</cfif><br>
									</cfloop>
									</td>
									<td><cfif get_activity.recordcount gt "1">#get_activity.recordcount#<cfelse>-</cfif></td>									
									<td><cfif get_quiz.recordcount neq "0">#get_quiz.recordcount#<cfelse>-</cfif></td>
									<td><cfif user_elapsed neq "">#obj_lms.get_format_hms(toformat="#user_elapsed#")#<cfelse>-</cfif></td>
									<td><cfif user_lastconnect neq "">#dateformat(user_lastconnect,'dd/mm/yyyy')#<cfelse>-</cfif></td>
								</tr>
								</cfloop>
							
								<!---<cfset counter = 0>
								<cfoutput query="get_group_all" group="group_id">
								<cfset counter++>
								<tr <cfif counter mod 2 eq "0">class="bg-light"</cfif>>
									<td><span class="badge badge-pill text-white" style="background-color:###user_color#">#user_firstname#</span></td>
									<td><span class="badge badge-pill text-white badge-default
									<cfif group_type eq "FARMING">bg-info<cfelseif group_type eq "MARKETING">bg-success<cfelseif group_type eq "HUNTING">bg-warning<cfelseif group_type eq "PROSPECT">bg-danger</cfif>">#group_type#</span>
									</td>
									<td>
										<i class="fas fa-plus-square"></i> <strong data-toggle="collapse" data-target=".g_#group_id#" style="cursor:pointer">#group_name# </strong>
									</td>
									<td></td>
									<td></td>
									<td align="right">
										
									<cfset m_1 = month(dateadd("m",-1,now()))>
									<cfset y_1 = year(dateadd("m",-1,now()))>
									<a href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#y_1#_#m_1#" class="btn btn-sm btn-outline-info p-1">#listgetat(SESSION.LISTMONTHS_SHORT,m_1)# #y_1#</a>
								
									<cfset m_0 = month(now())>
									<cfset y_0 = year(now())>
									<a href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#y_0#_#m_0#" class="btn btn-sm btn-outline-info p-1">#listgetat(SESSION.LISTMONTHS_SHORT,m_0)# #y_0#</a>
									
									</td>
									<!---<td align="right">
									<!---<a class="btn btn-sm btn-outline-info" href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#tselect#">Report. Group Mois</a>
									<a class="btn btn-sm btn-outline-info" href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=all">Report. Group Global</a>--->
									</td>--->
								</tr>
								
								<cfoutput group="account_id">
								<tr class="collapse g_#group_id# <cfif counter mod 2 eq "0">bg-light</cfif>">
							
									<td></td>
									<td></td>
									<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
									SELECT contact_firstname, ucase(contact_name) as contact_name, contact_id 
									FROM account_contact ac 
									INNER JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id 
									WHERE acc.a_id = #account_id# 
									</cfquery>
								
									<td>
									<a href="crm_account_edit.cfm?a_id=#account_id#">&nbsp;&nbsp;&nbsp;<strong>#account_name#</strong></a>
									</td>
									<cfif get_contact.recordcount gt "1">
									<cfloop query="get_contact">
									<td>TM : #contact_firstname# #contact_name#</td>
									</cfloop>
									<cfelseif get_contact.recordcount eq "1">
									<td>TM : #get_contact.contact_firstname# #get_contact.contact_name#</td><td></td>
									<cfelse>
									<td></td><td></td>
									</cfif>
									<td align="right">												
										
									<cfset m_1 = month(dateadd("m",-1,now()))>
									<cfset y_1 = year(dateadd("m",-1,now()))>
									<a href="./exporter/export_reporting_cs.cfm?a_id=#account_id#&tselect=#y_1#_#m_1#" class="btn btn-sm btn-outline-info">#listgetat(SESSION.LISTMONTHS_SHORT,m_1)#</a>
								
									<cfset m_0 = month(now())>
									<cfset y_0 = year(now())>
									<a href="./exporter/export_reporting_cs.cfm?a_id=#account_id#&tselect=#y_0#_#m_0#" class="btn btn-sm btn-outline-info">#listgetat(SESSION.LISTMONTHS_SHORT,m_0)#</a>
											
									</td>
								</tr>					
								</cfoutput>	--->
								
								</tbody>
							</table>
						
								
						</div>
					</div>
				
				</div>
				</cfoutput>	
			</div>
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>

</script>

</body>
</html>