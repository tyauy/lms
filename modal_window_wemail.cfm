<cfif isdefined("w_id")>
<cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_wemail WHERE wemail_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#w_id#">
</cfquery>

<cfoutput query="get_wemail">

<div align="center">
<h6>[#wemail_category#]</h5>
<h5>#wemail_subject#</h5>
</div>

<cfloop from="1" to="8" index="cor">
<cfset temp = evaluate("wemail_sample_#cor#")>
<cfset temp = replacenocase(temp,"#chr(10)##chr(13)#","<br>","ALL")>

<cfif temp neq "">
<div class="mt-3 border p-2 w-100 bg-light">
<strong>#obj_translater.get_translate('modal_txt_proposition')# #cor#</strong><br>
<p>#temp#</p>
</div>
</cfif>
</cfloop>

</cfoutput>

</cfif>