<!--- CSS Files --->
<link href="../assets/css/bootstrap-4.5.3/bootstrap.min.css" rel="stylesheet" />

<cfif isdefined("user_id") and isdefined("status_id")>
    
    <cfquery name="get_tm" datasource="#SESSION.BDDSOURCE#">
UPDATE user SET user_status_id = #status_id#
WHERE user_id = #user_id#
    </cfquery>

</cfif>
<cfquery name="get_tm" datasource="#SESSION.BDDSOURCE#">

SELECT *, us.user_status_name_fr as user_status_name FROM user u

INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
INNER JOIN user_profile up ON up.profile_id = upc.profile_id AND upc.profile_id = 8
INNER JOIN account a ON u.account_id = a.account_id
INNER JOIN user_status us ON us.user_status_id = u.user_status_id


ORDER BY u.account_id ASC, u.user_name ASC
</cfquery>


<table border="1">

<cfoutput query="get_tm">
<tr>
    <td><a name="tm_#user_id#"> #user_firstname#</a></td>
    <td>#user_name#</td>
    <td>#ucase(account_name)#</td>
    <td><cfif user_status_id eq "4"><div class="badge badge-success">#user_status_name#</div><cfelse><div class="badge badge-info">#user_status_name#</div></cfif></td>
    <td><cfif user_status_id neq "4"><a class="btn btn-sm btn-success" href="maj_active_tm.cfm?user_id=#user_id#&status_id=4">Switch to actif</a></cfif></td>
    <td><cfif user_status_id eq "4"><a class="btn btn-sm btn-secondary" href="maj_active_tm.cfm?user_id=#user_id#&status_id=5##tm_#user_id#">Switch to inactif</a></cfif></td>
</tr>


</cfoutput>

</table>