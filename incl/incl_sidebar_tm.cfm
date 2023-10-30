<cfoutput>
	<div class="sidebar-wrapper">
        <ul class="nav">
			<li <cfif find("index.cfm",SCRIPT_NAME)>class="active"</cfif>>
				<a href="tm_index.cfm<cfif isdefined("a_id")>?a_id=#a_id#</cfif>"><i class="fal fa-home"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
			</li>
			<!---<li <cfif find("tm_admin.cfm",SCRIPT_NAME) OR find("tm_order_create",SCRIPT_NAME) OR find("tm_estimate_create",SCRIPT_NAME)>class="active"</cfif>>
				<a href="tm_admin.cfm<cfif isdefined("a_id")>?a_id=#a_id#</cfif>"><i class="fal fa-folder"></i><p>ADMINISTRATIF</p></a>
			</li>--->
			<!---<li <cfif find("tm_learners.cfm",SCRIPT_NAME) OR find("tm_learner.cfm",SCRIPT_NAME)>class="active"</cfif>>
				<a href="tm_learners.cfm<cfif isdefined("a_id")>?a_id=#a_id#</cfif>"><i class="fal fa-users"></i><p>Parcours</p></a>
			</li>--->
			<!---<li <cfif find("common_trainer",SCRIPT_NAME)>class="active"</cfif>>
				<a href="common_trainer_search.cfm?view_select=list"><i class="fal fa-users"></i><p>Trainers</p></a>
			</li>--->
			
			
			<li <cfif find("tm_lessons.cfm",SCRIPT_NAME) OR find("tm_learners",SCRIPT_NAME) OR find("tm_group_tp",SCRIPT_NAME)>class="active"</cfif>>
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_tm_activity" href="##menu_tm_activity"><i class="fal fa-clipboard-list"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_activity'))#</p></a>

				<div <cfif find("tm_lessons",SCRIPT_NAME) OR find("tm_learners",SCRIPT_NAME) OR find("tm_group_tp",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_tm_activity">
					<ul>	
						<!--- <li style="list-style:none" <cfif find("tm_admin.cfm",SCRIPT_NAME)>class="active"</cfif>> --->
							<!--- <a href="tm_admin.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_orders')#</p></a> --->
						<!--- </li> --->
						<li style="list-style:none" <cfif find("tm_learners.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="tm_learners.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_learners')#</p></a>
						</li>
						<cfif isDefined("SESSION.ACCESS_TPGROUP_LIST")>
							<li style="list-style:none" <cfif find("tm_group_tp.cfm",SCRIPT_NAME)>class="active"</cfif>>
								<a href="tm_group_tp.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_tpgroup')#</p></a>
							</li>
						</cfif>
						<li style="list-style:none" <cfif find("tm_lessons.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="tm_lessons.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_reports')#</p></a>
						</li>
					</ul>
				</div>
			</li>

			<li <cfif find("tm_admin",SCRIPT_NAME)>class="active"</cfif>>
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_tm_admin" href="##menu_tm_admin"><i class="fal fa-cabinet-filing"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_admin'))#</p></a>

				<div <cfif find("tm_admin",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_tm_admin">
					<ul>	
						<li style="list-style:none" <cfif find("tm_admin.cfm",SCRIPT_NAME)>class="active"</cfif>>
							<a href="tm_admin.cfm" class="my-0 py-0"><p>#(obj_translater.get_translate('table_th_training_records'))#</p></a>
						</li>
						
						<cfif isDefined("SESSION.USER_ACCOUNT_RIGHT_ID")>
							<cfif listFindNoCase(SESSION.USER_ACCOUNT_RIGHT_ID, 1)>
								<li style="list-style:none" <cfif find("tm_admin_learners",SCRIPT_NAME)>class="active"</cfif>>
									<a href="tm_admin_learners.cfm" class="my-0 py-0"><p>#(obj_translater.get_translate('sidemenu_tm_gestion'))#</p></a>
								</li>
							</cfif>
						</cfif>
						
					</ul>
				</div>
			</li>
		
			
			<!--- <li <cfif find("tm_admin",SCRIPT_NAME)>class="active"</cfif>>
				<a href="tm_admin.cfm"><i class="fal fa-cabinet-filing"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_admin'))#</p></a>
			</li> --->





			<li <cfif find("el_",SCRIPT_NAME)>class="active"</cfif>>
				<a href="el_dashboard.cfm">
					<i class="fal fa-laptop"></i>
					<p>
					<img src="./assets/img_formation/2.png" class="mt-1 mr-2" width="23" align="left">
					ELEARNING
					</p>
				</a>
			</li>
			
			<!--- <li <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="active"</cfif>>
				
				<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_el" href="##menu_learner_el"><i class="fal fa-laptop"></i><p>E-LEARNING</p></a>

				<div <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_el">
					<ul>	
						
						<li style="list-style:none" <cfif find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME)>class="active"</cfif>>
							<a href="common_practice.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_myeprogram')#</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "email")>class="active"</cfif>>
							<a href="common_tools.cfm?subm=email" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_email_template')#</p></a>
						</li>

						<li style="list-style:none" <cfif find("common_tools",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "vocabulary")>class="active"</cfif>>
							<a href="common_tools.cfm?subm=vocabulary" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_vocab_list')#</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME)>class="active"</cfif>>
			
						<a data-toggle="collapse" role="button" <cfif find("learner_test",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_mock" href="##menu_learner_mock" class="my-0 py-0"><p>+ #obj_translater.get_translate('sidemenu_learner_mock_tests')#</p></a>

						<div <cfif find("learner_test",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_mock">
							<ul>
								<cfif isdefined("SESSION.ACCESS_EL") AND listfind(SESSION.LIST_ACCESS_EL,"2")> 
								<!--------------- DISPLAY FOR ENGLISH ------------>
								<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "toeic")>class="active"</cfif>>
									<a href="learner_test.cfm?subm=toeic" class="my-0 py-0"><p>Toeic</p></a>
								</li>
								<li style="list-style:none" <cfif find("learner_test",SCRIPT_NAME) AND (isdefined("subm") AND subm eq "linguaskill")>class="active"</cfif>>
									<a href="learner_test.cfm?subm=linguaskill" class="my-0 py-0"><p>Linguaskill</p></a>
								</li>
								</cfif>
							</ul>
						</div>
						
						
					</ul>						
				</div>
				
			</li> --->


			<li <cfif find("learner_virtual",SCRIPT_NAME) OR find("learner_index",SCRIPT_NAME)>class="active"</cfif>>
			
				<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cs_vc" href="##menu_cs_vc"><i class="fal fa-users-viewfinder"></i><p>VIRTUAL CLASS</p></a>

				<div <cfif find("learner_virtual",SCRIPT_NAME) OR find("learner_index",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cs_vc">
					<ul>		
						<li style="list-style:none" <cfif find("learner_index",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_index.cfm" class="my-0 py-0"><p>Home</p></a>
						</li>
						<li style="list-style:none" <cfif find("learner_virtual",SCRIPT_NAME)>class="active"</cfif>>
							<a href="learner_virtual.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_trainer_calendar')#</p></a>
						</li>
					</ul>						
				</div>
			</li>
			
			
			<li <cfif find("common_syllabus",SCRIPT_NAME)>class="active"</cfif>>
				<a href="common_syllabus.cfm"><i class="fal fa-photo-video"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_library'))#</p></a>
			</li>
			
			<!--- <li <cfif find("tm_trainers",SCRIPT_NAME) OR find("common_trainer_account",SCRIPT_NAME)>class="active"</cfif>> --->
				<!--- <a href="tm_trainers.cfm"><i class="fal fa-chalkboard-teacher"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_trainers'))#</p></a> --->
			<!--- </li> --->
			
			<li <cfif find("tm_opinion",SCRIPT_NAME)>class="active"</cfif>>
				
				<a data-toggle="collapse" role="button" <cfif find("tm_opinion",SCRIPT_NAME)>aria-expanded="true"<cfelse>aria-expanded="false"</cfif> aria-controls="menu_learner_opinion" href="##menu_learner_opinion"><i class="fal fa-comments"></i><p>#ucase(obj_translater.get_translate('sidemenu_tm_feedback'))#</p></a>

				<div <cfif find("tm_opinion",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_opinion">
					<ul>	
					
						<li style="list-style:none" <cfif find("tm_opinion",SCRIPT_NAME) AND isdefined("form_display") AND form_display eq "opinion">class="active"</cfif>>
							<a href="tm_opinion.cfm?form_display=opinion" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_feedback_training')#</p></a>
						</li>
						
						<li style="list-style:none" <cfif find("tm_opinion",SCRIPT_NAME) AND isdefined("form_display") AND form_display eq "interface">class="active"</cfif>>
							<a href="tm_opinion.cfm?form_display=interface" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_tm_feedback_interface')#</p></a>
						</li>
						
					</ul>						
				</div>
				
			</li>
						
			<li <cfif find("tm_account",SCRIPT_NAME)>class="active"</cfif>>
				<a href="tm_account.cfm"><i class="fal fa-wrench"></i><p>#ucase(obj_translater.get_translate('sidemenu_trainer_settings'))#</p></a>
			</li>


			<cfif isDefined("SESSION.PROFILE_LIST_NAME") AND listFindNoCase(SESSION.PROFILE_LIST_NAME, "SchoolMNG")>

				<li <cfif find("cm_",SCRIPT_NAME) OR  find("db_certif_school_2",SCRIPT_NAME)>class="active"</cfif>>
			
					<a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_cm_1" href="##menu_cm_1"><i class="fa-light fa-file-certificate"></i><p>CERTIFICATION</p></a>
	
					<div <cfif find("cm_",SCRIPT_NAME) OR  find("db_certif_school_2",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_cm_1">
						<ul>	
							<li style="list-style:none" <cfif find("db_certif_school_2",SCRIPT_NAME)>class="active"</cfif>>
								<a href="db_certif_school_2.cfm" class="my-0 py-0"><p>Tableau de bord</p></a>
							</li>	
							<li style="list-style:none" <cfif find("cm_database",SCRIPT_NAME)>class="active"</cfif>>
								<a href="cm_database.cfm" class="my-0 py-0"><p>Gestionnaires</p></a>
							</li>
							<li style="list-style:none" <cfif find("cm_session",SCRIPT_NAME)>class="active"</cfif>>
								<a href="cm_session.cfm" class="my-0 py-0"><p>Sessions</p></a>
							</li>						
						</ul>						
					</div>
				</li>
			</cfif>

			
         </ul>
	</div>
</cfoutput>