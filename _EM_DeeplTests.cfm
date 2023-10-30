<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <cfinclude template="incl/incl_head.cfm">
</head>
<cfsilent>


<!---     <cfset secure = "2,5,6,4,12">
    <cfinclude template="./incl/incl_secure.cfm">	 --->
</cfsilent>   

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


<body>
    <div class="wrapper">
    
	    <cfinclude template="./incl/incl_sidebar.cfm">
	
        <div class="main-panel">
        
            <cfset title_page = "Deepl translator">
            <cfinclude template="./incl/incl_nav.cfm">

                
            <div class="content">
                <div class="container mt-5">
     
            

                    <!--- Display the form for user input --->
                    <form action="" method="post" class="border p-4 rounded">
                        <div class="form-group">
                            <label for="textToTranslate">Text to Translate:</label>
                            <textarea name="textToTranslate" rows="4" class="form-control"></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="targetLanguage">Target Language:</label>
                            <select name="targetLanguage" class="form-control">
                                <option value="DE">German</option>
                                <option value="FR">French</option>
                                <!--- Add other languages as needed --->
                            </select>
                        </div>
                        
                        <input type="submit" value="Translate" class="btn btn-primary">
                    </form>

                            <!--- Check if the form has been submitted and handle it --->
                            <cfif structKeyExists(form, "textToTranslate") AND structKeyExists(form, "targetLanguage")>
                                <!--- Call the translateWithDeepL function with the user's input --->
                                <cfset translatedText = translateWithDeepL(form.textToTranslate, form.targetLanguage)>
                                <cfoutput>
                                    <!--- Display the translated text --->
                                    <div class="card mb-4">
                                        <div class="card-header bg-primary text-white">
                                            Translated Text
                                        </div>
                                        <div class="card-body">
                                            <p class="card-text">#translatedText#</p>
                                        </div>
                                    </div>
                                </cfoutput>
                                
                            </cfif>

                </div>
            
            </div>
        <cfinclude template="./incl/incl_footer.cfm">  
        </div>
        
    </div>
    <cfinclude template="./incl/incl_scripts.cfm">
    <cfinclude template="./incl/incl_scripts_vocab.cfm">

</body>
</html>