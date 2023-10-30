<!DOCTYPE html>

<cfsilent>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "INVOICE VIEW">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">
			<!--- <cfdump var="#cgi#"> --->

			<div class="row" style="margin-top:10px">
			
				<div class="col-md-12">
					<div class="card">
						<div class="card-body">
                            <div align="center">
                                <cfoutput>
                                <button class="btn btn-lg btn-info return_invoice"><i class="fal fa-backward"></i> Back</button>
                                <button class="btn btn-lg btn-info validate_invoice">Continue <i class="fal fa-forward"></i></button>
                                </cfoutput>
                            </div>
							<cfoutput>
							<iframe id="frame" src="./tpl/invoice_container.cfm?i_id=#i_id#&user_lang=#user_lang#" width="100%" height="800"></iframe>
                            </cfoutput>
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
$(document).ready(function() {
	$('.return_invoice').click(function(event) {	
		event.preventDefault();		
		history.back()
		// let _url = "<cfoutput>#cgi.HTTP_REFERER#</cfoutput>";
		// if (_url.indexOf("?") == "-1") {
		// 	_url += "?i_id=<cfoutput>#i_id#</cfoutput>"
		// } else {
		// 	_url += "&i_id=<cfoutput>#i_id#</cfoutput>"
		// }

		// document.location.href=_url;
	})

	var save = 0;

	$('.validate_invoice').click(function(event) {	
		event.preventDefault();		
		// history.back()
		save = 1;
		$("#frame").attr("src", "<cfoutput>./tpl/invoice_container.cfm?i_id=#i_id#&user_lang=#user_lang#&save=1</cfoutput>");
	})

	$('#frame').on("load", function() {
		if (save) {
			let _url = "<cfoutput>#cgi.HTTP_REFERER#</cfoutput>";
			if (_url.indexOf("?") == "-1") {
				_url += "?i_id=<cfoutput>#i_id#</cfoutput>&k=4"
			} else {
				_url += "&i_id=<cfoutput>#i_id#</cfoutput>&k=4"
			}

			document.location.href=_url;
		}
	});

})
</script>

</body>
</html>