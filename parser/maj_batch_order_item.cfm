<cfabort>

<cfquery name="get_order_b2c" datasource="#SESSION.BDDSOURCE#">
SELECT o.order_id, oi.*, ou.* FROM orders o 
INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
INNER JOIN orders_users ou ON ou.order_id = o.order_id
WHERE account_id = 346
</cfquery>

<cfoutput query="get_order_b2c">

#order_id# // #item_inv_total# // #order_item_invoice_id# #order_item_mode_id# // #user_id#<br>
<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
update order_item_invoice SET order_item_mode_id = 5 where order_item_invoice_id = #order_item_invoice_id#
</cfquery>
</cfoutput>