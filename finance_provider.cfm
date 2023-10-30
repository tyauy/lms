<!DOCTYPE html>
<cfsilent>
	
	<cfparam name="display" default="#year(now())#">
	<cfparam name="msel" default="#listgetat(SESSION.LISTMONTHS_CODE,month(now()))#">
	<cfparam name="ysel" default="#year(now())#">

<cfquery name="get_tp_certif" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(*) as nb, a.provider_id, ap.provider_name, lc.certif_name
FROM lms_tp t
INNER JOIN lms_lesson_method lm ON lm.method_id = t.method_id
INNER JOIN orders o ON o.order_id = t.order_id
INNER JOIN account a ON a.account_id = o.account_id
INNER JOIN account_provider ap ON ap.provider_id = a.provider_id
INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
WHERE t.method_id = 7
AND DATE_FORMAT(o.order_date,'%Y-%m') = '#ysel#-#msel#'
AND o.order_status_id NOT IN (1,2,6,8,9)
GROUP BY a.provider_id, t.certif_id
</cfquery>

<cfquery name="get_tp_el" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(*) as nb, a.provider_id, ap.provider_name, le.elearning_name, elearning_duration
FROM lms_tp t
INNER JOIN lms_lesson_method lm ON lm.method_id = t.method_id
INNER JOIN orders o ON o.order_id = t.order_id
INNER JOIN account a ON a.account_id = o.account_id
INNER JOIN account_provider ap ON ap.provider_id = a.provider_id
INNER JOIN lms_list_elearning le ON le.elearning_id = t.elearning_id
WHERE t.method_id = 3
AND DATE_FORMAT(o.order_date,'%Y-%m') = '#ysel#-#msel#'
AND o.order_status_id NOT IN (1,2,6,8,9)
GROUP BY a.provider_id, t.elearning_id, t.elearning_duration
</cfquery>


</cfsilent>
<html lang="fr">

<head>
	<cfset view = "screenshot">
	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "Stats">
			<cfinclude template="./incl/incl_nav.cfm">

	
			<div class="content">

                <form action="finance_provider.cfm" action="post">
                <div class="row">
                    <div class="col">
                        <select class="form-control" id="msel" name="msel">
                            <cfloop list="#SESSION.LISTMONTHS_CODE#" index="m">
                                <cfoutput>

                                    <option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS_SHORT,m)#</option>
                                    
                                </cfoutput>
                            </cfloop>
                        </select>
                    </div>

                    <div class="col">

                        <select class="form-control" name="ysel">
                            <cfloop from="2019" to="#year(now())#" index="y">
                                <cfoutput>
                                    <option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
                                </cfoutput>
                            </cfloop>
                        </select>

                        <input type="submit" value="GO">
                    </div>
                    
                </div>
                </form>
                    

                <div class="row">
                    <div class="col-md-12">

                        <h5>Certifications</h5>
                        
                    </div>
                </div>
                
                <div class="row">
                <cfoutput query="get_tp_certif" group="provider_id">
                    <div class="col">
                    <table class="table table-sm bg-white">
                        <tr class="bg-light">
                            <td colspan="2"><strong>#provider_name#</strong></td>
                        </tr>
                        <cfoutput>
                            <tr>
                                <td>#certif_name#</td>
                                <td>#nb#</td>
                            </tr>

                        </cfoutput>
        
                    </table>
                    </div>
                    
                </cfoutput>
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <h5>eLearning</h5>
                        
                    </div>
                </div>
                <div class="row">
                    <cfoutput query="get_tp_el" group="provider_id">
                        <div class="col">
                        <table class="table table-sm bg-white">
                            <tr class="bg-light">
                                <td colspan="2"><strong>#provider_name#</strong></td>
                            </tr>
                            <cfoutput>
                                <tr>
                                    <td>#elearning_name# <cfif elearning_duration gte 30>#elearning_duration/30# m<cfelse>#elearning_duration# j</cfif></td>
                                    <td>#nb#</td>
                                </tr>

                            </cfoutput>
            
                        </table>
                        </div>
                        
                    </cfoutput>
                </div>
            </div>
               
    <cfinclude template="./incl/incl_footer.cfm">

</div>


<cfinclude template="./incl/incl_scripts.cfm">


</body>
</html>












