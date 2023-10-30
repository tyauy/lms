<cfparam name="form.word" default="">
<cfparam name="#SESSION.USER_LANG#" default="EN"> 

<cffunction name="translateWithDeepL" access="public" returntype="string">
    <cfargument name="text" type="string" required="true">
    <cfargument name="targetLanguage" type="string" required="true">
    
    <!--- Define DeepL API endpoint and key --->
    <cfset apiEndpoint = "https://api-free.deepl.com/v2/translate">
    <cfset apiKey = "950629aa-f3c6-c872-9e03-ab2bed4057e2:fx">
    
    <!--- Set up the HTTP request to DeepL --->
    <cfhttp url="#apiEndpoint#" method="post">
        <cfhttpparam type="formfield" name="auth_key" value="#apiKey#">
        <cfhttpparam type="formfield" name="text" value="#arguments.text#">
        <cfhttpparam type="formfield" name="target_lang" value="#arguments.targetLanguage#">
    </cfhttp>
    
    <!--- Parse the response from DeepL --->
    <cfset response = deserializeJSON(cfhttp.fileContent)>
    
    <!--- Return the translated text --->
    <cfreturn response.translations[1].text>
</cffunction>
<cfif form.word neq "">
    <cfset translatedWord = translateWithDeepL(form.word, SESSION.USER_LANG)>
    <cfoutput>#translatedWord#</cfoutput>
</cfif>
