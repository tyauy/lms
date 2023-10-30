<cfcomponent>

	<cffunction name="oget_pt" access="remote" returntype="query">
        <cfargument name="u_id" type="numeric" required="yes">
        <cfargument name="quiz_type" type="any" required="no">
		<cfargument name="quiz_user_group_id" type="numeric" required="no">
		<cfargument name="pt_type" type="any" required="no">
		<cfargument name="pt_speed" type="any" required="no">
		<cfargument name="t_id" type="any" required="no">
		<cfargument name="level_id" type="numeric" required="no">
		<cfargument name="feedback" type="numeric" required="no" default="0">
        <cfargument name="group" type="numeric" required="no" default="0">
        <cfargument name="attributed" type="numeric" required="no" default="1">

        
        <cfquery name="get_pt" datasource="#SESSION.BDDSOURCE#">
            SELECT us.quiz_user_group_id, us.quiz_formation_id, us.quiz_global_level, us.quiz_grammar_level, us.quiz_reading_level, us.quiz_listening_level, 
            us.quiz_global_score, us.quiz_grammar_score, us.quiz_reading_score, us.quiz_listening_score, 
            us.quiz_global_css, us.quiz_grammar_css, us.quiz_reading_css, us.quiz_listening_css,
            qu.quiz_user_id, qu.quiz_user_start, qu.pt_speed, ut.tp_id, ut.type,
            <cfif feedback neq 0>
                CASE WHEN fg.feedback_text_#SESSION.LANG_CODE# IS NOT NULL AND fg.feedback_text_#SESSION.LANG_CODE# <> ""  THEN fg.feedback_text_#SESSION.LANG_CODE# ELSE fg.feedback_text END AS general_feedback,
                CASE WHEN fgr.feedback_text_#SESSION.LANG_CODE# IS NOT NULL AND fgr.feedback_text_#SESSION.LANG_CODE# <> ""  THEN fgr.feedback_text_#SESSION.LANG_CODE# ELSE fgr.feedback_text END AS grammar_feedback,
                CASE WHEN fl.feedback_text_#SESSION.LANG_CODE# IS NOT NULL AND fl.feedback_text_#SESSION.LANG_CODE# <> ""  THEN fl.feedback_text_#SESSION.LANG_CODE# ELSE fl.feedback_text END AS reading_feedback,
                CASE WHEN fr.feedback_text_#SESSION.LANG_CODE# IS NOT NULL AND fr.feedback_text_#SESSION.LANG_CODE# <> ""  THEN fr.feedback_text_#SESSION.LANG_CODE# ELSE fr.feedback_text END AS listening_feedback,
            </cfif>
            l.tp_rank, f.formation_code, l.method_id, l.tp_duration, l.tp_name,
			tpe.elearning_name, l.elearning_duration, tpc.certif_name
            FROM lms_quiz_user_score us
            INNER JOIN lms_quiz_user qu ON us.quiz_user_group_id = qu.quiz_user_group_id AND qu.quiz_head = 1
            INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
            LEFT JOIN lms_quiz_user_tp ut ON ut.quiz_user_group_id = us.quiz_user_group_id
            LEFT JOIN lms_tp l on l.tp_id = ut.tp_id
			LEFT JOIN lms_formation f ON f.formation_id = us.quiz_formation_id 
			LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = l.elearning_id
			LEFT JOIN lms_list_certification tpc ON tpc.certif_id = l.certif_id
            <cfif feedback neq 0>
                LEFT JOIN lms_feedback fg ON fg.level_id LIKE us.quiz_global_level AND fg.skill_sub_id = 5 AND fg.formation_id = us.quiz_formation_id
                LEFT JOIN lms_feedback fgr ON fgr.level_id LIKE us.quiz_grammar_level AND fgr.skill_sub_id = 3 AND fgr.formation_id = us.quiz_formation_id
                LEFT JOIN lms_feedback fl ON fl.level_id LIKE us.quiz_reading_level AND fl.skill_sub_id = 2 AND fl.formation_id = us.quiz_formation_id
                LEFT JOIN lms_feedback fr ON fr.level_id LIKE us.quiz_listening_level AND fr.skill_sub_id = 1 AND fr.formation_id = us.quiz_formation_id
            </cfif>

            WHERE us.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 

            AND qu.quiz_user_end IS NOT NULL
            AND us.quiz_formation_id != 0
            
            <cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
                AND ut.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
            </cfif>
            <cfif isdefined("pt_type") AND pt_type neq "">
                AND ut.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
            </cfif> 

            <cfif isdefined("quiz_user_group_id")>
                AND qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
            </cfif>
            <cfif isdefined("quiz_user_id")>
                AND qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
            </cfif>
            <cfif isdefined("quiz_type")>
                AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
            </cfif>
            <cfif isdefined("pt_speed") AND pt_speed neq "">
                AND qu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
            </cfif>
            <cfif isdefined("level_id")>
                AND q.level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_id#">
            </cfif>
            <cfif attributed eq 0>
                AND ut.type IS NULL
            </cfif>
        
            <cfif group neq 0>
                GROUP BY us.quiz_user_group_id
            </cfif>
        </cfquery>


        <!--- <cfloop query="get_pt">

            <cfif get_pt.quiz_global_score eq "">
                            
                <cfinvoke component="api/quiz/quiz_post" method="updt_quiz_level">
                    <cfinvokeargument name="u_id" value="#u_id#">
                    <cfinvokeargument name="quiz_user_group_id" value="#quiz_user_group_id#">
                </cfinvoke>

                <cfset reload_pt = true>
            </cfif>

        </cfloop>

        <cfif isDefined("reload_pt")>
            <!--- same query as above - just for refresh purpose --->
            <cfquery name="get_pt" datasource="#SESSION.BDDSOURCE#">
                SELECT us.quiz_user_group_id, us.quiz_formation_id, us.quiz_global_level, us.quiz_grammar_level, us.quiz_reading_level, us.quiz_listening_level, 
                us.quiz_global_score, us.quiz_grammar_score, us.quiz_reading_score, us.quiz_listening_score, 
                us.quiz_global_css, us.quiz_grammar_css, us.quiz_reading_css, us.quiz_listening_css,
                qu.quiz_user_id, qu.quiz_user_start, qu.pt_speed, ut.tp_id, ut.type,
                l.tp_rank, f.formation_code, l.method_id, l.tp_duration, l.tp_name,
                tpe.elearning_name, l.elearning_duration, tpc.certif_name
                FROM lms_quiz_user_score us
                INNER JOIN lms_quiz_user qu ON us.quiz_user_group_id = qu.quiz_user_group_id AND qu.quiz_head = 1
                INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
                LEFT JOIN lms_quiz_user_tp ut ON ut.quiz_user_group_id = us.quiz_user_group_id
                LEFT JOIN lms_tp l on l.tp_id = ut.tp_id
                LEFT JOIN lms_formation f ON f.formation_id = l.formation_id 
                LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = l.elearning_id
                LEFT JOIN lms_list_certification tpc ON tpc.certif_id = l.certif_id
                
                WHERE us.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
            
                <cfif isdefined("t_id") AND t_id neq "" AND t_id neq "0">
                    AND ut.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#"> 
                </cfif>
                <cfif isdefined("pt_type") AND pt_type neq "">
                    AND ut.type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
                </cfif> 
    
                <cfif isdefined("quiz_user_group_id")>
                    AND qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
                </cfif>
                <cfif isdefined("quiz_user_id")>
                    AND qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
                </cfif>
                <cfif isdefined("quiz_type")>
                    AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">
                </cfif>
                <cfif isdefined("pt_speed") AND pt_speed neq "">
                    AND qu.pt_speed = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
                </cfif>
                <cfif isdefined("level_id")>
                    AND q.level_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_id#">
                </cfif>
            
            </cfquery>
        </cfif> --->

        <cfreturn get_pt>

    </cffunction>
