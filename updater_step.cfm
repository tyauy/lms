<cfif isdefined("updt") AND isdefined("s_id")>

<cfset temp = obj_lms.updt_step("2")>

</cfif>

<cflocation addtoken="no" url="index.cfm">
