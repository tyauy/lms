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

			<div class="card-deck">
			
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
							<button class="btn btn-lg btn-danger btn_help" id="help_qdvqdv"><cfoutput>#obj_translater.get_translate('btn_help')#</cfoutput></button>
						</div>
						
					</div>
					
				</div>
				
			</div>
				
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	
	</div>
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	$('.btn_restart_quiz').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var q_id = idtemp[1];	

		

	})
	
})
</script>

</body>
</html>