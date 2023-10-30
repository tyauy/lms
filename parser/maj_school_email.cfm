<cfquery name="select_rdy" datasource="#SESSION.BDDSOURCE#">
    SELECT `user_id`, `user_email` FROM `user` WHERE `account_id` = 867
 </cfquery>
 
 
 <cfoutput query="select_rdy">
     <cftry>
 
        <p>
            <cfset test = listgetat(user_email,1,'@', true)>
            #user_email# #test#
        </p>
 

        <!--- <cfquery name="select_rdy" datasource="#SESSION.BDDSOURCE#">
            UPDATE `user` SET user_email = "#test#@etu.iut-tlse3.fr" WHERE `user_id` = #user_id#
         </cfquery> --->
 
         <cfcatch type="any">
             Error: <cfoutput>#cfcatch.message#</cfoutput>
             <!--- <cfreturn 0> --->
         </cfcatch>
     </cftry>
 
 </cfoutput>