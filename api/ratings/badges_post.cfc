<cfcomponent name="badges_post">

    <!---------------------------- Sending eval to DB ------------------------------------->
    <cffunction name="ocheck_existingBadge" access="remote"  returntype="query">
        <cfargument name="l_id" type="numeric" required="yes">
    <!---1a) Check to see if this user has already rated this Trainer for this lesson. We do not want to allow duplicate ratings.--->
    
            <cfquery name="existingBadge" datasource="#SESSION.BDDSOURCE#">
                SELECT
                    ba.badge_id as badge_id
                FROM
                    lms_badge_attribution as ba
                WHERE
                    ba.lesson_id = <cfqueryparam value="#l_id#" cfsqltype="cf_sql_integer" />
            </cfquery>
    
            <cfreturn existingBadge>
    
    
    
    </cffunction>
        
    <cffunction name="oinsert_Badge" access="remote"  returntype="any" output="false" returnformat="plain">
        <cfargument name="badges" required="yes">
        <cfargument name="l_id" required="yes">
        <cfargument name="u_id" required="yes">
        <cfargument name="tr_id" required="yes">
    
    
        <cfset badges_list=deserializeJSON(badges)>
        <!--- <cfdump var="#badges_list#" > --->
        <!--- 1b) If the badge exists, send error message. --->
        <cfset existingBadge=ocheck_existingBadge(l_id)>
    
        <cfif existingBadge.recordCount gt 0 >
            <cfreturn 2>
        <cfelse>
        
            
                    <!--- <cftry> --->
                    <cfloop array="#badges_list#" index="b_id" >
                    <cfquery name="insert_badges" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_badge_attribution
                    (
                    
                    badge_id,
                    badge_learner_id,
                    badge_trainer_id,
                    lesson_id,
                    badge_date
            
                    )
                    VALUES
                    
                        (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#b_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                        <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">	
                        )
                </cfquery>
                </cfloop>	

                <cfquery name="get_badges" datasource="#SESSION.BDDSOURCE#">
                    Select badge_name_en from lms_badge_attribution lba
                    left join lms_badge_index lbi on lba.badge_id=lbi.badge_id
                    where lba.lesson_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                </cfquery>
                
                <!--- Initialize a variable to hold the list of badge names --->
                <cfset badgeList = "">
                
                <!--- Loop over the query result and append each badge name to the list --->
                <cfloop query="get_badges">
                    <cfset badgeList = ListAppend(badgeList, get_badges.badge_name_en)>
                </cfloop>
                
                <cfinvoke component="api/task/task_post" method="insert_task">
                    <cfinvokeargument name="task_type_id" value="286">
                    <cfinvokeargument name="u_id" value="#u_id#">
                    <cfinvokeargument name="task_channel_id" value="6">
                    <cfinvokeargument name="log_remind" value="#now()#">
                    <cfinvokeargument name="log_remind_ok" value="1">
                    <cfinvokeargument name="log_text" value="Badges given to trainer: #badgeList#">
                    <cfinvokeargument name="task_category" value="FEEDBACK">
                </cfinvoke>
                 
                       <!--- <cfcatch type="any">
                        Error: <cfoutput>#cfcatch.type#</cfoutput> : <cfoutput>#cfcatch.message#</cfoutput>
                        <cfoutput>#cfcatch.extendedInfo#</cfoutput>
                        <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
                        
                    </cfcatch>
                    </cftry>	 --->
            <cfreturn 0>	
        </cfif> 
                <!--- 	<cfdump var="#insert_ratings#">  --->
                 
            </cffunction>
            </cfcomponent>