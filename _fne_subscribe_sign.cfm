<!DOCTYPE html>

<cfif isdefined("lg")>
	<cfif lg eq "de">
		<cfset SESSION.LANG = "3">
		<cfset lang_doc = "de">
	<cfelseif lg eq "en">
		<cfset SESSION.LANG = "2">
		<cfset lang_doc = "en">
	<cfelseif lg eq "fr">
		<cfset SESSION.LANG = "1">
		<cfset lang_doc = "fr">
	</cfif>
<cfelse>
	<cfif find("de",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "3">
		<cfset lang_doc = "de">
	<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "1">
		<cfset lang_doc = "fr">
	<cfelse>
		<cfset SESSION.LANG = "2">
		<cfset lang_doc = "en">
	</cfif>
</cfif>

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfif not isdefined("SESSION.USER_ID")>
		<cfinclude template="./incl/incl_head_light.cfm">
		<style type="text/css">
		.card {
			border-radius: 2px !important;
			box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
		}
		</style>
	<cfelse>
		<cfinclude template="./incl/incl_head.cfm">
	</cfif>
</head>

<body>


<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Signer votre devis">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<div class="row">

				<div class="col-md-6 offset-md-3">
					<div class="card border-top border-success">
						<div class="card-body">	
						
							<h5>1. Je prends connaissance du devis ci-dessous :</h5>
							<cfoutput>
							<iframe width="100%" height="500" src="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf"></iframe>
							</cfoutput>
							
							<br><br>
							<h5>2. Je signe &eacute;lectroniquement le document dans l'encadr&eacute; ci-dessous</h5>
							<div align="center"><em><small>La r&eacute;alisation de la prestation est subordonn&eacute;e &agrave; l'accord de prise en charge de la formation par l'OPCA ou la DIRECCTE.<br>Il ne constitue pas un engagement ferme.</small></em></div>
							
							<table cellpadding="20" width="100%">
								<tr>
									<td>
										<cfoutput>
										<em>Le #dateformat(now(),'dd/mm/yyyy')#, par #a_ctc# </em>
										
										<form action="_fne_subscribe.cfm" method="post">
										<input type="hidden" name="a_company" value="#a_company#">
										<input type="hidden" name="a_address" value="#a_address#">
										<input type="hidden" name="a_zipcode" value="#a_zipcode#">
										<input type="hidden" name="a_city" value="#a_city#">
										<input type="hidden" name="a_country" value="#a_country#">
										<input type="hidden" name="a_ctc" value="#a_ctc#">
										<input type="hidden" name="f_learner" value="#f_learner#">										
										<input type="hidden" name="f_package" value="#f_package#">
										<input type="hidden" name="f_date_start" value="#f_date_start#">
										<input type="hidden" name="f_date_end" value="#f_date_end#">
										<input type="hidden" name="f_certif" value="#f_certif#">
										<cfloop from="1" to="#f_learner#" index="cor">
											<input type="hidden" name="f_lastname_#cor#" value="#evaluate('f_lastname_#cor#')#">
											<input type="hidden" name="f_firstname_#cor#" value="#evaluate('f_firstname_#cor#')#">
										</cfloop>
										<input type="submit" class="btn btn-sm btn-warning p-1" value="Modifier devis">
										</form>
										
										
										</cfoutput>
										<div id="content"><div id="signatureparent"><div id="signature" style="border:1px solid #000000; width:250px"></div></div><div id="tools"></div></div>
									</td>
									<td valign="bottom">
										<form action="_fne_subscribe_work.cfm" id="sigform" method="post">
										<cfoutput>
										<input type="hidden" name="signature_base64" id="signature_base64" value="">
										<input type="hidden" name="a_ctc" value="#a_ctc#">
										<input type="hidden" name="n_id" value="#n_id#">
										</cfoutput>
										<input type="submit" value="Signer le document" class="btn btn-info">
										</form>
									</td>
									
								</tr>
							</table>
							
							
						</div>
					</div>
					
				</div>
				
			</div>
			
		</div>
		

	 
	 
	 
	
	
	
		<footer class="footer footer-black footer-white ">
			<div class="container-fluid">
				<div class="row">
					<nav class="footer-nav">
						<ul>
							<li>
							<a href="https://www.wefitgroup.com" target="_blank">SUPPORT WEFIT</a>
							</li>
						</ul>
					</nav>
					<div class="credits ml-auto">
						<span class="copyright">
						<!---<img src="./sources/<cfoutput>#SESSION.MASTER_ID#</cfoutput>/img/logo_wefit_1line.png" height="25" style="margin-top:2px">--->
						&copy;
						<script>
						<cfoutput>#year(now())#</cfoutput>
						</script> / WEFIT
						</span>
					</div>
				</div>
			</div>
		</footer>


	</div>
	
</div>



</body>

<cfif not isdefined("SESSION.USER_ID")>
	<cfinclude template="./incl/incl_scripts_light.cfm">
<cfelse>
	<cfinclude template="./incl/incl_scripts.cfm">
</cfif>

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

</html>