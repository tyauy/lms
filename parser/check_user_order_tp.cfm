
<cfquery name="get_order_id" datasource="#SESSION.BDDSOURCE#">
SELECT t.order_id, tpu.user_id, t.tp_id FROM lms_tp t 
INNER JOIN lms_tpuser tpu ON t.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
INNER JOIN user u ON u.user_id = tpu.user_id
ORDER BY tpu.user_id ASC 
</cfquery>

<cfoutput query="get_order_id" group="user_id">
    <div id="#user_id#" style="display: none;">

    

    USER: <a href="../common_learner_account.cfm?u_id=#get_order_id.user_id#">#get_order_id.user_id#</a></br>

    <cfquery name="check_order" datasource="#SESSION.BDDSOURCE#">
        SELECT order_id FROM orders_users WHERE user_id = #user_id#
    </cfquery>
          
    <cfset user_orders = ValueArray(check_order, "order_id")>


    USER ORDER :
    <cfloop array="#user_orders#" index="cor">
        #cor#, 
    </cfloop>
    </br>

    
    <cfoutput>

    <cfif arrayFind(user_orders, get_order_id.order_id) eq 0>
        <span style="color:##FF0000"> TP #tp_id# ORDER  >> #get_order_id.order_id# </span><br>
        
        <script type="text/javascript">
        console.log("hello");
            document.getElementById(#user_id#).style.display = 'block';
        </script>
        
    <cfelse>
        TP #tp_id# ORDER  >> #get_order_id.order_id# <br>
        
    </cfif>
    </cfoutput>
    <br>-----<br>
</div>
</cfoutput>

