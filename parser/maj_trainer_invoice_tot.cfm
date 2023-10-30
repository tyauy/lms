<cfabort>

<cfsetting requestTimeOut = "9000" />


<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
    SELECT user_id, user_firstname, user_name FROM user u
    WHERE profile_id = 4
    AND user_paid_global = 1
    ORDER BY user_firstname
</cfquery>


<cfoutput query="get_trainers">

    <p>#user_firstname# #user_name# <br></p>

    <cfquery name="get_total" datasource="#SESSION.BDDSOURCE#">
        SELECT SUM(l.lesson_duration) as total_dur, SUM( (pricing_amount * (l.lesson_duration / 60) )) as amount_total, 
        pricing_amount, f.formation_code,
        DATE_FORMAT(l.completed_date, "%Y-%m") as _date,
        u.user_id as planner_id, u.user_firstname as planner_firstname, u.user_name, u.user_email, u.user_lang
        FROM lms_lesson2 l
        INNER JOIN lms_tpsession s ON s.session_id = l.session_id
        INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
        INNER JOIN lms_tp tp ON tp.tp_id = l.tp_id
        INNER JOIN lms_formation f ON f.formation_id = tp.formation_id
        INNER JOIN user u ON u.user_id = l.planner_id
        INNER JOIN user_pricing uprice ON uprice.user_id = u.user_id 
        AND uprice.formation_id = tp.formation_id
        AND uprice.pricing_cat = sm.sessionmaster_cat_id
        AND uprice.pricing_method = l.method_id

        WHERE l.user_id IS NOT NULL AND l.planner_id IS NOT NULL AND l.session_id IS NOT NULL AND l.blocker_id IS NULL

        AND (lesson_ghost != 1 OR lesson_ghost IS NULL)

        AND ( l.status_id = 5 OR (l.status_id = 4 AND u.user_paid_missed = 1))

        AND l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">

        GROUP BY l.planner_id, _date
        ORDER BY `_date` ASC
    </cfquery>

    <cfloop query="get_total">

        <cfquery name="insert_trainer_invoice_info" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO user_invoice_info(
                user_invoice_info_user, 
                user_invoice_info_selector,
                user_invoice_info_amount,
                user_invoice_info_duration
                ) 
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#get_total.planner_id#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_total._date#">,
                <cfqueryparam cfsqltype="cf_sql_float" value="#get_total.amount_total#">,
                <cfqueryparam cfsqltype="cf_sql_float" value="#get_total.total_dur#">
                )
            ON DUPLICATE KEY UPDATE 
            user_invoice_info_amount = <cfqueryparam cfsqltype="cf_sql_float" value="#get_total.amount_total#">,
            user_invoice_info_duration = <cfqueryparam cfsqltype="cf_sql_float" value="#get_total.total_dur#">,
            user_invoice_info_modified = NOW()
        </cfquery>
        
    </cfloop>

</cfoutput>