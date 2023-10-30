<cfparam name="URL.qu_id" default="0">

<cfinvoke 
    component="api/mapping/mapping_get.cfc" 
    method="getMappingExplanation" 
    returnVariable="mappingDescription">
    <cfinvokeargument name="qu_id" value="#URL.qu_id#">
</cfinvoke>

<cfoutput>
    #mappingDescription#
</cfoutput>
