<cfoutput>
<!---- GET INDEX OF ARRAY T --->
<cfloop from="1" to="#arrayLen(array_t)#" index="counter">
    <cfif array_t[counter].planner_id IS user_id>
        <cfset arrayIndex = counter>
    </cfif>
</cfloop>

<!---- OBJ QUERIES--->
<cfset get_teaching = obj_query.oget_teaching(p_id="#user_id#")>
<cfset get_speaking = obj_query.oget_speaking(p_id="#user_id#")>
<cfset get_workinghour = obj_query.oget_workinghour(p_id="#user_id#")>

<!---- HARD QUERIES--->
<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#"> AND status_id <> 3
</cfquery>

<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
SELECT COUNT(DISTINCT(t.user_id)) as nb FROM lms_tp t
INNER JOIN lms_tpplanner p ON p.tp_id = t.tp_id
WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
    SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
</cfquery>

<div class="row">
    <div class="col-12">

        <!--- <cfif SESSION.USER_ID eq "7767">

        <cfif array_t[arrayIndex].score_global lt 50>
            <cfset t_css = "warning">
        <cfelseif array_t[arrayIndex].score_global gte 50>
            <cfset t_css = "info">
        </cfif>

        <h6 class="text-#t_css# d-inline">SCORE DISPONIBILITÉS : #array_t[arrayIndex].score_accuracy# // SCORE CHARGE = #array_t[arrayIndex].score_charge# // SCORE GLOBAL  = #array_t[arrayIndex].score_global#%</h6>
        <div class="progress" style="height: 2px;">
           <div class="progress-bar bg-info" role="progressbar" style="width: #array_t[arrayIndex].score_global#%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
        </div>

        <table class="table table-sm border bg-light p-2"> 
            <tr> 
                <td width="20%"> 
                    LESSONS 
                </td> 
                <td> 
                    <strong>#array_t[arrayIndex].h_activity#h (#array_t[arrayIndex].h_activity_rate#%)</strong> 
                </td> 
                <td rowspan="5"> 
                    <a href="common_trainer_blocker.cfm?p_id=#user_id#" target="_blank">[SEE CALENDAR]</a> 
                </td> 
            </tr> 
            <tr> 
                <td> 
                    BLOCKERS 
                </td> 
                <td> 
                    <strong>#array_t[arrayIndex].h_blocker#h (#array_t[arrayIndex].h_blocker_rate#%)</strong> 
                </td> 
            </tr> 
            <tr> 
                <td> 
                    BUSINESS HOURS 
                </td> 
                <td> 
                    <strong>#array_t[arrayIndex].h_business#h</strong> 
                </td> 
            </tr> 
            <tr> 
                <td> 
                    EFFECTIVE SLOTS 
                </td> 
                <td> 
                    <strong>#array_t[arrayIndex].h_slot#h</strong> 
                </td> 
            </tr> 
            <tr> 
                <td> 
                    CHARGE 
                </td> 
                <td> 
                    <strong><cfif array_t[arrayIndex].score_charge neq "NA">#100-array_t[arrayIndex].score_charge#%</cfif></strong> 
                </td> 
            </tr> 
        </table>
        </cfif> --->
                        
        <div class="card border">
            <div class="card-body">
                <div class="row">

                    <div class="col-lg-2 col-md-3 d-flex justify-content-center">
                        <div class="pt-3 pl-3" align="center">

                            <div>
                            #obj_lms.get_thumb(user_id="#user_id#",size="130")#
                            </div>

                            <div class="clearfix"></div>

                            <button class="btn btn-link text-info btn-block btn_view_trainer" id="trainer_#user_id#" >
                                <!--- <i class="fal fa-address-card"></i> --->
                                [#obj_translater.get_translate('btn_view_profile')#]
                            </button>
                        
                            <label class="btn btn-red btn-block text-nowrap text-white" style="white-space: normal !important">
                                <input type="checkbox" value="#user_id#" id="t_#user_id#" class="btn_choose_trainer"> 
                                #ucase(obj_translater.get_translate('btn_choose_this_trainer'))#
                            </label>

                        </div>
                    </div>

                    <div class="col-lg-5 col-md-9">
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
                            <div class="clearfix mt-3"></div>

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
                            </cfloop>
                            <br><br>
                            <table class="table table-sm table-borderless">
                                <tr align="center">
                                    <td width="33%"><i class="fal fa-users fa-2x text-info"></i></td>
                                    <td width="33%"><i class="fal fa-chalkboard-teacher fa-2x text-info"></i></td>
                                    <!--- <td width="33%"><i class="fal fa-history fa-2x text-info"></i></td> --->
                                    <!--- <td width="25%"><i class="fal fa-star fa-lg text-info"></i></td> --->
                                </tr>
                                <tr align="center">
                                    <td>#get_learner.nb+user_add_learner#<br>#obj_translater.get_translate('table_th_learners')#</td>
                                    <td>#get_lesson.nb+user_add_course#<br>#obj_translater.get_translate('lessons')#</td>
                                    <!--- <td>#obj_translater.get_translate('table_th_since')#<br><cfif user_create neq "">#year(user_create)#<cfelse>NC</cfif></td> --->
                                    <!--- <td><cfif get_rating.sum_rating gte 1>#numberformat(get_rating.avg_rating,'_._')#<br>#get_rating.sum_rating# vote<cfif get_rating.sum_rating gt 1>(s)</cfif><cfelse>-</cfif></td> --->
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="col-lg-5 col-md-12">
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
                                        <cfif array_t[arrayIndex].score_accuracy eq 0>
                                            <i class="fa fa-exclamation" aria-hidden="true" style="color: red"></i>
                                        </cfif> 
                                        #obj_translater.get_translate('table_th_availabilities')#
                                    </a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade <cfif display eq "video"> show active</cfif>" id="video_#user_id#" role="tabpanel">
                                    <!---<cfif user_video neq "">	
                                        <div class="video-container m-4">
                                            <iframe src="#user_video#" width="100%" height="180" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
                                        </div>
                                    </cfif>--->
                                    <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/video.mp4")>
                                        <video controls preload width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#user_id#/photo_video.jpg")>poster="./assets/user/#user_id#/photo_video.jpg"</cfif>>
                                            <source src="#SESSION.BO_ROOT_URL#/assets/user/#user_id#/video.mp4" type="video/mp4">
                                                <!--- <p> --->
                                                <!--- <cfset user_id = get_trainer_go.user_id> --->
                                                <!--- <cfset arr = ['SESSION.BO_ROOT_URL', 'user_id']> --->
                                                <!--- <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->
                                                <!--- #obj_translater.get_translate_complex(id_translate="download_trainer_video", argv="#argv#")#</p> --->
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
                                    <cfif array_t[arrayIndex].score_accuracy eq 0>
                                        <i class="fa fa-exclamation" aria-hidden="true" style="color: red"></i>
                                        <span>#obj_translater.get_translate('table_th_availabilities_ol_warning')#</span>
                                    </cfif> 
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