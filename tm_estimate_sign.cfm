<!DOCTYPE html>
<html lang="fr">

<cfset step = "2">

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
      
		<cfset title_page = "2/3 - Signature du devis">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
					
					
			<div class="row">

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
						
							<div class="card-title">
								<h4 class="mt-1 float-left"><i class="fad fa-clipboard-check text-info"></i> Je prends connaissance du devis ci-dessous :</h4>
							
									
								<form action="tm_estimate_create.cfm" method="post" class="pull-right">
									<cfoutput>	
									<input type="hidden" name="a_company" value="#a_company#">
									<input type="hidden" name="a_address" value="#a_address#">
									<input type="hidden" name="a_zipcode" value="#a_zipcode#">
									<input type="hidden" name="a_city" value="#a_city#">
									<input type="hidden" name="a_country" value="#a_country#">
									<input type="hidden" name="a_ctc" value="#a_ctc#">
									<cfif training_pack eq "pack">										
									<input type="hidden" name="pack_id" value="#pack_id#">
									<input type="hidden" name="tppack_id" value="#tppack_id#">
									<cfelse>				
									<input type="hidden" name="f_id" value="#f_id#">									
									<input type="hidden" name="f_certif" value="#f_certif#">
									</cfif>
									<input type="hidden" name="f_date_start" value="#f_date_start#">
									<input type="hidden" name="f_date_end" value="#f_date_end#">
									<input type="hidden" name="f_learner" value="#f_learner#">
									<input type="hidden" name="training_pack" value="#training_pack#">
									<cfloop from="1" to="#f_learner#" index="cor">
										<input type="hidden" name="f_lastname_#cor#" value="#evaluate('f_lastname_#cor#')#">
										<input type="hidden" name="f_firstname_#cor#" value="#evaluate('f_firstname_#cor#')#">
									</cfloop>
									<input type="submit" class="btn btn-sm btn-warning p-1" value="Modifier devis">
									</cfoutput>
								</form>
						
						
							</div>
										
										
							<cfoutput>
							<iframe width="100%" height="500" src="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf"></iframe>
							</cfoutput>
							
							
										
							
							<br><br>
							<div class="card-title">
								<h4 class="mt-1"><i class="fad fa-file-signature text-info"></i><!---COMPLEX<cfoutput>#obj_translater.get_translate_complex('estimate_sign_here')#</cfoutput>START_RM---> Je signe &eacute;lectroniquement le document dans l'encadr&eacute; ci-dessous :<!---END_RM---> </h4>
							</div>
							
							
						
										<cfoutput>
										<div align="center">
											<em>Le #dateformat(now(),'dd/mm/yyyy')#, par #a_ctc# </em>
											
											<div id="content" align="center"><div id="signatureparent"><div id="signature" style="border:1px solid ##000000; width:350px; height:100px"></div></div><div id="tools"></div></div>
										
											<form action="updater_estimate.cfm" id="sigform" method="post">
											
											<input type="hidden" name="signature_base64" id="signature_base64" value="">
											<input type="hidden" name="a_ctc" value="#a_ctc#">
											<input type="hidden" name="n_id" value="#n_id#">
											
											<input type="submit" value="Signer le document" class="btn btn-info">
											</form>
										</div>
										</cfoutput>
							
							
								<div align="center"><em><small></small></em></div>
							
							
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
var $sigdiv = $("#signature").jSignature({'UndoButton':true});
$("#sigform").submit(function( event ) {
	if( $sigdiv.jSignature('getData', 'native').length == 0) {
		alert('Votre signature est vide, veuillez essayer de nouveau.');
		return false;
	}
	else
	{
	var data = $sigdiv.jSignature('getData', 'default');
	$('#signature_base64').val(data);
	}
});
</script>

</body>

</html>