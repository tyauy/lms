<!DOCTYPE html>


<!--- <cfif isdefined('st')><cfdump var="#st#"></cfif> --->
<cfsilent>

	<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	


<cfparam name="view" default="closed">
<cfparam name="st" default="0">
<cfparam name="cont" default="0">
<cfparam name="mode" default="0">
<cfparam name="acc" default="0">

	<!--- <cfif view eq "closed"> --->
		<!--- <cfset get_orders = obj_query.oget_orders(alert_close="1")> --->
	<!--- <cfelseif view eq "outdatedd"> --->
		<!--- <cfset get_orders = obj_query.oget_orders(alert_dead="1")> --->
	<!--- </cfif> --->
	
	<cfquery name="get_orders" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	a.account_name, a.account_id,
	o.*, 
	oc.*,
	u.user_firstname, u.user_name, u.user_qpt, u.user_qpt_lock, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_de, u.user_qpt_lock_de, u.user_elapsed, u.user_lastconnect,
	oim.order_item_mode_name, 
	ofi.status_finance_name, ofi.status_finance_css,
	otm.status_tm_name, otm.status_tm_css, 
	oi.*, 
	a2.account_name as opca_name, 
	u.user_firstname, u.user_name,
	u2.user_firstname as manager_firstname, u2.user_color as manager_color,
	f.formation_id, f.formation_code
	
	FROM orders o

	INNER JOIN account a ON a.account_id = o.account_id
	INNER JOIN orders_users ou ON o.order_id = ou.order_id
	INNER JOIN user u ON u.user_id = ou.user_id
	
	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
	LEFT JOIN order_status_tm otm ON otm.status_tm_id = o.status_tm_id
	
	LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
	LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
	
	LEFT JOIN order_context oc ON oc.context_id = o.context_id

	INNER JOIN account a2 ON o.account_id = a2.account_id
	INNER JOIN account_group ag ON ag.group_id = a2.group_id
	LEFT JOIN user u2 ON u2.user_id = ag.manager_id
	LEFT JOIN lms_formation f ON f.formation_id = o.formation_id
	
	<!---LEFT JOIN order_item oi ON oi.order_id = o.order_id
	LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
	LEFT JOIN order_mode om ON om.order_mode_id = o.order_mode_id--->
	<!---LEFT JOIN logs lo ON lo.order_id = oi.order_id--->
	
	WHERE 1 = 1

	<!---------->
	<cfif isdefined('st') and st neq 0>
	AND ofi.status_finance_id = #st#
	</cfif>
	
	<cfif isdefined('cont') and cont neq 0>
	AND oc.context_id = #cont#
	</cfif>
	
	<cfif isdefined('mode') and mode neq 0>
	AND oim.order_item_mode_id = #mode#
	</cfif>
	
	<cfif isdefined('acc') and acc neq 0>
	AND a.account_id = #acc#
	</cfif>
	
	<!--- AND o.order_status_id <> "10" AND o.order_status_id <> "11"--->
	<cfif view eq "closed">
	AND o.order_end <= #dateadd('m',+2,now())# AND o.order_end > now() AND o.order_status_id <> "6"
	</cfif>
	
	<cfif view eq "outdatedd">
	AND o.order_end <= now() AND o.order_status_id <> "6" AND o.order_status_id <> "7"
	</cfif>
	
	ORDER BY order_end desc
	</cfquery>
		
	<cfquery name="get_fstatus" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM order_status_finance
	</cfquery>
	
	<cfquery name="get_context" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM order_context
	</cfquery>
	
	<cfquery name="get_mode" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM order_item_mode
	</cfquery>
	
	
	<cfquery name="get_acc_search" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	a.account_name, a.account_id,
	o.*, 
	oc.*,
	oim.order_item_mode_name, 
	ofi.status_finance_name, ofi.status_finance_css
	
	FROM orders o

	INNER JOIN account a ON a.account_id = o.account_id

	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
	
	LEFT JOIN order_item_invoice oi ON oi.order_id = o.order_id
	LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
	
	LEFT JOIN order_context oc ON oc.context_id = o.context_id

	
	<!---LEFT JOIN order_item oi ON oi.order_id = o.order_id
	LEFT JOIN order_item_mode oim ON oim.order_item_mode_id = oi.order_item_mode_id
	LEFT JOIN order_mode om ON om.order_mode_id = o.order_mode_id--->
	<!---LEFT JOIN logs lo ON lo.order_id = oi.order_id--->
	
	WHERE 1 = 1

	<!---------->
	<cfif isdefined('st') and st neq 0>
	AND ofi.status_finance_id = #st#
	</cfif>
	
	<cfif isdefined('cont') and cont neq 0>
	AND oc.context_id = #cont#
	</cfif>
	
	<cfif isdefined('mode') and mode neq 0>
	AND oim.order_item_mode_id = #mode#
	</cfif>
	
	
	<cfif view eq "closed">
	AND o.order_end <= #dateadd('m',+2,now())# AND o.order_end > now() AND o.order_status_id <> "6"
	</cfif>
	
	<cfif view eq "outdatedd">
	AND o.order_end <= now() AND o.order_status_id <> "6"
	</cfif>
	GROUP BY a.account_id
	ORDER BY o.order_ref ASC

	</cfquery>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
	<cfif view eq "closed">
		<cfset title_page = "ORDER : CLOSE DEADLINE (< 2 mois)">
	<cfelseif view eq "outdatedd">
		<cfset title_page = "ORDER : OUTDATED DEADLINE">
	</cfif>

		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
									
			<div class="row">	
			
				<div class="col-md-12">
					
					<a href="cs_alert_order.cfm?view=closed" class="btn p-2 <cfif view eq "closed">btn-info <cfelse>btn-outline-info</cfif>">CLOSE DEAD LINE</a>
					<a href="cs_alert_order.cfm?view=outdatedd" class="btn p-2 <cfif view eq "outdatedd">btn-info <cfelse>btn-outline-info</cfif>">OUTDATED DEADLINE</a>
					
					<cfform>
						<div class="row">
						<cfselect id="sel_fstatus" class="sel_fstatus p-2 m-1 mb-3 form-select-sm col-2" name="sel_fstatus" query="get_fstatus" display="status_finance_name" queryposition="below" selected="#st#" value="status_finance_id">
							<option <cfif st eq 0>selected </cfif> value = 0>Status: All</option>
						</cfselect>
						<cfselect id="sel_context" class="sel_context p-2 m-1 mb-3 form-select-sm col-2" name="sel_context" query="get_context" display="context_alias" queryposition="below" selected="#cont#" value="context_id">
							<option <cfif cont eq 0>selected </cfif>value = 0>Contexte: All</option>
						</cfselect>
						<cfselect id="sel_mode" class="sel_mode p-2 m-1 mb-3 form-select-sm col-2" name="sel_mode" query="get_mode" display="order_item_mode_name" queryposition="below" selected="#mode#" value="order_item_mode_id">
							<option <cfif mode eq 0>selected </cfif>value = 0>Pack: All</option>
						</cfselect>
						
						<div class="typeahead__container col-4 m-0 mt-1 mb-3 p-0">
							<div class="typeahead__field">
								<div class="typeahead__query">
									<cfsilent><cfif acc neq 0><cfquery name="get_acc" datasource="#SESSION.BDDSOURCE#">SELECT account_name FROM account WHERE account_id =#acc#</cfquery><cfset plholder = #get_acc.account_name#><cfelse><cfset plholder = "Account: all"></cfif></cfsilent>
									<input class="js_typeahead_account" <!---name="country_v1[query]"---> type="search" placeholder=<cfoutput>"#plholder#"</cfoutput> autocomplete="off">
								</div>
							</div>
						</div>
						<div class="col-1 m-0 p-0">
						<button id="btn_all_acc" class="m-0 mt-1 mb-3 p-2 btn_all_acc btn-md btn-ouline" style="background-color:white; border:1px grey solid;">
							All
						</button>
						</div>
						
						</div>
					</cfform>

					
					
					<cfset view eq "full"> 
					<cfinclude template="./widget/wid_order_list.cfm">					
					
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>
$( document ).ready(function() {

	$('.sel_fstatus').change(function(event) {
	
		<!--- var liner = '<cfset st = 4>'; --->
		<!--- $("#order_tab").before(liner); --->

		<!--- $("#order_tab").remove(); --->
		var status = $(sel_fstatus).val();

		<cfoutput>
		document.location.href="cs_alert_order.cfm?view=#view#&acc=#acc#&cont=#cont#&mode=#mode#&st="+status;
		</cfoutput>
	});
	
	
	$('.sel_context').change(function(event) {
		var context = $(sel_context).val();

		<cfoutput>
		document.location.href="cs_alert_order.cfm?view=#view#&acc=#acc#&st=#st#&mode=#mode#&cont="+context;
		</cfoutput>
	});
	
	
	$('.sel_mode').change(function(event) {
		var mode = $(sel_mode).val();

		<cfoutput>
		document.location.href="cs_alert_order.cfm?view=#view#&acc=#acc#&st=#st#&cont=#cont#&mode="+mode;
		</cfoutput>
	});
	

	
	$('.btn_all_acc').click(function(event) {

		<cfoutput>
		document.location.href="cs_alert_order.cfm?view=#view#&st=#st#&cont=#cont#&mode=#mode#&acc=0";
		</cfoutput>
	});
	


	$.typeahead({
		input: '.js_typeahead_account',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',

		/*matcher: function(item) {
			return true
		}*/
		
		
		source: {
			Accounts : {
				display:["account_name", "account_id"],
				href:"",
				data:[
					<cfoutput query="get_acc_search" group="account_id">
						{
						"account_name": "#account_name#",
						"account_id": #account_id#
						},
					</cfoutput>
				]
			},

			
		},
		
		
		callback: {
		
			onClickAfter: function (node, a, item, event) {
	 
				event.preventDefault;
				<cfoutput>				
				document.location.href="cs_alert_order.cfm?view=#view#&st=#st#&cont=#cont#&mode=#mode#&acc="+item.account_id;
				</cfoutput>			
			}			
		}
	});
	
	
	


})
</script>

</body>
</html>