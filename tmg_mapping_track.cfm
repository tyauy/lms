<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <cfinclude template="incl/incl_head.cfm">
</head>
<cfsilent>
    <cfquery name="getTrainers" datasource="#SESSION.BDDSOURCE#">
        SELECT DISTINCT u.user_id, u.user_firstname, u.user_name
        FROM lms_quiz_question q
        JOIN user u ON q.qu_updated_by = u.user_id
        WHERE q.is_treated = 2
        ORDER BY u.user_firstname, u.user_name
    </cfquery>
    

<!---     <cfset secure = "2,5,6,4,12">
    <cfinclude template="./incl/incl_secure.cfm">	 --->
</cfsilent>   

<body>
    <div class="wrapper">
    
	    <cfinclude template="./incl/incl_sidebar.cfm">
	
        <div class="main-panel">
        
            <cfset title_page = " trainer mapping tracking">
            <cfinclude template="./incl/incl_nav.cfm">

                
            <div class="content">
                <div class="container mt-5 d-flex justify-content-center align-items-center" >
                    <form action="tmg_mapping_track.cfm" method="post">
                    <select id="trainerDropdown" name="trainer">
                        <option value="0">Select a trainer</option>
                        <cfoutput query="getTrainers">
                            <option value="#user_id#">#user_firstname# #user_name#</option>
                        </cfoutput>
                    </select>
                    <input type="submit" value="Submit">
                    </form>
                </div>

                <cfif isDefined("form.trainer") AND form.trainer NEQ "0">
                    <cfquery name="getQuestions" datasource="#SESSION.BDDSOURCE#">
                        SELECT 
                            qu_updated_by,
                            qu_updated_date
                        FROM lms_quiz_question
                        WHERE qu_updated_by = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.trainer#">
                          AND is_treated = 2
                        ORDER BY qu_updated_date
                    </cfquery>

                    <!--- Initialize a structure to hold the session data --->
                    <cfset sessions = [] />
                    <cfset currentSession = {} />
                    <cfset prevDate = "">
               <!--- Check if there are any records in the getQuestions query --->
                    <cfif getQuestions.recordCount gt 0>
                        <!--- Initialize the current session with the first record's data --->
                        <cfset currentSession = {startDate: getQuestions.qu_updated_date[1], endDate: getQuestions.qu_updated_date[1], questionCount: 0} />
                    <cfelse>
                        <!--- If there are no records, initialize with empty values --->
                        <cfset currentSession = {startDate: "", endDate: "", questionCount: 0} />
                    </cfif>

                    <cfset prevDate = "">

                    <!--- Loop over the query results and identify sessions based on the time gap --->
                    <cfloop query="getQuestions">
                        <cfif prevDate neq "" and dateDiff("h", prevDate, getQuestions.qu_updated_date) gte 2>
                            <!--- Save the current session and start a new one --->
                            <cfset arrayAppend(sessions, currentSession) />
                            <cfset currentSession = {startDate: getQuestions.qu_updated_date, endDate: getQuestions.qu_updated_date, questionCount: 1} />
                        <cfelse>
                            <!--- Update the current session --->
                            <cfset currentSession.endDate = getQuestions.qu_updated_date />
                            <cfset currentSession.questionCount++ />
                        </cfif>
                        <cfset prevDate = getQuestions.qu_updated_date />
                    </cfloop>

                    <!--- Save the last session --->
                    <cfset arrayAppend(sessions, currentSession) />



                    <!--- Display the session data in a table --->
                    <cfoutput>
                    <table class="table table-bordered table-hover mt-4">
                        <thead class="text-center">
                            <tr>
                                <th>Date</th>
                                <th>Time Interval</th>
                                <th>Number of Questions Treated</th>
                            </tr>
                        </thead>
                        <tbody class="text-center">
                            <cfloop array="#sessions#" index="session">
                                <tr>
                                    <td>#dateFormat(session.startDate, "dd/mm/yyyy")#</td>
                                    <td>#timeFormat(session.startDate, "HH:mm:ss")# - #timeFormat(session.endDate, "HH:mm:ss")#</td>
                                    <td>#session.questionCount#</td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                    </cfoutput>
                </cfif>
                
            
            </div>
        <cfinclude template="./incl/incl_footer.cfm">  
        </div>
        
    </div>
    <cfinclude template="./incl/incl_scripts.cfm">
    <cfinclude template="./incl/incl_scripts_vocab.cfm">

</body>
</html>