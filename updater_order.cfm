

<cfif isDefined("_invoice_form")>
<!--- <cfdump var="#form#"> --->
	<cfinvoke component="api/orders/orders_post" method="insert_invoice" argumentcollection="#form#" returnvariable="cur_invoice_id"></cfinvoke>

	<cflocation addtoken="no" url="finance_invoice_view.cfm?a_id=#a_id#&i_id=#cur_invoice_id#&user_lang=#invoice_lang#">

	<!--- <cflocation addtoken="no" url="common_orders.cfm?k=1"> --->
<cfelseif isDefined("updt_order_status")>

	<cfinvoke component="api/orders/orders_post" method="insert_order" returnVariable="order_new_id">
		<cfinvokeargument name="order_id" value="#o_id#">
		<cfinvokeargument name="account_id" value="#a_id#">
		<cfinvokeargument name="order_status_id" value="#order_status_id#">
	</cfinvoke>

	<!--- <cflocation addtoken="no" url="shop_orders.cfm"> --->
	<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
	
<cfelse>
	<!--- <cfdump var="#form#"> --->

	<cfinvoke component="api/orders/orders_post" method="order_form" argumentcollection="#form#"></cfinvoke>

	<!--- <cflocation addtoken="no" url="common_orders.cfm"> --->
	<cflocation addtoken="no" url="#CGI.HTTP_REFERER#">
	
</cfif>