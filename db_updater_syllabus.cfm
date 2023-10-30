<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>

<cfif isdefined("sm_id") AND isdefined("form") AND isdefined("updt_sm")>


	<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsessionmaster2
	SET
	<cfif module_id neq "">module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#module_id#">,<cfelse>module_id = null,</cfif>
	
	sessionmaster_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_name#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_name_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_name_#lg#')#">,
	</cfloop>
	
	sessionmaster_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_description#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_description_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_description_#lg#')#">,
	</cfloop>
	
	sessionmaster_objectives = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_objectives#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_objectives_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_objectives_#lg#')#">,
	</cfloop>
	
	sessionmaster_grammar = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_grammar#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_grammar_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_grammar_#lg#')#">,
	</cfloop>
	
	sessionmaster_vocabulary = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_vocabulary#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_vocabulary_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_vocabulary_#lg#')#">,
	</cfloop>
	
	sessionmaster_transcript = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_transcript#">,
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
	sessionmaster_transcript_#lg# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('sessionmaster_transcript_#lg#')#">,
	</cfloop>


	<!---sessionmaster_new = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_new#">,--->
	sessionmaster_admin_note = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_admin_note#">,
	sessionmaster_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_duration#">,
	sessionmaster_ressource = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_ressource#">,
	
	sessionmaster_video = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_video#">,
	<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1">
	sessionmaster_video_bool = 1,
	<cfelseif sessionmaster_video neq "">
	sessionmaster_video_bool = 1,
	<cfelse>
	sessionmaster_video_bool = 0,
	</cfif>
	sessionmaster_exercice = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_exercice#">,
	
	sessionmaster_el_duration = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_el_duration#">,
	
	voc_cat_id = <cfif isdefined("voc_cat_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_id#">,<cfelse>null,</cfif>
	
	level_id = <cfif isdefined("level_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#level_id#">,<cfelse>null,</cfif>
	
	<!---sessionmaster_code = <{sessionmaster_code: }>,
	sessionmaster_level = <{sessionmaster_level: }>,
	sessionmaster_type = <{sessionmaster_type: }>,

	sessionmaster_url = <{sessionmaster_url: }>,
	sessionmaster_ressource = <{sessionmaster_ressource: }>,
	sessionmaster_cat_id = <{sessionmaster_cat_id: }>,--->
	
	sessionmaster_online_visio = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_online_visio#">,
	sessionmaster_online_el = <cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_online_el#">,
	
	tp_orientation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_orientation_id#">,



	keyword_id = <cfif isdefined("keyword_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#keyword_id#">,<cfelse>null,</cfif>
	grammar_id = <cfif isdefined("grammar_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#grammar_id#">,<cfelse>null,</cfif>
	mapping_id = <cfif isdefined("mapping_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#mapping_id#">,<cfelse>null,</cfif>
	skill_id = <cfif isdefined("skill_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#skill_id#">,<cfelse>null,</cfif>
	sessionmaster_ln_grammar = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_ln_grammar#">,
	sessionmaster_ln_vocabulary = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_ln_vocabulary#">
	WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>
	
	<cfquery name="get_mastercor" datasource="#SESSION.BDDSOURCE#">
	SELECT tm.tpmastercor_id, t.tpmaster_id
	FROM lms_tpmastercor2 tm 
	INNER JOIN lms_tpmaster2 t ON tm.tpmaster_id = t.tpmaster_id
	WHERE tm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	AND t.tpmaster_prebuilt = 0
	</cfquery>
	
	<cfif get_mastercor.tpmaster_id neq tpmaster_id>
	<cfquery name="updt_master" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpmastercor2
	SET tpmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmaster_id#">, sessionmaster_rank = null
	WHERE tpmastercor_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tpmastercor_id#">
	</cfquery>
	</cfif>

	<cfdump var="#keyword_id#">


	<cfif isdefined("keyword_id") AND listlen(keyword_id) gt 0>
	<cfquery name="del_kw" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_sessionmaster_keywordid_cor
	WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	AND keyword_id NOT IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#keyword_id#">)
	</cfquery>

	<cfloop list="#keyword_id#" index="cor">
	<cfquery name="check_kw" datasource="#SESSION.BDDSOURCE#">
	SELECT keyword_id FROM lms_sessionmaster_keywordid_cor
	WHERE keyword_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> AND sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
	</cfquery>

	<cfif check_kw.recordcount eq "0">
		<!--- <cfquery name="ins_kw" datasource="#SESSION.BDDSOURCE#">
		INSERT IGNORE INTO lms_sessionmaster_keywordid_cor
		SET sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
		keyword_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		</cfquery> --->

		<cfquery name="ins_kw" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_sessionmaster_keywordid_cor
		(
			sessionmaster_id,
			keyword_id

		)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
		)
		</cfquery>

	</cfif>

	
	</cfloop>
	</cfif>

	<!--- <cfabort> --->

	<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#sm_id#&k=1">

<cfelseif not isdefined("sm_id") AND isdefined("form")>

	<cfquery name="ins_sm" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO	lms_tpsessionmaster2
	(
	sessionmaster_name,
	sessionmaster_duration,
	sessionmaster_cat_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_name#">,
	45,
	1
	)
	</cfquery>
	
	
	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(sessionmaster_id) AS id FROM lms_tpsessionmaster2 
	</cfquery>
	
	<cfquery name="ins_tpcor" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO	lms_tpmastercor2
	(
	sessionmaster_id,
	tpmaster_id
	)
	VALUES
	(
	#get_max.id#,
	#tpmaster_id#
	)
	</cfquery>
	
	<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_tpsessionmaster2
	SET

	sessionmaster_md = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(get_max.id)#">

	WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_syllabus_edit.cfm?sm_id=#get_max.id#&k=1">
	
<cfelseif isdefined("sm_id") AND isdefined("form") AND isdefined("updt_chapter") AND isdefined("ch_id")>

	<cfquery name="get_voc" datasource="#SESSION.BDDSOURCE#">
	SELECT * 
	FROM lms_vocabulary ORDER BY voc_id ASC LIMIT 500
	</cfquery>
	
	<cfquery name="del_voc" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_vocabulary_glossary WHERE chapter_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ch_id#">
	</cfquery>
	
	<cfloop query="get_voc">
	<cfif listlen(voc_word_en," ") eq "1">
	<cfquery name="get_exist" datasource="#SESSION.BDDSOURCE#">
	SELECT chapter_id FROM lms_tpchaptermaster2 WHERE MATCH(chapter_content) AGAINST("#voc_word_en#" IN BOOLEAN MODE) 
	</cfquery>
	
	
	
	<cfif get_exist.recordcount neq "0">
	<cfoutput>le mot #voc_word_en# existe</cfoutput> <br><br>
	
	<cfquery name="insert_voc" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_vocabulary_glossary
	(
	voc_id,
	chapter_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#voc_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#ch_id#">
	)
	</cfquery>
	
	</cfif>
	</cfif>
	
	</cfloop>


</cfif>

</cfif>



