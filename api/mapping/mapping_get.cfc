<cfcomponent  name="mapping_get.cfc">
    <cffunction name="getMappingExplanation" access="remote" returnType="string" output="no">
        <cfargument name="qu_id" type="numeric" required="yes">
        
        <cfset var mappingExplanation = "">
        
        <!--- Fetch the main mapping explanation for the given quiz question ID --->
        <cfquery name="getMapping" datasource="#SESSION.BDDSOURCE#">
            SELECT m.mapping_explanation_long_en
            FROM lms_mapping m
            INNER JOIN lms_quiz_question_mapping_cor qm 
                ON m.mapping_id = qm.mapping_id
            WHERE qm.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.qu_id#"> 
            AND qm.is_main = 1
        </cfquery>
        
        <cfif getMapping.recordCount>
            <cfset mappingExplanation = getMapping.mapping_explanation_long_en>
        </cfif>
        
        <cfreturn mappingExplanation>
    </cffunction>

    <cffunction name="send_go" httpMethod="POST" access="remote" returntype="any" returnFormat="JSON">
     <!--- Deserialize incoming JSON data --->
     <cfset incomingData = DeserializeJSON(ToString(getHttpRequestData().content))>

     
     <cfset question_text ="#incomingData.question_text#">
     <cfset question_answer ="#incomingData.question_answer#">
        <cfset logFile = ExpandPath("./debug.log")>
        <cffile action="append" file="#logFile#" output="Question Text: #question_text#" addnewline="Yes">
 
        <!--- Construct the initial message for GPT-3 --->
        <cfset initialMessage = "Given the question '" & question_text & "' and the answer '" 
        & question_answer & "', 
        provide a comprehensive placeholder description that explains the grammar rule 
        associated with the question and answer in a couples of sentences. 
        For example, if 'We can use _____ plus infinitive to talk about plans for the future.' was the question_text 
        and  'Going to' was the answer, the comprehensive placeholder description 
        could be something like : 'Going to' is part of the Present Continuous tense used for a future meaning, 
        formed with the Subject + be (am/is/are) + going to + base form of the main verb, 
        and is employed to express future intentions, plans, or predictions based on present 
        evidence, as in 'She is going to start a new job next week' or 'Look at those dark 
        clouds. It's going to rain soon. In cases where the answer is a word and not a verb, 
        try to focus on the whole sentence structure to deduce a grammar rule from it. For example, 
        for the sentencee, 'Illegal activities are considered unethical.', where unethical is the answer, you could answer: 
        'unethical' is used as a placeholder to describe the moral judgment associated with 
        illegal activities. 
        'Are considered unethical' is a passive voice construction.">
        <cfset messages = [{"role": "user", "content": initialMessage}]>
    
        <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='#SerializeJSON({
                "model": "gpt-3.5-turbo", 
                "messages": messages
            })#'>
        </cfhttp>
    
        <cfset response = {}>
        <cfif IsJSON(result.fileContent)>
            <cfset response = DeserializeJSON(result.fileContent)>
        </cfif>
    
        <!--- Debug: Print out the response from the API --->
        <cffile action="append" file="#logFile#" output="Response: #SerializeJSON(response)#" addnewline="Yes">

        <cfif structKeyExists(response, "choices") AND arrayLen(response.choices) GTE 1 AND structKeyExists(response.choices[1], "message") AND structKeyExists(response.choices[1].message, "content")>
            <cfset answer = response.choices[1].message.content>
        <cfelse>
            <cfset answer = "Sorry, there was an error processing your request. Please try again later.">
        </cfif>

        <cfset result = {
            "placeholder": answer
        }>

        <cfreturn result>
 
    </cffunction>

    <cffunction name="getMappingSuggestion" access="remote" returntype="any" returnFormat="JSON">
       
        

    
        <cfset var questionCell = FORM.question_cell>
        <cfset var answerCell = FORM.answer_cell>
        <cfset var quiz_level = FORM.quiz_level>
        <cfset var lmsMappings = DeserializeJSON(FORM.lms_mappings)>

        <cfset logFile = ExpandPath("./debug.log")>
        <cffile action="append" file="#logFile#" output="Question Text: #questionCell#" addnewline="Yes">
 
        <!--- Construct the initial message for GPT-3 --->
        <cfset initialMessage = "Given the question '" & questionCell & "', the answer '" 
        & answerCell & "', the quiz level'" & quiz_level & "' and the following mapping points '" 
        & SerializeJSON(lmsMappings) & "',  
        provide a list of possible mapping points that correspond to the question and answer. 
        Provide a maximum of six possible mapping points, 
        selecting the most relevant by focusing on the mapping points pertaining to the quiz_level first.
        For example, if 'We can use _____ plus infinitive to talk about plans for the future.' 
        was the questionCell
        and  'Going to' was the answerCell, and the quiz_level was A.1.3, the list of possible mapping points
        could be something like :
        'Going to' (A1.3)
        'Present Continuous for the future' (A2.1)
        'Will/Going to Vs Present Tenses' (B1.3)
        
        Only provide suggestions that are directly related to the question and answer. 
        In no case should you suggest mapping points that are not already present in lmsMappings.
        Example, for 'I bought a house recently' (A2), you could suggest 
        - Past Simple (A1.3)
        - Present Perfect Vs Past Simple (B1.1)
        but not 
        - Past Simple (A1.3)
        - Present Perfect (A2.2)
        - Present Perfect Vs Past Simple (B1.1)
        - Past Perfect (B1.2)
        ">
        <cfset messages = [{"role": "user", "content": initialMessage}]>
    
        <cfhttp url="https://api.openai.com/v1/chat/completions" method="post" result="result">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Authorization" value="Bearer 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">
            <cfhttpparam type="body" value='#SerializeJSON({
                "model": "gpt-3.5-turbo", 
                "messages": messages
            })#'>
        </cfhttp>

        <cfset response = {}>
        <cfif IsJSON(result.fileContent)>
            <cfset response = DeserializeJSON(result.fileContent)>
        </cfif>
    
        <!--- Debug: Print out the response from the API --->
        <cffile action="append" file="#logFile#" output="Response: #SerializeJSON(response)#" addnewline="Yes">
        <cfif structKeyExists(response, "choices") AND arrayLen(response.choices) GTE 1 AND structKeyExists(response.choices[1], "message") AND structKeyExists(response.choices[1].message, "content")>
            <cfset answer = response.choices[1].message.content>
        <cfelse>
            <cfset answer = "Sorry, there was an error processing your request. Please try again later.">
        </cfif>

        <cfset result = {
            "suggestion": answer
        }>

        <cfreturn result>
 

       
    </cffunction>
    
    
    
</cfcomponent>
