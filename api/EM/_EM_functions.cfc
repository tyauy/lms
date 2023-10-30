<cfcomponent>
<cffunction name="setTmSessionVariables">
    <cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.USER_ACCOUNT_RIGHT_ID')>
        <cfif isDefined("SESSION.CUR_A_ID")>
            <cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.CUR_A_ID>
        <cfelse>
            <cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.ACCOUNT_ID>
        </cfif>
    </cfif>
    
    <cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.AL_ID')>
        <cfif isDefined("SESSION.CUR_A_ID")>
            <cfset SESSION.AL_ID = SESSION.CUR_A_ID>
        <cfelse>
            <cfset SESSION.AL_ID = SESSION.ACCOUNT_ID>
        </cfif>
    </cfif>
   
</cffunction>

<cffunction name="get_translate" returnType="string" output="false">
    <cfargument name="key" type="string" required="yes">

    <!--- Initialize the return value with the key as a fallback --->
    <cfset var translation = arguments.key>

    <!--- Query the database to get the translation for the given key --->
    <cfquery name="getTranslation" datasource="#SESSION.BDDSOURCE#">
        SELECT * 
        FROM lms_translation
        WHERE translation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.key#">
    </cfquery>

   <!--- If a translation is found, update the return value --->
   <cfif getTranslation.recordCount eq 1>
    <cfif isDefined("Session.LANG_CODE") AND len(trim(Session.LANG_CODE)) gt 0>
        <cfset translation = getTranslation["translation_string_" & Session.LANG_CODE]>
    <cfelse>
        <!--- Handle the case where Session.LANG_CODE is not defined or is empty --->
        <cflog text="Session.LANG_CODE is not defined or is empty">
    </cfif>
</cfif>
    <cfreturn translation>
</cffunction>


    <cffunction name="getButtons" returnType="struct" access="public" output="false">
        <cfargument name="buttons" type="array" required="yes">
        
        <cfset var buttonsStruct = structNew()>

        <cfloop array="#arguments.buttons#" index="button">
            <cfset buttonsStruct[button] = this.get_translate(button)>
        </cfloop>

        <cfreturn buttonsStruct>
    </cffunction>

    
    <cffunction name="getTooltips" returnType="struct" access="public" output="false">
        <cfargument name="tooltips" type="array" required="yes">
        
        <cfset var tooltipsStruct = structNew()>

        <cfloop array="#arguments.tooltips#" index="tooltip">
            <cfset tooltipsStruct[tooltip] = this.get_translate(tooltip)>
        </cfloop>

        <cfreturn tooltipsStruct>
    </cffunction>
</cfcomponent>