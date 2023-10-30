<cfabort> 

<cfquery name="get_contact" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_contact
</cfquery>

<cfoutput query="get_contact">
    <br>
    -
    <br>
    #contact_id#
    #account_id#
    <br>
    <cftry>

        <cfloop list="#account_id#" index="acc">

            <cfif acc neq 0>
                <cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO account_contact_cor
                    (
                    a_id,
                    ctc_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#acc#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#contact_id#">
                    )
                </cfquery>
            </cfif>

        </cfloop>


        <cfcatch>
            error  #acc# - #contact_id# <br>
        </cfcatch>
    </cftry>

<!--- <cfquery name="get_contact_cor" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_contact_cor WHERE ctc_id = #contact_id#
</cfquery>

<cfset list_temp = "">

<cfloop query="get_contact_cor">
<cfset list_temp = listappend(list_temp,a_id)>
<br>rattach&eacute; &agrave; account = #get_contact_cor.a_id#
</cfloop>

<!---<cfquery name="get_contact_cor" datasource="#SESSION.BDDSOURCE#">
UPDATE account_contact SET account_id = '#list_temp#' WHERE contact_id = #contact_id#
</cfquery>--->

<br>donc list = #list_temp#
<br><br><br> --->

</cfoutput>

