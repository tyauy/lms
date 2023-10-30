<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<cfquery name="getSessions" datasource="#SESSION.BDDSOURCE#">
    SELECT sessionmaster_id, sessionmaster_video
    FROM lms_tpsessionmaster2
    WHERE sessionmaster_video NOT LIKE '%style="%'
    AND sessionmaster_video NOT LIKE '%<iframe%'
</cfquery>

<cfset existingKeywords = ArrayNew(1)>
<cfset newKeywords = ArrayNew(1)>

<cfloop query="getSessions">
    <cfset words = ListToArray(sessionmaster_video, ' ')>
    
    <cfloop array="#words#" index="word">
        <cfset wordWithoutComma = Replace(word, ",", "", "all")>
        
        <cfquery name="getKeyword" datasource="#SESSION.BDDSOURCE#">
            SELECT keyword_id
            FROM lms_keyword2
            WHERE keyword_name_en = <cfqueryparam value="#wordWithoutComma#" cfsqltype="cf_sql_varchar">
        </cfquery>
        
        <cfif getKeyword.recordCount>
            <!--- Check if the pair exists in lms_sessionmaster_keywordid_cor --->
            <cfquery name="checkPair" datasource="#SESSION.BDDSOURCE#">
                SELECT *
                FROM lms_sessionmaster_keywordid_cor
                WHERE sessionmaster_id = <cfqueryparam value="#sessionmaster_id#" cfsqltype="cf_sql_integer">
                AND keyword_id = <cfqueryparam value="#getKeyword.keyword_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <!--- If the pair does not exist in lms_sessionmaster_keywordid_cor, add it to existingKeywords --->
            <cfif NOT checkPair.recordCount>
                <cfset ArrayAppend(existingKeywords, {word=word, keyword_id=getKeyword.keyword_id, sessionmaster_id=sessionmaster_id})>
            </cfif>
        <cfelse>
            <cfset ArrayAppend(newKeywords, {word=word, sessionmaster_id=sessionmaster_id})>
        </cfif>
    </cfloop>
</cfloop>



<!--- Display the arrays to the user for validation --->

<div class="row">
 
    <!--- New Keywords --->
    <div class="col-md-6">
        <cfoutput>
            <h2>STEP1: Approve New Keyword Creation</h2>
           <ul> 
            <li>Take out commas if present. </li>
            <li>If you see something like "TED-EdAnimation", 
                you have to go directly in the material to fix the copy-pasted list. 
                It means a space is missing.</li>
                <li>If the first letter of the keyword is not capitalized, change it for a capital letter</li>
        </ul> 
            <table>
                <tr>
                    <th>Sessionmaster ID</th>
                    <th>Keyword</th>
                    <th>Approve</th>
                </tr>
                <cfloop array="#newKeywords#" index="newKeyword">
                    <tr>
                        <td>#newKeyword.sessionmaster_id#</td>
                        <td><input type="text" id="keyword_#newKeyword.sessionmaster_id#" value="#newKeyword.word#"></td>
                        <td><button type="button" class="approveButton" data-sessionmaster-id="#newKeyword.sessionmaster_id#">Approve</button></td>
                    </tr>
                </cfloop>
            </table>
        </cfoutput>
    </div>
       <!--- Existing Keywords --->
       <div class="col-md-6">
        <cfoutput>
            <h2>STEP 2: Approve Match with Existing Keywords</h2>
            <form action="approve_keyword.cfm" method="post">
                <table>
                    <tr>
                        <th>Sessionmaster ID</th>
                        <th>Keyword</th>
                        <th>Keyword ID</th>
                    </tr>
                    <cfloop array="#existingKeywords#" index="i">
                        <tr>
                            <td>#i.sessionmaster_id#</td>
                            <td>#Replace(i.word, ',', '', 'all')#</td>
                            <td>#i.keyword_id#</td>
                            <!-- Hidden fields to hold the values -->
                            <input type="hidden" name="existingKeyword[#i.sessionmaster_id#][sessionmaster_id]" value="#i.sessionmaster_id#">
                            
                            <input type="hidden" name="existingKeyword[#i.sessionmaster_id#][keyword_id]" value="#i.keyword_id#">
                        </tr>
                    </cfloop>
                    
                </table>
                <input type="hidden" name="key" value="1">
                <input type="submit" value="Approve">
            </form>
            
        </cfoutput>
        

</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
$(document).ready(function() {
    $('.approveButton').click(function() {
        var sessionmaster_id = $(this).data('sessionmaster-id');
        var keyword = $('#keyword_' + sessionmaster_id).val();

        $.ajax({
            type: "POST",
            url: "approve_keyword.cfm",
            data: { 
                sessionmaster_id: sessionmaster_id, 
                keyword: keyword,
                key: 2
            },
            success: function() {
                // Create a Bootstrap alert with the keyword included in the message
                var alert = $('<div class="alert alert-success" role="alert">Keyword "' + keyword + '" approved and inserted successfully!</div>');
                
                // Insert the alert into the DOM
                $('body').prepend(alert);

                // Refresh the page after a delay
                setTimeout(function() {
                    location.reload();
                }, 4500);
            }
        });
    });
});


</script>
