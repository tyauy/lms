<cfsilent>

    <cfparam name="f_id" default="2">
    <cfparam name="lev_id" default="1">

    <cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_level WHERE level_id <> 0 AND level_id <> 6 ORDER BY level_alias
    </cfquery>
    
    <cfquery name="get_keyword_core" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
    </cfquery>
    
    <cfquery name="get_keyword_specific" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 5 ORDER BY keyword_cat_id ASC
    </cfquery>

    <cfquery name="get_keyword_general" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
    </cfquery>
    
    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
    </cfquery>
    
    <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
    SELECT skill_id, skill_code, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
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

    <cfquery name="get_bright_listening" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright listening" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>
    
    <cfquery name="get_bright_reading" datasource="#SESSION.BDDSOURCE#">
    SELECT quiz_id, quiz_name_#SESSION.LANG_CODE# as quiz_name, quiz_description_#SESSION.LANG_CODE# as quiz_description FROM lms_quiz WHERE quiz_type = "bright reading" AND quiz_active = 1 AND quiz_formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY quiz_name_#SESSION.LANG_CODE# ASC
    </cfquery>

    <cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
    SELECT w.wemail_id, w.wemail_category, w.wemail_subcategory, w.wemail_category_clean, w.wemail_subject, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category) as nb, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category AND wemail_sample_1 IS NOT NULL) as nb_notnull FROM lms_wemail w WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY w.wemail_category, w.wemail_subcategory, w.wemail_subject 
    </cfquery>

    <cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
    SELECT voc_cat_id, voc_cat_name_en as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
    </cfquery>
    
    <!--- <cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
    SELECT v.voc_id, v.voc_word_#lang_select# as voc_word, v.voc_desc_#lang_select# as voc_desc, vc.voc_cat_name_#lang_select# as voc_cat_name, v.voc_cat_id
    FROM lms_vocabulary v
    INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
    
    WHERE voc_cat_online = 1									
    </cfquery> --->


    
    <cfset gr_id = 0>
    
    <cfset list_level="A1_1,A1_2,A1_3,A2_1,A2_2,A2_3,B1_1,B1_2,B1_3,B2_1,B2_2,B2_3,C1_1,C1_2,C1_3">
        
    
    </cfsilent>
    
    <html lang="fr">
    
    <head>
    
        <cfinclude template="./incl/incl_head.cfm">
    <style>
    .card{
      cursor: pointer;
    }
    
    .btn-outline-info {color:#51bcda !important;}
    .btn-outline-success {color:#6bd098  !important;}
    .btn-outline-primary {color:#51cbce  !important;}
    .btn-outline-danger {color:#ef8157  !important;}
    .btn-outline-warning {color:#fbc658  !important;}
    
    .collapsing {
        <!--- -webkit-transition: none; --->
        <!--- transition: none; --->
        <!--- display: none; --->
    }
    <!--- .card { --->
        <!--- border-radius: 2px !important; --->
        <!--- box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important; --->
    <!--- } --->
    <!--- .card:hover{ --->
         <!--- cursor: pointer; --->
         <!--- transform: scale(1.05); --->
         <!--- box-shadow: 0 6px 10px rgba(0,0,0,.08), 0 0 6px rgba(0,0,0,.05); --->
        <!--- box-shadow: 0 10px 20px rgba(0,0,0,.12), 0 4px 8px rgba(0,0,0,.06); --->
    <!--- } --->
    </style>
    </head>
    
    
    <body>
    
    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "GLOBAL LANGUAGE ASSESSMENT">
            <cfinclude template="./incl/incl_nav.cfm">
    
                
            <div class="content">

                <!--- <h4 align="center">Welcome to your dahsboard</h4> --->
                <div style="height:20px"></div>                
                <cfinclude template="./incl/incl_nav_elearning.cfm">
                

                <!--- <a class="float-right" href="_AD_elearning_index.cfm?step=begin">[retour]</a> --->

                
                <div align="center" class="mb-3">
                    <cfoutput query="get_level">
                        <a class="btn btn-lg btn-outline-#level_css# <cfif level_id eq lev_id>active</cfif>" href="_AD_elearning_ressources.cfm?lev_id=#level_id#"> #level_alias#</a>
                    </cfoutput>
                </div>   

                <div class="row">
    
                    <div class="col-lg-6 col-md-6 col-sm-6">
				        
                        <div class="accordion_reading" id="accordion_reading">
                            <div class="card">
                                <div class="card-header p-4" id="skill_reading" type="button" data-toggle="collapse" data-target="#div_reading" aria-expanded="false" aria-controls="div_reading">
                                    <!--- <p> --->
                                        <!--- <img src="./assets/img/240_F_303946149_pzkuQv0LqtbY1ZgSjdPBYdUDKgGH2c6h.jpg" width="100" align="left"> --->
                                        <h5 class="text-info m-0 ml-3"><i class="fal fa-books text-info text-center"></i> <strong>READING</strong></h5>
                                    <!--- </p> --->
                                </div>
                                <div id="div_reading" class="collapse" aria-labelledby="skill_reading" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_reading_top">    
                                           
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="accordion_listening" id="accordion_listening">
                            <div class="card">
                                <div class="card-header p-4" id="skill_listening" type="button" data-toggle="collapse" data-target="#div_listening" aria-expanded="false" aria-controls="div_listening">
                                    <!--- <p> --->
                                        <!--- <img src="./assets/img/240_F_412967644_1jAgrUWY5A4Awhz9lWB5iGdm8TtZ3sCu.jpg" width="100" align="left"> --->
                                        <h5 class="text-info m-0 ml-3"><i class="fal fa-headphones text-info text-center"></i> <strong>LISTENING</strong></h5>
                                    <!--- </p> --->
                                </div>
                                <div id="div_listening" class="collapse show" aria-labelledby="skill_listening" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_listening_top">    
                                            
                                            <table class="table">
                                                <tr>
                                                    <td>Short listening Easy #1</td>
                                                    <td>PRACTICE QUIZ</td>
                                                    <td>
                                                        <span class="badge badge-pill badge-success">A1</span> <span class="badge badge-pill badge-primary">A2</span><span class="badge badge-pill badge-info">B1</span><span class="badge badge-pill badge-warning">B2</span><span class="badge badge-pill badge-danger">C1</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Short listening Easy #2</td>
                                                    <td>PRACTICE QUIZ</td>
                                                    <td>
                                                        <span class="badge badge-pill badge-success">A1</span> <span class="badge badge-pill badge-primary">A2</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Short listening Easy #3</td>
                                                    <td>PRACTICE QUIZ</td>
                                                    <td>
                                                        <span class="badge badge-pill badge-success">A1</span> <span class="badge badge-pill badge-primary">A2</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Short listening Easy #4</td>
                                                    <td>PRACTICE QUIZ</td>
                                                    <td>
                                                        <span class="badge badge-pill badge-success">A1</span> <span class="badge badge-pill badge-primary">A2</span>
                                                    </td>
                                                </tr>

                                            </table>
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="accordion_voclist" id="accordion_voclist">
                            <div class="card">
                                <div class="card-header p-4" id="skill_voclist" type="button" data-toggle="collapse" data-target="#div_voclist" aria-expanded="false" aria-controls="div_voclist">
                                    <!--- <p> --->
                                        <!--- <img src="./assets/img/240_F_412967644_1jAgrUWY5A4Awhz9lWB5iGdm8TtZ3sCu.jpg" width="100" align="left"> --->
                                        <h5 class="text-info m-0 ml-3"><i class="fal fa-pen-clip text-info text-center"></i> <strong>VOCAB LIST</strong></h5>
                                    <!--- </p> --->
                                </div>
                                <div id="div_voclist" class="collapse" aria-labelledby="skill_voclist" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_voclist_top">    
                                            <table class="table">
                                                <cfoutput query="get_category">
                                                <tr>
                                                    <td>
                                                        #voc_cat_name#
                                                    </td>
                                                    <td>
                                                        VOCAB LIST
                                                    </td>
                                                    <td>
                                                        <span class="badge badge-pill badge-success">A1</span>
                                                        <span class="badge badge-pill badge-primary">A2</span>
                                                        <span class="badge badge-pill badge-info">B1</span>
                                                        <span class="badge badge-pill badge-warning">B2</span>
                                                        <span class="badge badge-pill badge-danger">C1</span>
                                                    </td>
                                                </tr>
                                                </cfoutput>
                                            </table>
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="accordion_voclist" id="accordion_email">
                            <div class="card">
                                <div class="card-header p-4" id="skill_email" type="button" data-toggle="collapse" data-target="#div_email" aria-expanded="false" aria-controls="div_email">
                                    <!--- <p> --->
                                        <!--- <img src="./assets/img/240_F_412967644_1jAgrUWY5A4Awhz9lWB5iGdm8TtZ3sCu.jpg" width="100" align="left"> --->
                                        <h5 class="text-info m-0 ml-3"><i class="fal fa-at text-info text-center"></i> <strong>EMAIL</strong></h5>
                                    <!--- </p> --->
                                </div>
                                <div id="div_email" class="collapse" aria-labelledby="skill_email" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_email_top">    
                                            <table class="table">
                                            <cfoutput query="get_wemail" group="wemail_category">
                                                <tr>
                                                    <td>
                                                        <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                        
                                                        <cfif wemail_subcategory neq "">
                                                            <cfoutput group="wemail_subcategory">
                                                                <li style="display:none"> <span>#wemail_subcategory#</span>
                                                                    <ul>
                                                                        <cfoutput group="wemail_subject">
                                                                            <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                        </cfoutput>
                                                                    </ul>													
                                                                </li>
                                                            </cfoutput>
                                                        <cfelse>											
                                                            <cfoutput group="wemail_subject">
                                                                <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                            </cfoutput>
                                                        </cfif>
                                                    
                                                    </td>
                                                </tr>
                                            </cfoutput>
                                            </table>
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6">
				        
                        <div class="accordion_linguaskill" id="accordion_linguaskill">
                            <div class="card">
                                <div class="card-header p-4" id="skill_linguaskill" type="button" data-toggle="collapse" data-target="#div_linguaskill" aria-expanded="false" aria-controls="div_linguaskill">
                                    <p>
                                        <img src="./assets/img_certif/1.png" width="160" align="left">
                                        <!--- <h5 class="text-info m-0 ml-3"><img src="./assets/img_certif/1.png" width="100" align="left"> Work on... <strong>LINGUASKILL</strong></h5> --->
                                    </p>

                                </div>
                                <div id="div_linguaskill" class="collapse" aria-labelledby="skill_linguaskill" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_linguaskill_top">    
                                           
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                       

                        <div class="accordion_bright" id="accordion_bright">
                            <div class="card">
                                <div class="card-header p-4" id="skill_bright" type="button" data-toggle="collapse" data-target="#div_bright" aria-expanded="false" aria-controls="div_bright">
                                    <p>
                                        <img src="./assets/img_certif/12.png" width="180" align="left">
                                        
                                    </p>
                                </div>
                                <div id="div_bright" class="collapse show" aria-labelledby="skill_bright" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_bright_top">    
                                            <table class="table">

                                                <cfoutput query="get_bright_listening">
                                                    <tr>
                                                        <td>
                                                            #quiz_name#
                                                        </td>
                                                        <td>
                                                            LISTENING TRAINING
                                                        </td>
                                                        <td>
                                                            <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                                                <cfif findnocase("A1",cor)>
                                                                    <cfset css = "success">
                                                                <cfelseif findnocase("A2",cor)>
                                                                    <cfset css = "primary">
                                                                <cfelseif findnocase("B1",cor)>
                                                                    <cfset css = "info">
                                                                <cfelseif findnocase("B2",cor)>
                                                                    <cfset css = "warning">
                                                                <cfelseif findnocase("C1",cor)>
                                                                    <cfset css = "danger">
                                                                </cfif>
                                    
                                                                <span class="badge badge-pill badge-#css#">#cor#</span>
                                                            
                                                            </cfloop>
    
                                                        </td>
    
                                                    </tr>
    
                                                </cfoutput>
                                                <cfoutput query="get_bright_reading">
                                                    <tr>
                                                        <td>
                                                            #quiz_name#
                                                        </td>
                                                        <td>
                                                            READING TRAINING
                                                        </td>
                                                        <td>
                                                            <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                                                <cfif findnocase("A1",cor)>
                                                                    <cfset css = "success">
                                                                <cfelseif findnocase("A2",cor)>
                                                                    <cfset css = "primary">
                                                                <cfelseif findnocase("B1",cor)>
                                                                    <cfset css = "info">
                                                                <cfelseif findnocase("B2",cor)>
                                                                    <cfset css = "warning">
                                                                <cfelseif findnocase("C1",cor)>
                                                                    <cfset css = "danger">
                                                                </cfif>
                                    
                                                                <span class="badge badge-pill badge-#css#">#cor#</span>
                                                            
                                                            </cfloop>
    
                                                        </td>
    
                                                    </tr>
    
                                                </cfoutput>
    
                                                </table>
                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="accordion_toeic" id="accordion_toeic">
                            <div class="card">
                                <div class="card-header p-4" id="skill_toeic" type="button" data-toggle="collapse" data-target="#div_toeic" aria-expanded="false" aria-controls="div_toeic">
                                    <p>
                                        <img src="./assets/img_certif/4.png" width="180" align="left">
                                        
                                    </p>
                                </div>
                                <div id="div_toeic" class="collapse show" aria-labelledby="skill_toeic" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_toeic_top">    
                                            <table class="table">

                                            <cfoutput query="get_toeic">
                                                <tr>
                                                    <td>
                                                        #quiz_name#
                                                    </td>
                                                    <td>
                                                        GLOBAL QUIZ
                                                    </td>
                                                    <td>
                                                        <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                                            <cfif findnocase("A1",cor)>
                                                                <cfset css = "success">
                                                            <cfelseif findnocase("A2",cor)>
                                                                <cfset css = "primary">
                                                            <cfelseif findnocase("B1",cor)>
                                                                <cfset css = "info">
                                                            <cfelseif findnocase("B2",cor)>
                                                                <cfset css = "warning">
                                                            <cfelseif findnocase("C1",cor)>
                                                                <cfset css = "danger">
                                                            </cfif>
                                
                                                            <span class="badge badge-pill badge-#css#">#cor#</span>
                                                        
                                                        </cfloop>

                                                    </td>

                                                </tr>

                                            </cfoutput>

                                            </table>

                                        </div>
                                                
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>


                    
                       


                    <!--- <div class="col-lg-6 col-md-6 col-sm-6">
                            
                        <div class="card mb-3 bg-light">
                            <div class="card-body">
                                <h4 class="text-secondary m-0"><i class="fa-light fa-screen-users fa-lg text-secondary"></i> Open <strong>Training</strong></h4>
                                <div class="w-100 border-top bg-light mt-3 p-2">
                                    <img src="./assets/img/1000_F_347544985_ImOfEvR7qSWmXgPxHdRd3jVXn5z4eKTm.jpg" class="mr-2 float-left" width="120">
                                    <div>
                                        Vous ne suivez pas encore de parcours Open Training. Inscrivez-vous et accédez gratuitement à nos cours collectifs !
                                        <div align="right" class="clearfix"><a class="btn btn-secondary m-0 mt-2" href="./learner_virtual.cfm">DÉCOUVRIR</a></div>
                                    </div>
                                </div>
        
                            </div>
                        </div>

                    </div> --->

                </div>

                <div class="row">

                    <div class="col-md-12">

                        <div class="accordion_grammar" id="accordion_grammar">
                            <div class="card">
                                <div class="card-header p-4" id="skill_grammar" type="button" data-toggle="collapse" data-target="#div_grammar" aria-expanded="false" aria-controls="div_grammar">
                                    <h5 class="text-primary m-0"><i class="fal fa-spell-check text-primary text-center"></i> <strong>LANGUAGE MAPPING</strong></h5>
                                </div>
                                <div id="div_grammar" class="collapse" aria-labelledby="skill_grammar" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                    
                                    <div id="accordion_grammar_top">
                                        <div align="center" class="mb-3">
                                            <div class="btn-group-toggle" data-toggle="buttons">	
                                                <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                                    <cfif findnocase("A1",cor)>
                                                        <cfset css = "success">
                                                    <cfelseif findnocase("A2",cor)>
                                                        <cfset css = "primary">
                                                    <cfelseif findnocase("B1",cor)>
                                                        <cfset css = "info">
                                                    <cfelseif findnocase("B2",cor)>
                                                        <cfset css = "warning">
                                                    <cfelseif findnocase("C1",cor)>
                                                        <cfset css = "danger">
                                                    </cfif>

                                                    <cfoutput><label class="btn btn-lg btn-outline-#css# <cfif cor eq "A1">active</cfif>" data-toggle="collapse" data-target="##collapse_grammar_sub_#cor#"><input type="radio" name="level_id" id="level_id" value="1" autocomplete="off" required> #cor#</label></cfoutput>
                                                
                                                </cfloop>
                                            </div>
                                        </div>
                                        
                                        <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                            <cfoutput>
                                            <div id="collapse_grammar_sub_#cor#" class="collapse <cfif cor eq "A1">show</cfif> p-2" data-parent="##accordion_grammar_top">	
                                                
                                                <cfif cor eq "A1">	
                                                    <cfset list_level = "A1_1,A1_2,A1_3">
                                                <cfelseif cor eq "A2">	
                                                    <cfset list_level = "A2_1,A2_2,A2_3">
                                                <cfelseif cor eq "B1">
                                                    <cfset list_level = "B1_1,B1_2,B1_3">
                                                <cfelseif cor eq "B2">
                                                    <cfset list_level = "B2_1,B2_2,B2_3">
                                                <cfelseif cor eq "C1">
                                                    <cfset list_level = "C1_1,C1_2,C1_3">
                                                </cfif>
                                                
                                                <table class="table table-sm">
                                                
                                                <tr>
                                                    <td></td>
                                                    <td align="center">Validation</td>
                                                </tr>
                                                
                                                    
                                                <cfloop list="#list_level#" index="cor2">
                                                <cfquery name="get_mapping_grammar" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'grammar' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                                                </cfquery>
                                                <cfquery name="get_mapping_vocabulary" datasource="#SESSION.BDDSOURCE#">
                                                SELECT * FROM lms_mapping WHERE level = '#replace(cor2,"_",".")#' AND mapping_category = 'vocabulary' AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
                                                </cfquery>
                                                <!--- <cfdump var="#get_mapping_grammar#"> --->
                                                    <cfif findnocase("A1_",cor2)>
                                                        <cfset css = "success">
                                                    <cfelseif findnocase("A2_",cor2)>
                                                        <cfset css = "primary">
                                                    <cfelseif findnocase("B1_",cor2)>
                                                        <cfset css = "info">
                                                    <cfelseif findnocase("B2_",cor2)>
                                                        <cfset css = "warning">
                                                    <cfelseif findnocase("C1_",cor2)>
                                                        <cfset css = "danger">
                                                    </cfif>			
                                                    <!--- <div class="col-md-4"> --->
                                                        <!--- <div class="card border"> --->
                                                            <!--- <button class="btn btn-outline-#css# bg-white" data-toggle="collapse" data-target="##collapse_grammar_#cor2#">#replace(cor2,"_",".")#</button> --->
                                                        
                                                            <!--- <div class="card-body"> --->
                                                            
                                                            
                                                                <tr class="bg-#css#">
                                                                    <td colspan="4"><h6 class="m-0 text-white">GRAMMAR #replace(cor2,"_",".")#</h6></td>
                                                                </tr>
                                                            <cfloop query="get_mapping_grammar">
                                                                <tr>
                                                                    <td>
                                                                        <!---<input type="checkbox" name="mapping_id">---> #mapping_name#
                                                                    </td>
                                                                    <td align="center">
                                                                    
                                                                    
                                                                    
                                                                    </td>
                                                                    <td align="center">
                                                                    <a type="button" class="btn btn-outline-#css#" href="_AD_learner_practice2.cfm?sm_id=" >
                                                                        <i class="fal fa-lg fa-laptop"></i> 
                                                                        <br>
                                                                        <cfset test = randrange(0,3)>
                                                                        <cfif test eq "0">
                                                                        
                                                                        <cfelse>
                                                                            <cfloop from="1" to="3" index="cor">
                                                                            <cfif test eq "3">
                                                                                
                                                                                <cfset cssgo = "warning">
                                                                            <i class="fal fa-star text-#cssgo#"></i>
                                                                            <cfelseif test eq "2">
                                                                                
                                                                                <cfset cssgo = "warning">
                                                                            <i class="fal fa-star text-#cssgo#"></i>
                                                                            <cfelseif test eq "1">
                                                                                <cfset cssgo = "danger">
                                                                                <i class="fal fa-star text-#cssgo#"></i>
                                                                            </cfif>
                                                                            </cfloop>
                                                                        </cfif>
                                                                    
                                                                    </a>
                                                                    <a type="button" class="btn btn-sm btn-#css#" href="_AD_learner_practice2.cfm?sm_id=" ><i class="fal fa-laptop"></i></a>
                                                                    <a type="button" class="btn btn-sm btn-#css#" href="_AD_learner_practice2.cfm?sm_id=" ><i class="fal fa-laptop"></i></a>
                                                                            
                                                                    </td>
                                                                </tr>
                                                            </cfloop>
                                                            
                                                            
                                                            <!--- <table class="table"> --->
                                                                <!--- <tr class="bg-#css#"> --->
                                                                    <!--- <td colspan="2"><h6 class="m-0 text-white">VOCABULARY #replace(cor2,"_",".")#</h6></td> --->
                                                                <!--- </tr> --->
                                                            <!--- <cfloop query="get_mapping_vocabulary"> --->
                                                                <!--- <tr class="table-#css#"> --->
                                                                    <!--- <td> --->
                                                                        <!--- <input type="checkbox" name="mapping_id"> #mapping_name# --->
                                                                    <!--- </td> --->
                                                                    <!--- <td width="20%"> --->
                                                                    <!--- <div class="progress" style="height: 5px;"> --->
                                                                    <!--- <div class="progress-bar bg-#css#" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> --->
                                                                    <!--- </div> --->
                                                                    <!--- </td> --->
                                                                <!--- </tr> --->
                                                            <!--- </cfloop> --->
                                                            <!--- </table> --->
                                                            
                                                            <!--- </div> --->
                                                        <!--- </div>													 --->
                                                    
                                                </cfloop>
                                                </table>
                                                
                                                
                                            </div>
                                            </cfoutput>
                                            
                                        </cfloop>
                                        
                                                                            
                                                
                                    </div>
                                </div>
                            </div>
                        </div>
					
					
					
					
                        <div class="accordion_core" id="accordion_core">
                            <div class="card bg-light">
                                <div class="card-header p-4" id="skill_core" type="button" data-toggle="collapse" data-target="#div_core" aria-expanded="false" aria-controls="div_core">
                                    <h5 class="text-secondary m-0 d-inline"><i class="fal fa-briefcase text-secondary text-center"></i> Work on...<strong> BUSINESS ENGLISH CORE SKILLS</strong></h5>
                                    <div class="float-right"><a class="btn btn-secondary m-0" href="./learner_virtual.cfm">ACTIVER</a></div>
                                </div>
                                <div id="div_core" class="collapse" aria-labelledby="skill_core" data-parent="#skills_accordion">
                                    <div class="card-body">
                                         
                                        <div align="center">
                                            <i class="fal fa-3x fa-list-ul text-info m-2" id="btn_collapse_list"></i>
                                            <i class="fal fa-3x fa-grid m-2" id="btn_collapse_grid"></i>
                                        </div>

                                        <div class="core_list_collapse collapse show">
                                            <cfloop query="get_keyword_core">
                                                        
                                                <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
                                                SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
                                                FROM lms_keyword k 
                                                WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_core.keyword_cat_id#"> 
                                                GROUP BY keyword_id
                                                ORDER BY rand()
                                                LIMIT 10
                                                </cfquery>
                                                    
                                                <table class="table table-sm">
                                                    
                                                    <tr>
                                                        <td></td>
                                                        <td align="center">Validation</td>
                                                    </tr>
                                                    
                                                <cfoutput query="get_keyword">
                                                
                                                <cfset test = randrange(100,118)>
                                                    <tr>
                                                        <td>
                                                            <div class="media">
                                                                <img class="align-self-center mr-2" src="./assets/img_module/#test#.jpg" width="40">
                                                                <div class="media-body">
                                                                <cfif get_keyword_core.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td align="center">
                                                            <cfset test = randrange(0,3)>
                                                            <!--- test == #test# --->
                                                            <cfif test eq "0">
                                                            
                                                            <cfelse>
                                                                <cfloop from="1" to="#test#" index="cor">
                                                                <cfif test eq "3">
                                                                    <cfset cssgo = "warning">
                                                                <cfelseif test eq "2">
                                                                    <cfset cssgo = "warning">
                                                                <cfelseif test eq "1">
                                                                    <cfset cssgo = "danger">
                                                                </cfif>
                                                                <i class="fas fa-star text-#cssgo#"></i>
                                                                </cfloop>
                                                            </cfif>
                                                            
                                                            
                                                            </td>
                                                            <td align="center">
                                                            <a type="button" class="btn btn-sm btn-#css#" href="_AD_learner_practice2.cfm?sm_id=" ><i class="fal fa-laptop"></i></a>
                                                                    
                                                            </td>
                                                    </tr>
                                                    
                                                </cfoutput>
                                                
                                                </table>
                                                    
                                            </cfloop>
                                        </div>

                                        <div class="core_grid_collapse collapse">

                                            <div class="row">
                                            <cfloop query="get_keyword_core">
                                                        
                                                <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
                                                SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
                                                FROM lms_keyword k 
                                                WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_core.keyword_cat_id#"> 
                                                GROUP BY keyword_id
                                                ORDER BY rand()
                                                LIMIT 10
                                                </cfquery>

                                                <cfoutput query="get_keyword">
                                                
                                                <cfset test = randrange(100,118)>


                                                <div class="col-lg-2 col-md-3 col-sm-6">
                                                    <div class="card">
                                                        <img class="card-img-top" width="100%" src="./assets/img_module/#test#.jpg">
                                                        <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:150px">     
                                                            <h6 class="text-center mt-2"><cfif get_keyword_specific.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif></h6>
                                                            <!--- <p align="center">
                                                                Cuncta disseminata nec parcens post plebeiis latera urbium modum onerosus nullum latera parcens bonis Caesar.
                                                            </p> --->
                                                            <div align="center" class="mt-auto">
                                                                <a class="btn btn-info" href="_AD_elearning_dashboard.cfm">Suivre</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>	
                                               
                                                    
                                                </cfoutput>

                                            </cfloop>

                                            </div>

                                        </div>

                        
                                    
                                    </div>
                                </div>
                                
                            </div>
                        
                        </div>

                        <div class="accordion_job" id="accordion_job">
                            <div class="card">
                                <div class="card-header p-4" id="skill_job" type="button" data-toggle="collapse" data-target="#div_job" aria-expanded="false" aria-controls="div_job">
                                    <h5 class="text-secondary m-0"><i class="fal fa-spell-check text-secondary text-center"></i> Work on...<strong>BUSINESS SPECIFIC SKILLS</strong></h5>
                               </div>
                                <div id="div_job" class="collapse" aria-labelledby="skill_job" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                    <cfloop query="get_keyword_specific">
                                                
                                        <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
                                        SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
                                        FROM lms_keyword k 
                                        WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_specific.keyword_cat_id#"> 
                                        GROUP BY keyword_id
                                        ORDER BY rand()
                                        LIMIT 10
                                        </cfquery>
                                        

                                        <div class="row">
                                            <cfoutput query="get_keyword">
                                            
                                            <cfset test = randrange(100,118)>


                                            <div class="col-lg-2 col-md-3 col-sm-6">
                                                <div class="card">
                                                    <img class="card-img-top" width="100%" src="./assets/img_module/#test#.jpg">
                                                    <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:150px">     
                                                        <h6 class="text-center mt-2"><cfif get_keyword_specific.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif></h6>
                                                        <!--- <p align="center">
                                                            Cuncta disseminata nec parcens post plebeiis latera urbium modum onerosus nullum latera parcens bonis Caesar.
                                                        </p> --->
                                                        <div align="center" class="mt-auto">
                                                            <a class="btn btn-info" href="_AD_elearning_dashboard.cfm">Suivre</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>	

                                                
                                            </cfoutput>
                                        </div>
                                            
                                            
                                    </cfloop>
                        
                                    
                                    </div>
                                </div>
                                
                            </div>
                        
                        </div>

                        <div class="accordion_general" id="accordion_general">
                            <div class="card border-top border-info">
                                <div class="card-header p-4" id="skill_general" type="button" data-toggle="collapse" data-target="#div_general" aria-expanded="false" aria-controls="div_general">
                                    <h5 class="text-info m-0"><i class="fal fa-bullseye-arrow text-info text-center"></i> Work on... <strong>GENERAL ENGLISH</strong></h5>
                                    
                                    <div class="progress mt-2" style="height: 3px;">
                                    <div class="progress-bar bg-info progress-bar-striped progress-bar-animated" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>

                                </div>
                                <div id="div_general" class="collapse" aria-labelledby="skill_general" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <cfloop query="get_keyword_general">
                                                
                                            <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
                                            SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj, (SELECT COUNT(sessionmaster_id) FROM lms_tpsessionmaster2 sm WHERE FIND_IN_SET(k.keyword_id, keyword_id)) as nb 
                                            FROM lms_keyword k 
                                            WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_general.keyword_cat_id#"> 
                                            GROUP BY keyword_id
                                            ORDER BY rand()
                                            LIMIT 10
                                            </cfquery>
                                            
    
                                            <div class="row">
                                                <cfoutput query="get_keyword">
                                                
                                                <cfset test = randrange(100,118)>
    
    
                                                <div class="col-lg-2 col-md-3 col-sm-6">
                                                    <div class="card">
                                                        <img class="card-img-top" width="100%" src="./assets/img_module/#test#.jpg">
                                                        <div class="card-body d-flex flex-column h-100 bg-light" style="min-height:150px">     
                                                            <h6 class="text-center mt-2"><cfif get_keyword_general.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif></h6>
                                                            <!--- <p align="center">
                                                                Cuncta disseminata nec parcens post plebeiis latera urbium modum onerosus nullum latera parcens bonis Caesar.
                                                            </p> --->
                                                            <div align="center" class="mt-auto">
                                                                <a class="btn btn-info" href="_AD_elearning_dashboard.cfm">Suivre</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>	
    
                                                    
                                                </cfoutput>
                                            </div>
                                                
                                                
                                        </cfloop>
                                                
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
    
    
    <!--- <cfset result = StructNew()> --->
            <!--- <cfset result[0] = get_max_id.maxid> --->
            <!--- <cfset result[1] = session_rank> --->
            <!--- <cfset result[2] = get_module> --->
            <!--- <cfset result[3] = get_session_order> --->
            <!--- <cfset result[4] = get_sm.sessionmaster_name> --->
            <!--- <cfreturn result> --->
            
            
            <!--- <cfset table_data = arraynew(1)> --->
    
    <!--- <cfoutput query="get_tp"> --->
        
        <!--- <cfif tp_toschedule eq "" OR tp_toschedule eq "0"><cfset tp_toschedule_go = "0"><cfelse><cfset tp_toschedule_go = tp_toschedule/60></cfif> --->
        <!--- <cfif tp_scheduled eq "" OR tp_scheduled eq "0"><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled/60></cfif> --->
        <!--- <cfif tp_completed_full eq "" OR tp_completed_full eq "0"><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed_full/60></cfif> --->
        <!--- <cfif tp_missed eq "" OR tp_missed eq "0"><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed/60></cfif> --->
        <!--- <cfif tp_remain eq "" OR tp_remain eq "0"><cfset tp_remain_go = "0"><cfelse><cfset tp_remain_go = tp_remain/60></cfif> --->
        
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <!--- <cfset table_data[1] = tp_toschedule_go> --->
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <!--- <cfset table_data[2] = tp_scheduled_go> --->
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <!--- <cfset table_data[3] = tp_completed_go> --->
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <!--- <cfset table_data[4] = tp_missed_go> --->
        <!--- <cfset temp = arrayAppend(table_data, structNew())> --->
        <!--- <cfset table_data[5] = tp_remain_go> --->
        
    <!--- </cfoutput> --->
    
    <!--- <cfset table_js = SerializeJSON(table_data)> --->
    
    <script>
    $(function() {

        $('#btn_collapse_list').click(function(event) {
            
            $("#btn_collapse_list").removeClass("text-dark");
            $("#btn_collapse_list").addClass("text-info");

            $("#btn_collapse_grid").removeClass("text-info");
            $("#btn_collapse_grid").addClass("text-dark");

            $(".core_list_collapse").collapse("show");
            $(".core_grid_collapse").collapse("hide");

        })

        $('#btn_collapse_grid').click(function(event) {

            $("#btn_collapse_list").removeClass("text-info");
            $("#btn_collapse_list").addClass("text-dark");

            $("#btn_collapse_grid").removeClass("text-dark");
            $("#btn_collapse_grid").addClass("text-info");

            $(".core_list_collapse").collapse("hide");
            $(".core_grid_collapse").collapse("show");

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
        
        $('.change_feedback_custom').change(function(event) {
            var go = $(this).val();
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var skill_id = idtemp[1];	
            var skill_sub_id = idtemp[2];
    
            <!--- <cfoutput query="get_feedback_all"> --->
            <!--- if (skill_sub_id == "#skill_sub_id#" && go == #feedback_id#) --->
            <!--- { --->
                <!--- $('##feedtextcustom_'+skill_id+'_'+skill_sub_id).val("#encodeforjavascript(feedback_text)#"); --->
            
            <!--- } --->
            <!--- </cfoutput> --->
        
        })
        
        
        
    
        <!--- $('.btn_create_ressource').click(function(event) {	 --->
            <!--- event.preventDefault();		 --->
            <!--- var idtemp = $(this).attr("id"); --->
            <!--- var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50); --->
            <!--- $('#window_item_lg').modal({keyboard: true}); --->
            <!--- $('#modal_title_lg').text("Ajouter ressource"); --->
            <!--- $('#modal_body_lg').load("modal_window_ressource.cfm?new_resource=1&f_id="+idtemp, function() {}); --->
        <!--- }); --->
        
    })
    
    </script>
    
    </body>
    </html>