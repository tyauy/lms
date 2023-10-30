<cfabort>

<cfquery name="get_order_id" datasource="#SESSION.BDDSOURCE#">
    SELECT t.order_id, tpu.user_id, t.tp_id FROM lms_tp t 
    INNER JOIN lms_tpuser tpu ON t.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
    INNER JOIN user u ON u.user_id = tpu.user_id
    WHERE t.order_id = 2
    GROUP BY tpu.user_id
</cfquery>


<cfoutput query="get_order_id" >
    #get_order_id.user_id#

    <cftry>
    <!--- <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
        
        INSERT INTO `orders_users`(`order_id`, `user_id`) VALUES (
            1,
            #get_order_id.user_id#
            )
    </cfquery> --->
    <cfcatch type="any"></cfcatch>
    </cftry>
</cfoutput>

<!--- UPDATE orders_users SET order_id = 2 WHERE user_id = #get_order_id.user_id# AND order_id = 1 --->