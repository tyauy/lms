<cflock timeout="10">
		
    <!--- SET GLOBAL SESSION VARIABLES --->			
    <cfset SESSION.USER_ID = get_user.user_id>
    <cfset SESSION.PROFILE_ID = get_user.profile_id>
    <cfset SESSION.USER_GENDER = get_user.user_gender>
    <cfset SESSION.USER_NAME = "#get_user.user_firstname# #get_user.user_name#">
    <cfset SESSION.USER_FIRSTNAME = get_user.user_firstname>
    <cfset SESSION.USER_LASTNAME = get_user.user_name>
    <cfset SESSION.USER_PHONE = get_user.user_phone>
    <cfset SESSION.USER_PHONE_CODE = get_user.user_phone_code>
    <cfset SESSION.USER_PHONE_2 = get_user.user_phone>
    <cfset SESSION.USER_PHONE_2_CODE = get_user.user_phone_2_code>
    <cfset SESSION.USER_EMAIL = get_user.user_email>
    <cfset SESSION.USER_EMAIL_2 = get_user.user_email_2>
    <cfset SESSION.USER_ALIAS = get_user.user_alias>

    <cfset SESSION.USER_TIMEZONE = get_user.timezone_text>
    <cfset SESSION.USER_TIMEZONE_ID = get_user.timezone_id>
    <cfset SESSION.USER_TIMEZONE_LAG = get_user.timezone_lag>			
    <cfset SESSION.USER_LANG = get_user.user_lang>
    
    <cfset SESSION.USER_STATUS_ID = get_user.user_status_id>
    <cfset SESSION.USER_STATUS_NAME = get_user.user_status_name>
    <cfset SESSION.USER_TYPE_ID = get_user.user_type_id>
    <cfset SESSION.USER_TYPE_NAME = get_user.user_type_name>

    <cfset SESSION.USER_PWD_CHG = get_user.user_pwd_chg>
    
    <cfset SESSION.USER_CREATE = get_user.user_create>

    <cfset SESSION.LANG_CODE = get_user.user_lang>
    <cfset SESSION.ACCOUNT_ID = get_user.account_id>
    <cfset SESSION.ACCOUNT_NAME = get_user.account_name>
    <cfset SESSION.GROUP_ID = get_user.group_id>
    <cfset SESSION.USER_EL_LIST = get_user.user_el_list>
    <cfset SESSION.PROVIDER_ID = get_user.provider_id>
    <cfset SESSION.TP_ID = 0>
    <cfset SESSION.USER_ISMANAGER = 0>

    <cfset SESSION.AVAIL_ID = get_user.avail_id>
    <cfset SESSION.USER_BASED = get_user.user_based>
    <cfset SESSION.INTEREST_ID = get_user.interest_id>
    <cfset SESSION.FUNCTION_ID = get_user.function_id>
    <cfset SESSION.COUNTRY_ID = get_user.country_id>
    <cfset SESSION.METHOD_ID = get_user.method_id>
    <cfset SESSION.EXPERTISE_ID = get_user.expertise_id>
    <cfset SESSION.BUSINESS_ID = get_user.business_id>
    <cfset SESSION.TECHNO_ID = get_user.techno_id>	
    <cfset SESSION.USER_PT_MANDATORY = get_user.user_pt_mandatory>	
    
    <cfset SESSION.USER_REMIND_1D = get_user.user_remind_1d>
    <cfset SESSION.USER_REMIND_3H = get_user.user_remind_3h>
    <cfset SESSION.USER_REMIND_15m = get_user.user_remind_15m>
    <cfset SESSION.USER_REMIND_MISSED = get_user.user_remind_missed>
    <cfset SESSION.USER_REMIND_CANCELLED = get_user.user_remind_cancelled>
    <cfset SESSION.USER_REMIND_SCHEDULED = get_user.user_remind_scheduled>
    <cfset SESSION.USER_NOTIFICATION_LATE_CANCELED = get_user.user_notification_late_canceled>
    <cfset SESSION.USER_REMIND_SMS_15m = get_user.user_remind_sms_15m>
    <cfset SESSION.USER_REMIND_SMS_MISSED = get_user.user_remind_sms_missed>
    <cfset SESSION.USER_REMIND_SMS_SCHEDULED = get_user.user_remind_sms_scheduled>

    <cfset SESSION.USER_SHORTLIST = get_user.user_shortlist>
    <cfset SESSION.USER_EL_LIST = get_user.user_el_list>
    <cfset SESSION.USER_ELAPSED = get_user.user_elapsed>

    <cfset lvl_obj = {}>

    <cfquery name="get_levels" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_id, formation_code, level_id, level_code, level_sub_id, level_sub_code, level_verified
        FROM user_level
        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        AND skill_id = 0
    </cfquery>

    <cfoutput query="get_levels">
        <cfif !StructKeyExists(lvl_obj,formation_code)>
            <cfset lvl_obj[formation_code] = {
                'level_id' = level_id,
                'level_code' = level_code,
                'level_sub_id' = level_sub_id,
                'level_sub_code' = level_sub_code,
                'level_verified' = level_verified
            }>
        </cfif>
    </cfoutput>

    <cfset SESSION.USER_LEVEL = lvl_obj>


    <!--- SET OPTION FOR DASHBOARD --->
    <cfset SESSION.SELECTED_PROVIDER = "1,2,3">
    <cfset SESSION.SELECTED_MANAGER = "">
    <cfset SESSION.SELECTED_TYPE = "">

    <!--- SET DEFAULT LANGUAGE INTERFACE --->
    <cfswitch expression="#SESSION.LANG_CODE#">
        <cfcase value="fr"><cfset SESSION.LANG = "1"></cfcase>
        <cfcase value="en"><cfset SESSION.LANG = "2"></cfcase>
        <cfcase value="de"><cfset SESSION.LANG = "3"></cfcase>
        <cfcase value="es"><cfset SESSION.LANG = "4"></cfcase>
        <cfcase value="it"><cfset SESSION.LANG = "5"></cfcase>
    </cfswitch>
    
    <!--- UPDATE LAST CONNECT FOR TRACKING --->
    <cfquery name="updt_connect" dataSource="#SESSION.BDDSOURCE#"> 
    UPDATE user SET user_lastconnect = now() WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    </cfquery>


    <!--- GET PROFILE FOR BUILDING GATEWAYS IN TOP NAV --->
    <cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
    SELECT up.profile_name, up.profile_css, upc.profile_id, u.user_password, u.user_email
    FROM user_profile up 
    INNER JOIN user_profile_cor upc ON upc.profile_id = up.profile_id
    INNER JOIN user u ON u.user_id = upc.user_id
    WHERE upc.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    </cfquery>

    <cfset SESSION.PROFILE_LIST = get_profile>

    <cfset SESSION.PROFILE_LIST_NAME = "">

    <cfoutput query="get_profile">
        <cfset SESSION.PROFILE_LIST_NAME = SESSION.PROFILE_LIST_NAME & profile_name>
        <cfif currentrow neq recordcount>
            <cfset SESSION.PROFILE_LIST_NAME = SESSION.PROFILE_LIST_NAME & ",">
        </cfif>
    </cfoutput>

    <!--- LOG IP --->
    <cfquery name="updt_connect" dataSource="#SESSION.BDDSOURCE#"> 
    INSERT INTO user_log
    (
    user_id,
    ulog_ip,
    ulog_date
    )
    VALUES
    (
    <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#obj_function.getClientIp()#">,
    now()
    )
    </cfquery>

    <!--- GLOBAL VARIABLES DEPENDING ON PROFILES --->
    <cfif listFindNoCase("LEARNER,GUEST,TEST", SESSION.USER_PROFILE)>
                    
                    
        <!--- IF INACTIVE LEARNER, BOOT TO LOGIN --->
        <cfif get_user.user_status_id eq "5">
            <cfset incl="1">
            <cfset error="6">
            <cfinclude template="connect_out.cfm">
        </cfif>
        

        <!--- SCAN TRAINING PROGRAMS TO SET ACCESS --->
        <cfset get_tps_access = obj_tp_get.oget_tps(u_id="#SESSION.USER_ID#",st_id="1,2,10")>

        <cfset SESSION.LIST_ACCESS_EL = "">
        <cfset SESSION.ACCESS_VIRTUALCLASS_LANG = "">
        <cfset SESSION.ACCESS_EL = "0">
        <cfset SESSION.ACCESS_VISIO = "0">
        <cfset SESSION.ACCESS_F2F = "0">
        <cfset SESSION.ACCESS_VIRTUALCLASS = "0">
        <cfset SESSION.ACCESS_GROUP = "0">
        <cfset SESSION.ACCESS_CERTIF = "0">

        <cfoutput query="get_tps_access">				
            <cfif method_id eq "1">
                <cfset SESSION.ACCESS_VISIO = "1">
            <cfelseif method_id eq "2">
                <cfset SESSION.ACCESS_F2F = "1">
            <cfelseif method_id eq "3" AND elearning_id eq "1">
                <cfif tp_date_end gt now()>
                <cfset SESSION.LIST_ACCESS_EL = listappend(SESSION.LIST_ACCESS_EL,get_tps_access.formation_id)>
                <cfset SESSION.ACCESS_EL = "1">
                <cfset SESSION.ACCESS_VIRTUALCLASS = "1">
                <cfif !listFindNoCase(SESSION.ACCESS_VIRTUALCLASS_LANG,get_tps_access.formation_code)>
                    <cfset SESSION.ACCESS_VIRTUALCLASS_LANG = listappend(SESSION.ACCESS_VIRTUALCLASS_LANG,get_tps_access.formation_code)>
                </cfif>
                </cfif>
            <cfelseif method_id eq "3" AND elearning_id eq "2" AND tp_status_id neq "3">
                <cfif tp_date_end gt now()>
                <cfset SESSION.ACCESS_EL_7SPK = "1">
                </cfif>
            <cfelseif method_id eq "7">
                <cfset SESSION.ACCESS_CERTIF = "1">
            <!--- <cfelseif method_id eq "10">
                <cfset SESSION.ACCESS_VIRTUALCLASS = "1"> --->
            <cfelseif method_id eq "11">
                <cfset SESSION.ACCESS_GROUP = "1">
            </cfif>
        </cfoutput>

        <!--- SCAN SOLO CERTIF --->
        <cfset get_tps_certif = obj_tp_get.oget_tps(m_id="7",u_id="#SESSION.USER_ID#",st_id="1,2,6,10")>
        <cfoutput query="get_tps_certif">		
            <cfset SESSION.ACCESS_CERTIF = "1">
        </cfoutput>

        <cfset SESSION.STEPS = get_user.user_steps>
        <cfset SESSION.LAUNCH_GROUP = 0>
        
        <cfloop list="#SESSION.LIST_PT#" index="cor">
        <cfset "SESSION.USER_QPT_#cor#" = evaluate("get_user.user_qpt_#cor#")>
        <cfset "SESSION.USER_QPT_LOCK_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>	
        </cfloop>
        
        <cfset SESSION.USER_LST = get_user.user_lst>
        <cfset SESSION.USER_LST_LOCK = get_user.user_lst_lock>
                        
        <cfset SESSION.USER_ACCESS_TP = get_user.user_access_tp>

        
        <cfset SESSION.USER_NEEDS = get_user.user_needs_course>
        <cfset SESSION.USER_NEEDS_COURSE = get_user.user_needs_course>
        <cfset SESSION.USER_NEEDS_TRAINER = get_user.user_needs_trainer>
        <cfset SESSION.USER_NEEDS_NBTRAINER = get_user.user_needs_nbtrainer>
        <cfset SESSION.USER_NEEDS_FREQUENCY = get_user.user_needs_frequency>
        <cfset SESSION.USER_NEEDS_LEARN = get_user.user_needs_learn>
        <cfset SESSION.USER_NEEDS_COMPLEMENT = get_user.user_needs_complement>
        <cfset SESSION.USER_NEEDS_TRAINER_COMPLEMENT = get_user.user_needs_trainer_complement>
        <cfset SESSION.USER_NEEDS_THEME = get_user.user_needs_theme>			
        <cfset SESSION.USER_NEEDS_DURATION = get_user.user_needs_duration>
        <cfset SESSION.USER_NEEDS_SPEAKING_ID = get_user.user_needs_speaking_id>	
        <cfset SESSION.USER_NEEDS_EXPERTISE_ID = get_user.user_needs_expertise_id>
        
        <cfset SESSION.USER_JOBTITLE = get_user.user_jobtitle>				
        <cfset SESSION.USER_SETUP = get_user.user_setup>				
        <cfset SESSION.USER_CHARTER = get_user.user_charter>
        

        <cfset SESSION.USER_HIDE_REPORT_ALL = get_user.user_hide_report_all>
        <cfset SESSION.USER_HIDE_REPORT_FREE_REMAIN = get_user.user_hide_report_free_remain>


    <cfelseif SESSION.USER_PROFILE eq "trainer">
        
        <cfset SESSION.USER_BLOCKER = get_user.user_blocker>
        
        <cfset SESSION.ACCESS_EL = "1">
        <cfset SESSION.LIST_ACCESS_EL = "2,3">
        
        <cfset SESSION.USER_VIDEO_LINK = get_user.user_video_link>
        
        <cfloop list="#SESSION.LIST_PT#" index="cor">
        <cfset "SESSION.USER_QPT_#cor#" = evaluate("get_user.user_qpt_#cor#")>
        <cfset "SESSION.USER_QPT_LOCK_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>	
        </cfloop>
        
        <cfset SESSION.USER_LST = get_user.user_lst>
        <cfset SESSION.USER_LST_LOCK = get_user.user_lst_lock>

        <cfquery name="get_ops" dataSource="#SESSION.BDDSOURCE#"> 
            SELECT t.tp_id FROM lms_tpplanner p
            INNER JOIN  lms_tp t  ON t.tp_id = p.tp_id
            WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            AND t.method_id = 12 LIMIT 1
        </cfquery>

        <cfif get_ops.recordCount eq 1>
            <cfset SESSION.TRAINER_OPS_TP = get_ops.tp_id>
        </cfif>
        
    <cfelseif SESSION.USER_PROFILE eq "TM">
            
        <cfset SESSION.USER_ACCOUNT_RIGHT_ID = get_user.user_account_right_id>
        <cfset SESSION.AL_ID = get_user.user_account_right_id>
        <cfset SESSION.USER_WIDGET = get_user.user_widget>
        <cfset SESSION.CONTACT_ID = get_user.contact_id>

        <cfset SESSION.LIST_ACCESS_EL = "2,3">
        <cfset SESSION.ACCESS_EL = "1">
        <cfset SESSION.ACCESS_VISIO = "0">
        <cfset SESSION.ACCESS_F2F = "0">
        <cfset SESSION.ACCESS_VIRTUALCLASS = "1">
        <cfset SESSION.ACCESS_GROUP = "0">
        <cfset SESSION.ACCESS_CERTIF = "0">

        <cfif listFindNoCase(SESSION.PROFILE_LIST_NAME, "SchoolMNG")>
            <cfset SESSION.USER_SESSION_RIGHT_ID = get_user.user_session_right_id>
        </cfif>


        <cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
        SELECT group_id, provider_id FROM account a WHERE account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
        </cfquery>
        <cfset SESSION.GROUP_ID = get_group.group_id>
        <!--- <cfset SESSION.GROUP_NAME = get_group.group_name> --->

        <cfif get_group.provider_id eq 2>
            <cfset SESSION.ACCESS_VIRTUALCLASS_LANG = "DE">
        <cfelse>
            <cfset SESSION.ACCESS_VIRTUALCLASS_LANG = "EN">
        </cfif>
                        
        <cfquery name="get_price" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM account_group_price WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#"> 
        </cfquery>
        <cfif get_price.recordcount neq "0">
        <cfset SESSION.GROUP_PRICE_REDUCTION = get_price.price_reduction>
        <cfelse>
        <cfset SESSION.GROUP_PRICE_REDUCTION = 0>
        </cfif>				
        
        <cfquery name="get_learner_account" datasource="#SESSION.BDDSOURCE#">
        SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, a.account_id, a.account_name
        FROM user u
        INNER JOIN account a ON a.account_id = u.account_id
        INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	    INNER JOIN user_profile up ON upc.profile_id = up.profile_id
        WHERE u.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
        AND upc.profile_id = 3
        </cfquery>				
        <cfset SESSION.LIST_LEARNER_ACCOUNT = "">
        <cfoutput query="get_learner_account">
        <cfset SESSION.LIST_LEARNER_ACCOUNT = listappend(SESSION.LIST_LEARNER_ACCOUNT,user_id)>
        </cfoutput>

        <cfquery name="get_tp_group" datasource="#SESSION.BDDSOURCE#">
        SELECT t.tp_id FROM lms_tp t 
        INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
        INNER JOIN user u ON tpu.user_id = u.user_id
        WHERE u.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
        AND t.method_id = 11
        AND t.tp_status_id IN (1,2,3)
        GROUP BY t.tp_id
        </cfquery>
        <cfif get_tp_group.recordCount GT 0>
            <cfset SESSION.ACCESS_TPGROUP_LIST = "1">
        </cfif>


    <cfelseif SESSION.USER_PROFILE eq "PARTNER">
            
        <cfset SESSION.USER_ACCOUNT_RIGHT_ID = get_user.user_account_right_id>
        <cfset SESSION.AL_ID = get_user.user_account_right_id>
        <cfset SESSION.USER_WIDGET = get_user.user_widget>
        <cfset SESSION.CONTACT_ID = get_user.contact_id>

        <cfset SESSION.LIST_ACCESS_EL = "0">
        <cfset SESSION.ACCESS_EL = "0">
        <cfset SESSION.ACCESS_VISIO = "0">
        <cfset SESSION.ACCESS_F2F = "0">
        <cfset SESSION.ACCESS_VIRTUALCLASS = "0">
        <cfset SESSION.ACCESS_GROUP = "0">
        <cfset SESSION.ACCESS_CERTIF = "0">

        <cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
        SELECT group_id FROM account a WHERE account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
        </cfquery>
        <cfset SESSION.GROUP_ID = get_group.group_id>
        
        <cfquery name="get_learner_account" datasource="#SESSION.BDDSOURCE#">
        SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, a.account_id, a.account_name
        FROM user u
        INNER JOIN account a ON a.account_id = u.account_id
        INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	    INNER JOIN user_profile up ON upc.profile_id = up.profile_id
        WHERE u.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ACCOUNT_RIGHT_ID#">)
        AND upc.profile_id = 3
        </cfquery>				
        <cfset SESSION.LIST_LEARNER_ACCOUNT = "">
        <cfoutput query="get_learner_account">
        <cfset SESSION.LIST_LEARNER_ACCOUNT = listappend(SESSION.LIST_LEARNER_ACCOUNT,user_id)>
        </cfoutput>


        
    <cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

        <cfset SESSION.USER_PREF_TASK_GROUP = get_user.user_pref_task_group>
        <cfset SESSION.USER_ISMANAGER = get_user.user_ismanager>

        <cfset SESSION.ACCESS_VISIO = "1">
        <cfset SESSION.ACCESS_F2F = "1">
        <cfset SESSION.ACCESS_EL = "1">
        <cfset SESSION.LIST_ACCESS_EL = "2,3">				 
        <cfset SESSION.ACCESS_CERTIF = "1">
        <cfset SESSION.ACCESS_VIRTUALCLASS = "1">
        <cfset SESSION.ACCESS_VIRTUALCLASS_LANG = "EN,DE">
        <cfset SESSION.ACCESS_GROUP = "1">


    </cfif>
                
</cflock>