<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset list_view_global = "learner_activity,learner_rate,learner_distribution,order_distribution,order_list,learner_rating,learner_launch,learner_deadline,learner_missed,learner_nnl">

<cfquery name="get_widget" datasource="#SESSION.BDDSOURCE#">
SELECT widget_id, widget_name_#SESSION.LANG_CODE# as widget_name FROM user_widget
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
      
		<cfset title_page = obj_translater.get_translate('title_page_tm_account')>
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
					
					<div class="card border-top border-info">						
						<div class="card-body">
							<h5 class="mb-4"><cfoutput>#obj_translater.get_translate('sidemenu_learner_account')#</cfoutput></h5>
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
							
							<!--- <h5 class="mb-4">Notification</h5> --->
							<!--- <div class="row"> --->
								<!--- <div class="col-md-12"> --->
								
									<!--- <table class="table table-bordered"> --->
										<!--- <tr> --->
											<!--- <td width="30%" class="bg-light">Notification Lancement</td> --->
											<!--- <td> --->
											<!--- <input type="radio" name="user_missed"> Oui --->
											<!--- &nbsp;&nbsp;&nbsp; --->
											<!--- <input type="radio" name="user_missed"> Non --->
											<!--- </td> --->
										<!--- </tr> --->
										<!--- <tr> --->
											<!--- <td width="30%" class="bg-light">Notification Rapport mensuel</td> --->
											<!--- <td> --->
											<!--- <input type="radio" name="user_missed"> Oui --->
											<!--- &nbsp;&nbsp;&nbsp; --->
											<!--- <input type="radio" name="user_missed"> Non --->
											<!--- </td> --->
										<!--- </tr> --->
										<!--- <tr> --->
											<!--- <td width="30%" class="bg-light">Notification Cours manqué</td> --->
											<!--- <td> --->
											<!--- <input type="radio" name="user_missed"> Oui --->
											<!--- &nbsp;&nbsp;&nbsp; --->
											<!--- <input type="radio" name="user_missed"> Non --->
											<!--- </td> --->
										<!--- </tr> --->
									
									<!--- </table> --->
								<!--- </div> --->
							<!--- </div> --->
							
							<h5 class="mb-4"><cfoutput>#obj_translater.get_translate('card_settings_hp')#</cfoutput></h5>
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered">
									<!--- SESSION.USER_WIDGET -- <cfoutput>#SESSION.USER_WIDGET#</cfoutput> --->
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
							
							<div align="center">
							<input type="submit" value="<cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>" class="btn btn-info">
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


<script>
$(document).ready(function() {	
			
	$("#form_opinion").submit(function(event) {
	
	
	});
})
</script>		

</body>
</html>