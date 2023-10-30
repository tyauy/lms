<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="s_id" default="10">
<cfparam name="view" default="reg">

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>

<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
    SELECT status_finance_id, status_finance_name FROM order_status_finance
</cfquery>
</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Order">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row" style="margin-top:10px">
			
				<div class="col-md-12">
				
<cfloop from="15" to="22" index="y">
<cfset "ca_#y#" = 0> 
</cfloop>					
					<table class="table table-sm">
						<tr>
							<td>
								<div class="btn-group" role="group">
									<cfoutput>
										<a class="btn btn-success <cfif view eq "reg">active</cfif>" href="common_orders_export.cfm?ysel=#ysel#&view=reg">Vue REG</a>
										<a class="btn btn-success <cfif view eq "close">active</cfif>" href="common_orders_export.cfm?ysel=#ysel#&view=close">Vue CLOSE</a>
									</cfoutput>
								</div>
							</td>
						<cfloop from="2015" to="#year(now())#" index="y">
						<cfoutput>
							<td>
								<a class="btn btn-lg btn-info <cfif ysel eq y>active</cfif>" href="common_orders_export.cfm?ysel=#y#&view=#view#">#y#</a>
							</td>
						</cfoutput>
						</cfloop>
						</tr>
						<cfoutput query="get_status_finance">
						<tr>
							<td>
								<small>#status_finance_id# - #status_finance_name#</small>
							</td>
							

						<cfloop from="15" to="22" index="y">
							<td align="right">
						<cfquery name="get_ca_status" datasource="#SESSION.BDDSOURCE#">
						SELECT SUM(oi.item_inv_total) as ca
						FROM orders o
						INNER JOIN order_item_invoice oi ON oi.order_id = o.order_id
						INNER JOIN account a ON o.account_id = a.account_id
						INNER JOIN account_group ag ON ag.group_id = a.group_id
						INNER JOIN order_status_finance os ON os.status_finance_id = o.order_status_id
						<cfif view eq "reg">
							WHERE SUBSTRING(order_ref,1,2) = '#y#'
						<cfelseif view eq "close">
							WHERE DATE_FORMAT(order_date,'%Y') = '20#y#'
						</cfif>
						AND o.order_status_id = #status_finance_id#
						</cfquery>	

						<cfif status_finance_id neq "1"
						AND status_finance_id neq "2" 
						AND status_finance_id neq "6" 
						AND status_finance_id neq "7" 
						AND status_finance_id neq "8">
						<cfif get_ca_status.ca neq "">
						<cfset "ca_#y#" = evaluate("ca_#y#")+get_ca_status.ca>
						</cfif>
						</cfif>
						#get_ca_status.ca# &euro;
						
							</td>
						</cfloop>
						</tr>						
						</cfoutput>
						<tr>
							<td>
							
							</td>
							<cfloop from="15" to="22" index="y">
							<cfoutput>
								<td align="right">
									#evaluate("ca_#y#")# &euro;
								</td>
							</cfoutput>
							</cfloop>
						</tr>
						
						
						
					</table>

					<button type="button" class="btn_new_order btn btn-sm btn-info text-white" id="btn_new_order">New Order</button>
							
							<!---<div class="col">
								<select class="form-control" name="msel">

								<cfloop from="1" to="12" index="m">
								<cfoutput>
									<cfif SESSION.LANG_CODE neq "fr">
									<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
									<cfelse>
									<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
									</cfif>
									
									
								</cfoutput>
								</cfloop>
								</select>
							</div>
								
								<select class="form-control" name="ysel">
								<cfloop from="2018" to="#year(now())#" index="y">
								<cfoutput>
									<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
								</cfoutput>
								</cfloop> 
								</select>
							
							<div class="col-md-2">
								<input type="submit" value="GO" class="btn btn-info">
								
							</div>--->
				</div>
				
			</div>
			
			
			
			<div class="row">
			
				<div class="col-md-12">

		
					<ul class="nav nav-tabs" id="order_list" role="tablist">
						<cfoutput query="get_status_finance">
						<li class="nav-item">
							<a href="##s_#status_finance_id#" class="nav-link <cfif status_finance_id eq s_id>active</cfif>" role="tab" data-toggle="tab">
								#status_finance_name#
							</a>
						</li>
						</cfoutput>
					</ul>

					<!-- Tab panes -->
					<div class="tab-content">
						<cfloop query="get_status_finance">
						<cfoutput><div role="tabpanel" class="tab-pane fade <cfif status_finance_id eq s_id>active show</cfif>" id="s_#status_finance_id#"></cfoutput>

							<cfif view eq "reg">
								<cfset get_orders = obj_order_get.oget_orders(s_id="#status_finance_id#",y_id="#mid(ysel,3,2)#")>
							<cfelseif view eq "close">
								<cfset get_orders = obj_order_get.oget_orders(s_id="#status_finance_id#",close_id="#mid(ysel,3,2)#")>
							</cfif>
								
							<!---<cfdump var="#get_orders#">
							<br>--->
							<cfoutput>#get_orders.recordcount# dossiers</cfoutput>
							
							<cfinclude template="./widget/wid_order_list_export.cfm">
																
						</div>

						</cfloop>
					</div>	
					
				
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>

	$('.up_order').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[2];
		var o_id = idtemp[3];

		console.log(a_id, o_id)
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Order - " + o_id);
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_order_create.cfm?a_id="+a_id+"&o_id="+o_id, function() {});
	});


	$('.btn_new_order').click(function(event) {	
		event.preventDefault();		
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Create new order");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_order_create.cfm");
	});
</script>

</body>
</html>