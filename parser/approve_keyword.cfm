<cfparam name="key" default="1">

<cfif key eq 1>
<!--- Check if the form field exists --->
<cfif structKeyExists(form, "existingKeywords")>
    <!--- Loop over the form fields to get the existing keywords --->
    <cfdump var="#form#">
    <cfloop collection="#form.existingKeywords#" item="i">
        <cfset existingKeyword = {keyword_id=form.existingKeywords[i]['keyword_id'], sessionmaster_id=form.existingKeywords[i]['sessionmaster_id']}>

        <!--- Check if the pair (sessionmaster_id, keyword_id) already exists in the lms_sessionmaster_keywordid_cor table --->
        <cfquery name="checkPair" datasource="#SESSION.BDDSOURCE#">
            SELECT * 
            FROM lms_sessionmaster_keywordid_cor 
            WHERE sessionmaster_id = <cfqueryparam value="#existingKeyword.sessionmaster_id#" cfsqltype="cf_sql_integer">
            AND keyword_id = <cfqueryparam value="#existingKeyword.keyword_id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <!--- If the pair does not exist, insert it and print out the existingKeyword variable --->
        <cfif checkPair.recordCount eq 0>
            <!--- Insert the pair (sessionmaster_id, keyword_id) into the lms_sessionmaster_keywordid_cor table --->
            <cftry>
                <cfquery name="insertPair" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_sessionmaster_keywordid_cor (sessionmaster_id, keyword_id)
                    VALUES (
                        <cfqueryparam value="#existingKeyword.sessionmaster_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#existingKeyword.keyword_id#" cfsqltype="cf_sql_integer">
                    )
                </cfquery>
                <cfset response = 1>
                <cfcatch>
                    <cfoutput>Error occurred: #cfcatch.message#</cfoutput>
                    <cfset response = 0>
                </cfcatch>
            </cftry>
            
            <cfcontent type="text/plain" reset="Yes">
            <cfoutput>#response#</cfoutput>
            </cfcontent>
            
            
        </cfif>
    </cfloop>
    
</cfif>



<cfelseif key eq 2>

    <cfif IsDefined("form.sessionmaster_id") AND IsDefined("form.keyword")>
        <!--- Insert the keyword into the lms_keyword2 table and get the new keyword_id --->
        <cfquery name="insertKeyword" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_keyword2 (keyword_name_en, keyword_cat_id, is_active)
            VALUES (
                <cfqueryparam value="#form.keyword#" cfsqltype="cf_sql_varchar">,
                3,
                0
            )
        </cfquery>
        
        <cfquery name="getKeywordId" datasource="#SESSION.BDDSOURCE#">
            SELECT LAST_INSERT_ID() AS id
        </cfquery>
        
        <!--- Insert the pair (sessionmaster_id, keyword_id) into the lms_sessionmaster_keywordid_cor table --->
        <cfquery name="insertPair" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_sessionmaster_keywordid_cor (sessionmaster_id, keyword_id)
            VALUES (
                <cfqueryparam value="#form.sessionmaster_id#" cfsqltype="cf_sql_integer">,
                <cfqueryparam value="#getKeywordId.id#" cfsqltype="cf_sql_integer">
            )
        </cfquery>
    </cfif>

</cfif>
