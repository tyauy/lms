<cfsilent>

    <cfparam name="f_id" default="2">

    <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
    SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id = 3 OR skill_id = 1
    </cfquery>

    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name
    FROM lms_level
    WHERE level_id NOT IN (0,6) 
    </cfquery>

    <cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>
    
    <cfquery name="get_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE (quiz_type = "reading_training" OR quiz_type = "bright reading") AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
    </cfquery>
    
</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>

    </style>
</head>

<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
            
            <cfset title_page = "ELEARNING CERTIFICATION">
            <cfinclude template="./incl/incl_nav.cfm">

            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                
                <div class="row">
                    
                    <div class="col-md-12">

                        <nav>
                            <div class="nav nav-tabs" id="nav-tab" role="tablist" align="center">
                                <button class="nav-link active" data-toggle="tab" data-target="#grammar_1" type="button" role="tab" aria-controls="grammar_1" aria-selected="true"><cfoutput>#obj_translater.get_translate('tab_el_training_level')#</cfoutput></button>
                                <button class="nav-link" data-toggle="tab" data-target="#grammar_2" type="button" role="tab" aria-controls="grammar_2" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_grammar_review')#</cfoutput></button>
                                <!--- <button class="nav-link" data-toggle="tab" data-target="#grammar_3" type="button" role="tab" aria-controls="grammar_3" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong><cfoutput>#obj_translater.get_translate('btn_el_grammar_points')#</cfoutput></strong></button> --->
                                <button class="nav-link" data-toggle="tab" data-target="#rl_1" type="button" role="tab" aria-controls="rl_1" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong>Reading Comprehension</strong></button>
                                <button class="nav-link" data-toggle="tab" data-target="#rl_2" type="button" role="tab" aria-controls="rl_2" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong>Listening Comprehension</strong></button>
                                <button class="nav-link" data-toggle="tab" data-target="#lingua_1" type="button" role="tab" aria-controls="lingua_1" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_demo')#</cfoutput> <br> <strong>Linguaskill</strong></button>
                                <button class="nav-link" data-toggle="tab" data-target="#toeic" type="button" role="tab" aria-controls="toeic" aria-selected="false"><cfoutput>Mocks tests</cfoutput> <br> <strong>Toeic</strong></button>
                            </div>
                        </nav>

                        <div class="tab-content">
                            <div class="tab-pane show active" id="grammar_1" role="tabpanel">

                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_title_training_level')#</cfoutput></h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>

                                        <div class="row justify-content-between">

                                            <div class="col-md-12">
                                
                                                <div class="d-flex justify-content-center">
                                

                                                    <div class="btn-group-toggle" data-toggle="buttons">
                                                        <cfoutput query="get_level">
                                                            <label class="btn btn_change_level btn-outline-#level_alias# <cfif level_id eq "1">active</cfif>" data-levelid="#level_id#" data-toggle="collapse" data-target="##collapse_#level_id#" <cfif level_id eq "1">aria-expanded="true"<cfelse>aria-expanded="false"</cfif>>
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
                                                            <div class="card border bg-white">
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
                                                                            <tr class="bg-#get_level.level_alias#">
                                                                                <td>
                                                                                    <img src="./assets/img_sublevel/#level_sub_id#.svg" width="40" align="left">
                                                                                    <!--- <img src="./assets/img_sublevel/#replace(cor2,"_",".")#.svg" width="40" align="left"> --->
                                                                                    <!--- <h6 class="mt-2 text-white"> #replace(,"_",".")#</h6> --->
                                                                                </td>
                                                                                <td align="center" class="text-white">#obj_translater.get_translate('tab_el_learn_rules')#</td>
                                                                                <td align="center" class="text-white">#obj_translater.get_translate('tab_el_training_exerices')#</td>
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
                                                                                AND tm.tpmaster_id IN
                                                                                (11,12,13,14)
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
                                                                                                    <small>Learn #counter#</small>
                                                                                                    <br>
                                                                                                    <i class="fa-thin fa-laptop"></i>
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
                                                                                                        <small>Practice #counter#</small>
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

                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-book fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_title_el_grammar_review')#</cfoutput></h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>
    
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







                            <div class="tab-pane" id="rl_1" role="tabpanel">

                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-books" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> "Reading Comprehension"</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>

                                        <div class="row mt-1">
                                            <div class="col-md-12">
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
                                        </div>
                                    </div>
                                </div>
                            </div>






                            <div class="tab-pane" id="rl_2" role="tabpanel">

                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-head-side-headphones" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> "Listening Comprehension"</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>

                                        <div class="row mt-1">
                                            <div class="col-md-12">
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


                            <div class="tab-pane" id="lingua_1" role="tabpanel">


                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('tab_el_demo')#</cfoutput> - LINGUASKILL</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>

                                        <div class="row">
                                            
                                            <div class="col-md-6 mt-3">

                                                <h6 class="text-info"> LINGUASKILL GENERAL</h6>
                                                
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
                                                    
                                            <div class="col-md-6 mt-3">

                                                <h6 class="text-info">LINGUASKILL BUSINESS</h6>	

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


                            <div class="tab-pane" id="toeic" role="tabpanel">

                                <div class="card border mt-3">
                                    <div class="card-body">
                                            
                                        <div class="w-100">
                                            <h5 class="d-inline"><i class="fa-thin fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('table_th_mock_tests')#</cfoutput> - TOEIC</h5>
                                            <hr class=">border border-red mb-1 mt-2">
                                        </div>
                                        <div class="row">
                                        <cfoutput query="get_toeic">
											
                                            <cfquery name="get_result_toeic" datasource="#SESSION.BDDSOURCE#">
                                            SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
                                            </cfquery>
                                        
                                            <div class="col-md-6">
                                                  
                                                <div class="card border bg-light mt-3">
                                                
                                                    <div class="card-body">

                                                        <div class="media">

                                                            <img src="./assets/img/logo_toeic.jpg" width="120" class="mr-2">
                                                            <div class="media-body">
                                                                <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-success">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                                <small>#quiz_description#</small>
                                                                
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">
                                                                

                                                                    <cfif get_result_toeic.recordcount eq "0">
                                                                    
                                                                        <button class="btn btn-sm btn-outline-info btn_start_quiz" id="q_#quiz_id#">#obj_translater.get_translate('btn_go_test')#</button>
                                                                        
                                                                    <cfelse>
                                                                        <a href="##" class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_reading.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                                
                                                                        <cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq "">
                                                                            <a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_toeic.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                        <!---<cfelseif get_result_bright_listening.recordcount neq "0" AND get_result_bright_listening.quiz_user_end eq "">
                                                                            <a href="./quiz.cfm?quiz_user_id=#get_result_bright_listening.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>		---->									
                                                                        </cfif>
                                                                
                                                                    </cfif>	


                                                                    
                                                                </div>
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

    $('.btn_start_quiz').click(function(event) {		
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var q_id = idtemp[1];	

        $('#modal_title_xl').text("Exercice");
        $('#window_item_xl').modal({backdrop: 'static', keyboard: true});
        $('#modal_body_xl').load("modal_window_quiz_play.cfm?quiz_id="+q_id+"&new_quiz=1&del_quiz=1", function() {});
    
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