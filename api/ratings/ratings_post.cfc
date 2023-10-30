<cfcomponent>

    <cffunction name="ocheck_existingRating" access="remote" returntype="any">
        <cfargument name="l_id" type="numeric" required="yes">
        <!---1a) Check to see if this user has already rated this Trainer for this lesson. We do not want to allow duplicate ratings.--->
        
                <cfquery name="existingRating" datasource="#SESSION.BDDSOURCE#">
                   
                   SELECT lesson_id, rating_support, rating_techno, rating_description, rating_teaching FROM lms_rating WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                    
                </cfquery>
                <cfif isDefined(existingRating.rating_support) or isDefined(existingRating.rating_techno) or isDefined(existingRating.rating_description) or isDefined(existingRating.rating_teaching)>
                   
                <cfreturn "1"> 
            
                <cfelse>
                    <cfreturn "0">

                </cfif>
        
        </cffunction>
    <!------------------------------- Second variation of inserting rating based on jquery form -------------------------->
    
    <cffunction name="opost_rating_tech" access="remote" httpMethod="post" returnformat="JSON">
        <cfargument name="l_id" type="numeric" required="yes">
        <cfargument name="tr_id" type="numeric" required="yes">
        <cfargument name="note_support" type="any" required="no">
        <cfargument name="note_techno" type="any" required="no">
        <cfargument name="note_teaching" type="any" required="no">
        <cfargument name="note_description" type="any" required="no">


        <cfif isDefined("l_id") and isDefined("SESSION.USER_ID")>
     <cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
    <cfinvokeargument name="l_id" value="#l_id#"> </cfinvoke>
            
	        <cfset existingRating=ocheck_existingRating(l_id)>
            <cfif existingRating eq "0" >
                
               
              
                <cfquery name="create_rating_tech" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_rating
                    (
                    rating_date,
                    user_id,
                    lesson_id,
                    trainer_id,
                    rating_support,
                    rating_techno,
                    rating_teaching,
                    rating_description
                    )
                    VALUES
                    (
                    <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">,
                    
                    
                    <cfif isdefined("note_support") AND note_support neq "">
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#note_support#">,
                    <cfelse>
                        null,
                    </cfif>
                    
                    <cfif isdefined("note_techno") AND note_techno neq "">
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#note_techno#">,
                        <cfelse> null,
                    
                    </cfif>
                    <cfif isdefined("note_teaching") AND note_teaching neq "">
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#note_teaching#">,
                        <cfelse> null,
                    
                    </cfif>
                    <cfif isdefined("note_description") AND note_description neq "">
                       <cfqueryparam cfsqltype="cf_sql_varchar" value="#note_description#">
                        <cfelse> null
                    </cfif>  
                    
                    )
                </cfquery>

<cfset note_support = IsDefined("note_support") ? note_support : "N/A">
<cfset note_teaching = IsDefined("note_teaching") ? note_teaching : "N/A">
<cfset note_techno = IsDefined("note_techno") ? note_techno : "N/A">
<cfset note_description = IsDefined("note_description") ? note_description : "N/A">

            <cfinvoke component="api/task/task_post" method="insert_task">
                <cfinvokeargument name="task_type_id" value="286">
                <cfinvokeargument name="u_id" value="#u_id#">
                <cfinvokeargument name="task_channel_id" value="6">
                <cfinvokeargument name="log_remind" value="#now()#">
                <cfinvokeargument name="log_remind_ok" value="1">
                <cfinvokeargument name="log_text" 
                value="NOTE SUPPORT: #note_support#, NOTE TEACHING: #note_teaching#, NOTE TECHNO: #note_techno#, COMMENT: #note_description#">
                <cfinvokeargument name="task_category" value="FEEDBACK">
            </cfinvoke>
        
                
                <cfif (isdefined("note_support") AND note_support lte 3) OR (isdefined("note_teaching") AND note_teaching lte 3) OR (isdefined("note_techno") AND note_techno lte 3)>
                    <cfinvoke component="api/task/task_post" method="insert_task">
                        <cfinvokeargument name="task_type_id" value="270">
                        <cfinvokeargument name="u_id" value="#u_id#">
                        <cfinvokeargument name="task_channel_id" value="6">
                        <cfinvokeargument name="log_remind" value="#now()#">
                        <cfinvokeargument name="log_remind_ok" value="1">
                        <cfinvokeargument name="task_category" value="TO DO">
                    </cfinvoke>
                    <cfset subject = "[LMS] | Alerte Note | #get_lesson.learner_firstname# #get_lesson.learner_lastname# | #get_lesson.trainer_firstname#">
                        
                    <cfmail from="WEFIT <service@wefitgroup.com>" to="rremacle@wefitgroup.com,service@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                        <cfinclude template="../../email/email_warning_note.cfm">
                    </cfmail>
                </cfif>

                 <cfelse>
                    <cfreturn "tech already rated">
            
                 

            </cfif>
        </cfif>
    </cffunction>
<cffunction name="delete_rating" access="remote" method="POST" returntype="any" returnformat="json">

        <cfargument name="r_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="del_rating" datasource="#SESSION.BDDSOURCE#">

            delete from lms_rating 
            WHERE rating_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#r_id#">
        </cfquery>

       

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn "0">

        </cfcatch>
        </cftry>
    
    </cffunction>




    <cffunction name="switch_rating_highlight" access="remote" method="POST" returntype="any" returnformat="json">

        <cfargument name="r_id" type="numeric" required="yes">

        <cftry>
    
        <cfquery name="update_rating" datasource="#SESSION.BDDSOURCE#">

            UPDATE lms_rating SET rating_highlight = not rating_highlight
            WHERE rating_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#r_id#">
        </cfquery>

        <cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
            SELECT rating_highlight FROM lms_rating
            WHERE rating_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#r_id#">
        </cfquery>
        
        <cfreturn get_rating.rating_highlight>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn "0">

        </cfcatch>
        </cftry>
    
    </cffunction>

</cfcomponent>