<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">

<!--------------- DEFAULT DATE & VIEW  ------------->
<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfset y = mid(ysel,3,2)>

<cfparam name="prov_id" default="0">
<cfset prov_pos = listContainsNoCase(SESSION.SELECTED_PROVIDER, prov_id)>

<cfif prov_id neq 0 AND prov_pos eq 0>
	<cfset SESSION.SELECTED_PROVIDER = listAppend(SESSION.SELECTED_PROVIDER, prov_id)>
<cfelseif prov_id neq 0 AND prov_pos neq 0>
	<cfset SESSION.SELECTED_PROVIDER = listDeleteAt(SESSION.SELECTED_PROVIDER, prov_pos)>
</cfif>

<cfif SESSION.SELECTED_PROVIDER eq "">
	<cfset SESSION.SELECTED_PROVIDER = "1">
</cfif>


<cfparam name="view" default="reg">
<!--------------- DEFAULT DATE & VIEW  ------------->


<cfparam name="o_by" default="account_name">
<cfparam name="t_id" default="1">
<cfparam name="pv_id" default="all">
<cfparam name="manager_id" default="all">



<!---<cfif (SESSION.USER_ID eq "202" OR SESSION.USER_ID eq "69" OR SESSION.USER_ID eq "2072" OR SESSION.USER_ID eq "3471" OR SESSION.USER_ID eq "4809") AND not isdefined("u_id")>
<cfparam name="view" default="all">
</cfif>--->

<!---<cfset get_learner = obj_query.oget_learner(ust_id="#ust_id#",st_id="#st_id#",m_id="#m_id#",pf_id="#pf_id#")>---->

<!---
<cfquery name="get_user_profile" datasource="#SESSION.BDDSOURCE#">
SELECT profile_id, profile_name FROM user_profile WHERE profile_id = 3 OR profile_id = 7 
</cfquery>

<cfquery name="get_count" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(user_id) as nb FROM user WHERE profile_id = 3 
</cfquery>--->



<!------------------ GET ACCOUNT MANAGERS --------------->
<cfquery name="get_manager" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_color
FROM user u 
WHERE user_id IN (SELECT DISTINCT(user_id) as id FROM account)
</cfquery>

<!------------------ GET ACCOUNT BY MANAGER --------------->
<cfquery name="get_count_account_user_all" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a WHERE type_id <> 4
</cfquery>

<cfloop query="get_manager">
<cfquery name="get_count_account_user_#user_id#" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a
WHERE a.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_manager.user_id#">
</cfquery>
</cfloop>

<!------------------ GET ACCOUNT TYPE --------------->
<cfquery name="get_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type WHERE type_id <> 4 ORDER BY field(type_id,1,2,8,3,9,5,7,6)
</cfquery>

<!------------------ GET ACCOUNT BY TYPE --------------->
<cfquery name="get_count_account_type_all" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a WHERE type_id <> 4
</cfquery>

<cfloop query="get_account_type">
<cfquery name="get_count_account_type_#type_id#" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a
WHERE a.type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_account_type.type_id#">
</cfquery>

<cfquery name="get_ca_account_type_#type_id#" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(oi.item_inv_total) as ca
FROM orders o
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN account a ON o.account_id = a.account_id
INNER JOIN account_group ag ON ag.group_id = a.group_id
INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

<cfif view eq "reg">
	WHERE SUBSTRING(order_ref,1,2) = '#y#'
<cfelseif view eq "close">
	WHERE DATE_FORMAT(order_date,'%Y') = '20#y#'
</cfif>

AND o.order_status_id IN (3,4,5,10,11)

AND a.type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#type_id#">

</cfquery>

</cfloop>


<!------------------ GET ACCOUNT PROVIDER --------------->
<cfquery name="get_provider" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_provider
</cfquery>

<!------------------ GET ACCOUNT BY PROVIDER --------------->
<cfquery name="get_count_account_provider_all" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a WHERE type_id <> 4
</cfquery>

<cfloop query="get_provider">
<cfquery name="get_count_account_provider_#provider_id#" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(account_id) as nb 
FROM account a
WHERE a.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_provider.provider_id#">
</cfquery>

<cfquery name="get_ca_account_provider_#provider_id#" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(oi.item_inv_total) as ca
FROM orders o
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN account a ON o.account_id = a.account_id
INNER JOIN account_group ag ON ag.group_id = a.group_id
INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

<cfif view eq "reg">
	WHERE SUBSTRING(order_ref,1,2) = '#y#'
<cfelseif view eq "close">
	WHERE DATE_FORMAT(order_date,'%Y') = '20#y#'
