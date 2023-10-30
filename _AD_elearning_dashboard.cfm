<cfsilent>

    <cfparam name="f_id" default="2">
    <cfparam name="subm" default="home">
    <cfparam name="lang_select" default="en">
    <cfparam name="lang_translate" default="">

    
    <cfif subm eq "vocabulary" AND not isdefined("voc_cat_select")>
        <cfset voc_cat_select = RandRange("1","45")>
    </cfif>
    <cfif subm eq "vocabulary_perso" AND not isdefined("voc_cat_select")>
        <cfset voc_cat_select = 0>
    </cfif>

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

    <cfquery name="get_elearning_session" datasource="#SESSION.BDDSOURCE#">
        SELECT elearning_session_id, elearning_session_name FROM lms_elearning_session
    </cfquery>	
    
    <cfset gr_id = 0>
    
    <cfset list_level="A1_1,A1_2,A1_3,A2_1,A2_2,A2_3,B1_1,B1_2,B1_3,B2_1,B2_2,B2_3,C1_1,C1_2,C1_3">
        
    
    </cfsilent>
    
    <html lang="fr">
    
    <head>
    
        <cfinclude template="./incl/incl_head.cfm">
    <style>
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
                          
                <!--- <div class="row justify-content-md-center">
    
                    <div class="col-md-auto">
                        
                        <div class="d-flex">

                            <div class="card border-top border-primary mb-5">
                    
                                <div class="card-body">
                                                    
                                    <div class="d-flex w-100 justify-content-around" align="center">
                                        <div>
                                            <!--- <i class="fal fa-users fa-2x text-info"></i>
                                            <br> --->
                                            <ul class="navbar-nav">
			
			
						
                                                <li class="nav-item btn-rotate dropdown">
                                                    
                                                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="lang-sm" lang="fr"></span> </a>
                                                    
                                                    <div class="dropdown-menu dropdown-menu-right">
                                                        
                                                            
                                                            <a class="dropdown-item" href="/_AD_elearning_dashboard.cfm?lg=fr&amp;subm=email"> <span class="lang-sm lang-lbl" lang="fr"></span> </a>
                                                        
                                                            
                                                            <a class="dropdown-item" href="/_AD_elearning_dashboard.cfm?lg=en&amp;subm=email"> <span class="lang-sm lang-lbl" lang="en"></span> </a>
                                                        
                                                            
                                                            <a class="dropdown-item" href="/_AD_elearning_dashboard.cfm?lg=de&amp;subm=email"> <span class="lang-sm lang-lbl" lang="de"></span> </a>
                                                        
                                                            
                                                            <a class="dropdown-item" href="/_AD_elearning_dashboard.cfm?lg=es&amp;subm=email"> <span class="lang-sm lang-lbl" lang="es"></span> </a>
                                                        
                                                            
                                                            <a class="dropdown-item" href="/_AD_elearning_dashboard.cfm?lg=it&amp;subm=email"> <span class="lang-sm lang-lbl" lang="it"></span> </a>
                                                        
                                                    </div>
                                                </li>
                                                
                                            
                                            
                                            
                                            
                                            
                                            </ul>
                                        </div>
                                        <div>
                                            <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                            <br> --->
                                            12%<br><small><strong>Atteinte objectif</strong></small>
                                        </div>
                                        <div>
                                            <!--- <i class="fal fa-spell-check fa-2x text-info"></i>
                                            <br> --->
                                            123<br><small><strong>KPI</strong></small>
                                        </div>
                                        <div>
                                            <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                            <br> --->
                                            12%<br><small><strong>Atteinte objectif</strong></small>
                                        </div>
                                        <div>
                                            <!--- <span class="badge badge-pill badge-red"><h4 class="mt-1">A2.2</h4></span>
                                            <br> --->
                                            A.2<br><small><strong>Mon Niveau</strong></small>
                                        </div>
                                    </div>
                    
                                </div>
                            </div>

                        </div>
                        
                    </div>
                </div> --->

                
                   

                <cfinclude template="./incl/incl_nav_elearning.cfm">
                


               <cfif subm eq "home">

                <div class="row">
    
                    <div class="col-lg-12 col-md-12 col-sm-12">
                        
                        <div class="card border-top border-primary mb-5">
                    
                            <div class="card-body">
                                                
                                <div class="d-flex w-100 justify-content-around" align="center">
                                    <div>
                                        <!--- <i class="fal fa-users fa-2x text-info"></i>
                                        <br> --->
                                        12h53min<br><small><strong>Temps passé Total</strong></small>
                                    </div>
                                    <div>
                                        <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                        <br> --->
                                        12%<br><small><strong>Atteinte objectif mois</strong></small>
                                    </div>
                                    <div>
                                        <!--- <i class="fal fa-spell-check fa-2x text-info"></i>
                                        <br> --->
                                        123<br><small><strong>Cours complétés</strong></small>
                                    </div>
                                    <div>
                                        <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                        <br> --->
                                        34<br><small><strong>Skills maîtrisées</strong></small>
                                    </div>
                                    <div>
                                        <!--- <span class="badge badge-pill badge-red"><h4 class="mt-1">A2.2</h4></span>
                                        <br> --->
                                        A.2<br><small><strong>Mon Niveau</strong></small>
                                    </div>
                                </div>
                
                            </div>
                        </div>
                    </div>
                </div>




                <div class="row">
    
                    <div class="col-md-8 col-sm-12">

                        <!--- <cfdirectory directory="#SESSION.BO_ROOT#/assets/scorm" name="dir_el" action="LIST">
                       
                        </cfdirectory>
                        <cfset list_el = "">
                        <cfloop query="dir_el"> 
                        <cfif dir_el.type IS "dir" AND isnumeric(dir_el.name) > 
                        <cfset list_el = listappend(list_el,name)>
                        </cfif>
                        </cfloop>  --->

                        <!--- <cfdump var="#list_el#"> --->


                        <!--- <cfdump var="#dirQuery#"> --->
                            <!--- <cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
                            SELECT sm.sessionmaster_name, sm.sessionmaster_id,
                            tp.tpmaster_name_#SESSION.LANG_CODE# as _tpmaster_name, 
                            tm.module_name_#SESSION.LANG_CODE# as _module_name, 
                            tm.module_description_#SESSION.LANG_CODE# as _module_description, 
                            tm.module_level, tm.module_id,
                            ue.sm_elapsed, ue.sm_lastview,
                            te.update_date, te.elearning_completion
                            FROM lms_tpmaster2 tp
                            INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
                            INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
                            LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
                            LEFT JOIN user_elapsed ue ON ue.sm_id = sm.sessionmaster_id	AND ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                            LEFT JOIN lms_tp_elearning te ON te.module_id = sm.sessionmaster_id AND te.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                            WHERE sm.sessionmaster_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#list_el#" list="true">)
                           
                            GROUP BY sm.sessionmaster_id
                            ORDER BY tpmaster_rank ASC, sm.module_id, tc.sessionmaster_rank, sm.sessionmaster_name
                            </cfquery> --->

                            <cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
                                SELECT es.elearning_session_id, es.elearning_session_name, es.elearning_session_creation_date,
                                e.elearning_id, e.module_path, e.module_name, e.module_difficulty,
                                sm.sessionmaster_name, sm.sessionmaster_id,
                                tm.module_name_#SESSION.LANG_CODE# as _module_name, 
                                tm.module_description_#SESSION.LANG_CODE# as _module_description, 
                                tm.module_level, tm.module_id,
                                l.level_alias, l.level_css,
                                eu.update_date, eu.elearning_completion
                                FROM lms_elearning_session es
                                INNER JOIN lms_elearning_session_user esu ON esu.elearning_session_id = es.elearning_session_id
                                LEFT JOIN lms_elearning_cor ec ON ec.elearning_session_id = es.elearning_session_id
                                LEFT JOIN lms_elearning e ON e.elearning_id = ec.elearning_id
                                LEFT JOIN lms_elearning_session_cor esc ON esc.elearning_session_id = es.elearning_session_id
                                LEFT JOIN lms_elearning_user eu ON eu.elearning_id = e.elearning_id AND eu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                                LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = esc.sessionmaster_id	
                                LEFT JOIN lms_tpmodulemaster2 tm ON tm.module_id = sm.module_id 
                                LEFT JOIN lms_level l ON l.level_id = es.elearning_session_level
                                WHERE esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                                AND esu.active = 1
                            </cfquery>

                        <!--- <cfdump var="#get_session_access#"> --->

                        <cfoutput query="get_session_access" group="elearning_session_id">

                        <div class="card border">
                            <div class="card-body">

                                <div class="d-flex">
                                    <div>
                                        <img src="./assets/img_level/#module_level#.svg" width="40">
                                    </div>
                                    <div class="w-100 ml-2">

                                        <h5 class="d-inline"> #_module_name#</h5>
                                        <hr class="border-#module_level# mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 07/01/2023</small></span>
                                   
                                    </div>
                                </div>


                                <!--- <div class="row mt-2">
    
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        
                                                                
                                        <div class="d-flex w-100 justify-content-around" align="center">
                                            <div>
                                                <!--- <i class="fal fa-users fa-2x text-info"></i>
                                                <br> --->
                                                123<br><small><strong>Ressources</strong></small>
                                            </div>
                                            <div>
                                                <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                                <br> --->
                                                12%<br><small><strong>En cours</strong></small>
                                            </div>
                                            <div>
                                                <!--- <i class="fal fa-spell-check fa-2x text-info"></i>
                                                <br> --->
                                                123<br><small><strong>Finalisées</strong></small>
                                            </div>
                                        </div>
                                
                                    </div>
                                </div> --->

                                <!--- looping on module --->
                                <cfoutput>

                                <div class="row mt-2">
    
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        
                                        <!--- <cfloop from="1" to="2" index="cor"> --->
                                        <div class="border-top p-2">

                                            <div class="float-left">       
                                                <img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="120" class="mr-2">
                                            </div>   

                                            <div class="float-left">    
                                                #module_name#

                                                <cfif module_difficulty neq "">
                                                    <cfif module_difficulty lte 3><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                    
                                                    <cfif module_difficulty lte 2><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                
                                                    <cfif module_difficulty lte 1><i class="fas fa-star text-warning" aria-hidden="true"></i><cfelse><i class="fa-thin fa-star text-warning" aria-hidden="true"></i></cfif> 
                                                </cfif>
                                                
                                                <cfif update_date neq "">
                                                    <br>
                                                    <span class="text-danger fw-bold float-right"><small> Dernière activité : #update_date#</small></span>
                                                    <br>
                                                    <span class="text-danger fw-bold float-right"><small> Completion : #elearning_completion# %</small></span>
                                                </cfif>
                                                

                                            </div>

                                            <div class="float-right">    
                                                
                                                <!--- <small>Mots-clés :</small>
                                                <span class="badge badge-info">Relation client</span> <span class="badge badge-info">Téléphone</span> 
                                                <br>
                                                <small>Grammaire :</small>
                                                <span class="badge badge-info">Modal verbs</span> 	 --->
                                                
                                                <!--- <a class="btn btn-sm btn-outline-red btn_view_session" id="sm_703" href="#"><i class="fas fa-eye" aria-hidden="true"></i> Details</a> --->
                                                
                                                <!--- <a class="btn btn-sm btn-outline-red">
                                                    <i class="fas fa-book" data-toggle="tooltip" data-placement="top" title="Support de cours" aria-hidden="true"></i><span class="sr-only">Support de cours</span>
                                                </a>
                                                
                                                <a class="btn btn-sm btn-outline-red">
                                                    <i class="fas fa-volume-up" data-toggle="tooltip" data-placement="top" title="Contient de l'audio" aria-hidden="true"></i><span class="sr-only">Contient de l'audio</span>
                                                </a> --->
                                                
                                                <a class="btn btn-sm btn-link ">
                                                    <h3 class="m-0"><i class="fa-thin fa-language"></i></h3>
                                                   
                                                     Vocabulary
                                                </a>

                                                <a class="btn btn-sm btn-link ">
                                                    <h3 class="m-0"><i class="fa-thin fa-list-check"></i></h3>
                                                    Training Quizz
                                                </a>

                                                <a class="btn btn-sm btn-link">
                                                    <h3 class="m-0"><i class="fa-thin fa-envelope"></i></h3>
                                                    email templates
                                                </a>

                                                <a class="btn btn-sm btn-outline-#module_level#" href="el_play_sco.cfm?sco_path=#elearning_id#" target="_blank">
                                                    <h3 class="m-0"><i class="fa-thin fa-circle-play"></i></h3>
                                                    PLAY MODULE
                                                </a>
                                                
                                                <!--- <a class="btn btn-sm btn-outline-#module_level#" href="##">
                                                    Final Quiz
                                                </a> --->
                                                
                                                <!--- <div class="p-1 pull-right cursored btn_like_session" id="sm_703"><i class="far fa-heart fa-lg grey" aria-hidden="true"></i></div> --->
                                               
                                            </div>

                                        </div>

                                    </div>

                                </div>
                                </cfoutput>

                            </div>
                        </div>
                        </cfoutput>
                        <div>
                            <table class="table table-sm table-bordered">
                                <!--- <tr>
                                    <td colspan="4" bgcolor="#ECECEC"><strong>Listes</strong></td>
                                </tr> --->
                                <tr>
                                    <td colspan="3">
                                    <select id="new_elearning_session_id" class="form-control">
                                    <option value="0" selected>--Selectionner--</option>
                                    <cfoutput query="get_elearning_session">
                                    <option value="#elearning_session_id#">#elearning_session_name#</option>
                                    </cfoutput>
                                    </select>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-outline-info btn_add_elearning_session">add</button>
                                    </td>
                                </tr>
                            </table>
                        </div>





                        <!--- <div class="card border">
                            <div class="card-body">

                                <div class="d-flex">
                                    <div>
                                        <img src="./assets/img_level/B1.svg" width="40">
                                    </div>
                                    <div class="w-100 ml-2">

                                        <h5 class="d-inline"> Business English </h5>
                                        <hr class="bg-B1 mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 24/07/2022</small></span>
                                   
                                    </div>
                                </div>


                            </div>
                        </div> --->







                    </div>


                    <div class="col-md-4 col-sm-12">

                        <div class="card border">
                            <div class="card-body">

                                <div class="d-flex">
                                    <div>
                                        <i class="fa-thin fa-envelopes fa-2x mr-2"></i>
                                    </div>
                                    <div class="w-100">

                                        <h5 class="d-inline"> Email Templates</h5>
                                        <hr class="bg-danger border-danger mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 24/01/2023</small></span>
                                   
                                    </div>
                                </div>


                                <div class="row mt-2">
    
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        
                                                                
                                        <div class="d-flex w-100 justify-content-around" align="center">
                                            <div>
                                                <!--- <i class="fal fa-users fa-2x text-info"></i>
                                                <br> --->
                                                3<br><small><strong>Emails consultés</strong></small>
                                            </div>
                                            <div>
                                                <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                                <br> --->
                                                234<br><small><strong>Templates</strong></small>
                                            </div>
                                        </div>
                                
                                    </div>
                                </div>

                                <div class="row mt-2">
                                    <div class="col">
                                    <a href="_AD_elearning_dashboard.cfm?subm=email" class="btn btn-sm btn-outline-red float-right">CONSULTER</a>
                                    </div>
                                </div>

                            </div>
                        </div>




                        <div class="card border">
                            <div class="card-body">

                                <div class="d-flex">
                                    <div>
                                        <i class="fa-thin fa-book fa-2x mr-2"></i>
                                    </div>
                                    <div class="w-100">

                                        <h5 class="d-inline"> Vocabulary Lists</h5>
                                        <hr class="bg-danger border-danger mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 28/12/2022</small></span>
                                   
                                    </div>
                                </div>


                                <div class="row mt-2">
    
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        
                                                                
                                        <div class="d-flex w-100 justify-content-around" align="center">
                                            <div>
                                                <!--- <i class="fal fa-users fa-2x text-info"></i>
                                                <br> --->
                                                14<br><small><strong>Listes </strong></small>
                                            </div>
                                            <div>
                                                <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                                <br> --->
                                                312<br><small><strong>Mots favoris</strong></small>
                                            </div>
                                        </div>
                                
                                    </div>
                                </div>

                                <div class="row mt-2">
                                    <div class="col">
                                    <a href="_AD_elearning_dashboard.cfm?subm=vocabulary" class="btn btn-sm btn-outline-red float-right">CONSULTER</a>
                                    </div>
                                </div>


                            </div>
                        </div>

                        <div class="card border">
                            <div class="card-body">

                                <div class="d-flex">
                                    <div>
                                        <i class="fa-thin fa-file-certificate fa-2x mr-2"></i>
                                    </div>
                                    <div class="w-100">

                                        <h5 class="d-inline"> Mock Tests</h5>
                                        <hr class="bg-danger border-danger mb-1 mt-2">
                                        <span class="text-danger fw-bold float-right"><small> Dernière activité : 24/07/2022</small></span>
                                   
                                    </div>
                                </div>


                                <div class="row mt-2">
    
                                    <div class="col-lg-12 col-md-12 col-sm-12">
                                        
                                                                
                                        <div class="d-flex w-100 justify-content-around" align="center">
                                            <div>
                                                <!--- <i class="fal fa-users fa-2x text-info"></i>
                                                <br> --->
                                                4<br><small><strong>TOEIC</strong></small>
                                            </div>
                                            <div>
                                                <!--- <i class="fal fa-chalkboard-teacher fa-2x text-info"></i>
                                                <br> --->
                                                12<br><small><strong>BRIGHT</strong></small>
                                            </div>
                                        </div>
                                
                                    </div>
                                </div>

                                <div class="row mt-2">
                                    <div class="col">
                                    <a href="_AD_elearning_dashboard.cfm?subm=email" class="btn btn-sm btn-outline-red float-right">CONSULTER</a>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>

                    

                </div>

                <cfelseif subm eq "email">
                    
                <div class="row">
                    <div class="col-md-12">

                        <div class="card border">

                            <div class="card-body">

                                    <h5 class="mr-4 text-uppercase font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('title_page_common_wemail')#</cfoutput></h5>
                                    
                                    <cfif isdefined("SESSION.ACCESS_EL")>
                                    <div class="pull-right">			
                                    <select class="form-control" onChange="document.location.href='?subm=email&f_id='+$(this).val()">
                                    <cfoutput query="get_formation">
                                    <option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
                                    </cfoutput>
                                    <select>
                                    </div>
                                    </cfif>
                                
                                    
                                    <cfoutput><p>#obj_translater.get_translate_complex('intro_mail_template')#</p></cfoutput>
                                    
                                    <br>
                            
                            <cfif not isdefined("SESSION.ACCESS_EL")>
                                <cfinclude template="./incl/incl_noaccess.cfm">
                            <cfelse>
                                        
                            <cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
                            SELECT w.wemail_id, w.wemail_category, w.wemail_subcategory, w.wemail_category_clean, w.wemail_subject, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category) as nb, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category AND wemail_sample_1 IS NOT NULL) as nb_notnull FROM lms_wemail w WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY w.wemail_category, w.wemail_subcategory, w.wemail_subject 
                            </cfquery>
                                
                            <h6 class="card-title text-red"><cfoutput>#obj_translater.get_translate('card_wemail_search')#</cfoutput></h6>
                            
                            <form id="form-global_search" name="global_search" class="mt-2">
                                <div class="typeahead__container">
                                    <div class="typeahead__field">
                                        <div class="typeahead__query">
                                            <input class="js_typeahead_wemail" name="wemail[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
                                        </div>
                                        <div class="typeahead__button">
                                            <button type="submit">
                                                <i class="typeahead__search-icon"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            
                            <br><br>
                            <h6 class="card-title text-red"><cfoutput>#obj_translater.get_translate('card_wemail_category')#</cfoutput></h6>
                        
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="tree mt-2" id="tree_wemail1">
                                        <ul style="padding:0px">	
                                            <cfif f_id eq "2">
                                                <cfset startrow = "1">
                                                <cfset maxrows = "16">
                                            <cfelseif f_id eq "3">
                                                <cfset startrow = "1">
                                                <cfset maxrows = "8">
                                            </cfif>
                                            <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                <li>
                                                    <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                    
                                                    <ul>
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
                                                    
                                                    </ul>
                                                </li>
                                            </cfoutput>
                                            
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="tree mt-2" id="tree_wemail2">
                                        <ul style="padding:0px">	
                                            <cfif f_id eq "2">
                                                <cfset startrow = "190">
                                                <cfset maxrows = "16">
                                            <cfelseif f_id eq "3">
                                                <cfset startrow = "36">
                                                <cfset maxrows = "8">
                                            </cfif>
                                            <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                <li>
                                                    <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                    
                                                    <ul>
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
                                                    
                                                    </ul>
                                                </li>
                                            </cfoutput>
                                        
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="tree mt-2" id="tree_wemail3">
                                        <ul style="padding:0px">	
                                            <cfif f_id eq "2">
                                                <cfset startrow = "380">
                                                <cfset maxrows = "16">
                                            <cfelseif f_id eq "3">
                                                <cfset startrow = "73">
                                                <cfset maxrows = "8">
                                            </cfif>
                                            <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                <li>
                                                    <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                    
                                                    <ul>
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
                                                    
                                                    </ul>
                                                </li>
                                            </cfoutput>
                                            
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="tree mt-2" id="tree_wemail4">
                                        <ul style="padding:0px">	
                                            <cfif f_id eq "2">
                                                <cfset startrow = "897">
                                                <cfset maxrows = "50">
                                            <cfelseif f_id eq "3">
                                                <cfset startrow = "97">
                                                <cfset maxrows = "8">
                                            </cfif>
                                            <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                <li>
                                                    <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                    
                                                    <ul>
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
                                                    
                                                    </ul>
                                                </li>
                                            </cfoutput>
                                            
                                        </ul>
                                    </div>
                                </div>
                                
                            </div>
                            
                            </cfif>

                        
                        </div>

                    </div>


                </div>























                <cfelseif subm eq "vocabulary">

                    <cfset voc_btn_class = "fal fa-heart-square fa-2x btn_add_uvoc cursored">
                    <cfif subm eq "vocabulary_perso">
                        <cfset voc_btn_class = "fal fa-trash-alt fa-lg btn_rm_uvoc cursored">
                    </cfif>
                
                    <div class="row">
                        <div class="col-md-12">
    
                            <div class="card border">
    
                                <div class="card-body">

                                    <h5 class="mr-4 text-uppercase font-weight-bold" align="center"><cfoutput>#obj_translater.get_translate('card_#subm#_list')#</cfoutput></h5>
                                
                                    <cfif subm eq "vocabulary">
                                        
                                        <cfoutput><p class="mt-2">#obj_translater.get_translate_complex('intro_vocablist')#</p></cfoutput>
                                        
                                    </cfif>
                    
                        <cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
                        SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
                        </cfquery>
                        
                        <cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
                        SELECT v.voc_id, v.voc_word_#lang_select# as voc_word, v.voc_desc_#lang_select# as voc_desc, vc.voc_cat_name_#lang_select# as voc_cat_name, v.voc_cat_id
                        FROM lms_vocabulary v
                        INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
                        
                        WHERE voc_cat_online = 1									
                        </cfquery>
                        
                        <cfif lang_select eq "en">
                            <cfset lg_translate_select = "2">
                        <cfelseif lang_select eq "fr">
                            <cfset lg_translate_select = "1">
                        <cfelseif lang_select eq "de">
                            <cfset lg_translate_select = "3">
                        </cfif>
                        
                        <cfif isdefined("voc_cat_select")>
                            
                            <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
                            SELECT v.*,
                            vtfr.voc_type_name_fr as voc_type_name_fr,
                            vten.voc_type_name_en as voc_type_name_en,
                            vtde.voc_type_name_de as voc_type_name_de,
                            vcat.voc_cat_name_#lang_select# as voc_cat
                            
                            FROM lms_vocabulary v
                            
                            LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
                            LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
                            LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
                            
                            LEFT JOIN lms_vocabulary_category vcat ON v.voc_cat_id = vcat.voc_cat_id
                            
                            <cfif subm eq "vocabulary_perso">
                                INNER JOIN user_vocablist uv ON uv.voc_id = v.voc_id
                            </cfif>
                            
                            WHERE <cfif subm eq "vocabulary_perso">uv.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                                <cfelse>v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_select#"></cfif>  
                            ORDER BY <cfif voc_cat_select eq -1>voc_cat, </cfif>voc_word_#lang_select#
                            </cfquery>
                            
                        </cfif>
                        
                    
                    
                    <div class="row mt-3">
                    
                        <div class=<cfif subm eq "vocabulary">"col-md-4"<cfelse>"col-md-12"</cfif>>
                        
                            <div class="border bg-light p-2 h-100">
                                <h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_settings')#</cfoutput></h6>
                                                                            
                                <div class="row mt-3">
                                    <label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('table_th_lrn_language')#</cfoutput></label>
                                    <div class="col-sm-8">
                                        <select class="form-control lang_select" name="lang_select">
                                            <option value="en" <cfif lang_select eq "en">selected</cfif>>English</option>
                                            <option value="fr" <cfif lang_select eq "fr">selected</cfif>>Fran&ccedil;ais</option>
                                            <option value="de" <cfif lang_select eq "de">selected</cfif>>Deutsch</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('table_th_translation')#</cfoutput></label>
                                    <div class="col-md-8">
                                    <cfoutput>
                                    <cfloop list="en,fr,de" index="cor">
                                    <cfif cor neq lang_select>
                                    <label><input type="radio" name="lang_translate" class="lang_translate" id="lang_#cor#" value="#cor#" <cfif listfind(lang_translate,"#cor#")>checked</cfif>> <span class="lang-sm lang-lbl" lang="#cor#"></span></label> &nbsp;&nbsp;&nbsp;
                                    </cfif>
                                    </cfloop>
                                    </cfoutput>
                                    </div>
                                </div>
                                
                                <cfif get_vocabulary.recordcount neq 0>
                                <div class="row mt-3">
                                    <label class="col-sm-4 col-form-label"><cfoutput>#obj_translater.get_translate('btn_export')#</cfoutput></label>
                                    <div class="col-md-8">
                                    <cfoutput><a target="_blank" href="./tpl/vocablist_container.cfm?voc_cat_id=#voc_cat_select#&lang_select=#lang_select#&lang_select_id=#lg_translate_select#&<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-sm btn-primary"><i class="fad fa-file-pdf btn_export_list" id="export_#voc_cat_select#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
                                                
                                    </div>
                                </div>
                                </cfif>
                            </div>
                        
                        </div>
                        
                         
                        <cfif subm eq "vocabulary">

                        <div class="col-md-4">
                        
                            <div class="border bg-light p-2 h-100">
                                <h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_thematic_list')#</cfoutput></h6>
                        
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <select class="form-control voc_cat_select" name="voc_cat_select">
                                        <cfoutput query="get_category">
                                        <!---<a class="btn btn-sm <cfif voc_cat_select eq get_category.voc_cat_id>btn-outline-info active<cfelse>btn-outline-info</cfif> mb-0 py-0" href="common_tools.cfm?subm=vocabulary&voc_cat_select=#voc_cat_id#">#voc_cat_name#</a>--->
                                        <option value="#voc_cat_id#" <cfif voc_cat_select eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
                                        </cfoutput>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        
                        </div>
                        
                        <div class="col-md-4">
                            
                            <div class="border bg-light p-2 h-100">
                            
                                <h6 class="card-title text-info"><cfoutput>#obj_translater.get_translate('card_vocab_search')#</cfoutput></h6>
                                
                                <div class="row mt-3">
                                    <div class="col-md-12">											
                                        <form id="form-global_search" name="global_search">
                                            <div class="typeahead__container">
                                                <div class="typeahead__field">
                                                    <div class="typeahead__query">
                                                        <input class="js_typeahead_voc" name="vocabulary[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    
                                </div>
                            </div>
                            
                        </div>
                        </cfif>
                        
                        
                        
                        
                    </div>
                        
                    
                    <cfif get_vocabulary.recordcount eq 0 && subm eq "vocabulary_perso">
                    <div>
                        <br>
                        <p>
                        
                        <cfoutput>#obj_translater.get_translate_complex('empty_my_vocablist')#</cfoutput>
                        
                        </p>
                    </div>
                    <cfelseif isdefined("voc_cat_select")>
                    <cfset sort_active = "fas fa-sort fa-1x">
                    <cfset sort_desactive = "fal fa-sort fa-1x">
                        
                    <div class="row">
                                
                        <div class="col-md-12">
                        
                            <table <cfif lang_translate neq "">class="table table-bordered table-responsive mt-3"<cfelse>class="table table-bordered mt-3"</cfif>>
                                <tr class="bg-light">
                                    <cfoutput>
                                    
                                    
                                    
                                    <th width="2%"></th>
                                    <th nowrap><label class="order_choice cursored" id="#lang_select#_0">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate_select#")#<cfif subm eq "vocabulary_perso">  <i class=<cfif voc_cat_select eq 0>"#sort_active#"<cfelse>"#sort_desactive#"</cfif>></i></cfif></label></th>
                                    <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate_select#")#</label></th>
                                    <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate_select#")#</label></th>
                                    
                                    <cfloop list="en,fr,de" index="cor">
                                    <cfif listfind(lang_translate,cor)>
                                    <cfif cor eq "en">
                                        <cfset lg_translate = "2">
                                    <cfelseif cor eq "fr">
                                        <cfset lg_translate = "1">
                                    <cfelseif cor eq "de">
                                        <cfset lg_translate = "3">
                                    </cfif>
                                    <th width="2%"></th>
                                    <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate#")#</label></th>
                                    <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate#")#</label></th>
                                    <!--- <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th> --->
                                    </cfif>
                                    </cfloop>
                                    
                                    <cfif subm eq "vocabulary_perso">
                                    <th nowrap><label class="order_choice cursored" id="#lang_select#_-1">#obj_translater.get_translate(id_translate="table_th_vocab_category",lg_translate="#lg_translate_select#")#  <i class=<cfif voc_cat_select eq -1>"#sort_active#"<cfelse>"#sort_desactive#"</cfif>></i></label></th>
                                    </cfif>
                                    
                                    <th width="3%"></th>
                                    
                                    </cfoutput>
                                </tr>
                                
                                <cfoutput query="get_vocabulary">
                                <tr id="#SESSION.USER_ID#_#voc_id#">
                                
                                    <cfif lang_select eq "en">
                                        <cfset td_color = "ecd9d9">
                                    <cfelseif lang_select eq "fr">
                                        <cfset td_color = "c6cbe1">
                                    <cfelseif lang_select eq "de">
                                        <cfset td_color = "c8d4ca">
                                    </cfif>
                                    
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        <a name="#voc_id#"></a>
                                        <span class="lang-sm" lang="#lang_select#"></span>
                                    </td>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        <strong>#evaluate('voc_word_#lang_select#')#</strong>
                                    </td>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        #evaluate('voc_type_name_#lang_select#')#
                                    </td>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        #evaluate('voc_desc_#lang_select#')#
                                    </td>
                                    
                                    
                                    <cfloop list="en,fr,de" index="cor">
                                    <cfif listfind(lang_translate,cor)>
                                    <cfif cor eq "en">
                                        <cfset td_color = "ecd9d9">
                                    <cfelseif cor eq "fr">
                                        <cfset td_color = "c6cbe1">
                                    <cfelseif cor eq "de">
                                        <cfset td_color = "c8d4ca">
                                    </cfif>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        <span class="lang-sm" lang="#cor#"></span>
                                    </td>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        <strong>#evaluate('voc_word_#cor#')#</strong>
                                    </td>
                                    <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                                        #evaluate('voc_type_name_#cor#')#
                                    </td>
                                    <!--- <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>> --->
                                        <!--- #evaluate('voc_desc_#cor#')# --->
                                    <!--- </td> --->
                                    </cfif>
                                    </cfloop>
                                    
                                    <cfif subm eq "vocabulary_perso">
                                        <td class="bg-light">
                                            #voc_cat#
                                        </td>
                                    </cfif>
                                    
                                    <td class="bg-white">
                                        <cfif subm eq "vocabulary">
                                            <cfsilent>
                                                <cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">SELECT * FROM user_vocablist WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#voc_id#></cfquery>
                                            </cfsilent>
                                            <cfif check_uvoc.recordcount neq 0>
                                                <i class="fas fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
                                            <cfelse>
                                                <i class="#voc_btn_class#" id="#SESSION.USER_ID#_#voc_id#"></i>
                                            </cfif>
                                        <cfelse>													
                                                <i class="#voc_btn_class#" id="#SESSION.USER_ID#_#voc_id#"></i>
                                        </cfif>
                                    </td>
                                    
                                </tr>
                                </cfoutput>
                            </table>
                        </div>
                        
                    </div>
                        
                    </cfif>
                    
                </div>
            </div>














                </cfif>


                <!--- <a class="float-right" href="_AD_elearning_index.cfm?step=begin">[retour]</a> --->

                
                                

                <!--- <div class="row">
    
                    <div class="col-lg-6 col-md-6 col-sm-6">
				        
                        <div class="accordion_reading" id="accordion_reading">
                            <div class="card">
                                <div class="card-header p-4" id="skill_reading" type="button" data-toggle="collapse" data-target="#div_reading" aria-expanded="false" aria-controls="div_reading">
                                    <p>
                                        <img src="./assets/img/240_F_303946149_pzkuQv0LqtbY1ZgSjdPBYdUDKgGH2c6h.jpg" width="100" align="left">
                                        <h5 class="text-info m-0 ml-3"><!---<i class="fal fa-books text-info text-center"></i>---> Work on... <strong>READING</strong></h5>
                                    </p>
                                    <div class="progress" style="height: 5px;">
                                    <div class="progress-bar bg-info" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>

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
                                    <p>
                                        <img src="./assets/img/240_F_412967644_1jAgrUWY5A4Awhz9lWB5iGdm8TtZ3sCu.jpg" width="100" align="left">
                                        <h5 class="text-info m-0 ml-3"><!---<i class="fal fa-books text-info text-center"></i>---> Work on... <strong>LISTENING</strong></h5>
                                    </p>
                                </div>
                                <div id="div_listening" class="collapse" aria-labelledby="skill_listening" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                        <div id="accordion_listening_top">    
                                            
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
                                    <h5 class="text-primary m-0"><i class="fal fa-spell-check text-primary text-center"></i> Work on... <strong>GRAMMAR</strong></h5>
                                </div>
                                <div id="div_grammar" class="collapse" aria-labelledby="skill_grammar" data-parent="#skills_accordion">
                                    <div class="card-body">
                                    
                                    
                                    <div id="accordion_grammar_top">
                                        <div align="center" class="mb-3">
                                            <div class="btn-group-toggle" data-toggle="buttons">	
                                                <cfloop list="A1,A2,B1,B2,C1" index="cor">
                                                    <cfif findnocase("A1",cor)>
                                                        <cfset css = "red">
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
                                                        <cfset css = "red">
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
                
            </div>--->
                
        </div>
        
            
        
        
    <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
        
