<!DOCTYPE html>

<cfsilent>
	<!--- <cfquery name="get_all_orders" datasource="#SESSION.BDDSOURCE#">
		SELECT o.order_id, o.order_ref, o.user_id, o.order_date,
		u.user_id, u.user_firstname, u.user_name,
		-- (SELECT COUNT(i.product_name) as product FROM order_item i WHERE i.order_item_id = it.order_item_id) as nb_items,
		-- (SELECT i.product_name as product FROM order_item i WHERE i.order_item_id = it.order_item_id) as item,
		-- (SELECT i.product_id as product_id FROM order_item i WHERE i.order_item_id = it.order_item_id) as item_id,
		inv.invoice_amount_ttc
		FROM orders o
		LEFT JOIN orders_users ou ON o.order_id = ou.order_id
		LEFT JOIN user u ON u.user_id = ou.user_id
		LEFT JOIN order_item it ON it.order_id = o.order_id
		LEFT JOIN invoice inv ON inv.order_id = o.order_id
		WHERE o.user_id != 7521 AND o.user_id != 7767
		-- HAVING nb_items > 0
		order by o.order_id desc
	</cfquery> --->
	
	<cfquery name="get_products" datasource="#SESSION.BDDSOURCE#">
		SELECT product_name, product_id, category_id, method_id FROM product
	</cfquery>
	
	<cfparam name="date_start" default="#dateFormat(dateadd("m",-1,now()), 'yyyy-mm-dd')#">
	<cfparam name="date_end" default="#dateFormat(now(), 'yyyy-mm-dd')#">
	<cfparam name="deltadate" default="this_month">
	<cfparam name="display" default="date_desc">
	<cfparam name="prdt_id" default="all">

	<!---- DATE PERIOD ---->
	<cfif deltadate eq "all">
		<cfset date_start = "2021-01-01">
		<cfset date_end = "#dateFormat(now(), 'yyyy-mm-dd')#">
	<cfelseif deltadate eq "this_month">
		<cfset cur_month = listgetat(SESSION.LISTMONTHS_CODE,month(now()))>
		<cfset cur_year = year(now())>
		<cfset date_start = "#cur_year#-#cur_month#-01">
		<cfset date_end = "#cur_year#-#cur_month#-#daysInMonth(date_start)#">
	<cfelseif deltadate eq "last_month">
		<cfset cur_month = dateformat(dateadd("m",-1,now()),"mm")>		
		<cfset cur_year = dateformat(dateadd("m",-1,now()),"yyyy")>		
		<cfset date_start = "#cur_year#-#cur_month#-01">
		<cfset date_end = "#cur_year#-#cur_month#-#daysInMonth(date_start)#">				
	<cfelseif deltadate eq "last_7_days">
		<cfset date_start = #dateFormat(dateAdd('d', -7, now()), 'yyyy-mm-dd')#>
		<cfset date_end = #dateFormat(now(), 'yyyy-mm-dd')#>
	</cfif>

	<cfquery name="get_shop_orders" datasource="#SESSION.BDDSOURCE#">
		SELECT o.order_id, o.order_ref, o.user_id, o.order_date, osf.status_finance_name, cpn.coupon_code,
		u.user_firstname, u.user_name, u.user_id as uid,
		<!--- (SELECT COUNT(i.product_name) as product FROM order_item i WHERE i.order_item_id = it.order_item_id) as nb_items, --->
		(SELECT i.product_name as product FROM order_item_invoice i WHERE i.order_item_invoice_id  = it.order_item_invoice_id ) as item,
		<!--- (SELECT i.product_id as product_id FROM order_item i WHERE i.order_item_id = it.order_item_id) as item_id, --->
		inv.invoice_amount_ttc
		FROM orders o
		LEFT JOIN orders_users ou ON o.order_id = ou.order_id
		LEFT JOIN user u ON u.user_id = ou.user_id
		LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
		LEFT JOIN invoice inv ON inv.order_id = o.order_id
		LEFT JOIN order_status_finance osf ON osf.status_finance_id = o.order_status_id
		LEFT JOIN product_coupon cpn ON cpn.coupon_id = it.coupon_id
		WHERE o.user_id != 7521 AND o.user_id != 7767
		AND o.order_status_id <> 2
		AND o.order_ref like '%_W%'
		AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end#'
		<cfif isdefined('cpn')>
			<cfif cpn eq 0>
			AND it.coupon_id IS NULL
			<cfelse>
			AND it.coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cpn#">
			</cfif>
		</cfif>
		<!---<cfif prdt_id eq "all">
			HAVING nb_items > 0
		<cfelseif prdt_id eq 0>
			HAVING nb_items > 1
		<cfelse>
			HAVING nb_items = 1 AND item_id = #prdt_id#
		</cfif>--->

		<cfif display eq "date_desc">
		order by o.order_date desc
		<cfelseif display eq "date">
		order by o.order_date
		<cfelseif display eq "learner">
		order by u.user_name
		<cfelse>
		order by o.order_id
		</cfif>

	</cfquery>

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
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "SHOP orders">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="row p-3 bg-light">
				<cfoutput>
				<div class="col-md-3">
					<select class="form-control" onChange="document.location.href='shop_orders.cfm?date_start=#date_start#&date_end=#date_end#&prdt_id=#prdt_id#&display='+$(this).val()">
						<option value="date_desc" <cfif display eq "date_desc">selected</cfif>>ORDER BY : date</option>
						<option value="date" <cfif display eq "date">selected</cfif>>ORDER BY : date desc</option>
						<option value="learner" <cfif display eq "learner">selected</cfif>>ORDER BY : user name</option>
					</select>
				</div>
				</cfoutput>

				<div class="col-md-3">
					<select class="form-control" <cfoutput>onChange="document.location.href='shop_orders.cfm?date_start=#date_start#&date_end=#date_end#&display=#display#&prdt_id='+$(this).val()"</cfoutput>>
						<option value="all" <cfif prdt_id eq "all">selected</cfif>>ALL PRODUCT</option>
						<cfoutput query="get_products">
						<option value="#product_id#" <cfif prdt_id eq product_id>selected</cfif>>#product_name#</option>
						</cfoutput>
					</select>
				</div>

			
				<div class="col-md-6">
				
					<div id="accordion_period">	
						<div class="row">
							<div class="col-5 p-0">
							<cfoutput>
								<select class="form-control" onChange="document.location.href='shop_orders.cfm?display=#display#&date_start=#date_start#&date_end=#date_end#&prdt_id=#prdt_id#&deltadate='+$(this).val()">
									<option value="last_7_days" <cfif deltadate eq "last_7_days">selected</cfif>>last_7_days</option>
									<option value="this_month" <cfif deltadate eq "this_month">selected</cfif>>this_month</option>
									<option value="last_month" <cfif deltadate eq "last_month">selected</cfif>>last_month</option>
									<option value="all" <cfif deltadate eq "all">selected</cfif>>all</option>
								</select>
							</cfoutput>
							</div>
						</div>

					</div>
				</div>
			</div>

			<div class="row">

				<div class="col-12">
					
					<table class="table table-sm">
						<tbody>
							<tr class="bg-light">
								<th>ORDER REF</th>
								<th>DB REF</th>
								<th>ORDER STATUS</th>
								<th>CLIENT</th>
								<th>DATE</th>
								<th>PRODUCT</th>
								<th>COUPON</th>
								<th>PRICE</th>
								<th>GO TO ORDER</th>
							</tr>
							<cfoutput query="get_shop_orders">
								<tr>
									<td>#order_ref#</td>
									<td>#order_id#</td>
									<td>#status_finance_name#</td>
									<td><a href="common_learner_account.cfm?u_id=#uid#">#user_firstname# #user_name#</a></td>
									<td>#dateformat(order_date, "dd/mm/yyyy")#</td>
									<td>#item#</td>
									<td align="center"><cfif coupon_code eq ""> - </cfif>#coupon_code#</td>
									<td>#invoice_amount_ttc# &euro;</td>
									<td><button type="button" class="btn btn-dark btn_order_details" id="o_#order_id#">GO order</button></td>

								</tr>
							</cfoutput>

						</tbody>
					</table>

				</div>
				
			</div>		
	</div>
	
	<cfinclude template="./incl/incl_footer.cfm">

