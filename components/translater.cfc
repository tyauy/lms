<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">




<cffunction name="get_translate_complex" output=false>

	<cfargument name="id_translate" type="any" required="yes">
	<cfargument name="lg_translate" type="any" required="no">
	<cfargument name="argv" type="any" required="no">

	<cftry>

		<cfif isdefined("lg_translate")>
			<cfif IsNumeric("lg_translate")>
				<!--- OTHER LANGAGES --->
				<cfif lg_translate eq 1>
					<cfset lg = 'fr'>
				<cfelseif lg_translate eq 2>
					<cfset lg = 'en'>
				<cfelseif lg_translate eq 3>
					<cfset lg = 'de'>
				<cfelseif lg_translate eq 4>
					<cfset lg = 'es'>
				</cfif>			
			<cfelse>
				<cfset lg = lg_translate>
			</cfif>
		<cfelse>
			<cfif isdefined("SESSION.LANG_CODE")>
				<cfset lg = SESSION.LANG_CODE>
			<cfelse>
				<cfset lg = 'fr'>
			</cfif>
		</cfif>

		<cfif isdefined('argv')>
		<cfloop array="#argv#" index="cur_var">
			<cfset "#cur_var[1]#" = #cur_var[2]#>
		</cfloop>
		</cfif>


		<cfif not isdefined("SESSION.TRANSLATION_#ucase(lg)#")>
			<cfquery name="get_translation_long" datasource="#SESSION.BDDSOURCE#">
			SELECT translation_id, translation_code, translation_string_#lg# FROM lms_translation WHERE translation_cat = 'long'
			</cfquery>
			<cfset "SESSION.TRANSLATION_#ucase(lg)#" = serializeJSON(get_translation_long,"column")>
			<cfset translation_long = deserializeJSON(evaluate('SESSION.TRANSLATION_#ucase(lg)#'))>
		<cfelse>
			<cfset translation_long = deserializeJSON(evaluate('SESSION.TRANSLATION_#ucase(lg)#'))>
		</cfif>
		
		<cfset pos = arrayFind(translation_long.data.translation_code, "#id_translate#")>
		<cfset to_return = evaluate("translation_long.data.translation_string_#lg#[pos]")>

		
		<cfset to_replace = REMatch("\$\$[A-Za-z :,'\/\\\(\)\-\_\.]+\$\$", "#to_return#")>

		<cfloop array='#to_replace#' index='idx'>
			<cfset rm_dollar = #replace('#idx#', '$$', '', 'all')#>
			<cfset to_return = #replace('#to_return#', '#idx#', '#evaluate('#rm_dollar#')#', 'all')#>
		</cfloop>

	
		<cfreturn #trim(to_return)#>
		
	<cfcatch type="any">

		<cfreturn "$$#id_translate#$$">

	</cfcatch>

	</cftry>


</cffunction>



<cffunction name="get_translate" output=false>

<cfargument name="id_translate" type="any" required="yes">
<cfargument name="lg_translate" type="any" required="no">

<cftry>

	<cfif isdefined("lg_translate")>
		<cfif IsNumeric("#lg_translate#")>
			<!--- OTHER LANGAGES --->
			<cfif lg_translate eq 1>
				<cfset lg = 'fr'>
			<cfelseif lg_translate eq 2>
				<cfset lg = 'en'>
			<cfelseif lg_translate eq 3>
				<cfset lg = 'de'>
			<cfelseif lg_translate eq 4>
				<cfset lg = 'es'>
			</cfif>
			
		<cfelse>
			<cfset lg = #lg_translate#>
		</cfif>
	<cfelseif isdefined("SESSION.LANG_CODE")>
		<cfset lg = #SESSION.LANG_CODE#>
	<cfelse>
		<cfset lg = 'fr'>
	</cfif>
	
	<cfif not isdefined("SESSION.TRANSLATION_SHORT")>
		<cfquery name="get_translation_short" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_translation WHERE translation_cat = 'short'
		</cfquery>
		<cfset SESSION.TRANSLATION_SHORT = serializeJSON(get_translation_short,"column")>
		<cfset translation_short = deserializeJSON(SESSION.TRANSLATION_SHORT)>
	<cfelse>
		<cfset translation_short = deserializeJSON(SESSION.TRANSLATION_SHORT)> --->
 	</cfif>
		
	<cfset pos = arrayFind(translation_short.data.translation_code, "#id_translate#")>
	<cfset to_return = evaluate("translation_short.data.translation_string_#lg#[pos]")>

	<cfreturn #trim(to_return)#>

	<cfcatch type="any">

		<cfreturn "$$#id_translate#$$">

	</cfcatch>

</cftry>

</cffunction>


</cfprocessingdirective>
</cfcomponent>
