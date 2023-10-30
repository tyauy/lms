<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_status_id, user_password, user_lastconnect, user_pwd_chg FROM user
</cfquery>  
  
<cfoutput query="get_user">

<cfquery name="get_userold" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_status_id, user_password, user_lastconnect, user_pwd_chg FROM userold where user_id = #user_id#
</cfquery>

<cfif get_userold.user_status_id neq get_user.user_status_id>
    #user_id# : user_status_id has to be #get_user.user_status_id#<br>
</cfif>

<cfif get_userold.user_password neq get_user.user_password>
    #user_id# : user_password has to be #get_user.user_password#<br>
</cfif>

<cfif get_userold.user_pwd_chg neq get_user.user_pwd_chg>
    #user_id# : user_pwd_chg has to be #get_user.user_pwd_chg#<br>
</cfif>
  
</cfoutput>