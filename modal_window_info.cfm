<cfif isdefined("show_info")>
    
    <!------------------ TRAINER MANAGEMENT ---------------->
    <cfif show_info eq "trainer_choice">

        <cfset get_tp = obj_tp_get.oget_tps(t_id="#SESSION.TP_ID#")>

        <cfset tp_end = obj_dater.get_dateformat(get_tp.tp_date_end)>	
        <cfset arr = ['tp_end']>
        <cfset argv_tp_end = arrayMap(arr, function(item){return [item, evaluate(item)]})>

        <div class="alert bg-light text-dark border" role="alert">
            <div class="media">
                <img src="./assets/img/method_test.jpg" width="200" class="mr-3">
                <div class="media-body">
                    
                    <cfoutput>#obj_translater.get_translate_complex('alert_launch_text_choose_test_trainer',SESSION.LANG_CODE,argv_tp_end)#</cfoutput>
                    
                </strong>

                </div>
            </div>
        </div>

        <div align="center">
            <cfoutput>
                <!--- #obj_translater.get_translate("btn_understood")# --->
                <button type="button" class="btn btn-lg btn-success btn_valid_support" data-dismiss="modal"><cfoutput>#obj_translater.get_translate("btn_understood")#</cfoutput> <i class="far fa-chevron-double-right"></i></button>
            </cfoutput>
        </div>











   


























    <cfelseif show_info eq "elearning" OR show_info eq "booking">
        
        <cfoutput>
        <video controls width="100%" height="400" <!---poster="./assets/user/#user_id#/photo_video.jpg"--->>
        <source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_#show_info#_#SESSION.LANG_CODE#.mp4" type="video/mp4">
        </video>
        </cfoutput>














    <!------------------ GROUP TP LAUNCHING ---------->
    <cfelseif show_info eq "group">
        
        <cfset SESSION.LAUNCH_GROUP = 0>

        <cfoutput>
        <video controls width="100%" height="400" <!---poster="./assets/user/#user_id#/photo_video.jpg"--->>
        <source src="#SESSION.BO_ROOT_URL#/assets/video/tutoriel_#show_info#_#SESSION.LANG_CODE#.mp4" type="video/mp4">
        </video>
        </cfoutput>



















   





















    


        <!--- <div class="p-3"> --->

            <!--- <div align="center">

                <cfif SESSION.LANG_CODE eq "es" OR SESSION.LANG_CODE eq "it">
                    <video controls id="video_pres_vc_splash" width="80%" poster="./assets/img/method_virtualclass.jpg">
                    <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_en.mp4" type="video/mp4"></cfoutput>
                    </video>
                <cfelse>
                    <video controls id="video_pres_vc_splash" width="80%" poster="./assets/img/method_virtualclass.jpg">
                    <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_#SESSION.LANG_CODE#.mp4" type="video/mp4"></cfoutput>
                    </video>
                </cfif>

            </div> --->

           



            <!--- <cfif SESSION.LANG_CODE eq "es" OR SESSION.LANG_CODE eq "it">
                <cfoutput>#obj_translater.get_translate(id_translate='vc_discover_virtual_details',lg_translate="en")#</cfoutput>
            <cfelse>
                <cfoutput>#obj_translater.get_translate('vc_discover_virtual_details')#</cfoutput>
            </cfif> --->

            
        <!--- </div> --->
        
        





























    <!--------------------- VC SPLASH ------------->
    <cfelseif show_info eq "welcome_info">

        <cfset SESSION.ALERT_WELCOME = "1">

        <div>

            <div>
                <img src="./assets/img/header_modal_1.jpg" class="header_rounded_top border-bottom border-red" width="100%">
            </div>

            <div class="p-3">

                <h5><cfoutput>#obj_translater.get_translate('alert_info_title')#</cfoutput></h5>


                <p class="mt-3">
                    <cfoutput>#obj_translater.get_translate_complex('alert_info_text')#</cfoutput>
                </p>

                <div align="center" class="clearfix">
        
                    <a role="button" class="btn btn-link text-red m-0 mt-3" data-dismiss="modal">
                        [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                    </a>
                    
                    <!--- <cfif isdefined("SESSION.ACCESS_EL") AND SESSION.ACCESS_EL eq "1">
                        <a class="btn btn-red m-0 mt-3" href="./learner_virtual.cfm">
                            <cfoutput>#obj_translater.get_translate('vc_btn_manage_tp')#</cfoutput>
                        </a>
                    <cfelse>
                        <a class="btn disabled btn-red m-0 mt-3">
                            <cfoutput>#obj_translater.get_translate('vc_btn_explore_tp')#</cfoutput>
                        </a>
                    </cfif> --->

                    <a href="##" class="btn btn-red m-0 mt-3 btn_contact_wefit">
                        <cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput>
                    </a>
                </div>
            </div>

        </div>
        

    <!--------------------- VD SCHEDULE CONFIRMATION ------------->
    <cfelseif show_info eq "vc_confirm_booking">

        <!--------------------- ADD TO GG CALENDAR BTN ------------->
        <cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
        <cfset p_id = get_lesson.planner_id>
        <cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>	
        

        <div>

            <div>
                <img src="./assets/img/header_notif_confirm.jpg" class="header_rounded_top border-bottom border-red" width="100%">
            </div>

            <div class="p-3">
                
                <h5><cfoutput>#obj_translater.get_translate('js_confirm')#</cfoutput></h5>
                
                <cfoutput>#obj_translater.get_translate_complex('vc_confirm_booking')#</cfoutput>

                <br>
                
                <cfoutput>
                <cfset text_invite = encodeForURL("WEFIT LESSON with #ucase(get_planner.user_firstname)#")>
                <cfset desc_invite = encodeForURL("
                #obj_translater.get_translate('table_th_method')# : #ucase(get_lesson.method_name)#
                #obj_translater.get_translate('table_th_trainer')# : #ucase(get_planner.user_firstname)#
                #obj_translater.get_translate('table_th_duration_short')# : #get_lesson.lesson_duration#min 
                #obj_translater.get_translate('table_th_course')# : #get_lesson.sessionmaster_name#
                ")>
                <cfset start_invite = encodeForURL(dateformat(get_lesson.lesson_start,'yyyymmdd')&"T"&timeformat(get_lesson.lesson_start,'HHnnss')&"/"&dateformat(get_lesson.lesson_end,'yyyymmdd')&"T"&timeformat(get_lesson.lesson_end,'HHnnss'))>
                <cfset end_invite = "">
                <cfset link_go = "https://www.google.com/calendar/render?action=TEMPLATE&text=#text_invite#&details=#desc_invite#&dates=#start_invite#">
                <div align="center"><a href="#link_go#" target="_blank"><img src="./assets/img/invite_gg.gif"></a></div>
                </cfoutput>

                <div align="center" class="mt-3">
                    <button type="button" class="btn btn-red" data-dismiss="modal" aria-label="Close"><cfoutput>#obj_translater.get_translate('btn_understood')#</cfoutput></button>
                </div>

            </div>
            
        </div>


    <!--------------------- VC CANCEL CONFIRMATION ------------->
    <cfelseif show_info eq "vc_cancel_booking">

        <div>

            <div>
                <img src="./assets/img/header_notif_cancel.jpg" class="header_rounded_top border-bottom border-red" width="100%">
            </div>

            <div class="p-3">
                
                <h5><cfoutput>#obj_translater.get_translate('js_confirm')#</cfoutput></h5>
                
                <cfoutput>#obj_translater.get_translate_complex('vc_cancel_booking')#</cfoutput>

                <div align="center" class="mt-3">
                    <button type="button" class="btn btn-red" data-dismiss="modal" aria-label="Close"><cfoutput>#obj_translater.get_translate('btn_understood')#</cfoutput></button>
                </div>

            </div>

        </div>





    <!----------------- 1st LESSON BOOKING ------------------->
    <cfelseif show_info eq "tp_firstlesson">

        <div>

            <div>
                <img src="./assets/img/header_notif_congrats.jpg" class="header_rounded_top border-bottom-2 border-red" width="100%">
            </div>

            <div class="p-3">
                
                <h5><cfoutput>#obj_translater.get_translate('js_modal_title_firstlesson')#</cfoutput></h5>

                <cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_1')#</cfoutput>
                
                <p class="mb-0">
                <cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_2')#</cfoutput>
                </p>
                
                <!--- <div align="center"><a class="btn btn-red"> <span><cfoutput>#obj_translater.get_translate('btn_launch_lesson')#</cfoutput></span></a></div> --->
                <br>
                
                <p>
                <cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_3')#</cfoutput>
                </p>
                
                <p>
                <cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_4')#</cfoutput>
                </p>
                
                <p>
                <cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_5')#</cfoutput>
                </p>
                
                <div class="mt-2" align="center">
            
                    <a href="##" role="button" class="btn btn-red" data-dismiss="modal"><cfoutput>#obj_translater.get_translate('btn_understood')#</cfoutput></a>
                    
                </div>

            </div>

        </div>





    <!--------------------- VC DISCOVER WHEN NO EL ENABLE ------------->
    <cfelseif show_info eq "discover_virtualclass">

        <div>

            <div>
                <img src="./assets/img/header_modal_14.jpg" class="header_rounded_top border-bottom-2 border-red" width="100%">
            </div>

            <div class="p-3">

                <cfif SESSION.LANG_CODE eq "es" OR SESSION.LANG_CODE eq "it">
                    <h5><cfoutput>#obj_translater.get_translate(id_translate='vc_explain_virtual_title1',lg_translate="en")#</cfoutput></h5>
                    <cfoutput>#obj_translater.get_translate(id_translate='vc_explain_virtual_details1',lg_translate="en")#</cfoutput>
                    
                    <div align="center" class="my-3">
                        <video id="video_pres_vc_info" controls width="60%" poster="./assets/img/method_virtualclass.jpg">
                        <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_en.mp4" type="video/mp4"></cfoutput>
                        </video>
                    </div>

                    <h5><cfoutput>#obj_translater.get_translate(id_translate='vc_explain_virtual_title2',lg_translate="en")#</cfoutput></h5>
                    <cfoutput>#obj_translater.get_translate(id_translate='vc_explain_virtual_details2',lg_translate="en")#</cfoutput>
                <cfelse>
                    <h5><cfoutput>#obj_translater.get_translate('vc_explain_virtual_title1')#</cfoutput></h5>
                    <cfoutput>#obj_translater.get_translate('vc_explain_virtual_details1')#</cfoutput>
                    
                    <div align="center" class="my-3">
                        <video id="video_pres_vc_info" controls width="60%" poster="./assets/img/method_virtualclass.jpg">
                        <cfoutput><source src="#SESSION.BO_ROOT_URL#/assets/video/presentation_VC_#SESSION.LANG_CODE#.mp4" type="video/mp4"></cfoutput>
                        </video>
                    </div>
                    
                    <h5><cfoutput>#obj_translater.get_translate('vc_explain_virtual_title2')#</cfoutput></h5>
                    <cfoutput>#obj_translater.get_translate('vc_explain_virtual_details2')#</cfoutput>
                </cfif>

                <div align="center" class="clearfix">
                    <a role="button" class="btn btn-link text-red m-0 mt-3" data-dismiss="modal">
                        [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                    </a>
                    
                    <!---<cfif SESSION.ACCESS_EL eq "1">
                        <a class="btn btn-red m-0 mt-3" href="./learner_virtual.cfm">
                            <cfoutput>#obj_translater.get_translate('vc_btn_explore_tp')#</cfoutput>
                        </a>
                    <cfelse>
                        <a class="btn disabled btn-red m-0 mt-3">
                            <cfoutput>#obj_translater.get_translate('vc_btn_explore_tp')#</cfoutput>
                        </a>
                    </cfif>--->

                    <a href="##" class="btn btn-red m-0 mt-3 btn_contact_wefit">
                        <cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput>
                    </a>

                </div>

            </div>

        </div>

       


























    <!--------------------- VC EXPLANATION (OLD) ------------->
    <cfelseif show_info eq "explain_virtualclass">

        <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
        SELECT *
        FROM lms_level
        WHERE level_id NOT IN (0,6) 
        </cfquery>
        
        <div class="p-3">

            <p class="my-3" align="center"><em><cfoutput>#obj_translater.get_translate('vc_no_tpfollow_start')#</cfoutput></em></p>
            
            <div class="card mb-3 border">
                <div class="card-body">

                    <div class="w-100">
                        <h5 class="d-inline"><i class="fa-solid fa-circle-1 fa-lg text-red mr-2"></i> <cfoutput>#obj_translater.get_translate('vc_explain_virtual_box_title1')#</cfoutput></h5>
                        <hr class="border-red mb-4 mt-2">
                    </div>
                    <cfoutput>
                        <div align="center">
                            <video controls width="100%" id="video_tuto_vc" poster="./assets/img/method_virtualclass.jpg">
                            <source src="#SESSION.BO_ROOT_URL#/assets/video/tutorial_VC_#SESSION.LANG_CODE#.mp4" type="video/mp4">
                            </video>
                        </div>
                    </cfoutput>
                    
                </div>

            </div>

            <div class="card mb-3 border">
                <div class="card-body">

                    <div class="w-100">
                        <h5 class="d-inline"><i class="fa-solid fa-circle-2 fa-lg text-red mr-2"></i> <cfoutput>#obj_translater.get_translate('vc_explain_virtual_box_title2')#</cfoutput></h5>
                        <hr class="border-red mb-3 mt-2">
                    </div>


                    <div align="center">
                        <!--- <cfdump var="#SESSION.USER_LEVEL['en'].level_id#"> --->
                        <cfif StructKeyExists(SESSION.USER_LEVEL,'en')>
                            <cfset level_lock = SESSION.USER_LEVEL['en'].level_id>
                            <em><cfoutput>#obj_translater.get_translate('vc_explain_virtual_box_title3')#</cfoutput></em><br><br>
                        </cfif>
                            
                        <cfoutput query="get_level">
                            <cfif isdefined("level_lock")>
                             <a class="btn btn-outline-#level_alias# btn-lg p-2 px-3 btn_view_all_tp <cfif level_lock lt level_id-1 OR level_lock gt level_id+1>disabled</cfif>" id="lvl_#level_id#" data-dismiss="modal"> 
                                #obj_translater.get_translate('level')# #level_alias#
                            </a>
                            <cfelse>
                            <a class="btn btn-outline-#level_alias# btn-lg p-2 px-3 btn_view_all_tp" id="lvl_#level_id#" data-dismiss="modal"> 
                                #obj_translater.get_translate('level')# #level_alias#
                            </a>
                            </cfif>
                        </cfoutput>
                    </div>

                    
                </div>

            </div>

        </div>
					


















        

    <cfelseif show_info eq "discover_certif">


        <img src="./assets/img/1000_F_499587977_74icudwrqPqxF26K5U7O9weC1AAnq93g.jpg" class="mr-2 float-left" width="100%">
			
    <cfelseif show_info eq "discover_el">

 
        <img src="./assets/img/1000_F_448389005_EvnJXIoHnnQIggYFec2kBQdjEGa0Md6H.jpg" class="mr-2 float-left" width="100%">
									
    <cfelseif show_info eq "discover_visio">

 
        <img src="./assets/img/1000_F_331776223_RfSsrvsBXM1yoTfj6fZmOydtk2pl9NyR.jpg" class="mr-2 float-left" width="100%">
			













    <cfelseif show_info eq "launching_test">

        <div class="card border bg-light rounded-top">
            <div>
                <img src="./assets/img/header_modal_6.jpg" class="rounded-top rounded-3" width="100%">
            </div>
            <div class="card-body">
                <h5><cfoutput>#obj_translater.get_translate('alert_test_launch_title')#</cfoutput></h5>
                <!--- <hr class="border-red mb-2 mt-1"> --->
                <cfoutput>#obj_translater.get_translate_complex('alert_test_launch_text')#</cfoutput>
                
                <div align="center" class="clearfix">
                    <a role="button" class="btn btn-link text-red m-0 mt-3" data-dismiss="modal">
                        [<cfoutput>#obj_translater.get_translate('btn_skip')#</cfoutput>]
                    </a>

                    <a href="learner_launch_1.cfm?trigger_launch=1" class="btn btn-red m-0 mt-3">
                        <cfoutput>#obj_translater.get_translate('btn_go_send')#</cfoutput>
                    </a>
                </div>
            </div>

        </div>

    </cfif>



</cfif>





<script>
    $(document).ready(function() {
    
        $('.btn_contact_wefit').click(function(event) {	

        $('#window_item_sm').modal('hide');
        $('#window_item_lg').modal('hide');
        $('#window_item_xl').modal('hide');
        $('#window_item_xl_unclosable').modal('hide');

        $('#window_item_ctc').modal({keyboard: true});
        $('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
        $('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});

        });
    
    });

</script>
