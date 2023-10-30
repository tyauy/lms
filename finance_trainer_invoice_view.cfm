<!DOCTYPE html>

<cfsilent>

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfparam name="p_id" default="#listGetAt(SESSION.TRAINER_EXPORT_LIST, 1)#">

<cfparam name="start_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="end_date" default="#LSdateformat(now(),'yyyy-mm-dd', 'fr')#">
<cfparam name="use_date" default="0">

<cfif use_date eq 0>
	<cfset periode_name = "#msel##ysel#">
<cfelse>
	<cfset periode_name = "#start_date#">
</cfif>

<cfquery name="get_trainer_invoice_info" datasource="#SESSION.BDDSOURCE#">
SELECT user_invoice_info_id, user_invoice_info_mail_sent, user_invoice_info_path, user_invoice_info_date, user_invoice_info_modified 
FROM user_invoice_info 
WHERE user_invoice_info_user = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
<cfif use_date eq 0>
	AND user_invoice_info_selector = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tselect#">
<cfelse>
	AND user_invoice_info_selector = <cfqueryparam cfsqltype="cf_sql_varchar" value="#start_date#">
</cfif>
</cfquery>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "TRAINER INVOICE VIEW">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">

			<div class="row" style="margin-top:10px">
			
				<div class="col-md-12">
					<div class="card">
						<div class="card-body">
                            <div align="center">
                                <cfoutput>
                                <button class="btn btn-lg btn-info return_invoice"><i class="fal fa-backward"></i> Back</button>

								<cfif use_date eq 0>
									<a type="button" class="btn btn-lg btn-info" onclick="return confirm('Attention le pdf du <cfoutput>#tselect#</cfoutput> sera écraser.');" href="./tpl/invoice_trainer_container.cfm?msel=#msel#&ysel=#ysel#&p_id=#p_id#">Save <i class="fal fa-forward"></i></a>
									<a type="button" class="btn btn-lg btn-info" onclick="return confirm('Attention le pdf du <cfoutput>#tselect#</cfoutput> sera écraser.');" href="./tpl/invoice_trainer_container.cfm?mail=1&msel=#msel#&ysel=#ysel#&p_id=#p_id#">save & Mail <i class="fal fa-forward"></i></a>
								<cfelse>
									<a type="button" class="btn btn-lg btn-info" onclick="return confirm('Attention le pdf du <cfoutput>#start_date#</cfoutput> sera écraser.');" href="./tpl/invoice_trainer_container.cfm?&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#&p_id=#p_id#">Save <i class="fal fa-forward"></i></a>
									<a type="button" class="btn btn-lg btn-info" onclick="return confirm('Attention le pdf du <cfoutput>#start_date#</cfoutput> sera écraser.');" href="./tpl/invoice_trainer_container.cfm?mail=1&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#&p_id=#p_id#">save & Mail <i class="fal fa-forward"></i></a>
								</cfif>
								
                                <!--- <button class="btn btn-lg btn-info validate_invoice">Save <i class="fal fa-forward"></i></button>
                                <button class="btn btn-lg btn-info validate_invoice_mail">save & Mail <i class="fal fa-forward"></i></button> --->
								<cfif get_trainer_invoice_info.recordCount GT 1 AND get_trainer_invoice_info.user_invoice_info_mail_sent eq 1><small>Mail sent</small><cfelse><small>Mail not sent</small></cfif>
                                </cfoutput>
                            </div>
							<cfoutput>
								<cfif use_date eq 0>
									<iframe src="./tpl/invoice_trainer_container.cfm?view_only=1&msel=#msel#&ysel=#ysel#&p_id=#p_id#" width="100%" height="800"></iframe>
								<cfelse>
									<iframe src="./tpl/invoice_trainer_container.cfm?view_only=1&use_date=#use_date#&start_date=#start_date#&end_date=#end_date#&p_id=#p_id#" width="100%" height="800"></iframe>
								</cfif>
                            </cfoutput>
						</div>
					</div>
				
				</div>
				
			</div>
			<cfoutput>
			</cfoutput>

		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {

	$('.return_invoice').click(function(event) {	
		event.preventDefault();		
		history.back()
	})

})
</script>

</body>
</html>