</cfif>

AND o.order_status_id IN (3,4,5,10,11)

AND a.provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#">

</cfquery>

</cfloop>



<!------------------ GET ACCOUNT --------------->

<cfset get_account = obj_account_get.get_account(manager_id="#manager_id#",t_id="#t_id#",pv_id="#pv_id#",o_by="manager")>


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
	  			
			<cfset urlgo = "sales_account.cfm">
			<cfinclude template="./incl/incl_nav_sales.cfm">

			<div class="card border mb-3 p-2">
				<div class="card-body">

					<form action="sales_account.cfm" method="post">

						<table class="table table-sm">
							<tr>
								<td>BY MANAGER</td>
								<td>
									<label><span class="badge p-2 <cfif manager_id eq "all">bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px;"><input type="checkbox" name="manager_id" value="ALL" <cfif manager_id eq "all">checked</cfif>> ALL<br><cfoutput><div class="mt-1">#get_count_account_user_all.nb#</div></cfoutput></span></label>
									<cfloop query="get_manager">
									<cfoutput>
									<label><span class="badge p-2 <cfif listfind(manager_id,get_manager.user_id)>bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px;"><input type="checkbox" name="manager_id" value="#get_manager.user_id#" <cfif listfind(manager_id,get_manager.user_id)>checked</cfif>> #user_firstname#<br><div class="mt-1">#evaluate('get_count_account_user_#get_manager.user_id#.nb')#</div></span></label>
									</cfoutput>
									</cfloop>
								</td>
								<td><input type="submit" class="btn" value="GO"></td>
							</tr>	
							<tr>
								<td>BY TYPE</td>
								<td colspan="2">
									<label><span class="badge p-2 <cfif t_id eq "ALL">bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px"><input type="checkbox" autocomplete="off" name="t_id" value="ALL" <cfif t_id eq "ALL">checked</cfif>> ALL [<cfoutput>#get_count_account_type_all.nb#</cfoutput>]<br><div class="mt-1">&euro;</div></span></label>
									<cfloop query="get_account_type">
									<cfoutput>
									<label><span class="badge p-2 <cfif listfind(t_id,get_account_type.type_id)>bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px;"><input type="checkbox" autocomplete="off" name="t_id" value="#type_id#" <cfif listfind(t_id,get_account_type.type_id)>checked</cfif>> #type_name# [#evaluate('get_count_account_type_#type_id#.nb')#] <br><div class="mt-1"><cfif evaluate('get_ca_account_type_#type_id#.ca') neq "">#obj_number.get_space_number(evaluate('get_ca_account_type_#type_id#.ca'))#</cfif> &euro;</div></label>
									</cfoutput>
									</cfloop>
								</td>
							</tr>
							
							<tr>
								<td>BY PROVIDER</td>
								<td colspan="2">
									<label><span class="badge p-2 <cfif pv_id eq "ALL">bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px"><input type="checkbox" name="pv_id" value="ALL" <cfif pv_id eq "ALL">checked</cfif>> ALL [<cfoutput>#get_count_account_provider_all.nb#</cfoutput>]<br><div class="mt-1">&euro;</div></span></label>
									<cfloop query="get_provider">
									<cfoutput>
									<label><span class="badge p-2 <cfif listfind(pv_id, get_provider.provider_id)>bg-primary text-white<cfelse>bg-white text-dark border</cfif>" style="font-size:14px;"><input type="checkbox" name="pv_id" value="#provider_id#" <cfif listfind(pv_id, get_provider.provider_id)>checked</cfif>> <img src="./assets/img/training_#provider_code#.png" width="12"> #provider_name# [#evaluate('get_count_account_provider_#provider_id#.nb')#] <br><div class="mt-1">#obj_number.get_space_number(evaluate('get_ca_account_provider_#provider_id#.ca'))# &euro;</div></span></label>
									</cfoutput>
									</cfloop>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
				
			
			<div class="card border mb-3 p-2">
				<div class="card-header p-1">
			
					<div class="row">
						
						<div class="col-md-2">
						<h4 class="my-0">
						<cfif t_id eq "ALL">
						<label><span class="badge badge-pill text-white bg-primary"><i class="fad fa-city"></i> ALL
						<cfelse>
						<cfoutput>
						<label><span class="badge badge-pill text-white bg-#get_account.type_css#"><i class="fal fa-city"></i> #get_account.type_name#
						</cfoutput>
						</cfif>
						</h4>
						</div>
						
						<cfoutput>
						<cfloop list="ALL,1,2,3,4,5,10,11" index="cor">
						
						<cfquery name="get_ca_account" datasource="#SESSION.BDDSOURCE#">
						SELECT SUM(oi.item_inv_total) as ca, ag.group_id, ag.group_name, a.account_id, os.status_finance_name
						FROM orders o
						INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
						INNER JOIN account a ON o.account_id = a.account_id
						INNER JOIN account_group ag ON ag.group_id = a.group_id
						INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id

						<cfif view eq "reg">
							WHERE SUBSTRING(order_ref,1,2) = '#y#'
						<cfelseif view eq "close">
							WHERE DATE_FORMAT(order_date,'%Y') = '20#y#'
						</cfif>

						<cfif cor eq "ALL">
							AND o.order_status_id IN (3,4,5,10,11)
						<cfelse>
							AND o.order_status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
						</cfif>

						<cfif t_id neq "ALL">
							AND a.type_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#t_id#">)
						</cfif>

						<cfif manager_id neq "ALL">
							AND a.user_id IN (<cfqueryparam cfsqltype="cf_sql_integer" list="yes" value="#manager_id#">)
						</cfif>
						
						</cfquery>	
						
						<div class="col-md-1">
						<cfif cor eq "ALL">
						<small><strong>CA</strong></small>
						<cfif get_ca_account.ca neq ""><br><strong>#obj_number.get_space_number(get_ca_account.ca)# &euro;</strong><cfelse><br>-</cfif>
						<cfelse>
						<small>#get_ca_account.status_finance_name#</small>
						<cfif get_ca_account.ca neq ""><br>#obj_number.get_space_number(get_ca_account.ca)# &euro;<cfelse><br>-</cfif>
						</cfif>
						</div>
						
						</cfloop>
						</cfoutput>
						
						
						<div class="col-md-1">
						</div>
						
						<div class="col-md-1"></div>
						
					</div>
					
				</div>
			</div>

			<div class="card border mb-0 p-2">
				<table class="table">
					<tr class="bg-light">
						<th>Name</th>

					</tr>

				<cfoutput query="get_account" group="group_id">
					<tr bgcolor="##ECECEC">
						<td><a href="crm_account_edit.cfm?g_id=#group_id#">#group_name#</a></td>

						<!--- <cfloop from="#year(now())#" to="#dateformat(dateadd('yyyy',-1,now()),'yyyy')#" index="cor" step="-1"> --->
						<td colspan="3">
							<cfquery name="get_ca_group" datasource="#SESSION.BDDSOURCE#">
							SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.item_inv_total) as ca, ag.group_id, ag.group_name, a.account_id
							FROM orders o
							INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
							INNER JOIN account a ON o.account_id = a.account_id
							INNER JOIN account_group ag ON ag.group_id = a.group_id
							WHERE DATE_FORMAT(order_date,'%Y') = "#ysel#" AND ag.group_id = #group_id#
							GROUP BY group_id
							ORDER BY group_name
							</cfquery>
							<cfif get_ca_group.ca neq ""><br><strong>#obj_number.get_space_number(get_ca_group.ca)# &euro;</strong><cfelse><br>-</cfif>
						</td>
						<!--- </cfloop> --->
					</tr>
					<cfoutput>
						<tr>
							<td><img src="./assets/img/training_#provider_code#.png" width="25"> #account_id# #account_name#</td>
							<td width="10%"><span class="badge text-white" style="background-color:###account_manager_color#;">#account_manager#</span></td>
							<td width="10%"><span class="badge text-white bg-#type_css#">#type_name#</span></td>
						</tr>
					</cfoutput>

				</cfoutput>
				</table>

			</div>
			<!--- <div id="accordion">
				
				<cfoutput query="get_group_all" group="group_id">
				
				<div class="card border mb-0 p-2">
					<div class="card-header p-1">
				
						<div class="row">
							<div class="col-md-1">
								<span class="badge badge-pill text-white" style="background-color:###group_user_color#">#group_user_firstname#</span>
							</div>
							<!---<div class="col-md-1">
								<span class="badge badge-pill text-white badge-default bg-#color_icon#">#group_type#</span>
							</div>--->
							
							<div class="col-md-7" data-toggle="collapse" data-target="##g_#group_id#" aria-expanded="true" aria-controls="g_#group_id#">
								<i class="fad fa-city text-#group_type_css#"></i> <strong data-toggle="collapse" data-target=".g_#group_id#" style="cursor:pointer" class="text-#group_type_css#">#group_name# </strong>
							</div>
						
							
							<cfloop from="#year(now())#" to="#dateformat(dateadd('yyyy',-1,now()),'yyyy')#" index="cor" step="-1">
							
							<cfquery name="get_ca_group" datasource="#SESSION.BDDSOURCE#">
							SELECT DATE_FORMAT(order_date,'%m') as monthgo, SUM(oi.item_inv_total) as ca, ag.group_id, ag.group_name, a.account_id
							FROM orders o
							INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
							INNER JOIN account a ON o.account_id = a.account_id
							INNER JOIN account_group ag ON ag.group_id = a.group_id
							WHERE DATE_FORMAT(order_date,'%Y') = "#cor#" AND ag.group_id = #group_id#
							GROUP BY group_id
							ORDER BY group_name
							</cfquery>	
							
							<div class="col-md-1">
							<small>#cor#</small>
							<cfif get_ca_group.ca neq ""><br><strong>#obj_number.get_space_number(get_ca_group.ca)# &euro;</strong><cfelse><br>-</cfif>
							</div>
							</cfloop>
							
							
							<div class="col-md-1">
								<small>COMMENTS</small><br>
								
								<cfset get_todo = obj_task_get.oget_log(a_id="#account_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
								<cfset get_feedback = obj_task_get.oget_log(a_id="#account_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
							
								
								<cfif get_todo.recordcount neq "0">
								<button type="button" class="btn m-0 p-1 btn-warning btn-sm btn_view_log_group" id="glog_#group_id#">
								<i class="fal fa-edit"></i> #get_todo.recordcount#
								</button>
								</cfif>
								<button type="button" class="btn m-0 p-1 <cfif get_feedback.recordcount eq "0">btn-outline-info<cfelse>btn-info</cfif> btn-sm btn_view_log_group" id="glog_#group_id#">
								<i class="fal fa-book"></i> #get_feedback.recordcount#
								</button>
							</div>
							
							<div class="col-md-1">
								<small>REPORTS</small><br>
								<cfset m_1 = month(dateadd("m",-1,now()))>
								<cfset y_1 = year(dateadd("m",-1,now()))>
								<a class="m-0 btn btn-sm btn-info p-1" href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#y_1#_#m_1#">#listgetat(SESSION.LISTMONTHS_SHORT,m_1)# #mid(y_1,3,2)#</a>
								<!---
								<cfset m_0 = month(now())>
								<cfset y_0 = year(now())>
								<a class="m-0 btn btn-sm btn-outline-info p-1" href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#y_0#_#m_0#">#listgetat(SESSION.LISTMONTHS_SHORT,m_0)# #y_0#</a>
								--->
								<a class="m-0 btn btn-sm btn-info p-1" href="./cs_elearning.cfm?g_id=#group_id#">EL</a>
							</div>
							
						</div>
						
					</div>

					
					<div id="g_#group_id#" class="collapse card-header p-1" data-parent="##accordion">
					<cfoutput group="account_id">
					<div class="row mt-1">
						<div class="col-md-1">
							
						</div>
						<div class="col-md-5 bg-light">
							
							<!--- <i class="fal fa-building text-#group_type_css#"></i>  --->
							<span class="badge badge-pill text-white" style="background-color:###account_user_color#">#account_user_firstname#</span>
							
							<a href="crm_account_edit.cfm?a_id=#account_id#" class="text-#group_type_css#"><strong>#account_name#</strong></a><br>
						
						</div>
						
						<div class="col-md-2 bg-light">
							<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
							SELECT ac.* FROM account_contact ac 
							WHERE FIND_IN_SET(<cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,ac.account_id) 
							ORDER BY ac.contact_lead DESC, ac.contact_name ASC
							</cfquery>
							<cfif get_contact.recordcount neq "0">
							<table class="table table-sm table-borderless m-0">
								<cfloop query="get_contact">
								<cfquery name="get_user_attach" datasource="#SESSION.BDDSOURCE#">
								SELECT u.user_id, u.user_email, u.user_pwd
								FROM user u
								WHERE contact_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#contact_id#">
								</cfquery>
								<tr>
									<td>
									<cfif contact_active eq "1">
									<span class="btn_edit_ctc badge badge-pill text-white bg-success" style="cursor:pointer" id="c_#account_id#_#contact_id#"><i class="fal fa-user"></i> #contact_firstname# #contact_name#</span>			
									<cfelse>
									<span class="btn_edit_ctc badge badge-pill text-white  bg-dark" style="cursor:pointer" id="c_#account_id#_#contact_id#"><i class="fal fa-user"></i> #contact_firstname# #contact_name#</span>			
									</cfif>	
									</td>
									<td>
									<cfif get_user_attach.recordcount neq "0">
									<cfloop query="get_user_attach">
									<a class="btn btn-sm btn-info p-1" href="#SESSION.BO_ROOT_URL#/index.cfm?user_name=#get_user_attach.user_email#&user_password=#get_user_attach.user_pwd#" id="tm_#get_user_attach.user_id#">#mid(get_user_attach.profile_name,1,1)#</a>
									</cfloop>
									</cfif>
									
									</td>
								</tr>
								</cfloop>
							</table>
							</cfif>
						</div>
						
						<cfloop from="#year(now())#" to="#dateformat(dateadd('yyyy',-1,now()),'yyyy')#" index="cor" step="-1">
						<div class="col-md-1 bg-light">
						<!--- xxx &euro; --->
						</div>
						</cfloop>
						
						<div class="col-md-1">
							
							<cfset get_todo = obj_task_get.oget_log(a_id="#account_id#",category="TO DO",log_status="0",o_by="log_remind",profile_id="#SESSION.USER_PROFILE_ID#")>
							<cfset get_feedback = obj_task_get.oget_log(a_id="#account_id#",category="FEEDBACK",o_by="date_desc",profile_id="#SESSION.USER_PROFILE_ID#")>
							
							<cfif get_todo.recordcount neq "0">
							<button type="button" class="btn m-0 p-1 btn-warning btn-sm btn_view_log_account" id="alog_#account_id#">
							<i class="fal fa-edit"></i> #get_todo.recordcount#
							</button>
							</cfif>
							<button type="button" class="btn m-0 p-1 <cfif get_feedback.recordcount eq "0">btn-outline-info<cfelse>btn-info</cfif> btn-sm btn_view_log_account" id="alog_#account_id#">
							<i class="fal fa-book"></i> #get_feedback.recordcount#
							</button>
							
						</div>
						
						<div class="col-md-1">
							<cfset m_1 = month(dateadd("m",-1,now()))>
							<cfset y_1 = year(dateadd("m",-1,now()))>
							<a class="m-0 btn btn-sm btn-info p-1" href="./exporter/export_reporting_cs.cfm?a_id=#account_id#&tselect=#y_1#_#m_1#">#listgetat(SESSION.LISTMONTHS_SHORT,m_1)# #mid(y_1,3,2)#</a>
							<!---
							<cfset m_0 = month(now())>
							<cfset y_0 = year(now())>
							<a class="m-0 btn btn-sm btn-outline-info p-1" href="./exporter/export_reporting_cs.cfm?g_id=#group_id#&tselect=#y_0#_#m_0#">#listgetat(SESSION.LISTMONTHS_SHORT,m_0)# #y_0#</a>
							--->
							<a class="m-0 btn btn-sm btn-info p-1" href="./cs_elearning.cfm?a_id=#account_id#">EL</a>
						<cfif vtiger_id neq "">
						<a class="m-0 btn btn-sm btn-info" href="http://wefitcrm.redstratus.com/index.php?module=Accounts&view=Detail&record=#vtiger_id#" target="_blank"><img src="./assets/img/logo_vtiger.png" width="50"></a>
						</cfif>
						</div>
						
					</div>
					</cfoutput>
					</div>
					
				</div>
				
				
				</cfoutput>
					
			</div> --->
				
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {
	$('input[type="checkbox"]').change(function() {
        // Check if the value of the checkbox is "ALL"
        if ($(this).val() == "ALL") {
            // If the checkbox is checked
            if ($(this).is(':checked')) {
                // Uncheck all other checkboxes in the row
                $(this).closest('tr').find('input[type="checkbox"]').not(this).prop('checked', false);
            }
        } else {
            // If any other checkbox in the row is checked
            if ($(this).is(':checked')) {
                // Uncheck the "ALL" checkbox in the row
                $(this).closest('tr').find('input[type="checkbox"][value="ALL"]').prop('checked', false);
            }
        }
    });
	$('.btn_edit_ctc').click(function(event) {
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var a_id = idtemp[1];	
	var ctc_id = idtemp[2];	
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_title_lg').text("\u00c9diter contact");
	$('#modal_body_lg').load("modal_window_crm.cfm?ctc_edit=1&contact_id="+ctc_id+"&a_id="+a_id, function() {});
	});	
	
	
	
	/******************** VIEW LOG GROUP*****************************/	
	$('.btn_view_log_group').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var g_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Follow-Up");
		$('#modal_body_xl').load("modal_window_log.cfm?g_id="+g_id, function() {});
	});
	/******************** VIEW LOG GROUP*****************************/	
	$('.btn_view_log_account').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Follow-Up");
		$('#modal_body_xl').load("modal_window_log.cfm?a_id="+a_id, function() {});
	});
	
})


</script>

<script>

</script>

</body>
</html>