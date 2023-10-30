<!------------------------ MAJ ----------------->
<cfif isdefined("new_id") AND new_id neq "">
<cfoutput>
 MAJ #new_id# </cfoutput>
 

 <cfset order_start = dateformat(order_start,'yyyy-mm-dd')>
<cfset order_end = dateformat(order_end,'yyyy-mm-dd')>

 <cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_status_finance WHERE status_finance_name = '#order_status#'
</cfquery>


 
 	<cfquery name="insert_order" datasource="#SESSION.BDDSOURCE#">
	UPDATE orders SET 
	order_status_id = #get_status_finance.status_finance_id#,
	<cfif order_start neq "">order_start = '#order_start#',</cfif>
	<cfif order_end neq "">order_end = '#order_end#',</cfif>
	order_ref2 = '#order_ref#'
	WHERE order_id = #new_id#
	</cfquery>
	
</cfif>