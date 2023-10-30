
<cfabort>


<cfloop list="50738,49637,49639,49640,49641" index="cor">

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
        "2023-08-30",
        "2024-08-30", 
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
        FROM lms_tp WHERE tp_id = #cor#
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
        FROM lms_tpsession WHERE tp_id = #cor#
    </cfquery>

    <cfquery name="insert_planner" datasource="#SESSION.BDDSOURCE#" result="insert_planner_id">
        INSERT INTO lms_tpplanner SELECT
        NULL,
        planner_id,
        #insert_tp_id.generatedkey#, 
        active,
        now(),
        now()
        FROM lms_tpplanner WHERE tp_id = #cor#
    </cfquery>

</cfloop>

