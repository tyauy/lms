<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
    SELECT t.tp_id, u.user_id, u.user_name, u.account_id FROM lms_tp t
    INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND t.method_id = 7 AND t.tp_status_id = 1 AND (t.certif_id = 22 OR t.certif_id = 23)
    INNER JOIN user u ON u.user_id = tpu.user_id
    INNER JOIN orders_users ou ON ou.user_id = u.user_id 
    INNER JOIN orders o ON ou.order_id = o.order_id AND o.order_status_id = 11
    GROUP BY u.user_id 
    LIMIT 200
</cfquery>


<cfoutput query="get_tp">
    <a href="../common_learner_account.cfm?u_id=#user_id#">#user_name# account_id = #account_id#</a><br>
    UPDATE lms_tp SET tp_status_id = 3 where tp_id = #tp_id#
    <br><br>

    <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tp SET tp_status_id = 3 where tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
    </cfquery>
    
</cfoutput>