<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset list_formation = "1,2,3,4,5,9,6,8,12,13">

<cfparam name="a_id" default="#listgetat(SESSION.USER_ACCOUNT_RIGHT_ID,1)#">
<cfparam name="training_pack" default="pack">
<cfparam name="learner_choice" default="new">


<cfparam name="step" default="3">

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
      
		<cfset title_page = "3/3 - Télécharger Devis de formation">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			
			 
			
			<div class="row" style="margin-top:10px">
				<div class="col-lg-8 offset-lg-2 col-md-12">
				
					<div class="row">
				
						<div class="col-4" align="center">						
							<span class="btn btn-link">
							<cfif step eq "1">
							<h2 class="mb-1"><i class="fad fa-tasks text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">1 - DEVIS</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-tasks text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">1 - DEVIS</span></h4>
							</cfif>
							</span>								
						</div>
						<div class="col-4" align="center">
							<span class="btn btn-link">
							<cfif step eq "2">
							<h2 class="mb-1"><i class="fad fa-file-signature text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">2 - SIGNATURE</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-file-signature text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">2 - SIGNATURE</span></h4>
							</cfif>
							</span>			
						</div>
						<div class="col-4" align="center">
							<span class="btn btn-link">
							<cfif step eq "3">
							<h2 class="mb-1"><i class="fad fa-clipboard-check text-info"></i></h2>
							<h4 class="mt-1" style="color:#51BCDA"><span class="d-inline">3 - FINALISATION</span></h4>
							<cfelse>
							<h2 class="mb-1"><i class="fad fa-clipboard-check text-muted"></i></h2>
							<h4 class="mt-1" style="color:#999"><span class="d-inline">3 - FINALISATION</span></h4>
							</cfif>
							</span>								
						</div>
						
					</div>
			
					<div class="card border-top border-info">						
						<div class="card-body">
							<div class="row">
								<div class="col-md-12">
									<div class="card-title">
										<h4 class="mt-1"><i class="fad fa-building text-info"></i> Client / Coordonnées</h4>
										
									</div>
									
									<cfif isdefined("k") AND isdefined("n_id")>
			  
										<cfoutput>
										<div class="alert alert-success" role="alert" align="center">
										<!---COMPLEX
										#obj_translater.get_translate_complex('estimate_done')#
										START_RM--->
										Votre devis a correctement &eacute;t&eacute; g&eacute;n&eacute;r&eacute;, vous pouvez le t&eacute;l&eacute;charger et finaliser votre demande de prise en charge.
										<br>
										Merci pour votre confiance.
										<br>
										<a class="btn btn-secondary" href="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" target="_blank">T&eacute;l&eacute;charger votre devis</a>
										<!---END_RM--->
										</div>
										</cfoutput>
												
									  </cfif>
			  
								</div>
							</div>
						</div>
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
$(function() {

})
</script>



</body>
</html>