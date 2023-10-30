<cfabort>

<cfquery  name="select_qu" datasource="#SESSION.BDDSOURCE#">
    SELECT qu_id FROM `lms_quiz_cor` WHERE `quiz_id` = 981 ORDER BY `quiz_id` DESC
</cfquery>

<cfquery name="insert_quiz" datasource="#SESSION.BDDSOURCE#" result="insert_quiz_id">
    INSERT INTO lms_quiz SELECT
    NULL,
    CONCAT(quiz_name, " doublon 2"), 
    quiz_nbqu,
    module_id,
    sessionmaster_id, 
    quiz_score, 
    quiz_rank, 
    level_id,
    certif_id, 
    mapping_id, 
    quiz_type, 
    quiz_description, 
    quiz_alias, 
    quiz_analysis, 
    quiz_name_fr, 
    quiz_name_en,
    quiz_name_de, 
    quiz_name_es, 
    quiz_name_it, 
    quiz_description_fr, 
    quiz_description_en,
    quiz_description_es, 
    quiz_description_de, 
    quiz_description_it, 
    quiz_active, 
    quiz_formation_id,
    quiz_img,
    quiz_short_name_fr,
    quiz_short_name_en,
    quiz_short_name_es,
    quiz_short_name_de,
    quiz_short_name_it
    FROM lms_quiz WHERE quiz_id = 981
</cfquery>

<cfoutput query="select_qu">

    <cfdump var="#qu_id#"><br>

    <cfquery name="insert_question" datasource="#SESSION.BDDSOURCE#" result="insert_question_id">
        INSERT INTO lms_quiz_question SELECT
        NULL,
        sessionmaster_id, 
        qu_type,
        qu_category,
        qu_category_id, 
        qu_timer, 
        material_id, 
        qu_header,
        qu_header_en, 
        qu_header_fr, 
        qu_header_de, 
        qu_header_es, 
        qu_header_it, 
        qu_title, 
        qu_title_en, 
        qu_title_fr,
        qu_title_de, 
        qu_title_es, 
        qu_title_it, 
        qu_advise, 
        qu_advise_en,
        qu_advise_fr, 
        qu_advise_de, 
        qu_advise_es, 
        qu_advise_it, 
        qu_text,
        qu_text_fr,
        qu_text_en,
        qu_text_de,
        qu_text_es,
        qu_text_it,
        qu_text_temp,
        qu_header_temp,
        qu_category_temp,
        qu_updated_by,
        qu_updated_date,
        is_treated
        FROM lms_quiz_question WHERE qu_id = #qu_id#
    </cfquery>

    <cfquery name="insert_cor" datasource="#SESSION.BDDSOURCE#" result="insert_cor_id">
        INSERT INTO lms_quiz_cor SELECT
        NULL,
        #insert_quiz_id.generatedkey#, 
        #insert_question_id.generatedkey#,
        qu_ranking
        FROM lms_quiz_cor WHERE qu_id = #qu_id#
    </cfquery>


    <cfquery name="insert_answer" datasource="#SESSION.BDDSOURCE#" result="insert_answer_id">
        INSERT INTO lms_quiz_answer SELECT
        NULL,
        #insert_question_id.generatedkey#,
        sub_id,
        quiz_id,
        ans_iscorrect, 
        ans_type, 
        material_id, 
        ans_flag,
        ans_gain, 
        ans_text, 
        ans_text_fr, 
        ans_text_en, 
        ans_text_de, 
        ans_text_es, 
        ans_text_it
        FROM lms_quiz_answer WHERE qu_id = #qu_id#
    </cfquery>

    <cfquery name="insert_cor" datasource="#SESSION.BDDSOURCE#" result="insert_cor_id">
        INSERT INTO lms_quiz_question_mapping_cor SELECT
        NULL,
        #insert_question_id.generatedkey#,
        mapping_id,
        is_main
        FROM lms_quiz_question_mapping_cor WHERE qu_id = #qu_id#
    </cfquery>
</cfoutput>




<!--- <cfloop list="50738,49637,49639,49640,49641" index="cor">

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
 --->
