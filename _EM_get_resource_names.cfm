<cfparam name="URL.type" default="resource">
<cfparam name="URL.mapping_id" default="0">


<cfif URL.type EQ "resource">

  <cfquery name="get_mapping_resources" datasource="#SESSION.BDDSOURCE#">
    SELECT DISTINCT sm.sessionmaster_id, sm.sessionmaster_name
    FROM lms_mapping map
    INNER JOIN lms_grammar_mapping_cor cor
        ON map.mapping_id = cor.lms_mapping_id
    INNER JOIN lms_tpsessionmaster2 sm 
        ON cor.lms_grammar_id = sm.grammar_id
    INNER JOIN lms_tpmastercor2 tpm 
        ON tpm.sessionmaster_id=sm.sessionmaster_id
    INNER JOIN lms_tpmaster2 tm 
        ON tpm.tpmaster_id=tm.tpmaster_id
    WHERE map.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#URL.mapping_id#">
        AND sm.sessionmaster_online_visio = 1
        AND tm.tpmaster_id IN (11,12,13,14)
    ORDER BY sm.sessionmaster_name
</cfquery>

      
   <cfoutput query="get_mapping_resources">
    <a href="db_syllabus_edit.cfm?sm_id=#sessionmaster_id#">#sessionmaster_name#</a><br>
  </cfoutput>
<cfelseif URL.type EQ "quiz">
  
    <cfquery name="get_quiz_mapping" datasource="#SESSION.BDDSOURCE#">
        SELECT combined_results.quiz_id, combined_results.quiz_name
        FROM (
            (
                SELECT lq.quiz_id, lq.quiz_name
                FROM lms_quiz lq
                INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = lq.sessionmaster_id
                JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
                JOIN lms_tpmaster2 tm ON tpm.tpmaster_id = tm.tpmaster_id
                INNER JOIN lms_grammar_mapping_cor cor ON cor.lms_grammar_id = sm.grammar_id
                WHERE cor.lms_mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
                AND tm.tpmaster_id IN (11, 12, 13, 14)
            )
            UNION
            (
                SELECT lq.quiz_id, lq.quiz_name
                FROM lms_quiz lq
                JOIN lms_quiz_mapping_cor cor ON cor.quiz_id = lq.quiz_id
                WHERE cor.mapping_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#mapping_id#">
            )
        ) AS combined_results
        ORDER BY combined_results.quiz_name
    </cfquery>
    <cfoutput query="get_quiz_mapping">
        <a href="db_quiz_edit.cfm?quiz_id=#quiz_id#">#quiz_name#</a><br>
    </cfoutput>
    
    
</cfif>


