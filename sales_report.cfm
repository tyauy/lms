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
<!--------------- DEFAULT DATE & VIEW  ------------->



<!------------------ GET ACCOUNT TYPE --------------->
<cfquery name="get_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type WHERE type_id <> 4 ORDER BY field(type_id,1,2,8,3,9,5,7,10,6)
</cfquery>

<cfparam name="o_by" default="account_name">
<cfparam name="t_id" default="1">
<cfparam name="pv_id" default="all">
<cfparam name="manager_id" default="">
<cfparam name="type_id" default="">
<cfparam name="ca_id" default="1">
<cfparam name="rtype" default="income_group">


<cfset SESSION.SELECTED_MANAGER = manager_id>
<cfset SESSION.SELECTED_TYPE = type_id>

<!------------------ GET ACCOUNT MANAGERS --------------->
<cfquery name="get_manager" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_color
FROM user u 
WHERE user_id IN (SELECT DISTINCT(user_id) as id FROM account)
</cfquery>


</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

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
	  
		<cfset title_page = "Reporting">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
				
			<cfset urlgo = "sales_report.cfm">
			<cfinclude template="./incl/incl_nav_sales.cfm">
				<cfform action="sales_report.cfm" method="post" >
				<div class="row">	

					<div class="col-md-3">
						<div class="card">
							<div class="card-body">
								<h6>Managers</h6>
								<cfselect name="manager_id" id="manager_id" class="form-control" query="get_manager" display="user_firstname" value="user_id" multiple="yes" size="4" selected="#manager_id#"></cfselect>
							</div>
						</div>
					</div>

					<div class="col-md-3">	
						<div class="card">
							<div class="card-body">
								<h6>Type</h6>
								<cfselect name="type_id" id="type_id" class="form-control" query="get_account_type" display="type_name" value="type_id" multiple="yes" size="4" selected="#manager_id#"></cfselect>
							</div>
						</div>
					</div>

					<div class="col-md-3">	
						<div class="card">
							<div class="card-body">
								<h6>CA / PIPE</h6>
								<select name="ca_id" id="ca_id" class="form-control" multiple="yes" size="4" selected="<cfoutput>#ca_id#</cfoutput>">
									<option value="1" <cfif listfind(ca_id,1)>selected</cfif>>CA</option>
									<option value="2" <cfif listfind(ca_id,2)>selected</cfif>>PIPE</option>
								</select>
							</div>
						</div>
					</div>


					<div class="col-md-1">	
						<input type="submit" class="btn btn-success" value="Go">
						<!--- <div class="card">
							<div class="card-header">
								<h6 class="card-title d-inline"><label for="manager_id">Manager</label></h6>
							</div>
							<div class="card-body">
								<cfselect name="manager_id" id="manager_id" class="form-control" query="get_manager" display="user_firstname" value="user_id" multiple="yes" size="3" selected="#manager_id#"></cfselect>
							</div>
						</div> --->
					</div>

				</div>
				</cfform>

				<div class="row">

					<div class="col-md-12">	

						<cfinclude template="./widget/wid_report.cfm">
						
					</div>
					
				</div>
				
			</div>
			
		<cfinclude template="./incl/incl_footer.cfm">
  
	</div>
	
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script type="text/javascript">
						
$(document).ready(function() {

	$('#manager_id').multiselect({	
	numberDisplayed: 1
	});

	$('#type_id').multiselect({	
	numberDisplayed: 1
	});

	$('#ca_id').multiselect({	
	numberDisplayed: 1
	});

})
</script>
</body>
</html>