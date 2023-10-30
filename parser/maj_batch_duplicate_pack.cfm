<cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
SELECT pack_id, pack_name FROM lms_formation_pack WHERE provider_id = 1
</cfquery>

<table border="1">
<cfoutput query="get_pack">

    <cfquery name="get_new" datasource="#SESSION.BDDSOURCE#">
    SELECT pack_id, pack_name FROM lms_formation_pack WHERE provider_id = 3 AND pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">
    </cfquery>

<tr>
    <td>#get_pack.pack_id# / #get_pack.pack_name#</td>
    <td>#get_new.pack_id# / #get_new.pack_name#</td>
</tr>

<cfquery name="update" datasource="#SESSION.BDDSOURCE#">
    UPDATE lms_formation_pack SET from_id="#get_pack.pack_id#" WHERE provider_id = 3 AND pack_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pack_name#">
    </cfquery>
</cfoutput>
</table>