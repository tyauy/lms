<cfif IsDefined("form.keyword_id") AND IsDefined("form.parent_id") AND IsDefined("form.checked")>

    <cfquery name="get_parent_id" datasource="#SESSION.BDDSOURCE#">
        SELECT parent_id
        FROM lms_keyword2
        WHERE keyword_id = <cfqueryparam value="#form.keyword_id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
    
    <cfif form.checked EQ 1>
        <!--- If the checkbox is checked, we add the parent_id to the list --->
        <cfset newParentIdList = ListAppend(get_parent_id.parent_id, form.parent_id)>
    <cfelse>
        <!--- If the checkbox is unchecked, we remove the parent_id from the list --->
        <cfset newParentIdList = ListDeleteAt(get_parent_id.parent_id, ListFind(get_parent_id.parent_id, form.parent_id))>
    </cfif>

    <cfquery datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_keyword2
        SET parent_id = <cfqueryparam value="#newParentIdList#" cfsqltype="CF_SQL_LONGVARCHAR">
        WHERE keyword_id = <cfqueryparam value="#form.keyword_id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>

    <cfoutput>"Success"</cfoutput>



<cfelseif isDefined("URL.key") AND URL.key EQ 1>
    <cfif NOT isDefined("URL.keyword_id")>
        <cfoutput>Missing keyword_id parameter</cfoutput>
        <cfabort>
    </cfif>
    
    <cfparam name="URL.keyword_id" default="0">
    
    <cfquery name="getParents" datasource="#SESSION.BDDSOURCE#">
        SELECT parent_id
        FROM lms_keyword2
        WHERE keyword_id = <cfqueryparam value="#URL.keyword_id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>

    <cfquery name="getParentKeywords" datasource="#SESSION.BDDSOURCE#">
        SELECT keyword_id, keyword_name_en, parent_id
        FROM lms_keyword2
    </cfquery>
    
    <cfset counter = 0>
    
    <cfloop query="getParentKeywords">
    <cfoutput>   
        <cfif counter MOD 3 EQ 0>
            <div class="row">
        </cfif>
    
        <div class="col-md-4">
            <cfif ListFindNoCase(getParents.parent_id, getParentKeywords.keyword_id)>
                <input type="checkbox" class="parent-checkbox" data-keyword="#URL.keyword_id#" data-parent="#getParentKeywords.keyword_id#" checked> #getParentKeywords.keyword_name_en#<br>
            <cfelse>
                <input type="checkbox" class="parent-checkbox" data-keyword="#URL.keyword_id#" data-parent="#getParentKeywords.keyword_id#"> #getParentKeywords.keyword_name_en#<br>
            </cfif>
        </div>
    
        <cfset counter++>
    
        <cfif counter MOD 3 EQ 0>
           </div>
        </cfif>
    </cfoutput>
    </cfloop>
    
    <cfif counter MOD 3 NEQ 0>
    </div>
    </cfif>


    
    
  
<cfelse><cfoutput>"Error: Invalid parameters."</cfoutput>

</cfif>
