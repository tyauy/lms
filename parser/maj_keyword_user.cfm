<cfabort>
<cfset tochase = "32">
<cfset toreplace = "43">

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM user WHERE interest_id IN (SELECT keyword_id FROM lms_keyword WHERE keyword_id = #tochase#)
</cfquery>


<cfoutput query="get_user">

    #user_id#
<cfset old_list = interest_id> 
<cfset new_list = listdeleteat(old_list,listfind(interest_id,tochase))> 

old list = #old_list#
<br>
new list = #new_list#
<cfset new_list = listappend(new_list,toreplace)>
<br>
new new list = #new_list#


<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
    UPDATE user SET interest_id = '#new_list#' WHERE user_id = #user_id#
</cfquery>


<br><br><br>

</cfoutput>