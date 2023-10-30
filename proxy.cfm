<cfparam name="form.file" default="">

<cftry>

  <cfif len(trim(form.file))>
    
      <!--- File is present in the form. Now, we save it, loves. --->

      <cfset uploadDirectory = "#SESSION.BO_ROOT#/assets/img_task/">
      


        <cffile action = "upload" 
        filefield = "file" 
        destination = "#uploadDirectory#"
        result="uploaded_file"
        nameConflict = "Overwrite"
        mode="777">
        <cfset uploadedFilePath = "/assets/img_task/" & uploaded_file.clientFile>
      
  	

      <!--- Return a JSON response with the URL of the uploaded file. --->

      <cfoutput>
          <cfset response = {
              "location": "#uploadedFilePath#"
          }>
          #serializeJSON(response)#
      </cfoutput>
       <!--- <cflocation addtoken="no" url="db_task_list.cfm?reload">--->
  <cfelse>
      <!--- No file was provided in the form. --->

      <cfoutput>
          <p>Error: No file provided.</p>
      </cfoutput>
  </cfif>

  <cfcatch type="Any">
      <!--- Log the error for debugging. --->
      <cfset errorResponse = {
        "Error": "An error occurred",
        "Message": cfcatch.message,
        "Detail": cfcatch.Detail
      }>
      <cfcontent type="application/json" reset="true">
      <cfoutput>#serializeJSON(errorResponse)#</cfoutput>
  </cfcatch>
</cftry>
