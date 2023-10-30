<!--------------------- CUSTOM NAME ------------------->
<cfparam name="display_tab">

<cfif session_name neq "">
    <cfset format_title = "#session_name#">
<cfelse>
    <cfset format_title = "#sessionmaster_name#">
</cfif>

<!--------------------- LESSON ATTACHED TO SESSION ------------------->
<cfif lesson_id neq "">
    <cfset timehour = TimeFormat(lesson_start, "HH:mm")>
    <cfif dayOfWeek(lesson_start)-1 neq "0">
    <cfset timeday = listgetat(evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN"),dayOfWeek(lesson_start)-1)>
    <cfelse>
    <cfset timeday = DayOfWeekAsString(dayOfWeek(lesson_start))>
    </cfif>
    <cfset timeday = timeday&" "&dateFormat(lesson_start, "dd/mm")>
</cfif>

<!--------------------- COLOR AND DISABLED SETTINGS ------------------->
<cfif method_id eq "10">
    <cfif lesson_id neq "" AND (lesson_start eq "" OR lesson_start gt now())>
        <cfset color_border = level_alias>
        <cfset color_text = level_alias>
    <cfelse>
        <cfset color_border = "">
        <cfset color_text = "dark">
    </cfif>
    
    <cfset limit_date = dateadd("m","5",now())>

<cfelse>
    <cfset color_border = "">
    <cfset color_text = "dark">
    
    <cfset limit_date = dateadd("m","15",now())>

</cfif>



<div class="mt-3">

    <cfoutput>
    <div class="d-flex justify-content-between">

        <div class="rounded-top border-top border-left border-right border-#color_border# bg-light m-0 pt-2 pb-1 px-3">
            <strong class="text-#color_text#">
            <i class="fa-light #tp_icon# fa-lg mr-1 text-#color_text#"></i> #display_tab#
            </strong>
        </div>

        <cfif not isdefined("display_toolbox") AND level_alias neq "">
            <a class="btn btn-link btn_view_tp cursored m-0 text-#level_alias#" id="tp_#tp_id#_details">[ #__btn_view_series# ]</a>
        </cfif>
    </div>
    </cfoutput>

    <div class="shadow-sm rounded-bottom border <cfoutput>border-#color_border#</cfoutput> m-0 w-100 bg-light" style="min-height:250px; margin-top:-1px !important">
       
        <div class="card-body">

            <div id="<cfoutput>heading_#session_id#</cfoutput>" class="row">

                <div class="<cfif isdefined("display_toolbox")>col-md-3<cfelse>col-md-4</cfif>">
                
                    <div class="card m-0">

                        <cfoutput>
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                            <img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                            <img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
                        <cfelse>
                            <img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
                        </cfif>

                        
                        <div class="card-body">

                            <div class="d-flex justify-content-center">

                                <img src="./assets/img_formation/#formation_id#.png" width="32" class="border_thumb mr-1">
                            
                                <cfif level_alias neq "" AND level_id neq "0"><img src="./assets/img_level/#level_alias#.svg" width="32" class="mr-1"></cfif>
                        
                                <img src="https://lms.wefitgroup.com/assets/user/#planner_id#/photo.jpg" width="32" class="border_thumb" title="#planner_firstname#">
                                
                            </div>
                            
                        </div>
                        </cfoutput>

                    </div>
                    <!-------------- VC ONLY ----------->
                    <cfif method_id eq "10">
                    <div align="center">

                        <cfoutput> 
                        <cfif lesson_id eq "">
                            <a class="btn btn-#level_alias# font-weight-normal disabled">
                                #__btn_not_scheduled#
                            </a>
                        <cfelse>
                            <cfif lesson_start gt now()>
                                <span class="badge badge-pill border border-dark bg-white px-2 py-2 mt-2" data-toggle="tooltip" data-placement="top">
                                <i class="fa-light fa-users"></i>
                                <span id="remaining_#lesson_id#">#seats_used# / #seats_total#
                                </span>
                            </cfif>
                        </cfif>
                        </cfoutput> 
                        
                    </div>
                    </cfif>
                    
                </div>



                <div class="<cfif isdefined("display_toolbox")>col-md-9<cfelse>col-md-8</cfif>">

                    <div class="d-flex flex-column h-100">

                        <cfoutput>
                        <div>
                            <h6 class="m-0"><cfif SESSION.USER_ID eq "5373" or SESSION.USER_ID eq "202">#lesson_id#- </cfif><!---#__lesson#&nbsp;#session_rank# : --->#format_title# </h6>
                        </div>
                    
                        <div>
                            <p class="mt-2">

                                <small>#sessionmaster_description#</small>

                            </p>
                        </div>

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
                            <!--- <cfif lesson_start lte now()>
                                <a class="btn bg-white btn-outline-#level_alias# font-weight-normal p-1 <cfif lesson_url eq "">disabled"</cfif>><i class="fa-light fa-clapperboard-play"></i> #obj_translater.get_translate('vc_btn_view_recording')#</a>
                            </cfif> --->

                            <a class="btn bg-white btn-outline-#level_alias# font-weight-normal p-1" href="learner_practice.cfm?sm_id=#sessionmaster_id#" target="_blank"><i class="fa-thin fa-laptop"></i> #obj_translater.get_translate('vc_btn_work_el')#</a>
                        
                            
                        </div>
                        </cfif>
                        

                        <div class="mt-auto w-100">

                            <!------------ ALL LESSON BUT NO VC ----------->
                            <cfif method_id neq "10">

                                <div class="d-flex justify-content-end align-items-end">
                                    <span class="badge badge-pill bg-red border border-red text-white px-2 py-2 font-weight-normal" id="pill_#lesson_id#" style="font-size:14px">
                                    <i id="i_#lesson_id#" class="fa-light fa-calendar-alt text-white"></i>
                                    <strong>#timeday# - #timehour#</strong>
                                    </span>
                                </div>

                                <div class="d-flex justify-content-end align-items-end">
                                    
                                    <cfif lesson_id neq "">
                                    <div>
                                        <button class="btn btn-outline-red btn_view_lesson font-weight-normal" id="cancel_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#level_alias#" data-lduration="#lesson_duration#">
                                            #__btn_cancel_short#
                                        </button>
                                    </div>

                                    <div>
                                        <!--- <button class="btn btn-red <cfif lesson_start lt limit_date>disabled<cfelse>btn_launch_lesson</cfif> font-weight-normal" id="l_#lesson_id#">
                                        #obj_translater.get_translate('btn_launch_lesson')#
                                        </button> --->

                                        <button class="btn btn-red btn_launch_lesson font-weight-normal" id="l_#lesson_id#">
                                        #obj_translater.get_translate('btn_launch_lesson')#
                                        </button>
                                        
                                    </div>
                                    </cfif>

                                </div>
                                        <!--- <a class="btn btn-sm btn-outline-danger btn_view_lesson float-right" role="button" data-toggle="tooltip" data-placement="top" title="#__cancel#" id="l_#lesson_id#" href="##"><i class="far fa-calendar-times"></i></a> --->
                                                    
                                        
                                        <!--- <button class="btn btn-sm btn-outline-red font-weight-normal" id="lesson_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#">
                                            #obj_translater.get_translate('global_details')#
                                        </button> --->
                                        

                        
                            <cfelse>

                                <!------------ SPECIAL VC ----------->
                                <cfif lesson_start gte now()>
                                <cfif subscribed neq "1">
                                    
                                    <div class="d-flex justify-content-end align-items-end">
                                        <span class="badge badge-pill bg-white border border-#level_alias# text-#level_alias# px-2 py-2 font-weight-normal" id="pill_#lesson_id#" style="font-size:14px">
                                        <i id="i_#lesson_id#" class="fa-light fa-calendar-alt text-#level_alias#"></i>
                                        <strong>#timeday# - #timehour#</strong>
                                        </span>
                                    </div>
                                    <cfif not isdefined("prevent_booking")>
                                    <div class="d-flex justify-content-end align-items-end">
                                        <div>
                                            <!-------- CHECK IF CERTIF VC ------->
                                            <cfif level_id eq "0">
                                                <a class="d-block btn btn_join_class btn-red font-weight-normal" id="join_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#level_alias#" data-lduration="#lesson_duration#">
                                                    #__btn_book_short#<!---<i class="fal fa-clock"></i>---> #session_duration# #__min# 
                                                </a>
                                            <cfelse>
                                                <cfif level_id neq "">
                                                    <a class="d-block btn <cfif !StructKeyExists(SESSION.USER_LEVEL,formation_code) OR SESSION.USER_LEVEL[formation_code].level_id lt level_id-1 OR SESSION.USER_LEVEL[formation_code].level_verified eq "0">disabled<cfelse>btn_join_class</cfif> btn-#level_alias# font-weight-normal" id="join_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#level_alias#" data-lduration="#lesson_duration#">
                                                        #__btn_book_short#<!---<i class="fal fa-clock"></i>---> #session_duration# #__min# 
                                                    </a>
                                                </cfif>
                                            </cfif>
                                            
                                        </div>
                                    </div>
                                    </cfif>

                                <cfelse>

                                    <div class="d-flex justify-content-end align-items-end">
                                        <span class="badge badge-pill bg-red border border-red text-white text-white px-2 py-2 font-weight-normal" id="pill_#lesson_id#" style="font-size:14px">
                                        <i id="i_#lesson_id#" class="fa-light fa-calendar-alt text-white"></i>
                                        <strong>#timeday# - #timehour#</strong>
                                        </span>
                                    </div>

                                    <div class="d-flex justify-content-end align-items-end">
                                        <div>
                                            <a class="d-block btn btn_join_class btn-outline-red font-weight-normal" id="join_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#level_alias#" data-lduration="#lesson_duration#">
                                                #__btn_cancel_short#
                                            </a>
                                        </div>
                                        <div>
                                            <button class="btn btn-red btn_launch_lesson font-weight-normal" id="l_#lesson_id#">
                                            #obj_translater.get_translate('btn_launch_lesson')#
                                            </button>
                                            
                                            <!--- <button class="btn btn-red <cfif lesson_start lt limit_date>disabled<cfelse>btn_launch_lesson</cfif> font-weight-normal" id="l_#lesson_id#">
                                            #obj_translater.get_translate('btn_launch_lesson')#
                                            </button> --->
                                        </div>
                                    </div>
                                    
                                </cfif>
                                </cfif>

                            </cfif>

                        </div>
                        </cfoutput>
                    
                    </div>

                </div>



                <!---<div class="col-md-2">

                    <cfif lesson_id eq "">
                        <!---<div class="btn btn-block m-0 btn-outline-#get_tp.tplevel_alias# disabled" data-tid="#tp_id#" data-lid="#lesson_id#" style="border:2px dashed !important">--->
                            
                            <h5 class="m-0" align="center"><span class="badge badge-pill badge-secondary">Not scheduled</span></h5>

                        <!---</div>--->
                        
                    <cfelse>
                        <cfoutput>
                        <a name="lesson_#lesson_id#" id="lesson_#lesson_id#"></a>

                        <cfif status_id eq "2" OR status_id eq "5">

                        <cfelse>
                            <cfif subscribed eq 1>
                                <button class="btn disabled btn-lg p-0 py-3 btn-block m-0 btn-#level_alias# btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#" id="lesson_#tp_id#_#lesson_id#">
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
                                <button class="btn btn-lg p-0 py-3 btn-block py-4 w-100 m-0 bg-white btn-outline-#level_alias# btn_join_class" data-tid="#tp_id#" data-lid="#lesson_id#" id="lesson_#tp_id#_#lesson_id#" style="border: 1px dashed !important"> 
                                    <h6 class="m-0">#dateformat(lesson_start,'dd/mm')# - #timeformat(lesson_start,'HH:mm')#</h6>
                                    <br>
                                    <h4 class="m-0"><i class="fa-light fa-user-check"></i></h4>
                                    <!--- #tp_id# --->
                                    #obj_translater.get_translate('vc_btn_confirm_attendance')#
                                </button>
                                <cfset counter_book = "1">
                                <cfelse>
                                    <button class="disabled btn btn-lg p-0 py-3 btn-block py-4 w-100 m-0 bg-white btn-outline-#level_alias# btn_join_class" id="lesson_#tp_id#_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" style="border:1px dashed !important"> 
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
                    
                    

                </div>--->
                        
            </div>

        </div>

    </div>
</div>