
<cfif isDefined("form.question")>
    <cfset userQuestion = form.question>
    <cftry>
        <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='{"model": "gpt-3.5-turbo", "messages": [{"role": "system", "content": "You are a helpful assistant."}, {"role": "user", "content": "#userQuestion#"}]}'>
        </cfhttp>
        <!---  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 --->
        <cfset response = {}>
            <cfif IsJSON(result.fileContent)>
                <cfset response = DeserializeJSON(result.fileContent)>
            <cfelse>
                <cflog file="error" text="Invalid JSON: #result.fileContent#">
            </cfif>

        <!--- 
        <cfdump var="#response#">
        <cfdump var="#result#"> --->
        <cfif isDefined("result.statusCode") and result.statusCode eq "200 OK">
            <cfset response = DeserializeJSON(result.fileContent)>
            <!--- <cfdump var="#response#"> --->
            <cfif structKeyExists(response, "choices") AND arrayLen(response.choices) GTE 1 AND structKeyExists(response.choices[1], "message") AND structKeyExists(response.choices[1].message, "content")>
                <cfoutput>
                    <h2>Your question:</h2>
                    <p>#htmleditformat(form.question)#</p>
                    <h2>Answer:</h2>
                    <p>#htmleditformat(response.choices[1].message.content)#</p>
                </cfoutput>
                <cflog file="error" text="Error processing request. Message: #cfcatch.message#, Detail: #cfcatch.detail#, Type: #cfcatch.type#, TagContext: #serializeJSON(cfcatch.tagcontext)#">

                <cfoutput>
                    <p>Error: Unexpected structure in JSON response.</p>
                </cfoutput>
            </cfif>
        <cfelse>
            <cfoutput>
                <p>Sorry, there was an error processing your question. Please try again later.</p>
                <cfif isDefined("result.statusCode")>
                    <p>Status code: #result.statusCode#</p>
                </cfif>
                <cfif isDefined("result.fileContent")>
                    <p>Response body: #result.fileContent#</p>
                </cfif>
            </cfoutput>
        </cfif>
        
        <cfcatch>
            <cflog file="error" text="Error processing request. Message: #cfcatch.message#, Detail: #cfcatch.detail#, Type: #cfcatch.type#, TagContext: #serializeJSON(cfcatch.tagcontext)#">


            <cfoutput>
                <p>An error occurred while processing your request. Please try again later.</p>
                <p>Error Message: #htmleditformat(cfcatch.message)#</p>
                <p>Error Detail: #htmleditformat(cfcatch.detail)#</p>
                <p>Error Type: #htmleditformat(cfcatch.type)#</p>
                <cfdump var="#cfcatch.tagcontext#">
            </cfoutput>
        </cfcatch>
        
    </cftry>
</cfif>
