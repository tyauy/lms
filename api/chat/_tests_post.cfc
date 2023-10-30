<cfcomponent>

    <cffunction name="generate_quiz" access="public" returntype="string" output="false">
        <cfset myStructure = structNew()>
        <cfset myStructure["sessionmaster_id"] = "924">
        <cfset myStructure["sessionmaster_name"] = "Opening a meeting">
        <cfset myStructure["sessionmaster_description"] = "One of the best ways to ensure the smooth flow of a 
        meeting is to start it right. Opening the meeting with the right expressions and vocabulary 
        words will help make the participants understand the objectives of the meeting clearly.">
    
        <cfset jsonObject = serializeJSON(myStructure)>
    
        <cfreturn jsonObject>

    

		  <!--- <cfargument name="user_id" type="numeric" required="no">
	
		   <!--- Query for the sessionmaster related to the user --->
           <cfquery name="get_lesson_info" datasource="#SESSION.BDDSOURCE#">
            SELECT m.sessionmaster_id, m.sessionmaster_name, m.sessionmaster_description
            FROM lms_tp tp
            INNER JOIN lms_tpsession s ON tp.tp_id = s.tp_id
            INNER JOIN lms_tpsessionmaster2 m ON s.sessionmaster_id = m.sessionmaster_id
            WHERE tp.user_id = <cfqueryparam value="#user_id#" cfsqltype="CF_SQL_INTEGER">
            and m.sessionmaster_id=924
        </cfquery>

        <cfset lesson_info=arraynew(1)>
        <cfoutput query="get_lesson_info">
            <cfset temp=arrayAppend(lesson_info, structNew())>
            <!----ID ----->
            <cfset lesson_info[currentrow].id=sessionmaster_id>
            <!----Name ----->
            <cfset lesson_info[currentrow].name=sessionmaster_name>
            <!----DESCRIPTION ----->
            <cfset lesson_info[currentrow].desc=sessionmaster_description>
        </cfoutput>

		<cfset quiz_js = serializeJSON(lesson_info)>
        <cfcontent type="application/json; charset=utf-8">

        <cfoutput>#lesson_info#</cfoutput> --->

	
	</cffunction>

    
    <cffunction name="send_go" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="question" type="string" required="yes">
        <cfargument name="user_id" type="numeric" required="yes">
        
     
    
        <cfset logFile = ExpandPath("./debug.log")>
        <cfset userID = arguments.user_id>
        <cffile action="append" file="#logFile#" output="User ID: #userID#; Session: #serializeJSON(generate_quiz)#" addnewline="Yes">
 
        <!--- Ask the question --->
        <cfset messages = [
            {"role": "user", 
             "content": question
            }
        ]>
    
        <!--- Define the function for generating a quiz in the GPT-3 format --->
        <cfset function_definitions = [
            {
                "name": "generate_quiz",
                "description": "Generate a quiz from a lesson",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "sessionmaster_name": {
                            "type": "string",
                            "description": "The name of the lesson"
                        }
                    },
                    "required": ["sessionmaster_name"]
                }
            }
        ]>
     
    
        <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='#SerializeJSON({
                "model": "gpt-3.5-turbo", 
                "messages": messages,
                "functions"=function_definitions,
                "function_call"="auto"
            })#'>
        </cfhttp>
    
        <cfset response = {}>
        <cfif IsJSON(result.fileContent)>
            <cfset response = DeserializeJSON(result.fileContent)>
        </cfif>
    
      <!--- Debug: Print out the response from the API --->
        <cffile action="append" file="#logFile#" output="Response: #SerializeJSON(response)#" addnewline="Yes">

   <!--- Check if the GPT model wants to call a function --->
   <cfif structKeyExists(response, "choices") AND arrayLen(response.choices) GT 0 AND structKeyExists(response.choices[1].message, "function_call")>
    <cfset function_call = response.choices[1].message.function_call>
    <cfif isJSON(function_call)>
        <cfset function_call = deserializeJSON(function_call)>
    <cfif structKeyExists(function_call, "name") AND function_call.name EQ "generate_quiz">
        <!--- The GPT model has generated a quiz, so insert this into a new message --->
        <cfif structKeyExists(function_call.arguments, "sessionmaster_name") AND structKeyExists(function_call.arguments, "sessionmaster_description")>
            <cfset function_response = generate_quiz()>
            <cfset arrayAppend(messages, {"role": "function", "name": "generate_quiz", "content": function_response})>
            
          <!--- Call the GPT model again here and store the response in the 'result' variable --->
          <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='#SerializeJSON({"model": "gpt-3.5-turbo", "messages": messages})#'>
        </cfhttp>

        <cfset response = {}>
        <cfif IsJSON(result.fileContent)>
            <cfset response = DeserializeJSON(result.fileContent)>
        </cfif>

        </cfif>
    </cfif>
</cfif>
</cfif>

               
       
    <cfif structKeyExists(response, "choices") AND arrayLen(response.choices) GTE 1 AND structKeyExists(response.choices[1], "message") AND structKeyExists(response.choices[1].message, "content")>
            <cfset answer = response.choices[1].message.content>
        <cfelse>
            <cfset answer = "Sorry, there was an error processing your question. Please try again later.">
        </cfif>

        <!--- Insert the question and answer into the database --->
        <cfquery name="insertConversation" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_chat_conversation_feed (prompt_question, prompt_answer, user_id, timestamp)
            VALUES (
                <cfqueryparam value="#question#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#answer#" cfsqltype="CF_SQL_VARCHAR">,
                <cfqueryparam value="#user_id#" cfsqltype="CF_SQL_INTEGER">,
                NOW()
            )
        </cfquery>

        <cfset result = {
            "html": '
                <div class="d-flex flex-column">
                    <div class="p-2 bg-success text-white w-50 mb-2 rounded">
                        ' & question & '
                    </div>
                    <div class="p-2 bg-info text-white w-50 ml-auto mb-2 rounded">
                        ' & answer & '
                    </div>
                </div>
            '
        }>


        <cfreturn result>
 
    </cffunction>
    
    
    </cfcomponent>
    