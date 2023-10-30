<cfoutput>
	<div class="sidebar-wrapper">

        <!--- <cfif SESSION.USER_STATUS_ID eq "3">

            <div class="p-2">
                <a class="btn btn-block btn-red" href="learner_launch_1.cfm?trigger_launch=1"><i class="fal fa-rocket"></i><!---#ucase(obj_translater.get_translate('sidemenu_learner_home'))#---> ONBOARDING !</a>
            </div>   --->
            
            
		<!--- <cfoutput>SESSION.ACCESS_EL = #SESSION.ACCESS_EL#</cfoutput> --->
    
        <!--- </cfif> --->

        <ul class="nav">
			
			<cfif not findnocase("quiz.cfm",SCRIPT_NAME) AND not findnocase("learner_launch_1",SCRIPT_NAME) AND not findnocase("learner_launch_2",SCRIPT_NAME)>

                <li <cfif findnocase("index",SCRIPT_NAME) OR findnocase("common_tp_builder.cfm",SCRIPT_NAME)>class="active"</cfif>>
                    <a href="index.cfm"><i class="fal fa-home"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
                </li>
    
                <cfif (isdefined("SESSION.ACCESS_VISIO") AND SESSION.ACCESS_VISIO eq "1") OR (isdefined("SESSION.ACCESS_F2F") AND SESSION.ACCESS_F2F eq "1") OR (isdefined("SESSION.ACCESS_GROUP") AND SESSION.ACCESS_GROUP eq "1")>
                
                    <li <cfif find("common_tp_details",SCRIPT_NAME) OR find("common_trainer",SCRIPT_NAME) OR find("learner_lessons",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("learner_sign",SCRIPT_NAME)>class="active"</cfif>>
                        <a data-toggle="collapse" role="button" aria-expanded="false" aria-controls="menu_learner_tp" href="##menu_learner_tp"><i class="fal fa-webcam"></i><p>E-TRAINING</p></a>

                        <div <cfif find("common_tp_details",SCRIPT_NAME) OR find("common_trainer",SCRIPT_NAME) OR find("learner_lessons",SCRIPT_NAME) OR find("common_syllabus.cfm",SCRIPT_NAME) OR find("learner_sign",SCRIPT_NAME)>class="collapse show"<cfelse>class="collapse"</cfif> id="menu_learner_tp">
                            <ul>		
                            
                                <li style="list-style:none" <cfif find("common_tp_details",SCRIPT_NAME)>class="active"</cfif>>
                                    <a href="common_tp_details.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_visio_f2f_tp')#</p></a>
                                </li>
                                
                                <!--- <li style="list-style:none" <cfif find("common_syllabus.cfm",SCRIPT_NAME)>class="active"</cfif>>
                                    <a href="common_syllabus.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_visio_library')#</p></a>
                                </li> --->
                                
                                <!--- <li style="list-style:none" <cfif find("learner_lessons",SCRIPT_NAME)>class="active"</cfif>>
                                    <a href="learner_lessons.cfm" class="my-0 py-0"><p>#obj_translater.get_translate('sidemenu_learner_activity_report')#</p></a>
                                </li>	 --->

                            </ul>						
                        </div>					
                    
                    </li>

                </cfif>


                <cfif isdefined("SESSION.ACCESS_EL") AND SESSION.ACCESS_EL eq "1" AND SESSION.USER_STATUS_ID eq "4">

                    <li <cfif find("el_",SCRIPT_NAME)>class="active"</cfif>>
                        <a href="el_dashboard.cfm"><i class="fal fa-laptop"></i><p>E-LEARNING</p></a>
                    </li>

                </cfif>

                <!--- <cfif isdefined("SESSION.ACCESS_EL") AND SESSION.ACCESS_EL eq "1">

                    <li <cfif find("learner_test",SCRIPT_NAME) OR find("common_practice",SCRIPT_NAME) OR find("learner_practice",SCRIPT_NAME) OR find("common_tools",SCRIPT_NAME) OR find("elearning_certif",SCRIPT_NAME)>class="active"</cfif>>
                    
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
                        
                    </li>

                    
                    <li>
                        <a href="learner_virtual.cfm"><i class="fal fa-users-viewfinder"></i><p>VIRTUAL CLASS</p></a>
                    </li>

                </cfif> --->
            
                <li <cfif find("learner_eval",SCRIPT_NAME)>class="active"</cfif>>
                    <a href="learner_eval.cfm"><i class="fal fa-medal"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_tests'))#</p></a>
                </li>
					
            <cfelse>
                <li>
                    <a disabled class="grey"><i class="fal fa-home grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
                </li>

                <li>
                    <a disabled class="grey"><i class="fal fa-webcam grey"></i><p>E-TRAINING</p></a>
                </li>

                <li>
                    <a disabled class="grey"><i class="fal fa-laptop grey"></i><p>E-LEARNING</p></a>
                </li>

                <li>
                    <a disabled class="grey"><i class="fal fa-users-viewfinder grey"></i><p>VIRTUAL CLASS</p></a>
                </li>

                <li>
                    <a disabled class="grey"><i class="fal fa-medal grey"></i><p>#ucase(obj_translater.get_translate('sidemenu_learner_home'))#</p></a>
                </li>

			</cfif>
		   
		</ul>
	</div>
</cfoutput>