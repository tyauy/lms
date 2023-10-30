<cfabort>
<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user
</cfquery>

<cfoutput query="get_user">


<cfquery name="get_user_temp" datasource="lms-1-08012020">
SELECT user_id, user_phone FROM user WHERE user_id = #user_id#
</cfquery>

<cfif get_user_temp.recordcount neq "0">
#get_user.user_id# // #get_user_temp.user_id#
<br>
#get_user.user_phone# // #get_user_temp.user_phone#
<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#"> --->
<!--- UPDATE user SET user_phone = '#get_user_temp.user_phone#' where user_id = #get_user.user_id# --->
<!--- </cfquery> --->


<br><br> 
 </cfif>
 
<cfif len(user_phone) eq "10">
<!--- <cfset phonego = "#mid(user_phone,1,2)# #mid(user_phone,3,2)# #mid(user_phone,5,2)# #mid(user_phone,7,2)# #mid(user_phone,9,2)#">  --->
<!--- #user_id# - #user_phone# - #phonego#<br> --->
<!--- <cfquery name="updt" datasource="#SESSION.BDDSOURCE#"> --->
<!--- UPDATE user SET user_phone = '#phonego#' where user_id = #user_id# --->
<!--- </cfquery> --->
</cfif>




</cfoutput>