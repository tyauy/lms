<cfcomponent>

    <cffunction name="vocab_rename_audio" access="remote" returntype="any" output="true" httpMethod="POST">
        <cfargument name="start_id" type="numeric" required="yes">
        <cfargument name="vcl_id" type="numeric" required="yes">
        <cfargument name="el_count" type="numeric" required="yes">
        <cfargument name="formation_id" type="numeric" required="yes">
        <cfargument name="accent_id" type="numeric" required="no" default="0">
        <cfargument name="list" type="string" required="no" default="">
        <cfargument name="path" type="string" required="yes">


        <!--- <cftry> --->
            <cfset internal_path = "#SESSION.BO_ROOT#/parser/temp_vocab/#path#">

            <cfdirectory directory="#internal_path#" name="dirQuery" action="LIST" sort="name ASC">

            <cfset dest_name = "#SESSION.BO_ROOT#/assets/vocab/#formation_id#/#accent_id#/#vcl_id#/">

            <cfif not directoryExists(dest_name)>
			
				<cfdirectory directory="#dest_name#" action="create" mode="777">
			
			</cfif>

            <cfif list eq "">
                <cfquery name="get_vocab_list" datasource="#SESSION.BDDSOURCE#">
                    SELECT voc_id, voc_word_en, voc_desc_en, voc_category, voc_type
                    FROM lms_vocabulary 
                    WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
                    AND voc_id >= <cfqueryparam cfsqltype="cf_sql_integer" value="#vocab_id#">
                    ORDER BY voc_id ASC
                    LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#el_count#">
                </cfquery>

                <cfif get_vocab_list.recordCount GT 0>
                    <cfloop query="dirQuery">
                        <cfset cur_word = QueryGetRow(get_vocab_list, dirQuery.currentRow)>

                        <cfset dest_name = "#SESSION.BO_ROOT#/assets/vocab/#formation_id#/#accent_id#/#vcl_id#/">


                        <cfset dest_name &= "word_#cur_word.voc_id#_#formation_id#_#accent_id#">
                        <!--- <cfif accent_id neq "0" AND accent_id neq "">
                            <cfset dest_name &= "_#accent_id#">
                        </cfif> --->
                        <cfset dest_name &= ".mp3">

                        <cffile action="rename" 
                        source = "#internal_path#/#name#" 
                        destination = "#dest_name#"
                        attributes="normal"
                        mode="777"> 

                    </cfloop>
                    
                </cfif>

            <cfelse>

                <!--- <cfdump var="#list#"> --->

                <cfloop query="dirQuery">
                    <cfset cur_id = trim(listGetAt(list, dirQuery.currentRow))>

                    <cfset dest_name = "#SESSION.BO_ROOT#/assets/vocab/#formation_id#/#accent_id#/#vcl_id#/">

                    
                    <cfset dest_name &= "word_#cur_id#_#formation_id#_#accent_id#">
                    <!--- <cfif accent_id neq "0" AND accent_id neq "">
                        <cfset dest_name &= "_#accent_id#">
                    </cfif> --->
                    <cfset dest_name &= ".mp3">

                    <cfdump var="#dest_name#">

                    <cffile action="copy" 
                    source = "#internal_path#/#name#" 
                    destination = "#dest_name#"
                    attributes="normal"
                    mode="777"> 

                </cfloop>
                    

            </cfif>
            


           

            
            <cfreturn 1>

        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->

    </cffunction>

    <cffunction name="updateShortList" access="remote" method="POST" returntype="any" returnformat="json">

        <cfargument name="voc_group" type="numeric" required="yes">
		

        <cftry>
    
        <cfquery name="update_short_list" datasource="#SESSION.BDDSOURCE#">

            UPDATE lms_vocabulary_new SET voc_is_shortlist = not voc_is_shortlist
            WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">
        </cfquery>

        <cfquery name="get_short_list" datasource="#SESSION.BDDSOURCE#">
            SELECT voc_is_shortlist FROM lms_vocabulary_new
            WHERE voc_group = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_group#">
        </cfquery>
        
        <cfreturn get_short_list.voc_is_shortlist>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn "0">

        </cfcatch>
        </cftry>
    
    </cffunction>

</cfcomponent>