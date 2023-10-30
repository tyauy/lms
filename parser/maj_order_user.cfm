<cfabort>
<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT order_id, user_id FROM orders
</cfquery>



<cfloop query="get_order">
	<cftry>
    <cfif user_id neq "">

    
    <cfquery name="insert_order_user" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO `orders_users`(`order_id`, `user_id`) 
		VALUES (
			<cfqueryparam cfsqltype="cf_sql_integer" value="#order_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
			)
	</cfquery>

</cfif>

<cfcatch type="any"></cfcatch>
</cftry>
</cfloop>
