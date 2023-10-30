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

<cfparam name="view" default="reg">
<!--------------- DEFAULT DATE & VIEW  ------------->

<cfparam name="teaching_criteria_id" default="1,2,3,4">

<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
SELECT u.user_name, u.user_id, u.user_firstname,
t.tp_date_start, t.tp_date_end,
s.tp_status_name_fr,
c.certif_alias, c.certif_id, c.certif_name
FROM lms_tp t
INNER JOIN lms_tpstatus s ON t.tp_status_id = s.tp_status_id
INNER JOIN lms_formation f ON f.formation_id = t.formation_id
INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
INNER JOIN user u ON u.user_id = t.user_id
INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = 3
INNER JOIN lms_list_certification c ON c.certif_id = t.certif_id
WHERE t.method_id = 7 
AND t.tp_status_id IN (1,2,6,7,10)

ORDER BY t.certif_id
<!--- AND u.user_status_id IN (#user_status_cor#) AND a.provider_id IN (1,3)--->
<!---ORDER BY t.formation_id, t.tp_status_id, a.account_name, u.user_name, a.provider_id--->
</cfquery>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "DASHBOARD CERTIF">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">


			<div class="row">
                <cfoutput query="get_tp" group="certif_id">
				<div class="col-md-6">
					<div class="card border mb-3">

						<div class="card-body">
                            <a class="btn btn-primary" data-toggle="collapse" href="##div_go" role="button" aria-expanded="false">
								#certif_name#
							</a>

                            <table class="table">
                                <cfoutput>
                                    <tr>
                                        <td><a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a></td>
                                        <td>#tp_status_name_fr#</td>
                                        <td>#dateformat(tp_date_start,'dd/mm/yyyy')#</td>
                                        <td>#dateformat(tp_date_end,'dd/mm/yyyy')#</td>
                                    </tr>

                                </cfoutput>


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



</body>
</html>