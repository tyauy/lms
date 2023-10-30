<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,4,5,7,8,9">
<cfinclude template="./incl/incl_secure.cfm">	

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "FAQ">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="card-deck d-flex">

				<div class="card border border-primary">
					
					<div class="card-body p-3 d-flex flex-column">
				
						<div align="center">
							<h5 class="d-inline text-primary">
								<i class="fa-thin fa-video-slash"></i> Problems with Wefit visio </h5><br>
						</div>
				
						<p class="mt-3">
			
				
						<br>
						</p>
				
						<div class="m-2 p-2 mt-auto" align="center">
							<button class="btn btn-lg btn-primary" id="bbb"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
						</div>
				
					</div>
				
				</div>
			
				<div class="card border border-info">
					
					<div class="card-body p-3 d-flex flex-column">
						
						<div align="center">
							<h5 class="d-inline text-info"><i class="fal fa-home fa-lg text-info"></i> Ma page d'accueil </h5><br>
						</div>
									
						<p class="mt-3">
						
						<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
						
						<br>
						</p>
									
						<div class="m-2 p-2 mt-auto" align="center">
							<button class="btn btn-lg btn-info btn_help" id="help_index"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
						</div>
						
					</div>
					
				</div>
				
				<div class="card border border-success">
					
					<div class="card-body p-3 d-flex flex-column">
						
						<div align="center">
							<h5 class="d-inline text-success"><i class="fal fa-calendar-alt fa-lg text-success"></i> Le système de réservation </h5><br>
						</div>
									
						<p class="mt-3">
						
						<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
						
						<br>
						</p>
									
						<div class="m-2 p-2 mt-auto" align="center">
							<button class="btn btn-lg btn-success btn_help" id="help_qdv"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
						</div>
						
					</div>
					
				</div>
				</div>

				<div class="card-deck mt-5">
					<div class="card border border-warning">
					
						<div class="card-body p-3 d-flex flex-column">
					
							<div align="center">
								<h5 class="d-inline text-warning"><i class="fal fa-laptop fa-lg text-warning"></i> Le e-Learning Essential</h5><br>
							</div>
					
							<p class="mt-3">
					
							<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
					
							<br>
							</p>
					
							<div class="m-2 p-2 mt-auto" align="center">
								<button class="btn btn-lg btn-warning btn_help" id="help_el"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
							</div>
					
						</div>
					
					</div>
					
					<div class="card border border-dark">
					
						<div class="card-body p-3 d-flex flex-column">
					
							<div align="center">
								<h5 class="d-inline text-danger"><i class="fal fa-home fa-lg text-danger"></i> Le glossaire WEFIT </h5><br>
							</div>
					
							<p class="mt-3">
					
							<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
					
							<br>
							</p>
					
							<div class="m-2 p-2 mt-auto" align="center">
								<button class="btn btn-lg btn-danger btn_help" id="modal_connect"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
							</div>
					
						</div>
					
					</div>
					<div class="card border border-primary">
					
						<div class="card-body p-3 d-flex flex-column">
					
							<div align="center">
								<h5 class="d-inline text-primary">
									<i class="fa-light fa-link text-primary"></i> Se connecter à un cours </h5><br>
							</div>
					
							<p class="mt-3">
					
							<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
					
							<br>
							</p>
					
							<div class="m-2 p-2 mt-auto" align="center">
								<button class="btn btn-lg btn-primary btn_help" id="help_connect"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
							</div>
					
						</div>
					
					</div>
				</div>
			
			</div>
			
	
				
		</div>
		
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	
	</div>
	  
</div>
<div class="modal fade" id="bbb-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	  <div class="modal-content">
		<div class="modal-header">
		  <h4 class="modal-title" id="myModalLabel">FAQ</h4>
		  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		
		<div class="modal-body">
			<div class="accordion" id="accordionExample">
				
				<div class="card">
				  <div class="card-header" id="headingTwo">
					<h5 class="mb-0">
					  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						I can't access the room, what can I do?
					  </button>
					</h5>
				  </div>
				  <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
					<div class="card-body">
						Here are a few things you can try:
						<ol>
						<li>If you're at <strong> work</strong>, try connecting from a <strong>personal device</strong> (e.g. your phone) that is not connected to your work's Wifi.</li>
						<li>If you're using a <strong>VPN </strong>to connect to the internet, try connecting to the Wefit visio room while <strong> disconnected</strong> from the VPN.</li>
						<li>If you're still having trouble, you may need to ask your <strong>IT department </strong>to open specific ports on the firewall in order to allow traffic to and from the Wefit visio server. The ports we use are: 
							<ul>
								<li>TCP/IP port 22 (for SSH)</li>
								<li>TCP/IP ports 80/443 (for HTTP/HTTPS)</li>
								<li>UDP ports in the range 16384 - 32768 (for FreeSWITCH/HTML5 RTP streams).</li>
							</ul>
							</li> 
							<li> Ask your work's IT department to set up a meeting with our <a href="mailto:efiliondonato@wefitgroup.com"> tech team</a>.</li>
						</ol>
					</div>
				  </div>
				</div>
				<div class="card">
				  <div class="card-header" id="headingThree">
					<h5 class="mb-0">
					  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						I'm in the room but my microphone isn't working
					  </button>
					</h5>
				  </div>
				  <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
					<div class="card-body">
					 When you enter the room, click on the microphone icon, <strong>do not</strong> select the headphone icon.
					 <image src="assets\img\bbb_faq.png"></image>
					</div>
				  </div>
				</div>
			  </div>
		
			
		<div class="modal-footer">
		  <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		 
		</div>
	  </div>
	</div>
</div>
  </div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	$('#bbb').click(function(e){
		$('#bbb-modal').modal('show');
	});
	


	$('#help_').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
				
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_help')#</cfoutput>");
		$('#modal_body_lg').load("modal_window_help.cfm?h="+idtemp, function() {});
		
	});

	
	$('#modal_').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
				
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_help')#</cfoutput>");
		$('#modal_body_lg').load("modal_window_help_connect.cfm?h="+idtemp, function() {});
		
	});
	
})
</script>

</body>
</html>