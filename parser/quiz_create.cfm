<cfabort>

<cfset count1 = 0>
<cfloop from="238" to="277" index="qu_id">
<cfset count1++>

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_cor
(
quiz_id,
qu_id,
qu_ranking
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="8">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#count1#">
)
</cfquery>


</cfloop>




<cfset count2 = 0>
<cfloop from="278" to="317" index="qu_id">
<cfset count2++>

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_cor
(
quiz_id,
qu_id,
qu_ranking
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="9">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#count2#">
)
</cfquery>

</cfloop>





<cfset count3 = 0>
<cfloop from="318" to="337" index="qu_id">
<cfset count3++>

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_cor
(
quiz_id,
qu_id,
qu_ranking
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="10">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#count3#">
)
</cfquery>

</cfloop>





<cfset count4 = 0>
<cfloop from="238" to="337" index="qu_id">
<cfset count4++>

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_quiz_cor
(
quiz_id,
qu_id,
qu_ranking
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="17">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
<cfqueryparam cfsqltype="cf_sql_integer" value="#count4#">
)
</cfquery>

</cfloop>
