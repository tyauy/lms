<cffunction name="getFormationId" output="no">
	<cfargument name="list_lang" type="string">
	<cfloop list="#list_lang#" index="lang">
        	<!--- Map language codes to formation_ids --->
            <cfset var formationMap = {"en": 2, "fr": 1, "de": 3, "it": 4, "es": 5}>
        <cfoutput>#formationMap[lang]#</cfoutput>
    </cfloop>
	<!--- Return the formation_id for the given language code --->
	<cfreturn formationMap[lang]>
</cffunction>
<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfif isdefined("act") AND act eq "ins_voc_cat">

<cfquery name="ins_quiz" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_vocabulary_category
    (
    voc_cat_name,
    voc_cat_name_fr,
    voc_cat_name_en,
    voc_cat_name_de,
    voc_cat_name_es,
    voc_cat_name_it
    )
    VALUES 
    (
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name') ? voc_cat_name : JavaCast('null', ''))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name_fr') ? voc_cat_name_fr : JavaCast('null', ''))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name_en') ? voc_cat_name_en : JavaCast('null', ''))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name_de') ? voc_cat_name_de : JavaCast('null', ''))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name_es') ? voc_cat_name_es : JavaCast('null', ''))#">,
    <cfqueryparam cfsqltype="cf_sql_varchar" value="#(IsDefined('voc_cat_name_it') ? voc_cat_name_it : JavaCast('null', ''))#">
    )
</cfquery>

	
	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT max(voc_cat_id) as id FROM lms_vocabulary_category
	</cfquery>
	
	<cflocation addtoken="no" url="db_vocab_list.cfm?vcl_id=#get_id.id#">

<cfelseif isdefined("act") AND act eq "updt_voc_cat">

	<cfquery name="updt_voc_cat" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_vocabulary_category
	SET 
	voc_cat_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_name#">,
	voc_cat_name_fr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_name_fr#">,
	voc_cat_name_en = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_name_en#">,
	voc_cat_name_de = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_name_de#">,
	voc_cat_name_it = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_name_it#">,
	<cfif isdefined("voc_cat_online")>voc_cat_online = 1<cfelse>voc_cat_online = 0</cfif>
	WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_vocab_list.cfm?vcl_id=#vcl_id#">
	
<cfelseif isdefined("act") AND act eq "ins_voc">
    <cfset original_list_lang = list_lang>
<!--- Get the next voc_group --->
<cfquery name="get_max_voc_group" datasource="#SESSION.BDDSOURCE#">
    SELECT MAX(voc_group) as max_voc_group FROM lms_vocabulary_new
</cfquery>

<cfset voc_group = get_max_voc_group.max_voc_group + 1>

<!--- Loop through the list of languages --->
<cfloop list="en,fr,de,es,it" index="list_lang">

    <!--- Check if the structures exist, if not set them to null --->
    <cfif StructKeyExists(FORM, "voc_word_" & list_lang) AND StructKeyExists(FORM, "voc_desc_" & list_lang)>
        <cfset voc_word = FORM["voc_word_" & list_lang]>
        <cfset voc_desc = FORM["voc_desc_" & list_lang]>
        <cfset voc_type_id = FORM["voctype_" & list_lang & "_id"]>

       
    <cfelse>
        <cfset voc_word = "">
        <cfset voc_desc = "">
    </cfif>

  

    <!--- Retrieve the formation_id based on the language code --->
    <cfset formation_id = getFormationId(list_lang)>

    <!--- Use the data in your SQL query to insert a new record --->
    <cfquery name="insertVoc" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO lms_vocabulary_new (voc_word, voc_desc, formation_id, formation_code, voc_cat_id, voc_type_id, voc_group)
        VALUES (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_word#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_desc#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#list_lang#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_type_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">
        )
    </cfquery>

</cfloop>

<cflocation addtoken="no" url="db_vocab_list.cfm?vcl_id=#vcl_id#&list_lang=#original_list_lang#">



<cfelseif isdefined("act") AND act eq "updt_voc">
	
	<cfset languages = "en,fr,de,es,it">

<cfloop list="#Form.FieldNames#" index="cor">
    <cfif listlen(cor,"_") eq 3 AND listgetat(cor,1,"_") eq "vocword">
        <cfset voc_id = listgetat(cor,3,"_")>
		<cfquery name="getvocgroup" datasource="#SESSION.BDDSOURCE#">
			select voc_group from lms_vocabulary_new where voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_id#">
		</cfquery>
        
       
        <!--Debugging lines-->
        <cfdump var="#voc_id#" label="voc_id">
        <cfdump var="#getvocgroup#" label="getvocgroup">
        
        <cfloop list="#languages#" index="lang">
            <!-- Check if the form fields for this language exist -->
            <cfif isdefined("vocword_#lang#_#voc_id#")>
                <cfset voc_word = evaluate("vocword_#lang#_#voc_id#")>
                <cfset voc_desc = evaluate("vocdesc_#lang#_#voc_id#")>
                <cfset voc_type_id = FORM["voctype_" & lang & "_id"]>

        <!-- Debugging lines -->
        <cfdump var="#voc_word#" label="voc_word for #lang#">
        <cfdump var="#voc_desc#" label="voc_desc for #lang#">
        <cfdump var="#voc_type_id#" label="voc_type_id for #lang#">


                <cfset formation_id = getFormationId(lang)>

         <!-- Debugging line -->
         <cfdump var="#formation_id#" label="formation_id for #lang#">
                    
                
                <cfquery name="updateVoc" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_vocabulary_new SET
                    voc_word = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_word#">,
                    voc_desc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_desc#">,
                    voc_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_type_id#">
                    WHERE voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_id#">
                    
                </cfquery>
                
            </cfif>
        </cfloop>
    </cfif>
</cfloop>

		
	<cflocation addtoken="no" url="db_vocab_list.cfm?vcl_id=#vcl_id#&list_lang=#list_lang#">
	
<cfelseif isdefined("act") AND act eq "del_voc" AND isdefined("voc_group")>

	<cfquery name="updt_voc" datasource="#SESSION.BDDSOURCE#">
	DELETE FROM lms_vocabulary_new WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_vocab_list.cfm?vcl_id=#vcl_id#&list_lang=#list_lang#">
	
</cfif>

</cfif>
