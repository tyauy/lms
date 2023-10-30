<script>
tinymce.init({
    selector:'#lesson_feedback',
    branding: false,
    contextmenu: "link image imagetools table spellchecker",
    contextmenu_never_use_native: true,
    draggable_modal: false,
    menubar: '',	
    toolbar: 'undo redo | bold italic underline numlist bullist link',
    plugins: "lists,link",
    browser_spellcheck: true,
    paste_data_images: false,
    invalid_elements : "img",
    /*toolbar: 'undo redo | bold italic underline numlist bullist link | paste',
    paste_word_valid_elements: "b,strong,i,em,h1,h2",
    plugins: "lists,link,paste",
    remove_linebreaks : false*/
});

</script>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>
<cfset l_id = get_session.lesson_id>

<cfif l_id neq "">
    <cfif get_session.status_id eq "5"> 

        <cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

            <cfif get_session.sessionmaster_id eq "694">
                <!------- PTA -------->
                <cfset display_ln = "pta">
            <cfelseif get_session.sessionmaster_id eq "695">
                <!------- FIRST LESSON -------->
                <cfset display_ln = "first">
            <cfelse>
                <!------- ALL OTHERS LESSON -------->
                <cfset display_ln = "ln">
            </cfif>
            
        <cfelse>
            <cfif get_session.note_id neq "">
                <cfset display_ln = "read">
            </cfif>
        </cfif>
    </cfif>
</cfif>




<cfset display_ln = "ln">





