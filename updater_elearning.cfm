<!--- <cfsetting requestTimeOut = "9000000" /> --->

<!--- <cfdump var="#form#"> --->
<cfparam name="elearning_id" default="0">
<cfparam name="module_name">
<cfparam name="module_path" default="">
<cfparam name="module_difficulty" default="0">

<!--- <cfif isdefined("doc_attach_elearning") AND form["doc_attach_elearning"] neq "">

	<cfset dir_go = "#SESSION.BO_ROOT#/assets/scorm/">

	<cffile action = "upload" 
	filefield = "doc_attach_elearning" 
	destination = "#dir_go#" 
	result="uploaded_file"
	nameConflict = "Overwrite"
	mode="777">		
						
	<!--- <cfdump var="#uploaded_file#"> --->
	<cfif uploaded_file.FileWasSaved>

		<cfif not directoryExists("#dir_go#/#module_path#")>
			
			<cfdirectory directory="#dir_go#/#module_path#" action="create" mode="777">
			
		</cfif>
		
		<!--- <cfzip action="unzip" 
		destination="#dir_go#/#module_path#" 
		file="#dir_go#/#uploaded_file.ClientFile#" 
		overwrite="yes" > --->

	</cfif>

</cfif> --->

<cfset preview_name = elearning_id eq 0 ? "doc_attach_preview" : "doc_attach_preview_#elearning_id#">
<cfset preview_path = "">

<cfif isdefined("#preview_name#") AND form["#preview_name#"] neq "">

	<cfset dir_go = "#SESSION.BO_ROOT#/assets/img_elearning/">

	<cffile action = "upload" 
	filefield = "#preview_name#" 
	destination = "#dir_go#" 
	result="uploaded_file"
	nameConflict = "Overwrite"
	mode="777">		
						
	<!--- <cfdump var="#uploaded_file#"> --->
	<cfif uploaded_file.FileWasSaved>

		<cfif FileExists("#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#")>
			<cffile action = "delete" file = "#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#">
		</cfif>

		<cffile action="rename" 
		source = "#dir_go#/#uploaded_file.ClientFile#" 
		destination = "#dir_go#/#module_path#.#lcase(uploaded_file.clientFileExt)#" 
		attributes="normal"
		mode="777"> 

		<cfset preview_path = "#module_path#.#lcase(uploaded_file.clientFileExt)#">

	</cfif>

</cfif>

<cfif elearning_id eq 0>

	<cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
		INSERT INTO `lms_elearning`(
			module_path,
			module_name,
			module_difficulty,
			module_thumbs
			) 
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#module_path#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#module_name#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#module_difficulty#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#preview_path#">
		)
	</cfquery>

<cfelse>

	<cfquery datasource="#SESSION.BDDSOURCE#">
		UPDATE `lms_elearning` SET
		<cfif preview_path neq "">preview_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#preview_path#">,</cfif>
		module_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#module_name#">
		WHERE `elearning_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#elearning_id#">
	</cfquery>

</cfif>

<cflocation addtoken="no" url="db_elearning_list.cfm">