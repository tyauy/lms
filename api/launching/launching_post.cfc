<cfcomponent>
    
    <cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
    <cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
    <cfset obj_dater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.dater")>
           
       <cffunction name="updt_user" access="remote">
    
            <cfargument name="u_id" required="yes">
            <cfargument name="account_id" required="yes">
            <cfargument name="user_gender" required="yes">
            <cfargument name="user_lastname" required="yes">
            <cfargument name="user_phone" required="yes">
            <cfargument name="user_phone_code" required="yes">
    
            <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user 
            SET 
            account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
            user_gender = <cfif isdefined("user_gender") AND user_gender neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#"><cfelse>null</cfif>,
            user_firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
            user_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lastname#">,
            <cfif user_phone neq "">
                user_phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
                user_phone_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
            </cfif>
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>
    
       </cffunction>
    
       <cffunction name="insert_user" access="remote" httpMethod="post" returntype="any" returnformat="plain">
    
            <cfargument name="account_id" required="yes">
            <cfargument name="user_gender" required="yes">
            <cfargument name="user_lastname" required="yes">
            <cfargument name="user_phone" required="yes">
            <cfargument name="user_phone_code" required="yes">
    
            <cfargument name="tp_date_send" required="yes">
            <cfargument name="tp_date_start" required="yes">
            <cfargument name="tp_date_end" required="yes">
    
            <cfset user_pwd = RandRange(100000, 999999)>
    
            <cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#" result="ins_user">
            INSERT INTO user
            (
            account_id,
            timezone_id,
            user_gender,
            user_firstname,
            user_name,
            user_email,
            user_password,
            <cfif user_phone neq "">
                user_phone,
                user_phone_code,
            </cfif>
            user_create,
            user_lang,
            user_status_id,
            user_type_id,
            <cfif user_formula eq "en">user_qpt_en<cfelseif user_formula eq "es">user_qpt_es</cfif>,
            user_remind_1d,
            user_remind_3h
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
            6,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_lastname)#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
            <cfif user_phone neq "">
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
            </cfif>
            <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,			
            2,
            7,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_alias#">,
            1,
            1
            )
            </cfquery>
    
            <cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO user_profile_cor
            (
            user_id,
            profile_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#ins_user.generatedkey#">,
            3
            )
            </cfquery>
    
    
            <!------ CF TRICK FOR DATEPICKER -------------->
            <cfif day(tp_date_start) lte "12">
                <cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-dd-mm')#">
            <cfelse>
                <cfset tp_date_start = "#dateformat(tp_date_start,'yyyy-mm-dd')#">
            </cfif>	
    
            <cfif day(tp_date_end) lte "12">
                <cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-dd-mm')#">
            <cfelse>
                <cfset tp_date_end = "#dateformat(tp_date_end,'yyyy-mm-dd')#">
            </cfif>	
    
            <cfif day(tp_date_send) lte "12">
                <cfset tp_date_send = "#dateformat(tp_date_send,'yyyy-dd-mm')#">
            <cfelse>
                <cfset tp_date_send = "#dateformat(tp_date_send,'yyyy-mm-dd')#">
            </cfif>	
    
            
            <cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp">
            INSERT INTO lms_tp
            (
            user_id,
            tp_status_id,
            tp_date_start,
            tp_date_end,
            order_id,
    
            tp_duration,
            formation_id,
            method_id,
            tp_type_id,
            
            techno_id,            
            tp_rank,
            tp_vip,
            
            creator_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#ins_user.generatedkey#">,
            1,
            <cfqueryparam cfsqltype="cf_sql_date" value="#tp_date_start#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#tp_date_end#">,
            13863,
    
            600,
            <cfif user_formula eq "en">2,<cfelseif user_formula eq "es">4,</cfif>
            1,            
            4,
    
            3,
            1,
            0,
            
            <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            )
            </cfquery>
    
    
            <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpuser
            (
                user_id,
                tp_id
            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#ins_user.generatedkey#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
            )
            </cfquery>
    
        
            <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO orders_users
            (
                order_id,
                user_id
            ) 
            VALUES 
            (
                13863,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#ins_user.generatedkey#">
            )
            </cfquery>
    
    
            <!--- CREATE FIRST --->
            <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpsession
            (
            tp_id,
            sessionmaster_id,
            session_duration,
            session_rank,
            session_close,
            method_id,
            cat_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
            695,
            30,
            1,
            0,
            1,
            1
            );
            </cfquery>
    
            <cfloop from="2" to="19" index="cor">
    
            <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpsession
            (
            tp_id,
            sessionmaster_id,
            session_duration,
            session_rank,
            session_close,
            method_id,
            cat_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
            1267,
            30,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
            0,
            1,
            1
            );
            </cfquery>
    
            </cfloop>
    
            <!--- CREATE PTA --->
            <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpsession
            (
            tp_id,
            sessionmaster_id,
            session_duration,
            session_rank,
            session_close,
            method_id,
            cat_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
            694,
            30,
            20,
            0,
            1,
            1
            );
            </cfquery>
    
            <cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tps">
                <cfinvokeargument name="u_id" value="#ins_user.generatedkey#">
                <cfinvokeargument name="st_id" value="1">
            </cfinvoke>
    
            <cfinvoke component="api/task/task_post" method="insert_task">
                <cfinvokeargument name="task_type_id" value="49">
                <cfinvokeargument name="task_category" value="TO DO">
                <cfinvokeargument name="log_remind_ok" value="1">
                <cfinvokeargument name="log_remind" value="#tp_date_send#">
                <cfinvokeargument name="u_id" value="#ins_user.generatedkey#">
                <cfinvokeargument name="task_channel_id" value="6"></cfinvokeargument>
            </cfinvoke>
    
            <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                <cfinvokeargument name="u_id" value="#ins_user.generatedkey#">
            </cfinvoke>
    
    
            <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com" bcc="" subject="New learner Gymglish" type="html" server="localhost">
                New learner to come : <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#ins_user.generatedkey#">#get_user.user_firstname# #get_user.user_name#</a>
            </cfmail>
    
            <!--- <cfset flag_partner = "logo_gymglish.jpg">
                
            <cfif user_lang eq "fr">
                <cfset subject = "WEFIT | Votre formation linguistique est prête à démarrer">
            <cfelseif user_lang eq "en">
                <cfset subject = "WEFIT | Your training is ready to start">
            <cfelseif user_lang eq "de">
                <cfset subject = "WEFIT | Ihr Training kann beginnen">
            <cfelseif user_lang eq "es">
                <cfset subject = "WEFIT | Tu entrenamiento está listo para comenzar">
            <cfelseif user_lang eq "it">
                <cfset subject = "WEFIT | Your training is ready to start">
            </cfif>
            
            <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com" bcc="" subject="#subject#" type="html" server="localhost">
                <cfset new_formation = 1>
                <cfset send_reset = 1>
                
    
                <cfset lang = user_lang>
                <cfinclude template="../../email/email_new_formation.cfm">
            </cfmail> --->
            
        </cffunction>
    
    
    
    
        <cffunction name="attach_trainer" access="remote" httpMethod="post">
    
            <cfargument name="p_id" required="yes">
            <cfargument name="tp_id" required="yes">
    
            <cfquery name="del_planner" datasource="#SESSION.BDDSOURCE#">
            DELETE FROM lms_tpplanner WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
            </cfquery>
    
            <cfquery name="del_lesson" datasource="#SESSION.BDDSOURCE#">
            DELETE FROM lms_lesson2 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
            </cfquery>
    
            <cfquery name="del_attendance" datasource="#SESSION.BDDSOURCE#">
            DELETE FROM lms_lesson2_attendance WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
            </cfquery>
    
            <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpplanner
            (
                planner_id,
                tp_id,
                active
            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
                1
            )
            </cfquery>
    
            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
            SELECT user_id, user_gender, user_name, user_firstname, user_email, user_lang
            FROM user u
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            </cfquery>
    
            <cfquery name="get_planner" datasource="#SESSION.BDDSOURCE#">
            SELECT user_email, user_firstname, user_id
            FROM user u
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
            </cfquery>
    
            <cfset subject = "WEFIT | New Gymglish learner">
    
            <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_planner.user_email#" bcc="trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                <cfinclude template="../../email/email_new_learner.cfm">
            </cfmail>
    
    
            <cfreturn "ok">
    
    
        </cffunction>
    
        <cffunction name="switch_user" access="remote" httpMethod="post">
    
            <cfargument name="u_id" type="numeric" required="no" default="#SESSION.USER_ID#">
            <cfargument name="t_id" type="numeric" required="no" default="#SESSION.TP_ID#">
    
            <cfset obj_function = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.functions")>
    
            <cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
            UPDATE user SET user_status_id = 4 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>
            
            <cfset SESSION.USER_STATUS_ID = 4>
            <cfset SESSION.ACCESS_VISIO = 1>
    
            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
            SELECT user_gender, user_name, user_firstname, user_email, user_lang
            FROM user u
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>
    
            <cfquery name="get_lessons" datasource="#SESSION.BDDSOURCE#">
                SELECT l.lesson_id, l.lesson_start, l.lesson_end, l.planner_id, l.lesson_duration, u2.user_email, u2.user_firstname
                FROM lms_lesson2 l
                INNER JOIN user u2 ON u2.user_id = l.planner_id
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                AND l.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                AND lesson_pending = 1
                ORDER BY l.user_id,l.planner_id DESC
            </cfquery>


            <cfset lesson_total_list = "">

            <cfoutput query="get_lessons" group="planner_id">
    
                <cfset lesson_list = "">
    
                <cfoutput>
                    <cfset lesson_total_list = lesson_total_list & "<tr><td>#user_firstname# - #obj_function.get_dateformat(lesson_start)#</td><td>#lesson_duration# m</td></tr>">
                    <cfset lesson_list = lesson_list & "<tr><td>#obj_function.get_dateformat(lesson_start)#</td><td>#lesson_duration# m</td></tr>">
                </cfoutput>
            
                <cfset subject = "WEFIT | New learner & new lessons !">
    
                <!--- bcc="rremacle@wefitgroup.com,trainer@wefitgroup.com,service@wefitgroup.com" --->
                <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#"  subject="#subject#" type="html" server="localhost">
                    <cfinclude template="../../email/email_new_launch.cfm">
                </cfmail>
    
            </cfoutput>
    
            <cfquery name="up_pending" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_lesson2 SET
                lesson_pending = 0
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            </cfquery>
            
            <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                <cfinvokeargument name="task_type_id" value="74">
                <cfinvokeargument name="u_id" value="#u_id#">
                <cfinvokeargument name="task_channel_id" value="6">
            </cfinvoke>
            
            <cfset subject = "WEFIT | Lancement apprenant OK">
            <cfset lesson_list = lesson_total_list>

            <cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com" bcc="rremacle@wefitgroup.com,trainer@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                <cfinclude template="../../email/email_new_launch.cfm">
            </cfmail>
    
            <cfreturn SESSION.USER_STATUS_ID>
    
        </cffunction>
    
    
        <cffunction name="update_level" access="remote" httpMethod="post">
    
            <cfargument name="user_level" type="any" required="yes">
            <cfargument name="f_code" type="any" required="yes">
    
            <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                UPDATE user 
                SET user_qpt_#lcase(f_code)# =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">, 
                user_qpt_lock_#lcase(f_code)# = 0
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            </cfquery>
    
            <cftry>
                <!--- NEW INSERT LEVEL --->
                <cfquery name="get_f" datasource="#SESSION.BDDSOURCE#">
                    SELECT formation_id FROM lms_formation WHERE formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(f_code)#">
                </cfquery>
    
                <cfquery name="get_l" datasource="#SESSION.BDDSOURCE#">
                    SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_level#">
                </cfquery>
    
                <cfinvoke component="api/users/user_post" method="up_user_level">
                    <cfinvokeargument name="user_id" value="#SESSION.USER_ID#">
                    <cfinvokeargument name="skill_id" value="0">
                    <cfinvokeargument name="formation_id" value="#get_f.formation_id#">
                    <cfinvokeargument name="formation_code" value="#cor#">
                    <cfinvokeargument name="level_id" value="#get_l.level_id#">
                    <cfinvokeargument name="level_code" value="#evaluate("SESSION.USER_QPT_#ucase(cor)#")#">
                    <cfinvokeargument name="level_verified" value="1">
                </cfinvoke>
            <cfcatch type="any">
                updt_user_level: <cfoutput>#cfcatch.message#</cfoutput>
            </cfcatch>
            </cftry>
    
            
            <!----------- SET CORRECT QPT LEVEL -------------->
            <cfset "SESSION.USER_QPT_#ucase(f_code)#" = user_level>
            <cfset "SESSION.USER_QPT_#ucase(f_code)#_LOCK" = 0>
    
            <cfreturn "ok">
    
        </cffunction>  
    
    
    </cfcomponent>