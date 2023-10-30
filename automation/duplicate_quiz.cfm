<cfabort>

<cfset quiz_to_duplicate = "3">

<!---- DUPLICATE MASTER QUIZ --->
<cfquery name="duplicate_quiz" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz
(
quiz_name,
quiz_nbqu,
module_id,
sessionmaster_id,
quiz_score,
quiz_type,
quiz_description,
quiz_rank,
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
quiz_formation_id
)

SELECT 
quiz_name,
quiz_nbqu,
module_id,
sessionmaster_id,
quiz_score,
quiz_type,
quiz_description,
quiz_rank,
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
quiz_formation_id
FROM lms_quiz
WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_to_duplicate#">
</cfquery>




<!---- GET MAX QUIZ --->
<cfquery name="get_maxid_quiz" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(quiz_id) AS id FROM lms_quiz
</cfquery>

<!---- GET EXISTING QUESTIONS --->
<cfquery name="get_question_cor" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz_cor WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_to_duplicate#"> ORDER BY qu_ranking
</cfquery>


<!---- RECREATE THEM QUESTIONS --->
<cfoutput query="get_question_cor">
<cfif qu_ranking gt 30>

<cfquery name="duplicate_question_cor" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_question
(
sessionmaster_id,
qu_type,
qu_category,
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
qu_header_temp
)
SELECT 
sessionmaster_id,
qu_type,
qu_category,
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
qu_header_temp
FROM lms_quiz_question WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_question_cor.qu_id#">
</cfquery>

<cfquery name="get_maxid_qu" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(qu_id) AS id FROM lms_quiz_question
</cfquery>

<!-----RECREATE RANKING ------>
<cfquery name="insert_ranking" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_cor
(
quiz_id,
qu_id,
qu_ranking
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_maxid_quiz.id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_maxid_qu.id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_question_cor.qu_ranking#">
)
</cfquery>


<!-----GET ANSWERS ------>
<cfquery name="get_answers" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_quiz_answer WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_question_cor.qu_id#">
</cfquery>

<cfloop query="get_answers">
<cfquery name="duplicate_answer" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_answer
(
qu_id,
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
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_maxid_qu.id#">,
#get_answers.sub_id#,
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_maxid_quiz.id#">,
#get_answers.ans_iscorrect#,
'#get_answers.ans_type#',
<cfif get_answers.material_id neq "">#get_answers.material_id#<cfelse>null</cfif>,
'#get_answers.ans_flag#',
#get_answers.ans_gain#,
'#get_answers.ans_text#',
'#get_answers.ans_text_fr#',
'#get_answers.ans_text_en#',
'#get_answers.ans_text_de#',
'#get_answers.ans_text_es#',
'#get_answers.ans_text_it#'
)
</cfquery>
</cfloop>

</cfif>
</cfoutput>