<!--------------------- READ MODE FOR LEARNER ---------->
<cfif display_ln eq "read">

    <cfparam name="l_id">

    <cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>
    
    <cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
        <cfinvokeargument name="l_id" value="#l_id#">
    </cfinvoke>
    
    <cfinvoke component="api/tp/tp_get" method="oget_tp" returnvariable="get_tp">
        <cfinvokeargument name="t_id" value="#get_lessonnote.tp_id#">
    </cfinvoke>
    
    <cfswitch expression="#get_lessonnote.formation_id#">
        <cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
        <cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
        <cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
        <cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
        <cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
        <cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
    </cfswitch>
    
    <cfinvoke component="components/functions" method="get_dateformat" returnvariable="lesson_date_start">
        <cfinvokeargument name="datego" value="#get_lesson.lesson_start#">
        <cfinvokeargument name="lang" value="#lang_temp#">
    </cfinvoke>
    
    <cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
    SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #formation_id# ORDER BY grammar_cat_name
    </cfquery>
    
    <cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
    SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #formation_id#
    </cfquery>
    
    <cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
    SELECT e.eval_id, eq.equ_name_#lang_temp# as equ_name, eq.equ_group_#lang_temp# as equ_group, eq.equ_id, er.equ_result
    FROM lms_eval e
    INNER JOIN lms_eval_question eq ON eq.eval_id = e.eval_id
    LEFT JOIN lms_eval_result er ON er.equ_id = eq.equ_id
    WHERE e.eval_id = 1 AND (er.note_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.note_id#"> OR er.note_id IS NULL)
    ORDER BY equ_group
    </cfquery>
    
    <cfset lesson_intro = get_lessonnote.lesson_intro>
    <cfset lesson_footer = obj_translater.get_translate("ln_title_ending",formation_id)>
    
    <cfset sm_description = get_lessonnote.sessionmaster_description>
    <cfset sm_objectives = get_lessonnote.sessionmaster_objectives>
    <cfset sm_grammar = get_lessonnote.sessionmaster_grammar>
    <cfset sm_vocabulary = get_lessonnote.sessionmaster_vocabulary>
    
    <cfset lesson_open_main = get_lessonnote.lesson_open_main>
    <cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
    <cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
    <cfset lesson_skill_id = get_lessonnote.ln_skill_id>
    <cfset lesson_add_misc = get_lessonnote.lesson_add_misc>
    <cfset lesson_feedback = get_lessonnote.lesson_feedback>
    <cfset lesson_grammar = get_lessonnote.lesson_grammar>
    <cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>
    <cfset lesson_add_vocabulary = get_lessonnote.lesson_add_vocabulary>
    <cfset lesson_open_ressources = get_lessonnote.lesson_open_ressources>							
    <cfset lesson_add_correction = get_lessonnote.lesson_add_correction>
    <cfset lesson_homework = get_lessonnote.lesson_homework>
    
    <cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
    <cfset lesson_na_improve = get_lessonnote.lesson_na_improve>
    <cfset lesson_na_workon = get_lessonnote.lesson_na_workon>
    
    <cfset lesson_formation = get_lessonnote.formation_name>
    <cfset lesson_pta_initial = get_lessonnote.lesson_pta_initial>
    <cfset lesson_pta_achievement = get_lessonnote.lesson_pta_achievement>
    
    
    <cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
    <cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
    <cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
    <cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
    <cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>	
        
    <cfif get_lessonnote.sessionmaster_id eq "695">
    
        <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
        SELECT CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_fullname, u.*,
        a.account_name, g.group_name, s.user_status_name_fr as user_status_name
        
        FROM user u
        LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
        LEFT JOIN account a ON a.account_id = u.account_id
        LEFT JOIN account_group g ON g.group_id = a.group_id
        
        WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
        </cfquery>
    
        <cfset account_name = get_user.account_name>
        <cfset group_name = get_user.group_name>
        
        <cfset user_steps = get_user.user_steps>
        <cfset user_qpt = get_user.user_qpt>
        <cfset user_qpt_lock = get_user.user_qpt_lock>
        <cfset user_lst = get_user.user_lst>
        
        <cfset user_email = get_user.user_email>
        <cfset user_phone = get_user.user_phone>
        <cfset user_alias = get_user.user_alias>
        
        <cfset avail_id = get_user.avail_id>
        <cfset interest_id = get_user.interest_id>
                
        <cfset user_jobtitle = get_user.user_jobtitle>
        <cfset user_needs_course = get_user.user_needs_course>
        <cfset user_needs_frequency = get_user.user_needs_frequency>
        <cfset user_needs_trainer = get_user.user_needs_trainer>
        <cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
        <cfset user_needs_learn = get_user.user_needs_learn>
        <cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement>
        <cfset user_needs_complement = get_user.user_needs_complement>
        <cfset user_needs_theme = get_user.user_needs_theme>
        <cfset user_needs_duration = get_user.user_needs_duration>
        
        <cfset user_remind_1d = get_user.user_remind_1d>
        <cfset user_remind_3h = get_user.user_remind_3h>
        <cfset user_remind_15m = get_user.user_remind_15m>
        
        <cfset user_status_name = get_user.user_status_name>
    
    </cfif>
    
        <div class="card border h-100">
            <div class="card-body">
    
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-notes text-red fa-lg mr-2"></i><cfoutput>#get_lessonnote.sessionmaster_name#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
                <cfoutput query="get_lesson">
                <div class="row mt-3">
    
                    <div class="col-md-3">	
                                    
                        <div class="card">
                            
                            <cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
                                <img src="../assets/img_material/#sessionmaster_code#.jpg"class="card-img-top">
                            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
                                <img src="../assets/img_material/#sessionmaster_id#.jpg"class="card-img-top">
                            <cfelse>
                                <img src="../assets/img/wefit_lesson.jpg" class="card-img-top">
                            </cfif>
    
                            <cfif isDefined("sessionmaster_ressource")>
                            <div class="card-body">
                                <div class="d-flex w-100 justify-content-center">
                                    <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
                                        <i class="fa-thin fa-book fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
                                    <cfelse>
                                        <i class="fa-thin fa-book fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
                                    </cfif>
    
                                    <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
                                        <i class="fa-thin fa-volume-up fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
                                    <cfelse>
                                        <i class="fa-thin fa-volume-up fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
                                    </cfif>
    
                                    <cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
                                        <i class="fa-thin fa-film fa-lg text- m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
                                    <cfelse>
                                        <i class="fa-thin fa-film fa-lg m-2 cursored" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
                                    </cfif>
                                </div>
                                
                                
                            </div>
                            </cfif>
    
                        </div>
                        
                    </div>
    
                    <div class="col-md-9">	
                        #obj_function.get_thumb_border(user_id="#get_lessonnote.planner_id#",size="40",style="border-radius:50%; border: 2px solid ##8A2128 !important;")#
                    
                        <img src="./assets/img_formation/#formation_id#.png" width="40" class="border_thumb mr-1"> 
    
                        <br>
                        
                        <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fa-thin fa-calendar"></i> #lesson_date_start#</span> 
    
                        <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fa-thin fa-clock"></i> #timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</span> 
    
                        <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fa-thin fa-users"></i> #get_tp.method_name#</span> 
                    
                        <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:14px"><i class="fa-thin fa-hourglass-start"></i> #session_duration# min</span> 
                            
                        
                        <p class="mt-2">
        
                            <cfif isDefined("sessionmaster_description")>
                                #sessionmaster_description#
                            </cfif>
                            
                        </p>
    
    
                        <table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                            
                            <cfif sm_objectives neq "">
                                <tr>
                                    <td>
                                    <h6><u>#obj_translater.get_translate('ln_title_objectives',formation_id)#</u></h6>
                                    <p style="margin-top:10px">
                                    #sm_objectives#
                                    </p>
                                    </td>
                                </tr>
                            </cfif>
                            <cfif sm_grammar neq "">
                                <tr>
                                    <td>
                                    <h6><u>#obj_translater.get_translate('ln_title_grammar',formation_id)#</u></h6>
                                    <p style="margin-top:10px">
                                    #sm_grammar#
                                    </p>
                                    </td>
                                </tr>
                            </cfif>
                            <cfif sm_vocabulary neq "">
                                <tr>
                                    <td>
                                    <h6><u>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</u></h6>
                                    <p style="margin-top:10px">
                                    #sm_vocabulary#
                                    </p>
                                    </td>
                                </tr>
                            </cfif>
                        </table>
                    </div>
    
                </div>
                </cfoutput>
    
            </div>
        </div>
    
    
    
    
    
        <!----------------------------- NEEDS ASSESSMENTS 1ST LESSON ------------------------------------->
        <cfif get_lessonnote.sessionmaster_id eq "695">
    
            <div class="card border h-100">
                <div class="card-body">
        
                    <div class="w-100">
                        <h6 class="d-inline"><i class="fa-thin fa-bullseye-arrow text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h6>
                        <hr class="border-danger mb-1 mt-2">
                    </div>
                        
                    <cfoutput>
                    <table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                        
                        <cfif listlen(lesson_skill_id) neq "0">
                        <tr>
                            <td>
                            <h6><u>#obj_translater.get_translate('ln_title_want_to',formation_id)#</u></h6>
                            <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
                            SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
                            </cfquery>
                            <ul>
                            <cfloop query="get_skill">
                            <li>#get_skill.skill_objectives#</li>
                            </cfloop>
                            </ul>
                            </td>
                        </tr>
                        </cfif>
                        
                        <cfif lesson_na_needs neq "">
                        <tr>
                            <td>
                            <h6><u>#obj_translater.get_translate('ln_title_initial',formation_id)#</u></h6>
                            #replacenocase(lesson_na_needs,chr(10),"<br>","ALL")#
                            </td>
                        </tr>			
                        
                        </cfif>
                    
                    </table>
                    </cfoutput>
                </div>
            </div>
    
            <div class="card border h-100">
                <div class="card-body">
        
                    <div class="w-100">
                        <h6 class="d-inline"><i class="fa-thin fa-chess-knight text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_strategy_analysis',formation_id)#</cfoutput></h6>
                        <hr class="border-danger mb-1 mt-2">
                    </div>
                    <cfoutput>
                    <table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                        
                        <tr>
                            <td>
                                <h6><u>#ucase(obj_translater.get_translate('ln_title_how',formation_id))#</u></h6>
                                
                                <cfif listlen(user_needs_course) neq "0">
                                <strong>#obj_translater.get_translate('table_th_mini_course_pref',formation_id)#</strong><br>
                                <ul>
                                <cfloop list="#user_needs_course#" index="cor">
                                    <cfif cor eq "1"><li>Structural lessons</li></cfif>
                                    <cfif cor eq "2"><li>Open lessons</li></cfif>
                                    <cfif cor eq "3"><li>Workshop</li></cfif>
                                </cfloop>
                                </ul>
                                </cfif>
                            
                                <cfif user_needs_duration neq "">
                                <br>
                                <strong>#obj_translater.get_translate('table_th_mini_course_duration',formation_id)#</strong><br>
                                <ul>
                                    <li>#user_needs_duration# min</li>
                                </ul>
                                </cfif>
                                
                                <cfif user_needs_frequency neq "">
                                <br>
                                <strong>#obj_translater.get_translate('table_th_mini_course_freq',formation_id)#</strong><br>
                                <ul>	
                                <cfif user_needs_frequency eq "1"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('day',formation_id)#</li></cfif>
                                <cfif user_needs_frequency eq "2"><li>3 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
                                <cfif user_needs_frequency eq "3"><li>2 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
                                <cfif user_needs_frequency eq "4"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
                                </ul>
                                </cfif>
                                
                                <cfif user_needs_trainer neq "">
                                <br>
                                <strong>#obj_translater.get_translate('table_th_mini_trainer_franco',formation_id)#</strong><br>
                                <ul>
                                    <cfif user_needs_trainer eq "1"><li>#obj_translater.get_translate('yes',formation_id)#</li></cfif>
                                    <cfif user_needs_trainer eq "0"><li>#obj_translater.get_translate('no',formation_id)#</li></cfif>
                                </ul>
                                </cfif>
                                
                                <cfif user_needs_nbtrainer neq "">
                                <br>							
                                <strong>#obj_translater.get_translate('table_th_mini_trainer_nb',formation_id)#</strong><br>							
                                <ul>
                                    <cfif user_needs_nbtrainer eq "1"><li>#obj_translater.get_translate('needs_txt_trainer_mono',formation_id)#</li></cfif>
                                    <cfif user_needs_nbtrainer eq "2"><li>#obj_translater.get_translate('needs_txt_trainer_several',formation_id)#</li></cfif>
                                </ul>
                                </cfif>
                                
                            </td>
                        </tr>
                            
                            
                    </table>
                    </cfoutput>
    
                </div>
    
            </div>
    
            <div class="card border h-100">
                <div class="card-body">
    
                    <div class="w-100">
                        <h6 class="d-inline"><i class="fa-thin fa-head-side-brain text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_learner_profile',formation_id)#</cfoutput></h6>
                        <hr class="border-danger mb-1 mt-2">
                    </div>
    
                    
                    <table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                    
                        <tr>
                            <td>
                                
                                <cfif listlen(interest_id) neq "0">
                                <h6><u><cfoutput>#obj_translater.get_translate('ln_title_interests',formation_id)#</cfoutput></u></h6>
                                <cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
                                SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
                                FROM lms_keyword k 
                                INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
                                WHERE keyword_id IN (#interest_id#) ORDER BY k.keyword_cat_id DESC
                                </cfquery>
    
                                <cfoutput query="get_keywords" group="keyword_cat_id">
                                    <strong>#keyword_cat_name#</strong>
                                    <br>
                                    <cfoutput>
                                    #keyword_name#<br>
                                    </cfoutput>
                                </cfoutput>		
                                                
                                </cfif>
                                
                                <!---	fetching user test for TP	--->
                                <cfquery name="get_eval" datasource="#SESSION.BDDSOURCE#">
                                    SELECT qu.quiz_global_level,
                                    lv.level_desc_#lang_temp# as level_desc, lv.level_name_#lang_temp# as level_name
                                    FROM lms_quiz_user_score qu
                                    INNER JOIN lms_quiz_user_tp qutp ON qu.quiz_user_group_id = qutp.quiz_user_group_id
                                    LEFT JOIN lms_level lv ON lv.level_alias LIKE LEFT( qu.quiz_global_level, 2)
                                    WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.user_id#">
                                    AND qutp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lessonnote.tp_id#">
                                    AND qu.quiz_global_level IS NOT NULL
                                </cfquery>
                                
                                
                                
                                <cfif get_eval.recordcount GT 0 >
                                <cfoutput query="get_eval">
                                <h6><u>#ucase(obj_translater.get_translate('ln_title_level',formation_id))#</u></h6>
    
                                    #obj_translater.get_translate('ln_lesson_level_intro',formation_id)# #get_eval.quiz_global_level# - #get_eval.level_name#
    
                                    #get_eval.level_desc#
                                </cfoutput>					
                                </cfif>
                                                        
                            </td>
                            
                        </tr>
                    </table>
    
                </div>
            </div>
        
        <!----------------------------- PTA LAST LESSON ------------------------------------->
        <cfelseif get_lessonnote.sessionmaster_id eq "694">
    
        <div class="card border h-100">
            <div class="card-body">
    
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-bullseye-arrow text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
    
                <table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                                
                    <tr>
                        <td>
                        
                        <cfif listlen(lesson_skill_id) neq "0">
                        <h6><u>YOU WANTED TO LEARN <cfoutput>#ucase(lesson_formation)#</cfoutput> TO:</u></h6>
                        <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
                        SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
                        </cfquery>
                        <ul>
                        <cfoutput>
                        <cfloop query="get_skill">
                        <li>#get_skill.skill_objectives#</li>
                        </cfloop>
                        </cfoutput>
                        </ul>
                        </cfif>
                        
                        
                        <cfif lesson_pta_initial neq "">
                        <br>
                        
                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_initial',formation_id)#</cfoutput></u></h6>
                        <cfoutput>#replacenocase(lesson_pta_initial,chr(10),"<br>","ALL")#</cfoutput>
                        </cfif>
                        
                        </td>
                    </tr>
                </table>
    
            </div>
        </div>
    
        <div class="card border h-100">
            <div class="card-body">
                
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-trophy text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_achievement',formation_id)#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
    
                <table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                                
                    <tr>
                        <td>
    
                        <cfif lesson_pta_achievement neq "">
                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_now_able',formation_id)#</cfoutput></u></h6>
                        <cfoutput>#replacenocase(lesson_pta_achievement,chr(10),"<br>","ALL")#</cfoutput>
                        </cfif>
                        
                        <cfif lesson_feedback neq "">
                        <br>
                        
                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback_tips',formation_id)#</cfoutput></u></h6>
                        <cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#</cfoutput>
                        </cfif>
                        
                        </td>
                    </tr>
                </table>
    
            </div>
        </div>
    
    
        <div class="card border h-100">
            <div class="card-body">
    
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-ranking-star text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_performance',formation_id)#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
                
                <em>5: Excellent&nbsp;&nbsp;&nbsp;4: Very good&nbsp;&nbsp;&nbsp;3: Good&nbsp;&nbsp;&nbsp;2: Satisfactory&nbsp;&nbsp;&nbsp;1: Poor</em>
                    
    
                <table bgcolor="#CCCCCC" style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:20px" width="100%" cellpadding="10" cellspacing="1">	
    
                    <cfoutput query="get_eval" group="equ_group">
                                    
                    <tr bgcolor="##ECECEC">
                        <td><strong>#ucase(equ_group)#</strong></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">1</span></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">2</span></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">3</span></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">4</span></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">5</span></td>
                        <td width="10"><span class="badge badge-pill badge-secondary">NA</span></td>
                    </tr>
                    
                    <cfoutput>
                    
                    <tr bgcolor="##FFFFFF">
                        <td>
                            #equ_name#
                        </td>
                        <cfif isdefined("equ_result") AND equ_result eq "1">
                        <td width="10" bgcolor="##ff7c7c">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                        <cfif isdefined("equ_result") AND equ_result eq "2">
                        <td width="10" bgcolor="##fbb962">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                        <cfif isdefined("equ_result") AND equ_result eq "3">
                        <td width="10" bgcolor="##e7ef00">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                        <cfif isdefined("equ_result") AND equ_result eq "4">
                        <td width="10" bgcolor="##c6e885">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                        <cfif isdefined("equ_result") AND equ_result eq "5">
                        <td width="10" bgcolor="##49b734">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                        <cfif isdefined("equ_result") AND equ_result eq "0">
                        <td width="10" bgcolor="##ECECEC">
                            X
                        </td>
                        <cfelse>
                        <td width="10" bgcolor="##FFF">
                            
                        </td>								
                        </cfif>
                    </tr>
                    
                    </cfoutput>
                    
                    </cfoutput>
    
                </table>
    
            </div>
        </div>
    
    
    
    
        
        <cfelse>
        <!----------------------------- OTHERS LESSON ------------------------------------->
        
        <div class="card border h-100">
            <div class="card-body">
    
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-spell-check text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_today_teaching_points',formation_id)#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
    
                <cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "697" OR listlen(lesson_skill_id) neq "0" OR lesson_add_misc neq "">
                    <cfoutput>
                    <table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                        <cfif get_lessonnote.sessionmaster_id eq "696" OR get_lessonnote.sessionmaster_id eq "1181" OR get_lessonnote.sessionmaster_id eq "1183">
                            <tr>
                                <td>
                                <h6><u>#obj_translater.get_translate('ln_title_main_discussion',formation_id)#</u></h6>
                                <p style="margin-top:10px">
                                #replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
                                </p>
                                <cfif lesson_open_ressources neq "">
                                    
                                    <p style="margin-top:10px">
                                    #replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#
                                    </p>
                                
                                </cfif>
                                </td>
                            </tr>
                        
                        <cfelseif get_lessonnote.sessionmaster_id eq "697">
                            <tr>
                                <td>
                                <h6><u>#obj_translater.get_translate('ln_title_did_work_on',formation_id)#</u></h6>
                                <p style="margin-top:10px">
                                #replacenocase(lesson_open_main,chr(10),"<br>","ALL")#
                                </p>
                                
                                <cfif lesson_open_ressources neq "">
                                    
                                    <p style="margin-top:10px">
                                    #replacenocase(lesson_open_ressources,chr(10),"<br>","ALL")#
                                    </p>
                                
                                </cfif>
                                    
                                </td>
                            </tr>
                        </cfif>
                        <cfif listlen(lesson_skill_id) neq "0">
                            <tr>
                                <td>
                                <h6><u>#obj_translater.get_translate('ln_title_today_work_on',formation_id)#</u></h6>
                                <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
                                SELECT skill_name_#lang_temp# as skill_name FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
                                </cfquery>
                                <ul>
                                <cfloop query="get_skill">
                                <li>#get_skill.skill_name#</li>
                                </cfloop>
                                </ul>
                                </td>
                            </tr>
                        </cfif>
                        <cfif lesson_add_misc neq "">
                            <tr>
                                <td>
                                <p style="margin-top:10px">
                                #replacenocase(lesson_add_misc,chr(10),"<br>","ALL")#
                                </p>
                                </td>
                            </tr>
                        
                        </cfif>
                    </table>
                    </cfoutput>
                </cfif>
                
                
                
                
                
                <table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
                
                    <tr>
                        <td width="100%" align="center" style="padding:20px 20px 0px 20px">
                                
                            <table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="100%" align="left">
                                        
                                        <cfif lesson_grammar neq "" OR lesson_vocabulary neq "" OR lesson_add_vocabulary neq "" OR lesson_add_correction neq "" OR lesson_homework neq "">
                                        
                                        <table bgcolor="#EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <cfif listfind(get_lessonnote.ln_skill_id,"5") AND listlen(get_lessonnote.ln_grammar_id) neq "0">
                                                        
                                                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_covered',formation_id)#</cfoutput></u></h6>
                                                        
                                                        <cfquery name="get_grammar" datasource="#SESSION.BDDSOURCE#">
                                                        SELECT grammar_name, grammar_level, grammar_cat_name, g.grammar_cat_id
                                                        FROM lms_grammar g INNER JOIN lms_grammar_category gc ON gc.grammar_cat_id = g.grammar_cat_id WHERE g.grammar_id IN (#get_lessonnote.ln_grammar_id#)
                                                        </cfquery>										
                                                        
                                                        <cfoutput query="get_grammar" group="grammar_cat_id">
                                                        <strong>#grammar_cat_name# (#grammar_level#)</strong>
                                                        <ul>
                                                        <cfoutput>
                                                        <li>#get_grammar.grammar_name#</li>
                                                        </cfoutput>
                                                        </ul>
                                                        </cfoutput>
                                                        
                
                                                    </cfif>
                                            
                                            
                                                    <cfif lesson_grammar neq "">
                                                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_grammar_explanation',formation_id)#</cfoutput></u></h6>
                                                        <p style="margin-top:10px">
                                                        <cfoutput>#replacenocase(lesson_grammar,chr(10),"<br>","ALL")#</cfoutput>
                                                        </p>
                                                    </cfif>
                                            
                                                    <cfif lesson_vocabulary neq "">
                                                    
                                                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h6>
                                                        <p style="margin-top:10px">
                                                        <cfoutput>#replacenocase(lesson_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
                                                        </p>
                                                    
                                                    </cfif>
                                                    
                                                    <cfif lesson_add_vocabulary neq "">
                                                    
                                                        <h6><u><cfoutput>#obj_translater.get_translate('ln_title_vocabulary',formation_id)#</cfoutput></u></h6>
                                                        <p style="margin-top:10px">
                                                        <cfoutput>#replacenocase(lesson_add_vocabulary,chr(10),"<br>","ALL")#</cfoutput>
                                                        </p>
                                                    
                                                    </cfif>
                                                    
                                                    <cfif lesson_add_correction neq "">
                                                    
                                                        <p style="margin-top:10px">
                                                        <cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
                                                        </p>
                                                    
                                                    </cfif>
                                                    
                                                    <cfif lesson_homework neq "">
                                                    
                                                        <p style="margin-top:10px">
                                                        <cfoutput>#replacenocase(lesson_homework,chr(10),"<br>","ALL")#</cfoutput>
                                                        </p>
                                                    
                                                    </cfif>
                                                
                                                </td>
                                            
                                            </tr>
                                            
                                        </table>
                                        
                                        </cfif>
                
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>      
    
            </div>
        </div>
    
        <cfif lesson_feedback neq "">
        <div class="card border h-100">
            <div class="card-body">
    
                <div class="w-100">
                    <h6 class="d-inline"><i class="fa-thin fa-message-check text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback',formation_id)#</cfoutput></h6>
                    <hr class="border-danger mb-1 mt-2">
                </div>
    
                <p>
                    <cfoutput>#replacenocase(lesson_feedback,chr(10),"<br>","ALL")#	</cfoutput>	
                </p>
                
            </div>
        </div>
        </cfif>
    
        </cfif>
    
        <div align="center">
            <cfoutput>
                <div>
                    <a style="min-height:82px !important;" target="_blank" class="text-secondary" href="./tpl/ln_container.cfm?l_id=#l_id#">
                        <i class="fa-thin fa-download fa-2x mt-2"></i> PDF
                    </a>
                </div>
            <em style="font-size:13px">#lesson_footer#</em>
            <br>#get_lessonnote.planner_firstname#
            </cfoutput>
            
        </div>
    
    
    </body>
    </html>
    
    <script>
    $(document).ready(function() {
    
        
    });
    </script>
    




























    

    
<cfelse>

    <style>
    .purple{
        fill: #933088; 
    }
    .green{
        fill:#80BB46;
    }
    .perso:hover .st0{  
        fill:#933088;
        opacity: 0.5;
     }
    .badge:hover .st0{    
        fill:#80BB46;
        opacity: 0.5;
    }
    .smiley_img {
        max-height: 70px;
    }
    </style>

    <cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_general" returnvariable="get_keyword_tracking_general">
        <cfinvokeargument name="s_id" value="#s_id#">
    </cfinvoke>

    <cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_business" returnvariable="get_keyword_tracking_business">
        <cfinvokeargument name="s_id" value="#s_id#">
    </cfinvoke>

    <cfinvoke component="api/tracking/tracking_get" method="oget_vocab_tracking" returnvariable="get_vocab_tracking">
        <cfinvokeargument name="s_id" value="#s_id#">
    </cfinvoke>

    <cfinvoke component="api/tracking/tracking_get" method="oget_mapping_tracking" returnvariable="get_mapping_tracking">
        <cfinvokeargument name="s_id" value="#s_id#">
    </cfinvoke>

    <cfquery name="get_skill_sub" datasource="#SESSION.BDDSOURCE#">
    SELECT ss.skill_sub_name_#SESSION.LANG_CODE# as skill_sub_name, ss.skill_sub_id
    FROM lms_skill_sub2 ss
    WHERE ss.skill_id IN (2,4)
    </cfquery>

    <div class="row justify-content-between">
        <div class="col-lg-12">



            <div class="w-100 mt-4">
                <h5 class="d-inline"><i class="fa-thin fa-list-check text-red fa-lg mr-2"></i><cfoutput>Tracking skills</cfoutput></h5>
                <hr class="border-danger mb-1 mt-2">
            </div>

            
            <div id="skill_accordion">
            <!--------- SUB SKILL GLOBAL -------->
            <div class="bg-light shadow-sm rounded border mt-2">
                <div class="p-2">
                    <h6 class="m-0 d-inline" id="skill_global" type="button" data-toggle="collapse" data-target="#div_global" aria-expanded="true" aria-controls="div_global">
                        <i class="fa-thin fa-language fa-lg mr-1"></i> Global skills
                    </h6>
                    <div class="collapse mt-2" id="div_global" aria-labelledby="skill_global" data-parent="#skill_accordion">
                        <table class="table table-sm bg-white">
                            <tr>
                                <th>Skill</th>
                                <th>Notation</th>
                            </tr>
                            <cfoutput>
                            <cfloop query="get_skill_sub">
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_subskill" id="switch_subskill_#skill_sub_id#">
                                        <label class="custom-control-label mb-0 pb-0" for="switch_subskill_#skill_sub_id#">#skill_sub_name#</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_subskill_#skill_sub_id#" class="collapse">
                                    <cfloop from="1" to="15" index="cor">
                                        <div id="subskill_#skill_sub_id#_#cor#" class="p-1 ratingsubskill float-left" name="#skill_sub_id#" style="max-height: 30px;">
                                            <img src="https://lms.wefitgroup.com/assets/img_sublevel/#cor#_nb.svg" class="subskill_img cursored" id="img_subskill_#skill_sub_id#_#cor#" width="30">
                                            <input type="radio" name="subskill_#skill_sub_id#" class="form_#skill_sub_id#" id="input_#skill_sub_id#_#cor#" value="#cor#" style="visibility: hidden" required>
                                        </div>
                                    </cfloop>
                                    </div>
                                </td>
                            </tr>
                            </cfloop>
                            </cfoutput>

                        </table>
                    </div>
                </div>
            </div>



            <!--------- GENERAL / INTEREST KEYWORD -------->
            <cfif get_keyword_tracking_general.recordcount neq "0">
            <div class="bg-light shadow-sm rounded border mt-2">
                <div class="p-2">
                    <h6 class="m-0 d-inline" id="skill_global" type="button" data-toggle="collapse" data-target="#div_general" aria-expanded="false" aria-controls="div_general">
                        <i class="fa-thin fa-earth-europe fa-lg mr-1"></i> General English
                    </h6>
                    <div class="collapse mt-2" id="div_general" aria-labelledby="skill_global" data-parent="#skill_accordion">
                        <table class="table table-sm bg-white">
                            <tr>
                                <th>Discussed subjects</th>
                                <th>Time elapsed</th>
                            </tr>
                            <cfoutput>
                            <cfloop query="get_keyword_tracking_general">
                                <tr>
                                    <td>
                                        <div class="custom-control custom-switch">
                                            <input type="checkbox" class="custom-control-input" id="custom_kw_#keyword_id#">
                                            <label class="custom-control-label mb-0 pb-0" for="custom_kw_#keyword_id#">#keyword_name#</label>
                                        </div>
                                    </td>
                                    <td>
                                        <select class="form-control form-control-sm disabled">
                                            <option value="">All lesson</option>
                                            <option value="">Half lesson</option>
                                            <option value="">Quick review</option>
                                        </select>
                                    </td>
                                </div>
                            <div class="clearfix"></div>
                            </cfloop>
                            </cfoutput>
                        </table>
                    </div>
                </div>
            </div>
            </cfif>

            <!--------- BUSINESS / KEYWORD -------->
            <cfif get_keyword_tracking_business.recordcount neq "0">
            <div class="bg-light shadow-sm rounded border mt-2">
                <div class="p-2">
                    <h6 class="m-0 d-inline" id="skill_global" type="button" data-toggle="collapse" data-target="#div_business" aria-expanded="false" aria-controls="div_business">
                        <i class="fa-thin fa-briefcase fa-lg mr-1"></i> Business Skills
                    </h6>
                    <div class="collapse mt-2" id="div_business" aria-labelledby="skill_global" data-parent="#skill_accordion">
                        <table class="table table-sm bg-white">
                            <tr>
                                <th>Core skills</th>
                                <th>Notation</th>
                            </tr>
                            <cfoutput>
                            <cfloop query="get_keyword_tracking_business">
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_kw" id="switch_kw_#keyword_id#">
                                        <label class="custom-control-label mb-0 pb-0" for="switch_kw_#keyword_id#">#keyword_name#</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_kw_#keyword_id#" class="collapse">
                                    <cfloop from="1" to="5" index="cor">
                                        <cfoutput>
                                            <div id="kw_#keyword_id#_#cor#" class="p-1 ratingkey float-left" name="#keyword_id#" style="max-height: 30px;">
                                                <!---       <cffile action="read" file="https://lms.wefitgroup.com/assets/img_smile/#cor#.svg" variable="smiley_#cor#">
                                                            <cfoutput>#Variables["smiley_#cor#"]#</cfoutput> --->
                                                <img src="https://lms.wefitgroup.com/assets/img_smile/#cor#_nb.svg" class="smiley_img cursored" id="img_kw_#keyword_id#_#cor#" width="30">
                                                <input type="radio" name="kw_#keyword_id#" class="form_#keyword_id#" id="input_#keyword_id#_#cor#" value="#cor#" style="visibility: hidden" required>
                                            </div>
                                        </cfoutput>
                                    </cfloop>
                                    </div>
                                </td>
                            </tr>
                            </cfloop>
                            </cfoutput>
                        </table>
    
                    <!--- <span class="badge badge-pill bg-white border border-dark px-2 py-2 mt-2 font-weight-normal" style="font-size:12px"><i class="fa-thin fa-clock" aria-hidden="true"></i> #keyword_name#</span> --->
                    </div>
                </div>
            </div>
            </cfif>


            <!--------- VOCABULARY LIST -------->
            <cfif get_vocab_tracking.recordcount neq "0">
            <div class="bg-light shadow-sm rounded border mt-2">
                <div class="p-2">
                    <h6 class="m-0 d-inline" id="skill_voc" type="button" data-toggle="collapse" data-target="#div_voc" aria-expanded="false" aria-controls="div_voc">
                        <i class="fa-thin fa-language fa-lg mr-1"></i> Vocabulary list
                    </h6>
                    <div class="collapse mt-2" id="div_voc" aria-labelledby="skill_voc" data-parent="#skill_accordion">
                        <table class="table table-sm bg-white">
                            <tr>
                                <th>Vocabulary list</th>
                                <th>Notation</th>
                            </tr>
                            <cfoutput>
                            <cfloop query="get_vocab_tracking">
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="custom_voc_#voc_cat_id#">
                                        <label class="custom-control-label mb-0 pb-0" for="custom_voc_#voc_cat_id#">#voc_cat_name#</label>
                                    </div>
                                </td>
                                <td>
    
                                </td>
                            </tr>
                            </cfloop>
                            </cfoutput>
                        </table>
                    </div>
                </div>
            </div>
            </cfif>


        
            <!--------- MAPPING POINT -------->
            <cfif get_mapping_tracking.recordcount neq "0">
            <div class="bg-light shadow-sm rounded border mt-2">
                <div class="p-2">
                    <h6 class="m-0 d-inline" id="skill_mapping" type="button" data-toggle="collapse" data-target="#div_mapping" aria-expanded="false" aria-controls="div_mapping">
                        <i class="fa-thin fa-spell-check fa-lg mr-1"></i> Language Points
                    </h6>
                    <div class="collapse mt-2" id="div_mapping" aria-labelledby="skill_mapping" data-parent="#skill_accordion">
                        <table class="table table-sm bg-white">
                            <tr>
                                <th>Language points</th>
                                <th>Mastery level</th>
                            </tr>
                            <cfoutput>
                            <cfloop query="get_mapping_tracking">
                            <tr>
                                <td>
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input switch_mapping" id="custom_mapping_#mapping_id#">
                                        <label class="custom-control-label mb-0 pb-0" for="custom_mapping_#mapping_id#">#mapping_name#</label>
                                    </div>
                                </td>
                                <td>
                                    <div id="rating_mapping_#mapping_id#" class="collapse">
                                        <cfloop from="1" to="5" index="cor">
                                            <cfoutput>
                                                <div id="mapping_#mapping_id#_#cor#" class="p-1 ratingkey float-left" name="#mapping_id#" style="max-height: 30px;">
                                                    <!---       <cffile action="read" file="https://lms.wefitgroup.com/assets/img_smile/#cor#.svg" variable="smiley_#cor#">
                                                                <cfoutput>#Variables["smiley_#cor#"]#</cfoutput> --->
                                                    <img src="https://lms.wefitgroup.com/assets/img_smile/#cor#_nb.svg" class="smiley_img cursored" id="img_mapping_#mapping_id#_#cor#" width="30">
                                                    <input type="radio" name="mapping_#mapping_id#" class="form_#mapping_id#" id="input_#mapping_id#_#cor#" value="#cor#" style="visibility: hidden" required>
                                                </div>
                                            </cfoutput>
                                        </cfloop>
                                    </div>
                                </td>
                            </tr>
                            </cfloop>
                            </cfoutput>
                        </table>
                    </div>
                </div>
            </div>
            </cfif>
            </div>

            <div class="w-100 mt-4">
                <h5 class="d-inline"><i class="fa-thin fa-message-check text-red fa-lg mr-2"></i><cfoutput>#obj_translater.get_translate('ln_title_trainer_feedback')#</cfoutput></h5>
                <hr class="border-danger mb-1 mt-2">
            </div>


            <textarea name="lesson_feedback" id="lesson_feedback" class="form-control" placeholder="Feedback trainer (min. 150 chr.)" style="border:1px solid #871E2C"><!---<cfoutput>#lesson_feedback#</cfoutput>---> Feedback</textarea>
			

        </div>

    </div>








<script>
    $(document).ready(function() {


<!-------------------------------------------------->
<!----------GESTION SMILEYS ------------------------>
<!-------------------------------------------------->

$(".ratingkey").mouseout(function(event) {
    for(var i=0;i<=5;i++)
    {if(i <= 5){$("#keyimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
})

// $(".support").mouseout(function(event) {
//     for(var i=0;i<=5;i++)
//     {if(i <= 5){$("#supportimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
// })

// $(".teaching").mouseout(function(event) {
//     for(var i=0;i<=5;i++)
//     {if(i <= 5){$("#teachingimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
// })


$(".switch_subskill").change(function(event)  {

    var temp = ($(this).attr("id"));
    temp = temp.split("_");
    sub_id = temp["2"];

    $("#rating_subskill_"+sub_id).toggleClass('show');
});


$(".switch_kw").change(function(event)  {

    var temp = ($(this).attr("id"));
    temp = temp.split("_");
    k_id = temp["2"];

    $("#rating_kw_"+k_id).toggleClass('show');
});

$(".switch_mapping").change(function(event)  {

    var temp = ($(this).attr("id"));
    temp = temp.split("_");
    m_id = temp["2"];

    $("#rating_mapping_"+m_id).toggleClass('show');
});


$(".subskill_img").mouseover(function(event) {

    var subskill_click = ($(this).attr("id"));
    subskill_click = subskill_click.split("_");
    cor_id = subskill_click["3"];
    ss_id = subskill_click["2"];
    cat_id = subskill_click["1"];

    for(var i=0;i<=15;i++)
    {
        if(i <= cor_id)
        {$("#img_"+cat_id+"_"+ss_id+"_"+i).attr('src','https://lms.wefitgroup.com/assets/img_sublevel/'+i+'_plain.svg');}
        else
        {$("#img_"+cat_id+"_"+ss_id+"_"+i).attr('src','https://lms.wefitgroup.com/assets/img_sublevel/'+i+'_nb.svg');}
    }
});


$(".smiley_img").mouseover(function(event) {

    var smile_click = ($(this).attr("id"));
    smile_click = smile_click.split("_");
    cor_id = smile_click["3"];
    k_id = smile_click["2"];
    cat_id = smile_click["1"];

    for(var i=0;i<=5;i++)
    {
        if(i <= cor_id)
        {$("#img_"+cat_id+"_"+k_id+"_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+cor_id+'.svg');}
        else
        {$("#img_"+cat_id+"_"+k_id+"_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+cor_id+'_nb.svg');}
    }
});

$(".smiley_img").click(function(event) {

    var smile_click = ($(this).attr("id"));
    smile_click = smile_click.split("_");
    smile_click = smile_click["1"];
    var parentName = ($(this).parent().attr('name'));

    var parentId = ($(this).parent().attr('id'));
    var id = ($(this).attr("id"));
    id = id.split("_");
    id = id["1"];
    var inputN =($("input[id='input_"+parentId+"']"));

    $("."+parentName).off('mouseout');

    value=($(inputN).prop("checked", function( i, val ) {
        return !val;
    })) ;
    /*   console.log("this is the svg id before split "+($(this).attr("id")));
                console.log(parentId);
                
                console.log(inputN.attr("value"));  */
    $("."+parentName+ "> img").off('mouseover');

    for(var i=0;i<=5;i++)
    {
        if(i <= smile_click)
        {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'.svg');}
        else
        {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'_nb.svg');}

    }
    console.log($('#form_global_rating').serialize()); 
    
});



})





    
</cfif>