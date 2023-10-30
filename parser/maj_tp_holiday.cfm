<cfabort>

<!--- TODO a mettre dans les CRON --->
<!--- https://date.nager.at/Api --->
<cfset year = year(now())>
<!--- <cfset year = "2024"> --->

<cfhttp
url="https://date.nager.at/api/v3/publicholidays/#year#/FR"
method="GET"
result="res">
</cfhttp>

<cfset list = DeserializeJSON(res.Filecontent)>

<cfloop array="#list#" index="_index">

    <cfdump var="#_index#">
    <cfdump var="#_index.date#">
    <cfdump var="#_index.name#">

    <!--- <cftry> --->

            <cfquery name="insert_user_expertise" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `settings_holiday`(
                    `provider_code`, 
                    `holiday_name`,
                    `holiday_date`
                    ) 
                VALUES (
                    "FR",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#_index.name#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#_index.date#">
                    )
            </cfquery>
 
 
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry> --->

</cfloop>


<cfhttp
url="https://date.nager.at/api/v3/publicholidays/#year#/DE"
method="GET"
result="res">
</cfhttp>

<cfset list = DeserializeJSON(res.Filecontent)>

<cfloop array="#list#" index="_index">

    <cfdump var="#_index#">
    <cfdump var="#_index.date#">
    <cfdump var="#_index.name#">

    <!--- <cftry> --->

            <cfquery name="insert_user_expertise" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO `settings_holiday`(
                    `provider_code`, 
                    `holiday_name`,
                    `holiday_date`
                    ) 
                VALUES (
                    "DE",
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#_index.name#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#_index.date#">
                    )
            </cfquery>
 
 
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry> --->

</cfloop>
