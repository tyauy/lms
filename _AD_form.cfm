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

	<script type="text/javascript">
		(function() {
			window.sib = {
				equeue: [],
				client_key: "zaa6jgfqi3qw8gxoixgqy94g"
			};
			/* OPTIONAL: email for identify request*/
			window.sib.email_id = "<cfoutput>#SESSION.USER_EMAIL#</cfoutput>";
			window.sendinblue = {};
			for (var j = ['track', 'identify', 'trackLink', 'page'], i = 0; i < j.length; i++) {
			(function(k) {
				window.sendinblue[k] = function() {
					var arg = Array.prototype.slice.call(arguments);
					(window.sib[k] || function() {
							var t = {};
							t[k] = arg;
							window.sib.equeue.push(t);
						})(arg[0], arg[1], arg[2], arg[3]);
					};
				})(j[i]);
			}
			var n = document.createElement("script"),
				i = document.getElementsByTagName("script")[0];
			n.type = "text/javascript", n.id = "sendinblue-js", n.async = !0, n.src = "https://sibautomation.com/sa.js?key=" + window.sib.client_key, i.parentNode.insertBefore(n, i), window.sendinblue.page();
		})();
	</script>
	<script type="text/javascript">
		(function() {
		  window.sib = { equeue: [], client_key: "zaa6jgfqi3qw8gxoixgqy94g" };
		  /* OPTIONAL: email to identify request*/
		  window.sib.email_id = "<cfoutput>#SESSION.USER_EMAIL#</cfoutput>";
		  /* OPTIONAL: to hide the chat on your script uncomment this line (0 = chat hidden; 1 = display chat) */
		  // window.sib.display_chat = 0;
		  // window.sib.display_logo = 0;
		  /* OPTIONAL: to overwrite the default welcome message uncomment this line*/
		  // window.sib.custom_welcome_message = 'Hello, how can we help you?';
		  /* OPTIONAL: to overwrite the default offline message uncomment this line*/
		  // window.sib.custom_offline_message = 'We are currently offline. In order to answer you, please indicate your email in your messages.';
		  window.sendinblue = {}; for (var j = ['track', 'identify', 'trackLink', 'page'], i = 0; i < j.length; i++) { (function(k) { window.sendinblue[k] = function(){ var arg = Array.prototype.slice.call(arguments); (window.sib[k] || function() { var t = {}; t[k] = arg; window.sib.equeue.push(t);})(arg[0], arg[1], arg[2]);};})(j[i]);}var n = document.createElement("script"),i = document.getElementsByTagName("script")[0]; n.type = "text/javascript", n.id = "sendinblue-js", n.async = !0, n.src = "https://sibautomation.com/sa.js?key=" + window.sib.client_key, i.parentNode.insertBefore(n, i), window.sendinblue.page();
		})();
	</script>
</head>

<body>
<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formulaire WEFIT">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<div class="row">

				<div class="col-md-6">
					<cfoutput>#SESSION.USER_EMAIL#</cfoutput>



					<iframe src="https://docs.google.com/forms/d/e/1FAIpQLScdcxCibChieb-TYjsXH6WSJU4tJSdX8Il1xNyvFXfPlqAARQ/viewform?embedded=true" width="100%" height="1000" frameborder="0" marginheight="0" marginwidth="0">Chargement…</iframe>				
					

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

<!-------- MODAL SKELETON ------------>
<div id="window_item_sm" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_sm" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_sm" class="modal-body">
			
			</div>
        </div>
    </div>
</div>


</body>

<cfif not isdefined("SESSION.USER_ID")>
	<cfinclude template="./incl/incl_scripts_light.cfm">
<cfelse>
	<cfinclude template="./incl/incl_scripts.cfm">
</cfif>

<script>

$(document).ready(function() {
	

	$('.btn_reinit_mdp').click(function(event) {	
		event.preventDefault();
		$('#window_item_sm').modal({keyboard: true});
		$('#modal_title_sm').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_forgotten')#</cfoutput>");
		$('#modal_body_sm').load("_modal_window_mdp_reset.cfm?reinit=1", function() {});

	});
	
});
</script>

</html>