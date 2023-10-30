<cfif isdefined("id") AND len(id) eq "32">

	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM orders WHERE order_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#id#">
	</cfquery>

	<cfif get_id.recordcount neq "0">

		<cfdump var="#get_id#">
		
		
<!DOCTYPE html>

<cfsilent>
<cfif isdefined("id") AND isdefined("sh")>

	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_signature 
	WHERE signature_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
	AND signature_hash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sh#">
	</cfquery>

</cfif>
</cfsilent>

<html>
<head>	
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="../jquery/jsignature/libs/jSignature.min.js"></script>
	<script src="../jquery/jsignature/src/plugins/jSignature.UndoButton.js"></script> 
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">

	<div class="container">
	
		<img src="../../assets/img/logo_wefit_white.png" width="148" height="35" style="margin-top:8px; width:148px !important; height:35px !important">
	  
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
		</div>
	
		<div id="navbar" class="collapse navbar-collapse">
		
			<ul class="nav navbar-nav">
				
			</ul>
			
		</div>
		
	</div>
</nav>

<cfform action="wefit_work.cfm" id="sigform">		
<div class="container" style="margin-top:60px">

	<div class="row" style="margin-bottom:20px">

		<div class="col-md-8 col-md-offset-2">
						
			<table cellpadding="20" width="100%">
				
				<cfif isdefined("id") AND isdefined("sh") AND get_id.recordcount eq "1">
				<tr>
					<td colspan="2">
						<div class="alert alert-success" style="margin-top:50px">
						  <strong>Votre document a &eacute;t&eacute; correctement trait&eacute;</strong> Vous pouvez t&eacute;l&eacute;charger les &eacute;l&eacute;ments ci-dessous.
						</div>
					</td>					
				</tr>
				<cfelse>
				<tr>
					<td colspan="2">
						<h4>1. Veuillez prendre connaissance de votre attestation de fin de formation.</h4>
					</td>
				</tr>
				
				<!---<tr>
					<td colspan="2">
			
						<cfoutput>
						<iframe width="100%" height="500" src="../../tpl/aff_container.cfm?fn_aff=#fn_aff#&n_aff=#n_aff#&c_aff=#c_aff#&d_aff=#d_aff#&t_aff=#t_aff#<cfif isdefined("l_aff")>&l_aff=#l_aff#</cfif>&df_aff=#df_aff#&dt_aff=#dt_aff#&dateedit_aff=#dateedit_aff#&o_id=#o_id#"></iframe>
						</cfoutput>
				
					</td>
				</tr>--->
				
				<tr>
					<td colspan="2">
						<h4><strong>2. Veuillez signer <u>dans l'encadr&eacute; ci-dessous</u> puis cliquer sur le bouton "Enregistrer document".</strong></h4>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
<div id="content"><div id="signatureparent"><div id="signature" style="border:1px solid #000000"></div></div><div id="tools"></div></div>
					</td>
				</tr>				
				
				<!---<tr>
					<td colspan="2" align="center">
						<cfoutput>
						<input type="hidden" name="aff" id="aff" value="1">
						<input type="hidden" name="o_id" id="o_id" value="#o_id#">
						<input type="hidden" name="n_aff" id="n_aff" value="#n_aff#">
						<input type="hidden" name="t_aff" id="t_aff" value="#t_aff#">
						<input type="hidden" name="d_aff" id="d_aff" value="#d_aff#">
						<input type="hidden" name="c_aff" id="c_aff" value="#c_aff#">
						<cfif isdefined("l_aff")>
						<input type="hidden" name="l_aff" id="l_aff" value="#l_aff#">
						</cfif>
						<input type="hidden" name="df_aff" id="df_aff" value="#df_aff#">
						<input type="hidden" name="dt_aff" id="dt_aff" value="#dt_aff#">
						<input type="hidden" name="fn_aff" id="fn_aff" value="#fn_aff#">
						<input type="hidden" name="dateedit_aff" id="dateedit_aff" value="#dateedit_aff#">
						<input type="submit" value="Enregistrer document" class="btn btn-info" style="margin-top:20px">
						</cfoutput>
					</tr>
				</tr>--->
				
				</cfif>
				
				<input type="hidden" name="signature_base64" id="signature_base64" value="">
				
				<tr>
					<td colspan="2" align="center">
			
						<cfif isdefined("id") AND isdefined("sh") AND get_id.recordcount eq "1">
							<cfoutput><a href="./img/#get_id.signature_src#.pdf" class="btn btn-info">T&eacute;l&eacute;charger attestation</a></cfoutput>
							<cfif isdefined("sign")><cfoutput><a href="./img/#get_id.signature_src#.png" class="btn btn-info">T&eacute;l&eacute;charger signature</a></cfoutput></cfif>
						</cfif>
				
					</td>
				</tr>
				
			</table>

		</div>

	</div>

</div>
</cfform>

<script>
var $sigdiv = $("#signature").jSignature({'UndoButton':true});
$("#sigform").submit(function( event ) {
	var data = $sigdiv.jSignature('getData', 'default');
	$('#signature_base64').val(data);
});
</script>
	
	
</body>
</html>

		
	<cfelse>
	
		Dead-end !
		
	</cfif>

<cfelse>

Dead-end !

</cfif>

<cfabort>
