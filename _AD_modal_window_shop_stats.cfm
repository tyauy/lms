<cfoutput>

	<cfif listGetAt(date_start, 1, '/') lt 13>
		<cfset sday = day(date_start)>
		<cfset smonth = month(date_start)>
		<cfset date_start_format = "#sday#/#smonth#/2021">
	<cfelse>
		<cfset date_start_format = #date_start#>
	</cfif>
	
	<cfif listGetAt(date_end, 1, '/') lt 13>
		<cfset sday = day(date_start)>
		<cfset smonth = month(date_end)>
		<cfset date_end_format = "#sday#/#smonth#/2021">
	<cfelse>
		<cfset date_end_format = #date_end#>
	</cfif>
	
</cfoutput>
			
<cfsilent>
<cfparam name="product" default="all">

<cfquery name="get_all_orders" datasource="#SESSION.BDDSOURCE#">
	SELECT o.order_id, o.order_ref, o.user_id, o.order_date,
	u.user_firstname, u.user_name,
	(SELECT COUNT(i.product_name) as product FROM order_item_invoice i WHERE i.order_item_invoice_id = it.order_item_invoice_id) as nb_items,
	(SELECT i.product_name as product FROM order_item_invoice i WHERE i.order_item_invoice_id = it.order_item_invoice_id) as item,
	(SELECT i.product_id as product_id FROM order_item_invoice i WHERE i.order_item_invoice_id = it.order_item_invoice_id) as item_id,
	inv.invoice_amount_ttc
	FROM orders o
	LEFT JOIN orders_users ou ON o.order_id = ou.order_id
	LEFT JOIN user u ON u.user_id = ou.user_id
	LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
	LEFT JOIN invoice inv ON inv.order_id = o.order_id
	WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767
	AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#dateformat(date_start_format,'yyyy-mm-dd')#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#dateformat(date_end_format,'yyyy-mm-dd')#'
	<cfif isdefined('cpn')>
	<cfif cpn eq 0>
	AND it.coupon_id IS NULL
	<cfelse>
	AND it.coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cpn#">
	</cfif>
	</cfif>
	<cfif product eq "all">
	HAVING nb_items > 0
	<cfelseif product eq 0>
	HAVING nb_items > 1
	<cfelse>
	HAVING nb_items = 1 AND item_id = #product#
	</cfif>
	order by o.order_id desc
</cfquery>
</cfsilent>



<table class="table table-bordered">
<tr>
	<th>ID</th>
	<th>ref</th>
	<th>Learner</th>
	<th>Date</th>
	<th>Product(s)</th>
	<th>Price</th>
	<th>link</th>
</tr>

<cfoutput query="get_all_orders">
<tr>
	<td>#order_id#</td>
	<td>#order_ref#</td>
	<td>#user_firstname# #user_name#</td>
	<td>#dateformat(order_date, 'dd/mm/yyyy')#</td>
	<td>#item#</td>
	<td>#invoice_amount_ttc# &euro;</td>
	<td><a class="btn btn-dark" id="#user_id#" href="#SESSION.BO_ROOT_URL#/common_learner_account.cfm?u_id=#user_id#">GO learner</a>
	<a class="btn btn-dark btn_see_order" id="#order_id#">GO order</a></td>
</tr>
</cfoutput>
</table>



<script>
$(document).ready(function() {


$('.btn_see_order').click(function(event) {		
	event.preventDefault();
	
	var oid = $(this).attr("id");
		
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_title_lg').text("Order "+oid);
	$('#modal_body_lg').load("_AD_modal_window_shop_stats.cfm?oid="+oid);
});

});
</script>





