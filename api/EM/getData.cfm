

<cfset learningPlansService = createObject("component", "TM_reports.cfc")>
<cfset data = learningPlansService.getLearningPlans(
    url.startDate,
    url.endDate,
    url.employee,
    url.status
)>

<!--- Convert query result into JSON --->
<cfset jsonData = serializeJSON(data)>

<!--- Set content type to JSON --->
<cfcontent type="application/json">

<!--- Output the JSON data --->
<cfoutput>#jsonData#</cfoutput>
