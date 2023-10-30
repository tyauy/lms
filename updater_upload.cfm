<cfif isdefined("l_id") AND (listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)) AND isdefined("add_ln")>
			
	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#")>
	
	<cfif isdefined("lesson_attach") AND lesson_attach neq "">
	
		<cfset dir_go = "#SESSION.BO_ROOT#/assets/attachment">
			
		<cffile action = "upload" 
		filefield = "lesson_attach" 
		destination = "#dir_go#" 
		nameConflict = "Overwrite"
		mode="777">					
						
		<cfif cffile.FileWasSaved>	

			<cfif cffile.clientFileExt neq "pdf" AND cffile.clientFileExt neq "jpg" AND cffile.clientFileExt neq "jpeg" AND cffile.clientFileExt neq "png" AND cffile.clientFileExt neq "docx" AND cffile.clientFileExt neq "doc" AND cffile.clientFileExt neq "txt">
			
				<cffile action="DELETE" file="#dir_go#/#cffile.ClientFile#">
			
				Unsupported File Format...  Please <a href="trainer_index.cfm">go back</a> and try again !
				
				<cfabort>		
			
			</cfif>
			
			<cfif (CFFILE.FileSize GT (5000 * 1024))>
			
				<cffile action="DELETE" file="#dir_go#/#cffile.ClientFile#">
			
				File too big... Please <a href="trainer_index.cfm">go back</a> and try again !
				
				<cfabort>			
			
			</cfif>
			
			<cffile action="rename" 
			source = "#dir_go#/#cffile.ClientFile#" 
			destination = "#dir_go#/#l_id#_#dateformat(now(),'yyyyddmm')##timeformat(now(),'HHmmss')#.#cffile.clientFileExt#" 
			attributes="normal"
			mode="777"> 
			
		</cfif>
		
	</cfif>
	
	<cfif isdefined("finalise_lesson")>
	
		<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson2 SET status_id = "5", completed_date = now() WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		</cfquery>	
		
		<!---------------------------- LEARNER NOTIFICATION ----------------------->
		<cfif get_lesson.learner_lang eq "fr">
			<cfset subject = "WEFIT | Votre compte rendu de cours">
		<cfelseif get_lesson.learner_lang eq "en">
			<cfset subject = "WEFIT | Your lesson note is available">
		<cfelseif get_lesson.learner_lang eq "de">
			<cfset subject = "WEFIT | Ihre Lesson Note ist jetzt verf�gbar">
		<cfelseif get_lesson.learner_lang eq "es">
			<cfset subject = "WEFIT | Your lesson note is available">
		<cfelseif get_lesson.learner_lang eq "it">
			<cfset subject = "WEFIT | Your lesson note is available">
		</cfif>
		
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#get_lesson.learner_email#" subject="#subject#" type="html" server="localhost">
			<cfset lang = get_lesson.learner_lang>
			<cfset status = "complete">
			<cfset recipient = "learner">			
			<cfinclude template="./email/email_lesson_status.cfm">		
		</cfmail>		
	
	</cfif>	
	
	<cfif SESSION.USER_PROFILE eq "TRAINER">
		<cflocation addtoken="no" url="trainer_index.cfm?k=2">
	<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<cflocation addtoken="no" url="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#">
	</cfif>
	
<cfelseif isdefined("lesson_delete") AND lesson_delete neq "" AND isdefined("l_id") AND (listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>

	<cfif fileexists("#SESSION.BO_ROOT#/assets/attachment/#lesson_delete#") AND findnocase("#l_id#_",lesson_delete)>
	<cffile action = "delete" file = "#SESSION.BO_ROOT#/assets/attachment/#lesson_delete#">
	</cfif>

	<cflocation addtoken="no" url="trainer_index.cfm?k=3">
		
</cfif>