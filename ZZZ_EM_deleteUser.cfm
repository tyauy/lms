<cfabort>
<!--- Get user ID from form submission --->
<cfparam name="form.user_id" default="">

<cftry>
    <!--- Update user in the database --->
    <cfquery name="deleteUser" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM user
        WHERE user_id = #form.user_id#
      </cfquery>
    
    <!--- Display success message --->
    <cfset successMessage = "User updated successfully!">
    <cflocation url="_EM_maj_user_rm.cfm?message=#successMessage#" addtoken="false">

    <cfcatch>
        <!--- Display error message --->
        <cfset errorMessage = "Error updating user: #cfcatch.message#">
        <cflocation url="_EM_maj_user_rm.cfm?message=#errorMessage#" addtoken="false">
    </cfcatch>
</cftry>
