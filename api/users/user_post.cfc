<cfcomponent displayname="user_post" hint="ColdFusion Component page for inserting or updating data for users">

    <cffunction name="insert_user" access="remote" returntype="any" output="false" description="insert user" returnformat="json">
        <cfargument name="user_email" type="string" required="yes">
        <cfargument name="user_email_2" type="string" required="no" default="">

        <cfargument name="user_pwd" type="string" required="no" default="">

        <cfargument name="account_id" type="numeric" required="yes">
        <!--- <cfargument name="profile_id" type="numeric" required="no" default="3"> --->
        <cfargument name="profile_cor_id" type="string" required="no" default="#profile_id#">

        <cfargument name="user_firstname" type="string" required="yes">
        <cfargument name="user_lastname" type="string" required="yes">

        <cfargument name="user_phone" type="string" required="yes">
        <cfargument name="user_phone_code" type="string" required="no" default="">
        <cfargument name="user_phone_2" type="string" required="no" default="">
        <cfargument name="user_phone_2_code" type="string" required="no" default="">

        <cfargument name="user_lang" type="string" required="no" default="fr">
        <cfargument name="user_status_id" type="numeric" required="no" default="2">
        <cfargument name="user_type_id" type="numeric" required="no" default="3">
        <cfargument name="user_gender" type="string" required="no" default="">
        <cfargument name="user_create_todo" type="numeric" required="no" default="0">
        <cfargument name="user_pt_mandatory" type="numeric" required="no" default="0">

        <cftry>
            
            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
                SELECT user_id, user_firstname, user_name FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
            </cfquery>

            <cfif get_user.recordCount GT 0>
                <!--- <cfreturn get_user.user_id> --->
                <cfreturn {'state':'already','user_id':'#get_user.user_id#','user_firstname':'#get_user.user_firstname#','user_name':'#ucase(get_user.user_name)#'}>

            <cfelse>

                <cfif not isDefined("user_pwd")>
                    <cfset user_pwd = RandRange(100000, 999999)>
                </cfif>
            
                <cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#" result="insert_user">
                INSERT INTO user
                (
                    account_id,
                    timezone_id,
                    user_gender,
                    user_firstname,
                    user_name,
                    user_email,
                    user_email_2,
                    user_password,
                    <cfif user_phone neq "">
                        user_phone,
                        user_phone_code,
                    </cfif>
                    <cfif user_phone_2 neq "">
                        user_phone_2,
                        user_phone_2_code,
                    </cfif>
                    user_create,
                    user_lang,
                    user_status_id,
                    user_type_id,
                    
                    user_pt_mandatory,
                    user_account_right_id,
                    user_remind_1d,
                    user_remind_3h,
                    user_remind_15m,
                    user_remind_missed,
                    user_remind_cancelled,
                    user_remind_scheduled
                )
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
                    6,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_lastname)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(user_email_2)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                    <cfif user_phone neq "">
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
                    </cfif>
                    <cfif user_phone_2 neq "">
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_2_code#">,
                    </cfif>
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,			
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_status_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#user_type_id#">,

                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_pt_mandatory#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
                    1,
                    1,
                    0,
                    1,
                    1,
                    1
                );
                </cfquery>

                <cfloop list="#profile_cor_id#" index="cor">
                    <cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO user_profile_cor
                        (
                            user_id,
                            profile_id
                        )
                        VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
                        )
                    </cfquery>
                </cfloop>

                <cfif user_create_todo eq 1>
                    <!--- create todo --->

                    <cfset todo_date = dateAdd('d',7,now())>

                    <cfif listFind(SESSION.HOLIDAY_LIST,todo_date) neq 0>
                        <!--- wkend --->
                        <cfset todo_date = dateAdd('d',1,now())>
                    </cfif>

                    <cfinvoke component="api/task/task_post" method="insert_task">
                        <cfinvokeargument name="task_type_id" value="271">
                        <cfinvokeargument name="task_category" value="TO DO">
                        <!--- <cfinvokeargument name="log_remind_ok" value="1"> --->
                        <cfinvokeargument name="log_remind" value="#lsdateformat(todo_date,'yyyy-mm-dd', 'fr')#">
                        <cfinvokeargument name="u_id" value="#user_id#">
                        <cfinvokeargument name="task_channel_id" value="6">
                    </cfinvoke>


                    <cfset todo_date = dateAdd('d',7,todo_date)>
                    <cfif listFind(SESSION.HOLIDAY_LIST,todo_date) neq 0>
                        <cfset todo_date = dateAdd('d',1,now())>
                    </cfif>

                    <cfinvoke component="api/task/task_post" method="insert_task">
                        <cfinvokeargument name="task_type_id" value="271">
                        <cfinvokeargument name="task_category" value="TO DO">
                        <!--- <cfinvokeargument name="log_remind_ok" value="1"> --->
                        <cfinvokeargument name="log_remind" value="#lsdateformat(todo_date,'yyyy-mm-dd', 'fr')#">
                        <cfinvokeargument name="u_id" value="#user_id#">
                        <cfinvokeargument name="task_channel_id" value="6">
                    </cfinvoke>
                </cfif>
        
                <cfreturn {'state':'created','user_id':'#insert_user.generatedkey#','user_firstname':'#user_firstname#','user_name':'#ucase(user_lastname)#'}>

            </cfif>
    
        <cfreturn 0>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>


    <cffunction name="insert_user_tm" access="remote" httpMethod="post" output="false" returntype="any" returnformat="plain">

        <cfargument name="account_id" required="yes">
        <cfargument name="user_gender" required="yes">
        <cfargument name="user_lastname" required="yes">
        <cfargument name="user_phone" required="yes">
        <cfargument name="user_phone_code" required="yes">
        <cfargument name="user_id" required="no">

        <cfargument name="tp_date_send" required="yes">
        <cfargument name="tp_date_start" required="yes">
        <cfargument name="tp_date_end" required="yes">
        <cfargument name="formation_id" required="yes">

        <cfargument name="tpmaster_id" required="no" default="0">
        <cfargument name="ins_tp" required="yes">
        <cfargument name="ins_learner" required="yes">
        <cfargument name="user_pt_mandatory" required="no" default="0">

        <cfif ins_learner eq 1>

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
                user_qpt_en,
                user_pt_mandatory,
                user_steps,
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
                3,
                8,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_alias#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_pt_mandatory#">,
                "1,2,3",
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
                9
                )
                </cfquery>

                <cfset user_id = ins_user.generatedkey>
        <cfelse>

            <!--- UPDATE --->
        </cfif>

        <cfif ins_tp eq 1>

            <cfif tpmaster_id neq 0>

                <cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
                    SELECT sm.sessionmaster_id, tc.sessionmaster_schedule_duration, tc.sessionmaster_rank, sm.sessionmaster_cat_id,
                    tp.tpmaster_lesson_duration
                    FROM lms_tpmaster2 tp
                    INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
                    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
                    WHERE tp.tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">
                </cfquery>
                <cfset module = queryGetRow(get_module, 1)>

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
            <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
            1,
            <cfqueryparam cfsqltype="cf_sql_date" value="#lsdateformat(tp_date_start,'yyyy-mm-dd', 'fr')#">,
            <cfqueryparam cfsqltype="cf_sql_date" value="#lsdateformat(tp_date_end,'yyyy-mm-dd', 'fr')#">,
            1,
    
            <cfif tpmaster_id neq 0>#module.tpmaster_lesson_duration#,<cfelse>0,</cfif>
            <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
            1,            
            6,
    
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
                <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
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
                
                1,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            )
            </cfquery>


            <cfif tpmaster_id neq 0>

                <cfoutput query="get_module">
                    <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO lms_tpsession 
                        (
                        tp_id,
                        sessionmaster_id,
                        session_duration,
                        session_rank,
                        method_id,
                        cat_id
                        )
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_schedule_duration#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_rank#">,
                        2,
                        1
                        )
                    </cfquery>		
                </cfoutput>

            </cfif>
                
            
        </cfif>

       

        <!--- <cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tps">
            <cfinvokeargument name="u_id" value="#user_id#">
            <cfinvokeargument name="st_id" value="1">
        </cfinvoke> --->

        <cfinvoke component="api/task/task_post" method="insert_task">
            <cfinvokeargument name="task_type_id" value="271">
            <cfinvokeargument name="task_category" value="FEEDBACK">
            <!--- <cfinvokeargument name="log_remind_ok" value="1">
            <cfinvokeargument name="log_remind" value="#lsdateformat(tp_date_send,'yyyy-mm-dd', 'fr')#"> --->
            <cfinvokeargument name="u_id" value="#user_id#">
            <cfinvokeargument name="task_channel_id" value="6">
        </cfinvoke>

        <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
            <cfinvokeargument name="u_id" value="#user_id#">
        </cfinvoke>


        <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com" bcc="amorisset@wefitgroup.com" subject="New learner From TM - #get_user.account_name#" type="html" server="localhost">
            New learner to come : <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#user_id#">#get_user.user_firstname# #get_user.user_name#</a>
        </cfmail>

        <!--- <cfset flag_partner = "logo_gymglish.jpg"> --->
			
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

        <cfset obj_translater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.translater")>
        <cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
        <cfset obj_dater = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.dater")>
        
        <cfinvoke component="api/tp/tp_get" method="oget_tps" returnvariable="get_tps">
            <cfinvokeargument name="u_id" value="#user_id#">
            <cfinvokeargument name="st_id" value="1">
        </cfinvoke>
        
        <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com" bcc="amorisset@wefitgroup.com" subject="#subject#" type="html" server="localhost">
            <cfset new_formation = 1>
            <cfset send_reset = 1>
            <cfset lang = user_lang>
            <cfinclude template="../../email/email_new_formation.cfm">
        </cfmail>
        
    </cffunction>


    <cffunction name="hide_user" access="remote" method="POST" returntype="numeric" description="hide user">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user_profile_cor SET profile_id = (profile_id * -1)
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
            AND (profile_id = 7 OR profile_id = -7)
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>

    <cffunction name="deactivate_user_tm" access="remote" method="POST" returntype="numeric">
        <cfargument name="u_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user SET user_status_id = 5
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>

    <cffunction name="update_search_criteria" access="remote" method="POST" returntype="string">
        <cfargument name="avail_id" type="any" required="no" default="">
        <cfargument name="speaking_criteria_id" type="any" required="no" default="">
        <cfargument name="user_needs_nbtrainer" type="any" required="no" default="">
        <cfargument name="u_id" type="any" required="yes">
        
        <!--- <cftry> --->
    
            <cfdump var="#arguments#">
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user SET 
            <cfif avail_id neq "">avail_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#avail_id#">,</cfif>
            <cfif speaking_criteria_id neq "">user_needs_speaking_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#speaking_criteria_id#">,</cfif>
            <cfif user_needs_nbtrainer neq "">user_needs_nbtrainer = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_needs_nbtrainer#">,</cfif>
            user_blocker = user_blocker
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>

        <cfif avail_id neq "">
            <cfset SESSION.AVAIL_ID = avail_id>
        </cfif>
        <cfif speaking_criteria_id neq "">
            <cfset SESSION.USER_NEEDS_SPEAKING_ID = speaking_criteria_id>	
        </cfif>
        <cfif user_needs_nbtrainer neq "">
            <cfset SESSION.USER_NEEDS_NBTRAINER = user_needs_nbtrainer>
        </cfif>
        
        <cfreturn 1>

        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
    
    
    </cffunction>


    <cffunction name="switch_user_hide_report" access="remote" method="POST" returntype="numeric">
        <cfargument name="u_id" type="numeric" required="yes">
        <cfargument name="all" type="numeric" required="no" default="0">
        <cfargument name="fr" type="numeric" required="no" default="0">

        <cftry>
    
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user SET 
            <cfif all eq 1>user_hide_report_all = NOT user_hide_report_all</cfif> 
            <cfif fr eq 1>user_hide_report_free_remain = NOT user_hide_report_free_remain</cfif> 
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    </cffunction>

    <cffunction name="updt_tmaccount_add" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update trainer attached to TP">
		<cfargument name="u_id" type="numeric" required="yes">
		<cfargument name="a_id" type="numeric" required="yes">

        <cftry>

        <!------- SCAN ALREADY ATTACHED Ts ------>
        <cfquery name="check_list" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_account_right_id FROM user u WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>

        <cfdump var="#check_list#">

        <cfset pos = listFindNoCase(check_list.user_account_right_id, a_id)>
        <cfdump var="#pos#">

        <cfif pos neq 0>

            DELETE
            <cfdump var="#check_list.user_account_right_id#">

            <cfset new_list = ListDeleteAt(check_list.user_account_right_id, pos)>
            <cfdump var="#new_list#">

            <!--- <cfset new_list = ListAppend(new_list, a_id)> --->
            <!--- <cfdump var="#new_list#"> --->

        <cfelse>

            <cfdump var="#listLen(check_list.user_account_right_id)#">

            <cfset new_list = ListAppend(check_list.user_account_right_id, a_id)>
            
        </cfif>
        
        <cfquery name="update_user" datasource="#SESSION.BDDSOURCE#">
            UPDATE user SET 
            user_account_right_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_list#">
            WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>


    <cffunction name="updt_send_access" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false" description="Update trainer attached to TP">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="is_partner" type="numeric" required="no" default="0">
		<cfargument name="is_sms" type="numeric" required="no" default="0">

        <cftry>

            <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
                SELECT user_gender, user_name, user_firstname, user_email, upc.profile_id, user_lang, user_session_right_id, user_account_right_id
                FROM user u
                INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
                INNER JOIN user_profile up ON upc.profile_id = up.profile_id
                WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                GROUP BY u.user_id
            </cfquery>
            
            <cfset user_gender = get_user.user_gender>
            <cfset user_firstname = get_user.user_firstname>
            <cfset user_lastname = get_user.user_name>
            <cfset user_email = get_user.user_email>
            <cfset user_pwd = RandRange(100000, 999999)>
            <cfset profile_id = get_user.profile_id>
            <cfset user_lang = get_user.user_lang>
        
            <cfquery name="updt_pwd" datasource="#SESSION.BDDSOURCE#">
                UPDATE user
                SET user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                user_pwd_chg = 0
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
            </cfquery>
                
            
            <cfif is_sms neq 0>
                <cfset subject = "WEFIT | Accès Gestionnaire | Certification LINGUASKILL">

                <cfif get_user.user_session_right_id eq "">
                    <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                        <cfinvokeargument name="user_session_right_id" value="#get_user.user_session_right_id#">
                    </cfinvoke>
                <cfelse>
                    <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                        <cfinvokeargument name="user_account_right_id" value="#get_user.user_account_right_id#">
                    </cfinvoke> 
                </cfif>


            <cfelse>
                <cfif user_lang eq "fr">
                    <cfset subject = "WEFIT | Votre compte Training Manager">
                <cfelseif user_lang eq "en">
                    <cfset subject = "WEFIT | Your Training Manager account">
                <cfelseif user_lang eq "de">
                    <cfset subject = "WEFIT | Your Training Manager account">
                <cfelseif user_lang eq "es">
                    <cfset subject = "WEFIT | Votre compte Training Manager">
                <cfelseif user_lang eq "it">
                    <cfset subject = "WEFIT | Votre compte Training Manager">
                </cfif>	            </cfif>
            
            <!---  <cfmail from="WEFIT <service@wefitgroup.com>" to="amorisset@wefitgroup.com" subject="#subject#" type="html" server="localhost"> --->
            <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com,mkouhail@wefitgroup.com,nmichel@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = user_lang>
                    <cfif is_partner neq 0>
                        <cfinclude template="../../email/email_new_partner.cfm">
                    <cfelseif is_sms neq 0>
                        <cfset user_pwd_chg = 0>
                        <cfinclude template="../../email/email_new_cm.cfm">
                    <cfelse>
                        <cfinclude template="../../email/email_new_tm.cfm">
                    </cfif>
            </cfmail>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>

    <cffunction name="up_user_level" access="public" output="false" returntype="numeric">
        <cfargument name="user_id" type="numeric" required="yes">
        <cfargument name="skill_id" type="numeric" required="no" default="0">
        <cfargument name="sub_skill_id" type="numeric" required="no" default="0">
        <cfargument name="formation_id" type="numeric" required="yes">
        <cfargument name="formation_code" type="string" required="yes">
        <cfargument name="level_id" type="numeric" required="no">
        <cfargument name="level_code" type="string" required="no">
        <cfargument name="level_sub_id" type="numeric" required="no">
        <cfargument name="level_sub_code" type="string" required="no">
        <cfargument name="level_verified" type="numeric" required="no" default="0">

        <cftry>

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT user_level_id FROM user_level 
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
                AND skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#skill_id#">
                AND sub_skill_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_skill_id#">
                AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">
                LIMIT 1
            </cfquery>


            <cfif select.recordcount eq 0>

                <cfquery name="insert_user_level" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO user_level (
                        user_id,
                        skill_id,
                        sub_skill_id,
                        formation_id, 
                        formation_code,
                        level_id,
                        level_code,
                        level_sub_id,
                        level_sub_code,
                        level_date,
                        level_verified
                        ) 
                    VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#skill_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_skill_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#formation_code#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_code#">,
                        <cfif isDefined("level_sub_id")><cfqueryparam cfsqltype="cf_sql_integer" value="#level_sub_id#"><cfelse>NULL</cfif>,
                        <cfif isDefined("level_sub_code")><cfqueryparam cfsqltype="cf_sql_varchar" value="#level_sub_code#"><cfelse>NULL</cfif>,
                        NOW(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_verified#">
                        )
                </cfquery>

                <cfset return_id = insert_res.generatedkey>
                
            <cfelse>

                <cfset return_id = select.user_level_id>

                <cftry>
                <cfquery name="insert_user_level_logs" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO user_level_logs SELECT
                    NULL,
                    user_id,
                    skill_id,
                    sub_skill_id,
                    formation_id, 
                    formation_code,
                    level_id,
                    level_code,
                    level_sub_id,
                    level_sub_code,
                    level_date,
                    level_verified
                    FROM user_level WHERE user_level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>

                <cfcatch type="any">
                    Error up_user_level: <cfoutput>#cfcatch.message#</cfoutput>
                </cfcatch>
                </cftry>
                

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE user_level SET
                    <cfif isDefined("level_id")> level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_id#">,</cfif>
                    <cfif isDefined("level_code")> level_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_code#">,</cfif>
                    <cfif isDefined("level_sub_id")> level_sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_sub_id#">,</cfif>
                    <cfif isDefined("level_sub_code")> level_sub_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level_sub_code#">,</cfif>
                    level_verified = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_verified#">,
                    level_date = NOW()
                    
                    WHERE user_level_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#return_id#">
                </cfquery>
                
            </cfif>

            <cfif !structKeyExists(SESSION.USER_LEVEL,formation_code)>
                <cfset SESSION.USER_LEVEL[formation_code] = {}>
            </cfif>
            
            <cfset SESSION.USER_LEVEL[formation_code].level_id = level_id>
            <cfset SESSION.USER_LEVEL[formation_code].level_code = level_code>
            <cfif isDefined("level_sub_id")><cfset SESSION.USER_LEVEL[formation_code].level_sub_id = level_sub_id></cfif>
            <cfif isDefined("level_sub_code")><cfset SESSION.USER_LEVEL[formation_code].level_sub_code = level_sub_code></cfif>
            <cfset SESSION.USER_LEVEL[formation_code].level_verified = level_verified>

        <cfreturn return_id>
        <cfcatch type="any">
            Error up_user_level: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="up_user_level_ln" access="remote" httpMethod="post" returnFormat="json" returntype="string" output="false">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfargument name="formation_id" type="numeric" required="yes">
		<cfargument name="level_sub_id" type="numeric" required="yes">
		<cfargument name="skill_id" type="numeric" required="yes">
        <cfargument name="sub_skill_id" type="numeric" required="no" default="0">
        <cftry>

            <cfquery name="get_info" datasource="#SESSION.BDDSOURCE#">
                SELECT l.level_id, l.level_alias, ls.level_sub_name, ls.level_sub_id,
                (SELECT formation_code FROM lms_formation WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">) as formation_code
                FROM lms_level_sub ls
                INNER JOIN lms_level l ON l.level_id = ls.level_id
                WHERE ls.level_sub_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#level_sub_id#">
            </cfquery>

            <!--- NEW INSERT LEVEL GLOBAL --->
			<cfinvoke component="api/users/user_post" method="up_user_level">
				<cfinvokeargument name="user_id" value="#user_id#">
				<cfinvokeargument name="skill_id" value="#skill_id#">
				<cfinvokeargument name="sub_skill_id" value="#sub_skill_id#">
				<cfinvokeargument name="formation_id" value="#formation_id#">
				<cfinvokeargument name="formation_code" value="#get_info.formation_code#">
				<cfinvokeargument name="level_id" value="#get_info.level_id#">
				<cfinvokeargument name="level_code" value="#get_info.level_alias#">
                <cfinvokeargument name="level_sub_id" value="#get_info.level_sub_id#">
				<cfinvokeargument name="level_sub_code" value="#get_info.level_sub_name#">
				<cfinvokeargument name="level_verified" value="1">
			</cfinvoke>
        
        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn cfcatch.message>
        </cfcatch>
        </cftry>

    </cffunction>

</cfcomponent>