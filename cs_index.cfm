<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="provider_selected" default="0">



<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
	SELECT provider_id, provider_name, provider_code FROM account_provider
</cfquery>


<!--- 

<cfquery name="get_count_tp_status" datasource="#SESSION.BDDSOURCE#">
SELECT s.tp_status_name_fr as tp_status_name, s.tp_status_id, COUNT(tp_id) as nb 
FROM lms_tp t
INNER JOIN user u ON u.user_id = t.user_id
INNER JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
GROUP BY t.tp_status_id
</cfquery>

<cfquery name="get_count_tp_method" datasource="#SESSION.BDDSOURCE#">
SELECT m.method_name_fr as method_name, m.method_id, COUNT(tp_id) as nb 
FROM lms_tp t
INNER JOIN user u ON u.user_id = t.user_id
INNER JOIN lms_lesson_method m ON m.method_id = t.method_id
GROUP BY t.method_id
</cfquery>


--->

<!--- <cfset get_logs = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="1",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")> --->


<cfparam name="st_id" default="100">
<cfparam name="ust_id" default="3">
<cfparam name="m_id" default="100">
<cfparam name="pf_id" default="100">
<cfparam name="p_id" default="0">
<cfparam name="manager_id" default="#SESSION.USER_ID#">

<cfset get_task_list_cs = obj_task_get.oget_task_list(category="TO DO")>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				Vous n'avez pas acc&egrave;s &agrave; la page demand&eacute;e, vous avez &eacute;t&eacute; redirig&eacute;(e) vers votre page d'accueil
				</div>
			</cfif>
			
			
			
			<div class="row">
				<div class="col-md-12" align="center">				
					<div class="btn-group" role="group" aria-label="task_group_header">

						<cfoutput query="get_task_list_cs" group="task_group_alias">				
						<cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
						SELECT 
						COUNT(l.log_id) as nb,
						tt.task_type_name
						FROM logs l

						INNER JOIN logs_item li ON li.log_id = l.log_id
						INNER JOIN task_type tt ON tt.task_type_id = li.task_type_id
						LEFT JOIN user u ON u.user_id = l.user_id
						LEFT JOIN user t ON l.to_id = t.user_id
						LEFT JOIN user f ON l.from_id = f.user_id

						LEFT JOIN account a ON a.account_id = u.account_id
						LEFT JOIN account_group g ON g.group_id = a.group_id

						LEFT JOIN account al ON al.account_id = l.account_id
						LEFT JOIN account_group gl ON gl.group_id = l.group_id


						WHERE l.log_remind IS NOT NULL 
						AND task_group_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_alias#">

						AND date_format(log_remind, "%Y-%m-%d") = '#dateformat(now(),'yyyy-mm-dd')#'
						AND log_status IS NULL

						GROUP BY tt.task_type_name
						</cfquery>

						<cfloop query="get_task">
						<label class="btn btn-sm text-white" style="background-color:###get_task_list_cs.task_color# !important; font-weight:normal">
						#task_type_name#<br>
						#nb#
						</label>
						</cfloop>
						</cfoutput>
				
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="card">
						<div class="card-body">
						
							<div class="row">
			
								<div class="col-md-12" align="center">
								
								<table>
									<tr>
										<td valign="top">
											<div class="btn-group" role="group">
											<label class="btn btn-sm text-white p-1" style="background-color:#333333 !important; font-weight:normal">
											<input type="checkbox" value="0" class="active" id="cs_all" <cfif isdefined("SESSION.USER_PREF_TASK_GROUP") AND SESSION.USER_PREF_TASK_GROUP eq "">checked="checked"</cfif>><br>ALL
											</label>
											<cfoutput query="get_task_list_cs" group="task_group_alias">
											<label class="btn btn-sm text-white p-1" style="background-color:###task_color# !important; font-weight:normal">
											<input type="checkbox" value="#task_group#" class="active" id="#task_group#" <cfif isdefined("SESSION.USER_PREF_TASK_GROUP") AND SESSION.USER_PREF_TASK_GROUP neq ""><cfif listfind(SESSION.USER_PREF_TASK_GROUP,task_group)>checked="checked"</cfif><cfelse>checked="checked"</cfif>><br>#task_group_alias#
											</label>
											</cfoutput>
											</div>											
										</td>
										<td valign="top">
											<div class="btn-group" role="group">
											<!--- <label class="btn btn-sm text-white" style="background-color:#333333 !important"> --->
											<!--- <input type="checkbox" value="0" id="meeting_all"> ALL MEETINGS --->
											<!--- </label> --->
											<label class="btn btn-sm text-white p-1" style="background-color:#cbc49d !important; font-weight:normal">
											<input type="checkbox" value="1" id="meeting_setup"><br>SETUP
											</label>
											<label class="btn btn-sm text-white p-1" style="background-color:#9db7cb !important; font-weight:normal">
											<input type="checkbox" value="1" id="meeting_certif"><br>CERTIF
											</label>
											</div>	
										</td>
										<td valign="top">
											<!--- <label class="btn btn-sm text-white" style="background-color:#999999 !important"> --->
											<!--- <input type="checkbox" value="0" id="cs_closed"><br>CLOSED --->
											<div class="btn-group" role="group">
											<label class="btn btn-sm text-white p-1" style="background-color:#33618e !important; font-weight:normal">
											<input type="radio" value="0" name="task_everybody" id="task_everybody" checked><br> EVERYONE
											</label>
											<label class="btn btn-sm text-white p-1" style="background-color:#123C65 !important; font-weight:normal">
											<input type="radio" value="1" name="task_me" id="task_me"><br> JUST ME
											</label>
											</div>
										</td>
									</tr>
									<!--- <tr> --->
										<!--- <td><strong>SALES</strong></td> --->
										<!--- <td colspan="4"> --->
											<!--- <div class="btn-group" role="group"> --->
											<!--- <label class="btn btn-sm text-white" style="background-color:#333333 !important"> --->
											<!--- <input type="checkbox" value="0" class="active" id="sales_all"> ALL --->
											<!--- </label> --->
											<!--- <cfoutput query="get_task_list_sales" group="task_group_alias"> --->
											<!--- <label class="btn btn-sm text-white" style="background-color:###task_color# !important"> --->
											<!--- <input type="checkbox" value="#task_group#" class="active" id="#task_group#"  <cfif isdefined("SESSION.USER_PREF_TASK_GROUP") AND SESSION.USER_PREF_TASK_GROUP neq ""><cfif listfind(SESSION.USER_PREF_TASK_GROUP,task_group)>checked="checked"</cfif></cfif>> #task_group_alias# --->
											<!--- </label> --->
											<!--- </cfoutput> --->
											<!--- <label class="btn btn-sm text-white" style="background-color:#999999 !important"> --->
											<!--- <input type="checkbox" value="0" id="sales_closed"> CLOSED --->
											<!--- </label> --->
											<!--- </div> --->
										<!--- </td> --->
									<!--- </tr> --->
								</table>
								
								</div>
							</div>	

							<div class="col-md-12" align="center">
								
								<table>
									<tr>
										<td valign="top" align="center">
											<div class="btn-group" role="group">
											<cfoutput query="get_provider">
											<label class="btn btn-sm text-white p-1" style="font-weight:normal">
											<input type="checkbox" value="#provider_id#" class="active" id="provider_#provider_id#"> #provider_name#
											</label>
											</cfoutput>
											</div>											
										</td>
									</tr>
								</table>
								
							</div>
							<div class="row mt-2">
								<div class="col-md-12">
									<div id="calendar"></div> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			


			<!--- <div class="row">
						
				<div class="col-md-12">
						
					<div class="card">
						<div class="card-body">
							<table class="table table-borderless">
								<tr>
									<td align="center">
									<i class="fa-light fa-rabbit-running fa-2x"></i><br><strong><cfoutput>#get_active.nb#</cfoutput></strong><br>ACTIVE L
									</td>
									<td align="center">
									<i class="fa-light fa-play-pause fa-2x"></i><br><strong><cfoutput>#get_tolaunch.nb#</cfoutput></strong><br>TO LAUNCH L
									</td>
									<td align="center">
									<i class="fa-light fa-list-check fa-2x"></i><br><strong><cfoutput>#get_launching.nb#</cfoutput></strong><br>LAUNCHING L
									</td>

									<td align="center">
										<i class="fa-light fa-camera-web fa-2x"></i><br><strong><cfoutput><span class="lang-sm" lang="fr"></span> #get_tp_inprogress_fr.nb# / <span class="lang-sm" lang="de"></span> #get_tp_inprogress_de.nb# </cfoutput></strong><br>VISIO TP PROGRESS
									</td>
									<td align="center">
										<i class="fa-light fa-camera-web fa-2x"></i><br><strong><cfoutput><span class="lang-sm" lang="fr"></span> #get_tp_tolaunch_fr.nb# / <span class="lang-sm" lang="de"></span> #get_tp_tolaunch_de.nb# </cfoutput></strong><br>VISIO TP TO LAUNCH
									</td>

								</tr>
							</table>
							
						</div>
					</div>
					
				</div>
				
			</div> --->






			<!--- <div class="row">
						
				<div class="col-md-12">
						
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">ALL - LEARNERS / Lancements</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="#ust_id#",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_steps_all" role="button" aria-expanded="false" aria-controls="d_steps_all"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_steps_all">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
							
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">ALL - LEARNERS / A lancer</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="2",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#")>
																
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_launch_all" role="button" aria-expanded="false" aria-controls="d_launch_all"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_launch_all">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div> --->






















			<!--- <div class="row">
			
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - LEARNERS / Lancements</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="#ust_id#",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#",manager_id="#manager_id#")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_steps" role="button" aria-expanded="false" aria-controls="d_steps"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_steps">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - LEARNERS / A lancer</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="2",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#",manager_id="#manager_id#")>
							
							
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_launch" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_launch">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - Order / Proposal</h6>
							
							<cfset get_orders = obj_query.oget_orders(s_id="1",manager_id="#SESSION.USER_ID#")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_proposal" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_proposal">
							<cfset view_order = "compact">
							<cfinclude template="./widget/wid_order_list.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - Order / En attente</h6>
							
							<cfset get_orders = obj_query.oget_orders(s_id="2",manager_id="#SESSION.USER_ID#")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_wait" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_wait">
							<cfset view_order = "compact">
							<cfinclude template="./widget/wid_order_list.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - PTA DONE</h6>
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_pta" role="button" aria-expanded="false" aria-controls="d_pta">+</a></div>
							
							<br><br>
							<div class="collapse" id="d_pta">
							</div>
							
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - PTA MISSED</h6>
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_pta_missed" role="button" aria-expanded="false" aria-controls="d_pta_missed">+</a></div>
							
							<br><br>
							<div class="collapse" id="d_pta_missed">
							</div>
							
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title"><cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput> - PTA COMING SOON</h6>
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_pta_coming" role="button" aria-expanded="false" aria-controls="d_pta_coming">+</a></div>
							
							<br><br>
							<div class="collapse" id="d_pta_coming">
							</div>
							
						</div>
					</div>
					
				</div>
			</div>
			
		
		
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">WEFIT - LEARNERS / Lancements</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="#ust_id#",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_steps_all" role="button" aria-expanded="false" aria-controls="d_steps_all"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_steps_all">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">WEFIT - LEARNERS / A lancer</h6>
							<cfset get_learner = obj_query.oget_learner(ust_id="2",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#",p_id="#p_id#")>
							
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_launch_all" role="button" aria-expanded="false" aria-controls="d_launch_all"><cfoutput>#get_learner.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_launch_all">
							<cfinclude template="./widget/wid_learner_list_cs.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">WEFIT - Order / Proposal</h6>
							
							<cfset get_orders = obj_query.oget_orders(s_id="1",manager_id="176")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_proposal" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_proposal">
							<cfset view_order = "compact">
							<cfinclude template="./widget/wid_order_list.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			
			<div class="row">
	
				<div class="col-md-12">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">WEFIT - Order / En attente</h6>
							
							<cfset get_orders = obj_query.oget_orders(s_id="2",manager_id="176")>
							
							<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_wait" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
							
							<br><br>
							<div class="collapse" id="d_wait">
							<cfset view_order = "compact">
							<cfinclude template="./widget/wid_order_list.cfm">
							</div>
							
						</div>
					</div>
					
				</div>
				
			</div>
			




			<div class="row">
				
				<div class="col-md-7">
				
					
							
					<div class="row">
			
						<div class="col-md-12">
						
							<div class="card">
								<div class="card-body">
									<h6 class="card-title">ALL - Order / Proposal</h6>
									
									<cfset get_orders = obj_query.oget_orders(s_id="1")>
									
									<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_proposal" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
									
									<br><br>
									<div class="collapse" id="d_proposal">
									<cfset view_order = "full">
									<cfinclude template="./widget/wid_order_list.cfm">
									</div>
									
								</div>
							</div>
							
						</div>
						
					</div>
							
					<div class="row">
			
						<div class="col-md-12">
						
							<div class="card">
								<div class="card-body">
									<h6 class="card-title">ALL - Order / En attente</h6>
									
									<cfset get_orders = obj_query.oget_orders(s_id="2")>
									
									<div class="float-right"><a class="btn btn-sm btn-primary" data-toggle="collapse" href="#d_wait" role="button" aria-expanded="false" aria-controls="d_launch"><cfoutput>#get_orders.recordcount#</cfoutput></a></div>
									
									<br><br>
									<div class="collapse" id="d_wait">
									<cfset view_order = "full">
									<cfinclude template="./widget/wid_order_list.cfm">
									</div>
									
								</div>
							</div>
							
						</div>
						
					</div>
					
				</div>
				
				<div class="col-md-5">
				
					<div class="card">
						<div class="card-body">
							<h6 class="card-title">ACTIVIT&Eacute; JOUR</h6>
							
							<table class="table table-bordered">
							
							<cfif get_logs.recordcount neq "0">
								<cfoutput query="get_logs" group="user_id">
								<tr>
									<td>#user_firstname#</td>
									<td><cfoutput><span class="badge badge-info" style="width:20px">#nb#</span> #task_type_name# <br></cfoutput></td>
									
								</tr>
								</cfoutput>
							</cfif>
							
							</table>
							
						</div>
					</div>
					
				</div>
				
			</div> --->
				
				
				
		
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>

<cfif not isdefined("picker")>
<cfset picker = dateformat(now(),"yyyy-mm-dd")>
</cfif>

var avail_choice = "remove";
var currentTimezone = "UTC";


$(document).ready(function() {

	<cfif isDefined("openlog")>

		// window.location.href =  window.location.href.split("?")[0];
		$('#modal_title_xl').text("Follow-Up");
		$('#window_item_xl').modal({keyboard: true});

		<cfif isdefined("u_id")>
			$('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
		<cfelseif isdefined("a_id")>
			$('#modal_body_xl').load("modal_window_log.cfm?a_id="+<cfoutput>#a_id#</cfoutput>, function() {})
		<cfelseif isdefined("g_id")>
			$('#modal_body_xl').load("modal_window_log.cfm?g_id="+<cfoutput>#g_id#</cfoutput>, function() {})
		</cfif>
	</cfif>

	var sprovider = [];

function renderCalendar() {
	
$('#calendar').fullCalendar({

	/**************COMMON****************/
	/*schedulerLicenseKey: '0542611006-fcs-1459164489',*/
	/*themeSystem: 'bootstrap4',*/
	/*nowIndicator:true,*/
	/*eventConstraint: "blocker",*/
	
	schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
	defaultDate: '<cfoutput>#picker#</cfoutput>',	
	timeFormat: 'H:mm',
	hiddenDays: [0,6],
	lang:'<cfoutput>#lcase(SESSION.LANG_CODE)#</cfoutput>',
	axisFormat: 'HH:mm',
	allDaySlot: true,	
	defaultEventMinutes:15,
	timezone: currentTimezone,
	<cfif isdefined("cal_view")>
	defaultView: '<cfoutput>#cal_view#</cfoutput>',
	<cfelse>
	defaultView: 'agendaWeek',
	</cfif>	
	selectHelper: false,	
	firstDay: 1,
	minTime: '06:00:00',
	maxTime: '23:00:00',
	slotDuration: '00:15:00',
	navLinks: true,
	editable: false,
	eventStartEditable: false,
	eventResizableFromStart: false,
	eventDurationEditable: false,
	droppable: false,
	eventOrder:["task_group_alias"],

		
	header: {
		left: 'prev,next today',
		center: 'title',
		right: 'agendaWeek,month'
	},		
	
	eventOrder:'title',
  
		/**************SOURCE****************/	
		eventSources: [

			<cfoutput>

			<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
				<cfif isdefined("SESSION.USER_PREF_TASK_GROUP") AND SESSION.USER_PREF_TASK_GROUP eq "">
					<!---"./calendar/get_data_lms_calendar.cfm?get_task=1&task_closed=0",--->
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_admin&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_certificate&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_info&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_elearning&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_finance&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_launching&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_training&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_trainer&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_posttraining&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_immersion&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_test&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_sales&task_closed=0",
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=cs_pe&task_closed=0"
									
				<cfelse>
					<cfif isdefined("SESSION.USER_PREF_TASK_GROUP") AND SESSION.USER_PREF_TASK_GROUP neq "">
					<cfloop list="#SESSION.USER_PREF_TASK_GROUP#" index="cor">
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#cor#&task_closed=0",
					</cfloop>
					</cfif>
				</cfif>
				
			<cfelseif SESSION.USER_PROFILE eq "SALES">
			
					"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=sales_info&task_closed=0"

			</cfif>
			
			<!---
				"./calendar/get_data_lms_calendar.cfm?get_task=1&task_group=0&task_closed=1"
				"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785",
				"./calendar/get_data_lms_calendar.cfm?get_lesson=1&p_id=4784",--->
			
			</cfoutput>
		],		
		/**************END SOURCE****************/

		
		eventClick: function(event) {

			if($.isNumeric(event.user_id) && !$.isNumeric(event.lesson_id))
			{
				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_log.cfm?u_id="+event.user_id, function() {})
			}
			else if($.isNumeric(event.account_id_log) && !$.isNumeric(event.lesson_id))
			{
				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_log.cfm?a_id="+event.account_id_log, function() {})
			}
			else if($.isNumeric(event.group_id_log) && !$.isNumeric(event.lesson_id))
			{
				$('#modal_title_xl').text("Follow-Up");
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_body_xl').load("modal_window_log.cfm?g_id="+event.group_id_log, function() {})
			}
			
		},
	  
		eventRender: function(event, element) {
			
			if($.isNumeric(event.lesson_id) && $.isNumeric(event.calendartype)){    
				if(event.calendartype == "2")
				{
					
					element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><a class="btn btn-sm btn-danger text-white p-0 m-0 remove" style="min-width:20px !important; padding:2px !important"><i class="fas fa-times"></i></a><br><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
					element.find(".remove").on("click", function() {
					if(confirm("Remove Setup ?"))
						{
						document.location.href='updater_lesson.cfm?faction=erase&l_id='+event.lesson_id+'&p_id='+event.planner_id+'&u_id='+event.user_id;
						}
					})
				
				}
				else{
					element.find(".fc-title").before('<div style="float:left; cursor:pointer; margin-right:2px"><!---<a class="btn btn-sm btn-danger text-white p-0 m-0 remove" href=""><i class="fas fa-times"></i></a><br>---><a class="btn btn-sm btn-danger p-0 m-0 go_user" href="common_learner_account.cfm?u_id='+event.user_id+'" style="min-width:20px !important; padding:2px !important"><i class="fas fa-user"></i></a></div>');
				}
		
			}
			
			element.find(".fc-title").html(element.find('.fc-title').text());

		}
	
	
});

	
}


renderCalendar();

function updateCalendar(checked, todisplay) {

	console.log("hello");

	if(todisplay=="meeting_all")
	{
		if(checked)		
		{	
			$('#calendar').fullCalendar('removeEventSources');

			$('#cs_all').prop("checked",false);
			<cfoutput query="get_task_list_cs" group="task_group_alias">
				$('###task_group#').prop("checked",false);
			</cfoutput>
			
			$('#meeting_setup').prop("checked",true);
			$('#meeting_certif').prop("checked",true);
			$('#calendar').fullCalendar('addEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
			$('#calendar').fullCalendar('addEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784",);
			
		}
		else{		
			$('#meeting_setup').prop("checked",false);
			$('#meeting_certif').prop("checked",false);
			$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
			$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784",);
		}
	
	}
	else if(todisplay=="cs_all")
	{
		if(checked)
		{

			<cfoutput query="get_task_list_cs" group="task_group_alias">
			if($('###task_group#').prop("checked") == false)
			{
			displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#task_group#&task_closed=0';
			$('##calendar').fullCalendar('addEventSource', displayid);
			$('###task_group#').prop("checked",true);
			}
			</cfoutput>
			
			$('#meeting_all').prop("checked",false);
			$('#meeting_setup').prop("checked",false);
			$('#meeting_certif').prop("checked",false);
			$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
			$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784");
			
		}
		else{
			<cfoutput query="get_task_list_cs" group="task_group_alias">
				$('###task_group#').prop("checked",false);
			</cfoutput>
			$('#calendar').fullCalendar('removeEventSources');
		}
		
	}
	else if(todisplay=="cs_closed")
	{
		if(checked)
		{	
			<cfoutput query="get_task_list_cs" group="task_group_alias">
			displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#task_group#&task_closed=1';
			$('##calendar').fullCalendar('addEventSource', displayid);
			</cfoutput>
		}
		else{		
			<cfoutput query="get_task_list_cs" group="task_group_alias">
			displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#task_group#&task_closed=1';
			$('##calendar').fullCalendar('removeEventSource', displayid);
			</cfoutput>
		}
	}
	else
	{
		if(todisplay == "meeting_certif")
		{
			if(checked)		
			{	
				$('#cs_all').prop("checked",false);
				<cfoutput query="get_task_list_cs" group="task_group_alias">
					$('###task_group#').prop("checked",false);
				</cfoutput>
				$('#calendar').fullCalendar('removeEventSources');
				
				$('#calendar').fullCalendar('addEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784");				
				
			}
			else{		
				$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784");
			}
		}
		else if(todisplay == "meeting_setup")
		{
			if(checked)
			{	
			
				$('#cs_all').prop("checked",false);
				<cfoutput query="get_task_list_cs" group="task_group_alias">
					$('###task_group#').prop("checked",false);
				</cfoutput>
				$('#calendar').fullCalendar('removeEventSources');
				

				$('#calendar').fullCalendar('addEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
				
			}
			else{		
				$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
			}
		}
		else
		{

			if (sprovider.length > 0) {
				// for (let index = 0; index < sprovider.length; index++) {
				// 	const element = sprovider[index];
					
					displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group='+todisplay+'&task_closed=0&provider_selected=' + sprovider;
			
					if(checked)
				
					{
						$('#meeting_all').prop("checked",false);
						$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
						$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784");
						
						$('#calendar').fullCalendar('addEventSource', displayid);
					}
					else{		

						$('#cs_all').prop("checked",false);
						$('#calendar').fullCalendar('removeEventSource', displayid);
					}
				// }
			} else {
			
				displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group='+todisplay+'&task_closed=0';
				
				if(checked)
			
				{
					$('#meeting_all').prop("checked",false);
					$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_setup=1&p_id=4785");
					$('#calendar').fullCalendar('removeEventSource',"./calendar/get_data_lms_calendar.cfm?get_certif=1&p_id=4784");
					
					$('#calendar').fullCalendar('addEventSource', displayid);
				}
				else{		

					$('#cs_all').prop("checked",false);
					$('#calendar').fullCalendar('removeEventSource', displayid);
				}
			}
			
		}
		
	}
	
}

	<!--- PARAM RADIO BTN FOR DISPLAYING TASK ATTACHED --->
	$('label > input[type=radio]').on('change', function () {
	
		var todisplay = $(this).attr('id');
		<!--- alert(todisplay); --->
		if(todisplay=="task_me")
		{
			
		}
		else if(todisplay=="task_everybody")
		{
		
		}
	
	});
	
	
	<!--- PARAM CHECKBOX FOR DISPLAYING EVENT LAYER ON CALENDAR --->
	$('label > input[type=checkbox]').on('change', function () {

		
	
	var todisplay = $(this).attr('id');

	console.log($(this).attr('id'));



	if(todisplay.match("provider"))
	{
		if($(this).is(':checked'))
		{
			sprovider.push($(this).val());
		}
		else{		
			let to_remove = sprovider.indexOf($(this).val());
			if (to_remove > -1) { 
				sprovider.splice(to_remove, 1);
			}
		}

		$('#calendar').fullCalendar('removeEventSources');

		if (sprovider.length == 0) {
			<cfoutput query="get_task_list_cs" group="task_group_alias">
				if($('###task_group#').prop("checked") == true)
				{
				displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#task_group#&task_closed=0';
				$('##calendar').fullCalendar('addEventSource', displayid);
				}
			</cfoutput>
		} else {
			<cfoutput query="get_task_list_cs" group="task_group_alias">
			if($('###task_group#').prop("checked") == true)
			{
			displayid = './calendar/get_data_lms_calendar.cfm?get_task=1&task_group=#task_group#&task_closed=0&provider_selected=' + sprovider;
			$('##calendar').fullCalendar('addEventSource', displayid);
			}
			</cfoutput>
		}



	} else {
		if (sprovider.length > 0) {
			for (let index = 0; index < sprovider.length; index++) {
				const element = sprovider[index];
				updateCalendar($(this).is(':checked'), todisplay, element);
			}
		} else {
			updateCalendar($(this).is(':checked'), todisplay);
		}
	}

	
	console.log("sprovider", sprovider);
	<!----------- RERENDER / REFETCH ------------>
	$('#calendar').fullCalendar('rerenderEvents');
	$('#calendar').fullCalendar('refetchEvents');
	
	});
		
});
</script>

</body>
</html>