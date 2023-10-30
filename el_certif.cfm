<cfsilent>

    <cfparam name="f_id" default="2">
    <cfparam name="subm" default="toeic">
    <cfparam name="f_bright_id" default="2">

    <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
    SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id = 3 OR skill_id = 1
    </cfquery>

    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name
    FROM lms_level
    WHERE level_id NOT IN (0,6) 
    </cfquery>

    <cfquery name="get_toeic_online" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic_online" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_toeic_online_section_1" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic_section_1" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_toeic_online_section_2" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic_section_2" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_toeic_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic_listening" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_toeic_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic_reading" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_toeic_paper" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>
    
    <cfquery name="get_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE (quiz_type = "reading_training" OR quiz_type = "bright reading") AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <cfquery name="get_bright_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_bright_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <cfquery name="get_bright_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright reading" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_bright_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <!--- <cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
    </cfquery> --->

    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code FROM lms_formation 
    WHERE formation_id = 1
    OR formation_id = 2
    OR formation_id = 3
    OR formation_id = 4
    OR formation_id = 5
    OR formation_id = 8
    OR formation_id = 9
    OR formation_id = 12
    OR formation_id = 13
    </cfquery>
    
</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
</head>

<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
            
            <cfset title_page = "*WEFIT LMS*">
            <cfinclude template="./incl/incl_nav.cfm">

            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row mt-3">
                    
                    <div class="col-md-12">

                        <nav>
                            <div class="nav nav-tabs" id="nav-tab" role="tablist" align="center">
                                <cfif subm eq "toeic">
                                <button class="nav-link <cfif subm eq "toeic">active</cfif> border-0" data-toggle="tab" data-target="#toeic_pres" type="button" role="tab" aria-controls="toeic_pres" aria-selected="<cfif subm eq "toeic">true<cfelse>false</cfif>">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/logo_toeic.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_toeic_type')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>
                                </cfif>

                                <cfif subm eq "linguaskill" or subm eq "bright">
                                <button class="nav-link <cfif subm eq "linguaskill" or subm eq "bright">active</cfif> border-0" data-toggle="tab" data-target="#grammar_1" type="button" role="tab" aria-controls="grammar_1" aria-selected="<cfif subm eq "linguaskill" or subm eq "bright">true<cfelse>false</cfif>">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_4.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_level_all')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>
                                </cfif>

                                <!--- <button class="nav-link border-0" data-toggle="tab" data-target="#grammar_2" type="button" role="tab" aria-controls="grammar_2" aria-selected="false">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_7.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_el_grammar_review')#</cfoutput>
                                            </h5>
                                        </div>

                                    </div>
                                </button> --->
                                <cfif subm eq "toeic">

                                <button class="nav-link border-0" data-toggle="tab" data-target="#toeic_exercice_listening" type="button" role="tab" aria-controls="toeic_exercice_listening" aria-selected="false" id="btn_toeic_exercice_listening">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_9.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_toeic_listening')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>

                                <button class="nav-link border-0" data-toggle="tab" data-target="#toeic_exercice_reading" type="button" role="tab" aria-controls="toeic_exercice_reading" aria-selected="false" id="btn_toeic_exercice_reading">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_8.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_toeic_reading')#</cfoutput>
                                            </h5>
                                        </div>

                                    </div>
                                </button>

                                <button class="nav-link border-0" data-toggle="tab" data-target="#toeic" type="button" role="tab" aria-controls="toeic" aria-selected="false" id="btn_toeic_mock">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/logo_toeic.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_toeic_mock')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>

                                </cfif>

                                <cfif subm eq "linguaskill">
                                <button class="nav-link border-0" data-toggle="tab" data-target="#lingua_2" type="button" role="tab" aria-controls="lingua_1" aria-selected="false">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_10.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_linguaskill_explanation')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>

                                <button class="nav-link border-0" data-toggle="tab" data-target="#lingua_1" type="button" role="tab" aria-controls="lingua_1" aria-selected="false">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/logo_linguaskill.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_linguaskill_demo')#</cfoutput>
                                            </h5>
                                        </div>
                                    </div>
                                </button>
                                </cfif>
                                <cfif subm eq "bright">
                                    <button class="nav-link border-0" data-toggle="tab" data-target="#bright" type="button" role="tab" aria-controls="bright" aria-selected="false">
                                        <div class="d-flex">
                                            <div>
                                                <img class="mr-3 img_rounded" src="./assets/img/logo_bright.jpg" width="90">
                                            </div>
                                            <div align="left">
                                                <h5 style="font-size:18px" class="mb-0">
                                                    <cfoutput>#obj_translater.get_translate('tab_bright_mock')#</cfoutput>
                                                </h5>
                                            </div>
                                        </div>
                                    </button>
                                </cfif>
                                <cfif subm eq "bright" OR subm eq "linguaskill">
                                <button class="nav-link border-0" data-toggle="tab" data-target="#rl" type="button" role="tab" aria-controls="rl" aria-selected="false">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_8.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                                <cfoutput>#obj_translater.get_translate('tab_certif_rl_exercice')#</cfoutput>
                                            </h5>
                                        </div>

                                    </div>
                                </button>
                                </cfif>
                            </div>
                        </nav>
                        

                        <div class="tab-content">
                            <div class="tab-pane <cfif subm eq "linguaskill" OR subm eq "bright">show active</cfif>" id="grammar_1" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                            
                                        <!--- <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_title_training_level')#</cfoutput></h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div> --->

                                        <cfoutput><p style="font-size:18px">#obj_translater.get_translate_complex('intro_certif_level_preparation')#</p></cfoutput>

                                        <div class="row justify-content-between">

                                            <div class="col-md-12">
                                
                                                <div class="d-flex justify-content-center">
                                

                                                    <div class="btn-group-toggle" data-toggle="buttons">
                                                        <cfoutput query="get_level">
                                                            <label class="btn btn-sm btn_change_level btn-outline-#level_alias# <cfif level_id eq "1">active</cfif>" data-levelid="#level_id#" data-toggle="collapse" data-target="##collapse_#level_id#" <cfif level_id eq "1">aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
                                                                <input type="radio" name="level_id" id="level_id" value="1" autocomplete="off">
                                                                <img src="./assets/img_level/#level_alias#.svg" width="30"> #level_name#
                                                            </label>
                                                        </cfoutput>	
                                                    </div>
                                        
                                                </div>
                                
                                            </div>
                                
                                        </div>


                                        <div id="accordion_level">

                                            <cfloop query="get_level">
                            
                                                <div id="collapse_<cfoutput>#level_id#</cfoutput>" class="<cfif level_id neq "1">collapse<cfelse>collapse show</cfif> pt-2" data-parent="#accordion_level">
                                                    <div class="row mt-3">
                                                        <div class="col-md-12">
                                                            <div class="card border bg-white border-<cfoutput>#level_alias#</cfoutput>">
                                                                <div class="card-body">
                                                                    <table class="table table-sm">

                                                                        <cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
                                                                        SELECT * FROM lms_mapping 
                                                                        WHERE level_sub_id IN (SELECT level_sub_id FROM lms_level_sub WHERE level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">) 
                                                                        AND (mapping_category = 'grammar' OR mapping_category = 'vocabulary') 
                                                                        AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                                                                        ORDER BY level_sub_id
                                                                        </cfquery>

                                                                        <cfoutput query="get_mapping_grammar" group="level_sub_id">
                                                                            <tr <!---class="bg-#get_level.level_alias#"--->class="border-bottom border-#get_level.level_alias#">
                                                                                <td>
                                                                                    <img src="./assets/img_sublevel/#level_sub_id#_plain.svg" width="40" align="left">
                                                                                    <!--- <img src="./assets/img_sublevel/#replace(cor2,"_",".")#.svg" width="40" align="left"> --->
                                                                                    <!--- <h6 class="mt-2 text-white"> #replace(,"_",".")#</h6> --->
                                                                                </td>
                                                                                <td align="center" class="text-#get_level.level_alias#">#obj_translater.get_translate('tab_el_learn_rules')#</td>
                                                                                <td align="center" class="text-#get_level.level_alias#">#obj_translater.get_translate('tab_el_training_exerices')#</td>
                                                                            </tr>
                                                                            <cfoutput>
                                                                                <cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
                                                                                SELECT sm.sessionmaster_id
                                                                                FROM lms_sessionmaster_grammarid_cor sg 
                                                                                INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = sg.sessionmaster_id
                                                                                JOIN lms_grammar_mapping_cor gm ON sg.grammar_id = gm.lms_grammar_id
                                                                                JOIN lms_mapping m ON gm.lms_mapping_id = m.mapping_id
                                                                                JOIN lms_grammar g ON gm.lms_grammar_id = g.grammar_id
                                                                                INNER JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
                                                                                INNER JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id
                                                                                WHERE m.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                                                                                AND tm.tpmaster_id IN (11,12,13,14)
                                                                                </cfquery>
    
                                                                                <cfquery name="get_quiz_mapping" datasource="#SESSION.BDDSOURCE#">
                                                                                SELECT
                                                                                q.quiz_name,
                                                                                q.quiz_id,
                                                                                m.mapping_name,
                                                                                g.grammar_name
                                                                                FROM
                                                                                lms_sessionmaster_grammarid_cor sg 
                                                                                INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = sg.sessionmaster_id
                                                                                JOIN lms_quiz q ON sg.sessionmaster_id = q.sessionmaster_id
                                                                                JOIN lms_grammar_mapping_cor gm ON sg.grammar_id = gm.lms_grammar_id
                                                                                JOIN lms_mapping m ON gm.lms_mapping_id = m.mapping_id
                                                                                JOIN lms_grammar g ON gm.lms_grammar_id = g.grammar_id
                                                                                INNER JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
                                                                                INNER JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id
                                                                                WHERE m.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                                                                                AND tm.tpmaster_id IN (11,12,13,14)
                                                                                GROUP BY q.quiz_id
                                                                                </cfquery>
                                                                                    
                                                                                <cfif get_sm.recordcount neq "0" OR get_quiz_mapping.recordcount neq "0">
    
                                                                                <tr>
                                                                                    <td>
                                                                                        #mapping_name#
                                                                                    </td>
                                                                                    
                                                                                    <td align="left">
    
                                                                                        <cfif get_sm.recordcount neq "0">
                                                                                            <cfset counter = 0>
                                                                                            <cfloop query="get_sm">
                                                                                                <cfset counter ++>
                                                                                                <cfif counter lte 2>
                                                                                                <a class="btn btn-sm btn-outline-#get_level.level_alias# mr-2" target="_blank" href="learner_practice.cfm?sm_id=#sessionmaster_id#">
                                                                                                    Learn #counter#
                                                                                                    <br>
                                                                                                    <i class="fa-light fa-laptop"></i>
                                                                                                    </div>
                                                                                                </a>
                                                                                                </cfif>
                                                                                            </cfloop>
                                                                                        </cfif>
                                                                                        
                                                                                    </td>
    
                                                                                    <td align="left">
    
                                                                                        <cfif get_quiz_mapping.recordcount neq "0">
                                                                                            <cfset counter = 0>
                                                                                            <cfloop query="get_quiz_mapping">
                                                                                                <cfset counter ++>
                                                                                                <cfif counter lte 5>
    
                                                                                                <cfquery name="get_result_unit" datasource="#SESSION.BDDSOURCE#">
                                                                                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                                                                                                </cfquery>
    
                                                                                                <cfif get_result_unit.recordcount eq "0">
                                                                                                    <a class="btn btn-sm btn-outline-#get_level.level_alias# mr-2 btn_start_quiz" id="q_#quiz_id#" <!---href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" target="_blank"--->>
                                                                                                        <small>Practice #counter#</small>
                                                                                                        <br>
                                                                                                        <cfloop from="1" to="5" index="star">
                                                                                                        <i class="fa-thin fa-star"></i>
                                                                                                        </cfloop>
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
    
                                                                                                    <a class="btn btn-sm btn-outline-#get_level.level_alias# mr-2 btn_view_quiz" id="quiz_#get_result_unit.quiz_user_id#">
                                                                                                        Practice #counter#
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
                                                                                                        
                                                                                                        <!---<h5 class="m-0"><span class="badge badge-pill badge-#cssgo# text-white">#global_note#%<!--- / #get_quiz_score.quiz_score#---></span></h5>--->
                                                                                                        <i class="<cfif global_note gte 20>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
                                                                                                        <i class="<cfif global_note gte 40>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
                                                                                                        <i class="<cfif global_note gte 60>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
                                                                                                        <i class="<cfif global_note gte 80>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
                                                                                                        <i class="<cfif global_note gte 100>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i>
    
                                                                                                    </a>
                                                                                                    
    
                                                                                                    <!--- <a id="q_#quiz_id#" href="##" target="_blank" class="btn btn-sm btn-outline-red float-right btn_restart_quiz"><i class="fa-light fa-lg fa-sync-alt"></i></a>																
                                                                                                                                                            
                                                                                                    <cfif get_result_unit.recordcount neq "0" AND get_result_unit.quiz_user_end neq "">
                                                                                                        <a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quiz_#get_result_unit.quiz_user_id#"><i class="fa-light fa-lg fa-tasks"></i></a>
                                                                                                    </cfif> --->
                                                                                                </cfif>
    
                                                                                                    
                                                                                                
                                                                                                </cfif>
                                                                                            </cfloop>
                                                                                        </cfif>
    
                                                                                    </td>
                                                                                    <!--- <td>
                                                                                        <div class="progress" style="height: 5px;"> 
                                                                                        <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                                                        </div>
                                                                                    </td> --->
                                                                                </tr>
                                                                                </cfif>
                                                                            
                                                                            </cfoutput>
                                                                        </cfoutput>
                                                                        
                                                                        
                                                                    </table>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfloop>

                                        </div>
                                    </div>
                                    
                                </div>

                            </div>





                            <div class="tab-pane" id="grammar_2" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                     
                                        <div class="row">
                                            <div class="col-md-12">
    
                                                    <cfquery name="get_sm_grammar" datasource="#SESSION.BDDSOURCE#">
                                                    SELECT sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_name, sm.sessionmaster_description
                                                    FROM lms_tpsessionmaster2 sm 
                                                    WHERE sm.sessionmaster_id IN (594,595,596,597,598)
                                                    </cfquery>
    
                                                    <cfoutput>
                                                    <cfloop query="get_sm_grammar">
    
                                                        <div class="card border bg-light mt-3">
                                                            <div class="card-body">
                                                                <div class="media">
                                                                    <img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="60">
                                                                        <div class="media-body ml-2">
                                                                        <h6 class="mt-1">#sessionmaster_name# <img src="./assets/img_level/A1.svg" width="32" align="left"> <img src="./assets/img_level/A2.svg" width="32" align="left"></h6>
                                                                        <small>#sessionmaster_description#</small>
                                                                        
                                                                        <div class="clearfix"></div>
                                                                        <div class="float-right">
                                                                            
                                                                            <a class="btn btn-sm btn-outline-#get_level.level_alias# mr-2" target="_blank" href="learner_practice.cfm?sm_id=#sessionmaster_id#">
                                                                                <small>Learn !</small>
                                                                                <br>
                                                                                <i class="fa-thin fa-laptop"></i>
                                                                            </a>
                                                                            
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </cfloop>
                                                </cfoutput>
    
    
    
    
                                            </div>
                                        </div>
    
                                    </div>
                                </div>

                            </div>







                            <div class="tab-pane" id="rl" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                            
                                        <!--- <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-books" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> "Reading Comprehension"</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div> --->

                                        <cfoutput><p style="font-size:18px">#obj_translater.get_translate_complex('intro_certif_rl_preparation')#</p></cfoutput>
                                        
                                        <div class="row">
                                            <div class="col-md-6">

                                                <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('js_writing')#</cfoutput></h5>
                                                <hr class="mt-0 border-red">

                                                <!--- <h5 class="mb-2 text-red" style="font-size:18px"><strong><cfoutput>#ucase(obj_translater.get_translate('js_writing'))#</cfoutput></strong></h5>
                                                <hr class="mt-0 border-red"> --->
                                                
                                                <cfoutput query="get_reading">
                                                        
                                                <cfquery name="get_result_reading" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id#
                                                </cfquery>
        
                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                    
                                                        <div class="media">
                                                            <div class="media-body">
                                                                <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-info">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                                <small>#quiz_description#</small>
                                                                
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">
                                                                
                                                                    <cfif get_result_reading.recordcount eq "0">
                                                                    
                                                                        <button class="btn btn-sm btn-outline-info btn_start_quiz" id="q_#quiz_id#">#obj_translater.get_translate('btn_go_test')#</button>
                                                                        
                                                                    <cfelse>

                                                                        <a href="##" class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_reading.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                                
                                                                        <cfif get_result_reading.recordcount neq "0" AND get_result_reading.quiz_user_end neq "">
                                                                            <a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_reading.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                        <!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
                                                                            <a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
                                                                        </cfif>
                                                                
                                                                    </cfif>		
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
        
                                                    </div>

                                                </div>
                                                
                                                </cfoutput>
                                            </div>

                                            <div class="col-md-6">
                                                
                                                <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('js_oral')#</cfoutput></h5>
                                                <hr class="mt-0 border-red">

                                                <!--- <h5 class="mb-2 text-dark" style="font-size:18px"><strong><cfoutput>#ucase(obj_translater.get_translate('js_oral'))#</cfoutput></strong></h5>
                                                <hr class="mt-0 border-red"> --->

                                                <cfoutput query="get_listening">
                                                
                                                <cfquery name="get_result_listening" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id#
                                                </cfquery>
        
                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                    
                                                        <div class="media">
                                                            <div class="media-body">
                                                                <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-info">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                                <small>#quiz_description#</small>
                                                                
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">
                                                                
                                                                    <cfif get_result_listening.recordcount eq "0">
                                                                    
                                                                        <button class="btn btn-sm btn-outline-info btn_start_quiz" id="q_#quiz_id#">#obj_translater.get_translate('btn_go_test')#</button>
                                                                        
                                                                    <cfelse>

                                                                        <a href="##" class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_listening.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                                
                                                                        <cfif get_result_listening.recordcount neq "0" AND get_result_listening.quiz_user_end neq "">
                                                                            <a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_listening.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                        <!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
                                                                            <a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
                                                                        </cfif>
                                                                
                                                                    </cfif>		
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
        
                                                    </div>

                                                </div>
                                                
                                                </cfoutput>
                                                
                                                
                                            </div>

                                        </div>

                                    </div>
                                </div>
                            </div>













                            <div class="tab-pane" id="lingua_2" role="tabpanel">


                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">




                                        <div class="row mt-3">
                                            <div class="col-md-3">

                                                <div class="sticky-top pt-3">

                                                <nav id="navbar-lingua_4" class="navbar bg-light">
                                                    <nav class="nav nav-pills flex-column">

                                                        <a class="nav-link text-dark" href="#item-presentation-1">Linear VS Adaptative testing</a>

                                                        <a class="nav-link text-dark" href="#item-presentation-2">Different levels of questions</a>

                                                        <a class="nav-link text-dark" href="#item-presentation-3">Test Format : Reading & Listening</a>

                                                            <nav class="nav nav-pills flex-column">
                                                                <a class="nav-link text-dark ml-3 my-1" href="#item-presentation-3-1">Reading section</a>
                                                                <a class="nav-link text-dark ml-3 my-1" href="#item-presentation-3-2">Listening section</a>
                                                            </nav>

                                                        <a class="nav-link text-dark" href="#item-presentation-4">Timing</a>

                                                        
                                                    </nav>
                                                </nav>

                                                </div>
                                                    
                                            </div>

                                            <div class="col-md-9">

                                                <div data-spy="scroll" data-target="#navbar-lingua_4" data-offset="0">


                                                    The test lasts between 65 and 80 minutes depending on the candidates’ responses to the questions and how well they do. There is no fixed number of questions. There are seven fixed types of questions: i) Five types of reading question, ii) Two types of listening question.

                                                    <br><br>
                                                    <h5 id="item-presentation-1">Linear VS Adaptative testing</h5>
                                                    <p>
                                                    Linear testing is where the questions in a test are fixed and are presented in the same way for every take of the test: Each learner does the same number of questions in the same order. Linguaskills is not linear; it is adaptive. This means that the questions i) come in different orders for each learner, and ii) learners do not do a fixed amount of questions.
                                                    <br><br>
                                                    Linguaskills is designed to be adaptive, if the learner gets a question wrong, the test gives them an easier question. Alternatively, if the learner gets a question correct, it gives them a harder one. The test does this until it has the correct level for the learner.
                                                    <br><br>
                                                    What are the consequences of this for teachers and learners? Essentially, we cannot teach techniques based on predicting what type of question will come next or on how many questions the learner needs to get right. For tests like IELTS and TOEIC, we can explain how many points the learner needs for a specific score; with Linguaskills, we cannot.
                                                    </p>

                                                    <h5 id="item-presentation-2">Different levels of questions</h5>
                                                    <p>
                                                    As the exam is adaptive rather than linear, there are questions of different difficulty levels. The idea, as already noted, is that when the learners do the actual test if they get questions correct they are given more difficult ones. On the LMS, we have examples of different difficulty level questions. There is a basic test, an intermediate version and an advanced version. This gives a clear - albeit slightly simplified- example of what happens on the test: if the learner gets the basic questions correct they are given intermediate ones and if they get those correct they get advanced ones.
                                                    <br><br>
                                                    Because of this, the outline of the test format given below gives examples from each of the levels. The aim here is to show the type of language the learners will encounter for different types of questions at different degrees of difficulty. It aims to illustrate i) the format and style of each question, and ii) some of the language points that are important to focus on.
                                                    </p>

                                                    <h5 id="item-presentation-3">Test Format : Reading & Listening</h5>
                                                    <p>
                                                    The test lasts between 65 and 80 minutes depending on the candidates’ responses to the questions and how well they do. There is no fixed number of questions. There are seven fixed types of questions: i) Five types of reading question, ii) Two types of listening question.


                                                    <h6 id="item-presentation-3-1">Reading section</h6>
                                                    There are five types of questions in the reading section. Three of these focus on language skills by filling in gaps (Two of them with answer options and one by writing in) and two that focus on reading comprehension.

                                                    <br><br>
                                                    <strong>Read and select</strong>
                                                    <br>
                                                    Candidates read a notice, label, memo or letter containing a short text and choose the sentence or phrase that most closely matches the meaning of the text. There are three possible answers. One key thing to note is that it is three sentences to describe the item, not a question. There are a couple of pints to note:
                                                    These tend to focus more on the lower levels; for learners looking to score C1, these will not be so prevalent as the test progresses
                                                    
                                                    <br><br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image10.jpg" width="100%">
                                                                    </div>
                                                                    
                                                                    <br>

                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image15.jpg" width="100%">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br>
                                                    <strong>Gapped sentences</strong>
                                                    <br>
                                                    Candidates read a sentence with a missing word (gap) and choose the correct word to fill the gap. There are three or four choices for each gap. There are a few points to note on these:
                                                    <ol>
                                                        <li>For some of the easier questions, there are three options for the gaps. As the questions get more complex, there are four options.</li>
                                                        <li>For some of the easier questions, we look at filling the gaps with auxiliaries or simple verb conjugations. As we get more complex, the level of grammar goes up. Some of the more difficult questions use phrasal language and can be really challenging.</li>
                                                        <li>To answer questions that would help a leaner score C1, it is much more about an appropriate choice of word or a collocation with a preposition rather than a clear cut piece of conjugation.</li>
                                                    </ol>

                                                    <br><br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image7.jpg" width="100%">
                                                                    </div>
                                                                    <em>The example we see here is an easier example (It can be found on the basic level demo version of the test). It is asking the candidate to differentiate between auxiliary verbs. As it is one of the easier questions (It is in the basic level) there are only three answer options.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image5.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is a higher level question (It is more of an Intermediate level). We can see that there are four answer options rather than three and that the language in question is a collocation: attention+pay.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image2.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the most advanced questions. As we can see there are, again, four answer options. The choices are much more complex as we are looking at four words that could be used in the context of finance. However, we can only choose stands because of the preposition ‘at’.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <strong>Multiple-choice gap-fill</strong>
                                                    <br>
                                                    Candidates choose the right word or phrase to fill the gaps in a text. There are three or four choices for each gap. There are a few key points to note for these questions:
                                                    <ol>
                                                        <li>On a very practical level, the learner must click on each gap to reveal the answer options and then collect. They shouldn’t click on the arrow until they have answered all of the questions.</li>
                                                        <li>Just as with the Gapped Sentences, some of the earlier and easier questions will have three answer options but as the questions get more complex, here are four options</li>
                                                        <li>The complexity of the language gets progressively more difficult. Some of the easier questions deal with things like basic conjugations, possessives, auxiliaries and comparative forms. However, if candidates get these correct they begin to encounter more difficult language such as conjunctions and different choices of vocabulary. The most complex look at nuanced collocations and more phrasal language.</li>
                                                    </ol>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image14.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the more basic questions. As can be seen, it only has three answer options. The five questions focus on points like i) basic conjunctions, such as ‘because’, ii) all vs every, iii) possessives, and iv) there/that/they.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image8.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is a more intermediate level question. It includes a more complex conjunction with a choice between despite/even though etc and then uses vocabulary questions that are heavily based around collocations.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image11.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the more complex questions. Again, it relies heavily on collocation on the majority of the questions. These ones are far more complex and nuanced.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>



                                                    <br><br>
                                                    <strong>Open gap-fill</strong>
                                                    <br>
                                                    Candidates read a short text in which there are some missing words (gaps) and write in the missing word in each gap. There are a few points to note for this one:
                                                    <ol>
                                                        <li>This is, obviously, more complicated in itself than the multiple choice gap-fills as the candidate needs to generate the answers themselves.
                                                        <li>
                                                            Even though it is more complex, we see language used for the gaps that is similar to the language in the multiple-choice gap-fills. We see a lot of collocation and auxiliaries, articles and basic collocations
                                                            <ul>
                                                                <li>Where in the multiple-choice gap-fills things get more complex quickly, this is not quite the case in the open gap fills.</li>
                                                                <li>As the multiple-choice questions get more difficult, we get much more collocation and much more nuance in the questions. However, this is not quite the case with open ones. The language is a lot more structured and predictable. For example:
                                                                    <ul>
                                                                        <li>Make/Do/Take collocations</li>
                                                                        <li>Prepositions</li>
                                                                        <li>Simpler collocations</li>
                                                                    </ul>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ol>


                                                    <br><br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image12.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the more basic level questions. The questions focus on language points such as  i) articles like a/an/the, ii) time markets like ago/since, iii) comparatives</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image13.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is a more intermediate level question. It looks at language points such as i) time markers lie for/since/ago, ii) conditional language such as if/whether, iii) prepositions, and iv) make/take/do/have collocations.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">

                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image17.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the more advanced questions, it focuses on language points such as: i) take/make/do/have collocations, ii) time markers such as far/ago/since, iii) prepositions</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <br>
                                                    <strong>Extended reading</strong>
                                                    <br>
                                                    Candidates read a longer text and answer a series of multiple-choice questions. The questions are in the same order as the information in the text.
                                                    <ol>
                                                        <li>We see a couple of general types of questions
                                                            <ul>
                                                                <li>Direct questions asking When/Where/How etc</li>
                                                                <li>Completing a sentence to describe what we read in the text</li>
                                                            </ul>
                                                        </li>
                                                        <li>In terms of the content of the questions, we are almost always looking for information from the text. 
                                                            <ul>
                                                                <li>In the lower levels this is an action or a feeling </li>
                                                                <li>In the more complicated levels you get opinions and comments</li>
                                                                <li>In the most complicated questions you get opinions and trends</li>
                                                            </ul>
                                                        </li>
                                                        <li>There are other types of questions that are represented far less
                                                            <ul>
                                                                <li>There are one or two questions where the candidate has to define a piece of vocabulary</li>
                                                                <li>There are one or two where the candidate needs to suggest a title or a general meaning for the text</li>
                                                            </ul>
                                                        </li>
                                                        <li>For some of the easier questions, we see three answer options. In the more complex ones, this changes to four options.</li>
                                                        <li>As we move between more basic questions and more complex ones:
                                                            <ul>
                                                                <li>The length of the text becomes greater</li>
                                                                <li>The complexity of the language becomes great</li>
                                                                <li>The subject matter becomes more complex
                                                                    <ul>
                                                                        <li>The basic level below is a journal about travelling to Japan written by a non-native speaker. It uses basic language about the trip looking at things like food and travel activities</li>
                                                                        <li>The intermediate level is a book review that uses literary language and also gives much more in terms of opinion and more balanced language, looking at different sides of an opinion or argument.</li>
                                                                        <li>The advanced level is a very nuanced and detailed piece that is critical of hipster style design. The reader needs to look for irony and deeper meaning in the piece as well as battling through the detail in order to answer the questions.</li>
                                                                    </ul>
                                                                </li>
                                                            </ul>
                                                        </li>
                                                    </ol>
















                                                    

                                                    <br><br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image1.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is one of the easier examples, so a lot of the questions have three options rather than four. The questions are relatively simple as they are looking for pieces of specific information from the text such as where the person went shopping, the houses she saw or the food she ate.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">

                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image3.jpg" width="100%">
                                                                    </div>
                                                                    <br><em>This is a more intermediate level question, so we still have questions looking for specific information albeit on a more complex level, but we also have questions that focus a lot more on understanding the opinions in the piece.For example, it asks about insights and quality of writing. Aside from the information questions, there is also a question that asks the learner to summarise their understanding of the text by choosing an appropriate subtitle.</em>

                                                                    
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    





                                                    <h6 id="item-presentation-3-2">Listening section</h6>

                                                    There are two parts to the listening section i) Listen and Select, and ii) Extended Listening. The key difference between the two is, basically, the size and complexity. 





                                                    <br><br>
                                                    <strong>Listen and select</strong>
                                                    <br>
                                                    
                                                    Candidates listen to a short audio recording and answer a multiple-choice question with three options. As we will see below these questions have a few characteristics that we can take note of:
                                                    <ol>
                                                        <li>There is only one question per audio</li>
                                                        <li>There are three answer options to choose from</li>
                                                        <li>There are a couple of different types of questions : 
                                                            <ul>
                                                                <li>With pictures to choose from</li>
                                                                <li>A question and a short answer</li>
                                                            </ul>
                                                        </li>
                                                    </ol>

                                                    As the instructions show, the candidate has time to read the questions (10 seconds) and then they will hear the audio twice. 

                                                    <br>
                                                    <br>
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image4.jpg" width="100%">
                                                                    </div>
                                                                    <em>The example above is a picture question. These all work in a similar way. We hear a description of the picture and the learner must choose the most appropriate picture.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <br><br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image19.jpg" width="100%">
                                                                    </div>
                                                                    <em>This is an example of a listen and select based around a short question. And three answers. It is important to note that as we move into the more advanced levels of the test, we get more of these questions than we do the picture versions.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <br>
                                                    <strong>Extended listening</strong>
                                                    <br>
                                                    Candidates listen to a longer recording and answer a series of multiple-choice questions based on it. The questions are in the same order as the information they hear in the recording. There are a couple of things to note here:
                                                    <ol>
                                                    <li>The audio is significantly longer than the Listen and Select questions.</li>
                                                    <li>There are multiple questions for the one audio recording. In this case, there were six questions based on one recording. The candidate needs to scroll through the questions as they go.</li>
                                                    <li>The candidate will have 45 seconds before the audio starts to read the questions. The audio is played twice</li>
                                                    <li>It is common to hear interviews as typical questions and discussion. Generally, we are listening to a dialog</li>
                                                    <li>As we get into the more advanced levels - and the candidates only do this if they get the easier questions correct - the dialogs can get very long and complex.</li>
                                                    </ol>

                                                    <br>                                                    
                                                    <br>

                                                    <div class="row justify-content-center">
                                                        <div class="col-md-9">
                                                            <div class="card bg-light border">
                                                                <div class="card-body">
                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image6.jpg" width="100%">
                                                                    </div>

                                                                    <br><br>

                                                                    <div align="center">
                                                                    <img src="./assets/img_linguaskill/presentation/image16.jpg" width="100%">
                                                                    </div>
                                                                    <em>The format of these types of questions stay the same throughout the course of the test. However, the complexity of the language and the speed of speech gets more difficult as we go.</em>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    </p>


                                                    <h5 id="item-presentation-4">Timing</h5>
                                                    <p>
                                                    Because the test is adaptive rather than linear, we need to approach timing in a different way to other tests. For many paper tests - which are. by definition, linear - there is a set number of questions to be done in a fixed time. For instance, the paper version of the TOEIC is 200 questions in 2 hours. This is not the case in Linguaskills. The test does not have a strict time limit either in total or per question. However, it will only run upto 85 minutes. Therefore, timing is still something of an issue. The test needs the learner to be able to demonstrate their language level within 85 minutes. Therefore, the learner needs to answer enough questions to give a good reflection of their language.
                                                    <br><br>
                                                    What does this mean for the training we give to learners? Essentially, we do not need to focus on timing techniques as strongly as in some other exams such as IELTS or the paper version of TOEIC. The learner isn’t seeing their time tick away. However, we still need to ensure the learner is using their time well and getting the most from the 60-85 minutes of the test.
                                                    </p>





                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>





































                            <div class="tab-pane" id="lingua_1" role="tabpanel">


                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                            
                                        <!--- <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('tab_el_demo')#</cfoutput> - LINGUASKILL</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div> --->

                                        


                                        <div class="row">
                                            
                                            <div class="col-md-6">

                                                <h5 class="mb-2 text-dark" style="font-size:22px">Linguaskill General</h5>
                                                <hr class="mt-0 border-red">
                                                
                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-success"><cfoutput>#obj_translater.get_translate('l_beginner')#</cfoutput></span></h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-a1-a2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-a1-a2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-warning"><cfoutput>#obj_translater.get_translate('l_intermediate')#</cfoutput></span> </h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-b1-b2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-b1-b2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_general.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-danger"><cfoutput>#obj_translater.get_translate('l_advanced')#</cfoutput></span></h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-1/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 1</a>
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/2020-practice-tests/general-c1-c2-2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test 2</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                
                                            </div>
                                                    
                                            <div class="col-md-6">

                                                <h5 class="mb-2 text-dark" style="font-size:22px">Linguaskill Business</h5>
                                                <hr class="mt-0 border-red">

                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-success"><cfoutput>#obj_translater.get_translate('l_beginner')#</cfoutput></span></h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/A+level+Test+-+Reading+and+Listening/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-warning"><cfoutput>#obj_translater.get_translate('l_intermediate')#</cfoutput></span></h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/B+level+Test+-+Reading+and+Listening/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card border bg-light mt-3">
                                                    <div class="card-body">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill_business.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1"><cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput> <span class="badge badge-pill badge-danger"><cfoutput>#obj_translater.get_translate('l_advanced')#</cfoutput></span></h6>
                                                                <em><small>
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://s3-eu-west-1.amazonaws.com/prd-swp-le/linguaskill/practice-tests-2018/C+level+Test+-+Reading+and+Listening+V2/story_html5.html" class="btn btn-sm btn-outline-info mb-0">Test</a>
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

                            <div class="tab-pane <cfif subm eq "toeic">show active</cfif>" id="toeic_pres" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                        
                                        <div style="font-size:18px">
                                            <cfoutput>#obj_translater.get_translate_complex('intro_toeic_type')#</cfoutput>
                                        </div>

                                        <div class="row justify-content-center mt-3">
                                            
                                            <div class="col-lg-5">
                                                <div class="card header_rounded_top">
                                                    <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_online.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                        <h5 class="text-white my-4 font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('card_title_toeic_online')#</cfoutput></h5>
                                                    </div>
                                                    <div class="card-body d-flex flex-column h-100 bg-light">
                                                    <p align="center">
                                                        <ul>
                                                            <li><strong>LISTENING SECTION 1</strong>  (25 questions)
                                                                <ul>
                                                                    <li>Photographs: 3 questions</li>
                                                                    <li>Question/Response: 4 questions</li>
                                                                    <li>Conversations: 9 questions</li>
                                                                    <li>Talks: 9 questions</li>
                                                                </ul>
                                                            </li>
                                                            <li><strong>LISTENING SECTION 2</strong> (20 questions)
                                                                <ul>
                                                                    <li>Question/Response: 5 questions</li>
                                                                    <li>Conversations: 9 questions</li>
                                                                    <li>Talks: 6 questions</li>
                                                                </ul>
                                                            </li>
                                                            <li><strong>READING SECTION 1</strong> (25 questions)
                                                                <ul>
                                                                    <li>Incomplete Sentences: 5 questions</li>
                                                                    <li>Text Completion: 4 questions</li>
                                                                    <li>Reading Comprehension: 16 questions</li>
                                                                </ul>
                                                            </li>
                                                            <li><strong>READING SECTION 2</strong> (20 questions)
                                                                <ul>
                                                                    <li>Incomplete Sentences: 5 questions</li>
                                                                    <li>Text Completion: 4 questions</li>
                                                                    <li>Reading Comprehension: 16 questions</li>
                                                                </ul>
                                                            </li>
                                                        </ul> 
                                                        
                                                        <div align="center">
                                                            <a class="btn btn-info btn_go_train"><cfoutput>#obj_translater.get_translate('btn_train')#</cfoutput></a>
                                                            <a class="btn btn-info btn_go_mock_online"><cfoutput>#obj_translater.get_translate('btn_mock_test')#</cfoutput></a>
                                                        </div>
                                                    </p>
                                                    </div>
                                                </div>
                                            </div>
                                        
                                            <div class="col-lg-5">
                                                <div class="card header_rounded_top">
                                                    <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_paper.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                        <h5 class="text-white my-4 font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('card_title_toeic_paper')#</cfoutput></h5>
                                                    </div>
                                                    <div class="card-body d-flex flex-column h-100 bg-light">
                                                        <p align="center">
                                                            <ul>
                                                                <li><strong>LISTENING SECTION</strong> (Approx 45 minutes & 100 questions)
                                                                    <ul>
                                                                        <li>PART 1 - Photographs: 6 questions</li>
                                                                        <li>PART 2 - Question/Response: 25 questions</li>
                                                                        <li>PART 3 - Conversations: 39 questions</li>
                                                                        <li>PART 4 - Talks: 30 questions</li>
                                                                    </ul>
                                                                </li>
                                                            </ul>
                                                            <ul>
                                                                <li><strong>READING SECTION</strong> (Approx 75 minutes & 100 questions)
                                                                    <ul>
                                                                        <li>PART 5 - Incomplete Sentences: 30 questions</li>
                                                                        <li>PART 6 - Text Completion: 16 questions</li>
                                                                        <li>PART 7 - Reading Comprehension: 54 questions</li>
                                                                    </ul>
                                                                </li>
                                                            </ul>  

                                                            <div align="center">
                                                                <a class="btn btn-info btn_go_train"><cfoutput>#obj_translater.get_translate('btn_train')#</cfoutput></a>
                                                                <a class="btn btn-info btn_go_mock_paper"><cfoutput>#obj_translater.get_translate('btn_mock_test')#</cfoutput></a>
                                                            </div>
                                                            
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane" id="toeic" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">
                                            
                                        <!--- <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('table_th_mock_tests')#</cfoutput> - TOEIC</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div> --->

                                        <!--- <h5 class="mb-2 text-info" style="font-size:18px"><strong>TEST TOEIC FORMAT ONLINE</strong></h5>
                                        <hr class="mt-0 border-info"> --->

                                        



                                        <!--- <cfoutput><p style="font-size:18px">#obj_translater.get_translate_complex('intro_toeic_preparation')#</p></cfoutput> --->
  


   
                                        <!--- <ul>
                                            <li>Listening Section: (Approx 25 minutes & 45 questions)</li>
                                            <li>Reading Section: (Approx 35 minutes and 45 questions)</li>
                                        </ul> --->
                                        


                                        <nav>
                                            <div class="nav nav-tabs" id="nav-tab" role="tablist" align="center">
                                               
                                                <button class="nav-link active" data-toggle="tab" data-target="#toeic_online" type="button" role="tab" aria-controls="toeic_online" aria-selected="false" id="btn_toeic_online">
                                                    <cfoutput>#obj_translater.get_translate('card_title_toeic_online')#</cfoutput>
                                                </button>
                                                <button class="nav-link" data-toggle="tab" data-target="#toeic_paper" type="button" role="tab" aria-controls="toeic_paper" aria-selected="true" id="btn_toeic_paper">
                                                    <cfoutput>#obj_translater.get_translate('card_title_toeic_paper')#</cfoutput>
                                                </button>
                                                <button class="nav-link" data-toggle="tab" data-target="#toeic_listening" type="button" role="tab" aria-controls="toeic_listening" aria-selected="true" id="btn_toeic_listening">
                                                    Focus on Listening
                                                </button>
                                                <button class="nav-link" data-toggle="tab" data-target="#toeic_reading" type="button" role="tab" aria-controls="toeic_reading" aria-selected="true" id="btn_toeic_reading">
                                                    Focus on Reading
                                                </button>
                                            </div>
                                        </nav>

                                        <div class="tab-content">

                                            <div class="tab-pane show active" id="toeic_online" role="tabpanel">
                                                
                                                <div class="row justify-content-center">

                                                    <div class="col-lg-10">

                                                        <div class="card header_rounded_top mt-3">
                                                            <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_online.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                                <h5 class="text-white my-4 font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('card_title_toeic_online')#</cfoutput></h5>
                                                            </div>
                                                            <div class="card-body d-flex flex-column h-100 bg-light">
                                                            
                                                                <h5 class="mb-2 text-dark mt-3" style="font-size:22px">TOEIC Full Tests</h5>
                                                                <hr class="mt-0 border-red">
                                                                
                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_online">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
                                                                </div>
            
                                                                <h5 class="mb-2 text-dark mt-3" style="font-size:22px">TOEIC Tests for Section 1</h5>
                                                                <hr class="mt-0 border-red">
            
                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_online_section_1">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
                                                                </div>
            
                                                                <h5 class="mb-2 text-dark mt-3" style="font-size:22px">TOEIC Tests for Section 2</h5>
                                                                <hr class="mt-0 border-red">
            
                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_online_section_2">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
                                                                </div>
                                                                
                                                            </div>
                                                        </div>

                                                    </div>


                                                </div>

                                            </div>

                                            <div class="tab-pane" id="toeic_paper" role="tabpanel">

                                                <div class="row justify-content-center">

                                                    <div class="col-lg-10">

                                                        <div class="card header_rounded_top mt-3">
                                                            <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_paper.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                                <h5 class="text-white my-4 font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('card_title_toeic_paper')#</cfoutput></h5>
                                                            </div>
                                                            <div class="card-body d-flex flex-column h-100 bg-light">
                                                                        

                                                                <!--- <h5 class="mb-2 text-dark mt-3" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_title_toeic_paper')#</cfoutput></h5>
                                                                <hr class="mt-0 border-red"> --->

                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_paper">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
                                                                </div>


                                                            </div>

                                                        </div>
                                                        
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="tab-pane" id="toeic_listening" role="tabpanel">

                                                <div class="row justify-content-center">

                                                    <div class="col-lg-10">

                                                        <div class="card header_rounded_top mt-3">
                                                            <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_5.jpg'); height:100px; background-position:top center; background-size: cover;">
                                                                <h5 class="text-white my-4 font-weight-bold" align="center">Focus on Listening</h5>
                                                            </div>
                                                            <div class="card-body d-flex flex-column h-100 bg-light">
                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_listening">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="tab-pane" id="toeic_reading" role="tabpanel">

                                                <div class="row justify-content-center">

                                                    <div class="col-lg-10">

                                                        <div class="card header_rounded_top mt-3">
                                                            <div class="header_rounded_top border-bottom-2 border-red" style="background-color:#C2E8F5; background-image: url('./assets/img/header_certif_4.jpg'); height:100px; background-position:top center; background-size: cover;">
                                                                <h5 class="text-white my-4 font-weight-bold" align="center">Focus on Reading</h5>
                                                            </div>
                                                            <div class="card-body d-flex flex-column h-100 bg-light">


                                                                <div class="row">
                                                                    <cfoutput query="get_toeic_reading">
                                                                        
                                                                        <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                        
                                                                    </cfoutput>
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







                            <div class="tab-pane" id="toeic_exercice_listening" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">

                                        <!--- <cfoutput><p style="font-size:18px">#obj_translater.get_translate_complex('intro_toeic_preparation')#</p></cfoutput> --->
                                        
                                        <cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
                                        SELECT * FROM lms_quiz_user 
                                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
                                        AND quiz_id 
                                        IN (2203,2201,2197,2202,2191,2198,2199,2200) 
                                        </cfquery>
                                        
                                        
                                        <div id="container_listening_section_pres" class="collapse <cfif get_activity.recordcount eq "0">show</cfif>">
                                        <h5 class="mb-2 text-dark" style="font-size:22px">Listening section</h5>
                                        <hr class="mt-0 border-red">

                                        <div class="row">
                                            <cfoutput>
                                            <cfloop from="1" to="4" index="cor">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="card header_rounded_top">
                                                        <div class="header_rounded_top border-bottom-2 border-red" style="background-color:##C2E8F5; background-image: url('./assets/img/header_certif_#cor#.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                            <h5 class="text-white my-4 font-weight-bold" align="center">PART #cor#</h5>
                                                        </div>
                                                        <div class="card-body d-flex flex-column h-100 bg-light">
                                                        <p align="center">
                                                            <strong>#ucase(obj_translater.get_translate('title_toeic_part_#cor#'))#</strong>
                                                            <br>
                                                            #obj_translater.get_translate_complex('intro_toeic_part_#cor#')#
                                                            <br>
                                                            <button class="btn btn-info btn_display_part" data-id="#cor#">#obj_translater.get_translate('btn_train')#</button>
                                                        </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfloop>
                                            </cfoutput>
                            
                                        </div>
                                        </div>

                                        
                                        
                                        <div id="container_listening_section_details" class="collapse <cfif get_activity.recordcount neq "0">show</cfif>">
                                        <h5 class="mb-2 text-dark" style="font-size:22px">Listening section</h5>
                                        <hr class="mt-0 border-red">

                                        <div id="accordion_listening">
                                            <cfoutput>
                                            <cfloop from="1" to="4" index="cor">

                                                <div class="bg-light border shadow-sm mb-2">
                                                    <div class="d-flex justify-content-start p-2">
                                                        <div class="p-2" width="120">
                                                            <img width="120" class="rounded mr-2" src="./assets/img/header_certif_#cor#.jpg"> 
                                                        </div>
                                                        <div width="100%">
                                                            <h5 style="font-size:20px" class="m-0">PART #cor# : #obj_translater.get_translate('title_toeic_part_#cor#')#</h5>
                                                            #obj_translater.get_translate_complex('intro_toeic_part_#cor#')#
                                                        </div>
                                                    </div>
                                                    <div class="row justify-content-center">
														<a class="btn btn-sm btn-outline-info font-weight-normal p-1 m-1" data-toggle="collapse" data-target="##part_#cor#" aria-expanded="true" aria-controls="part_#cor#"><i class="far fa-chevron-double-down" aria-hidden="true"></i> Contenu</a>
													</div>
                                            

                                                    <div id="part_#cor#" class="collapse" data-parent="##accordion_listening">
                                                        <div class="card-body">
                                                            <!--- <p align="left" class="font-weight-normal"> --->
                                                            <!--- </p> --->

                                                            <cfquery name="get_part_#cor#" datasource="#SESSION.BDDSOURCE#">
                                                            SELECT q.quiz_id, q.quiz_name_#SESSION.LANG_CODE# as quiz_name, q.quiz_description_#SESSION.LANG_CODE# as quiz_description 
                                                            FROM lms_quiz q
                                                            <!--- LEFT JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id --->
                                                            <cfif cor eq "1">
                                                                WHERE quiz_id IN (2203,2201) 
                                                            <cfelseif cor eq "2">
                                                                WHERE quiz_id IN (2197,2202,2191) 
                                                            <cfelseif cor eq "3">
                                                                WHERE quiz_id IN (2198) 
                                                            <cfelseif cor eq "4">
                                                                WHERE quiz_id IN (2199,2200) 
                                                            </cfif>
                                                            <!---AND quiz_active = 1--->
                                                            </cfquery>

                                                            <div class="row">
                                                                <cfloop query="get_part_#cor#">                            
                                                                <cfinclude template="./incl/incl_quiz_content.cfm">
                                                                </cfloop>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                            </cfloop>
                                            </cfoutput>
                                        
                                        </div>
                                        </div>


                                    </div>
                                </div>
                                
                            </div>






                            <div class="tab-pane" id="toeic_exercice_reading" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">                                        


                                        <cfquery name="get_activity" datasource="#SESSION.BDDSOURCE#">
                                        SELECT
                                        em.elearning_module_id, em.elearning_module_path, 
                                        emg.elearning_module_group_id, emg.tp_orientation_id, emg.elearning_module_group_name,
                                        emu.update_date, emu.elearning_completion, emu.elearning_score

                                        FROM lms_elearning_module em
                                        INNER JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1
                                        INNER JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id
                                        INNER JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id
                                        INNER JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

                                        WHERE emg.elearning_module_group_id IN (41,42,43)
                                        </cfquery>

                                        <!--- <cfdump var="#get_activity#"> --->

                                        
                                        <div id="container_reading_section_pres" class="collapse <cfif get_activity.recordcount eq "0">show</cfif>">
                                        <h5 class="mb-2 text-dark" style="font-size:22px">Reading section</h5>
                                        <hr class="mt-0 border-red">

                                        <div class="row justify-content-center">
                                            <cfoutput>
                                            <cfloop from="5" to="7" index="cor">
                                                <div class="col-lg-3 col-md-3">
                                                    <div class="card header_rounded_top">
                                                        <div class="header_rounded_top border-bottom-2 border-red" style="background-color:##C2E8F5; background-image: url('./assets/img/header_certif_#cor#.jpg'); height:100px; background-position:center right; background-size: cover;">
                                                            <h5 class="text-white my-4 font-weight-bold" align="center">PART #cor#</h5>
                                                        </div>
                                                        <div class="card-body d-flex flex-column h-100 bg-light">
                                                        <p align="center">
                                                            <strong>#ucase(obj_translater.get_translate('title_toeic_part_#cor#'))#</strong>
                                                            <br>
                                                            #obj_translater.get_translate_complex('intro_toeic_part_#cor#')#
                                                            <br>
                                                            <button class="btn btn-info btn_display_part" data-id="#cor#">#obj_translater.get_translate('btn_train')#</button>
                                                        
                                                        </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </cfloop>
                                            </cfoutput>
                                        </div>
                                        </div>

                                        
                                        <div id="container_reading_section_details" class="collapse <cfif get_activity.recordcount neq "0">show</cfif>">
                                        <h5 class="mb-2 text-dark" style="font-size:22px">Reading section</h5>
                                        <hr class="mt-0 border-red">

                                        <div id="accordion_reading">
                                            <cfloop from="5" to="7" index="cor">

                                                <cfquery name="get_session_access_#cor#" datasource="#SESSION.BDDSOURCE#">
                                                SELECT
                                                em.elearning_module_id, em.elearning_module_path, 
                                                emg.elearning_module_group_id, emg.tp_orientation_id, emg.elearning_module_group_name,
                                                emu.update_date, emu.elearning_completion, emu.elearning_score

                                                FROM lms_elearning_module em
                                                LEFT JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id AND esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND esu.active = 1
                                                INNER JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id
                                                INNER JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id
                                                LEFT JOIN lms_elearning_module_user emu ON emu.elearning_module_id = esu.elearning_module_id AND emu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">

                                                <cfif cor eq "5">
                                                    WHERE emg.elearning_module_group_id = "41"
                                                <cfelseif cor eq "6">
                                                    WHERE emg.elearning_module_group_id = "42"
                                                <cfelseif cor eq "7">
                                                    WHERE emg.elearning_module_group_id = "43"
                                                </cfif>
                                               
                                                ORDER BY elearning_module_group_id, elearning_module_id, elearning_module_path
                                                </cfquery>

                                                <!--- <cfdump var="#evaluate('get_session_access_#cor#')#"> --->

                                                <div class="bg-light border shadow-sm mb-2">
                                                    <cfoutput>
                                                    <div class="d-flex justify-content-start p-2 w-100">
                                                        <div class="p-2" width="120">
                                                            <img width="120" class="rounded mr-2" src="./assets/img/header_certif_#cor#.jpg"> 
                                                        </div>
                                                        <div width="100%">
                                                            <h5 style="font-size:20px" class="m-0">PART #cor# : #obj_translater.get_translate('title_toeic_part_#cor#')#</h5>
                                                            #obj_translater.get_translate_complex('intro_toeic_part_#cor#')#
                                                        </div>
                                                    </div>
                                                    <div class="row justify-content-center">
														<a class="btn btn-sm btn-outline-info font-weight-normal p-1 m-1" data-toggle="collapse" data-target="##part_#cor#" aria-expanded="true" aria-controls="part_#cor#"><i class="far fa-chevron-double-down" aria-hidden="true"></i> Contenu</a>
													</div>
                                                    </cfoutput>


                                                    <div id="part_<cfoutput>#cor#</cfoutput>" class="collapse" data-parent="#accordion_reading">
                                                        <div class="card-body">
                                                            <!--- <cfdump var="#evaluate('get_session_access_#cor#')#"> --->

                                                            <div class="row">
                                                                <cfset __score = obj_translater.get_translate('table_th_score')>
                                                                <cfset __btn_train = obj_translater.get_translate('btn_train')>
                                                                <cfoutput query="get_session_access_#cor#">

                                                                    <cfinclude template="./incl/incl_module_el_certif.cfm">
                                                                    
                                                                </cfoutput>

                                                            </div>


                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                            </cfloop>
                                        
                                        </div>
                                        </div>

                                    </div>
                                </div>
                            </div>








                            <div class="tab-pane" id="bright" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">
                                    <div class="card-body">

                                        <!--- <h5 class="mb-2 text-dark" style="font-size:22px"><strong>LISTENING SECTION</strong></h5>
                                        <hr class="mt-0 border-red"> --->


                                        <div class="row">
                                            <div class="col-md-12">		
                                                <cfoutput query="get_formation">
                                                <a href="el_certif.cfm?subm=bright&f_bright_id=#formation_id#" class="btn <cfif isdefined("f_bright_id") AND f_id eq formation_id>btn-outline-info active<cfelse>btn-link</cfif>">
                                                <img src="./assets/img_formation/#formation_id#.png" width="40" height="40"><br><cfif len(formation_name) gt 8><small>#formation_name#</small><cfelse>#formation_name#</cfif>
                                                </a>
                                                </cfoutput>
                                            </div>
                                        </div>


                                        <cfoutput>#obj_translater.get_translate_complex('bright_intro')#</cfoutput>
									
                                        <br><br>
                                        
                                        <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_for_practice')#</cfoutput> - Bright Language English</h5>
                                        <hr class="mt-0 border-red">

                                        
                                        <div class="row">
                                            
                                            <div class="col-md-6">
                                            
                                            <cfoutput query="get_bright_reading">
                                                
                                                <cfquery name="get_result_bright_reading" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id# 
                                                </cfquery>

                                                    <div class="border-top border-success bg-light mt-3 p-2">
                                                
                                                    <div class="media">
                                                        <img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
                                                        <div class="media-body">
                                                            <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                            <small>#quiz_description#</small>
                                                            
                                                            <div class="clearfix"></div>
                                                            <div class="float-right">
                                                            
                                                                <cfif get_result_bright_reading.recordcount eq "0">
                                                                
                                                                    <a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
                                                                    
                                                                <cfelse>
                                                                    <a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                    
                                                                    <cfif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end neq "">
                                                                        <a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_bright_reading.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                    <!---<cfelseif get_result_bright_reading.recordcount neq "0" AND get_result_bright_reading.quiz_user_end eq "">
                                                                        <a href="./quiz.cfm?quiz_user_id=#get_result_bright_reading.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>--->									
                                                                    </cfif>
                                                            
                                                                </cfif>		
                                                                
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            
                                            </cfoutput>
                                            
                                            </div>
                                            
                                            <div class="col-md-6">
                                            
                                            <cfoutput query="get_bright_listening">
                                                
                                                <cfquery name="get_result_bright_listening" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = #quiz_id#
                                                </cfquery>

                                                    <div class="border-top border-success bg-light mt-3 p-2">
                                                
                                                    <div class="media">
                                                        <img src="./assets/img/logo_bright.jpg" width="120" class="mr-2">
                                                        <div class="media-body">
                                                            <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                            <small>#quiz_description#</small>
                                                            
                                                            <div class="clearfix"></div>
                                                            <div class="float-right">
                                                            
                                                                <cfif get_result_bright_listening.recordcount eq "0">
                                                                
                                                                    <a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
                                                                    
                                                                <cfelse>
                                                                    <a id="q_#quiz_id#" href="##" class="btn btn-sm btn-outline-success float-right btn_restart_quiz"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                            
                                                                    <cfif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end neq "">
                                                                        <a href="##" class="btn btn-sm btn-outline-success btn_view_quiz" id="quser_#get_result_bright_listening.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                    <!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
                                                                        <a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
                                                                    </cfif>
                                                            
                                                                </cfif>		
                                                                
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            
                                            </cfoutput>
                                            
                                            </div>
                                                
                                        </div>
                                        

                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>

            </div>

        <cfinclude template="./incl/incl_footer.cfm">

        </div>

    </div>

    
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">
        
