<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>


<cfif get_tp.tp_interest_id neq "">
<cfquery name="get_interest" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#get_tp.tp_interest_id#)
</cfquery>
<h6>Interests</h6>
<ul>
<cfoutput query="get_interest">
<li>#keyword_name#</li>
</cfoutput>
</ul>
</cfif>



<cfif get_tp.tp_function_id neq "">
<cfquery name="get_function" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#get_tp.tp_function_id#)
</cfquery>
<h6>Business Skills</h6>
<ul>
<cfoutput query="get_function">
<li>#keyword_name#</li>
</cfoutput>
</ul>
</cfif>