<!DOCTYPE html>

<cfsilent>

<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset SESSION.TP_ID = 45403>
<cfparam name="step" default="0">

<cfquery name="get_tpformula" datasource="#SESSION.BDDSOURCE#">
SELECT tp_formula_id, tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tp_formula_desc_#SESSION.LANG_CODE# as tp_formula_desc, tp_formula_css, tp_formula_img, tp_formula_nbcourse FROM lms_tpformula
</cfquery>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_alias, level_name FROM lms_level WHERE level_id IN (1,2,3,4,5) ORDER BY level_id 
</cfquery>

<!--- <cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 1
</cfquery>

<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 2
</cfquery>

<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 3
</cfquery> --->

<cfif step eq "2_2_1">
<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 3
</cfquery>
</cfif>


<cfif step eq "1_1_1_3">
<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 5
</cfquery>
</cfif>

<cfif step eq "1_1_1_2">
<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 4
</cfquery>
</cfif>




<cfset u_id = SESSION.USER_ID>
<cfset t_id = 45403>


<cfset progress_completed = 0>
<cfset progress_total = 0>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#",l_by="yes")>
<cfoutput query="get_session" group="session_id">
	<cfset progress_total += 1>
	<cfif status_id neq "">
		<cfset progress_completed += 1>
	</cfif>

</cfoutput>


</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
<style>

