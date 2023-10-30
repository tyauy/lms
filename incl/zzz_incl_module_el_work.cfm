<cfoutput>

<cfquery name="get_kw" datasource="#SESSION.BDDSOURCE#">
SELECT kw.keyword_name_#SESSION.LANG_CODE# as keyword_name, kw.keyword_id 
FROM lms_sessionmaster_keywordid_cor skc
INNER JOIN lms_keyword kw ON kw.keyword_id = skc.keyword_id
WHERE skc.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">
ORDER BY keyword_name ASC
</cfquery>

<cfif level_alias eq "">
    <cfset level_css = "red">
<cfelse>
    <cfset level_css = level_alias>
</cfif>

<cfif elearning_completion neq "0.0">
    <cfset elearning_progress = round(elearning_completion*100)>
</cfif>

<div class="container_resource bg-light card border rounded shadow-sm" id="container_#sessionmaster_id#">
                                                            
    <div class="card-body">

        <div class="d-flex">

            <cfif tp_orientation_id eq "6">
                <div class="mr-2" style="flex: 0 0 140px;">
                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                        <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="130" align="left" class="mr-2">
                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                        <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="130" align="left" class="mr-2">
                    <cfelse>
                        <img src="../assets/img/wefit_lesson.jpg" width="130" align="left" class="mr-2">
                    </cfif>
                </div>
            <cfelse>
                <div class="mr-2" style="flex: 0 0 140px;">
                    <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                        <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="130" align="left" class="mr-2">
                    <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                        <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="130" align="left" class="mr-2">
                    <cfelse>
                        <img src="../assets/img/wefit_lesson.jpg" width="130" align="left" class="mr-2">
                    </cfif>
                </div>
            </cfif>


            <div>
                <h6 class="m-0">
                    #sessionmaster_name#
                </h6>

                <p class="mt-2">
                    <cfif tp_orientation_id eq "6">
                        <small><strong>Author</strong> : #sessionmaster_objectives#</small>
                    <cfelse>
                        <small><strong>Objectif</strong> : #sessionmaster_objectives#</small>
                    </cfif>
                    <br>
                    <small class="text-red">
                    <cfif elearning_completion neq "0.0"><strong>Dernière activité</strong> : #obj_dater.get_dateformat(update_date)#<cfelse><strong>Non commencé</strong></cfif>
                    </small>

                    <!--- <br>
                    <small> #sessionmaster_description#</small> --->
                </p>

                <img src="../assets/img_formation/2.png" width="30">
                <cfif tp_orientation_id eq "6">
                    <img src="./assets/img_level/B1.svg" width="30" align="left" class="mr-1">
                    <img src="./assets/img_level/B2.svg" width="30" align="left" class="mr-1">
                    <img src="./assets/img_level/C1.svg" width="30" align="left" class="mr-1">
                <cfelse>
                    <img src="../assets/img_level/#level_alias#.svg" width="30">
                </cfif>
                <cfloop query="get_kw">
                    <span class="badge badge-pill bg-white border border-dark px-2 py-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                </cfloop>

            </div>

            <div class="ml-auto">
                <div>
                    <a class="btn btn-outline-#level_css# btn_add_tp mr-1 ml-0" id="module_#elearning_module_id#" data-status="up" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el_work">
                        Retirer
                        <br>
                        <i class="fa-light fa-xmark"></i>
                    </a>
                    <cfif tp_orientation_id eq "6">
                        <button class="btn btn-outline-#level_css# mr-1 ml-0 btn_player_work <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                            Play Module
                            <br>
                            <i class="fa-light fa-circle-play"></i>
                        </button>
                    <cfelse>
                        <a class="btn btn-outline-#level_css# mr-1 ml-0" href="el_play_sco.cfm?sco=#elearning_module_id#" target="_blank" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                            <cfif elearning_completion eq "0.0">Play Module<cfelse>Continuer</cfif>
                            <br>
                            <i class="fa-light fa-circle-play"></i>
                        </a>
                    </cfif>

                    <cfquery name="get_quiz_unit" datasource="#SESSION.BDDSOURCE#">
                    SELECT *
                    FROM lms_quiz
                    WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#"> AND quiz_type = 'unit'
                    AND quiz_active = 1
                    LIMIT 1
                    </cfquery>
                    
                    <cfloop query="get_quiz_unit">

                        <cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
                        SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                        </cfquery>

                        <cfif get_result_unit.recordcount eq "0">
                            <a class="btn btn-outline-#level_css# mr-0 ml-0 btn_start_quiz" id="q_#quiz_id#" <!---href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" target="_blank"--->>
                                Validation Quiz
                                <br>
                                <cfloop from="1" to="5" index="star"><i class="fa-light fa-star"></i></cfloop>
                            </a>
                        <cfelse>

                            <cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
                            SELECT SUM(ans_gain) as score
                            FROM lms_quiz_result
                            WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_unit.quiz_user_id#">
                            </cfquery>
                            
                            <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
                            SELECT SUM(ans_gain) as quiz_score
                            FROM lms_quiz_answer a 
                            INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
                            INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
                            WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                            </cfquery>

                            <a class="btn btn-outline-#level_alias# mr-0 ml-0 btn_view_quiz" id="quiz_#get_result_unit.quiz_user_id#">
                                Validation Quiz
                                <br>

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
                                
                                <i class="<cfif global_note gte 20>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 40>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 60>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 80>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i><i class="<cfif global_note gte 100>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>

                            </a>
                            
                        </cfif>

                    </cfloop>

                </div>
                <div>
                    <cfif elearning_completion neq "0.0">
                        <div class="progress">
                        <div class="progress-bar progress-bar-striped bg-success progress-bar-animated bg-#level_alias#" role="progressbar" style="width: #elearning_progress#%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </cfif>

                </div>
                


            </div>


        </div>
        
    </div>   
</div>
</cfoutput>