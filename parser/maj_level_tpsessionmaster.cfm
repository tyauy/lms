<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(sm.sessionmaster_id) as sessionmaster_id, tm.tpmaster_level
FROM lms_tpsessionmaster2 sm
INNER JOIN lms_tpmastercor2 tpc ON tpc.sessionmaster_id = sm.sessionmaster_id
INNER JOIN lms_tpmaster2 tm ON tm.tpmaster_id = tpc.tpmaster_id
GROUP BY sessionmaster_id
</cfquery>



<cfoutput query="get_level">

    <cfif tpmaster_level eq "A0/A1/A2">
        <cfset level_id = "2">
    <cfelseif tpmaster_level eq "A1/A2">
        <cfset level_id = "2">
    <cfelseif tpmaster_level eq "A1">
        <cfset level_id = "1">
    <cfelseif tpmaster_level eq "A2">
        <cfset level_id = "2">
    <cfelseif tpmaster_level eq "B1">
        <cfset level_id = "3">
    <cfelseif tpmaster_level eq "B2">
        <cfset level_id = "4">
    <cfelseif tpmaster_level eq "B1/B2">
        <cfset level_id = "4">
    <cfelseif tpmaster_level eq "C1">
        <cfset level_id = "5">
    <cfelseif tpmaster_level eq "C1/C2">
        <cfset level_id = "5">
    <cfelse>
        <cfset level_id = "">
    </cfif>
    <cfif level_id neq "">
    <cfquery name="updt_lesson" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_tpsessionmaster2 SET level_id = #level_id# WHERE sessionmaster_id = #sessionmaster_id#
    </cfquery>
    </cfif>
    <br>
</cfoutput>