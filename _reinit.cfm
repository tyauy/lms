<cfif isdefined("u_id") AND isdefined("phsh")>

<cfquery name="get_email" datasource="#SESSION.BDDSOURCE#">
SELECT u.user_id, u.user_lang FROM user u
INNER JOIN user_temp_mdp m ON m.user_id = u.user_id
WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
AND m.mdp_temp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#phsh#">
AND m.mdp_date > #dateadd('d','-1',now())#
</cfquery>

<cfswitch expression="#get_email.user_lang#">
	<cfcase value="fr"><cfset SESSION.LANG = "1"><cfset SESSION.LANG_CODE = "fr"><cfset lang_doc = "fr"></cfcase>
	<cfcase value="en"><cfset SESSION.LANG = "2"><cfset SESSION.LANG_CODE = "en"><cfset lang_doc = "en"></cfcase>
	<cfcase value="de"><cfset SESSION.LANG = "3"><cfset SESSION.LANG_CODE = "de"><cfset lang_doc = "de"></cfcase>
	<cfcase value="es"><cfset SESSION.LANG = "4"><cfset SESSION.LANG_CODE = "es"><cfset lang_doc = "es"></cfcase>
	<cfcase value="it"><cfset SESSION.LANG = "5"><cfset SESSION.LANG_CODE = "it"><cfset lang_doc = "it"></cfcase>
</cfswitch>

<cfif get_email.recordcount eq "0">

	<cflocation addtoken="no" url="connect.cfm?error=5">

<cfelse>

<!DOCTYPE html>

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
      
		<cfset title_page = "">
		<cfinclude template="./incl/incl_nav.cfm">

		<cfoutput>
		<div class="content">
	  
			<div class="row justify-content-center">

				<div class="col-md-4 col-sm-12">
				
					<div class="card">
						<div class="card-header">
							<h5 class="card-title"><img src="#SESSION.BO_ROOT_URL#/assets/img/logo_wefit_100.jpg" width="30" align="left" style="margin-right:15px">#obj_translater.get_translate('card_title_reinit')#</h5>
						</div>
						<div class="card-body ">

							<form id="form_pw" method="post" action="#SESSION.BO_ROOT_URL#/_updater_mdp.cfm"> 
							<table class="table table-borderless" align="center" style="width:100%; border:0px;"> 
								<tr> 	
									<td>
										#obj_translater.get_translate('card_text_reinit')#
									</td>
								</tr> 
								<tr> 	
									<td>
										<input type="password" name="user_pwd" id="user_pwd" class="form-control" required="yes" minlength="6" placeholder="#obj_translater.get_translate('form_placeholder_new_password')#">
									</td>
								</tr> 
								<tr> 
									<td>
										<input type="password" name="user_pwd2" id="user_pwd2" class="form-control" required="yes" minlength="6" placeholder="#obj_translater.get_translate('form_placeholder_new_password2')#">
									</td>
								</tr> 
								<tr>
									<td align="center">
										<button id="form_submit" class="btn btn-default btn-primary" type="submit">#obj_translater.get_translate('btn_reset')#</button>
									</td>
								</tr>
								<input type="hidden" name="valid_maj" value="1">
								<input type="hidden" name="u_id" value="#u_id#">
								<input type="hidden" name="phsh" value="#phsh#">
							</table> 
							</form>
									
						</div>
					</div>
					

				</div>
			</div>
	
		</div>
		</cfoutput>
		
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
$( document ).ready(function() {
	$("#form_pw").submit(function( event ) {
	if($("#user_pwd").val() != $("#user_pwd2").val())
	{
	alert("Les mots de passe ne correspondent pas..." );
	event.preventDefault();
	
	}
	});
})
</script>

</html>

</cfif>


</cfif>

