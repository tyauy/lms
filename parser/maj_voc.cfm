<!--- 
    This ColdFusion code presents a form for each language (English, French, German, Spanish, Italian) 
    allowing users to select which languages' vocabulary to migrate from the `lms_vocabulary` table to 
    the `lms_vocabulary_new` table. Upon form submission, it performs the migration for the selected 
    languages, only inserting vocabulary word groups that do not already exist in the `lms_vocabulary_new` 
    table. It handles errors during the insertion process and displays the vocabulary words that were 
    newly inserted. Please update one language at a time otherwise it crashes.
--->


<cfquery name="get_diff" datasource="#SESSION.BDDSOURCE#" >
    SELECT voc_cat_id
FROM lms_vocabulary AS old
WHERE NOT EXISTS (
    SELECT 1 
    FROM lms_vocabulary_new AS new
    WHERE old.voc_cat_id = new.voc_cat_id
)
group by voc_cat_id;
</cfquery>
<form action="maj_voc.cfm" method="post">
    <cfoutput query="get_diff"> 
        <input type="checkbox" name="voc_cat_ids" value="#voc_cat_id#"> #voc_cat_id# <br>
    </cfoutput>
    <input type="submit" name="activate_query" value="Send Update">
</form>


<cfif isDefined("form.activate_query")>
<cfloop list="en,fr,de,es,it" index="cor">
    <!--- Loop through the languages and retrieve the vocabulary data from the lms_vocabulary table --->
    <cfquery name="get_old_voc" datasource="#SESSION.BDDSOURCE#">
        SELECT voc_id, 
        voc_word_#cor# as voc_word, 
        voc_desc_#cor# as voc_desc, 
        voc_category,
        voc_cat_id,
        voc_type_#cor#_id as voc_type,
        voc_is_private
        FROM lms_vocabulary
    </cfquery>
    <cfoutput query="get_old_voc">
        <cftry>
            <cfquery name="get_max_voc_group" datasource="#SESSION.BDDSOURCE#">
                SELECT MAX(voc_group) as max_voc_group FROM lms_vocabulary_new
            </cfquery>
            
            <cfset voc_group = get_max_voc_group.max_voc_group + 1>
            <!--- Check if the vocabulary group already exists in the lms_vocabulary_new table --->
            <cfquery name="check_voc_group" datasource="#SESSION.BDDSOURCE#">
                SELECT voc_group FROM lms_vocabulary_new WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#"> AND formation_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">
            </cfquery>
            <!--- If the vocabulary group doesn't exist, insert the data into the lms_vocabulary_new table --->
            <cfif check_voc_group.recordcount eq 0 >
                <cfquery name="lms_vocabulary_new_update" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO `lms_vocabulary_new`(
                        `voc_group`, 
                        `formation_code`,
                        `voc_word`, 
                        `voc_desc`,
                        `voc_category`, 
                        `voc_cat_id`,
                        `voc_type_id`,
                        `voc_is_private`
                        ) 
                    VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_word#">,
                        <cfif voc_desc neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_desc#">,<cfelse>null,</cfif>
                            <cfif voc_category neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_category#">,<cfelse>null,</cfif>
                            <cfif voc_cat_id neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_cat_id#">,<cfelse>null,</cfif>
                            <cfif voc_type neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_type#">,<cfelse>null,</cfif>
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_is_private#">
                            )
                            </cfquery>
                            </cfif>
                            <cfcatch type="any">
                            Error: <cfoutput>#cfcatch.message#</cfoutput>
                            </cfcatch>
                            </cftry>
                            </cfoutput>
                            </cfloop>
                            <cfquery name="get_inserted_words" datasource="#SESSION.BDDSOURCE#">
                                SELECT voc_word FROM lms_vocabulary_new WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_id#">
                            </cfquery>
                            
                            <cfset insertedWords = "" />
                            <cfloop query="get_inserted_words">
                                <cfset insertedWords = insertedWords & ", " & voc_word />
                            </cfloop>
                            <cfoutput>Words inserted: #insertedWords#</cfoutput>
                    
 </cfif>