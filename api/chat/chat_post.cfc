<cfcomponent>

    <cffunction name="send_go" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="question" type="string" required="yes">
        <cfargument name="user_id" type="numeric" required="yes">


          <!--- Query for the sessionmaster related to the user --->
          <cfquery name="getSessionMaster" datasource="#SESSION.BDDSOURCE#">
            SELECT m.sessionmaster_id, m.sessionmaster_name, m.sessionmaster_description
            FROM lms_tp tp
            INNER JOIN lms_tpsession s ON tp.tp_id = s.tp_id
            INNER JOIN lms_tpsessionmaster2 m ON s.sessionmaster_id = m.sessionmaster_id
            WHERE tp.user_id = <cfqueryparam value="#user_id#" cfsqltype="CF_SQL_INTEGER">
            and m.sessionmaster_id=924
            
        </cfquery>

        <cfset logFile = ExpandPath("./debug.log")>
        <cfset userID = arguments.user_id>
        <!--- Dump getSessionMaster result for debugging --->
    
        <cffile action="append" file="#logFile#" output="User ID: #userID#; Session: #serializeJSON(getSessionMaster)#" addnewline="Yes">

        <!--- Query for the previous conversations --->
        <cfquery name="getConversation" datasource="#SESSION.BDDSOURCE#">
            SELECT prompt_question, prompt_answer
            FROM lms_chat_conversation_feed
            WHERE user_id = <cfqueryparam value="#user_id#" cfsqltype="CF_SQL_INTEGER">
            ORDER BY timestamp DESC
        </cfquery>

        <!--- Convert previous conversations to GPT-3 format --->
        <cfset messages = [
            {"role": "system", 
             "content": "You are a helpful assistant teaching a student English. Today you are working on " & getSessionMaster.sessionmaster_name & ". The lesson content was " & getSessionMaster.sessionmaster_description & ". When the learner says hi or hello, you need to first recap what they worked on, then quiz the learner on what they worked on during the lesson."
            }
        ]>

        
       
        <cfloop query="getConversation">
            <cfset arrayAppend(messages, {"role": "user", "content": prompt_question})>
            <cfset arrayAppend(messages, {"role": "assistant", "content": prompt_answer})>
        </cfloop>
        <cfset arrayAppend(messages, {"role": "user", "content": question})>

        <!--- Output messages for debugging --->
        <cffile action="append" file="#logFile#" output="#SerializeJSON(messages)#" addnewline="Yes">



        <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='#SerializeJSON({"model": "gpt-3.5-turbo", "messages": messages})#'>
        </cfhttp>

        <cfset response = {}>
        <cfif IsJSON(result.fileContent)>
            <cfset response = DeserializeJSON(result.fileContent)>
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
