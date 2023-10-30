<!DOCTYPE html>

<cfsilent>
<cfparam name="p_id">
<cfparam name="contract_lang" default="en">

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
		
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
		background-color: #51bcda !important;
	}


	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">
				<div class="col-md-12">
					<table cellpadding="20" width="100%">
						<tr>
							<td colspan="2" align="center">
								<div>
									<a href="trainer_sign.cfm?view=trainer_contract&p_id=<cfoutput>#p_id#</cfoutput>&contract_lang=en">
										<span class="lang-sm lang-lbl" lang="en"></span>
									</a>
									<a href="trainer_sign.cfm?view=trainer_contract&p_id=<cfoutput>#p_id#</cfoutput>&contract_lang=fr">
										<span class="lang-sm lang-lbl" lang="fr"></span>
									</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<cfform id="sigform" action="tpl/trainer_contract_container.cfm" target="_blank">
			<div class="container">
			<div class="row">
											
				<div class="col-md-12">
					
					<table cellpadding="20" width="100%">
						
						
					<cfif isdefined("id") AND isdefined("sh") AND get_id.recordcount eq "1">
						<tr>
							<td colspan="2">
								<div class="alert alert-success" style="margin-top:50px">
								  <strong>L'attestation de formation a &eacute;t&eacute; correctement g&eacute;n&eacute;r&eacute;e!</strong> Vous pouvez t&eacute;l&eacute;charger les &eacute;l&eacute;ments ci-dessous.
								</div>
							</td>
						</tr>
					<cfelse>
						<tr>
							<td colspan="2">
								<h4>1. Veuillez prendre connaissance du document suivant</h4>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<cfif view eq "trainer_charter">
								<cfoutput>
								<iframe width="100%" height="2000" src="./tpl/trainer_charter_container.cfm"></iframe>
								</cfoutput>
								<cfelseif view eq "trainer_contract">
								<cfoutput>
								<iframe width="100%" height="2000" src="./tpl/trainer_contract_container.cfm?p_id=<cfoutput>#p_id#&contract_lang=#contract_lang#</cfoutput>"></iframe>
								</cfoutput>
								</cfif>
						
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<h4><strong>2. Veuillez signer <u>dans l'encadr&eacute; ci-dessous</u> puis cliquer sur le bouton "Enregistrer document".</strong></h4>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<div id="content">
									<div id="signatureparent">
										<div id="signature" style="border:1px solid #000000;  width:300px;"></div>
									</div>
									<div id="tools"></div>
								</div>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" align="center">
								<!--- <cfoutput> --->
								<!--- <input type="hidden" name="charte" id="charte" value="1"> --->
								<!--- <input type="hidden" name="o_id" id="o_id" value="#o_id#"> --->
								<!--- <input type="hidden" name="fn_ch" id="fn_ch" value="#fn_ch#"> --->
								<!--- <input type="hidden" name="n_ch" id="n_ch" value="#n_ch#"> --->
								<!--- <input type="hidden" name="s_ch" id="s_ch" value="#s_ch#"> --->
								<!--- <input type="hidden" name="t_ch" id="t_ch" value="#t_ch#"> --->
								<!--- <input type="hidden" name="f_ch" id="f_ch" value="#f_ch#"> --->
								<!--- <input type="hidden" name="df_ch" id="df_ch" value="#df_ch#"> --->
								<!--- <input type="hidden" name="dt_ch" id="dt_ch" value="#dt_ch#"> --->
								<!--- <input type="hidden" name="c_ch" id="c_ch" value="#c_ch#"> --->
								<input type="submit" value="Enregistrer document" class="btn btn-info" style="margin-top:20px">
								<!--- </cfoutput> --->
								<input type="hidden" name="p_id" id="p_id" value="<cfoutput>#p_id#</cfoutput>">
								<input type="hidden" name="contract_lang" id="contract_lang" value="<cfoutput>#contract_lang#</cfoutput>">
								<input type="hidden" name="save" value="1">
								<input type="hidden" name="signature_base64" id="signature_base64" value="">
							</td>
						</tr>
							
					</cfif>
								
					
					
					<tr>
						<td colspan="2" align="center">
								
							<cfif isdefined("id") AND isdefined("sh") AND get_id.recordcount eq "1">
								<cfoutput><a href="./img/#get_id.signature_src#.pdf" class="btn btn-info">T&eacute;l&eacute;charger Document</a></cfoutput>
								<cfif isdefined("sign")><cfoutput><a href="./img/#get_id.signature_src#.png" class="btn btn-info">T&eacute;l&eacute;charger signature</a></cfoutput></cfif>
							</cfif>
					
						</td>
					</tr>
					
					</table>
				</div>
				
			
			</div>

		</div></div>
		</cfform> 
		<!--- </form> --->
		

      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  

<cfinclude template="./incl/incl_scripts.cfm">



<script>
var $sigdiv = $("#signature").jSignature({'UndoButton':true});
$("#signature").resize();
$("#sigform").submit(function( event ) {
	var data = $sigdiv.jSignature('getData', 'default');
	$('#signature_base64').val(data);
});
</script>
	

</body>
</html>