</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	$('.btn_order_details').click(function(event) {		
		event.preventDefault();
		
		var id_temp = $(this).attr("id");
		
		var tmp = id_temp.split("_");
		var o_id = tmp[1];
		
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Order "+id_temp);
		$('#modal_body_xl').load("modal_window_order_create.cfm?quick_change=1&o_id="+o_id);

	});

	$('.btn_sel_date').click(function(event) {
		var date_from = $(date_schedule_from).val();
		var date_to = $(date_schedule_to).val();

		<cfoutput>
		document.location.href="shop_orders.cfm?prdt_id=#prdt_id#&display=#display#&date_start="+date_from+"&date_end="+date_to;
		</cfoutput>
	});

	$("#date_schedule_from").datepicker({
		firstDay: 1,
		defaultDate: "+1w",
		changeMonth: true,
		numberOfMonths: 3,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
		$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
		}
	});

	$("#date_schedule_to").datepicker({
		firstDay: 1,
		defaultDate: "+1w",
		changeMonth: true,
		numberOfMonths: 3,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
		$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
		}
	});


// $.typeahead({
//     input: '.js_typeahead_shop',
//     order: "desc",
// 	minLength: 1,
//     maxItem: 15,
// 	emptyTemplate: 'Pas de resultats pour "{{query}}"',


