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
    
    <div class="container_resource bg-light card border rounded shadow-sm" id="containerdash_#sessionmaster_id#">
                                                                
        <div class="card-body">
    
            <div class="d-flex">
    
                <div class="mr-2" style="flex: 0 0 140px;">
                    <cfif tp_orientation_id eq "6">
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
                            <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="130" class="mr-2">
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
                            <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="130" class="mr-2">
                        <cfelse>
                            <img src="../assets/img/wefit_lesson.jpg" width="130" class="mr-2">
                        </cfif>
                    <cfelse>
                        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_code#.jpg")>			
                            <img src="../assets/img_material_el/thumbs/#sessionmaster_code#.jpg" width="130" class="mr-2">
                        <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material_el/thumbs/#sessionmaster_id#.jpg")>			
                            <img src="../assets/img_material_el/thumbs/#sessionmaster_id#.jpg" width="130" class="mr-2">
                        <cfelse>
                            <img src="../assets/img/wefit_lesson.jpg" width="130" class="mr-2">
                        </cfif>
                    </cfif>
                </div>
    
    
                <div>
                    <h6 class="m-0">
                        #sessionmaster_name#
                    </h6>
    
                    <p class="mt-2">

                        <!----------- MODULE PROGRESS ------------>
                        <div class="d-flex">
                            <!---<div><small><strong>#obj_translater.get_translate('table_th_progress')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></strong></small></div>
                        
                            <cfquery name="get_module_id" datasource="#SESSION.BDDSOURCE#">
                            SELECT em.elearning_module_id, emu.elearning_completion
                            FROM lms_elearning_module em
                            LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = em.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                            WHERE elearning_module_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#elearning_module_path#">
                            </cfquery>

                            <cfif get_module_id.elearning_completion neq "0.0" AND get_module_id.elearning_completion neq "">
                                <cfset elearning_progress = round(get_module_id.elearning_completion*100)>
                            <cfelse>
                                <cfset elearning_progress = 0>
                            </cfif>
                                
                            <div class="progress mt-1 ml-2" style="height:18px; width:120px">
                                <div class="progress-bar progress-bar-striped bg-success progress-bar-animated bg-#level_alias#" role="progressbar" style="width: #elearning_progress#%" aria-valuenow="#elearning_progress#" aria-valuemin="0" aria-valuemax="100">
                                #elearning_progress# %
                                </div>
                            </div>--->

                        </div>

                        <cfif sessionmaster_objectives neq "">
                        <small><strong>#obj_translater.get_translate('table_th_author')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></strong> #sessionmaster_objectives#</small>
                        </cfif>
                        
                        <!---<br>

                        <small class="text-red"><strong>#obj_translater.get_translate('table_th_last_activity')#<cfif SESSION.LANG_CODE eq "fr"> :<cfelse>:</cfif></strong> 
                        <cfif elearning_completion neq "0.0">
                            <cfif update_date neq "">
                                #obj_dater.get_dateformat(update_date)#
                            </cfif>
                        <cfelse>
                            <strong>#obj_translater.get_translate('btn_not_started')#</strong>
                        </cfif>
                        </small>--->

                    </p>
    
                    <img src="../assets/img_formation/2.png" width="30">

                    #obj_function.get_level_thumb(sm_level_id,"30")#

                    <cfloop query="get_kw">
                        <span class="badge badge-pill bg-white border border-dark px-2 py-2 font-weight-normal" style="font-size:12px">#keyword_name#</span>
                    </cfloop>
    
                </div>
    
                <div class="d-flex ml-auto align-items-end flex-column justify-content-end h-100">

                    <div>
                        <a class="btn btn-red btn_add_tp m-0 p-0" id="module_#elearning_module_id#" data-status="up" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#" data-lid="#level_id#" data-lalias="#level_alias#" data-trigger="module_el_work" style="width:16px !important">
                            <i class="fa-light fa-xmark"></i>
                        </a>
                    </div>

                    <div class="mt-4 d-flex">

                        <!----------- REAL MODULE MANAGER ------------>
                        <div class="bg-white border mr-2">
                            <a class="btn btn-link m-0 btn_player_work <cfif not fileexists("#SESSION.BO_ROOT#/assets/materials_video/#sessionmaster_ressource#.mp4")>disabled</cfif>" data-mid="#elearning_module_id#" data-smid="#sessionmaster_id#">
                                <div align="center"><i class="fa-light fa-play-circle fa-2x" aria-hidden="true"></i> <br><cfif elearning_completion eq "0.0">Play Module<cfelse>Continuer</cfif></div>											
                            </a>
                        </div>

                        <!----------- VALIDATION QUIZ MANAGER ------------>
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

                                <!--- <div class="bg-white border mr-2 rounded" style="position:relative"> --->
                                    
                                <!--- <cfdump var = "#get_module_id#"> --->
                                <a class="btn btn-#level_css# m-0 btn_start_quiz ml-3" id="q_#quiz_id#">
                                    <div align="center">
                                    <cfloop from="1" to="5" index="star"><i class="fa-light fa-star text-white"></i></cfloop>
                                    </div>
                                    <div align="center" class="mt-2">
                                        Validation Quiz
                                    </div>	
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

                                <a class="btn btn-#level_css# m-0 btn_view_quiz ml-3" id="quiz_#get_result_unit.quiz_user_id#_#quiz_id#">
                                    <div align="center">
                                        <i class="<cfif global_note gte 20>fa-solid fa-star text-white<cfelse>fa-light fa-star text-white</cfif>"></i>
                                        <i class="<cfif global_note gte 40>fa-solid fa-star text-white<cfelse>fa-light fa-star text-white</cfif>"></i>
                                        <i class="<cfif global_note gte 60>fa-solid fa-star text-white<cfelse>fa-light fa-star text-white</cfif>"></i>
                                        <i class="<cfif global_note gte 80>fa-solid fa-star text-whitee<cfelse>fa-light fa-star text-white</cfif>"></i>
                                        <i class="<cfif global_note gte 100>fa-solid fa-star text-white<cfelse>fa-light fa-star text-white</cfif>"></i>
                                    </div>
                                    <div align="center" class="mt-2">
                                        Validation Quiz
                                    </div>											
                                </a>
                                
                            </cfif>

                        </cfloop>
    
                    </div>    
                    
                </div>
    
    
            </div>
            
        </div>  
    </div>
    </cfoutput>