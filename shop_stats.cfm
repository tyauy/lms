<!DOCTYPE html>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "Shop stats">
			<cfinclude template="./incl/incl_nav.cfm">
	
			<cfif not isdefined("date_start") AND not isdefined("date_end")>
			
				<cfset date_start ="02/01/#year(now())-1#">
				<cfset date_end = "#dateformat(now(),'dd/mm/yyyy')#">
				<!--- <cfoutput>date_end - #date_end#</cfoutput> --->
				<cfset date_start_format = "#year(now())-1#-01-01">
				<cfset date_end_format = dateformat(now(),'yyyy-mm-dd')>
				
				
				<!--- <cfoutput> --->
				<!--- date_start_format --- #date_start_format#<br> --->
				<!--- date_end_format --- #date_end_format# // #dateformat(date_end_format,'yyyy-mm-dd')#<br><br><br> --->
				<!--- </cfoutput> --->
				
				
				<cfset period_spe = 0>
			
			<cfelse>
				
				
				
				<cfset period_spe = 1>
				
				<cfif listGetAt(date_start, 1, '/') lte 12>
					<cfset sday = listGetAt(date_start, 1, '/')>
					<cfset smonth = listGetAt(date_start, 2, '/')>
					<cfset syear = listGetAt(date_start, 3, '/')>
					<cfset date_start = "#sday#/#smonth#/#syear#">
					<cfset date_start_format = dateformat(date_start,'yyyy-mm-dd')>
				<cfelse>
					<cfset date_start_format = dateformat(date_start,'yyyy-mm-dd')>
				</cfif>
				
				<cfif listGetAt(date_end, 1, '/') lte 12>
				
					<cfset sday = listGetAt(date_end, 1, '/')>
					<cfset smonth = listGetAt(date_end, 2, '/')>
					<cfset syear = listGetAt(date_end, 3, '/')>
					<cfset date_end = "#sday#/#smonth#/#syear#">
					<cfset date_end_format = dateformat(date_end,'yyyy-mm-dd')>
					
				<cfelse>
					<cfset date_end_format = dateformat(date_end,'yyyy-mm-dd')>
				</cfif>
				
				
			</cfif>
			
			
			
				
			<cfquery name="get_all_orders" datasource="#SESSION.BDDSOURCE#">
				SELECT o.order_id, o.order_ref,
				u.user_id, u.user_firstname, u.user_name
				FROM orders o
				LEFT JOIN orders_users ou ON o.order_id = ou.order_id
				LEFT JOIN user u ON u.user_id = ou.user_id
				INNER JOIN order_item_invoice it ON it.order_id = o.order_id
				WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				order by o.order_id desc
			</cfquery>
			
			<!--- <cfdump var="#get_all_orders#"> --->
			<!--- order_item --->
			
			<cfsilent>
			<cfloop list="1,2,3,8,9" index="cur_prdt">
			<cfquery name="get_#cur_prdt#_orders" datasource="#SESSION.BDDSOURCE#">
				SELECT it.product_name, it.product_id, it.item_inv_total,
                ivar.attribute_id, ivar.variation_id, COUNT(ivar.variation_id) as nb_var_uses, 
				var.variation_name_fr, atr.attribute_name
				FROM orders o
				LEFT JOIN orders_users ou ON o.order_id = ou.order_id
				LEFT JOIN user u ON u.user_id = ou.user_id
				LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
				LEFT JOIN order_item_var ivar ON ivar.order_item_id = it.order_item_invoice_id
				LEFT JOIN product_variation var ON var.variation_id = ivar.variation_id
				LEFT JOIN product_attribute atr ON atr.attribute_id = ivar.attribute_id
				WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767 AND it.product_id = #cur_prdt#
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				GROUP BY ivar.variation_id
				ORDER BY ivar.attribute_id, ivar.variation_id
			</cfquery>
			</cfloop>
			
			<cfloop list="1,8,9" index="cur_product">
				<cfquery name="get_coupon_repart_#cur_product#" datasource="#SESSION.BDDSOURCE#">
				SELECT it.product_name, it.product_id, COUNT(it.product_id) AS cpn_uses, cpn.coupon_id, cpn.coupon_code, 
				(SELECT COUNT(oo.order_id) as nb_tt FROM orders oo LEFT JOIN order_item_invoice iit ON iit.order_id = oo.order_id WHERE oo.order_status_id = 11 AND oo.user_id != 7521 AND oo.user_id != 7767 AND iit.product_id = #cur_product#) as nb_total
				FROM orders o
				LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
				LEFT JOIN product_coupon cpn ON cpn.coupon_id = it.coupon_id
				WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767 AND it.product_id = #cur_product#
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				GROUP BY it.coupon_id
				ORDER BY it.coupon_id
				</cfquery>
			</cfloop>
			
			<cfquery name="get_total_price" datasource="#SESSION.BDDSOURCE#">
				SELECT SUM(inv.invoice_amount_ttc) as total_ttc,
				(SELECT COUNT(i.product_name) as product FROM order_item_invoice i WHERE i.order_id = o.order_id) as nb_items
				FROM orders o
				LEFT JOIN invoice inv ON inv.order_id = o.order_id
				WHERE o.order_status_id = 11
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				HAVING nb_items > 0
			</cfquery>
			
			<cfquery name="get_orders_repart" datasource="#SESSION.BDDSOURCE#">
				SELECT
				(SELECT COUNT(i.product_name) as product FROM order_item_invoice i WHERE i.order_item_invoice_id = it.order_item_invoice_id) as nb_items,
				it.product_name, COUNT(it.product_id) as nb_product, it.product_id,
				SUM(inv.invoice_amount_ttc) as price
				FROM orders o
				LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
				LEFT JOIN invoice inv ON inv.order_id = o.order_id
				WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				GROUP BY it.product_id
				HAVING nb_items = 1
				UNION
				SELECT
				(SELECT COUNT(i.product_name) as product FROM order_item_invoice i WHERE i.order_item_invoice_id = it.order_item_invoice_id) as nb_items,
				"multiple" as product_name, COUNT(it.product_id) as nb_product, 0 as product_id,
				SUM(inv.invoice_amount_ttc) as price
				FROM orders o
				LEFT JOIN order_item_invoice it ON it.order_id = o.order_id
				LEFT JOIN invoice inv ON inv.order_id = o.order_id
				WHERE o.order_status_id = 11 AND o.user_id != 7521 AND o.user_id != 7767
				AND DATE_FORMAT(o.order_date, "%Y-%m-%d") >= '#date_start_format#' AND DATE_FORMAT(o.order_date, "%Y-%m-%d") <= '#date_end_format#'
				GROUP BY it.product_id
				HAVING nb_items > 1
			</cfquery>
			
			<!--- % de commandes avec coupon ... --->
			
			</cfsilent>
			
			
			<div class="container-fluid" style="margin-top:70px;">
				<!--- DATE selection & order/learner SEARCH --->
				<div class="row p-3" style="background-color: rgba(150,150,150,0.35);">
					<div class="col-md-8">
					
						<div id="accordion_period">
							<button type="button" class="btn btn-info btn_no_date <cfif period_spe eq 0>active</cfif>">ALL</button>
							<button type="button" class="btn btn-info <cfif period_spe eq 1>active</cfif>" data-toggle="collapse" data-target="#period" aria-expanded="true" aria-controls="period">Select Period</button>
							<cfoutput><em>(#date_start# - #date_end#)</em></cfoutput>
						
							<div id="period" class="collapse hide" data-parent="#accordion_period">
								<cfform>
								<div class="row">
									<cfoutput>
									<div class="col-md-5">										
										<div class="control-group">
											<label for="date_schedule_from" class="control-label">#obj_translater.get_translate('short_between')#</label>
											<div class="controls">
												<div class="input-group">
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
					
					</div>
					
					<div class="col-md-4">
					
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

				</div>
			</div>	
				
				
			<div class="content">	
			
				<!--- OVERVIEW --->
				<h4 style="color:black">OVERVIEW</h4>
				<div class="row" style="margin-top:10px;">
					<div class="col-md-6">

					<table class="table table-bordered m-3" rules="all">
					<cfoutput query="get_orders_repart">
						<tr>
							<td>#product_name#</td>
							<td width="10%">#nb_product#</td>
							<td width="20%">#price# &euro;</td>
							<td width="35px"><button type="button" class="btn btn-dark btn_repart_ord" id="#product_id#_#product_name#">details</button></td>
						</tr>
					</cfoutput>
					</table>
					
					<table class="table table-bordered m-3" rules="all">
					<cfoutput>
					<cfset nb_orders = #get_all_orders.recordcount()#>
						<tr>
							<td>TOTAL</td>
							<td width="10%">#nb_orders#</td>
							<td width="20%">#get_total_price.total_ttc# &euro;</td>
							<td width="35px"><button type="button" class="btn btn-dark btn_all_ord">details</button></td>
						</tr>
					</cfoutput>
					</table>
					
					</div>
					<div class="col-md-6">
						<div width="100%" class="mb-5"><canvas id="order_repart"></canvas></div>
					</div>
				</div>
			
			
			

			<!--- CERTIFS --->	
			<div id="certifs_collapse" class="mt-3">	
				<div class="d-grid">
					<button class="btn btn-dark btn-block text-center m-0 mt-4" data-toggle="collapse" data-target="#certifs" aria-expanded="true" aria-controls="certifs">
						<i class="fal fa-file-certificate mr-2"></i> CERTIFICATIONS
					</button>
				</div>
								
				<div id="certifs" class="collapse show p-1" style="background-color: rgba(150,150,150,0.2);" data-parent="#certifs_collapse">
				
				
				
			
				<div class="row">
				<cfset product_list = "1,2,3">
				<cfloop list="#product_list#" index="cur_product">	
				<cfoutput>
				<div class="col-md-4">
				<div id="#cur_product#_collapse">	
					<div class="d-grid">
						<button class="btn btn-info btn-block text-center m-0 mt-4" data-toggle="collapse" data-target="###cur_product#" aria-expanded="true" aria-controls="#cur_product#">
							#evaluate('get_#cur_product#_orders.product_name')#
						</button>
					</div>
								
					<div id="#cur_product#" class="collapse show p-2 bg-white" data-parent="###cur_product#_collapse">
					
						<div class="row">
							<div class="col-md-12">
								<table class="table table-bordered" rules="all">
								
								<cfset list_attr = "">
								<cfset cur_attr = "">
								<cfset cur_nb = 0>
								<cfloop query="get_#cur_product#_orders">
									<cfif attribute_name eq #cur_attr#>
										<cfset cur_nb += 1>
									<cfelse>
										<cfif cur_nb neq 0>
											<cfset list_attr = listAppend(#list_attr#, "#cur_nb#")>
										</cfif>
										<cfset cur_attr = #attribute_name#>
										<cfset cur_nb = 1>
									</cfif>
								</cfloop>
								<cfset list_attr = listAppend(#list_attr#, "#cur_nb#")>
								
								<cfset start_row = 1>
								<cfset attr_bool = 0>
								<cfloop list="#list_attr#" index="cur_attr">
									<cfloop query="get_#cur_product#_orders" startRow="#start_row#" endRow="#start_row+cur_attr-1#">
									<tr>
										<cfif attr_bool eq 0>
										<td rowspan="#cur_attr#">#attribute_name#</td>
										<cfset attr_bool = 1>
										</cfif>
										<td align="center">#variation_name_fr#</td>
										<td>#nb_var_uses#</td>
										<!---<cfif view neq "screenshot"><td width="100px"><button type="button" class="btn btn-dark btn_list_tps" id="#display#_#method_id#_#tp_status_id#">details</button></td>--->
									</tr>
									</cfloop>
									<cfset start_row += #cur_attr#>
									<cfset attr_bool = 0>
								</cfloop>
								<!---
								<tr>
									<td><strong>TOTAL</strong></td>
									<td align="center"><strong>#nb_tp#</strong></td>
								</tr>
								--->
								</table>
							</div>
						</div>
						<!---
						<div class="row">
							<cfset w_col = 12 / #listLen(list_attr)#>
							<cfloop from="1" to="#listLen(list_attr)#" index="cur_attr" step="1">
							<div class="col-md-#w_col#">
								CHART
							</div>
							</cfloop>
						</div>
						--->
						
					<cfif isdefined('get_coupon_repart_#cur_product#')>	
					<div class="row"><div class="col-12">
						<div id="#cur_product#_cpn_collapse">
							<div class="row">
							<div class="col-md-3"></div>
							<div class="d-grid col-md-6">
								<button class="btn btn-info btn-block text-center m-0 mt-4" data-toggle="collapse" data-target="###cur_product#_cpn" aria-expanded="true" aria-controls="#cur_product#_cpn">
									see coupons
								</button>
							</div>
							<div class="col-md-3"></div>
							</div>
										
							<div id="#cur_product#_cpn" class="collapse p-2 bg-white" data-parent="###cur_product#_cpn_collapse">
							
								<div class="row">
									<div class="col-12">
										
										<div width="100%" class="mb-3"><canvas id="coupon_repart_#cur_product#"></canvas></div>
										
									</div>
								</div>
								
								<div class="row"><div class="col-md-11">
								<table class="table table-bordered m-3" rules="all">
								<cfloop query="get_coupon_repart_#cur_product#">
								<tr>
								<td><cfif coupon_code eq "">no coupon<cfelse>#coupon_code#</cfif></td>
								<td>#cpn_uses# uses</td>
								<td width="35px"><button type="button" class="btn btn-dark btn_repart_cpn" id="#product_id#_#coupon_id#_#coupon_code#">details</button></td>
								</tr>
								</cfloop>
								</table>
								</div><div class="col-md-1"></div></div>
								
							</div>
						</div>
					</div></div>
					</cfif>
					</div>
			
				</div>
				</div>
				</cfoutput>
				</cfloop>
				</div>
				<!--- AUTRES LINGUA *2 ----------------------------
				<div class="row">
				<div class="col-md-2"></div>
				<cfset product_list = "8,9">
				<cfloop list="#product_list#" index="cur_product">	
				<cfoutput>
				<div class="col-md-4">
				<div id="#cur_product#_collapse">	
					<div class="d-grid">
						<button class="btn btn-info btn-block text-center m-0 mt-4" data-toggle="collapse" data-target="###cur_product#" aria-expanded="true" aria-controls="#cur_product#">
							#evaluate('get_#cur_product#_orders.product_name')#
						</button>
					</div>
								
					<div id="#cur_product#" class="collapse p-2 bg-white" data-parent="###cur_product#_collapse">
					
						<div class="row">
							<div class="col-md-12">
								<table class="table table-bordered" rules="all">



								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">


							</div>
						</div>
						
					</div>
			
				</div>
				</div>
				</cfoutput>
				</cfloop>
				<div class="col-md-2"></div>
				</div>
				--->
			
				</div>
			</div>
			<!--- /certifs --->
			
			</div>
			
		</div>
	</div>
	
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>


<script>
$(document).ready(function() {

$('.btn_repart_ord').click(function(event) {		
	event.preventDefault();
	
	var id_temp = $(this).attr("id");
	
	var tmp = id_temp.split("_");
	var prdt_id = tmp[0];
	var prdt_name = tmp[1];
	
	
	<cfoutput>	
	console.log('pp: '+#period_spe#);
	
	$('##window_item_lg').modal({keyboard: true});
	if(#period_spe# == 1){
	$('##modal_title_lg').text("Product "+prdt_name+" ("+"#date_start#"+" - "+"#date_end#"+")");
	}
	else
	{
	$('##modal_title_lg').text("Product "+prdt_name);
	}
	$('##modal_body_lg').load("_AD_modal_window_shop_stats.cfm?product="+prdt_id+"&date_start="+"#date_start#"+"&date_end="+"#date_end#");
	</cfoutput>
});


$('.btn_repart_cpn').click(function(event) {		
	event.preventDefault();
	
	var id_temp = $(this).attr("id");
	
	var tmp = id_temp.split("_");
	var prdt_id = tmp[0];
	var cpn_id = tmp[1];
	var cpn_name = tmp[2];
	
	if (cpn_name == "")
	{
	var cpn_name = "without";
	var cpn_id = 0;
	}
	

	$('#window_item_lg').modal({keyboard: true});
	<cfoutput>
	if(#period_spe# == 1){
	$('##modal_title_lg').text("Coupon "+cpn_name+" ("+"#date_start#"+" - "+"#date_end#"+")");
	}
	else
	{
	$('##modal_title_lg').text("Coupon "+cpn_name);
	}
	$('##modal_body_lg').load("_AD_modal_window_shop_stats.cfm?product="+prdt_id+"&cpn="+cpn_id+"&date_start="+"#date_start#"+"&date_end="+"#date_end#");
	</cfoutput>
});



$('.btn_all_ord').click(function(event) {		
	event.preventDefault();
		
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_title_lg').text("All shop orders :");
	<cfoutput>
	if(#period_spe# == 1){
	$('##modal_title_lg').text("All shop orders ("+"#date_start#"+" - "+"#date_end#"+") :");
	}
	else
	{
	$('##modal_title_lg').text("All shop orders : ");
	}
	$('##modal_body_lg').load("_AD_modal_window_shop_stats.cfm?date_start="+"#date_start#"+"&date_end="+"#date_end#");
	</cfoutput>
});


$('.btn_no_date').click(function(event) {

	document.location.href="shop_stats.cfm?";

});

$('.btn_sel_date').click(function(event) {
	var date_from = $(date_schedule_from).val();
	var date_to = $(date_schedule_to).val();

	<cfoutput>
	document.location.href="shop_stats.cfm?date_start="+date_from+"&date_end="+date_to;
	</cfoutput>
});


$(function() {
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
});



	<!-------------------------------------------------------------------------------------->




$.typeahead({
    input: '.js_typeahead_shop',
    order: "desc",
	minLength: 1,
    maxItem: 15,
	emptyTemplate: 'Pas de resultats pour "{{query}}"',


	source: {
		

		<!--- Learners: {
			display:"learner_name",
			href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/_AD_modal_window_shop_stats.cfm?oid={{order_id}}",
			data: [
				<cfoutput query="get_all_orders" group="user_id">{"user_id": #user_id#, "order_id": #order_id#, "learner_name": "#user_firstname# #user_name#  <em>°#order_ref#°</em>"},</cfoutput>				
			]
		}, --->
		
    }
});

$('.js_typeahead_shop').change(function(event) {
    console.log('ggg');
	var oid = $('.js_typeahead_shop').val();
	console.log(oid);
	
	
	<!---
	form-global_shop
	var oid = $(this).attr("id");
		
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_title_lg').text("Order "+oid);
	$('#modal_body_lg').load("_AD_modal_window_shop_stats.cfm?oid="+oid);
	--->
})

		<!-------------------------------------------------------------------------------------->

});
</script>

<cfset color_2 = 'rgba(219, 77, 155, 0.2)'>
<cfset color_1 = 'rgba(239, 129, 87, 0.2)'>
<cfset color_3 = 'rgba(251, 198, 88, 0.2)'>
<cfset color_4 = 'rgba(107, 208, 152, 0.2)'>
<cfset color_5 = 'rgba(251, 0, 0, 0.2)'>
<cfset color_6 = 'rgba(10, 10, 10, 0.2)'>
<cfset color_7 = 'rgba(0, 0, 250, 0.2)'>
<cfset color_8 = 'rgba(0, 0, 250, 0.2)'>
<cfset color_9 = 'rgba(0, 250, 0, 0.2)'>
<cfset color_10 = 'rgba(107, 208, 152, 0.2)'>
<cfset color_11 = 'rgba(187, 105, 255, 0.2)'>

<cfset colorbg_2 = 'rgba(219, 77, 155, 1)'>
<cfset colorbg_1 = 'rgba(239, 129, 87, 1)'>
<cfset colorbg_3 = 'rgba(251, 198, 88, 1)'>
<cfset colorbg_4 = 'rgba(107, 208, 152, 1)'>
<cfset colorbg_5 = 'rgba(251, 0, 0, 1)'>
<cfset colorbg_6 = 'rgba(107, 208, 152, 1)'>
<cfset colorbg_7 = 'rgba(0, 0, 250, 1)'>
<cfset colorbg_8 = 'rgba(107, 208, 152, 1)'>
<cfset colorbg_9 = 'rgba(0, 250, 0, 1)'>
<cfset colorbg_10 = 'rgba(42, 117, 90, 1)'>
<cfset colorbg_11 = 'rgba(187, 105, 255, 1)'>

<script>
<cfoutput>

var order_repart = document.getElementById('order_repart');
var order_repart = new Chart(order_repart, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_orders_repart#">
		'#product_name#: #round((nb_product/nb_orders)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_orders_repart#">
			#round((nb_product/nb_orders)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_orders_repart#">
                '<cfif isDefined("color_#product_id#")>#evaluate("color_#product_id#")#<cfelse>rgba(239, 129, 87, 0.2)</cfif>',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_orders_repart#">
                '<cfif isDefined("colorbg_#product_id#")>#evaluate("colorbg_#product_id#")#<cfelse>rgba(239, 129, 87, 0.2)</cfif>',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});

<cfloop list="1,8,9" index="cur_product">
<cfif #evaluate('get_coupon_repart_#cur_product#.recordcount()')# neq 0>
var coupon_repart_#cur_product# = document.getElementById('coupon_repart_#cur_product#');
var coupon_repart_#cur_product# = new Chart(coupon_repart_#cur_product#, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#evaluate('get_coupon_repart_#cur_product#')#">
		'<cfif #coupon_code# eq "">no coupon<cfelse>#coupon_code#</cfif>: #round((cpn_uses/nb_total)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#evaluate('get_coupon_repart_#cur_product#')#">
			#round((cpn_uses/nb_total)*100)#,
			</cfloop>
			],
            <!--- backgroundColor: [ --->
			<!--- <cfloop from="1" to="#evaluate('get_coupon_repart_#cur_product#.recordcount()')#" step="1" index="color_id"> --->
                <!--- '#evaluate("color_#color_id#")#',                 --->
			<!--- </cfloop> --->
            <!--- ], --->
            borderColor: [
			<cfloop from="1" to="#evaluate('get_coupon_repart_#cur_product#.recordcount()')#" step="1" index="color_id">
                <!---'#evaluate("colorbg_#color_id#")#',      --->           
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
</cfif>
</cfloop>

</cfoutput>
</script>


</body>

</html>