<script>
$(document).ready(function() {
    $('#window_item_xl').on('hidden.bs.modal', function () {
        location.reload();
    })

    $('.btn_go_train').click(function(e) {	
        e.preventDefault()
        $("#btn_toeic_exercice_listening").tab('show');
    })

    $('.btn_go_mock_online').click(function(e) {	
        e.preventDefault()
        $("#btn_toeic_mock").tab('show');
        $("#btn_toeic_online").tab('show');
    })

    $('.btn_go_mock_paper').click(function(e) {	
        e.preventDefault()
        $("#btn_toeic_mock").tab('show');
        $("#btn_toeic_paper").tab('show');
    })

    $('.btn_display_part').click(function(e) {	
        e.preventDefault();
        var part_id = $(this).attr("data-id");
        if (part_id <= 4)
        {
            $("#container_listening_section_pres").collapse('hide');
            $("#container_listening_section_details").collapse('show');
            $("#part_"+part_id).collapse('show');
        } 
        else
        {
            $("#container_reading_section_pres").collapse('hide');
            $("#container_reading_section_details").collapse('show');
            $("#part_"+part_id).collapse('show');
        }
    })


    


    $('.btn_start_quiz').click(function(event) {		
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var q_id = idtemp[1];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({backdrop: 'static', keyboard: true});
        
        $('#modal_body_xl').load("modal_window_quiz_play_test.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});

    })
    
    $('.btn_view_quiz').click(function(event) {	
        event.preventDefault();		
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var quiz_user_id = idtemp[1];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {});
    })

    
    <cfloop query="get_skill">
    
    <cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
    SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
    FROM lms_skill_sub 
    WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
    </cfquery>
    
    <cfloop query="get_skill_sub">
    
    <cfquery name="get_feedback_solo" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_feedback WHERE skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#">
    </cfquery>
    
    $('.level_select_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>').change(function(event) {
        var go = $(this).val();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var skill_id = idtemp[1];	
        var skill_sub_id = idtemp[2];
        <!--- alert(go); --->
        <cfoutput query="get_feedback_solo">
        if (skill_sub_id == "#skill_sub_id#" && go == "#replace(level_id,".","_")#")
        {
            $('##feedtext_'+skill_id+'_'+skill_sub_id).val("#encodeforjavascript(feedback_text)#");
        }
        </cfoutput>
        
    })
    </cfloop>

    </cfloop>

});
</script>

</body>
</html>