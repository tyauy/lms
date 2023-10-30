<cfabort>
<cfset tochase = "2">
<cfset toreplace = "47">

<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_tpsessionmaster2 WHERE keyword_id IN (SELECT keyword_id FROM lms_keyword WHERE keyword_id = #tochase#)
</cfquery>


<cfoutput query="get_material">

    #sessionmaster_id#
<cfset old_list = keyword_id> 
<cfset new_list = listdeleteat(old_list,listfind(keyword_id,tochase))> 

old list = #old_list#
<br>
new list = #new_list#
<cfset new_list = listappend(new_list,toreplace)>
<br>
new new list = #new_list#


<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
    UPDATE lms_tpsessionmaster2 SET keyword_id = '#new_list#' WHERE sessionmaster_id = #sessionmaster_id#
</cfquery>


<br><br><br>

</cfoutput>