<cfcomponent>

    <cffunction name="updt_tptrainer_add" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update trainer attached to TP">

        <cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="p_id" type="numeric" required="yes">

        <cfargument name="interne" type="string" required="no" default="no">


        <cftry>

        <!------- SCAN ALREADY ATTACHED Ts ------>
        <cfquery name="check_trainer" datasource="#SESSION.BDDSOURCE#">
            SELECT active
            FROM lms_tpplanner 
            WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            LIMIT 1
        </cfquery>

        <cfif check_trainer.recordCount eq 0>
            <cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpplanner (
                    tp_id,
                    planner_id,
                    active
                )
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
                    1
                )
            </cfquery>
        <cfelseif check_trainer.active eq 0 >
            <cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_tpplanner SET
                active = 1,
                modification_date = NOW()
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            </cfquery>
        <cfelse>
            <!--- if somehow the trainer is already attached to the tp and active we exit --->
            <cfreturn 0>
        </cfif>
        
        <!--- for some process we don't want task or mail to be generated (see updater_form) --->
        <cfif interne neq "no">
            <cfreturn 1>
        </cfif>

        <cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_firstname, u.user_name, u.user_email, u.user_lang
            FROM user u
            WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        </cfquery>
        
        <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_firstname, u.user_name
            FROM user u
            WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
    

            <cfset _user = "#get_learner.user_firstname# #ucase(get_learner.user_name)#">
            <cfset _trainer = "#get_trainer.user_firstname#">
            <!--- <cfset _trainer $= " #ucase(get_trainer.user_name)#"> --->
            <!--- TODO cherche la lang du trainer pour mail --->
            <cfset lang = 'en'>

            <cfset SESSION.show_new_trainer = p_id>

            <cfset arr = ['_user', '_trainer']>
            <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
            <!--- <cfset txt_team = obj_translater.get_translate_complex('mail_team_trainer_added_title', lang, argv)> --->

            <cfinvoke component="components/translater" method="get_translate_complex" returnVariable="txt_team">
                <cfinvokeargument name="id_translate" value="mail_team_trainer_added_title">
                <cfinvokeargument name="lg_translate" value="#lang#">
                <cfinvokeargument name="argv" value="#argv#">
            </cfinvoke>


            <!--- <cfset txt = "Trainer #_trainer# have been added to the TP #t_id# for #_user#"> --->
            
            <!--------------------- INSERT TASK ----------------->	
            <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                <cfinvokeargument name="task_type_id" value="232">
                <cfinvokeargument name="u_id" value="#u_id#">
                <cfinvokeargument name="task_channel_id" value="6">
                <cfinvokeargument name="log_text" value="#txt_team#" >
            </cfinvoke>

            <cfif isDefined("SESSION.CUR_STEP") AND SESSION.CUR_STEP eq 3>
                <!---  we don't send mail from the launching --->
                <cfreturn 1>
            </cfif>


            <!--- <cfif SESSION.USER_PROFILE neq "CS" AND SESSION.USER_PROFILE neq "SALES" AND SESSION.USER_PROFILE neq "FINANCE"> --->

            <cfset subject = "[LMS] | Trainer Added | #_user#">

            <!--- to team only first - todo duplicate with trainer email  --->
            <cfinvoke component="api/email/email" method="send_simple_email">
                <!--- rremacle@wefitgroup.com,service@wefitgroup.com,finance@wefitgroup.com,  trainer@wefitgroup.com --->
                <cfinvokeargument name="to" value="trainer@wefitgroup.com">
                <cfinvokeargument name="subject" value="#subject#">
                <cfinvokeargument name="email_title" value="#txt_team#">
            </cfinvoke>
            
            <cfinvoke component="components/translater" method="get_translate_complex" returnVariable="txt_trainer">
                <cfinvokeargument name="id_translate" value="mail_trainer_added_title">
                <cfinvokeargument name="lg_translate" value="#get_trainer.user_lang neq "" ? get_trainer.user_lang : 'en'#">
                <cfinvokeargument name="argv" value="#argv#">
            </cfinvoke>

            <cfinvoke component="api/email/email" method="send_simple_email">
                <!--- #get_trainer.user_email# --->
                <cfinvokeargument name="to" value="#get_trainer.user_email#">
                <cfinvokeargument name="subject" value="[LMS] | Learner Added | #_user#">
                <cfinvokeargument name="email_title" value="#txt_trainer#">
            </cfinvoke>

            <!--- </cfif> --->

        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>




    <cffunction name="updt_tptrainer_delete" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update trainer attached to TP">

        <cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="p_id" type="numeric" required="yes">

        <cfargument name="interne" type="string" required="no" default="no">

		<cfargument name="avail" type="string" required="no" default="">
		<cfargument name="accent" type="string" required="no" default="">
		<cfargument name="method" type="string" required="no" default="">
		<cfargument name="style" type="string" required="no" default="">
		<cfargument name="skills" type="string" required="no" default="">
		<cfargument name="trainer" type="string" required="no" default="">
		<cfargument name="trainer_left" type="string" required="no" default="">
		<cfargument name="not_booked" type="string" required="no" default="">
		<cfargument name="review_description" type="string" required="no" default="">

        <cftry>

        <cfquery name="get_trainer_lesson" datasource="#SESSION.BDDSOURCE#">
            SELECT l.lesson_id
            FROM lms_lesson2 l
            WHERE l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            AND l.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            AND l.status_id IN (1,2)
        </cfquery>

        <cfif get_trainer_lesson.recordCount neq 0>
            <cfreturn 4>
        </cfif>

        <!------- Update active on TP ------>
        <cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tpplanner SET
        active = 0,
        modification_date = NOW()
        WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
        AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        </cfquery>

        <!--- for some process we don't want task or mail to be generated (see updater_form) --->
        <cfif interne neq "no">
            <cfreturn 1>
        </cfif>

        <cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_firstname, u.user_name, u.user_email, user_lang
            FROM user u
            WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
        </cfquery>

        <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_firstname, u.user_name, user_lang
            FROM user u
            WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>

        <!--------------------- INSERT TASK ----------------->	

        <cfset _user = "#get_learner.user_firstname# #ucase(get_learner.user_name)#">
        <cfset _trainer = "#get_trainer.user_firstname#">
        <!--- <cfset _trainer $= " #ucase(get_trainer.user_name)#"> --->
        <!--- TODO cherche la lang du trainer pour mail --->
        <cfset lang = 'en'>

        <cfset arr = ['_user', '_trainer']>
        <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

        <cfinvoke component="components/translater" method="get_translate_complex" returnVariable="txt">
            <cfinvokeargument name="id_translate" value="mail_team_trainer_removed_title">
            <cfinvokeargument name="lg_translate" value="#lang#">
            <cfinvokeargument name="argv" value="#argv#">
        </cfinvoke>


        <!--- <cfset txt = "Trainer #_trainer#  have been removed from the TP #t_id# of #_user#"> --->

        <cfif review_description neq "">
            <cfset txt &= ",<br> #review_description#" >
        </cfif>


        <cfset type = "">

        <cfif avail neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "230">
        </cfif>
        <cfif accent neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "190">
        </cfif>
        <cfif method neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "189">
        </cfif>
        <cfif style neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "193">
        </cfif>
        <cfif skills neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "192">
        </cfif>
        <cfif trainer neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "191">
        </cfif>
        <cfif trainer_left neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "231">
        </cfif>
        <cfif not_booked neq "">
            <cfif type neq ""><cfset type &= ","></cfif>
            <cfset type &= "233">
        </cfif>

        
        <cfif type eq "">
            <cfset type = "191">
        </cfif>

        <cfinvoke component="api/task/task_post" method="insert_task">
            <cfinvokeargument name="task_type_id" value="#type#">
            <cfinvokeargument name="u_id" value="#u_id#">
            <cfinvokeargument name="task_channel_id" value="6">
            <cfinvokeargument name="log_text" value="#txt#" >
        </cfinvoke>

        <!--- no need to send an email to the team id the change is from the team --->
        <!--- <cfif SESSION.USER_PROFILE neq "CS" AND SESSION.USER_PROFILE neq "SALES" AND SESSION.USER_PROFILE neq "FINANCE"> --->

            <cfset txt_team = txt >

            <cfloop list="#type#" index="item">
                <cfquery name="get_explanation" datasource="#SESSION.BDDSOURCE#">
                    SELECT task_type_name, task_explanation_en
                    FROM task_type
                    WHERE task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#item#">
                </cfquery>
    
                <cfset txt_team &= "<br> #get_explanation.task_type_name# : #get_explanation.task_explanation_en#" >
            </cfloop>

            <!--- to team only first duplicate with trainer email  --->
            <cfinvoke component="api/email/email" method="send_simple_email">
                <!--- rremacle@wefitgroup.com,service@wefitgroup.com,finance@wefitgroup.com,  trainer@wefitgroup.com --->
                <cfinvokeargument name="to" value="trainer@wefitgroup.com">
                <cfinvokeargument name="subject" value="[LMS] | Trainer changed | #_user#">
                <cfinvokeargument name="email_title" value="#txt_team#">
            </cfinvoke>


            <!--- <cfinvoke component="components/translater" method="get_translate_complex" returnVariable="txt_trainer">
                <cfinvokeargument name="id_translate" value="mail_trainer_removed_title">
                <cfinvokeargument name="lg_translate" value="#get_trainer.user_lang neq "" ? get_trainer.user_lang : 'en'#">
                <cfinvokeargument name="argv" value="#argv#">
            </cfinvoke>

            <cfinvoke component="api/email/email" method="send_simple_email">
                <cfinvokeargument name="to" value="#get_trainer.user_email#">
                <cfinvokeargument name="subject" value="[LMS] | Learner left | #_user#">
                <cfinvokeargument name="email_title" value="#txt_trainer#">
            </cfinvoke> --->

        <!--- </cfif> --->

        <cfreturn type>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>

    <cffunction name="updt_tplearner" access="remote" httpMethod="post" returnFormat="json" returntype="string" description="Update learners attached to a group TP">

        <cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">

        <cftry>

            <cfquery name="get_" datasource="#SESSION.BDDSOURCE#" result="data">
                SELECT tpuser_id, tpuser_active
                FROM lms_tpuser
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                LIMIT 1
            </cfquery>

            <cfif get_.recordCount eq 0>

                <cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_tpuser(user_id, tp_id) 
                    VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                    )
                </cfquery>

                <cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_lesson2_attendance(lesson_id, tp_id, user_id)
                    SELECT 
                    lesson_id,
                    tp_id,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                    FROM lms_lesson2 
                    WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                    AND status_id = 1
                </cfquery>

                <cfreturn 1>

            <cfelse>

                <cfquery name="up" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_tpuser SET
                    tpuser_active = NOT tpuser_active,
                    tpuser_modified = NOW()
                    WHERE tpuser_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_.tpuser_id#">
                </cfquery>

                <cfreturn 2>

            </cfif>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>

    </cffunction>

    <cffunction name="updt_tplearner_leader" access="remote" httpMethod="POST" returnFormat="json" returntype="string" output="false" description="Give leadership to learners attached to a group TP">

        <cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">

        <cfquery name="updt_tplearner_leader" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tpuser SET is_group_leader = IF(is_group_leader = 1, 0, 1)  WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
        </cfquery>

        <cfreturn t_id>

    </cffunction>

    <cffunction name="updt_quiz_ins" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update quiz attached to TP">

        <cfargument name="tp_quiz_id" type="numeric" required="yes">
        <cfargument name="q_id" type="numeric" required="yes">
		<cfargument name="type" type="string" required="yes">

        <cfif tp_quiz_id neq "" AND q_id neq "" AND type neq "">
        <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO lms_quiz_user_tp(tp_id, quiz_user_group_id, type) 
        VALUES (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_quiz_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#q_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            )
        </cfquery>
        </cfif>

        <cfreturn 1>

    </cffunction>


    <cffunction name="updt_quiz_delete" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update quiz attached to TP">

        <cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="type" type="string" required="yes">

        <cfif t_id neq "" AND type neq "">
        <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM lms_quiz_user_tp 
        WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
        AND type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        </cfquery>
        </cfif>

        <cfreturn 1>

    </cffunction>

    <cffunction name="updt_free_remain" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Generate Free Remain Tp from lesson list">

        <cfargument name="planner_id" type="numeric" required="yes" default="5373">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="tp_end_date" type="any" required="yes">
		<cfargument name="new_total_duration" type="numeric" required="yes">

        <cfif isDefined("l_nb") AND l_nb neq "" AND l_nb neq 0>

            <!--- CREATE NEW TP --->
            <cfquery name="insert_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp_id">
                INSERT INTO lms_tp SELECT
                NULL,
                user_id, 
                2, <!--- tp_status_id --->
                3, <!--- order_id --->
                formation_id, 
                tpmaster_id, 
                method_id, 
                level_id,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(tp_end_date,'yyyy-mm-dd', 'fr')#">, 
                <cfqueryparam cfsqltype="cf_sql_integer" value="#new_total_duration#">, 
                tp_rank, 
                tp_close, 
                tp_vip, 
                destination_id, 
                tp_note, 
                certif_id, 
                certif_token,
                certif_url, 
                certif_login, 
                certif_password, 
                techno_id, 
                elearning_id, 
                elearning_duration_old, 
                elearning_login, 
                elearning_password, 
                elearning_url, 
                token_id, 
                creator_id, 
                elearning_duration, 
                tp_formula_id, 
                tp_type_id, 
                tp_support_id, 
                tp_skill_id, 
                tp_interest_id, 
                tp_function_id, 
                tp_orientation_id, 
                tp_session_duration, 
                tp_max_participants,
                tp_group,
                tp_quiz_start_id, 
                tp_quiz_end_id, 
                tp_name, 
                tp_description,
                tp_level,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#t_id#">,
                tp_icon,
                tp_description_fr,
                tp_description_en,
                tp_description_de,
                tp_description_es,
                tp_description_it
                FROM lms_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>

            <!--- UPDATE OLD TP STATUS --->
            <cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_tp
                SET tp_status_id = 3
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>
            
            <!--- ATTRIBUTE NEW TP TO USER --->
            <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpuser
                (
                    user_id,
                    tp_id
                )
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">
                )
                </cfquery>

                <!--- ATTRIBUTE SAME TEACHER TO NEW TP --->
            <cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpplanner SELECT
                NULL,
                planner_id,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id, --->
                active,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">
                FROM lms_tpplanner WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>


            <!--- LOOP TROUGH UNDONE LESSON --->
            <cfloop from="1" to="#l_nb#" index="idx">

                <!--- <cftry> --->

                <cfif arguments["session_" & idx] neq "">

                    <!--- TRANSFERT SESSION --->
                    <cfquery name="insert_session" datasource="#SESSION.BDDSOURCE#" result="insert_session_id">
                        INSERT INTO lms_tpsession SELECT 
                        NULL, 
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id --->
                        sessionmaster_id, 
                        session_name, 
                        session_duration, 
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#idx#">, <!--- session_rank --->
                        session_close, 
                        method_id, 
                        cat_id, 
                        keyword_id, 
                        skill_id, 
                        expertise_id, 
                        grammar_id, 
                        level_id, 
                        mapping_id, 
                        origin_id,
                        voc_cat_id
                        FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["session_" & idx]#"> 
                    </cfquery>

                    <!--- <cfdump var="#arguments["lesson_" & idx]#"> --->

                    <!--- TRANSFERT ONGOING LESSON  --->
                    <cfif arguments["lesson_" & idx] neq "">

                        <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
                            UPDATE lms_lesson2 SET
                            session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_session_id.generatedkey#">,
                            tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">
                            WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["lesson_" & idx]#"> 
                        </cfquery>

                    </cfif>

                    <!--- FILL OLD TP LESSON BY COMPLETED ONE VIA FORM --->
                    <cfquery name="insert_lesson" datasource="#SESSION.BDDSOURCE#" result="insert_lesson_id">
                        INSERT INTO lms_lesson2(
                            `session_id`, 
                            `tp_id`, 
                            `method_id`, 
                            `status_id`, 
                            `user_id`, 
                            `planner_id`, 
                            `lesson_start`, 
                            `lesson_end`, 
                            `lesson_duration`, 
                            `lesson_ghost`, 
                            `lesson_remind_1d`, 
                            `lesson_remind_3h`, 
                            `lesson_remind_1h`, 
                            `lesson_remind_15m`, 
                            `booker_id`, 
                            `booker_date`, 
                            `completed_date`,
                            `lesson_launch`, 
                            `lesson_remind_sms_15m`, 
                            `lesson_signed`
                            ) 
                        VALUES (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["session_" & idx]#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                            1,
                            5,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#planner_id#">,
                            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#lsDateTimeFormat(arguments["time_" & idx],'yyyy-mm-dd HH:nn:ss', 'fr')#">,
                            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#lsDateTimeFormat(dateadd('n',arguments["dur_" & idx],arguments["time_" & idx]),'yyyy-mm-dd HH:nn:ss', 'fr')#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["dur_" & idx]#">,
                            1,
                            1,
                            1,
                            1,
                            1,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
                            <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                            <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                            1,
                            1,
                            1
                            )
                    </cfquery>

                    <cftry>

                        <!--- UPDATE OLD TP LESSON ATTENDANCE --->
                    <cfquery name="insert_attendance" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO lms_lesson2_attendance(
                            lesson_id, 
                            tp_id,
                            user_id, 
                            lesson_signed
                            ) 
                        VALUES (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_lesson_id.generatedkey#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                            1
                            )
                    </cfquery>
                    <cfcatch type="any">
                        Error attendance: <cfoutput>#cfcatch.message#</cfoutput>
                    </cfcatch>
                    </cftry> 
                
                </cfif>

                <!--- <cfcatch type="any">
                    Error: <cfoutput>#cfcatch.message#</cfoutput>
                </cfcatch>
                </cftry> --->
            </cfloop>

            <cftry>

                <!--- TRANSFERT QUIZZ TO NEW TP --->
                <cfquery name="update_lms_quiz_user_tp" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_quiz_user_tp SELECT
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id, --->
                    quiz_user_group_id,
                    `type`
                    FROM lms_quiz_user_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                </cfquery>

                <!--- GIVE FREE REMAIN ORDER ACCESS TO LEARNER TO SEE TP --->
                <cfquery name="insert_orders_users" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO `orders_users`(
                        `order_id`, 
                        `user_id`
                        ) 
                    VALUES (
                        3,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                        )
                </cfquery>
            <cfcatch type="any">
                Error quiz user: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
            </cftry>


        </cfif>

        <cfreturn 1>

    </cffunction>




    <cffunction name="updt_free_remain_migrate" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Generate Free Remain Tp from lesson list">

        <cfargument name="planner_id" type="numeric" required="yes" default="5373">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="t_id" type="numeric" required="yes">
		<cfargument name="tp_end_date" type="any" required="yes">
		<cfargument name="new_total_duration" type="numeric" required="yes">

        <cfif isDefined("l_nb") AND l_nb neq "" AND l_nb neq 0>

            <!--- CREATE NEW TP --->
            <cfquery name="insert_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp_id">
                INSERT INTO lms_tp SELECT
                NULL,
                user_id, 
                2, <!--- tp_status_id --->
                3, <!--- order_id --->
                formation_id, 
                tpmaster_id, 
                method_id, 
                level_id,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(tp_end_date,'yyyy-mm-dd', 'fr')#">, 
                <cfqueryparam cfsqltype="cf_sql_integer" value="#new_total_duration#">, 
                tp_rank, 
                tp_close, 
                tp_vip, 
                destination_id, 
                tp_note, 
                certif_id, 
                certif_token,
                certif_url, 
                certif_login, 
                certif_password, 
                techno_id, 
                elearning_id, 
                elearning_duration_old, 
                elearning_login, 
                elearning_password, 
                elearning_url, 
                token_id, 
                creator_id, 
                elearning_duration, 
                tp_formula_id, 
                tp_type_id, 
                tp_support_id, 
                tp_skill_id, 
                tp_interest_id, 
                tp_function_id, 
                tp_orientation_id, 
                tp_session_duration, 
                tp_max_participants,
                tp_group,
                tp_quiz_start_id, 
                tp_quiz_end_id, 
                tp_name, 
                tp_description,
                tp_level,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#t_id#">,
                tp_icon,
                tp_description_fr,
                tp_description_en,
                tp_description_de,
                tp_description_es,
                tp_description_it
                FROM lms_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>

            <!--- UPDATE OLD TP STATUS --->
            <!--- <cfquery name="updt_tp" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_tp
                SET tp_status_id = 3
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery> --->
            
            <!--- ATTRIBUTE NEW TP TO USER --->
            <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpuser
                (
                    user_id,
                    tp_id
                )
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">
                )
                </cfquery>

                <!--- ATTRIBUTE SAME TEACHER TO NEW TP --->
            <cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpplanner SELECT
                NULL,
                planner_id,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id, --->
                active,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">
                FROM lms_tpplanner WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>


            <!--- LOOP TROUGH UNDONE LESSON --->
            <cfloop from="1" to="#l_nb#" index="idx">

                <!--- <cftry> --->

                <cfif arguments["session_" & idx] neq "">

                    <!--- TRANSFERT SESSION --->
                    <cfquery name="insert_session" datasource="#SESSION.BDDSOURCE#" result="insert_session_id">
                        INSERT INTO lms_tpsession SELECT 
                        NULL, 
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id --->
                        sessionmaster_id, 
                        session_name, 
                        session_duration, 
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#idx#">, <!--- session_rank --->
                        session_close, 
                        method_id, 
                        cat_id, 
                        keyword_id, 
                        skill_id, 
                        expertise_id, 
                        grammar_id, 
                        level_id, 
                        mapping_id, 
                        origin_id,
                        voc_cat_id
                        FROM lms_tpsession WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["session_" & idx]#"> 
                    </cfquery>


                    <!--- TRANSFERT ONGOING LESSON  --->
                    <cfif arguments["lesson_" & idx] neq "">

                        <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
                            UPDATE lms_lesson2 SET
                            session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_session_id.generatedkey#">,
                            tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">
                            WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments["lesson_" & idx]#"> 
                        </cfquery>

                    </cfif>
                
                </cfif>

                <!--- <cfcatch type="any">
                    Error: <cfoutput>#cfcatch.message#</cfoutput>
                </cfcatch>
                </cftry> --->
            </cfloop>

            <cftry>

                <!--- TRANSFERT QUIZZ TO NEW TP --->
                <cfquery name="update_lms_quiz_user_tp" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_quiz_user_tp SELECT
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp_id.generatedkey#">, <!--- tp_id, --->
                    quiz_user_group_id,
                    `type`
                    FROM lms_quiz_user_tp WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                </cfquery>

                <!--- GIVE FREE REMAIN ORDER ACCESS TO LEARNER TO SEE TP --->
                <cfquery name="insert_orders_users" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO `orders_users`(
                        `order_id`, 
                        `user_id`
                        ) 
                    VALUES (
                        3,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                        )
                </cfquery>
            <cfcatch type="any">
                Error quiz user: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
            </cftry>


        </cfif>

        <cfreturn 1>

    </cffunction>


    <cffunction name="dup_virtual_class" access="remote" output="true" returntype="any" returnformat="plain">
	
		<cfargument name="t_id" type="numeric" required="yes">

		<cfquery name="insert_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp_id">
            INSERT INTO lms_tp SELECT
            NULL,
            user_id, 
            1, <!--- tp_status_id --->
            order_id,
            formation_id, 
            tpmaster_id, 
            method_id, 
            level_id,
            tp_date_start,
            tp_date_end, 
            tp_duration, 
            tp_rank, 
            tp_close, 
            tp_vip, 
            destination_id, 
            tp_note, 
            certif_id, 
            certif_token,
            certif_url, 
            certif_login, 
            certif_password, 
            techno_id, 
            elearning_id, 
            elearning_duration_old, 
            elearning_login, 
            elearning_password, 
            elearning_url, 
            token_id, 
            creator_id, 
            elearning_duration, 
            tp_formula_id, 
            tp_type_id, 
            tp_support_id, 
            tp_skill_id, 
            tp_interest_id, 
            tp_function_id, 
            tp_orientation_id, 
            tp_session_duration, 
            tp_max_participants,
            tp_group,
            tp_quiz_start_id, 
            tp_quiz_end_id, 
            tp_name, 
            tp_description,
            tp_level,
            NULL,
            tp_icon,
            tp_description_fr,
            tp_description_en,
            tp_description_de,
            tp_description_es,
            tp_description_it
            FROM lms_tp WHERE tp_id = #t_id#
        </cfquery>
    
    
        <cfquery name="insert_session" datasource="#SESSION.BDDSOURCE#" result="insert_session_id">
            INSERT INTO lms_tpsession SELECT
            NULL,
            #insert_tp_id.generatedkey#, 
            sessionmaster_id,
            session_name,
            session_duration, 
            session_rank, 
            session_close, 
            method_id,
            cat_id, 
            keyword_id, 
            skill_id, 
            expertise_id, 
            grammar_id, 
            level_id, 
            mapping_id, 
            origin_id,
            voc_cat_id
            FROM lms_tpsession WHERE tp_id = #t_id#
        </cfquery>
    
        <cfquery name="insert_planner" datasource="#SESSION.BDDSOURCE#" result="insert_planner_id">
            INSERT INTO lms_tpplanner SELECT
            NULL,
            planner_id,
            #insert_tp_id.generatedkey#, 
            active,
            now(),
            now()
            FROM lms_tpplanner WHERE tp_id = #t_id#
        </cfquery>

        <cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#" result="insert_user_id">
            INSERT INTO lms_tpuser SELECT
            NULL,
            user_id,
            #insert_tp_id.generatedkey#, 
            0,
            tpuser_active,
            now(),
            now()
            FROM lms_tpplanner WHERE tp_id = #t_id#
        </cfquery>
                

        <cfif fileexists("#SESSION.BO_ROOT#/assets/img_tp/#t_id#.jpg")>
            
            <cffile 
            action = "copy" 
            destination = "#SESSION.BO_ROOT#/assets/img_tp/#insert_tp_id.generatedkey#.jpg" 
            source = "#SESSION.BO_ROOT#/assets/img_tp/#t_id#.jpg">

        </cfif>
        

		<cfreturn "ok">
		
		
	</cffunction>

    <cffunction name="updt_rank" access="remote" output="true" returntype="any" returnformat="plain">
	
		<cfargument name="lesson_rank_table" type="any" required="yes">

		<cfoutput>
		<cfset counter = 0>
		
		<cfloop list="#lesson_rank_table#" index="cor">
        <cfset s_id = listgetat(cor,2,'_')>
		<cfset counter ++>
				
    	<cfquery name="update_lesson" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_tpsession SET session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#counter#"> WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
		</cfquery>

		</cfloop>
		
		</cfoutput>
		

		<cfreturn "ok">
		
		
	</cffunction>


    <cffunction name="cancel_tp" access="remote" output="true" returntype="any" returnformat="plain">
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="_status" type="string" required="no" default="cancel">
        <cfargument name="status_id" type="numeric" required="no" default="3">


        <!---- CHANGE LESSON STATUS ----->
        <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_lesson2
        SET
        status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#status_id#">,
        updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
        updater_date = now(),
        completed_date = now()
        WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
        </cfquery>

        <!--- GET ALL LEARNER + LESSON INFO --->
        <cfinvoke component="components/queries" method="oget_lesson" returnvariable="get_lesson">
            <cfinvokeargument name="l_id" value="#l_id#">
            <cfinvokeargument name="all_learner" value="1">
        </cfinvoke>

        <!--- GROUP BY FOR UPDATE, WE WANT THEM DONE ONLY ONCE --->
        <cfoutput query="get_lesson" group="lesson_id">
            <cfif get_lesson.method_id neq 10 >

            <!--- ADVERTISE CANCEL SPOT SCRIPT IN ASYNC --->
            <cfthread name="adv_cancel" action="run">
                <cfif get_lesson.lesson_start GT DateAdd("h",1,now()) AND get_lesson.lesson_start LT DateAdd("h",24,now())>
                    <cfinvoke component="api/tp/tp_post" method="advertise_canceled_spot">
                        <cfinvokeargument name="l_id" value="#get_lesson.lesson_id#">
                    </cfinvoke>
                </cfif>
            </cfthread>
                
            <!--- adaptin the status to match the one in the email set-up --->
            <cfif SESSION.USER_PROFILE eq "learner" AND _status eq "fcancel">
                <cfset status = "force_cancel_by_learner">
            <cfelseif SESSION.USER_PROFILE eq "trainer" AND _status eq "fcancel">
                <cfset status = "force_cancel_by_trainer">
            <cfelse>
                <cfset status = _status>
            </cfif>

            <!---------------------------- TRAINER EMAIL NOTIFICATION ----------------------->			
            <cfif get_lesson.trainer_remind_scheduled eq "1" OR _status eq "fcancel">

                <!--- subject translation --->
                <cfinvoke component="components/translater" method="get_translate" returnVariable="_subject">
                    <cfinvokeargument name="id_translate" value="email_status_subject_#_status#"><cfinvokeargument name="lg_translate" value="#get_lesson.trainer_lang#">
                </cfinvoke>
            
                <cfset subject = "[LMS] #_subject# #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                
                <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.trainer_email#" subject="#subject#" type="html" server="localhost">
                    <cfset lang = get_lesson.trainer_lang>
                    <!--- <cfset status = "cancel"> --->
                    <cfset recipient = "trainer">		
                    <cfinclude template="../../email/email_lesson_status.cfm">	
                </cfmail>

                <cfif SESSION.USER_PROFILE eq "trainer">

                    <!--- <cfmail from="WEFIT <service@wefitgroup.com>" to="krystina@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = get_lesson.trainer_lang>
                    <!--- <cfset status = "cancel"> --->
                    <cfset recipient = "trainer">		
                    <cfinclude template="../../email/email_lesson_status.cfm">	
                    </cfmail> --->
                
                </cfif>		
            
            </cfif>
            
            <!--------- LOOP TROUGH LEARNER --------->
            <cfoutput>
            <!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
            <cfif get_lesson.learner_remind_scheduled eq "1" OR _status eq "fcancel">

                <cfinvoke component="components/translater" method="get_translate" returnVariable="_subject">
                    <cfinvokeargument name="id_translate" value="email_status_subject_#_status#_learner"><cfinvokeargument name="lg_translate" value="#get_lesson.learner_lang#">
                </cfinvoke>
            
                <cfset subject = "WEFIT | #_subject# #get_lesson.trainer_firstname#">
                    
                <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
                    <cfset lang = get_lesson.learner_lang>
                    <!--- <cfset status = "cancel"> --->
                    <cfset recipient = "learner">		
                    <cfinclude template="../../email/email_lesson_status.cfm">	
                </cfmail>
                
            </cfif>
            </cfoutput>

            <!--- MAIL TO TEAM --->
            <cfif get_lesson.sessionmaster_id eq "695">
                
                <cfset subject = "[LMS] | Cancelled 1st Lesson | #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                
                <cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com,finance@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = "fr">
                    <!--- <cfset status = "cancel"> --->
                    <cfset recipient = "learner">
                    <cfinclude template="../../email/email_lesson_status.cfm">
                </cfmail>
            
            </cfif>
            
            <!--- call cancel tp from info passed from TP page --->
            <cfif status_id neq 4>
                <cfif SESSION.TP_CANCEL_PTA eq SESSION.TP_ID OR get_lesson.sessionmaster_id eq "694">
                    <cfinvoke component="api/tp/tp_post" method="cancel_tpa" returnvariable="res">
                        <cfinvokeargument name="l_id" value="#l_id#">
                        <cfinvokeargument name="status" value="#status#">
                        <cfinvokeargument name="sm" value="#get_lesson.sessionmaster_id#">
                    </cfinvoke>
                </cfif>
            </cfif>
            
            </cfif>

        </cfoutput>
		<cfreturn "ok">
	</cffunction>




    <cffunction name="cancel_tpa" access="remote" output="true" returntype="any" returnformat="plain">
        <cfargument name="l_id" type="numeric" required="no" default="0">
        <cfargument name="status" type="string" required="no" default="cancel">
        <cfargument name="sm" type="numeric" required="no" default="0">

        <cftry>
        <cfif SESSION.TP_CANCEL_PTA eq SESSION.TP_ID OR sm eq "694">
            
        <cfif l_id neq "0" AND l_id neq "">

            <!--- GET TPA OT THE TP FROM LESSON ID --->
            <cfquery name="get_pta_id" datasource="#SESSION.BDDSOURCE#" >
                SELECT ts.session_id, l2.lesson_id
                FROM lms_tpsession ts
                INNER JOIN lms_lesson2 l2 ON l2.session_id = ts.session_id
                WHERE ts.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.TP_ID#">
                <cfif sm eq "694">
                    AND l2.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                <cfelse>
                    AND ts.sessionmaster_id = 694
                    AND l2.status_id = 1
                </cfif>
                LIMIT 1
            </cfquery>


            <cfif get_pta_id.recordCount GT 0>
                
            <!--- GET ALL LEARNER + LESSON INFO --->
            <cfinvoke component="components/queries" method="oget_lesson" returnvariable="get_lesson">
                <cfinvokeargument name="l_id" value="#get_pta_id.lesson_id#">
                <cfinvokeargument name="all_learner" value="1">
            </cfinvoke>

            <!--- SET-UP VAR --->
            <cfset subject = "[LMS] | Cancelled PTA | #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
            <cfset _status_id = 3>

            <cfif get_lesson.recordCount GT 0>

            <cfoutput query="get_lesson" group="lesson_id">

                <cfif get_lesson.method_id neq 10 >
                <!--- CECK IF LATE CANCEL OR NOT --->
                <cfif status_id eq "1" AND lesson_start lt dateadd("h",+6,now())>
                    <cfset _status_id = 4>
                    <cfset subject = "[LMS] | Late PTA Cancellation | #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                </cfif>

                <!--- If the pta was the cancelled lesson the update was already done --->
                <cfif lesson_id neq l_id>
                    <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#" result="get_id">
                        UPDATE lms_lesson2
                        SET
                        status_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#_status_id#">,
                        updater_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
                        updater_date = now(),
                        completed_date = now()
                        WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lesson_id#">
                    </cfquery>
                </cfif>
                
                <cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com,finance@wefitgroup.com,krystina@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = "fr">
                    <cfset status = "#status#">
                    <cfset recipient = "learner">
                    <cfinclude template="../../email/email_lesson_status.cfm">
                </cfmail>

                <!--------- LOOP TROUGH LEARNER --------->
                <cfoutput>
                <!--------------------- INSERT TASK ----------------->	
                <cfinvoke component="api/task/task_post" method="insert_task">
                    <cfinvokeargument name="task_type_id" value="240">
                    <cfinvokeargument name="u_id" value="#get_lesson.learner_id#">
                    <cfinvokeargument name="task_channel_id" value="6">
                </cfinvoke>

                </cfoutput>

                </cfif>
            </cfoutput>

            </cfif>
            </cfif>

            <cfset SESSION.TP_CANCEL_PTA = 0>
            
        </cfif>

        </cfif>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>

		<cfreturn "ok">
		
		
	</cffunction>


    <cffunction name="updt_tplearner_attendance" access="remote" httpMethod="POST" returnFormat="json" returntype="string" output="false" description="Update learners attendance">

        <cfargument name="l_id" type="numeric" required="yes">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="att" type="numeric" required="yes">

        <cftry>

        <cfquery name="update_att" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_lesson2_attendance SET
            lesson_signed_trainer = <cfqueryparam cfsqltype="cf_sql_integer" value="#att#">
            WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>


        <cfreturn 1>

        <cfcatch type="any">
            Error learner attendance: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="update_tp_name" access="remote" httpMethod="POST" returnFormat="json" returntype="string" output="false" description="Update tp name">

        <cfargument name="t_id" type="numeric" required="yes">
        <cfargument name="tp_name" type="string" required="yes">

        <cftry>

        <cfquery name="update_att" datasource="#SESSION.BDDSOURCE#">
            UPDATE lms_tp SET
            tp_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#tp_name#">
            WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
        </cfquery>

        <cfreturn 1>

        <cfcatch type="any">
            Error upating tp name: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="speedbook_lesson" access="remote" httpMethod="POST" returnFormat="json" returntype="any" output="false">
        <cfargument name="t_id" type="numeric" required="yes">
        <cfargument name="p_id" type="numeric" required="yes">
        <cfargument name="u_id" type="numeric" required="no" default="#SESSION.USER_ID#">
        <cfargument name="rank" type="numeric" required="no" default="0">
        <cfargument name="date" type="string" required="yes">
        <cfargument name="hour" type="numeric" required="yes">
        <cfargument name="min" type="numeric" required="yes">
        <cfargument name="s_dur" type="numeric" required="yes">

        <!--- <cftry> --->

            <cfif listFindNoCase("TRAINER", SESSION.USER_PROFILE)>
                <cfif SESSION.USER_ID neq p_id>
                    <cfreturn 4>
                </cfif>
            </cfif>

            <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#" >
                SELECT l2.lesson_id, s.session_rank
                FROM lms_lesson2 l2 
                INNER JOIN lms_tpsession s ON s.session_id = l2.session_id
                WHERE l2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                AND l2.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                AND l2.lesson_start = <cfqueryparam cfsqltype="cf_sql_varchar" value="#date# #hour#:#min#">
                AND l2.status_id = 1
            </cfquery>

            <cfset start_format = "#date# #hour#:#min#:00">

            <cfif get_lesson.recordCount eq 0>

                <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#" >
                    SELECT s.session_id, s.session_rank, t.method_id, s.session_duration
                    FROM lms_tpsession s 
                    INNER JOIN lms_tp t ON s.tp_id = t.tp_id
                    LEFT JOIN lms_lesson2 l2 ON s.session_id = l2.session_id AND l2.status_id <> 3
                    WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                    AND l2.lesson_id IS NULL 
                    <cfif rank neq 0>
                        AND s.session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#rank#">
                    </cfif>
                    ORDER BY s.session_rank ASC
                    LIMIT 1
                </cfquery>

                <!--- IF THERE ARE NO MORE SPOT FOR LESSON TO FIT --->
                <cfif get_session.recordCount eq 0>
                    <cfreturn 3>
                </cfif>
                    
                <cfset end_format = "#dateadd('n',get_session.session_duration,start_format)#">

                <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#" result="new_lesson">
                INSERT INTO lms_lesson2
                (
                session_id,
                tp_id,
                user_id,
                lesson_start,
                lesson_end,
                lesson_duration,
                status_id,
                method_id,
                planner_id,
                booker_id,
                booker_date,
                lesson_pending
                )
                VALUES(
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.session_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#start_format#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#end_format#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.session_duration#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="1">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.method_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
                now(),
                <cfif isDefined("SESSION.CUR_STEP") AND (SESSION.CUR_STEP eq 3 OR SESSION.CUR_STEP eq 2)>1<cfelse>0</cfif>
                )
                </cfquery>

                <cfquery name="insert_attendance" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_lesson2_attendance(
                        lesson_id, 
                        tp_id,
                        user_id
                        ) 
                    VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_lesson.generatedkey#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                        )
                </cfquery>

                <!--- HERE TEST REDIRECT --->
                <cfif SESSION.USER_PROFILE eq "TEST">

                    <cfinvoke component="api/tp/tp_post" method="updt_tptrainer_add">
                        <cfinvokeargument name="t_id" value="#t_id#">
                        <cfinvokeargument name="u_id" value="#u_id#">
                        <cfinvokeargument name="p_id" value="#p_id#">
                        <cfinvokeargument name="interne" value="yes">
                    </cfinvoke>

                    <cfinvoke component="api/launching/launching_post" method="switch_user">
                        <cfinvokeargument name="t_id" value="#t_id#">
                    </cfinvoke>
                    
                    <cfreturn 4>
                </cfif>

                <cfif !isDefined("SESSION.CUR_STEP") OR SESSION.CUR_STEP neq 3>
                    <cfinvoke component="api/tp/tp_get" method="get_calendar_invite" returnvariable="_inv">
                        <cfinvokeargument name="l_id" value="#new_lesson.generatedkey#">
                    </cfinvoke>

                    <cfinvoke component="components/queries" method="oget_lesson" returnvariable="get_lesson">
                        <cfinvokeargument name="l_id" value="#new_lesson.generatedkey#">
                        <cfinvokeargument name="all_learner" value="1">
                    </cfinvoke>

                    <cfset _get_lesson = QueryGetRow(get_lesson, 1)>
                    <cfif _get_lesson.method_id neq 10 >
                        <cfoutput query="get_lesson" group="lesson_id">

                            <!---------------------------- TRAINER NOTIFICATION ----------------------->
                            <cfif get_lesson.trainer_remind_scheduled eq "1">

                                <!--- SUBJECT AND OPTION SET-UP --->
                            <cfif get_lesson.sessionmaster_id eq "695">

                                <cfif get_lesson.trainer_lang eq "fr">
                                    <cfset subject = "[LMS] Nouvel apprenant - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "en">
                                    <cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "de">
                                    <cfset subject = "[LMS] Neuer Schüler - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "es">
                                    <cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "it">
                                    <cfset subject = "[LMS] New learner - 1st lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                </cfif>

                                <cfset status = "na">

                            <cfelseif get_lesson.sessionmaster_id eq "694">
                                        
                                <cfif get_lesson.trainer_lang eq "fr">
                                    <cfset subject = "[LMS] Nouveau PTA planifié - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "en">
                                    <cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "de">
                                    <cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "es">
                                    <cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "it">
                                    <cfset subject = "[LMS] New PTA booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                </cfif>

                                <cfset status = "pta_booked">

                            <cfelse>
                                
                                <cfif get_lesson.trainer_lang eq "fr">
                                    <cfset subject = "[LMS] Nouveau cours planifié - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "en">
                                    <cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "de">
                                    <cfset subject = "[LMS] Neuer Kurs gebucht - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "es">
                                    <cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                <cfelseif get_lesson.trainer_lang eq "it">
                                    <cfset subject = "[LMS] New lesson booked - #get_lesson.learner_firstname# #get_lesson.learner_lastname#">
                                </cfif>

                                <cfset status = "confirm">

                            </cfif>

                            <!--- MAIL SENDER TRAINER --->
                            <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.trainer_email#" subject="#subject#" type="html" server="localhost">
                                <cfset lang = get_lesson.trainer_lang>
                                <!--- <cfset status = "pta_booked"> --->
                                <cfset recipient = "trainer">			
                                <cfinclude template="../../email/email_lesson_status.cfm">	
                                <cfmailparam type="text/calendar" file="#_inv#">
                            </cfmail>

                            </cfif>
                            <!--- TRAINER END --->

                            <cfoutput>
                                <cfif get_lesson.sessionmaster_id eq "695">
			
                                    <!-------------- UPDATE FOR SIGNING CHARTER ---------->
                                    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                                    UPDATE user 
                                    SET user_charter = 1
                                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.learner_id#">
                                    </cfquery>
                                    
                                    <!---------------------------- LEARNER NOTIFICATION ----------------------->
                                    <cfif get_lesson.learner_lang eq "fr">
                                        <cfset subject = "WEFIT | Réservation 1er cours avec #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "en">
                                        <cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "de">
                                        <cfset subject = "WEFIT | Die Buchung Ihres ersten Kurses mit #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "es">
                                        <cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "it">
                                        <cfset subject = "WEFIT | 1st booking with #get_lesson.trainer_firstname#">
                                    </cfif>
                                                    
                                    <cfset status = "na">
                                    <cfset tp_firstlesson = "&tp_firstlesson=1">
                        
                                    <!---------------------------- INSERT TASK ----------------------->			
                                    <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                                        <cfinvokeargument name="task_type_id" value="74">
                                        <cfinvokeargument name="u_id" value="#get_lesson.learner_id#">
                                        <cfinvokeargument name="task_channel_id" value="6">
                                    </cfinvoke>
                                        
                                <!-------------- IF BOOKING PTA ---------->
                                <cfelseif get_lesson.sessionmaster_id eq "694">
                                
                                    
                                    <!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
                                    <cfif get_lesson.learner_lang eq "fr">
                                        <cfset subject = "WEFIT | Confirmation réservation avec #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "en">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "de">
                                        <cfset subject = "WEFIT | Kurs mit #get_lesson.trainer_firstname# bestätigt">
                                    <cfelseif get_lesson.learner_lang eq "es">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "it">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    </cfif>
                                        
                                    <cfset status = "pta_booked">
                        
                                    <!---------------------------- CS EMAIL NOTIFICATION ----------------------->			
                                    <cfmail from="W-LMS <service@wefitgroup.com>" to="service@wefitgroup.com" subject="[LMS] New PTA booked" type="html" server="localhost">
                                        <cfset lang = "fr">
                                        <cfset status = "pta_booked">
                                        <cfset recipient = "trainer">
                                        <cfinclude template="../../email/email_lesson_status.cfm">	
                                        <cfmailparam type="text/calendar" file="#_inv#">	
                                    </cfmail>
                        
                                    <!---------------------------- INSERT TASK ----------------------->			
                                    <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                                        <cfinvokeargument name="task_type_id" value="37">
                                        <cfinvokeargument name="u_id" value="#get_lesson.learner_id#">
                                        <cfinvokeargument name="task_channel_id" value="6">
                                    </cfinvoke>
                                    
                                
                        
                                    
                                <!-------------- IF BOOKING REGULAR LESSON ---------->
                                <cfelse>
                                    
                                    <!---------------------------- LEARNER EMAIL NOTIFICATION ----------------------->
                                    <cfif get_lesson.learner_lang eq "fr">
                                        <cfset subject = "WEFIT | Confirmation réservation avec #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "en">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "de">
                                        <cfset subject = "WEFIT | Kurs bestätigt mit #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "es">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    <cfelseif get_lesson.learner_lang eq "it">
                                        <cfset subject = "WEFIT | Lesson confirmed with #get_lesson.trainer_firstname#">
                                    </cfif>
                                    
                                    <cfset status = "confirm">
                        
                                </cfif>

                                <cfif get_lesson.learner_remind_scheduled eq "1">	

                                    <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
                                        <cfset lang = get_lesson.learner_lang>
                                        <!--- <cfset status = "na"> --->
                                        <cfset recipient = "learner">			
                                        <cfinclude template="../../email/email_lesson_status.cfm">
                                        <cfmailparam type="text/calendar" file="#_inv#">	
                                    </cfmail>
                                </cfif>

                            </cfoutput>
                        </cfoutput>
                    </cfif>      
                </cfif>
                <!--- NOTIF END --->

                <cfif not structKeyExists(SESSION.booking_array, dateformat(start_format,'yyyy-mm-dd'))>
                    <cfset SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")] = [{
                        date: '#dateformat(start_format,"yyyy-mm-dd")#',
                        hour: '#timeformat(start_format,'HH')#',
                        min: '#timeformat(start_format,'mm')#',
                        id: p_id,
                        l_id: new_lesson.generatedkey
                    }]>
                <cfelse>


                    <cfset arrayAppend(SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")], {
                        date: '#dateformat(start_format,"yyyy-mm-dd")#',
                        hour: '#timeformat(start_format,'HH')#',
                        min: '#timeformat(start_format,'mm')#',
                        id: p_id,
                        l_id: new_lesson.generatedkey
                    })>

                    <cfscript>
                        arraySort(SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")], function (e1, e2){
                            return compare("#e1.hour#:#e1.min#", "#e2.hour#:#e2.min#");
                        });
                    </cfscript>

                    <!--- <cfdump var="#SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")]#"> --->
                </cfif>

                <cfset result = StructNew()>
                <cfset result['rk'] = get_session.session_rank>
                <cfset result['id'] = new_lesson.generatedkey>
                <!--- <cfset SESSION.booking_array = result> --->
                <cfset table_js = SerializeJSON(result)>

                <cfreturn table_js>

            <cfelse>

                <cfquery name="del_blocker" datasource="#SESSION.BDDSOURCE#">
                    DELETE FROM lms_lesson2
                    WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_lesson.lesson_id#">
                </cfquery>

                <cfquery name="del_blocker_att" datasource="#SESSION.BDDSOURCE#">
                    DELETE FROM lms_lesson2_attendance
                    WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_lesson.lesson_id#">
                    AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                </cfquery>


                <cfset arrayDelete(SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")], {
                    date: '#dateformat(start_format,"yyyy-mm-dd")#',
                    hour: '#timeformat(start_format,'HH')#',
                    min: '#timeformat(start_format,'mm')#',
                    id: p_id,
                    l_id: get_lesson.lesson_id
                })>

                <cfscript>
                    SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")]=ArrayFilter(SESSION.booking_array[dateformat(start_format,"yyyy-mm-dd")],function(item){
                          return item.l_id != get_lesson.lesson_id;
                    });
               </cfscript>

                <cfset result = StructNew()>
                <cfset result['rk'] = get_lesson.session_rank>
                <!--- <cfset SESSION.booking_array = result> --->
                <cfset table_js = SerializeJSON(result)>

                <cfreturn table_js>
                <!--- <cfreturn "{'rk':#get_session.session_rank#}"> --->
            </cfif>

        <!--- <cfcatch type="any">
            Error speedbook_lesson: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
    </cffunction>


    <cffunction name="speedbook_reorder_lesson" access="remote" httpMethod="POST" returnFormat="json" returntype="any" output="false">
        <cfargument name="t_id" type="numeric" required="yes">
        <cfargument name="u_id" type="numeric" required="no" default="#SESSION.USER_ID#">
        <cfargument name="l_list" type="string" required="yes">
        <cfargument name="r_list" type="string" required="yes">

        <!--- <cftry> --->
            <!--- <cfdump var="#l_list#">
            <cfdump var="#r_list#"> --->

            <cfset x = 1>
            <cfloop list="#l_list#" index="_l_id" delimiters=",">

                <cfset rk = trim(listGetAt(r_list, x))>

            <!--- </br>
                <cfdump var="#rk#">
            </br>

                <cfdump var="#x#">
            </br>
            <p>ici</p>
                <cfdump var="#_l_id#">
            </br> --->


                <cfquery name="get_session" datasource="#SESSION.BDDSOURCE#" >
                    SELECT s.session_id
                    FROM lms_tpsession s 
                    WHERE s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                    AND s.session_rank = <cfqueryparam cfsqltype="cf_sql_integer" value="#rk#">
                    LIMIT 1
                </cfquery>
                <cfdump var="#get_session#">


                <cfquery name="up_rk" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_lesson2 SET
                    session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.session_id#">
                    WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_l_id#">
                </cfquery>


                <cfset x = x + 1>

            </cfloop>

            <cfreturn 1>

        <!--- <cfcatch type="any">
            Error speedbook_lesson: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
    </cffunction>




    
    <cffunction name="advertise_canceled_spot" access="public" output="true" returntype="numeric">
        <cfargument name="l_id" type="numeric" required="yes">

        <cfquery name="get_lesson_adv" datasource="#SESSION.BDDSOURCE#">	
            SELECT l.lesson_id, l.lesson_start, l.lesson_duration, l.updater_date, l.planner_id, 
            u.user_firstname, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h,
            au.avail_id, au.group_name_fr, au.avail_name_fr
            FROM lms_lesson2 l
            INNER JOIN user u ON l.planner_id = u.user_id
            LEFT JOIN user_availability au ON DATE_FORMAT(l.lesson_start,'%a') = au.avail_day AND DATE_FORMAT(l.lesson_start,'%H:%i') BETWEEN au.hour_start AND au.hour_end
            WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            ORDER BY l.lesson_id DESC
        </cfquery>
    
    <!--- <cfdump var="#get_lesson_adv#">
    <cfdump var="#get_lesson_adv.user_send_late_canceled_6h eq 1#">
    <cfdump var="#get_lesson_adv.lesson_start LT DateAdd("h",6,now())#">
    <cfdump var="#get_lesson_adv.user_send_late_canceled_24h eq 1#">
    <cfdump var="#get_lesson_adv.lesson_start LT DateAdd("h",24,now())#">
    <cfdump var="#(get_lesson_adv.user_send_late_canceled_6h eq 1 AND get_lesson_adv.lesson_start LT DateAdd("h",6,now())) OR (get_lesson_adv.user_send_late_canceled_24h eq 1 AND get_lesson_adv.lesson_start LT DateAdd("h",24,now()))#"> --->


        <!--- <cfdump var="#get_lesson_adv#"> --->
        <cfif (get_lesson_adv.user_send_late_canceled_6h eq 1 AND get_lesson_adv.lesson_start LT DateAdd("h",6,now())) OR (get_lesson_adv.user_send_late_canceled_24h eq 1 AND get_lesson_adv.lesson_start LT DateAdd("h",24,now()))>

            
        <cfset day_int = lsDateTimeFormat(DateAdd("d",-7,now()),'yyyy-mm-dd HH:nn:ss', 'fr')>
        <!--- <cfdump var="#day_int#"> --->

        <!--- user_notification_late_canceled will need to be set to 1 --->
        <!---             AND u.user_notification_late_canceled = 1  --->
        <cfquery name="get_prof_learner" datasource="#SESSION.BDDSOURCE#">	
            SELECT DISTINCT u.user_id, u.user_lang, adv.canceled_adv_mail_sent
            FROM user u
            INNER JOIN lms_tpuser tu ON u.user_id = tu.user_id AND tpuser_active = 1
            INNER JOIN lms_tpplanner tpp ON tpp.tp_id = tu.tp_id AND active = 1
            INNER JOIN lms_tp t ON t.tp_id = tu.tp_id
            INNER JOIN lms_tpsession s ON s.tp_id = tu.tp_id
            LEFT JOIN lms_lesson2 l ON s.session_id = l.session_id AND l.status_id <> 3
            LEFT JOIN lms_lesson_canceled_adv adv ON adv.user_id = u.user_id AND adv.canceled_adv_mail_sent = 1 AND adv.canceled_adv_date < "#day_int#"
            WHERE tpp.planner_id = #get_lesson_adv.planner_id#
            AND l.lesson_id IS NULL
            AND u.user_status_id = 4
            AND t.tp_status_id = 2
            AND t.method_id = 1
            AND (s.sessionmaster_id != 695 AND s.sessionmaster_id != 694)
            AND s.session_duration <= #get_lesson_adv.lesson_duration#
            GROUP BY u.user_id
        </cfquery>

        <!--- ne marche pas + pas necessaire --->
        <!--- AND ((#get_lesson_adv.avail_id# IN (u.avail_id)) OR u.avail_id IS NULL) --->

        <cfset count = 0>

        <cfoutput query="get_prof_learner">

            <!--- <cfif count LT 30 AND get_prof_learner.canceled_adv_mail_sent eq ""> --->


            <!--- mail here / check the limit of mail sent and current number--->
            <!--- <cfset lang = get_prof_learner.user_lang> --->

            <!--- <cfmail from="WEFIT <service@wefitgroup.com>" to="amorisset@wefitgroup.com" bcc="amorisset@wefitgroup.com" subject="Offre Incroyable blbllblblbllblb" type="html" server="localhost">
                <cfinclude template="../../email/email_advertise_canceled_lesson.cfm">
            </cfmail> --->


            <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_lesson_canceled_adv
                (
                    lesson_id,
                    user_id,
                    canceled_adv_mail_sent
                )
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                    0
                )
            </cfquery>


            <!--- <cfset count = count + 1> 

            </cfif>--->
            <cfset count = count + 1> 
        </cfoutput> 

        <!--- MAIL CS --->
        <cfset lang = "fr">
        <cfset u_dest = "CS">
        <cfset cs = 1>

        <!--- trainer@wefitgroup.com --->
        <!--- <cfinclude template="../../email/email_advertise_canceled_lesson.cfm"> --->

        <cfmail from="WEFIT <service@wefitgroup.com>" to="trainer@wefitgroup.com"  bcc="amorisset@wefitgroup.com,rremacle@wefitgroup.com" subject="Cancelled lesson ADV - #get_lesson_adv.user_firstname#" type="html" server="localhost">
			<cfinclude template="../../email/email_advertise_canceled_lesson_cs.cfm">
		</cfmail>

        <br>mail sent 
        </cfif>

        <!--- TESTING --->
        <cfif count GT 0>
            <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_lesson_canceled_adv
                (
                    lesson_id,
                    user_id,
                    canceled_adv_mail_sent
                )
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="3892">,
                    0
                )
            </cfquery>
            <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_lesson_canceled_adv
                (
                    lesson_id,
                    user_id,
                    canceled_adv_mail_sent
                )
                VALUES(
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="22650">,
                    0
                )
            </cfquery>
        </cfif>
        
        <!---<cfset lang = "fr">

        <cfmail from="WEFIT <service@wefitgroup.com>" to="amorisset@wefitgroup.com" subject="Canceled lesson #get_lesson_adv.user_firstname#" type="html" server="localhost">
			<cfinclude template="../../email/email_advertise_canceled_lesson.cfm">
		</cfmail>

         <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_lesson_canceled_adv
            (
                lesson_id,
                user_id,
                canceled_adv_mail_sent
            )
            VALUES(
                <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="202">,
                0
            )
        </cfquery> --->
        <!--- TESTING --->

        <!--- <cfquery name="get_all_learner" datasource="#SESSION.BDDSOURCE#">	
            SELECT COUNT(DISTINCT u.user_id) as nb_user
            FROM user u
            INNER JOIN lms_tpuser tu ON u.user_id = tu.user_id AND tpuser_active = 1
            INNER JOIN lms_tp t ON t.tp_id = tu.tp_id
            INNER JOIN lms_tpsession ts ON ts.tp_id = tu.tp_id
            LEFT JOIN lms_lesson2 l ON ts.session_id = l.session_id
            WHERE l.lesson_id IS NULL
            AND ((#get_lesson_adv.avail_id# IN (u.avail_id)) OR u.avail_id IS NULL)
            AND u.user_status_id = 4
            AND t.tp_status_id = 2
        </cfquery>  --->

        <cfreturn 1>

    </cffunction>


    <cffunction name="send_adv_mail" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="user_list" type="any" required="no">
		<cfargument name="l_id" type="any" required="yes">

        <cftry>


            <cfloop list="#arguments["user_list[]"]#" item="user_id">

                <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">	
                    SELECT user_lang, user_firstname, user_email
                    FROM user
                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                </cfquery>

                <cfset lang = get_learner.user_lang>
                <cfset u_dest = get_learner.user_firstname>
                <cfmail from="WEFIT <service@wefitgroup.com>" to="amorisset@wefitgroup.com" bcc="krystina@wefitgroup.com,trainer@wefitgroup.com,rremacle@wefitgroup.com" subject="WEFIT - Ca vous tente ?" type="html" server="localhost">
                    <cfinclude template="../../email/email_advertise_canceled_lesson.cfm">
                </cfmail>


                <cfquery name="updt_user_adv" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_lesson_canceled_adv SET 
                    canceled_adv_mail_sent = 1 
                    WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                    AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                </cfquery>

            </cfloop>

            <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


    
    <cffunction name="rebook_canceled_spot" access="public" output="true" httpMethod="POST" returnFormat="json" returntype="any">
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="s_id" type="numeric" required="yes">
        <cfargument name="t_id" type="numeric" required="yes">
        <cfargument name="u_id" type="numeric" required="no" default="#SESSION.USER_ID#">

        <cfquery name="get_comfirm_late_lesson" datasource="#SESSION.BDDSOURCE#">
            SELECT canceled_adv_id, canceled_adv_date, canceled_adv_closed, canceled_adv_clicked, canceled_adv_new_lesson_id 
            FROM lms_lesson_canceled_adv 
            WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>

        <cfif get_comfirm_late_lesson.recordCount eq 0 OR get_comfirm_late_lesson.canceled_adv_closed eq 1>
            <cfreturn 2>
        <cfelseif get_comfirm_late_lesson.canceled_adv_closed eq 0>

            <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_lesson_canceled_adv SET 
                canceled_adv_closed = 1 
                WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            </cfquery>

            <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#" result="new_lesson">
                INSERT INTO lms_lesson2
                (
                session_id,
                tp_id,
                user_id,
                lesson_start,
                lesson_end,
                lesson_duration,
                status_id,
                method_id,
                planner_id,
                booker_id,
                booker_date
                )
                SELECT 
                <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                lesson_start,
                lesson_end,
                lesson_duration,
                1,
                method_id,
                planner_id,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                NOW(),
                lesson_pending
                FROM lms_lesson2
                WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
            </cfquery>

            <cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_lesson_canceled_adv SET 
                canceled_adv_new_lesson_id = #new_lesson.generatedkey#
                WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>

        </cfif>

        <cfreturn 1>

    </cffunction>

</cfcomponent>