.card_module:hover {
	/*  */
	-webkit-filter: grayscale(0%) !important;
	filter: grayscale(0%) !important;
	opacity:1;
	transition:0.2s ease-in-out;
	box-shadow:0 6px 10px -4px rgb(0 0 0 / 15%) !important;
}
.card_module {
	/* -webkit-filter: grayscale(30%) !important;
	filter: grayscale(30%) !important; */
	opacity:0.9;
	/* border-radius: 50% !important; */
	/* box-shadow:0 6px 10px -4px rgb(0 0 0 / 15%) !important; */
	cursor:pointer;

}
.card_module a {
	color:#252422 !important;
	text-decoration: none !important;
	padding: 0 !important;
	border: none !important;
	white-space: normal !important;

}
</style>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Tests de profil d'apprentissage">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif step eq "0">
				<cfset progress= 0>
				<cfset return_step= 0>

			<cfelseif step eq "1" OR step eq "2">
				<cfset return_step= 0>
				<cfset progress= 15>
			<cfelseif step eq "3">
				<cfset return_step= "3">
				<cfset progress= 50>

			<cfelseif step eq "1_2">
				<cfset return_step= "1">
				<cfset progress= 25>
			<cfelseif step eq "2_2">
				<cfset return_step= "2">
				<cfset progress= 25>
			<cfelseif step eq "3_2">
				<cfset return_step= "3">
				<cfset progress= 75>


			<cfelseif step eq "1_1">
				<cfset return_step= "1">
				<cfset progress= 25>
			<cfelseif step eq "2_1">
				<cfset return_step= "2">
				<cfset progress= 25>

			<cfelseif step eq "1_1_1" OR step eq "1_2_1">
				<cfset return_step= "1_1">
				<cfset progress= 40>

			<cfelseif step eq "2_1_1" OR step eq "2_2_1">
				<cfset return_step= "2_1">
				<cfset progress= 40>

			<cfelseif step eq "1_1_1_1">
				<cfset return_step= "1_1_1">
				<cfset progress= 50>
			<cfelseif step eq "1_1_1_2">
				<cfset return_step= "1_1_1">
				<cfset progress= 50>
			<cfelseif step eq "1_1_1_3">
				<cfset return_step= "1_1_1">
				<cfset progress= 50>


			<cfelseif step eq "2_2_1_1">
				<cfset return_step= "2_1_1">
				<cfset progress= 50>



			<cfelseif step eq "1_1_1_1_1">
				<cfset return_step= "1_1_1_1">
				<cfset progress= 70>
			<cfelseif step eq "1_1_1_2_1">
				<cfset return_step= "1_1_1_2">
				<cfset progress= 70>
			<cfelseif step eq "1_1_1_3_1">
				<cfset return_step= "1_1_1_3">
				<cfset progress= 70>



			<cfelseif step eq "2_1_1_1">
				<cfset return_step= "2_1_1">
				<cfset progress= 60>




			<cfelseif step eq "1_1_1_1_1_1">
				<cfset return_step= "1_1_1_1_1">
				<cfset progress= 80>
			<cfelseif step eq "1_1_1_2_1_1">
				<cfset return_step= "1_1_1_2_1">
				<cfset progress= 80>
			<cfelseif step eq "1_1_1_3_1_1">
				<cfset return_step= "1_1_1_3_1">
				<cfset progress= 80>
			<cfelseif step eq "2_1_1_1_1_1">
				<cfset return_step= "2_1_1_1_1_1">
				<cfset progress= 80>


			<cfelseif step eq "1_1_1_2_1_1_1">
				<cfset return_step= "1_1_1_2_1_1">
				<cfset progress= 80>



			<cfelseif step eq "1_1_1_2_1_1_1_1">
				<cfset return_step= "1_1_1_2_1_1_1">
				<cfset progress= 100>





				



			</cfif>

			<cfif step neq "0">
				<a class="float-left text-dark" href="?step=<cfoutput>#return_step#</cfoutput>" style="text-transform:none !important; vertical-align:middle"><i class="fa-regular fa-2x fa-chevron-left text-red"></i> <span class="mb-3">RETOUR</span></a>
			</cfif>
			
			<div class="row justify-content-center">

				<div class="col-lg-3 col-md-4 col-sm-6">

					<div class="progress border border-red">
						<div class="progress-bar bg-red progress-bar-striped" role="progressbar" style="width: <cfoutput>#progress#</cfoutput>%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>

				</div>
			</div>
			
            <cfif step eq "0">

				

				<h4 align="center" class="pt-4 mb-5">Pour commencer, <strong class="red">pourquoi</strong> êtes vous là ?</h4>
				<!--- <hr class="bg-danger"> --->
				
				<div class="row justify-content-center">

					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="card card_module">
							<a class="btn_action" id="act-1">
							<img class="card-img-top" src="./assets/img/orientation_1.jpg">
							<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
									
								<h6 class="text-center mt-2" style="font-size:20px !important">POUR LE TRAVAIL</h6>

								<!--- <h5 class="text-center mt-2">Pour le travail</h5> --->
								<p align="center">
									Se perfectionner en Anglais dans un secteur en particulier
								</p>
								<!--- <div align="center" class="mt-auto">
									<a class="btn btn-info">Choisir cette orientation</a>
								</div> --->
								
							</div>
							</a>
						</div>
					</div>

					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="card card_module">
							<a class="btn_action" id="act-2">
							<img class="card-img-top" src="./assets/img/orientation_2.jpg">
							<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
											
								<h6 class="text-center mt-2" style="font-size:20px !important">POUR LE PLAISIR</h6>

								<!--- <h5 class="text-center mt-2">Pour le plaisir</h5> --->
								<p align="center">
									S'améliorer au quotidien pour discuter et voyager par exemple
								
								</p>
								<!--- <div align="center" class="mt-auto">
									<a class="btn btn-secondary" href="_AD_elearning_dashboard.cfm?orientation=business">Choisir cette orientation</a>
								</div> --->
								
							</div>
							</a>
						</div>
					</div>

					<div class="col-lg-3 col-md-4 col-sm-6">
						<div class="card card_module">
							<a class="btn_action" id="act-3">
							<img class="card-img-top" src="./assets/img/orientation_3.jpg">
							<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
											
								<h6 class="text-center mt-2" style="font-size:20px !important">POUR UNE CERTIF</h6>

								<!--- <h5 class="text-center mt-2">Préparation Certification</h5> --->
								<p align="center">
								TOEIC, Linguaskill, Bright, LTE.. Parcours personnalisés pour optimiser votre socre
								</p>
								<!--- <div align="center" class="mt-auto">
									<a class="btn btn-warning" href="?step=certif">Choisir cette orientation</a>
								</div> --->
								
							</div>
							</a>
						</div>
					</div>	

				</div>


						


				<cfelseif step eq "1" OR step eq "2">


					<h4 align="center" class="pt-4 mb-5">Très bien, c'est noté ! <strong class="red">de combien de temps</strong> on dispose ?</h4>
				
					<div class="row justify-content-center">

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_1</cfoutput>">
									<img class="card-img-top" src="./assets/img/method_discover.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">JE PRENDS LE TEMPS</h6>
										<p align="center">
										On passe les tests, on découvre les différents types de ressources, on construit son parcours...
										</p>
										<!--- <div align="center" class="mt-auto">
											<a class="btn btn-info">Choisir cette orientation</a>
										</div> --->
										
									</div>
								</a>
							</div>
						</div>
	
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_2</cfoutput>">
									<img class="card-img-top" src="./assets/img/method_speed.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">ON SE LA FAIT RAPIDE !</h6>
										<p align="center">
										Allez hop, on grille les feux ! Quelques questions, un choix de parcours et de formateur, et on attaque...
										</p>
										<!--- <div align="center" class="mt-auto">
											<a class="btn btn-secondary" href="_AD_elearning_dashboard.cfm?orientation=business">Choisir cette orientation</a>
										</div> --->
										
									</div>
								</a>
							</div>
						</div>
	
	
					</div>

				<cfelseif step eq "3">


					<h4 align="center" class="pt-4 mb-5">Quelle <strong class="red">certification</strong> avez-vous prévu de passer ?</h4>
				
					<div class="row justify-content-center">

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_2</cfoutput>">
									<img class="card-img-top" width="100%" src="https://formation.wefitgroup.com/assets/img_product/3.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">TOEIC</h6>
										<p align="center">
										Exercices de révision et tests blancs <br>+<br> Accès illimité à nos classes virtuelles
										</p>
										
									</div>
								</a>
							</div>
						</div>
	
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_2</cfoutput>">
									<img class="card-img-top" width="100%" src="https://formation.wefitgroup.com/assets/img_product/1.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">LINGUASKILL</h6>
										<p align="center">
											Exercices de révision, entrainement à la compréhension orale & écrite 
											<br>+<br> Accès illimité à nos classes virtuelles
										</p>
										
									</div>
								</a>
							</div>
						</div>
	
	
					</div>






				<cfelseif step eq "1_2" OR step eq "2_2" OR step eq "3_2">

					<h4 align="center" class="pt-4 mb-5">Il nous faut quand même une indication sur <strong class="red">votre niveau !</strong></h4>


					<div class="row justify-content-center">

						<cfoutput query="get_level">
						<div class="col-lg-2 col-md-4 col-sm-6">
							<div class="card card_module">
								<cfif step eq "3_2">
									<a href="_AD_elearning_dashboard.cfm">
								<cfelse>
									<a class="btn_action" id="act-#step#_1">
								</cfif>
									<img class="card-img-top" src="./assets/img_level/#level_alias#.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:150px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">#level_alias#<br>#level_name#</h6>
										
										
									</div>
								</a>
							</div>
						</div>
						</cfoutput>

					</div>

					

				<cfelseif step eq "1_1" OR step eq "2_1">


					<h4 align="center" class="pt-4 mb-5">Allez, <strong class="red">au travail !</strong> je détermine :</h4>

					<div class="row justify-content-center">

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_1</cfoutput>">
									<img class="card-img-top" src="./assets/img/qpt_en.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">MON NIVEAU</h6>
										<p align="center">
										On teste la compréhension écrite et orale, et on obtient son niveau sur l'échelle officielle (de A1 à C2) 
										</p>
										<!--- <cfoutput>
										<h6><i class="fal fa-clock"></i> #obj_translater.get_translate('timing_zero_minute')#</h6>
										#obj_translater.get_translate('text_pt_later')#<br>
										<a href="##" class="btn btn-outline-red p-2 m-2 cursored btn_skip_qpt" <cfif isdefined("SESSION.STEPS") AND listfind(SESSION.STEPS,"2")><cfelse>disabled</cfif>>
											<i class="fal fa-forward"></i> #obj_translater.get_translate('btn_later')#
										</a>
										</cfoutput> --->
										
									</div>
								</a>
							</div>
						</div>

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_1</cfoutput>">
									<img class="card-img-top" src="./assets/img/lst.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
													
										<h6 class="text-center mt-2" style="font-size:20px !important">MON PROFIL D'APPRENTISSAGE</h6>
										<!--- <p align="center">
											<cfoutput>#obj_translater.get_translate('js_modal_title_lst')#</cfoutput></p> --->
										<cfoutput>
											#obj_translater.get_translate_complex('more_lst_explain')#
											<!--- <br><br>
											
											<h6>#obj_translater.get_translate('more_lst_list_profil')#</h6>
											<ul>
												<li class="float-left">#obj_translater.get_translate('profile_independant')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_social')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_dynamic')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_applied')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_conceptual')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_scholastic')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_creative')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_analytic')#</li>
												<li class="float-left ml-4">#obj_translater.get_translate('profile_neutral')#</li>
											</ul> --->
											</cfoutput>
										
									</div>
								</a>
							</div>
						</div>

					</div>











				

				<cfelseif step eq "1_1_1">

					<h4 align="center" class="pt-4 mb-5">Quel est votre <strong class="red">objectif professionnel</strong> ?</h4>

					<div class="row justify-content-center">

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_1_1</cfoutput>">
									<img class="card-img-top" src="./assets/img/orientation_1_1.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
										<h6 class="text-center mt-2" style="font-size:20px !important">NIVEAU</h6>
										<p align="center">
											Je veux améliorer mon niveau global d’anglais professionel
										</p>
									</div>
								</a>
							</div>
						</div>

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_2</cfoutput>">
									<img class="card-img-top" src="./assets/img/orientation_1_4.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
										<h6 class="text-center mt-2" style="font-size:20px !important">COMP&Eacute;TENCES</h6>
										<p align="center">
											Je veux savoir réaliser les tâches de mon quotidien professionnel en anglais
										</p>
									</div>
								</a>
							</div>
						</div>

						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="<cfoutput>act-#step#_3</cfoutput>">
									<img class="card-img-top" src="./assets/img/orientation_1_3.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:200px">
										<h6 class="text-center mt-2" style="font-size:20px !important">JOB</h6>
										<p align="center">
											Je veux renforcer mes compétences en anglais spécifiques à mon métier
										</p>
									</div>
								</a>
							</div>
						</div>


					</div>


				<cfelseif step eq "1_1_1_2">

					<h4 align="center" class="pt-4 mb-5">Ok, on se spécialise <strong class="red">sur quelles compétences</strong> ?</h4>

					<div class="row justify-content-center">

						<div class="col-lg-8">

							<div class="row justify-content-center">

								<cfoutput query="get_keywords">
									<div class="col-lg-3 col-md-2 col-sm-3">
										<div class="card card_module">
											<a class="btn_action" id="act-#step#_1">
												<img class="card-img-top" src="./assets/img_keyword/#keyword_id#.jpg">
												<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:100px">
													<h6 class="text-center mt-2" style="font-size:20px !important">#keyword_name#</h6>
													<p align="center">

													</p>
												</div>
											</a>
										</div>
									</div>
								</cfoutput>

							</div>

						</div>

					</div>

				<cfelseif step eq "1_1_1_3">

					<h4 align="center" class="pt-4 mb-5">Ok, on va travailler <strong class="red">sur quelle spécialité</strong> ?</h4>

					<div class="row justify-content-center">

						<div class="col-lg-8">

							<div class="row justify-content-center">

								<cfoutput query="get_keywords">
									<div class="col-lg-3 col-md-2 col-sm-3">
										<div class="card card_module">
											<a class="btn_action" id="act-#step#_1">
												<img class="card-img-top" src="./assets/img_keyword/#keyword_id#.jpg">
												<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:100px">
													<h6 class="text-center mt-2" style="font-size:20px !important">#keyword_name#</h6>
													<p align="center">

													</p>
												</div>
											</a>
										</div>
									</div>
								</cfoutput>

							</div>

						</div>

					</div>






				<cfelseif step eq "2_2_1">

					<h4 align="center" class="pt-4 mb-5">On a bien quelques sujets susceptibles de vous <strong class="red">intéresser</strong> ?</h4>

					<div class="row justify-content-center">

						<div class="col-lg-8">

							<div class="row justify-content-center">

								<cfoutput query="get_keywords">
									<div class="col-lg-3 col-md-2 col-sm-3">
										<div class="card card_module">
											<a class="btn_action" id="act-#step#_1">
												<img class="card-img-top" src="./assets/img_keyword/#keyword_id#.jpg">
												<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:100px">
													<h6 class="text-center mt-2" style="font-size:20px !important">#keyword_name#</h6>
													<p align="center">

														

													</p>
												</div>
											</a>
										</div>
									</div>
								</cfoutput>

							</div>

						</div>

					</div>






				<cfelseif step eq "1_1_1_1_1" OR step eq "1_1_1_2_1" OR step eq "1_1_1_3_1" OR step eq "2_2_1_1">


					<h4 align="center" class="pt-4 mb-5">Une préférence <strong class="red">pour le rythme de formation ?</strong> </h4>



					<!--- <div class="alert bg-light text-dark border" role="alert">
						<div class="media">
							<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
							<div class="media-body">
								<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_rythm')#</cfoutput>
							</div>
						</div>
					</div>
					
					<form id="form_formula">								
					<div class="card-deck btn-group-toggle" data-toggle="buttons">
						<cfoutput query="get_tpformula">
						<label class="btn btn-lg card p-2 m-2 btn-outline-#tp_formula_css# cursored tp_formula">
							<input type="radio" name="tp_formula_id" class="tp_formula_id" value="#tp_formula_id#" autocomplete="off" >		
							<img class="card-img-top" src="./assets/img/#tp_formula_img#">
							<div class="card-body px-1">
								<h5 align="center" class="mt-1">#tp_formula_name#</h5>
								<div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
								#tp_formula_desc#
								</div>
							</div>
						</label>
						</cfoutput>
					</div>
	
					<div align="center">
					<br>
					<cfoutput>
					<input type="hidden" name="t_id" value="#t_id#">
					<button type="button" class="btn btn-lg btn-outline-red tp_formula_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button> 
					</cfoutput>
					</div>
					</form> --->


					<div class="row justify-content-center">

						<cfoutput query="get_tpformula">
						<div class="col-lg-2 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="act-#step#_1">
									<img class="card-img-top" src="./assets/img/#tp_formula_img#">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:120px">
										<!--- <h5 align="center" class="mt-1">#ucase(tp_formula_name)#</h5> --->
										<h6 class="text-center mt-2" style="font-size:20px !important">#ucase(tp_formula_name)#</h6>
										<!--- <div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
										#tp_formula_desc#
										</div> --->
									</div>
								</a>
							</div>
						</div>
						</cfoutput>

					</div>






				<cfelseif step eq "1_1_1_1_1_1" OR step eq "1_1_1_2_1_1" OR step eq "1_1_1_3_1_1" OR step eq "2_1_1_1_1_1">


					<h4 align="center" class="pt-4 mb-5">Il est temps de <strong class="red">choisir un parcours</strong> </h4>

					<div class="row justify-content-center">
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="act-<cfoutput>#step#_1</cfoutput>">
									<img class="card-img-top" src="./assets/img_keyword/5.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:120px">
										<!--- <h5 align="center" class="mt-1">#ucase(tp_formula_name)#</h5> --->
										<h6 class="text-center mt-2" style="font-size:20px !important">Parcours #1</h6>
										<!--- <div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
										#tp_formula_desc#
										</div> --->
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-3 col-md-4 col-sm-6">
							<div class="card card_module">
								<a class="btn_action" id="act-<cfoutput>#step#_1</cfoutput>">
									<img class="card-img-top" src="./assets/img_keyword/5.jpg">
									<div class="card-body d-flex flex-column h-100 bg-light" style="min-height:120px">
										<!--- <h5 align="center" class="mt-1">#ucase(tp_formula_name)#</h5> --->
										<h6 class="text-center mt-2" style="font-size:20px !important">Parcours #2</h6>
										<!--- <div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
										#tp_formula_desc#
										</div> --->
									</div>
								</a>
							</div>
						</div>
					</div>

				<cfelseif step eq "1_1_1_2_1_1_1">


					<h4 align="center" class="pt-4 mb-5">Avec qui souhaitez-vous <strong class="red">commencer l'aventure ?</strong> </h4>



					<div class="row justify-content-md-center mt-3 mb-1">
						<div class="col-md-12">
			
							
								
							
			
			<div class="row">
				<div class="col-12">
			
					
					
									
					<div class="card border">
						<div class="card-body">
							<div class="row">
								<div class="col-md-2 col-3 d-flex justify-content-center">
									<div class="pt-3 pl-3" align="center">
			
										<div>
										
							<img src="./assets/user/161/photo.jpg" class=" rounded-circle " width="130" title="DIANNE">
						
										</div>
			
										<div class="clearfix"></div>
			
										<button class="btn btn-outline-red btn-block btn_view_trainer" id="trainer_161">
											<i class="fal fa-address-card" aria-hidden="true"></i>
											Voir profil
										</button>
									
										<a class="btn btn-red btn-block text-nowrap text-white btn_action" id="act-<cfoutput>#step#_1</cfoutput>">
											CHOISIR
										</a>
			
									</div>
								</div>
								<div class="col-md-5 col-9">
									<div class="p-3">
										 
										
										
										
										<strong style="font-size:22px" class="text-dark">DIANNE </strong>
										<br><br>
										<small><strong>Enseigne :</strong></small>
										<br>
											
											
												<span class="lang-lg" lang="EN" style="top:4px"></span>
													
											
										<div class="clearfix mt-3"></div>
			
										<small><strong>Parle :</strong></small>
										<br>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Anglais 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Grec 
											<div class="clearfix"></div>
											<div class="gauge bg-warning float-left ml-1 mt-1"></div>
											<div class="gauge bg-warning float-left ml-1 mt-1"></div>
											<div class="gauge bg-warning float-left ml-1 mt-1"></div>
											<div class="gauge bg-warning float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											</span>
										
										<br><br>
										<table class="table table-sm table-borderless">
											<tbody><tr align="center">
												<td width="33%"><i class="fal fa-users fa-2x text-info" aria-hidden="true"></i></td>
												<td width="33%"><i class="fal fa-chalkboard-teacher fa-2x text-info" aria-hidden="true"></i></td>
												
												
											</tr>
											<tr align="center">
												<td>214<br>Apprenants</td>
												<td>4319<br>Cours</td>
												
												
											</tr>
										</tbody></table>
									</div>
								</div>
								<div class="col-md-5 col-12">
									<div class="p-3">
										<ul class="nav nav-tabs" role="tablist">
											<li class="nav-item">
												<a class="nav-link active" data-toggle="tab" href="#video_161" role="tab" aria-controls="video_161" aria-selected="true">Video</a>
											</li>
											<li class="nav-item">
												<a class="nav-link " data-toggle="tab" href="#about_161" role="tab" aria-controls="about_161" aria-selected="false">À propos de moi</a>
											</li>
											<li class="nav-item">
												<a class="nav-link " data-toggle="tab" href="#agenda_161" role="tab" aria-controls="agenda_161,  -" aria-selected="false">
													Disponibilités
												</a>
											</li>
										</ul>
										<div class="tab-content">
											<div class="tab-pane fade  show active" id="video_161" role="tabpanel">
												
												
													<video controls="" preload="" width="100%" height="250" poster="./assets/user/161/photo_video.jpg">
														<source src="https://lms.wefitgroup.com/assets/user/161/video.mp4" type="video/mp4">
															
															
															
															
															
													</video>
												
											</div>
			
			
											
			
			
											<div class="tab-pane fade " id="about_161" role="tabpanel">
												
													<br> 
												
											</div>
											
											<div class="tab-pane fade " id="agenda_161" role="tabpanel">
												<div class="my-4">
													
					<table class="table  table-borderless bg-white m-0 h-100">
			
					<tbody><tr align="center">	
						
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">LUN</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">MAR</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">MER</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">JEU</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">VEN</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">SAM</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge bg-light border text-muted">DIM</span></h5></td>
								
					</tr>
					
					
					
					
					<tr id="avail_161">
						
						<td width="12%" id="colday_mon" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_tue" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_wed" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_thu" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_fri" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_sat" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>21:00 
						</td>
						
						<td width="12%" id="colday_sun" class="text-center align-top" style="line-height:30px !important">
						
							<br>&nbsp;
						
						</td>
						
						</tr>		
					</tbody></table>
					
								
					
												</div>
												 
											</div>
											
										</div>
									</div>
								</div>	
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="row">
				<div class="col-12">
			
					
					
									
					<div class="card border">
						<div class="card-body">
							<div class="row">
								<div class="col-md-2 col-3 d-flex justify-content-center">
									<div class="pt-3 pl-3" align="center">
			
										<div>
										
							<img src="./assets/user/26382/photo.jpg" class=" rounded-circle " width="130" title="NOURHANE">
						
										</div>
			
										<div class="clearfix"></div>
			
										<button class="btn btn-outline-red btn-block btn_view_trainer" id="trainer_26382">
											<i class="fal fa-address-card" aria-hidden="true"></i>
											Voir profil
										</button>
									
										<a class="btn btn-red btn-block text-nowrap text-white btn_action" id="act-<cfoutput>#step#_1</cfoutput>">
											CHOISIR
										</a>
			
									</div>
								</div>
								<div class="col-md-5 col-9">
									<div class="p-3">
										 
										
										
										
										<strong style="font-size:22px" class="text-dark">NOURHANE </strong>
										<br><br>
										<small><strong>Enseigne :</strong></small>
										<br>
											
											
												<span class="lang-lg" lang="EN" style="top:4px"></span>
													
											
											
												<span class="lang-lg" lang="AR" style="top:4px"></span>
													
											
										<div class="clearfix mt-3"></div>
			
										<small><strong>Parle :</strong></small>
										<br>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Anglais 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Français 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Arabe 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Turc 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Arabe 
											<div class="clearfix"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											<div class="gauge bg-success float-left ml-1 mt-1"></div>
											</span>
										
											<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
											Allemand 
											<div class="clearfix"></div>
											<div class="gauge bg-danger float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											<div class="gauge bg-light2 float-left ml-1 mt-1"></div>
											</span>
										
										<br><br>
										<table class="table table-sm table-borderless">
											<tbody><tr align="center">
												<td width="33%"><i class="fal fa-users fa-2x text-info" aria-hidden="true"></i></td>
												<td width="33%"><i class="fal fa-chalkboard-teacher fa-2x text-info" aria-hidden="true"></i></td>
												
												
											</tr>
											<tr align="center">
												<td>174<br>Apprenants</td>
												<td>993<br>Cours</td>
												
												
											</tr>
										</tbody></table>
									</div>
								</div>
								<div class="col-md-5 col-12">
									<div class="p-3">
										<ul class="nav nav-tabs" role="tablist">
											<li class="nav-item">
												<a class="nav-link active" data-toggle="tab" href="#video_26382" role="tab" aria-controls="video_26382" aria-selected="true">Video</a>
											</li>
											<li class="nav-item">
												<a class="nav-link " data-toggle="tab" href="#about_26382" role="tab" aria-controls="about_26382" aria-selected="false">À propos de moi</a>
											</li>
											<li class="nav-item">
												<a class="nav-link " data-toggle="tab" href="#agenda_26382" role="tab" aria-controls="agenda_26382,  -" aria-selected="false">
													Disponibilités
												</a>
											</li>
										</ul>
										<div class="tab-content">
											<div class="tab-pane fade  show active" id="video_26382" role="tabpanel">
												
												
													<video controls="" preload="" width="100%" height="250">
														<source src="https://lms.wefitgroup.com/assets/user/26382/video.mp4" type="video/mp4">
															
															
															
															
															
													</video>
												
											</div>
			
			
											
			
			
											<div class="tab-pane fade " id="about_26382" role="tabpanel">
												
													<br><p>My favourite quote is: "Some are born great, some achieve greatness, and some have greatness thrust upon them" said by William Shakespeare and it means that there are some people who are born into power; others work for it, However, some are forced to accept it, also it <span class="ILfuVd" lang="en"><span class="hgKElc">suggests that even if someone is at a low level of abilities, it's possible to work on him/herself to develop.<br></span></span></p>
			<p>&nbsp;</p> 
												
											</div>
											
											<div class="tab-pane fade " id="agenda_26382" role="tabpanel">
												<div class="my-4">
													
					<table class="table  table-borderless bg-white m-0 h-100">
			
					<tbody><tr align="center">	
						
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">LUN</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">MAR</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">MER</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">JEU</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">VEN</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">SAM</span></h5></td>							
							
							<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">DIM</span></h5></td>							
								
					</tr>
					
					
					
					
					<tr id="avail_26382">
						
						<td width="12%" id="colday_mon" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_tue" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_wed" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_thu" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_fri" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_sat" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						<td width="12%" id="colday_sun" class="text-center align-top" style="line-height:30px !important">
						08:00 
							<br>13:00 
							<br><br>
							14:00 
							<br>22:00 
						</td>
						
						</tr>		
					</tbody></table>
					
								
					
												</div>
												 
											</div>
											
										</div>
									</div>
								</div>	
							</div>
						</div>
					</div>
				</div>
			</div>
			
							
						</div>
					</div>

					















				<cfelseif step eq "1_1_1_2_1_1_1_1">


					<h4 align="center" class="pt-4 mb-5">Un dernier effort ! Time to <strong class="red">book</strong> !</h4>


					<div class="row bg-white shadow-sm sticky-top">
			
						<div class="col-md-12">
				
							<div class="p-2">
	
								<div class="row justify-content-center">
									<div class="col-sm-12 col-md-4 col-lg-3">
	
										<div class="d-flex border border-red justify-content-between p-2">
											<div>
												<h6 class="m-0"><cfoutput>#obj_translater.get_translate('sidemenu_learner_tp')#</cfoutput></h6>
												<div class="badge display_tp_progress">
													<cfoutput>#progress_total - progress_completed# cours restants</cfoutput>	
												</div>
											</div>
	
											<div>
												<cfoutput><input type="submit" class="disabled btn btn-red btn_validate_tp m-0 <!---btn_view_tp---> <!---<cfif (progress_completed/progress_total)*100 LT 20>disabled</cfif>--->" id="tp_#t_id#" value="#obj_translater.get_translate('btn_continue')#"></cfoutput>
											</div>
										
			
											
											<!--- <cfoutput>
												<div class="progress w-100 mt-2" style="height:6px">
													<div class="progress_completed_general_bar progress-bar bg-success progress-bar-striped progress-bar-animated text-dark" role="progressbar" aria-valuenow="#(progress_completed/progress_total)*100#" aria-valuemin="0" aria-valuemax="100" style="width: #(progress_completed/progress_total)*100#%;"> 
													<!--- &nbsp;  --->
													</div>
												</div>
											</cfoutput> --->
			
											
											
										</div>
									</div>
								
								</div>
								
	
								<div id="container_session">
								
										
										
	
								</div>
	
								
								
	
							</div>
	
						</div>
	
					</div>
	
				<!--- </div> --->
	
				<div class="row">
				
					<div class="col-md-12">
	
						<cfset showfilter = "1">

						<!--- <cfinclude template="./incl/incl_multi_filter.cfm">

						<cfinclude template="get_slot_multi.cfm"> --->
	
					</div>
				
				</div>


					
				<cfelse>

				



            </cfif>



















			
			
			
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<!--- <cfinclude template="./incl/incl_multi_script.cfm"> --->

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	$(document).ready(function() {
		
		$(".btn_action").click(function(event) {

			event.preventDefault();
			var act_id = $(this).attr("id");
			var act_id = act_id.split("-");
			var act = act_id[1];
			document.location.href="_AD_onboarding.cfm?step="+act;
		});

		$("#btn_validate_tp").click(function(event) {
			event.preventDefault();
			$.ajax({				 
				url: './api/launching/launching_post.cfc?method=switch_user',
				type: "POST",
				data: {t_id:45403},
				datatype : "html",
				success : function(result, statut){
					window.location.href="common_tp_details.cfm";
				}
			})
		});

	});
</script>









</body>
</html>