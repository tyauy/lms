<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
<body>
<cfsilent>
    <cfquery name="get_trainer_info" datasource="#SESSION.BDDSOURCE#">

        SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
            c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
            s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
            FROM user u
            LEFT JOIN settings_country c ON c.country_id = u.country_id
            LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
            WHERE u.user_id = #user_id#
    </cfquery>
</cfsilent>
<cfset display = "video">

<cfoutput query="get_trainer_info">
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
    
            <div class="card border">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2 col-3 d-flex justify-content-center">
                            <div class="pt-3 pl-3" align="center">
    
                                <div>
                                #obj_lms.get_thumb(user_id="#user_id#",size="130")#
                                </div>
    
                                <div class="clearfix"></div>
    
                                <button class="btn btn-info btn-block btn_view_trainer" id="trainer_#user_id#" >
                                    <i class="fal fa-address-card"></i>
                                    #obj_translater.get_translate('btn_view_profile')#
                                </button>
                            
    
                            </div>
                        </div>
                        <div class="col-md-5 col-9">
                            <div class="p-3">
                                <strong style="font-size:22px" class="text-dark">#user_firstname# <!---<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif>---></strong>
                                <br><br>
                                <small><strong>#obj_translater.get_translate('table_th_teaches')# :</strong></small>
                                <br>
                                    <cfloop query="get_teaching">
                                    
                                        <span class="lang-lg" lang="#get_teaching.formation_code#" style="top:4px"></span>
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
                                    </tr>
                                    <tr align="center">
                                        <td>#get_learner.nb+user_add_learner#<br>#obj_translater.get_translate('table_th_learners')#</td>
                                        <td>#get_lesson.nb+user_add_course#<br>#obj_translater.get_translate('lessons')#</td>
                                    </tr>
                                </table>
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
                                    <li class="nav-item">
                                        <a class="nav-link <cfif display eq "personality">active</cfif>" data-toggle="tab" href="##personality_#user_id#" role="tab" aria-controls="personality_#user_id#,  -" aria-selected="false">
                                            <!---#obj_translater.get_translate('table_th_personality')#--->
                                            Personalities
                                        </a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link <cfif display eq "badge">active</cfif>" data-toggle="tab" href="##badge_#user_id#" role="tab" aria-controls="badge_#user_id#,  -" aria-selected="false">
                                           <!--- #obj_translater.get_translate('table_th_badge')#--->
                                           Badges
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
                                        
                                        <cfquery name="get_user_personality" datasource="#SESSION.BDDSOURCE#">
                                            SELECT perso_id, COUNT(up.personality_id) AS count, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index upi
                                            INNER JOIN user_personality up ON up.personality_id = upi.perso_id
                                            WHERE up.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                            GROUP BY up.personality_id
                                            ORDER BY count DESC
                                            LIMIT 3
                                        </cfquery>

                                        <cfquery name="get_user_badge" datasource="#SESSION.BDDSOURCE#">
                                            SELECT lbi.badge_id, COUNT(lba.badge_id) AS count, badge_name_#SESSION.LANG_CODE# as badge_name FROM lms_badge_index lbi
                                            INNER JOIN lms_badge_attribution lba ON lba.badge_id = lbi.badge_id
                                            WHERE lba.badge_trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                                            GROUP BY lba.badge_id
                                            ORDER BY count DESC
                                            LIMIT 3
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
                                            <cfinclude template="./widget/wid_planner.cfm">
                                        </div>
                                    </div>

                                    <div class="tab-pane fade <cfif display eq "personality"> show active</cfif>" id="personality_#user_id#" role="tabpanel">
                                        <table>
                                            <tbody>
                                                <cfloop query="get_user_personality">
                                                    <tr>
                                                        <td>
                                                            <img src="./assets/img_personality/#perso_id#_G.svg" height="60" width="60" alt="#perso_name#" title="#perso_name#" />
                                                        </td>
                                                        <td>
                                                            <span>#perso_name#</span>
                                                        </td>
                                                        <td>
                                                            <span>(#count# recommendations)</span>
                                                        </td>
                                                    </tr>
                                                </cfloop>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="tab-pane fade <cfif display eq "badge"> show active</cfif>" id="badge_#user_id#" role="tabpanel">
                                        <table>
                                            <tbody>
                                                <cfloop query="get_user_badge">
                                                    <tr>
                                                        <td>
                                                            <img src="./assets/img_badge/#badge_id#_G.svg" height="80" width="80" alt="#badge_name#" title="#badge_name#" />
                                                        </td>
                                                        <td>
                                                            <span>#badge_name#</span>
                                                        </td>
                                                        <td>
                                                            <span>(#count# recommendations)</span>
                                                        </td>
                                                    </tr>
                                                </cfloop>
                                            </tbody>
                                        </table>
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



</body>
</html>