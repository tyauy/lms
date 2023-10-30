<!DOCTYPE html>

<cfsilent>

<cfset secure = "1,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="msel" default="#month(now())#">


<cfif SESSION.LANG_CODE neq "fr">
    <cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
    <cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">



<cfquery name="get_hours_total" datasource="#SESSION.BDDSOURCE#">
    SELECT l.lesson_duration as lesson_duration, p.user_id as planner_id, p.user_firstname as planner_firstname, ap.provider_id, ap.provider_name, 
    uprice.pricing_amount, uprice.pricing_currency
    FROM lms_lesson2 l
    INNER JOIN lms_tpsession s ON s.session_id = l.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
    INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
    INNER JOIN orders o ON o.order_id = tp.order_id
    INNER JOIN user p ON p.user_id = l.planner_id
    INNER JOIN account a ON a.account_id = o.account_id
    INNER JOIN account_provider ap ON ap.provider_id = a.provider_id

    LEFT JOIN user_pricing uprice ON uprice.user_id = p.user_id 
    AND uprice.formation_id = tp.formation_id
    AND uprice.pricing_cat = sm.sessionmaster_cat_id
    AND uprice.pricing_method = l.method_id

    WHERE l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL
    
    AND ( l.status_id = 5 OR (l.status_id = 4 AND p.user_paid_missed = 1) )
    <!--- AND DATE_FORMAT(l.completed_date, "%Y") = '#ysel#' --->
    AND DATE_FORMAT(l.completed_date, "%Y-%m") =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">

    <!---  GROUP BY p.user_id, a.provider_id
    ORDER BY p.user_firstname, a.provider_id ASC --->
</cfquery>

<cfset tmp_obj = {}>
<cfset trainer_obj = {}>
<cfset count = 0>


<cfoutput query="get_hours_total">


    <cfif !StructKeyExists(tmp_obj,planner_firstname)>
        <cfset count++>

        <cfset tmp_obj[planner_firstname] = {
            'planner_firstname' = planner_firstname,
            'planner_id' = planner_id,
            '1' = 0,
            'm_1' = 0,
            '2' = 0,
            'm_2' = 0,
            '3' = 0,
            'm_3' = 0,
            'total' = 0,
            'm_total' = 0
        }>
    </cfif>
    <cfset tmp_obj[planner_firstname][provider_id] += lesson_duration>

    <cfset tmp_amount = pricing_amount neq "" ? pricing_amount : 0>
    <cfset tmp_obj[planner_firstname]["m_#provider_id#"] += (tmp_amount * (lesson_duration / 60))>

    <cfset tmp_obj[planner_firstname]['total'] += lesson_duration>
    <cfset tmp_obj[planner_firstname]['m_total'] += (tmp_amount * (lesson_duration / 60))>

</cfoutput>

<cfscript>

    trainer_obj=tmp_obj.ToSorted("text","asc",false);

</cfscript>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
tr:nth-child(even) {
  background-color: #f5f5f5;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formateurs WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

            <div class="row" style="margin-top:10px">

                <div class="col-md-6">
                    <div class="card border-top border-info" style="min-height:140px">						
                        <div class="card-body">
                            <h4 class="card-title">S&eacute;lection : <cfoutput>#mlongsel# #ysel#</cfoutput></h4>
                            <div class="row">
                                <div class="col-md-12 mt-4">
                                    <cfform action="cs_trainer_hours.cfm">
                                        <div class="form-row">

                                            <div class="col">
                                                <select class="form-control" id="msel" name="msel">

                                                    <cfloop from="1" to="12" index="m">
                                                        <cfoutput>
                                                            <cfif SESSION.LANG_CODE neq "fr">
                                                                <option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
                                                            <cfelse>
                                                                <option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
                                                            </cfif>


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

                                                <cfoutput><a href="cs_trainer_hours.cfm" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput>
                                            </div>

                                            <div class="col">
                                                <cfoutput>
                                                    <input type="submit" value="GO" class="btn btn-info">
                                                </cfoutput>
                                            </div>
                                        </div>
                                    </cfform>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--- <cfdump var="#get_hours_total#"> --->
            <!--- <cfdump var="#get_hours_total#">
            <cfdump var="#trainer_obj#"> --->
			<table class="table table-bordered bg-white">
                <tr>
                    <td>ID</td>
                    <td>Trainer</td>
                    <td colspan="2">WEFIT GROUP</td>
                    <td colspan="2">WEFIT DEUTSCHLAND</td>
                    <td colspan="2">WEFIT FRANCE</td>
                    <td colspan="2">TOTAL</td>
                </tr>

                <cfoutput>
                <cfif count gt 1>
					<cfloop collection="#trainer_obj#" item="ac_ca">
                        <!--- <cfdump var="#ac_ca#"> --->
						<tr>
                            <td>#trainer_obj[ac_ca].planner_id#</td>
							<td>#ac_ca#</td>
                            <td>#trainer_obj[ac_ca]["1"] /60# h</td>
							<td>#trainer_obj[ac_ca]["m_1"]# &euro;</td>
                            <td>#trainer_obj[ac_ca]["2"] /60# h</td>
							<td>#trainer_obj[ac_ca]["m_2"]# &euro;</td>
                            <td>#trainer_obj[ac_ca]["3"] /60# h</td>
                            <td>#trainer_obj[ac_ca]["m_3"]# &euro;</td>
                            
                            <td>#trainer_obj[ac_ca]["total"] /60# h</td>
                            <td>#trainer_obj[ac_ca]["m_total"]# &euro;</td>
						</tr>

					</cfloop>
				</cfif>
                </cfoutput>
            </table>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script type="text/javascript">
						

$(document).ready(function() {

	
});
</script>
						
</body>
</html>