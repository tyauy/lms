<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<!--------------- DEFAULT DATE & VIEW  ------------->
<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfset y = mid(ysel,3,2)>

<cfparam name="prov_id" default="0">
<cfset prov_pos = listContainsNoCase(SESSION.SELECTED_PROVIDER, prov_id)>

<cfif prov_id neq 0 AND prov_pos eq 0>
	<cfset SESSION.SELECTED_PROVIDER = listAppend(SESSION.SELECTED_PROVIDER, prov_id)>
<cfelseif prov_id neq 0 AND prov_pos neq 0>
	<cfset SESSION.SELECTED_PROVIDER = listDeleteAt(SESSION.SELECTED_PROVIDER, prov_pos)>
</cfif>

<cfif SESSION.SELECTED_PROVIDER eq "">
	<cfset SESSION.SELECTED_PROVIDER = "1">
</cfif>


<cfparam name="view" default="reg">
<!--------------- DEFAULT DATE & VIEW  ------------->



<cfparam name="s_id" default="2">



<cfquery name="get_status_cs" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_status_cs
</cfquery>

<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT * FROM order_status_finance
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
				
					<cfset urlgo = "common_orders.cfm">
					<cfinclude template="./incl/incl_nav_sales.cfm">

					<cfloop from="15" to="23" index="y">
					<cfset "ca_#y#" = 0> 
					</cfloop>					
					

					<!--- <button type="button" class="btn_new_order btn btn-sm btn-info text-white" id="btn_new_order">New Order</button> --->
							
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

						<cfif view eq "reg">
							<cfset get_orders = obj_order_get.oget_orders(s_id="#status_finance_id#",y_id="#mid(ysel,3,2)#")>
						<cfelseif view eq "close">
							<cfset get_orders = obj_order_get.oget_orders(s_id="#status_finance_id#",close_id="#mid(ysel,3,2)#")>
						</cfif>
						
						<li class="nav-item">
							<a href="##s_#status_finance_id#" class="nav-link <cfif status_finance_id eq s_id>active</cfif>" role="tab" data-toggle="tab">
								#status_finance_name# (#get_orders.recordcount#)
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
								
							<!--- <cfdump var="#get_orders#"> --->
							
							<cfinclude template="./widget/wid_order_list.cfm">						
																
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

	$('.btn_edit_order').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[2];
		var o_id = idtemp[3];

		console.log(a_id, o_id)
		$('#window_item_xl').modal({keyboard: true, backdrop: "static"});
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

	$(".delete_order").click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		
		var o_id = idtemp[2];

		if(confirm("Confirmer la suppression de l'order ?")) {
		
			$.ajax({
				url : './api/orders/orders_post.cfc?method=delete_order',
				type : 'POST',	   
				<cfoutput>
				data : {order_id: o_id},
				</cfoutput>
				success : function(resultat, statut){
					window.location.reload(true);
				},
				error : function(resultat, statut, erreur){
					// alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
				}
			})
		}

	});

</script>

</body>
</html>