<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "13">
<cfinclude template="./incl/incl_secure.cfm">	

<cfquery name="get_widget" datasource="#SESSION.BDDSOURCE#">
SELECT widget_id, widget_name_#SESSION.LANG_CODE# as widget_name FROM user_widget WHERE widget_partner = 1
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
      
		<cfset title_page = "WEFIT Partner - Settings">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<form action="updater_tm.cfm" id="form_opinion" method="post">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 col-md-12">
					
					<cfif isdefined("k")>
						<cfif k eq "1">
						<div class="alert alert-success"><cfoutput>#obj_translater.get_translate('alert_modif_ok')#</cfoutput></div>
						</cfif>
					</cfif>
					

					<div class="card h-100 border">					
						<div class="card-body pb-0">

                            <div class="w-100">
                                <h5 class="d-inline"><i class="fa-thin fa-user fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('sidemenu_learner_account')#</cfoutput></strong></h5>
                                <hr class="border-red mb-3 mt-2">
                            </div>

							<div class="row">
								<div class="col-md-12">
								
									<table class="table table-bordered">
										<tbody>
											<tr>
												<td width="30%" class="bg-light"><cfoutput>#obj_translater.get_translate('form_label_firstname')#</cfoutput></td>
												<td><input type="text" class="form-control" required value="<cfoutput>#SESSION.USER_FIRSTNAME#</cfoutput>"></td>
											</tr>
											<tr>
												<td width="30%" class="bg-light"><cfoutput>#obj_translater.get_translate('form_label_name')#</cfoutput></td>
												<td><input type="text" class="form-control" required value="<cfoutput>#SESSION.USER_LASTNAME#</cfoutput>"></td>
											</tr>
											<tr>
												<td width="30%" class="bg-light"><cfoutput>#obj_translater.get_translate('form_label_email')#</cfoutput></td>
												<td><input type="email" class="form-control" required value="<cfoutput>#SESSION.USER_EMAIL#</cfoutput>"></td>
											</tr>
											<tr>
												<td width="30%" class="bg-light"><cfoutput>#obj_translater.get_translate('table_th_attached_accounts')#</cfoutput></td>
												<td><cfoutput>#SESSION.ACCOUNT_NAME#</cfoutput></td>
											</tr>
										</tbody>
									</table>
									
								</div>
							</div>

                            <div class="w-100 mt-3">
                                <h5 class="d-inline"><i class="fa-thin fa-cogs fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_settings_hp')#</cfoutput></strong></h5>
                                <hr class="border-red mb-3 mt-2">
                            </div>

							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
										<cfoutput>
										<cfloop query="get_widget">
										<tr>
											<td width="30%" class="bg-light">#get_widget.widget_name#</td>
											<td>
											<input type="checkbox" name="widget_id" value="#get_widget.widget_id#" <cfif listfind(SESSION.USER_WIDGET,get_widget.widget_id)>checked</cfif>> <cfoutput>#obj_translater.get_translate('btn_display')#</cfoutput>
											</td>
										</tr>
										</cfloop>
										</cfoutput>
									</table>
								</div>
							</div>
							
                            <div align="center" class="clearfix w-100">
                                <input type="submit" value="<cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>" class="btn btn-outline-red m-0 mt-2">
							</div>
							
						</div>
					</div>
									
				</div>
			</div>
			
		</div>
		</form>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">


<script>
$(document).ready(function() {	

	<cfif isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "0">
		$('#window_item_pw').modal({keyboard: false,backdrop:'static'});
		$('#modal_title_pw').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");		
		$('#modal_body_pw').load("modal_window_mdp.cfm?init=1", function() {});
	</cfif>

	$('.btn_add_user').click(function(event) {		
		event.preventDefault();
		$('#modal_title_lg').text("Créer Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_partner.cfm?create_user=1", function() {});
	});
	
})
</script>		

</body>
</html>