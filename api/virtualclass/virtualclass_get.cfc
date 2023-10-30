<cfcomponent>

    <!------------------ GET SESSION VC ORIENTATED ------------->
    <cffunction name="oget_session_vc" access="public" returntype="query" description="Retrieve list of sessions for VC display">
		<cfargument name="t_id" type="numeric" required="yes">
        <cfargument name="f_id" type="numeric" required="no">
		<cfargument name="status" type="any" required="no">
		

		<cfquery name="oget_session_vc" datasource="#SESSION.BDDSOURCE#">
			SELECT 
			t.tp_id, t.tp_name, t.method_id, t.tp_date_end, f.formation_id, f.formation_code, t.tp_icon, t.tp_max_participants,
			s.session_id, s.session_duration, s.session_rank, s.session_close, s.session_name, s.mapping_id, s.origin_id,
			lv.level_id, lv.level_alias, lv.level_name_#SESSION.LANG_CODE# as level_name, lv.level_css,
			sm.sessionmaster_id, sm.sessionmaster_cat_id, sm.module_id, sm.skill_id, sm.keyword_id, sm.grammar_id, sm.sessionmaster_audio_bool, sm.sessionmaster_video_bool, sm.sessionmaster_support_bool, sm.sessionmaster_code, sm.sessionmaster_level, sm.sessionmaster_type, sm.sessionmaster_duration, sm.sessionmaster_url, sm.sessionmaster_ressource, sm.sessionmaster_subtype, sm.sessionmaster_group, sm.sessionmaster_ln_grammar, sm.sessionmaster_ln_vocabulary, sm.sessionmaster_md, sm.sessionmaster_transcript, sm.sessionmaster_video, sm.sessionmaster_el_duration, sm.voc_cat_id, sm.sessionmaster_exercice, sm.sessionmaster_date, sm.sessionmaster_icon, 
			CASE WHEN sm.sessionmaster_name_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_name_#SESSION.LANG_CODE# <> " " THEN sm.sessionmaster_name_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_name,
			CASE WHEN sm.sessionmaster_description_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_description_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_description_#SESSION.LANG_CODE# ELSE sessionmaster_description END AS sessionmaster_description,
			CASE WHEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_objectives_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_objectives_#SESSION.LANG_CODE# ELSE sessionmaster_objectives END AS sessionmaster_objectives,
			CASE WHEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_grammar_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_grammar_#SESSION.LANG_CODE# ELSE sessionmaster_grammar END AS sessionmaster_grammar,
			CASE WHEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# IS NOT NULL AND sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# <> " "  THEN sm.sessionmaster_vocabulary_#SESSION.LANG_CODE# ELSE sessionmaster_name END AS sessionmaster_vocabulary,
			lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
			u2.user_alias as trainer_alias, u2.user_id as planner_id, u2.user_firstname as planner_firstname,
			l.lesson_start, l.lesson_end, l.lesson_id, l.status_id, l.lesson_duration, l.lesson_unbookable, l.lesson_ghost,
			ls.status_css, ls.status_bootstrap, ls.status_name_#SESSION.LANG_CODE# as status_name,
			la.subscribed

			FROM lms_tp t
			INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
			INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
			LEFT JOIN lms_level lv ON lv.level_id = t.level_id
			INNER JOIN lms_lesson2 l ON l.session_id = s.session_id AND l.status_id = 1
			INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
			INNER JOIN lms_lesson_method lm ON lm.method_id = t.method_id AND t.method_id = "10"
			INNER JOIN lms_formation f ON f.formation_id = t.formation_id
			INNER JOIN user u2 ON u2.user_id = l.planner_id	
			LEFT JOIN lms_lesson2_attendance la ON la.lesson_id = l.lesson_id AND la.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
			
			WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            
            <cfif isdefined("f_id")>
                AND t.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
            </cfif>

            <cfif isdefined("status")>
                <cfif status eq "past">
                    AND l.lesson_start < now()
                <cfelse>
                    AND (l.lesson_start IS NULL OR l.lesson_start > now())
                </cfif>
            </cfif>

            
			ORDER BY l.lesson_start ASC LIMIT 1

			</cfquery>
		
		<cfreturn oget_session_vc> 
		
	</cffunction>





    <!------------------ GET PACK TO DISPLAY DIRECTLY ------------->
    <cffunction name="oget_vc_week_level" output="yes" access="remote" returnformat="plain">

        <cfargument name="date_ref" type="date" required="yes">
        <cfargument name="level_id" type="integer" required="no">
        <cfargument name="is_subscribed" type="integer" required="no">
        <cfargument name="f_id" type="numeric" required="no">

        <cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>

        
	    <cfset __btn_cancel_short = obj_translater.get_translate('btn_cancel_short')>
        <cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
        <cfset __min = obj_translater.get_translate('short_minute')>

        <cfset todaydayOfWeek = dayOfWeek(date_ref)>
        <cfset mondayOffset = (2-todaydayOfWeek)>
        <cfset mostRecentMonday = dateAdd("d", mondayOffset, date_ref)>

        <cfset f_code = "en">
        <cfset f_list = "en">
        <cfif isDefined("SESSION.ACCESS_VIRTUALCLASS_LANG")>
            <cfset f_code = listFirst(SESSION.ACCESS_VIRTUALCLASS_LANG)>
            <cfset f_list = SESSION.ACCESS_VIRTUALCLASS_LANG>
        </cfif>


        <cfset level_lock = 6>
        <cfif StructKeyExists(SESSION.USER_LEVEL,f_code)>
            <cfset level_lock = SESSION.USER_LEVEL[f_code].level_id>
            <!--- <cfdump var="#SESSION.USER_LEVEL#"> --->
        </cfif>

        <cfloop from="0" to="4" index="cor">

            <cfset date_ref = dateadd("d",cor,mostRecentMonday)>

            <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
            SELECT l.*, 
            sm.sessionmaster_name, sm.sessionmaster_id,
            t.tp_id, t.tp_max_participants, t.tp_name, t.tp_icon,
            m.method_name_#SESSION.LANG_CODE# as method_name, 
            u2.user_firstname as planner_contact,
            lla_v.subscribed,
            ls.status_id, ls.status_css, ls.status_name_#SESSION.LANG_CODE# as status_name,
            lv.level_css AS tplevel_css, lv.level_alias AS tplevel_alias, lv.level_color AS tplevel_color, lv.level_color_light AS tplevel_color_light, t.level_id AS tplevel_id,
            f.formation_id, f.formation_code
            FROM lms_lesson2 l
            LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id	
            LEFT JOIN lms_tpsession ts ON ts.session_id = l.session_id
            LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = ts.sessionmaster_id	
            INNER JOIN lms_tp t ON t.tp_id = l.tp_id AND t.method_id = 10
            INNER JOIN lms_lesson_method m ON m.method_id = t.method_id
            INNER JOIN user u2 ON l.planner_id = u2.user_id
            LEFT JOIN lms_level lv ON lv.level_id = t.level_id
            LEFT JOIN lms_formation f ON f.formation_id = t.formation_id	
            LEFT JOIN lms_lesson2_attendance lla_v ON lla_v.lesson_id = l.lesson_id AND lla_v.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        
            WHERE t.method_id = 10 AND DATE_FORMAT(lesson_start, "%Y-%m-%d") = '#dateformat(date_ref,'yyyy-mm-dd')#'
            <cfif isdefined("level_id") AND level_id neq "0">
                AND t.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">
            <cfelse>
                AND (t.level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#"> OR t.level_id IS NULL)
            </cfif>

            <cfif isdefined("f_id")>
                AND t.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
            </cfif>
            
            ORDER BY lesson_start
            </cfquery>

            <div class="border-right col p-1">
<!--- <cfdump var="#get_lesson#"> --->
                <strong><cfoutput>#LSDateFormat(date_ref,"ddd dd mmm",'#SESSION.LANG_CODE#')#</cfoutput></strong>
                
                <cfif get_lesson.recordcount neq "0">

                <cfoutput query="get_lesson">

                    <cfif listFindNoCase(f_list, formation_code)>

                    <cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
                    SELECT COUNT(*) as nb
                    FROM lms_lesson2_attendance la 
                    LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
                    WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#"> 
                    AND subscribed = 1
                    </cfquery>

                    <cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
                    SELECT tpuser_active
                    FROM lms_tpuser 
                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> 
                    AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                    </cfquery>

                    <cfif count_participant.nb neq "0">
                        <cfset seats_total = get_lesson.tp_max_participants>
                        <cfset seats_used = count_participant.nb>
                        <cfset seats_remaining = seats_total-seats_used>
                    <cfelse>
                        <cfset seats_total = get_lesson.tp_max_participants>
                        <cfset seats_used = 0>
                        <cfset seats_remaining = seats_total>
                    </cfif>

                    <!--- <cfif isdefined("level_id") AND tplevel_id eq level_id>
                        <cfif lesson_start lt now()>
                            <cfset border_color = "#tplevel_color#">
                            <cfset color = "#tplevel_color_light#">
                            <cfset tp_color = "#tplevel_color_light#">
                            <cfset text_color = "FFFFFF">
                        <cfelse>
                            <cfset border_color = "#tplevel_color#">
                            <cfset color = "#tplevel_color#">
                            <cfset tp_color = "#tplevel_color#">
                            <cfset text_color = "FFFFFF">
                        </cfif>
                    <cfelse>
                        <cfset border_color = "ECECEC">
                        <cfset color = "ECECEC">
                        <cfset tp_color = "999999">
                        <cfset text_color = "999999">
                    </cfif> --->

                    <cfset border_color = "#tplevel_color#">
                    <cfset color = "#tplevel_color#">
                    <cfset tp_color = "#tplevel_color#">
                    <cfset text_color = "FFFFFF">

                    <cfset timehour = TimeFormat(lesson_start, "HH:mm")>

                    <cfset timeday = dateFormat(lesson_start, "dd/mm")>

                    <div class="shadow-sm p-2 pb-3 mb-2 rounded bg-light cursored btn_view_lesson border border-#tplevel_alias#" id="lesson_#tp_id#_#lesson_id#">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="mb-2 mt-0"><span class="badge border border-#tplevel_alias# badge-pill bg-white mr-2" id="pillcalendar_#lesson_id#"><small><strong>#timeday# - #timehour#</strong></small></span></h5>
                            </div>

                            <div>
                                <cfif tplevel_alias neq "A0">
                                    <img src="./assets/img_level/#tplevel_alias#.svg" width="30">
                                <cfelse>
                                    <cfif findnocase("TOEIC", tp_name)>
                                        <img class="mr-3 img_rounded" src="./assets/img/logo_toeic.jpg" width="60">
                                    <cfelseif findnocase("LINGUASKILL", tp_name)>
                                        <img class="mr-3 img_rounded" src="./assets/img/logo_linguaskill.jpg" width="60">
                                    </cfif>
                                </cfif>
                            </div>
                        </div>
                        <div class="d-flex" style="font-size:14px">

                            <div>
                                <i class="fa-thin d-none d-lg-block #tp_icon# fa-2x mr-2"></i>
                            </div>

                            <div>
                                
                            <cfif level_id neq "0">
                                 <strong>#ucase(tp_name)#</strong><br>
                            </cfif>
                                <!--- #lesson_id# --->
                            #sessionmaster_name#
                            
                            <cfif lesson_start gt now() AND lesson_start lt dateadd("d","7",now())>
                                <br>
                                <span><i class="fa-light fa-users"></i> #obj_translater.get_translate("vc_btn_remaining_seats")#: <span id="remainingcalendar_#lesson_id#"><strong>#seats_remaining#</strong></span></span>
                                <br>

                                <cfif subscribed eq 1>
                                    <div class="d-flex justify-content-end align-items-end">
                                        <div>
                                            <a class="d-block btn btn_join_class btn-outline-red font-weight-normal" id="join_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#tplevel_alias#" data-lduration="#lesson_duration#">
                                                #__btn_cancel_short#
                                            </a>
                                        </div>
                                        <div>
                                            <button class="btn btn-red <cfif lesson_start lt dateadd("m","30",now())>disabled<cfelse>btn_launch_lesson</cfif>  font-weight-normal" id="l_#lesson_id#">#obj_translater.get_translate('btn_launch_lesson')#</button>
                                        </div>
                                    </div>
                                <cfelse>
                                    <div class="d-flex justify-content-end align-items-end">
                                        <div>
                                            <cfif level_id eq "0">
                                                <a class="btn btn-sm btn-red btn_join_class font-weight-normal" id="joincalendar_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#tplevel_alias#" data-lduration="#lesson_duration#">
                                                    #__btn_book_short# #lesson_duration# #__min#
                                                </a>
                                            <cfelse>
                                                <a class="btn btn-sm <cfif !StructKeyExists(SESSION.USER_LEVEL,formation_code) OR SESSION.USER_LEVEL[formation_code].level_id lt tplevel_id - 1>disabled<cfelse>btn_join_class</cfif> btn-#tplevel_alias# font-weight-normal" id="joincalendar_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#tplevel_alias#" data-lduration="#lesson_duration#">
                                                    #__btn_book_short# #lesson_duration# #__min#
                                                </a>
                                            </cfif>
                                        </div>
                                    </div>

                                    
                                </cfif>

                            <cfelseif lesson_start gt now() AND lesson_start gte dateadd("d","7",now())>

                                <br>
                                <span><i class="fa-light fa-users"></i> #obj_translater.get_translate("vc_btn_not_opened_seats")#</span>
                                <br>
                                <a class="btn btn-sm disabled btn-#tplevel_alias# font-weight-normal" id="joincalendar_#lesson_id#" data-tid="#tp_id#" data-lid="#lesson_id#" data-levelalias="#tplevel_alias#" data-lduration="#lesson_duration#">
                                    #__btn_book_short# #lesson_duration# #__min#
                                </a>

                            </cfif>                                

                            </div>
                        </div>
                    </div>
                    </cfif>
                </cfoutput>
            <cfelse>
                <br>
                <cfoutput>#obj_translater.get_translate('vc_alert_no_vc')#</cfoutput>
            </cfif>
        
            </div>
        </cfloop>

    </cffunction>

</cfcomponent>
