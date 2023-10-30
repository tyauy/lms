<cfquery name="get_keyword_children" datasource="#SESSION.BDDSOURCE#">
SELECT k.keyword_id, k.keyword_name_#lang_temp# as keyword_name FROM lms_keyword2 k 
INNER JOIN lms_sessionmaster_keywordid_cor skwc ON skwc.keyword_id = k.keyword_id
WHERE (is_active = 0 OR parent_id <> 0)
AND sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_kwid" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_sessionmaster_keywordid_cor WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<div class="row">
    <cfif get_keyword_children.recordcount neq "0">
    <div class="col-6">
        <cfoutput query="get_keyword_children">
            <label class="d-inline"><input type="checkbox" name="keyword_id" id="keyword_id" value="#keyword_id#" <cfif arrayFind(ValueArray(get_kwid,"keyword_id"),keyword_id)>checked</cfif>> #keyword_name#</label>				
        </cfoutput>
    </div>
    </cfif>
    <div class="col-6">
        <div class="form-row">
            <div class="col-7">
                <input type="text" name="kw_name" id="kw_name" value="" class="form-control">
            </div>
            <div class="col-3">
                <input class="btn btn-sm btn-outline-red btn-block btn_kw_submit" value="add">
            </div>
        </div>
    </div>
</div>
        