<cffunction name="oget_all_questions_to_mapped">

    <cfquery name="get_quiz_questions" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT
            qq.qu_text,
            qq.qu_id,
            qa.ans_text,
            m.mapping_name,
            qqc.lms_mapping_id,
            qqc.is_correct,
            gm.lms_grammar_id
        
        FROM
            lms_quiz_question qq
        
        JOIN lms_quiz_question_mapping_cor qqc on qqc.qu_id=qq.qu_id and qqc.is_correct = 1
        Join lms_grammar_mapping_cor gm ON gm.lms_mapping_id = qqc.lms_mapping_id
        JOIN lms_mapping m ON gm.lms_mapping_id = m.mapping_id
        LEFT JOIN lms_quiz_answer qa ON qq.qu_id = qa.qu_id AND qa.ans_iscorrect = 1
        WHERE NOT EXISTS (
            SELECT 1
            FROM lms_quiz_question_mapping_cor subqqc
            WHERE subqqc.qu_id = qq.qu_id AND subqqc.timestamp >= <cfqueryparam cfsqltype="cf_sql_date" value="#now()#">
        )
        and qq.qu_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
        GROUP BY qq.qu_id, qq.qu_text, qa.ans_text, m.mapping_name, qqc.lms_mapping_id, qqc.is_correct, gm.lms_grammar_id
        order by qu_id asc
    </cfquery>
    
</cffunction>

<cffunction name="oget_question_mapping">
    <cfargument name="qu_id" type="numeric" required="yes">
    <cfquery name="get_linked_mappings" datasource="#SESSION.BDDSOURCE#">
        SELECT lms_mapping_id, qu_id, is_correct, lm.mapping_name
        FROM lms_quiz_question_mapping_cor lmc
        left join lms_mapping lm on lm.mapping_id=lmc.lms_mapping_id
        WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
        and is_correct =1
    </cfquery>
    
</cffunction>
</cfcomponent>