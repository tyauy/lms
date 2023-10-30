<cfif isdefined("a_id") AND isdefined("g_id")>
			
	<cftry>

		
	
	<cfset dir_go = "#SESSION.BO_ROOT#/assets/img_group">
    <cfdump var="#dir_go#">
			
	<cffile action = "upload" 
	filefield = "image" 
	destination = "#dir_go#" 
    result="fileUpload"
	nameConflict = "Overwrite"
	mode="777">					
						
    <cfdump var="#fileUpload#">
	<cfif fileUpload.FileWasSaved>	

		<cfif  fileUpload.clientFileExt neq "jpg" AND fileUpload.clientFileExt neq "jpeg" AND fileUpload.clientFileExt neq "png">
			
			<cffile action="DELETE" file="#dir_go#/#fileUpload.ClientFile#">
			
			Unsupported File Format...  Please <a href="crm_account_edit.cfm?a_id=<cfoutput>#a_id#</cfoutput>">go back</a> and try again !
				
			<cfabort>		
			
		</cfif>
			
		<cfif (fileUpload.FileSize GT (5000 * 1024))>
			
			<cffile action="DELETE" file="#dir_go#/#fileUpload.ClientFile#">
			
			File too big... Please <a href="crm_account_edit.cfm?a_id=<cfoutput>#a_id#</cfoutput>">go back</a> and try again !
				
			<cfabort>			
			
		</cfif>

		<cfif isDefined("up_img")>
			<cffile action="delete" file="#dir_go#/#g_id#.#up_img#">
			<cfdump var="#dir_go#/#g_id#.#up_img#">
			<br>
		</cfif>

		<cfdump var="#dir_go#/#fileUpload.ClientFile#">
		<br>
		<cfdump var="#dir_go#/#g_id#.#fileUpload.clientFileExt#">

		<cffile action="rename" 
		source = "#dir_go#/#fileUpload.ClientFile#" 
		destination = "#dir_go#/#g_id#.#fileUpload.clientFileExt#" 
		attributes="normal"
		mode="777"> 
			
        <cfdump var="end">
	</cfif>
		

	
	<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#">

	<cfcatch type="any">
		Error: <cfoutput>#cfcatch.message#</cfoutput>
		<cflocation addtoken="no" url="crm_account_edit.cfm?a_id=#a_id#">
	</cfcatch>
	</cftry>
		
</cfif>