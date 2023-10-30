<cfset loginerror = 1>

<cftry>

<cfif !isDefined("SESSION.CO_GO_STATE")>
    <cfset SESSION.CO_GO_STATE = Rand()>
</cfif>

<cfoauth
    type = "Google"
    clientid = "684245052657-9r47kqevgjtqvv7proge8k3atpm3m6ne.apps.googleusercontent.com"
    secretkey = "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"
    scope = "email"
    result = "res"
    state = "#SESSION.CO_GO_STATE#"
    redirecturi = "#SESSION.BO_ROOT_URL#/connect_google.cfm" >

<!--- <cfdump var="#res#">
<cfdump var="#state#">
<br>session <br>
<cfdump var="#SESSION.CO_GO_STATE#">
<cfdump var="#ToString(SESSION.CO_GO_STATE) eq state#"> --->

<cfset SESSION.HIDDEN_NAME = "">

<cfif ToString(SESSION.CO_GO_STATE) eq state>
    <cfif isDefined("res.access_token") AND isDefined("res.id") AND isDefined("res.other.email")>

        <cfif isDefined("res.other.given_name") AND isDefined("res.other.family_name")>
            <cfset SESSION.HIDDEN_NAME = "#res.other.given_name# #res.other.family_name#">
        </cfif>


        <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
            SELECT u.user_id, sso.sso_id
            FROM user u
            LEFT JOIN user_sso sso ON u.user_id = sso.user_id AND sso.sso_name = "GOOGLE" AND sso.sso_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.id#">
            WHERE (u.user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.other.email#">
            OR sso.sso_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.id#">)
            LIMIT 1
        </cfquery>
        
        <!--- <cfdump var="#get_learner#"> --->

        <cfif get_learner.recordCount eq 1>

            <cfset loginerror = 0>
            <cfset structdelete(SESSION, "CO_GO_STATE")>

            <cfif isDefined("SESSION.USER_ID") AND SESSION.USER_ID eq get_learner.user_id>
                <cflocation addtoken="no" url="index.cfm">
            <cfelse>

                <cfset incl="1">
                <cfinclude template="connect_out.cfm">

                <cfif get_learner.sso_id eq "">
                    <cfquery name="up_learner" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO `user_sso` (`user_id`, `sso_name`, `sso_id`, `sso_user_name`) VALUES
                        (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_learner.user_id#">,
                            "GOOGLE",
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.id#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.HIDDEN_NAME#">
                        )
                    </cfquery>
                </cfif>
                

                <cfquery name="get_user" dataSource="#SESSION.BDDSOURCE#"> 
                    SELECT 
                    u.user_id, u.account_id, u.user_ismanager, u.user_status_id, u.user_type_id, u.timezone_id, u.contact_id, u.user_gender, u.user_firstname, u.user_name, u.user_alias, u.user_temp_alias, u.user_email, u.user_email_2, u.user_phone, u.user_phone_2, u.user_phone_code, u.user_phone_2_code, u.user_password, u.user_pwd_chg, u.user_create, u.user_color, u.user_css, u.user_lang, u.user_charter, u.situation_id, u.interest_id, u.function_id, u.business_id, u.method_id, u.speciality_id, u.country_id, u.avail_id, u.perso_id, u.expertise_id, u.techno_id, u.certif_id, u.user_jobtitle, u.user_birthday, u.user_based, u.user_adress, u.user_postal, u.user_city, u.user_company, u.user_school, u.user_adress_inv, u.user_postal_inv, u.user_city_inv, u.country_id_inv, u.user_news, u.user_needs, u.user_needs_course, u.user_needs_trainer, u.user_needs_frequency, u.user_needs_nbtrainer, u.user_needs_learn, u.user_needs_complement, u.user_needs_trainer_complement, u.user_needs_theme, u.user_needs_duration, u.user_needs_speaking_id, u.user_needs_expertise_id, u.user_remind_1d, u.user_remind_3h, u.user_remind_1h, u.user_remind_15m, u.user_remind_missed, u.user_remind_cancelled, u.user_remind_scheduled, u.user_notification_late_canceled, u.user_send_late_canceled_6h, u.user_send_late_canceled_24h, u.user_remind_sms_15m, u.user_remind_sms_missed, u.user_remind_sms_scheduled, u.user_hide_report_all, u.user_hide_report_free_remain, u.user_steps, u.user_level, u.user_access_tp, u.user_el_list, u.user_shortlist, u.user_elapsed, u.user_lastconnect, u.user_md5, u.user_blocker, u.user_visio_rate, u.user_f2f_rate, u.user_add_course, u.user_add_learner, u.user_paid_global, u.user_paid_missed, u.user_paid_tva, u.user_resume, u.user_video, u.user_video_link, u.user_signature, u.user_abstract, u.user_account_right_id, u.user_session_right_id, u.user_widget, u.user_pref_task_group, u.user_appointlet, u.user_ref, u.user_ref2, u.user_ctc_cpf, u.user_ctc_formation, u.user_optin, u.user_lst, u.user_lst_lock, u.user_qpt, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr, u.user_setup, u.user_gymglish_link, u.user_pt_mandatory,
                    up.*, 
                    tz.*, a.account_id, a.account_name, a.group_id, a.provider_id,
                    s.user_status_name_fr as user_status_name,
                    t.user_type_name_fr as user_type_name,
                    ac.contact_id
                    FROM user u
                    LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
                    LEFT JOIN user_type t ON t.user_type_id = u.user_type_id
                    INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
                    INNER JOIN user_profile up ON upc.profile_id = up.profile_id
                    LEFT JOIN account a ON a.account_id = u.account_id
                    LEFT JOIN settings_timezone tz ON tz.timezone_id = u.timezone_id
                    LEFT JOIN account_contact ac ON ac.user_id = u.user_id
                    WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_learner.user_id#">
                </cfquery> 

                    
                <cfset SESSION.USER_PROFILE_ID = get_user.profile_id>
                <cfset SESSION.USER_PROFILE = get_user.profile_name>
                <cfset SESSION.USER_PROFILE_CSS = get_user.profile_css>

                <!--- For Multi select --->
                <cfset SESSION.booking_array = {}>


                <cfinclude template="Application_vars.cfm">

                <cflocation addtoken="no" url="index.cfm">
            </cfif>

        <cfelse>

            <cfset SESSION.GOOGLE_ID = res.id>

            <cfset user_email = res.other.email>
            <cfset user_firstname = res.other.given_name>
            <cfset user_name = res.other.family_name>
            <cfif isDefined("res.gender")>
                <cfset user_gender = res.gender>
            </cfif>

            <cfset loginerror = 0>
            <cfset structdelete(SESSION, "CO_GO_STATE")>
            <cfinclude template="connect_validate.cfm">

        </cfif>
    </cfif>
</cfif>


    <!--- LINK USER TO GOOGLE --->
    <!--- <cfif ToString(SESSION.CO_GO_STATE) eq state>
        <cfif isDefined("res.access_token") AND isDefined("res.id") AND isDefined("res.other.email")>
            <cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
                SELECT u.user_id
                FROM user u
                WHERE u.user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.other.email#">
            </cfquery>

            <cfif get_learner.recordCount eq 1>
    
                <cfif isDefined("SESSION.USER_ID") AND SESSION.USER_ID eq get_learner.user_id>

                    <cfquery name="up_learner" datasource="#SESSION.BDDSOURCE#">
                        UPDATE user u SET
                        u.google_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#res.id#">
                        WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.USER_ID#">
                    </cfquery>

                </cfif>
        
            </cfif>

        </cfif>
    </cfif>

    <cfset structdelete(SESSION, "CO_GO_STATE")>
    <cflocation addtoken="no" url="index.cfm"> --->

<cfcatch type="any">
</cfcatch>
</cftry>



<cfif loginerror eq 1>
    <cfset structdelete(SESSION, "CO_GO_STATE")>
    <cfset error="4">
    <cflocation addtoken="no" url="connect_out.cfm?error=4">
</cfif>