</div>
    
      
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">
    
    
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
    

    <script>
        $(document).ready(function() {

            handler_del_elearning_session = function del_elearning_session(){
                event.preventDefault();
                var idtemp = $(this).attr("id");
                var idtemp = idtemp.split("_");
                es_id = idtemp[2];

                console.log(es_id)
                
                $.ajax({
                    url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
                    type : 'POST',
                    data : {
                        user_id:'<cfoutput>#SESSION.USER_ID#</cfoutput>',
                        elearning_session_id:es_id
                    },				
                    success : function(result, status) {
                        window.location.reload(true);
                    }
                });
            
            };
            $(".del_elearning_session").bind("click",handler_del_elearning_session);
            
            handler_add_elearning_session = function add_elearning_session(){
                event.preventDefault();

                var es_id = $('#new_elearning_session_id').val();
                console.log(es_id)
                
                $.ajax({
                    url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
                    type : 'POST',
                    data : {
                        user_id:'<cfoutput>#SESSION.USER_ID#</cfoutput>',
                        elearning_session_id:es_id
                    },				
                    success : function(result, status) {
                        window.location.reload(true);
                    }
                });
            
            };
            $(".btn_add_elearning_session").bind("click",handler_add_elearning_session);
    
                
            <cfif subm eq "email">
            $('#tree_wemail1 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        
            $('#tree_wemail1 li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                }
                e.stopPropagation();
            });
            
            $('#tree_wemail2 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        
            $('#tree_wemail2 li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                }
                e.stopPropagation();
            });
        
            
            $('#tree_wemail3 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        
            $('#tree_wemail3 li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                }
                e.stopPropagation();
            });
        
            $('#tree_wemail4 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        
            $('#tree_wemail4 li.parent_li > span').on('click', function (e) {
                var children = $(this).parent('li.parent_li').find(' > ul > li');
                if (children.is(":visible")) {
                    children.hide('fast');
                    $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
                } else {
                    children.show('fast');
                    $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
                }
                e.stopPropagation();
            });
        
        
            $('.btn_view_wemail').click(function(event) {
                event.preventDefault();		
                var idtemp = $(this).attr("id");
                var idtemp = idtemp.split("_");
                var idt = idtemp[1];	
                $('#window_item_lg').modal({keyboard: true});
                $('#modal_title_lg').text("Wemail");
                $('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+idt, function() {});
            });
            
            $.typeahead({
                input: '.js_typeahead_wemail',
                order: "desc",
                minLength: 1,
                maxItem: 15,
                emptyTemplate: 'Pas de resultats pour "{{query}}"',
                /*matcher: function(item) {
                    return true
                }*/
                
                dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
                
                group: {
                    template: "{{group}}"
                },
                
                source: {
                    
                    <cfoutput query="get_wemail" group="wemail_category">
                    #replacenocase(wemail_category_clean,' ','','ALL')# : {
                    
                        display:"wemail_subject",
                        href:"",
                        data:[
                            <cfoutput group="wemail_subject">
                            {
                            "wemail_id": #wemail_id#,
                            "wemail_subject": "#wemail_subject#"
                            },
                            </cfoutput>
                        ]
                    
                    },
                    </cfoutput>
                },
                callback: {
                
                    onClickAfter: function (node, a, item, event) {
             
                        event.preventDefault;
                        
                        $('#window_item_lg').modal({keyboard: true});
                        $('#modal_title_lg').text("Email Template");
                        $('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+item.wemail_id, function() {});
                    
             
                    }			
                }
            });
            
            </cfif>
            
            <cfif subm eq "vocabulary_perso">
            $( ".btn_rm_uvoc" ).click(function() {
                    
                var id_temp = $(this).attr("id");
                if (id_temp != 0) {
                    <!-- $('#'+id_temp).append("<div class='spinner-border' role='status'></div>");			 -->
                        
                    var idtemp = id_temp.split("_");
                    var uid = idtemp[0];
                    var vid = idtemp[1];
        
                    $.ajax({
                        url : './components/vocabulary_perso.cfc?method=rm_user_voc',
                        type : 'POST',
                        data : {act:"rm_user_voc", uid:uid, vid:vid},
                            
                        red : function(resultat, status) {
                        
                            $("#"+id_temp).remove();
                        }
                    });
                        
                    $(this).attr('id', '0');
                    
                    
                }
            });
            
            
            $(".order_choice").click(function() {
                var c = $(this).attr("class");
        
        
                
                    var idtemp = $(this).attr("id");
                    var idtemp = idtemp.split('_');
                    var lg = idtemp[0];
                    var order = idtemp[1];
                
                    
                    var other = -1;
                    if (order != -1) {var other = 0}
                    console.log(order);
        
                    
                    if (order == -1) {
                        <cfoutput>
                            document.location.href="?subm=#subm#&voc_cat_select=-1&lang_select=#lang_select#";
                        </cfoutput>
                    }
                    if (order == 0) {
                    
                        <cfoutput>
                            document.location.href="?subm=#subm#&voc_cat_select=0&lang_select=#lang_select#";
                        </cfoutput>
                    }
        
                
                
            });
            </cfif>
            
            
            
            <cfif subm eq "vocabulary" or subm eq "vocabulary_perso">
            
            $('.lang_translate').click(function(event) {	
        
                var lang_translate = [];
                if($('#lang_en').is(":checked")){lang_translate.push("en")}
                if($('#lang_fr').is(":checked")){lang_translate.push("fr")}
                if($('#lang_de').is(":checked")){lang_translate.push("de")}
        
                <cfoutput>
                document.location.href="?subm=#subm#&voc_cat_select=#voc_cat_select#&lang_select=#lang_select#&lang_translate="+lang_translate;
                </cfoutput>
                
            });
            
            
            $('.lang_select').change(function(event) {	
        
                var lang_select = $('.lang_select').val();
                
                <cfoutput>
                document.location.href="?subm=#subm#&voc_cat_select=#voc_cat_select#&lang_select="+lang_select+"&lang_translate=#lang_translate#";
                </cfoutput>
                
            });
            
            $('.voc_cat_select').change(function(event) {	
        
                var voc_cat_select = $('.voc_cat_select').val();
                
                <cfoutput>
                document.location.href="?subm=#subm#&voc_cat_select="+voc_cat_select+"&lang_select=#lang_select#&lang_translate=#lang_translate#";
                </cfoutput>
                
            });
            </cfif>
            
            <cfif subm eq "vocabulary">
            
            $( ".btn_add_uvoc" ).click(function() {
        
                var id_temp = $(this).attr("id");
                
                    <!-- $('#'+id_temp).append("<div class='spinner-border' role='status'></div>"); -->
                    
                    var idtemp = id_temp.split("_");
                    var uid = idtemp[0];
                    var vid = idtemp[1];
                    
                    var c = $(this).attr("class");
                    
                    if ( c == "fal fa-heart-square fa-2x btn_add_uvoc cursored") {
                    $.ajax({
                        url : './components/vocabulary_perso.cfc?method=add_user_voc',
                        type : 'POST',
                        data : {act:"add_user_voc", uid:uid, vid:vid},
                        red : function(resultat, status) {
                        }
                    });
                    $(this).attr('class', 'fas fa-heart-square fa-2x btn_add_uvoc cursored');
                    }
                    
                    if ( c != "fal fa-heart-square fa-2x btn_add_uvoc cursored") {
                    $.ajax({
                        url : './components/vocabulary_perso.cfc?method=rm_user_voc',
                        type : 'POST',
                        data : {act:"rm_user_voc", uid:uid, vid:vid},
                        red : function(resultat, status) {
                        }
                    });
                    $(this).attr('class', 'fal fa-heart-square fa-2x btn_add_uvoc cursored');
                    }
                
            });
            
        
        
        
            $.typeahead({
                input: '.js_typeahead_voc',
                order: "desc",
                minLength: 1,
                maxItem: 15,
                emptyTemplate: 'Pas de resultats pour "{{query}}"',
                /*matcher: function(item) {
                    return true
                }*/
                
                dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
                
                group: {
                    template: "{{group}}"
                },
                
                source: {
                    
                    <cfoutput query="get_vocabulary_all" group="voc_cat_id">
                    <cfif voc_cat_id neq "35">
                    "#encodeForJavaScript(voc_cat_name)#" : {
                    
                        display:"voc_word",
                        href:"",
                        data:[
                            <cfoutput>
                            {
                            "voc_id": #voc_id#,
                            "voc_word": "#encodeForJavaScript(trim(voc_word))#",
                            "voc_category": "#encodeForJavaScript(trim(voc_cat_name))#",
                            "voc_cat_id": "#voc_cat_id#"					
                            },
                            </cfoutput>
                        ]
                    
                    },
                    </cfif>
                    </cfoutput>
                },
                callback: {
                
                    onClickAfter: function (node, a, item, event) {
             
                        event.preventDefault;
                        <cfoutput>				
                        document.location.href='?subm=#subm#&lang_select=#lang_select#&lang_translate=#lang_translate#&voc_cat_select='+item.voc_cat_id+'&v_id='+item.voc_id+'##'+item.voc_id;
                        </cfoutput>			
                    }			
                }
            });
            
            </cfif>
            
        });





         $('.btn_add_module').click(function(event) {
            event.preventDefault();
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("Gérer les modules eLearning");
            $('#modal_body_xl').load("modal_window_el.cfm", function() {});
        });
        
        </script>

    </body>
    </html>