// 	source: {
		

// 		Learners: {
// 			display:"learner_name",
// 			href:"https://lms.wefitgroup.com/_AD_modal_window_shop_stats.cfm?oid={{order_id}}",
// 			data: [
// 				<!---<cfoutput query="get_all_orders" group="user_id">{"user_id": #user_id#, "order_id": #order_id#, "learner_name": "#user_firstname# #user_name#  <em>°#order_ref#°</em>"},</cfoutput>--->			
// 			]
// 		},

//     }
// });


});
</script>

</body>
</html>











<cfabort>







<!DOCTYPE html>


<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.main-panel>.content {
    padding: 0 30px 30px;
    min-height: calc(100vh - 123px);
    margin-top: 10px;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
		
		<cfset title_page = "Shop orders">
	
		<cfinclude template="./incl/incl_nav.cfm">

		
		<div class="content">
				
			
			
		</div>	</div>
		</div>

	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">


<script>

</script>


</body>
</html>




				<!---<div class="row p-3 bg-light">
					<div class="col-md-8"></div>
				
					<div class="col-md-4">
						
						<!--- searchfield by learner or order-ref/id --->
						<form id="form-global_shop" name="shop_search">
							<div class="typeahead__container">
								<div class="typeahead__field">
									<div class="typeahead__query">
										<input id="js_typeahead_shop_input" class="js_typeahead_shop" <!---name="country_v1[query]"---> type="search" placeholder="Search" autocomplete="off">
									</div>
									<div class="typeahead__button">
										<button type="submit">
											<i class="typeahead__search-icon"></i>
										</button>
									</div>
								</div>
							</div>
						</form>						
						
					</div>
				</div>--->
			
<!--- <div class="row">
								<div class="col-12">
									<div id="period" class="collapse hide" data-parent="#accordion_period">
										<cfform>
										<div class="row">
											<cfoutput>
											<div class="col-md-5">										
												<div class="control-group">
													<label for="date_schedule_from" class="control-label">#obj_translater.get_translate('short_between')#</label>
													<div class="controls">
														<div class="input-group">
															<cfset from_dateformat = '01/03/2021'>
															<cfset to_dateformat = "#dateformat(now(),'dd/mm/yyyy')#">
															
															<input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" value="#date_start#"/>
															<label for="date_schedule_from" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-5">
												<div class="control-group">
													<label for="date_schedule_to" class="control-label">#obj_translater.get_translate('short_and')#</label>
													<div class="controls">
														<div class="input-group">
															<input id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" autocomplete="off" value="#date_end#" />
															<label for="date_schedule_to" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
														</div>
													</div>
												</div>
											</div>
											<div class="col-md-2">
												<br>
												<button type="button" class="btn btn-info btn_sel_date">GO</button>
											</div>
											</cfoutput>
										</div>
										</cfform>
									</div>
								</div>
								
							</div> --->

							<!---
						<div class="col-7 p-0">
						<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#period" aria-expanded="true" aria-controls="period">Select Period</button>
						<cfif period_spe eq 1><cfoutput><em>(#date_start# - #date_end#)</em></cfoutput></cfif>
					</div>
					--->