<cfcomponent>
<cfprocessingdirective pageEncoding="utf-8" suppressWhiteSpace="yes">




<cffunction name="get_translate_complex">

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


	<cfset my_path = "../translation/translation_#lg#.xml">
	
	<cfif not isdefined('SESSION.TRAD_#Ucase(lg)#_XML')>		
		<cfset complex_xml = XMLParse('#my_path#')>
		<cfset "SESSION.TRAD_#Ucase(lg)#_XML" = complex_xml>
	<cfelse>
		<cfset complex_xml = "#evaluate('SESSION.TRAD_#Ucase(lg)#_XML')#">
	</cfif>	

	<cfset my_text = XMLSearch(complex_xml, '//item_translate[@ID="#id_translate#"]')>


	<cfset my_correct_text = "#my_text[1].XmlText#">
	
	
	<cfset to_replace = REMatch("\$\$[A-Za-z :,'\/\\\(\)\-\_\.]+\$\$", "#my_correct_text#")>

	<cfloop array='#to_replace#' index='idx'>
		<cfset rm_dollar = #replace('#idx#', '$$', '', 'all')#>
		<cfset my_correct_text = #replace('#my_correct_text#', '#idx#', '#evaluate('#rm_dollar#')#', 'all')#>
	</cfloop>

<cfreturn #my_correct_text#>

<cfcatch type="any">

<cfreturn "To translate">

</cfcatch>

</cftry>


</cffunction>



<cffunction name="get_translate">

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
	
	
	<cfset my_path = "../translation/translation_short.xml">
	
	<cfif not isdefined('SESSION.SHORT_XML')>		
		<cfset short_xml = XMLParse('#my_path#')>
		<cfset SESSION.SHORT_XML = short_xml>
	<cfelse>
		<cfset short_xml = SESSION.SHORT_XML>
	</cfif>	


	<cfset my_text = XMLSearch(short_xml, '//item_translate[@ID="#id_translate#"]/item_translate_#lg#')>

	<cfset my_correct_text = "#trim(my_text[1].XmlText)#">
	
	
	<cfset to_replace = REMatch("\$\$[A-Za-z :,'\/\\\(\)\-\_\.]+\$\$", "#my_correct_text#")>

	<cfloop array='#to_replace#' index='idx'>
		<cfset rm_dollar = #replace('#idx#', '$$', '', 'all')#>
		<cfset my_correct_text = #replace('#my_correct_text#', '#idx#', '#evaluate('#rm_dollar#')#', 'all')#>
	</cfloop>

<cfreturn #my_correct_text#>

<cfcatch type="any">

<cfreturn "To translate">

</cfcatch>

</cftry>

</cffunction>


</cfprocessingdirective>
</cfcomponent>
