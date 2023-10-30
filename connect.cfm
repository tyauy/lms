<!DOCTYPE html>

<cfparam name="back" default="2">

<cfinclude template="./incl/incl_lang.cfm">

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfinclude template="./incl/incl_head_light.cfm">
</head>

<style type="text/css">
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
.bck_img{
	background-image: url('./assets/img/back_connect_<cfoutput>#back#</cfoutput>.jpg');
	background-position:center center;
	background-size:cover;
	background-repeat:no-repeat;
}
h1,h2,h3,h4,h5,h6,p,td,button,a{
	font-family: 'Titillium Web', sans-serif;
}
.btn-danger {
    background-color: #CE1D37 !important;
    color: #FFFFFF;
}
.btn-danger:hover,
.btn-danger:focus,
.btn-danger:active,
.btn-danger.active,
.btn-danger:active:focus,
.btn-danger:active:hover,
.btn-danger.active:focus,
.btn-danger.active:hover {
    background-color: #c50202 !important;
}
.text-danger {
    color: #CE1D37 !important;
}
a.text-danger:hover {
    color: #c50202 !important;
}
.google-btn {
    display: flex;
    align-items: center;
    background-color: #4285F4;
    border-radius: 2px;
    box-shadow: 0 3px 4px 0 rgba(0, 0, 0, 0.25);
    border: none;
    color: white;
    width: 258px;
    height: 50px;
    cursor: pointer;
  }
  .google-btn span {
    font-family: 'Roboto', sans-serif;
    font-weight: bold;
    margin: auto;
  }
  .google-icon {
  background: url('https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg') no-repeat center, white;
  background-size: 70%;
  height: 40px;
  width: 40px;
  border-right: 1px solid #4285F4;
  margin-left: 5px;
  border-radius: 2px 0 0 2px;
}

</style>

<script>
function redirectToGoogleConnect() {
	window.location.href = './connect_google.cfm';
}
</script>


<body>
	
