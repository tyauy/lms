<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,7,8,9">
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
      
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<cfoutput>
		<div class="content">

			<cfinclude template="./incl/incl_nav_tuto.cfm">
	  
			<div class="row mt-3">
				
				<div class="col-md-3">
				
					<div class="card border-top border-info">

						<div class="card-body">
	
							<cfif fileexists("#SESSION.BO_ROOT#/assets/video/tutoriel_1_#SESSION.LANG_CODE#.mp4")>
							<video controls width="100%">
							<source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_1_#SESSION.LANG_CODE#.mp4" type="video/mp4">
							</video>
							</cfif>
							<!--- <div class="video-container"> --->
							<!--- <iframe src="https://player.vimeo.com/video/359556690" width="100%" height="250" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe> --->
							<!--- </div> --->
									
							<h6><cfoutput>#obj_translater.get_translate('title_tuto_1')#</cfoutput></h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card border-top border-info">

						<div class="card-body">

							<!--- <div class="video-container"> --->
							<!--- <iframe src="https://player.vimeo.com/video/361785159" width="100%" height="250" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe> --->
							<!--- </div> --->
									
								
							<cfif fileexists("#SESSION.BO_ROOT#/assets/video/tutoriel_2_#SESSION.LANG_CODE#.mp4")>
							<video controls width="100%">
							<source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_2_#SESSION.LANG_CODE#.mp4" type="video/mp4">
							</video>
							</cfif>
							
							<h6><cfoutput>#obj_translater.get_translate('title_tuto_2')#</cfoutput></h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card border-top border-info">

						<div class="card-body">

							<!--- <div class="video-container"> --->
							<!--- <iframe src="https://player.vimeo.com/video/362081738" width="100%" height="250" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe> --->
							<!--- </div> --->
								
							<cfif fileexists("#SESSION.BO_ROOT#/assets/video/tutoriel_3_#SESSION.LANG_CODE#.mp4")>
							<video controls width="100%">
							<source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_3_#SESSION.LANG_CODE#.mp4" type="video/mp4">
							</video>
							</cfif>
							
							<h6><cfoutput>#obj_translater.get_translate('title_tuto_3')#</cfoutput></h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card border-top border-info">

						<div class="card-body">

							<!--- <div class="video-container"> --->
							<!--- <iframe src="https://player.vimeo.com/video/306134372" width="100%" height="250" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> --->
							<!--- </div> --->
								
							<cfif fileexists("#SESSION.BO_ROOT#/assets/video/tutoriel_booking_#SESSION.LANG_CODE#.mp4")>
							<video controls width="100%">
							<source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_booking_#SESSION.LANG_CODE#.mp4" type="video/mp4">
							</video>
							</cfif>
							
							<h6><cfoutput>#obj_translater.get_translate('title_tuto_booking')#</cfoutput></h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card border-top border-info">

						<div class="card-body">

							<!--- <div class="video-container"> --->
							<!--- <iframe src="https://player.vimeo.com/video/306134372" width="100%" height="250" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> --->
							<!--- </div> --->
								
							<cfif fileexists("#SESSION.BO_ROOT#/assets/video/tutoriel_elearning_#SESSION.LANG_CODE#.mp4")>
							<video controls width="100%">
							<source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_elearning_#SESSION.LANG_CODE#.mp4" type="video/mp4">
							</video>
							</cfif>
							
							<h6><cfoutput>#obj_translater.get_translate('title_tuto_elearning')#</cfoutput></h6>

						</div>

					</div>

				</div>
				
			</div>
			
			
			<!---
			

			<div class="row">

				<div class="col-md-3">
				
					<div class="card">

						<div class="card-body">

							<div class="video-container">
							<iframe width="100%" height="250" src="https://www.youtube.com/embed/Lfslr324RYs" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
							</div>
									
							<h6>La m&eacute;thode WEFIT</h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card">

						<div class="card-body">

							<div class="video-container">
							<iframe width="100%" height="250" src="https://www.youtube.com/embed/-IHeCcck2l4?list=PL-r1TTPMaToyxCZBoVUrmq3d9SK7y6hj8" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
							</div>
									
							<h6>D&eacute;couvrez le WEFIT Gum #1</h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card">

						<div class="card-body">

							<div class="video-container">
							<iframe width="100%" height="250" src="https://www.youtube.com/embed/9Botq_yTM_U?list=PL-r1TTPMaToyxCZBoVUrmq3d9SK7y6hj8" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
							</div>
									
							<h6>D&eacute;couvrez le WEFIT Gum #2</h6>

						</div>

					</div>

				</div>
				
				<div class="col-md-3">
				
					<div class="card">

						<div class="card-body">

							<div class="video-container">
							<iframe width="100%" height="250" src="https://www.youtube.com/embed/YWyzLpMnINg" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
							</div>
									
							<h6>D&eacute;couvrez le WEFIT Gum #3</h6>

						</div>

					</div>

				</div>
				
				
			</div>
			
			
			
			--->
			
			

			
		</div>
		</cfoutput>
		
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

</body>
</html>