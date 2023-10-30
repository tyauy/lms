<cfoutput>
	<div class="sidebar-wrapper">
        <ul class="nav">
			
			<cfif not findnocase("quiz.cfm",SCRIPT_NAME)>
			
				<cfif SESSION.USER_STATUS_ID eq "4">

					<li <cfif findnocase("index",SCRIPT_NAME) OR findnocase("common_tp_builder.cfm",SCRIPT_NAME)>class="active"</cfif>>
						<a href="index.cfm"><i class="fal fa-home"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
					</li>

				<cfelse>

					<li>
						<a disabled class="grey"><i class="fal fa-home grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
					</li>

				</cfif>
					
				<!--- <li <cfif SCRIPT_NAME eq "/learner_evals.cfm">class="active"</cfif>> --->
					<!--- <a href="learner_evals.cfm"><i class="fas fa-mind-share"></i><p>USPRING</p></a> --->
				<!--- </li> --->
				
				<cfif SESSION.USER_PROFILE eq "LEARNER">

					<cfif SESSION.USER_STATUS_ID eq "4">

						<cfif SESSION.PROVIDER_ID eq "1" OR SESSION.PROVIDER_ID eq "3">
						<cfquery name="get_lesson_not_signed" datasource="#SESSION.BDDSOURCE#">
						SELECT COUNT(l2.lesson_id) as nb FROM lms_lesson2 l2
						LEFT JOIN lms_lesson2_attendance lla ON lla.lesson_id = l2.lesson_id
						WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
						AND (l2.status_id = 4 OR l2.status_id = 5) 
						AND (l2.lesson_signed = 0 OR (lla.lesson_signed <> 1 OR lla.lesson_signed IS NULL)) 
						AND (l2.method_id = 1 OR l2.method_id = 2)
						</cfquery>			
						</cfif>			
				
							
						<cfif (isdefined("SESSION.ACCESS_VISIO") AND SESSION.ACCESS_VISIO eq "1") OR (isdefined("SESSION.ACCESS_F2F") AND SESSION.ACCESS_F2F eq "1") OR (isdefined("SESSION.ACCESS_GROUP") AND SESSION.ACCESS_GROUP eq "1")>
						
							<li <cfif findnocase("common_tp_details",SCRIPT_NAME) OR find("common_tp_multi",SCRIPT_NAME) OR find("learner_lessons",SCRIPT_NAME) OR find("learner_sign",SCRIPT_NAME)>class="active"</cfif>>
								<a href="common_tp_details.cfm"><i class="fal fa-webcam"></i><p>E-TRAINING</p></a>
							</li>

							<!--- common_syllabus --->

							<!--- <li <cfif find("common_tp_details",SCRIPT_NAME) OR find("common_trainer",SCRIPT_NAME) OR find("learner_lessons",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("learner_sign",SCRIPT_NAME)>class="active"</cfif>>
								<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_learner_tp" href="##menu_learner_tp"><i class="fal fa-webcam"></i><p>E-TRAINING <cfif SESSION.PROVIDER_ID eq "1" OR SESSION.PROVIDER_ID eq "3"><cfif get_lesson_not_signed.nb neq "0"><span class="badge badge-pill badge-warning">!</span></cfif></cfif></p></a>

								<div <cfif find("common_tp_details",SCRIPT_NAME) OR find("common_trainer",SCRIPT_NAME) OR find("learner_lessons",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("learner_sign",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_tp">
									<ul>		
									
										<li style="list-style:none" <cfif find("common_tp_details",SCRIPT_NAME)>class="active"</cfif>>
											<a href="common_tp_details.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_visio_f2f_tp')#</p></a>
										</li>
										
										<!--- <li style="list-style:none" <cfif find("common_syllabus.cfm",SCRIPT_NAME)>class="active"</cfif>>
											<a href="common_syllabus.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_visio_library')#</p></a>
										</li> --->
										
										<li style="list-style:none" <cfif find("learner_lessons",SCRIPT_NAME)>class="active"</cfif>>
											<a href="learner_lessons.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_activity_report')#</p></a>
										</li>	
										
										<cfif SESSION.PROVIDER_ID eq "1" OR SESSION.PROVIDER_ID eq "3">
										<cfif get_lesson_not_signed.nb neq "0">
										<li style="list-style:none" <cfif find("learner_sign",SCRIPT_NAME)>class="active"</cfif>>
											<a href="learner_sign.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_wait_signature')# <span class="badge badge-pill badge-warning">#get_lesson_not_signed.nb#</span></p></a>
										</li>	
										</cfif>
										</cfif>

									</ul>						
								</div>					
							
							</li> --->
						<cfelse>
							<li>
								<a disabled class="grey"><i class="fal fa-webcam grey"></i><p>E-TRAINING</p></a>
							</li>
						</cfif>

					<cfelse>
						<li>
							<a disabled class="grey"><i class="fal fa-webcam grey"></i><p>E-TRAINING</p></a>
						</li>
					</cfif>
					

				<cfelse>
					<li>
						<a disabled class="grey"><i class="fal fa-webcam grey"></i><p>E-TRAINING</p></a>
					</li>
				</cfif>

				<!----------------- REMOVE FOR PARTNER LEARNER -------------------->
				<cfif SESSION.USER_TYPE_ID neq "7">
					
					<cfif isdefined("SESSION.ACCESS_EL_7SPK") AND SESSION.USER_STATUS_ID eq "4">
						<li>
							<a href="https://user.7speaking.com/" target="_blank"><i class="fal fa-laptop"></i><p>E-LEARNING 7SPK</p></a>
						</li>
					</cfif>
					
					<cfif isdefined("SESSION.ACCESS_EL") AND SESSION.ACCESS_EL eq "1" AND SESSION.USER_STATUS_ID eq "4">

						<cfif listlen(SESSION.LIST_ACCESS_EL) gte "1">

							<cfif listfind(SESSION.LIST_ACCESS_EL,"2")>
								<li <cfif find("el_",SCRIPT_NAME)>class="active"</cfif>>
									<a href="el_dashboard.cfm">
										<i class="fal fa-laptop"></i>
										<p>
										<img src="./assets/img_formation/2.png" class="mt-1 mr-2" width="23" align="left">
										ELEARNING
										</p>
									</a>
								</li>
							</cfif>


							<cfif listfind(SESSION.LIST_ACCESS_EL,"3")>
							<li <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
						
								<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_el" href="##menu_learner_el"><i class="fal fa-laptop"></i>
									<p>
										<img src="./assets/img_formation/3.png" class="mt-1 mr-2" width="23" align="left">
										ELEARNING
									</p>
								</a>
	
								<div <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_el">
									<ul>	
										
										<li style="list-style:none" <cfif find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME)>class="active"</cfif>>
											<a href="common_practice.cfm?f_id=3" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_myeprogram')#</p></a>
										</li>
										
										<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "email")>class="active"</cfif>>
											<a href="common_tools.cfm?subm=email" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_email_template')#</p></a>
										</li>
										
										
										<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="active"</cfif>>
							
											<a data-toggle="collapse" role="button" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_vocabulary" href="##menu_learner_vocabulary" class="my-0 py-0"><p>+ #obj_translater.get_translate('sidemenu_learner_vocab')#</p></a>
	
											<div <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_vocabulary">
												<ul>
													<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>>
														<a href="elearning_vocab.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_theme')#</p></a>
													</li>
													<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary_perso")>class="active"</cfif>>
														<a href="elearning_vocab_perso.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list_perso')#</p></a>
													</li>
												</ul>
											</div>
										
										</li>
										
										
										<!--- <cfif SESSION.USER_ID eq "30398">
											<li style="list-style:none" <cfif find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
												<a href="elearning_certif.cfm" class="my-0 py-0"><p>Prépa Certification</p></a>
											</li>
										<cfelse> --->
										<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
							
											<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_mock" href="##menu_learner_mock" class="my-0 py-0"><p>+ #obj_translater.get_translate('card_certification')#</p></a>
	
											<div <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_mock">
												<ul>
													<!--- <cfif isdefined("SESSION.ACCESS_EL") AND listfind(SESSION.LIST_ACCESS_EL,"2")>  --->
													<!--------------- DISPLAY FOR ENGLISH ------------>
													<!--- <li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "toeic")>class="active"</cfif>>
														<a href="learner_test.cfm?subm=toeic" class="my-0 py-0"><p>Toeic</p></a>
													</li>
													<li style="list-style:none" <cfif find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
														<a href="elearning_certif.cfm" class="my-0 py-0"><p>Linguaskill</p></a>
													</li> --->
													<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "bright")>class="active"</cfif>>
														<a href="learner_test.cfm?subm=bright" class="my-0 py-0"><p>Bright</p></a>
													</li>
													<!--- </cfif> --->
												</ul>
											</div>
										
										</li>
										<!--- </cfif> --->
									</ul>						
								</div>
								
							</li>
							</cfif>


						<cfelse>
							<li <cfif find("el_",SCRIPT_NAME)>class="active"</cfif>>
								<a href="el_dashboard.cfm"><i class="fal fa-laptop"></i><p>E-LEARNING</p></a>
							</li>
						</cfif>

						
						

						<!--- <li <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
						
							<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_el" href="##menu_learner_el"><i class="fal fa-phone-laptop"></i><p>E-LEARNING</p></a>

							<div <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_el">
								<ul>	
									
									<li style="list-style:none" <cfif find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME)>class="active"</cfif>>
										<a href="common_practice.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_myeprogram')#</p></a>
									</li>
									
									<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "email")>class="active"</cfif>>
										<a href="common_tools.cfm?subm=email" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_email_template')#</p></a>
									</li>
									
									
									<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="active"</cfif>>
						
										<a data-toggle="collapse" role="button" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_vocabulary" href="##menu_learner_vocabulary" class="my-0 py-0"><p>+ #obj_translater.get_translate('sidemenu_learner_vocab')#</p></a>

										<div <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND findnocase("vocabulary",subm))>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_vocabulary">
											<ul>
												<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>>
													<a href="elearning_vocab.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_theme')#</p></a>
												</li>
												<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary_perso")>class="active"</cfif>>
													<a href="elearning_vocab_perso.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list_perso')#</p></a>
												</li>
											</ul>
										</div>
									
									</li>
									
									
									<!--- <cfif SESSION.USER_ID eq "30398">
										<li style="list-style:none" <cfif find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
											<a href="elearning_certif.cfm" class="my-0 py-0"><p>Prépa Certification</p></a>
										</li>
									<cfelse> --->
									<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
						
										<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_mock" href="##menu_learner_mock" class="my-0 py-0"><p>+ #obj_translater.get_translate('card_certification')#</p></a>

										<div <cfif find("learner_test",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_mock">
											<ul>
												<!--- <cfif isdefined("SESSION.ACCESS_EL") AND listfind(SESSION.LIST_ACCESS_EL,"2")>  --->
												<!--------------- DISPLAY FOR ENGLISH ------------>
												<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "toeic")>class="active"</cfif>>
													<a href="learner_test.cfm?subm=toeic" class="my-0 py-0"><p>Toeic</p></a>
												</li>
												<li style="list-style:none" <cfif find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
													<a href="elearning_certif.cfm" class="my-0 py-0"><p>Linguaskill</p></a>
												</li>
												<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "bright")>class="active"</cfif>>
													<a href="learner_test.cfm?subm=bright" class="my-0 py-0"><p>Bright</p></a>
												</li>
												<!--- </cfif> --->
											</ul>
										</div>
									
									</li>
									<!--- </cfif> --->
								</ul>						
							</div>
							
						</li> --->
						
						<li <cfif findnocase("learner_virtual",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_virtual.cfm"><i class="fal fa-users-viewfinder"></i><p>VIRTUAL CLASS</p></a>
						</li>
					<cfelse>
						<li>
							<a disabled class="grey"><i class="fal fal fa-phone-laptop grey"></i><p>E-LEARNING</p></a>
							<a disabled class="grey"><i class="fal fa-users-viewfinder grey"></i><p>VIRTUAL CLASS</p></a>
						</li>
					</cfif>
				
					
					<cfif SESSION.USER_STATUS_ID eq "4">
					
						<li <cfif find("learner_eval",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_eval.cfm"><i class="fal fa-medal"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
						</li>
						
						
						<!--- <li <cfif find("learner_eval",SCRIPT_NAME)>class="active"</cfif>>
					
						<a data-toggle="collapse" role="button" <cfif find("learner_eval",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_lst" href="##menu_learner_lst"><i class="fal fa-medal"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>

						<div <cfif find("learner_eval",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_lst">
							<ul>	
								
								<li style="list-style:none" <cfif SCRIPT_NAME eq "/learner_eval.cfm">class="active"</cfif>>
									<a href="learner_eval.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_tests')#</p></a>
								</li>
								
							</ul>
						</div>

						</li> --->
						
					<cfelse>
						<li>
							<a disabled class="grey"><i class="fal fa-medal grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
						</li>
					</cfif>
				
					<cfif isdefined("SESSION.LANG_CODE") AND (SESSION.LANG_CODE eq "fr" OR SESSION.LANG_CODE eq "de") AND (isdefined("SESSION.ACCESS_VISIO") OR SESSION.USER_PROFILE eq "GUEST")>
						<cfif SESSION.USER_STATUS_ID eq "4">
							<li <cfif find("common_tuto",SCRIPT_NAME)>class="active"</cfif>>
								<a href="common_tuto.cfm"><i class="fal fa-video"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_video'))#</p></a>
							</li>
						<cfelse>
							<li>
								<a disabled class="grey"><i class="fal fa-video grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_video'))#</p></a>
							</li>
						</cfif>				
					</cfif>
					
					<cfif isdefined("SESSION.LANG_CODE") AND SESSION.LANG_CODE eq "fr">
						<cfif SESSION.USER_STATUS_ID eq "4">
							<li>
								<a href="https://cpf.wefitgroup.com/catalogue-formation-langue" target="_blank"><i class="fal fa-book"></i><p>CATALOGUE CPF</p></a>
							</li>
						<cfelse>
							<li>
								<a disabled class="grey"><i class="fal fa-book grey"></i><p>CATALOGUE CPF</p></a>
							</li>
						</cfif>	
					</cfif>

				<cfelse>
					
					<cfif SESSION.USER_STATUS_ID eq "4">
						<li <cfif find("learner_eval",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_eval.cfm" target="_blank"><i class="fal fa-medal"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
						</li>
					<cfelse>
						<li>
							<a disabled class="grey"><i class="fal fa-medal grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
						</li>
					</cfif>	
					
				</cfif>
		
			</cfif>
		   
		</ul>
	</div>
</cfoutput>