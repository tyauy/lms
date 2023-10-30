<cfabort>


<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, user_el_list FROM `user` WHERE user_el_list IS NOT NULL AND user_el_list != "" AND user_status_id <> 5
 </cfquery>
 
 
 <cfoutput query="select">

    <cfquery name="select_module" datasource="#SESSION.BDDSOURCE#">
        SELECT `elearning_module_id` FROM `lms_elearning_module` WHERE `elearning_module_id` IN (#user_el_list#)
     </cfquery>

    <cfloop query="select_module">

        #select.user_id#

        #select_module.elearning_module_id#<br>

    <cftry>

            <cfquery name="insert_user_expertise" datasource="#SESSION.BDDSOURCE#">
                DELETE FROM lms_elearning_session_user 
                WHERE elearning_module_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_module.elearning_module_id#"> 
                AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#select.user_id#">
            </cfquery>
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

    </cfloop>

    <br><br>--<br><br>

 
 </cfoutput>