<div class="main">

	<div class="container-fluid bck_img">
		
		<div class="container">

			
				
					
			<div class="row d-flex justify-content-center align-items-center min-vh-100 py-6">
				<div class="col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
					
					<div class="card" style="border-top: 3px solid #CB2039;">
						<div class="card-body p-3 p-sm-4">
								
							<div align="center">
								<img src="./assets/img/logo_wefit_solo_150.png" alt="" width="80" />
								<h4 class="font-weight-light m-0"><cfoutput>#obj_translater.get_translate('title_page_connect')#</cfoutput></h4>
								<h5>Connect as <span class="text-danger font-weight-bold">you</span> are</h5>
							</div>

							<cfif isdefined("error")>
								<div class="row">
									<div class="col-md-12">
									<cfif error eq "1">									
										<div class="alert alert-danger" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_wrong_connect')#</cfoutput>
										</div>
									<cfelseif error eq "2">
										<div class="alert alert-danger" role="alert">
											<strong>Attention ! </strong> Votre session n'est plus active. Veuillez vous connecter &agrave; nouveau.
										</div>
									<cfelseif error eq "3">
										<div class="alert alert-danger" role="alert">
											<strong>Bonjour,</strong> veuillez entrer vos identifiants pour vous connecter &agrave; la plateforme.
										</div>
									<cfelseif error eq "4">
										<div class="alert alert-danger" role="alert">
											<strong>Attention !</strong> nous n'avons trouv&eacute; personne chez nous qui utilise cette adresse email...
										</div>
									<cfelseif error eq "5">
										<div class="alert alert-danger" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_wrong_link')#</cfoutput>
										</div>
									<cfelseif error eq "6">
										<div class="alert alert-danger" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_inactive_learner')#</cfoutput>
										</div>
									</cfif>	
									</div>
								</div>
							</cfif>	
							<cfif isdefined("k")>
								<div class="row">
									<div class="col-md-12">
									<cfif k eq "1">									
										<div class="alert alert-success" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_reset_pwd')#</cfoutput>
										</div>
									<cfelseif k eq "2">									
										<div class="alert alert-success" role="alert">
											<cfoutput>#obj_translater.get_translate('alert_ready')#</cfoutput>
										</div>
									</cfif>	
									</div>
								</div>
							</cfif>

							<div class="row justify-content-center">
								<div class="col-sm-12 col-md-8">
									<cfif not findnocase("connect.cfm",SCRIPT_NAME) AND not findnocase("connect_out.cfm",SCRIPT_NAME)>
										<form id="form_connect" method="post" action="<cfoutput>#SESSION.BO_CONNECT_URL##SCRIPT_NAME##CGI.QUERY_STRING neq "" ? "?"&CGI.QUERY_STRING : ""#</cfoutput>"> 
									<cfelse>
										<form id="form_connect" method="post" action="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>"> 
									</cfif>
									<div class="mb-3 ">
										<input type="text" id="user_name" name="user_name" placeholder="<cfoutput>#obj_translater.get_translate('table_th_email')#</cfoutput>" class="form-control">
									</div>
									<div class="mb-3">
										<input type="password" id="user_password" name="user_password" placeholder="<cfoutput>#obj_translater.get_translate('table_th_password')#</cfoutput>" class="form-control">
									</div>
									<div class="mb-3">
										<button id="form_submit" class="btn btn-lg btn-danger d-block w-100 mt-3" type="submit"><cfoutput>#obj_translater.get_translate('btn_connect')#</cfoutput></button>
									</div>
									</form>
								</div>
							</div>
							
							<div class="row justify-content-center">
								<div class="col-sm-12 col-md-8">
								<a href="#" class="btn_reinit_mdp pull-right text-danger">[<cfoutput>#obj_translater.get_translate('card_forgotten_password')#</cfoutput>]</a>
								</div>
							</div>

							
							<div class="row justify-content-center">
								<div class="col-sm-12 col-md-8">
								<hr>
								<button onclick="redirectToGoogleConnect()" class="google-btn">
									<div class="google-icon"></div>
									<span>Sign in with Google</span>
								</button>
								</div>
							</div>

							<!--- <div class="row justify-content-center">
								<div class="col-sm-12 col-md-8">
									<div class="bsk-container">
										<button class="bsk-btn bsk-btn-default">
										  <object type="image/svg+xml" data="https://s3-eu-west-1.amazonaws.com/cdn-testing.web.bas.ac.uk/scratch/bas-style-kit/ms-pictogram/ms-pictogram.svg" class="x-icon"></object> 
										  Sign in with Microsoft</button>
									  </div>
								</div>
							</div> --->
							<!---
							<div align="center">
								<form id="form_google_connect" method="post" action="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/index.cfm"> 
									<input type="hidden" name="gggo" value="YES">		
									<button type="submit" class="btn btn-default btn-primary">Google Connect</button>
								</form>
							</div> --->

						</div>
					</div>
				</div>
			</div>
		</div>

	
	</div>

</div>

<footer style="position: fixed; bottom: 0; width: 100%; text-align: center; background-color: rgba(255, 255, 255, 0.5);">
	<div class="container p-2 text-dark">
		<a role="button" class="text-dark btn_show_charter" class="text-muted"><cfoutput>#obj_translater.get_translate('card_use')#</cfoutput></a>
		|
		<a role="button" class="text-dark btn_show_cgu" class="text-muted"><cfoutput>#obj_translater.get_translate('card_policy')#</cfoutput></a>
		|
		<a role="button" class="text-dark btn_contact_wefit" class="text-muted"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
	</div>
</footer>

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script src="./assets/js/core/jquery.min.js"></script>	

<script src="./assets/js/core/bootstrap.min.js"></script>

<script>
$(document).ready(function() {
	
	$('.btn_reinit_mdp').click(function(event) {	
		event.preventDefault();
		$('#window_item_sm').modal({keyboard: true});
		$('#modal_title_sm').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_title_mdp_forgotten'))#</cfoutput>");
		$('#modal_body_sm').load("_modal_window_mdp_reset.cfm?reinit=1", function() {});
	});
	
	$('.btn_show_cgu').click(function(event) {	
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_cgu'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_cgu.cfm?view=display_cgu", function() {});
	});

	$('.btn_show_charter').click(function(event) {	
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_charter'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_cgu.cfm?view=display_charter", function() {});
	});

	$('.btn_contact_wefit').click(function(event) {	
		event.preventDefault();
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#encodeforJavascript(obj_translater.get_translate('js_modal_contact_wefit'))#</cfoutput>");
		$('#modal_body_lg').load("modal_window_contact.cfm?view=l", function() {});
	});



	/********************** FOR MODAL CLOSING *********************/
	$("#window_item_sm").on('hidden.bs.modal', function () {
		$('#modal_body_sm').empty();
		$('#modal_title_sm').empty();
	});
	
	$("#window_item_lg").on('hidden.bs.modal', function () {
		$('#modal_body_lg').empty();
		$('#modal_title_lg').empty();
	});

	$("#window_item_xl").on('hidden.bs.modal', function () {
		$('#modal_body_xl').empty();
		$('#modal_title_xl').empty();
	});
	
	


});
</script>

</body>

</html>