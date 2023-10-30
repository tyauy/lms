
<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfif isdefined("act") AND act eq "ins_voc_cat">



<cfelseif isdefined("act") AND act eq "updt_voc_cat">


	
<cfelseif isdefined("act") AND act eq "ins_voc">



<cfelseif isdefined("act") AND act eq "updt_voc">

	
<cfelseif isdefined("act") AND act eq "del_wemail">

	<cfquery name="updt_voc" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_wemail WHERE wemail_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#wemail_id#">
	</cfquery>
		
</cfif>

</cfif>

<cflocation addtoken="no" url="db_vocab_wemail.cfm?wemail_cat=#wemail_cat#">
