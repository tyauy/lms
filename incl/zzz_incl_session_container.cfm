<cfif session_name neq "">
    <cfset format_title = "#session_name#">
<cfelse>
    <cfset format_title = "#sessionmaster_name#">
</cfif>
    
<div class="card border p-2 w-100 bg-light">

    <div id="<cfoutput>heading_#session_id#</cfoutput>" class="row">

        <div class="col-md-3">	
        
            <div class="card">

                <cfoutput>
                <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                    <img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
                <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                    <img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
                <cfelse>
                    <img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
                </cfif>

                
                <div class="card-body">
                    <div class="d-flex w-100 justify-content-center">
                        <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
                            <i class="fal fa-book fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
                        <cfelse>
                            <i class="fal fa-book fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
                        </cfif>

                        <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
                            <i class="fal fa-volume-up fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
                        <cfelse>
                            <i class="fal fa-volume-up fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
                        </cfif>

                        <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
                            <i class="fal fa-film fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
                        <cfelse>
                            <i class="fal fa-film fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
                        </cfif>
                    </div>
                    
                </div>
                </cfoutput>

            </div>
            
        </div>

        <div class="col-md-7">

            <cfoutput>
            <h6 class="m-0">#__lesson#&nbsp;#session_rank# : #format_title#</h6>

            <img src="./assets/img_formation/#formation_id#.png" width="32" class="border_thumb">

            <img src="./assets/img_level/#level_alias#.svg" width="32">

            <!--- <div> --->

                
                <!--- <img src="https://lms.wefitgroup.com/assets/user/#trainer_id#/photo.jpg" width="32" class="border_thumb" title=""> --->
            
                <!--- </div> --->

            
            <!--- <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-users"></i> #get_tp.method_name#</span>  --->
        
            <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-clock"></i> #session_duration# min</span> 
            
            

            <p class="mt-2">

                #sessionmaster_description#

            </p>

            <!---<div class="row justify-content-center">
                <a class="btn btn-sm btn-outline-info font-weight-normal p-1 m-1" data-toggle="collapse" href="##collapse_#session_id#" role="button" aria-expanded="false" aria-controls="collapse_#session_id#"><i class="far fa-chevron-double-down"></i> #obj_translater.get_translate('card_details')#</a>
            </div>--->

            <cfif isdefined("display_toolbox")>
            <div class="row justify-content-center">

                <div class="btn-group" role="group">
                    <button id="btn_#session_id#" type="button" class="btn bg-white btn-outline-#level_alias# font-weight-normal dropdown-toggle p-1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa-light fa-download"></i> #obj_translater.get_translate('vc_btn_download_resources')#
                    </button>
                    <div class="dropdown-menu" aria-labelledby="btn_#session_id#">

                        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
                            <a class="dropdown-item" href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_ws')#</a>
                        </cfif>
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                            <a class="dropdown-item" href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank"><i class="fas fa-file-pdf"></i> #obj_translater.get_translate('modal_link_wsk')#</a>
                        </cfif>	
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pptx")>
                            <a class="dropdown-item" href="./assets/materials/#sessionmaster_ressource#_WS.pptx" target="_blank"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a>
                        </cfif>
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.ppt")>
                            <a class="dropdown-item" href="./assets/materials/#sessionmaster_ressource#_WS.ppt" target="_blank"><i class="fas fa-file-powerpoint"></i> #obj_translater.get_translate('modal_link_ws')#</a>
                        </cfif>


                    </div>
                    </div>

                <!--- <a class="btn bg-white btn-outline-#get_tp.tplevel_alias# font-weight-normal p-1 disabled"><i class="fa-light fa-star"></i> #obj_translater.get_translate('vc_btn_rate_lesson')#</a> --->
                <a class="btn bg-white btn-outline-#level_alias# font-weight-normal p-1 disabled"><i class="fa-light fa-clapperboard-play"></i> #obj_translater.get_translate('vc_btn_view_recording')#</a>
                <a class="btn bg-white btn-outline-#level_alias# font-weight-normal p-1" href="learner_practice.cfm?sm_id=#sessionmaster_id#" target="_blank"><i class="fa-thin fa-laptop"></i> #obj_translater.get_translate('vc_btn_work_el')#</a>
            
                
            </div>
            </cfif>

            </cfoutput>

        </div>

        <div class="col-md-2">
            <!--- subscribed = #get_session.subscribed# --->
            <cfif lesson_id eq "">
                <!---<div class="btn btn-block m-0 btn-outline-#get_tp.tplevel_alias# disabled" data-tid="#tp_id#" data-lid="#lesson_id#" style="border:2px dashed !important">--->
                    
                    <h5 class="m-0" align="center"><span class="badge badge-pill badge-secondary">Not scheduled</span></h5>

                <!---</div>--->
                
            <cfelse>
                <cfoutput>
                <a name="lesson_#lesson_id#" id="lesson_#lesson_id#"></a>

                <cfif status_id eq "2" OR status_id eq "5">

                <cfelse>
                    <!--- // !MOVE TO VC 2 --->
                    <cfif subscribed eq 1>
                        <button class="btn disabled btn-lg p-0 py-3 btn-block m-0 btn-#level_alias#" data-tid="#tp_id#" data-lid="#lesson_id#" id="lesson_#tp_id#_#lesson_id#">
                            #dateformat(lesson_start,'dd/mm')# - #timeformat(lesson_start,'HH:mm')#
                            <br>
                            <h4 class="m-0"><i class="fa-light fa-check"></i></h4> 
                            <!--- #tp_id# --->
                            #obj_translater.get_translate('vc_btn_subscribed')#
                        </button>
                        <button class="btn btn-sm btn-outline-red m-0 mt-2 btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#" id="lesson_#tp_id#_#lesson_id#">
                            #obj_translater.get_translate('vc_btn_cancel_attendance')#
                        </button>
                        <cfset counter_book = "1">
                    <cfelse>
                        <cfif not isdefined("counter_book") AND get_subscribed_tp.recordcount neq "0">
                        <button class="btn btn-lg p-0 py-3 btn-block py-4 w-100 m-0 bg-white btn-outline-#level_alias# <cfif !StructKeyExists(SESSION.USER_LEVEL,formation_code) OR SESSION.USER_LEVEL[formation_code].level_id lt level_id-1>disabled<cfelse>btn_join_class</cfif>" 
                        data-tid="#tp_id#" data-lid="#lesson_id#" id="lesson_#tp_id#_#lesson_id#" style="border: 1px dashed !important"> 
                            <h6 class="m-0">#dateformat(lesson_start,'dd/mm')# - #timeformat(lesson_start,'HH:mm')#</h6>
                            <br>
                            <h4 class="m-0"><i class="fa-light fa-user-check"></i></h4>
                            <!--- #tp_id# --->
                            #obj_translater.get_translate('vc_btn_confirm_attendance')#
                        </button>
                        <cfset counter_book = "1">
                        <cfelse>
                            <button class="disabled btn btn-lg p-0 py-3 btn-block py-4 w-100 m-0 bg-white btn-outline-#level_alias# <cfif !StructKeyExists(SESSION.USER_LEVEL,formation_code) OR SESSION.USER_LEVEL[formation_code].level_id lt level_id-1>disabled<cfelse>btn_join_class</cfif>" 
                                id="lesson_#tp_id#_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" style="border:1px dashed !important"> 
                                <h6 class="m-0">#dateformat(lesson_start,'dd/mm')# - #timeformat(lesson_start,'HH:mm')#</h6>
                                <br>
                                <h4 class="m-0"><i class="fa-light fa-user-check"></i></h4>
                                <!--- #tp_id# --->
                                #obj_translater.get_translate('vc_btn_not_opened_seats')#
                            </button>
                        </cfif>
                    </cfif>
                </cfif>
            </cfoutput>

            </cfif>
            
            

        </div>
                
    </div>

    
    
                                                                        
        
    <!--- <div class="row collapse mt-2 pt-3" id="collapse_#session_id#" aria-labelledby="heading_#session_id#" data-parent="##tpgo">
    
        <div class="col-md-4">
            <div class="border-top border-red p-2 bg-white h-100">
                <h6 class="text-red"><i class="fas fa-plus-circle"></i> #__modal_supports#</h6>
                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WS.pdf")>
                    <a href="./assets/materials/#sessionmaster_ressource#_WS.pdf" target="_blank" class="text-red"><i class="fas fa-file-pdf"></i> #__modal_link_ws#</a><br>
                </cfif>
                <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_WSK.pdf")>
                    <a href="./assets/materials/#sessionmaster_ressource#_WSK.pdf" target="_blank" class="text-red"><i class="fas fa-file-pdf"></i> #__modal_link_wsk#</a><br>
                </cfif>	
                <cfloop from="1" to="3" index="cor">
                    <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4")>
                        <cfset video = "1">
                        <a href="./assets/materials/#sessionmaster_ressource#_VIDEO#cor#.mp4" target="_blank" class="text-red"><i class="fas fa-video"></i> #__modal_link_video# #cor#</a><br>
                    </cfif>
                </cfloop>
                <cfloop from="1" to="3" index="cor">
                    <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3")>
                        <cfset audio = "1">
                        <a href="./assets/materials/#sessionmaster_ressource#_AUDIO#cor#.mp3" target="_blank" class="text-red"><i class="fas fa-volume-up"></i> #__modal_link_audio# #cor#</a><br>
                    </cfif>
                </cfloop>	
            </div>
        </div>
        <div class="col-md-4">
            <div class="border-top border-success p-2 bg-white h-100">
                <h6 class="text-success"><i class="fas fa-plus-circle"></i> #__card_tp_exercice#</h6>
                
                <cfif quiz_id neq "">
                    <cfquery name="get_quiz_id" datasource="#SESSION.BDDSOURCE#">
                    SELECT qu.quiz_user_id
                    FROM lms_quiz_user qu
                    INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
                    WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                    </cfquery>
                    
                    <cfif get_quiz_id.recordcount neq "0">

                        <cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
                        SELECT SUM(ans_gain) as score
                        FROM lms_quiz_result
                        WHERE quiz_user_id = #get_quiz_id.quiz_user_id#
                        </cfquery>
                                                                                        
                        <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
                        SELECT SUM(ans_gain) as quiz_score
                        FROM lms_quiz_answer a 
                        INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
                        INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
                        WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                        </cfquery>
                        
                        <cfif get_result_score.score neq "">
                            <cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
                        <cfelse>
                            <cfset global_note = "0">
                        </cfif>

                        <cfif global_note gte 80>
                            <cfset cssgo = "success">
                        <cfelseif global_note gt 20 AND global_note lt 80>
                            <cfset cssgo = "warning">
                        <cfelseif global_note lte 20>
                            <cfset cssgo = "danger">
                        </cfif>
                    
                        <div class="row">
                            <div class="col-md-12">
                                <div align="center" class="mt-2">
                                    <h5 class="m-0"><span class="badge badge-pill badge-#cssgo# text-white">Quiz : #global_note# %<!--- / #get_quiz_score.quiz_score#----></span></h5>
                                </div>
                                
                                <div align="center">
                                    <a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_quiz_id.quiz_user_id#"><i class="fas fa-tasks"></i> #__btn_results#</a>
                                </div>
                                
                            </div>
                        </div>
                                
                    </cfif>				
                </cfif>
            </div>
        </div>
        <cfif SESSION.LANG_CODE eq "fr">
        <div class="col-md-4">
            <div class="border-top border-secondary p-2 bg-white h-100">
                <h6 class="text-secondary"><i class="fas fa-plus-circle"></i> #__card_tp_lessonnote#</h6>
                <cfoutput group="lesson_id">																				
                <cfif note_id neq "">
                    <a target="_blank" class="text-secondary" href="./tpl/ln_container.cfm?l_id=#lesson_id#"><i class="fas fa-file-pdf"></i> Lesson Notes</a>
                </cfif>
                </cfoutput>
                
                <cfif lesson_id neq "">
                    <cfset counter = 0>
                    <cfloop query="dirQuery">
                    <cfif findnocase("#get_session.lesson_id#_",#dirQuery.name#)>
                    <cfset counter ++>
                    <a target="_blank" class="text-secondary" href="./assets/attachment/#dirQuery.name#"><i class="fas fa-file-pdf"></i> Attachment #counter#</a><br>																					
                    </cfif>																					
                    </cfloop>
                </cfif>
                
                <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND method_id eq "2">
                <a class="btn btn-sm btn-outline-info btn_ln_upload" id="l_#lesson_id#" href="##"><i class="fas fa-file-upload" title="#__tooltip_fill_ln#"></i> #__btn_upload_notes#</a>
                </cfif>
                
            </div>
        </div>
        </cfif>

    </div> --->

</div>