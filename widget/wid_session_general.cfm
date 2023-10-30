<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>

<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
<cfset __with = obj_translater.get_translate('with')>
<cfset __min = obj_translater.get_translate('short_minute')>
<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfoutput query="get_session">

<cfif session_name neq "">
    <cfset format_title = "#session_name#">
<cfelse>
    <cfset format_title = "#sessionmaster_name#">
</cfif>

<cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_general" returnvariable="get_keyword_tracking_general">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_business" returnvariable="get_keyword_tracking_business">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_vocab_tracking" returnvariable="get_vocab_tracking">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_mapping_tracking" returnvariable="get_mapping_tracking">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfif lesson_id neq "">
    <cfset timehour = TimeFormat(lesson_start, "HH:mm")>
    <cfif dayOfWeek(lesson_start)-1 neq "0">
    <cfset timeday = listgetat(evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN"),dayOfWeek(lesson_start)-1)>
    <cfelse>
    <cfset timeday = DayOfWeekAsString(lesson_start)>
    </cfif>
    <cfset timeday = timeday&" "&dateFormat(lesson_start, "dd/mm")>
</cfif>

<div class="shadow-sm rounded border m-0 w-100 bg-light">

    <div class="card-body">

        <div class="row">

            <div class="col-md-4">
            
                <div class="card">
                                
                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                        <img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                        <img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
                    <cfelse>
                        <img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
                    </cfif>

                    <div class="card-body">

                        <div class="card-body">

                            <div class="d-flex justify-content-center">
                                <cfif lesson_id neq "">
                                <span class="badge badge-pill bg-A1 border border-A1 text-white bg-A1 text-white p-2 font-weight-normal" id="pill_#session_id#" style="font-size:16px">
                                    
                                    <img src="https://lms.wefitgroup.com/assets/user/#planner_id#/photo.jpg" width="35" class="border_thumb" title="DOUGLAS">
                                    <!--- <cfif planner_id neq "">
                                        <div align="center">#obj_lms.get_thumb_border(user_id="#planner_id#",size="35",class="border_thumb",display_title="#planner_firstname#")#</div>
                                    </cfif> --->
                                    <!--- <i class="fa-light fa-thumbs-up"></i> --->
                                             <i class="fa-light fa-calendar-alt"></i>
                                            <strong>#timeday# - #timehour#</strong>

                                    <!--- <strong>#obj_dater.get_dateformat(lesson_start)# - #timeformat(lesson_end,'HH:mm')#</strong> --->
    
                                </span>
                                <cfelse>
                                    <a class="btn btn_join_class btn-#level_alias# font-weight-normal" id="join_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#level_alias#" data-lduration="#lesson_duration#">
                                        #__btn_book_short#<!---<i class="fal fa-clock"></i>---> #session_duration# #__min#
                                    </a>
                                </cfif>
    
                            </div>
                            
                        </div>
                        
                    </div>
                </div>
                
            </div>

            <div class="col-md-8">

                <div class="d-flex flex-column h-100">

                
                    <div>
                        <h5 class="m-0">
                        <img src="./assets/img_formation/2.png" width="32" class="border_thumb mr-1">
                        
                        <img src="./assets/img_level/A1.svg" width="32" class="mr-1">
                        #format_title#
                        </h5>
                    </div>
                
                    <div>
                        <p class="mt-2">

                            <small>#sessionmaster_description#</small>
                            <br><br>
                            
                            


                            <cfif get_keyword_tracking_general.recordcount neq "0">

                                <strong><i class="fal fa-earth-europe" aria-hidden="true"></i> General English :</strong>
                                <br>
                                <cfloop query="get_keyword_tracking_general">
                                <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                                </cfloop>
                                <br><br>

                            </cfif>
                                
                            <cfif get_keyword_tracking_business.recordcount neq "0">

                                <strong><i class="fal fa-briefcase" aria-hidden="true"></i> Business Skills :</strong>
                                <br>
                                <cfloop query="get_keyword_tracking_business">
                                <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                                </cfloop>
                                <br><br>

                            </cfif>

                            <cfif get_vocab_tracking.recordcount neq "0">
                                <strong><i class="fal fa-language" aria-hidden="true"></i> Vocab List :</strong>
                                <br>
                                <cfloop query="get_vocab_tracking">
                                <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#voc_cat_name#</span>
                                </cfloop>
                                <br><br>

                            </cfif>

                            <cfif get_mapping_tracking.recordcount neq "0">
                                <strong><i class="fal fa-spell-check" aria-hidden="true"></i> Language Points :</strong>
                                <br>
                                <cfloop query="get_mapping_tracking">
                                <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px">#mapping_name#</span>
                                </cfloop>
                                <br><br>

                            </cfif>

                            
                            <!---<cfif get_vocab_tracking.recordcount neq "0">

                                <strong>Vocab lists : </strong>
                                <br>
                                <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px"><i class="fal fa-clock" aria-hidden="true"></i> VOCAB 1</span>
                            
                            </cfif>--->

                            <strong><i class="fa-light fa-file-pdf" aria-hidden="true"></i> Supports : </strong>
                            <br>
                            <cfinclude template="./wid_session_attachment.cfm">

                        </p>
                    </div>

                    <!--- <div class="mt-auto d-flex justify-content-between">
                        
                        <div align="center">

                        </div>
                        
                    </div> --->
                </div>

            </div>

        </div>

    </div>

</div>
</cfoutput>