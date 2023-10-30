<cfcomponent name="personality_post">

	
	
	<!--- <cfdump var="#perso_list#" > --->


<!---------------------------- Sending eval to DB ------------------------------------->
<cffunction name="ocheck_existingpersonality" access="remote"  returntype="query">
	<cfargument name="tr_id" required="yes">
	<cfargument name="u_id" required="yes">
<!---1a) Check to see if this user has already rated this Trainer for this lesson. We do not want to allow duplicate ratings.--->

		<cfquery name="existingpersonality" datasource="#SESSION.BDDSOURCE#">
			SELECT
				*
			FROM
				user_personality as up
			WHERE
				up.user_id = <cfqueryparam value="#tr_id#" cfsqltype="cf_sql_integer" />
			AND
				 up.perso_giver_id = <cfqueryparam value="#u_id#" cfsqltype="cf_sql_integer" /> ;
	
		</cfquery>

		<cfreturn existingpersonality>



</cffunction>
	
<cffunction name="oinsert_personality" access="remote"  returntype="any" output="false" returnformat="plain">
	<!-- Define required arguments -->
	<cfargument name="perso" required="yes">
	<cfargument name="l_id" required="yes">
	<cfargument name="u_id" required="yes">
	<cfargument name="tr_id" required="yes">
	<!-- Convert JSON string to array -->
	<cfset perso_list=deserializeJSON(perso)>
	<!-- Check if rating already exists for the user and trainer -->
	<cfset existingRating=ocheck_existingpersonality(u_id,tr_id)>
	<!-- If rating exists, return 2 -->
	<cfif existingRating.recordCount gt 0 > <cfreturn 2>
	<cfelse>	
		<cftry>
		<!--- Insert new rating --->
		<cfloop array="#perso_list#" index="p_id" >
		<cfquery name="insert_ratings" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO user_personality 
		(
		perso_giver_id,
		lesson_id,
		user_id,
		personality_id,
		personality_date

		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#tr_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">,
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">	
		)
	</cfquery>
	</cfloop>	
		
	<cfquery name="get_personality" datasource="#SESSION.BDDSOURCE#">
		Select perso_name_en from user_personality up
		left join user_personality_index upi on up.personality_id=upi.perso_id
		where up.lesson_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
	</cfquery>
	
	<!--- Initialize a variable to hold the list of personality names --->
	<cfset persoList = "">
	
	<!--- Loop over the query result and append each perso name to the list --->
	<cfloop query="get_personality">
		<cfset persoList = ListAppend(persoList, get_personality.perso_name_en)>
	</cfloop>
	
	<cfset taskResult = createObject("component", "api/task/task_post").insert_task(
		task_type_id=286, 
		u_id=u_id, 
		task_channel_id=6, 
		log_remind=now(), 
		log_remind_ok=1, 
		log_text="Personality given to trainer: " & persoList, 
		task_category="FEEDBACK"
	)>
	
	<cfset writeOutput("Insert task result: " & taskResult)>
	
	<!-- If no error occurs during insertion,  return 1 -->
	<cfreturn 1>
			<!-- If error occurs during insertion, catch it and return 0 -->
			<cfcatch type="any">
				<cflog file="debug" type="ERROR" text="Error: #cfcatch.type# : #cfcatch.message#">
				<cflog file="debug" type="ERROR" text="#cfcatch.extendedInfo#">
				<cfif cfcatch.type eq "database">
					<cflog file="debug" type="ERROR" text="#cfcatch.queryError#">
				</cfif>
				<cfreturn 0>
			</cfcatch>
	</cftry>		
	</cfif> 
	<!--- 	<cfdump var="#insert_ratings#">  --->
	
</cffunction>

<cffunction name="oinsert_teaching" access="remote"  returntype="any" output="false" returnformat="plain">
	<cfargument name="l_id" required="yes">
	<cfargument name="u_id" required="no">
	<cfargument name="tr_id" required="no">

	<!--- 
	<cfset existingRating=ocheck_existingpersonality(u_id,tr_id)>

	<cfif existingRating.recordCount gt 0 >
	
		<cfreturn 2> --->
<!--- 		
	<cfelse>	
		<cftry><! --->
		
		<cfquery name="update_ratings" datasource="#SESSION.BDDSOURCE#">
		update lms_rating
	set 
		rating_teaching = <cfqueryparam cfsqltype="cf_sql_integer" value="#ratingG#">	

		
		where lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
	
	
	</cfquery>

	
</cffunction>
</cfcomponent>