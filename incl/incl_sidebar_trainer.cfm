<cfoutput>
	<cfif SESSION.USER_STATUS_ID eq "4" OR SESSION.USER_STATUS_ID eq "6">
	
		<div class="sidebar-wrapper">
			<ul class="nav">
			
				<li <cfif find("index",SCRIPT_NAME)>class="active"</cfif>>
					<a href="index.cfm"><i class="fal fa-home"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_home'))#</p></a>
				</li>
				
				<!---<li <cfif find("trainer_calendar",SCRIPT_NAME)>class="active"</cfif>>
					<a href="trainer_calendar.cfm"><i class="fal fa-calendar-alt"></i><p>#obj_translater.get_translate('sidemenu_trainer_calendar')#</p></a>
				</li>--->
				
				<!---<li <cfif find("trainer_calendar",SCRIPT_NAME)>class="active"</cfif>>
					
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_trainer_2" href="##menu_trainer_2"><i class="fal fa-calendar-alt"></i><p>#obj_translater.get_translate('sidemenu_trainer_calendar')#</p></a>
	
					<div <cfif find("trainer_calendar",SCRIPT_NAME)>class="collapsed show"<cfelse>class="collapse"</cfif> id="menu_trainer_2">
						<ul>			
						<li style="list-style:none">
						<a href="trainer_calendar.cfm" <cfif find("trainer_calendar.cfm",SCRIPT_NAME)>style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>Aper&ccedil;u calendrier</p></a>
						</li>
						<li style="list-style:none">
						<a href="trainer_calendar_avail.cfm" <cfif find("trainer_calendar_avail.cfm",SCRIPT_NAME)>style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>Param&eacute;trer dispo</p></a>
						</li>
						</ul>
					</div>
					
				</li>--->
				
				<li <cfif find("trainer_learners.cfm",SCRIPT_NAME) OR find("common_learner_account.cfm",SCRIPT_NAME) OR find("common_tp_calendar.cfm",SCRIPT_NAME) OR find("common_tp_details.cfm",SCRIPT_NAME) OR findnocase("common_tp_builder.cfm",SCRIPT_NAME)>class="active"</cfif>>
				
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_trainer_3" href="##menu_trainer_3"><i class="fal fa-users"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_learners'))#</p></a>
	
					<div  <cfif find("trainer_learners",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_trainer_3">
						<ul>
						<li style="list-style:none">
						<a href="trainer_learners.cfm?st_id=1,2" <cfif isdefined("st_id") AND st_id eq "1,2">style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_active')#</p></a>
						</li>
						<!--- <li style="list-style:none">
						<a href="trainer_learners.cfm?st_id=3" <cfif isdefined("st_id") AND st_id eq "3">style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_inactive')#</p></a>
						</li> --->
						<!----<li style="list-style:none">
						<a href="trainer_learners.cfm?st_id=5" <cfif isdefined("st_id") AND st_id eq "5">style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_anomaly')#</p></a>
						</li>--->
						</ul>
					</div>
				</li>
				
				<li <cfif find("trainer_lessons.cfm",SCRIPT_NAME)>class="active"</cfif>>
					<a href="trainer_lessons.cfm"><i class="fal fa-list-ul"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_lessons'))#</p></a>
				</li>
				
				<li <cfif find("common_syllabus",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="active"</cfif>>
				
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_trainer_5" href="##menu_trainer_5"><i class="fal fa-book-reader"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_library'))#</p></a>
	
					<div <cfif find("common_syllabus",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_trainer_5">
						<ul>			
							<li style="list-style:none" <cfif find("common_syllabus",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_syllabus.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_materials')#</p></a>
							</li>
							<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "email")>class="active"</cfif>>
								<a href="common_tools.cfm?subm=email" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_email_template')#</p></a>
							</li>		
							<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>>
								<a href="common_tools.cfm?subm=vocabulary" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list')#</p></a>
							</li>						
						</ul>						
					</div>
				</li>
					
				
				<li <cfif find("trainer_account",SCRIPT_NAME) OR find("trainer_calendar",SCRIPT_NAME) OR find("trainer_ops",SCRIPT_NAME)>class="active"</cfif>>
				
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_trainer_3" href="##menu_trainer_4"><i class="fal fa-user"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_account'))#</p></a>
	
					<div <cfif find("trainer_account",SCRIPT_NAME) OR find("trainer_calendar",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_trainer_4">
						<ul>			 
						<li style="list-style:none">
							<a href="common_trainer_account.cfm" <cfif find("trainer_account",SCRIPT_NAME)>style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_settings')#</p></a>
						</li>
						<li style="list-style:none">
							<a href="trainer_calendar.cfm" <cfif find("trainer_calendar",SCRIPT_NAME)>style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_availabilities')#</p></a>
						</li>
						<cfif isDefined("SESSION.TRAINER_OPS_TP")>
							<li style="list-style:none">
								<!--- not gonna highligth as trainer_ops is not the path, but that way we avoid conflict with --->
								<a href="common_tp_details.cfm?t_id=#SESSION.TRAINER_OPS_TP#" <cfif find("trainer_ops",SCRIPT_NAME)>style="color:##DB233D; font-weight:bold"</cfif> class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_ops')#</p></a>
							</li>
						</cfif>
						</ul>
					</div>
									
				</li>
				
				<li <cfif find("trainer_eval",SCRIPT_NAME) OR find("quiz_eval",SCRIPT_NAME) OR find("quiz_start.cfm",SCRIPT_NAME)>class="active"</cfif>>
					
						<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_learner_test" href="##menu_learner_test"><i class="fal fa-medal"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
	
						<div <cfif find("trainer_eval",SCRIPT_NAME) OR find("quiz_eval",SCRIPT_NAME) OR find("quiz_start.cfm",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_test">
							<ul>			
								<li style="list-style:none" <cfif (isdefined("subm") AND subm eq "wtest")>class="active"</cfif>>
									<a href="trainer_eval.cfm?subm=wtest" class="my-0 py-0"><p>Wefit Tests</p></a>
								</li>
								<li style="list-style:none" <cfif (isdefined("subm") AND subm eq "toeic")>class="active"</cfif>>
									<a href="trainer_eval.cfm?subm=toeic" class="my-0 py-0"><p>Toeic</p></a>
								</li>
								<li style="list-style:none" <cfif (isdefined("subm") AND subm eq "linguaskill")>class="active"</cfif>>
									<a href="trainer_eval.cfm?subm=linguaskill" class="my-0 py-0"><p>Linguaskill</p></a>
								</li>
								<li style="list-style:none" <cfif (isdefined("subm") AND subm eq "bright")>class="active"</cfif>>
									<a href="trainer_eval.cfm?subm=bright" class="my-0 py-0"><p>Bright</p></a>
								</li>
								
							</ul>						
						</div>
						
					</li>

					<li <cfif find("el_",SCRIPT_NAME)>class="active"</cfif>>
						<a href="el_dashboard.cfm">
							<i class="fal fa-laptop"></i>
							<p>
							<img src="./assets/img_formation/2.png" class="mt-1 mr-2" width="23" align="left">
							ELEARNING
							</p>
						</a>
					</li>

					<li <cfif find("db_mappingperquestion",SCRIPT_NAME)>class="active"</cfif>>
						<a href="db_mappingperquestion.cfm">
							<i class="fa-light fa-file-pen fa-2x"></i>
							<p>MISSED LESSON</p>
						</a>
					</li>
					
				<!---- 
				151 - DOUGLAS
				139 - PAUL
				504 - JAMIE K
				305 - VIRGINIA
				2586 - TOM
				141 - ANNE H
				8037 - NICOLAS
				13307 - ALBA
				27129 - SOFIA
				5781 - IVAN
				3484 - Craig
				161 - Dianne
				8036 - CLAYTINA
				32429 - COLIN
	
				---->
						
				<cfif SESSION.USER_ID eq "151" 
				OR SESSION.USER_ID eq "139" 
				OR SESSION.USER_ID eq "504" 
				OR SESSION.USER_ID eq "305" 
				OR SESSION.USER_ID eq "2586" 
				OR SESSION.USER_ID eq "141" 
				OR SESSION.USER_ID eq "8037"
				OR SESSION.USER_ID eq "13307"
				OR SESSION.USER_ID eq "27129"
				OR SESSION.USER_ID eq "5781"
				OR SESSION.USER_ID eq "12291"
				OR SESSION.USER_ID eq "202"
				OR SESSION.USER_ID eq "3484"
				OR SESSION.USER_ID eq "161"
				OR SESSION.USER_ID eq "8036"
				OR SESSION.USER_ID eq "32429"
				>
				<li <cfif find("db_",SCRIPT_NAME)>class="active"</cfif>>
				
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_5" href="##menu_cs_5"><i class="fal fa-database"></i><p>ADMIN</p></a>
	
					<div <cfif find("db_",SCRIPT_NAME) OR find("quiz_list",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_5">
						<ul>	
							<li style="list-style:none" <cfif find("db_mappingperquestion.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_mappingperquestion.cfm" class="my-0 py-0"><p>Quiz Question Map</p></a>
							</li>	
							<li style="list-style:none" <cfif find("db_mapping_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_mapping_list.cfm" class="my-0 py-0"><p>Edit Mapping</p></a>
							</li>
							<li style="list-style:none" <cfif find("db_syllabus_list.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_syllabus_list.cfm" class="my-0 py-0"><p>Edit Resource</p></a>
							</li>						
							<li style="list-style:none" <cfif find("db_quiz_list",SCRIPT_NAME) OR find("db_quiz_edit",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_quiz_list.cfm" class="my-0 py-0"><p>Edit Quiz</p></a>
							</li>
							<li style="list-style:none" <cfif find("db_vocab_list",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_vocab_list.cfm" class="my-0 py-0"><p>Edit Vocab List</p></a>
							</li>
							
							<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME)>class="active"</cfif>>
					
								<a data-toggle="collapse" role="button" <cfif find("db_translate_list",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_translation" href="##menu_learner_translation" class="my-0 py-0"><p>+ Edit Translation</p></a>
	
								<div <cfif find("db_translate_list",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_translation">
									<ul>
										<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME) AND (isdefined("view") AND view eq "short")>class="active"</cfif>>
											<a href="db_translate_list.cfm?view=short" class="my-0 py-0"><p>Short</p></a>
										</li>
										<li style="list-style:none" <cfif find("db_translate_list",SCRIPT_NAME) AND (isdefined("view") AND view eq "long")>class="active"</cfif>>
											<a href="db_translate_list.cfm?view=long" class="my-0 py-0"><p>Complex</p></a>
										</li>
									</ul>
								</div>
							
							</li>
							
						</ul>						
					</div>
				</li>
				</cfif>
			 </ul>
		</div>
	
	</cfif>
	
</cfoutput>