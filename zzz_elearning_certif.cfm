<cfsilent>

    <cfset SESSION.EL_CERTIF = "1">
    <cfparam name="f_id" default="2">
    <cfparam name="u_id" default="#SESSION.USER_ID#">
    <cfparam name="subm" default="linguaskill">
    <cfset lang_select = "en">
    
    
    <cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
    </cfquery>
    
    <cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
    </cfquery>
    
    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
    </cfquery>
    
    <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
    SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id = 3 OR skill_id = 1
    </cfquery>
    
    <cfquery name="get_formations_solo" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_fr as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    </cfquery>
    
    <cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
    SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    </cfquery>
    
    <cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
    SELECT DISTINCT(level_id) as level_id FROM lms_grammar WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
    </cfquery>

    <cfquery name="get_toeic" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "toeic" AND quiz_active = 1
    </cfquery>

    <cfquery name="get_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>
    
    <!--- <cfquery name="get_grammar_quiz" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright reading" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery> --->

    <cfquery name="get_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE (quiz_type = "reading_training" OR quiz_type = "bright reading") AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name
    FROM lms_level
    WHERE level_id NOT IN (0,6) 
    </cfquery>


    
    <cfset gr_id = 0>
    
    <cfset list_level="A1_1,A1_2,A1_3,A2_1,A2_2,A2_3,B1_1,B1_2,B1_3,B2_1,B2_2,B2_3,C1_1,C1_2,C1_3">
        
    <cfset bg_header= "bg-info">

    <cfset bg_menu1= "bg-light">
    <cfset txt_menu1= "text-secondary">

    <cfset bg_menu2= "bg-light">
    <cfset txt_menu2= "text-secondary">

    <cfset bg_menu3= "bg-white">
    <cfset txt_menu3= "text-info">    
    
    </cfsilent>
    
    <cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>
    
    <head>
    
        <cfinclude template="./incl/incl_head.cfm">
        <style>

        .btn-outline-info {color:#51bcda !important;}
        .btn-outline-success {color:#80bb46  !important;}
        .btn-outline-primary {color:#51cbce  !important;}
        .btn-outline-danger {color:#ef8157  !important;}
        .btn-outline-warning {color:#fbc658  !important;}

        #sortable { list-style-type: none; margin: 0; padding: 0; }

        </style>

<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
		
	.nav-link {
		color: #999999 !important;
	}
    .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
		background-color: #51bcda !important;
	}


	</style>
    
    </head>
    
    
    <body>
    
    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "GLOBAL LANGUAGE ASSESSMENT">
            <cfinclude template="./incl/incl_nav.cfm">
    
                
            <div class="content">
    
                <div class="row mt-3">
                    <div class="col-md-12">

                    </div>
                </div>

                <div class="d-flex justify-content-center <cfoutput>#bg_header#</cfoutput> pt-3 mt-5" >
      
                    <!--- <div class="col-lg-3 col-md-3 col-sm-3" style="margin-top:-40px !important">
                                
                        <div class="card <cfif subm eq "grammar">border-top border-info</cfif> mb-3" onclick="document.location.href='elearning_certif.cfm?subm=grammar'" style="cursor:pointer">
                            <div class="card-body">
                                <div align="center"><i class="fal fa-spell-check fa-2x <cfif subm eq "grammar">text-info</cfif>"></i> <br> <span class="<cfif subm eq "grammar">text-info</cfif>"><cfoutput>#obj_translater.get_translate('tab_el_grammar')#</cfoutput></span></div>											
                            </div>
                        </div>
            
                    </div> --->

                    <!--- <div class="col-lg-3 col-md-3 col-sm-3" style="margin-top:-40px !important">
                                
                        <div class="card <cfif subm eq "rl">border-top border-info</cfif> mb-3" onclick="document.location.href='elearning_certif.cfm?subm=rl'" style="cursor:pointer">
                            <div class="card-body">
                                <div align="center"><i class="fal fa-books fa-2x <cfif subm eq "rl">text-info</cfif>"></i> <i class="fal fa-head-side-headphones fa-2x <cfif subm eq "rl">text-info</cfif>"></i> <br> <span class="<cfif subm eq "rl">text-info</cfif>">Reading & Listening</span></div>											
                            </div>
                        </div>
            
                    </div> --->
            
                    <!--- <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                                
                        <div class="card <cfif subm eq "listening">border-top border-info</cfif> mb-3" onclick="document.location.href='elearning_certif.cfm?subm=listening'">
                            <div class="card-body">
                                <div align="center"><i class="fal fa-books fa-2x <cfif subm eq "listening">text-info</cfif>"></i> <br> <span class="<cfif subm eq "listening">text-info</cfif>">Listening<br>Comprehension</span></div>											
                            </div>
                        </div>
            
                    </div> --->
            
                    <!--- <div class="col-lg-2 col-md-2 col-sm-3" style="margin-top:-40px !important">
                                
                        <div class="card <cfif subm eq "toeic">border-top border-info</cfif> mb-3" onclick="document.location.href='elearning_certif.cfm?subm=toeic'" style="cursor:pointer">
                            <div class="card-body">
                                <div align="center">
                                <img src="./assets/img/logo_toeic.jpg" width="83" class="mr-2 d-block">
                                <span class="<cfif subm eq "toeic">text-info</cfif>">Examens blancs</span>
                                </div>											
                            </div>
                        </div>
            
                    </div> --->

                    <div class="col-lg-3 col-md-3 col-sm-3" style="margin-top:-40px !important">
                                
                        <div class="card <cfif subm eq "linguaskill">border-top border-info</cfif> mb-3" onclick="document.location.href='elearning_certif.cfm?subm=linguaskill'" style="cursor:pointer">
                            <div class="card-body">
                                <div align="center">
                                    <img src="./assets/img/logo_linguaskill_inline.png" width="150" class="mr-2 d-block">
                                    <span class="<cfif subm eq "linguaskill">text-info</cfif>"><cfoutput>#obj_translater.get_translate('tab_el_prep_exam')#</cfoutput></span>
                                </div>	
                            </div>
                        </div>
            
                    </div>

                </div>
    

                <div class="row mt-3">
                    <div class="col-md-12">

                        <cfif subm eq "linguaskill">

                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link active" data-toggle="tab" data-target="#grammar_1" type="button" role="tab" aria-controls="grammar_1" aria-selected="true"><cfoutput>#obj_translater.get_translate('tab_el_training_level')#</cfoutput></button>
                                    <button class="nav-link" data-toggle="tab" data-target="#grammar_2" type="button" role="tab" aria-controls="grammar_2" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_grammar_review')#</cfoutput></button>
                                    <!--- <button class="nav-link" data-toggle="tab" data-target="#grammar_3" type="button" role="tab" aria-controls="grammar_3" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong><cfoutput>#obj_translater.get_translate('btn_el_grammar_points')#</cfoutput></strong></button> --->
                                    <button class="nav-link" data-toggle="tab" data-target="#rl_1" type="button" role="tab" aria-controls="rl_1" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong>Reading Comprehension</strong></button>
                                    <button class="nav-link" data-toggle="tab" data-target="#rl_2" type="button" role="tab" aria-controls="rl_2" aria-selected="false"><cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <br> <strong>Listening Comprehension</strong></button>
                                    <button class="nav-link" data-toggle="tab" data-target="#lingua_1" type="button" role="tab" aria-controls="lingua_1" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_demo')#</cfoutput> <br> <strong>Linguaskill</strong></button>
                                </div>
                            </nav>

                            <div class="tab-content">
                                <div class="tab-pane show active" id="grammar_1" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-spell-check fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_title_training_level')#</cfoutput></h5>
                                                <hr class=">border-red mb-1 mt-2">
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
                                                                                                        <i class="fal fa-laptop"></i>
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
                                                                                                            <i class="fal fa-star"></i>
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
                                                <h5 class="d-inline"><i class="fal fa-book fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_title_el_grammar_review')#</cfoutput></h5>
                                                <hr class=">border-red mb-1 mt-2">
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
                                                                                    <i class="fal fa-laptop"></i>
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










                                <!--- <div class="tab-pane" id="grammar_3" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-edit fa-lg mr-1" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> <cfoutput>#obj_translater.get_translate('btn_el_grammar_points')#</cfoutput></h5>
                                                <hr class=">border-red mb-1 mt-2">
                                            </div>
        
                                            <div class="row">
                                                <div class="col-md-12">
        
                                                    <cfoutput query="get_grammar_quiz">
                                                                            
                                                        <cfquery name="get_result_grammar_quiz" datasource="#SESSION.BDDSOURCE#">
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
                                                                        
                                                                            <cfif get_result_grammar_quiz.recordcount eq "0">
                                                                            
                                                                                <button class="btn btn-sm btn-outline-info btn_start_quiz" id="q_#quiz_id#">#obj_translater.get_translate('btn_go_test')#</button>
                                                                                
                                                                            <cfelse>
                                                                                <button class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_grammar_quiz.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</button>																
                                                                                        
                                                                                <cfif get_result_grammar_quiz.recordcount neq "0" AND get_result_grammar_quiz.quiz_user_end neq "">
                                                                                    <button <!---href="##"---> class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_grammar_quiz.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</button>
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

                                </div> --->






                                <div class="tab-pane" id="rl_1" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-books" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> "Reading Comprehension"</h5>
                                                <hr class=">border-red mb-1 mt-2">
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
                                                <h5 class="d-inline"><i class="fal fa-head-side-headphones" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('btn_el_exercices')#</cfoutput> "Listening Comprehension"</h5>
                                                <hr class=">border-red mb-1 mt-2">
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
                                                <h5 class="d-inline"><i class="fal fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('tab_el_demo')#</cfoutput> - LINGUASKILL</h5>
                                                <hr class=">border-red mb-1 mt-2">
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
                                                    
                                                    <!--- <br>
                                                    
                                                    <h6 class="text-info">DEMO - Linguaskill General</h6>
                                                        
                                                    <div class="border-top bg-light mt-3 p-2">
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1">DEMO - <cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput></h6>
                                                                <em><small>
                                                                
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LSKLDEMO02" class="btn btn-sm btn-outline-info mb-0">DEMO</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> --->
                                                    
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
                                                    
                                                    <!--- <br>
                                                    
                                                    <h6 class="text-info">DEMO - Linguaskill Business</h6>	
                                                    
                                                    <div class="border-top bg-light mt-3 p-2">				
                                                        <div class="media">
                                                            <img src="./assets/img/logo_linguaskill.png" width="120" class="align-self-center mr-3">
                                                            <div class="media-body">
                                                                <h6 class="mt-1">DEMO - <cfoutput>#obj_translater.get_translate('card_linguaskill_name')#</cfoutput></h6>
                                                                <em><small>
                                                                
                                                                <cfoutput>#obj_translater.get_translate_complex('lingua_redirected')#</cfoutput>
                                                                
                                                                </small></em>
                                                                <div class="clearfix"></div>
                                                                <div class="float-right">												
                                                                    <a target="_blank" href="https://www.metritests.com/metricatestdelivery/Assessment/Assignment?test=LinguaskillBusinessDemo" class="btn btn-sm btn-outline-info mb-0">DEMO</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> --->
                                                    
                                                </div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>


                            

                            

                            














                        <!--- <cfelseif subm eq "linguaskill">

                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link active" data-toggle="tab" data-target="#lingua_4" type="button" role="tab" aria-controls="lingua_4" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_test_presentation')#</cfoutput></button>
                                    <button class="nav-link" data-toggle="tab" data-target="#lingua_2" type="button" role="tab" aria-controls="lingua_2" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_prep_technics')#</cfoutput></button>
                                    <button class="nav-link" data-toggle="tab" data-target="#lingua_3" type="button" role="tab" aria-controls="lingua_3" aria-selected="false"><cfoutput>#obj_translater.get_translate('tab_el_further_exercices')#</cfoutput></button>
                                </div>
                            </nav>

                            <div class="tab-content"> --->
                                







                                <!--- <div class="tab-pane show active" id="lingua_4" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-edit" aria-hidden="true"></i> Présentation du test</h5>
                                                <hr class=">border-red mb-1 mt-2">
                                            </div>


                                            <div class="row mt-3">
                                                <div class="col-md-3">

                                                    <nav id="navbar-lingua_4" class="navbar navbar-light bg-light">
                                                        <nav class="nav nav-pills flex-column">

                                                            <a class="nav-link" href="#item-presentation-1">Linear VS Adaptative testing</a>

                                                            <a class="nav-link" href="#item-presentation-2">Different levels of questions</a>

                                                            <a class="nav-link" href="#item-presentation-3">Test Format : Reading & Listening</a>

                                                                <nav class="nav nav-pills flex-column">
                                                                    <a class="nav-link ml-3 my-1" href="#item-presentation-3-1">Reading section</a>
                                                                    <a class="nav-link ml-3 my-1" href="#item-presentation-3-2">Listening section</a>
                                                                </nav>

                                                            <a class="nav-link" href="#item-presentation-4">Timing</a>

                                                            
                                                        </nav>
                                                    </nav>
                                                      
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
                                </div> --->







                                <!--- <div class="tab-pane" id="lingua_2" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-edit" aria-hidden="true"></i> Techniques de préparation</h5>
                                                <hr class=">border-red mb-1 mt-2">
                                            </div>

                                            <div class="row mt-3">
                                                <div class="col-md-3">


                                                    <nav id="navbar-lingua_2" class="navbar navbar-light bg-light">
                                                        <nav class="nav nav-pills flex-column">

                                                            <a class="nav-link" href="#item-1">Language Training Vs Exam Technique</a>

                                                            <a class="nav-link" href="#item-2">Key Language Points for Linguaskills</a>

                                                            <nav class="nav nav-pills flex-column">
                                                                <a class="nav-link ml-3 my-1" href="#item-2-1">Basic Sentence Structure</a>
                                                                <a class="nav-link ml-3 my-1" href="#item-2-2">Collocations</a>
                                                            </nav>
                                                            
                                                            <a class="nav-link" href="#item-3">Universal Exam Techniques</a>
                                                            <nav class="nav nav-pills flex-column">
                                                                <a class="nav-link ml-3 my-1" href="#item-3-1">Traffic Light Approach</a>
                                                                <a class="nav-link ml-3 my-1" href="#item-3-2">Looking for Evidence</a>
                                                                <a class="nav-link ml-3 my-1" href="#item-3-3">Elimination</a>
                                                            </nav>
                                                            
                                                            <a class="nav-link" href="#item-4">Specific techniques</a>

                                                            <a class="nav-link" href="#item-5">Finding Materials</a>

                                                            <a class="nav-link" href="#item-6">Familiarity</a>
                                                            
                                                        </nav>
                                                    </nav>
                                                      
                                                </div>

                                                <div class="col-md-9">

                                                    <div data-spy="scroll" data-target="#navbar-lingua_2" data-offset="0">

                                                        One important thing to note for the exam is that while the technology it uses for testing is quite advanced in being adaptive, the actual questions are not particularly complex in their design and are not unlike questions we see in lots of regular ESL materials.
                                                        <br><br>
                                                        There are four major issues that we need to look at for exams and the way we help the learners. 
                                                        <ul>
                                                            <li>Language training vs Exam training</li>
                                                            <li>Language points for Linguaskills</li>
                                                            <li>Universal exam techniques</li>
                                                            <li>Specific exam techniques for Linguaskills</li>
                                                        </ul>

                                                        <h5 id="item-1">Language Training Vs Exam Technique</h5>
                                                        <p>
                                                            This is a common theme in preparing for any English language exam. It is common to see learners with great levels of general English do terribly on a structured exam and others with much worse levels excel. Conversely, there are learners who prep and prep for an exam but get no nearer to passing because they just do not have the fundamental language skills. This brings us to our major point. Preparing for Linguaskills is not just about learning the structure of the questions and exam techniques. It is also about ensuring the learners have the right level of language and, crucially, practice specific language skills that will be useful for the exam. The next section will look at some of the language points that we need to focus on.
                                                        </p>

                                                        <h5 id="item-2">Key Language Points for Linguaskills</h5>
                                                        <p>
                                                            There are several points and areas that we can guide learners to either for in-class work or for them to do at home. 
                                                            <br>

                                                            <h6 id="item-2-1">Basic Sentence Structure</h6>
                                                        It is really important to have a solid foundation of language. This is particularly important for three sections of the test: Gapped Sentences / Multiple Choice Gap Fill / Open Gap Fill
                                                        <br><br>
                                                        The idea here is that learners need to know a few key points that will help them choose correct answers. These include:
                                                        <ol>
                                                            <li>Auxiliaries
                                                                <ul>
                                                                    <li>Be Vs Do</li>
                                                                    <li>Conjugation, for example</li>
                                                                    <li>Present continuous am vs are vs is</li>
                                                                    <li>Go vs went vs gone</li>
                                                                </ul>
                                                            </li>
                                                            <li>Articles
                                                                <ul>
                                                                    <li>An vs a</li>
                                                                    <li>An/a Vs The</li>
                                                                </ul>
                                                            </li>
                                                            <li>Comparatives and intensifiers
                                                                <ul>
                                                                    <li>As… as …</li>
                                                                    <li>Using than</li>
                                                                    <li>So/Very/Really</li>
                                                                </ul>
                                                            </li>
                                                        </ol>




                                                        <h6 id="item-2-1">Collocations</h6>
                                                        These are the biggest issues when it comes to Linguaskills. In all three of the sections mentioned in the previous section, we see lots and lots of questions based around collocations. These come in several forms such as common:
                                                        <br><br>

                                                        <ol>
                                                            <li>Common structured collocations such as Make/Do/Take/Have
                                                                <ul>
                                                                    <li>Make a mistake</li>
                                                                    <li>Take a break</li>
                                                                    <li>Do business</li>
                                                                </ul>
                                                            </li>
                                                            <li>Basic collocations that we encounter in practical situations such as travel, shopping and meetings. We will find these in the lower levels.
                                                                <ul>
                                                                    <li>Book a room</li>
                                                                    <li>Buy tickets</li>
                                                                </ul>
                                                            </li>
                                                            <li>More complex collocations from a wider variety of areas that are less predictable. We find these in the advanced levels.
                                                                <ul>
                                                                    <li>Get the gist</li>
                                                                    <li>Cast doubt</li>
                                                                    <li>Research reveals</li>
                                                                    <li>Shed light</li>
                                                                </ul>
                                                            </li>
                                                            <li>Collocations with prepositions. These are in all levels, but more commonly in the advanced ones.
                                                                <ul>
                                                                    <li>Builds upon</li>
                                                                    <li>Consist of</li>
                                                                </ul>
                                                            </li>
                                                        </ol>
                                                        </p>









                                                        <h5 id="item-3">Universal Exam Techniques</h5>
                                                        <p>


                                                            There are a selection of techniques that we can apply to more than one type of question within the test:
                                                            <br>

                                                        <h6 id="item-3-1">Traffic Light Approach</h6>
                                                        This is a great way of analysing how we approach a question and looks at i) how we can use our time, and ii) how we work on decision making. The idea is that we categorise questions in three ways: Red, Yellow and Green. The red and green options are relatively simple:
                                                        <ol>
                                                            <li>Red: These are questions that the learner finds very difficult and they genuinely do not understand. For example, it is a piece of vocab that the learner doesn't recognise at all. The idea here is that the learner gives it their best shot and moves on so as not to i) waste time, or ii) second guess themselves feel negative 
                                                                The aspect of negativity is that if learners spend too long focusing on one question that they cannot answer, they might get a little fixated and lose confidence. So, it they answer and move on it limits that possibility</li>
                                                            <li>Green: These are questions that the learner is sure of, or at least almost sure of. The idea here is that they check and make sure they feel they are correct … and then answer the question. The main idea is that we are encouraging them not to i) waste time, or ii) second guess themselves.</li>
                                                            <li>Yellow: This is the area where we want the learners to focus more: Questions that are difficult, but that they can answer with a bit of thought. For this one, we can apply some of the techniques listed below.</li>
                                                        </ol>



                                                        <h6 id="item-3-2">Looking for Evidence</h6>

                                                        This is not a hugely complex technique. The idea is that we explain to the learner that for questions they find difficult, rather than just go with a guess, they should look for evidence to support the answer they choose. Here are a few simple examples of how to do this: 
                                                        <br>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE3.jpg" width="800">
                                                                        </div>
                                                                        <em>This is an example of a Gapped Sentence question. The structure is the first conditional, so the learner needs to be linking “if they aren’t” with “they will”.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE3.jpg" width="100%">
                                                                        </div>
                                                                        <em>This is an example of a Gapped Sentence question. The structure is the first conditional, so the learner needs to be linking “if they aren’t” with “they will”.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE9.jpg" width="100%">
                                                                        </div>
                                                                        <em>This is another Gapped Sentences question. The structure is the present perfect, so the learner needs to choose eaten because it fits with the auxiliary ‘have’.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE5.jpg" width="100%">
                                                                        </div>
                                                                        <em>This is an example of a Read and Select question. The statement says that instead of two buses an hour there will be one, so the learner needs to choose “less frequent”.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE4.jpg" width="100%">
                                                                        </div>
                                                                        <em>This is an example of a Read and Select question. The learner needs to look at building works in the text and then construction in the answer options.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <br><br>
                                                        This type of technique is relatively simple and perhaps we can best describe it as asking the learner to think about why they will choose each answer. The more they can do that, the better their chances of getting things correct

                                                        <br><br>
                                                        <h6 id="item-3-3">Elimination</h6>

                                                        If we imagine that looking for evidence of a correct answer is a positive approach to exam questions, then we can also use a negative approach to work on eliminating incorrect answers. The goal with the positive approach is to be able to find the correct answer. By definition, that is the preferable approach. However, if the learner is struggling, being able to eliminate one or two answers that are not correct can make the decision making process easier and improve their chances of getting a correct answer.
                                                        
                                                        
                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE3.jpg" width="100%">
                                                                        </div>
                                                                        <em>In the last section we saw this question example when we looked for evidence. However, if the learner doesn’t recognise the structure of the first conditional, it might be more difficult for them to answer correctly. So, we need to help them work their way through by eliminating the wrong answers. This example is quite easy as we cannot use be or am with the base form of a verb (In this case send). But, the learners may also recognise that “That” doesn’t pair with be or am.
                                                                        </em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE1.jpg" width="100%">
                                                                        </div>
                                                                        <em>This one is a great example of how we can use elimination. If the learner recognises break and coffee as two words that pair well together, super. However, if they do not, we can eliminate off and hour as both of those are likely to be preceded by an rather than a.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/CE2.jpg" width="100%">
                                                                        </div>
                                                                        <em> The only real language that could relate to numbers and figures is “one hour”. Therefore, we can eliminate the second option as 20 couldn’t link to one hour.</em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        </p>






                                                        <h5 id="item-4">Specific Techniques</h5>
                                                        <p>
                                                        The above techniques can be applied to several different types of questions in the reading section. However, there are some techniques that we can apply only to specific types of questions.
                                                        <br><br>

                                                        <strong>Read and select & Extended Reading</strong>
                                                        <br>
                                                        These questions are, essentially, reading comprehension. There are two easy techniques we can teach here:
                                                        <ul>
                                                            <li>Keyword Matching: We show the learner how to match the key words in the possible descriptions to the key words in the item that might indicate a correct answer.</li>
                                                            <li>Paraphrasing: Questions like these tend to have the information in the text presented in the options using synonyms or alternative types of vocabulary.</li>
                                                        </ul>
                                                        <br>
                                                        This technique in itself will not always reveal the answer definitively as the test will have distractors in many questions. However, it is a good way for learners to whittle down the options and help guide them towards the best answer.



                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/image1.png" width="100%">
                                                                        </div>
                                                                        <em>With this example, we would apply the above techniques by linking words in the text like menu with similar words in the sample like food and change with a word like different.
                                                                        </em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <br>
                                                        <div class="row justify-content-center">
                                                            <div class="col-md-9">
                                                                <div class="card bg-light border">
                                                                    <div class="card-body">
                                                                        <div align="center">
                                                                            <img src="./assets/img_linguaskill/preparation/image2.jpg" width="100%">
                                                                        </div>
                                                                        <em>With the extended reading questions, the idea is essentially the same but more complicated. The only differences are the quantity of text and the number of questions. For example, with this one about a book review. The question is asking what people thought when they saw the horse Hans. The text gives several clues that they were ‘mistaken’. However, of course, it does not use such language. Rather, it uses language to hint this. Clues  include:
                                                                        <ul>
                                                                        <li>“Han’s true skill” (Not what the people believed)</li>
                                                                        <li>“The spectators were convinced” (Used to imply they had been fooled)</li>
                                                                        <li>“Even eminent scientists” (Used to show that it was not surprising that people were mistaken)</li>
                                                                        </ul></em>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        


                                                        </p>

                                                        <h5 id="item-5">Finding Materials</h5>
                                                        <p>
                                                        In some of the sections, it is not difficult to prepare as the questions are quite similar to a lot of traditional materials. A good example of this is i) Read and Select and Extended Reading are both very similar to section 7 in the TOEIC exam. Similarly, the i) Gapped sentences and ii) Multiple choice gap-fill questions are very similar to sections 5 and 6 of the TOEIC. Finally, in the listening section, Extended Listening is similar to sections 3 and 4 of the TOEIC. Therefore, to help learners to practice we can give them:
                                                        <br>Use the sample Linguaskills materials on the LMS
                                                        <br>Use the TOEIC materials on the LMS
                                                        </p>

                                                        <h5 id="item-6">Familiarity</h5>
                                                        <p>One final note here is a relatively simple one. Even though the test is adaptive, the learners will face the same type of questions. Therefore it is hugely important that not only do the learners prep for the test - either themselves or in classes with a teacher - but that they also do the practice tests that are available on the LMS so they get super familiar with the different types of questions. </p>
                                                      

                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div> --->





                                <!--- <div class="tab-pane" id="lingua_3" role="tabpanel">

                                    <div class="card border mt-3">
                                        <div class="card-body">
                                                
                                            <div class="w-100">
                                                <h5 class="d-inline"><i class="fal fa-edit" aria-hidden="true"></i> Exercices pour aller plus loin</h5>
                                                <hr class=">border-red mb-1 mt-2">
                                            </div>

                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="card border bg-light mt-3">
                                                        <div class="card-body">
                                                            <h6 class="mt-2">USING ENGLISH</h6>
                                                            <a href="https://www.usingenglish.com/quizzes/400.html" target="_blank">https://www.usingenglish.com/quizzes/400.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/550.html" target="_blank">https://www.usingenglish.com/quizzes/550.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/399.html" target="_blank">https://www.usingenglish.com/quizzes/399.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/549.html" target="_blank">https://www.usingenglish.com/quizzes/549.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/502.html" target="_blank">https://www.usingenglish.com/quizzes/502.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/231.html" target="_blank">https://www.usingenglish.com/quizzes/231.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/176.html" target="_blank">https://www.usingenglish.com/quizzes/176.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/521.html" target="_blank">https://www.usingenglish.com/quizzes/521.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/103.html" target="_blank">https://www.usingenglish.com/quizzes/103.html</a><br>
                                                            <a href="https://www.usingenglish.com/quizzes/175.html" target="_blank">https://www.usingenglish.com/quizzes/175.html</a><br>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="card border bg-light mt-3">
                                                        <div class="card-body">
                                                            <h6 class="mt-2">LEARNENGLISHFEELGOOD</h6>
                                                            <a href="https://www.learnenglishfeelgood.com/adjectives-prepositions1.html" target="_blank">https://www.learnenglishfeelgood.com/adjectives-prepositions1.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/adjectives-prepositions2.html" target="_blank">https://www.learnenglishfeelgood.com/adjectives-prepositions2.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-adjectives-with-prepositions4.html" target="_blank">https://www.learnenglishfeelgood.com/english-adjectives-with-prepositions4.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-adjectives-with-prepositions5.html" target="_blank">https://www.learnenglishfeelgood.com/english-adjectives-with-prepositions5.html</a><br>
                                                            
                                                            <a href="https://www.learnenglishfeelgood.com/prepositions-mixed2.html" target="_blank">https://www.learnenglishfeelgood.com/prepositions-mixed2.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-prepositions-mixed3.html" target="_blank">https://www.learnenglishfeelgood.com/english-prepositions-mixed3.html</a><br>
                                                            
                                                            <a href="https://www.learnenglishfeelgood.com/english-auxiliary-verbs1.html" target="_blank">https://www.learnenglishfeelgood.com/english-auxiliary-verbs1.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-auxiliary-verbs2.html" target="_blank">https://www.learnenglishfeelgood.com/english-auxiliary-verbs2.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-auxiliary-verbs3.html" target="_blank">https://www.learnenglishfeelgood.com/english-auxiliary-verbs3.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-auxiliary-verbs4.html" target="_blank">https://www.learnenglishfeelgood.com/english-auxiliary-verbs4.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-verbs-behave1.html" target="_blank">https://www.learnenglishfeelgood.com/english-verbs-behave1.html</a><br>
                                                            <a href="https://www.learnenglishfeelgood.com/english-verbs-behave2.html" target="_blank">https://www.learnenglishfeelgood.com/english-verbs-behave2.html</a><br>
                                                            
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="card border bg-light mt-3">
                                                        <div class="card-body">
                                                            <h6 class="mt-2">PERFECT ENGLISH GRAMMAR</h6>
                                                            <a href="https://www.perfect-english-grammar.com/preposition-collocations-exercise-1.html" target="_blank">https://www.perfect-english-grammar.com/preposition-collocations-exercise-1.html</a><br>
                                                            
                                                            <a href="https://www.perfect-english-grammar.com/make-or-do.html" target="_blank">https://www.perfect-english-grammar.com/make-or-do.html</a><br>
                                                            <a href="https://www.perfect-english-grammar.com/make-or-do-exercise-1.html" target="_blank">https://www.perfect-english-grammar.com/make-or-do-exercise-1.html</a><br>
                                                            <a href="https://www.perfect-english-grammar.com/make-or-do-exercise-2.html" target="_blank">https://www.perfect-english-grammar.com/make-or-do-exercise-2.html</a><br>
                                                            <a href="https://www.perfect-english-grammar.com/make-or-do-exercise-3.html" target="_blank">https://www.perfect-english-grammar.com/make-or-do-exercise-3.html</a><br>
                                                            <a href="https://www.perfect-english-grammar.com/make-or-do-exercise-4.html" target="_blank">https://www.perfect-english-grammar.com/make-or-do-exercise-4.html</a><br>
                                                            <a href="https://www.perfect-english-grammar.com/preposition-collocations-exercise-1.html" target="_blank">https://www.perfect-english-grammar.com/preposition-collocations-exercise-1.html</a><br>
                                                        </div>
                                                   </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="card border bg-light mt-3">
                                                        <div class="card-body">
                                                            <h6 class="mt-2">BRITISH COUNCIL</h6>
                                                            <a href="https://learnenglish.britishcouncil.org/grammar/beginner-to-pre-intermediate/adjectives-and-prepositions" target="_blank">https://learnenglish.britishcouncil.org/grammar/beginner-to-pre-intermediate/adjectives-and-prepositions</a><br>
                                                            <a href="https://learnenglish.britishcouncil.org/grammar/intermediate-to-upper-intermediate/verbs-and-prepositions" target="_blank">https://learnenglish.britishcouncil.org/grammar/intermediate-to-upper-intermediate/verbs-and-prepositions</a><br>
                                                        </div>
                                                   </div>

                                                   <div class="card border bg-light mt-3">
                                                        <div class="card-body">
                                                            <h6 class="mt-2">TEST ENGLISH</h6>
                                                            <a href="https://test-english.com/grammar-points/b1/adjective-preposition/" target="_blank">https://test-english.com/grammar-points/b1/adjective-preposition/</a><br>
                                                            <a href="https://test-english.com/grammar-points/b1/adjective-preposition/2/" target="_blank">https://test-english.com/grammar-points/b1/adjective-preposition/2/</a><br>
                                                            <a href="https://test-english.com/grammar-points/b1/adjective-preposition/3/" target="_blank">https://test-english.com/grammar-points/b1/adjective-preposition/3/</a>
                                                        </div>
                                                    </div>
                                                
                                                    
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div> --->




                            <!--- </div> --->
                            

































                        <cfelseif subm eq "toeic">

                            <div class="card border">
                                <div class="card-body">
                                        
                                    <div class="w-100">
                                        <h5 class="d-inline"><i class="fal fa-edit" aria-hidden="true"></i> <cfoutput>#obj_translater.get_translate('card_for_practice')# - TOEIC</cfoutput></h5>
                                        <hr class=">border-red mb-1 mt-2">
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
                                                            <h6 class="mt-1">#quiz_name# <span class="badge badge-pill badge-info">#obj_translater.get_translate('btn_all_level')#<span></h6>
                                                            <small>#quiz_description#</small>
                                                            
                                                            <div class="clearfix"></div>
                                                            <div class="float-right">
                                                            
                                                                <cfif get_result_toeic.recordcount eq "0">
                                                                
                                                                    <a href="quiz.cfm?quiz_id=#quiz_id#&new_quiz=1" class="btn btn-sm btn-outline-info">#obj_translater.get_translate('btn_go_test')#</a>
                                                                    
                                                                <cfelse>
                                                                    <a href="##" class="btn btn-sm btn-outline-info float-right btn_view_quiz" id="quser_#get_result_toeic.quiz_user_id#"><i class="fas fa-sync-alt"></i> #obj_translater.get_translate('btn_start_again')#</a>																
                                                                    
                                                                    <cfif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end neq "">
                                                                        <a href="##" class="btn btn-sm btn-outline-red btn_view_quiz" id="quser_#get_result_toeic.quiz_user_id#"><i class="fas fa-tasks"></i> #obj_translater.get_translate('btn_results_test')#</a>
                                                                    <!---<cfelseif get_result_toeic.recordcount neq "0" AND get_result_toeic.quiz_user_end eq "">
                                                                        <a href="./quiz.cfm?quiz_user_id=#get_result_toeic.quiz_user_id#&f=go" target="_blank" class="btn btn-sm btn-outline-success"><i class="fas fa-play"></i> #obj_translater.get_translate('btn_continue')# test</a>--->											
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
                        </cfif>



















                        <!--- <div class="accordion" id="skills_accordion">
                            
                            <cfloop query="get_skill">
                            
                            <cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
                            SELECT skill_sub_id, skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, skill_id
                            FROM lms_skill_sub 
                            WHERE skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill.skill_id#"> AND online = 1
                            </cfquery>
    
    
    
    <!--- <cfdump var="#get_skill_sub#"> --->
    
                            <div class="card border">
                                <div class="card-header p-4" id="<cfoutput>skill_#get_skill.skill_id#</cfoutput>" data-toggle="collapse" data-target="#div_<cfoutput>#get_skill.skill_id#</cfoutput>" aria-expanded="true" aria-controls="div_<cfoutput>#get_skill.skill_id#</cfoutput>">
                                    <h6 class="mb-0">
                                    <!--- <button class="btn btn-link btn-block text-left font-weight-light" type="button"> --->
                                    <i class="<cfoutput>#get_skill.skill_icon#</cfoutput> fa-lg"></i> <cfoutput>#get_skill.skill_name#</cfoutput>
                                    <!--- </button> --->
                                    </h6>
                                </div>
    
                                <div id="div_<cfoutput>#get_skill.skill_id#</cfoutput>" class="collapse<!--- <cfif get_skill.skill_id eq "1">show</cfif>--->" aria-labelledby="skill_<cfoutput>#get_skill.skill_id#</cfoutput>" data-parent="#skills_accordion">
                                    
                                    <div class="card-body">
                                    
                                        <cfset counter = 2>
                                            
                                        <cfloop query="get_skill_sub">
    
                                        <table class="table bg-white table-borderless border border-info borderless">
                                            <!--- <tr align="center"> --->
                                                <!--- <td></td> --->
                                                <!--- <td></td> --->
                                                        
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.2</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-success">A1.3</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.2</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-primary">A2.3</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.2</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-info">B1.3</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-warning">B2.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.1</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.2</span></h5></td> --->
                                                <!--- <td width="5%"><h5 class="m-0"><span class="badge badge-pill badge-danger">C1.3</span></h5></td> --->
                                            <!--- </tr> --->
                                            
                                            
                                            <cfif isdefined("level_#get_skill.skill_code#_start")>
                                                <cfset status_scale = replace(evaluate("level_#get_skill.skill_code#_start"),".","_")>
                                                <!--- status_scale == #status_scale# // #cor# --->
                                                <cfquery name="get_feedback_#get_skill.skill_code#" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 0 AND level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("level_#get_skill.skill_code#_start")#">
                                                </cfquery>
                                                
                                            <cfelse>
                                                <cfset status_scale = 0>
                                            </cfif>
                                            
                                            <!--- <cfquery name="get_feedback_custom" datasource="#SESSION.BDDSOURCE#"> --->
                                            <!--- SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 1 --->
                                            <!--- </cfquery> --->
                                            
                                            <tr align="center">
                                                <!--- <td rowspan="4"><cfoutput>#get_skill_sub.skill_sub_name#</cfoutput></td> --->
                                                <td class="bg-white text-info" rowspan="2" width="150">
    
                                                <cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" align="center"></cfoutput>
                                                
                                                <br>Niveau d'entrée</td>
                                                
                                                <td align="left">
                                                    <div class="btn-group-toggle" data-toggle="buttons">	
                                                    <cfloop list="#list_level#" index="cor">
                                                        
                                                        <cfif findnocase("A1_",cor)>
                                                            <cfset css = "success">
                                                        <cfelseif findnocase("A2_",cor)>
                                                            <cfset css = "primary">
                                                        <cfelseif findnocase("B1_",cor)>
                                                            <cfset css = "info">
                                                        <cfelseif findnocase("B2_",cor)>
                                                            <cfset css = "warning">
                                                        <cfelseif findnocase("C1_",cor)>
                                                            <cfset css = "danger">
                                                        </cfif>
    
                                                        <cfoutput>
                                                        <label class="btn btn-sm <cfif findnocase("B1_3",cor)>btn-#css# text-white<cfelse>btn-outline-#css# <cfif status_scale neq cor>disabled</cfif></cfif> <cfif status_scale eq cor>active</cfif> "><input type="radio" <cfif status_scale eq cor>checked</cfif> name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label>
                                                        </cfoutput>
                                                    
                                                    </cfloop>
                                                    </div>
                                                </td>	
                                                
                                                
                                                
                                                
                                                    
                                                <!--- <cfset counter ++> --->
                                                <!--- <td align="left"> --->
                                                <!--- <div class="btn-group-toggle" data-toggle="buttons">			 --->
                                                <!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> A1.1</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.2</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-success" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A1.3</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.1</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-primary <cfif counter eq "3">active</cfif>"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" <cfif counter eq "3">checked</cfif>> A2.2</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-primary" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> A2.3</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.1</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.2</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-info" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B1.3</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.1</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.2</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-warning" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> B2.3</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.1</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.2</label> --->
                                                <!--- <label class="btn btn-sm btn-outline-danger" disabled><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off"> C1.3</label> --->
                                                <!--- </div> --->
                                                <!--- </td>			 --->
                                            </tr>
                                            <tr>
                                                <td>
                                                <cfif isdefined("get_feedback_#get_skill.skill_code#")>
                                                <cfoutput>#replacenocase(evaluate("get_feedback_#get_skill.skill_code#").feedback_text,chr(10),"<br>")#</cfoutput>
                                                </cfif>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                        
                                        
                                        
                                        <table class="table bg-light table-borderless border">
                                            <tr align="center">
                                            
                                                <td class="bg-light text-muted" width="150">
                                                <!--- <img src="./assets/img/support_all.jpg" align="center"> --->
                                                <!--- <i class="fal fa-hiking fa-2x"></i> --->
                                                <i class="fa-thin fa-chart-user fa-2x"></i>
                                                
                                                <br>Aptitudes</td>
                                                <td align="left">	
                                                    <strong>Spoken Interaction</strong>
                                                    <p>
                                                        Can easily give brief reasons for opinions<br>
                                                        Can easily discuss family, hobbies, work, travel and news/current affairs<br>
                                                    </p>
                                                    <strong>Spoken Production</strong>
                                                    <p>
                                                        
                                                        Can tell a story or explain narrative of book/film with ease<br>
                                                    </p>
                                                </td>
                                            </tr>
                                        </table>
                                        <!--- <tr align="center"> --->
                                                <!--- <td class="bg-light"><strong>Feedback</strong></td> --->
                                                <!--- <td> --->
                                                <!--- <select name="scale_2" class="change_feedback form-control" id="<cfoutput>feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
                                                <!--- <option value="0">---Choose feedback---</option> --->
                                                <!--- <cfoutput query="get_feedback"> --->
                                                <!--- <option value="#feedback_id#">#feedback_title#</option> --->
                                                <!--- </cfoutput> --->
                                                <!--- </select> --->
                                                
                                                <!--- <textarea readonly class="form-control" name="" rows="7" id="feedtext_<cfoutput>#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#</cfoutput>"> --->
                                                
                                                <!--- </textarea> --->
                                                <!--- </td> --->
                                            <!--- </tr> --->
                                            
                                        
                                            <table class="table bg-light table-borderless border">
                                                
                                                
                                                <cfif isdefined("level_#get_skill.skill_code#_end")>
                                                    <cfset status_scale = replace(evaluate("level_#get_skill.skill_code#_end"),".","_")>
                                                    <!--- status_scale == #status_scale# // #cor# --->
                                                    <cfquery name="get_feedback_#get_skill.skill_code#" datasource="#SESSION.BDDSOURCE#">
                                                    SELECT * FROM lms_feedback WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> AND skill_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_skill_sub.skill_sub_id#"> AND feedback_custom = 0 AND level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("level_#get_skill.skill_code#_end")#">
                                                    </cfquery>
                                                    
                                                <cfelse>
                                                    <cfset status_scale = 0>
                                                </cfif>
                                                
                                                
                                                <tr align="center">
                                                    <td class="bg-white text-info" rowspan="2" width="150">
        
                                                    <cfoutput><img src="./assets/img/qpt_#lang_select#.jpg" align="center"></cfoutput>
                                                    
                                                    <br>Niveau de sortie</td>
                                                    
                                                    <td align="left">
                                                        <div class="btn-group-toggle" data-toggle="buttons">	
                                                        <cfloop list="#list_level#" index="cor">
                                                            
                                                            <cfif findnocase("A1_",cor)>
                                                                <cfset css = "success">
                                                            <cfelseif findnocase("A2_",cor)>
                                                                <cfset css = "primary">
                                                            <cfelseif findnocase("B1_",cor)>
                                                                <cfset css = "info">
                                                            <cfelseif findnocase("B2_",cor)>
                                                                <cfset css = "warning">
                                                            <cfelseif findnocase("C1_",cor)>
                                                                <cfset css = "danger">
                                                            </cfif>
        
                                                            <cfoutput>
                                                            <label class="btn btn-sm btn-outline-#css# <cfif status_scale eq cor>active</cfif>" <cfif status_scale neq cor>disabled</cfif>><input type="radio" <cfif status_scale eq cor>checked</cfif> name="level_id" class="level_select_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#" value="#cor#" autocomplete="off" required id="feedid_#get_skill_sub.skill_id#_#get_skill_sub.skill_sub_id#"> #replace(cor,"_",".")#</label>
                                                            </cfoutput>
                                                        
                                                        </cfloop>
                                                        </div>
                                                    </td>	
                                                </tr>
                                                <tr>
                                                    <td>
                                                    <cfif isdefined("get_feedback_#get_skill.skill_code#")>
                                                    <cfoutput>#replacenocase(evaluate("get_feedback_#get_skill.skill_code#").feedback_text,chr(10),"<br>")#</cfoutput>
                                                    </cfif>
                                                    </td>
                                                </tr>
                                                
                                            </table>
                                            
    
                                    </cfloop>
    
    
                                    </div>
                                </div>
                            </div>
                            </cfloop>
                    
                        </div> --->
                    
                </div>			
            </div>
                
        </div>
        
        <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
            
    </div>
        
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">
    
    <script>
    $(function() {
    
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
            $('#modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
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
        
        
        
    
        
    })
    
    </script>
    
</body>
</html>