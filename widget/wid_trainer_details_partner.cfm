<cfoutput>
    
    <!---- OBJ QUERIES--->
    <cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
    <cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
    <cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>

    <div class="row">
        <div class="col-12">
                            
            <div class="card border">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2 col-3 d-flex justify-content-center">
                            <div class="pt-3 pl-3" align="center">
    
                                <div>
                                #obj_lms.get_thumb(user_id="#user_id#",size="130")#
                                </div>
    
                                <div class="clearfix"></div>
    
                                <button class="btn btn-outline-red btn-block btn_view_trainer" id="trainer_#user_id#">
                                    <i class="fal fa-address-card"></i>
                                    #obj_translater.get_translate('btn_view_profile')#
                                </button>
                            
                                <button class="btn btn-red btn-block btn_choose_trainer" id="trainer_#user_id#">
                                #ucase(obj_translater.get_translate('btn_choose_this_trainer'))#
                                </button>
    
                            </div>
                        </div>
                        <div class="col-md-5 col-9">
                            <div class="p-3">
                                <!---#user_id# - <img src="./assets/css/flags/blank.gif" class="flag_lg flag-#lcase(country_alpha)# mr-3" align="left">---> 
                                <!--- <cfif user_based neq ""><br>#obj_translater.get_translate('lives')#</cfif> --->
                                <!--- <div class="d-inline pull-right"><i class="fas fa-heart fa-lg grey"></i></div> --->
                                <!---<br>
                                    #obj_translater.get_translate('table_th_specialities')# : <cfloop list="#speciality_id#" index="cor"><span class="badge badge-outline" style="font-size:12px">#SESSION.SPECIALITY.speciality_name[cor]#</span> </cfloop>
                                    <br>
                                --->
                                <strong style="font-size:22px" class="text-dark">#user_firstname# <!---<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif>---></strong>
                                <br><br>
                                <small><strong>#obj_translater.get_translate('table_th_teaches')# :</strong></small>
                                <br>
                                    <cfloop query="get_teaching">
                                    
                                        <span class="lang-lg" lang="#get_teaching.formation_code#" style="top:4px"></span>
                                            <!---<td align="left">
                                            <cfloop list="#get_teaching.level_id#" index="cor">
                                            <span class="badge bg-white border">
                                            <cfif cor eq "0">A0
                                            <cfelseif cor eq "1">A1
                                            <cfelseif cor eq "2">A2
                                            <cfelseif cor eq "3">B1
                                            <cfelseif cor eq "4">B2
                                            <cfelseif cor eq "5">C1
                                            <cfelseif cor eq "6">C2
                                            </cfif>
                                            </span>
                                            </cfloop>--->
                                    </cfloop>
                                <!---<div class="clearfix mt-3"></div>
    
                                <small><strong>#obj_translater.get_translate('table_th_speaks')# :</strong></small>
                                <br>
                                <cfloop query="get_speaking">
                                    <span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
                                    #get_speaking.formation_name# 
                                    <cfset level_id = get_speaking.level_id>
                                    <div class="clearfix"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    <div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
                                    </span>
                                </cfloop> --->
                            </div>
                        </div>
                        <div class="col-md-5 col-12">
                            <div class="p-3">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link <cfif display eq "video">active</cfif>" data-toggle="tab" href="##video_#user_id#" role="tab" aria-controls="video_#user_id#" aria-selected="true">#obj_translater.get_translate('btn_el_video')#</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <cfif display eq "aboutme">active</cfif>" data-toggle="tab" href="##about_#user_id#" role="tab" aria-controls="about_#user_id#" aria-selected="false">#obj_translater.get_translate('table_th_about_me')#</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link <cfif display eq "agenda">active</cfif>" data-toggle="tab" href="##agenda_#user_id#" role="tab" aria-controls="agenda_#user_id#,  -" aria-selected="false">
                                           #obj_translater.get_translate('table_th_availabilities')#
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade <cfif display eq "video"> show active</cfif>" id="video_#user_id#" role="tabpanel">
               
                                        <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>
                                            <video controls preload width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo_video.jpg")>poster="./assets/user/#user_id#/photo_video.jpg"</cfif>>
                                                <source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4">
                                            </video>
                                        <cfelse>
                                            <div align="center" class="mt-4">
                                                <h2 class="text-muted"><i class="fal fa-stopwatch fa-3x"></i></h2>																							
                                                #obj_translater.get_translate('coming_soon')#
                                            </div>
                                        </cfif>
                                    </div>
    
    
                                    <cfsilent>
                                    <cfquery name="get_user_about" datasource="#SESSION.BDDSOURCE#">
                                        SELECT ua.*, uaq.about_question_#SESSION.LANG_CODE# as quest 
                                        FROM user_about ua 
                                        INNER JOIN user_about_question uaq ON uaq.user_about_question_id = ua.user_about_type 
                                        WHERE ua.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> 
                                        ORDER BY RAND()
                                        LIMIT 5
                                    </cfquery>
                                    <cfquery name="get_user_paragraph" datasource="#SESSION.BDDSOURCE#">
                                    SELECT *
                                    FROM user_about
                                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> and user_about_type = 0
                                    </cfquery>
                                    </cfsilent>
    
    
                                    <div class="tab-pane fade <cfif display eq "aboutus"> show active</cfif>" id="about_#user_id#" role="tabpanel">
                                        <cfif get_user_paragraph.recordcount neq "0">
                                            <br>#get_user_paragraph.user_about_desc#
                                        <cfelse>
                                            <cfloop query="get_user_about">
                                                <br><strong class="text-muted">#quest#</strong><br>#user_about_desc#
                                            </cfloop>
                                        </cfif>
                                        
                                    </div>
                                    
                                    <div class="tab-pane fade <cfif display eq "agenda"> show active</cfif>" id="agenda_#user_id#" role="tabpanel">
                                        <div class="my-4">
                                            <cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
                                                <cfinvokeargument name="u_id" value="#user_id#">
                                            </cfinvoke>
                                            <cfset planner_view = "view_toggle_vertical_read">
                                            <cfset remove_day = "6">
                                            <cfinclude template="../widget/wid_planner.cfm">
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
    </cfoutput>