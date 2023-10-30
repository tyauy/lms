<cfcomponent>

    <cffunction name="oget_keyword_tracking_general" access="public" returntype="query" description="Retrieve list of sessions attached keywords interests">

        <cfargument name="s_id" type="numeric" required="yes">
		
        <cfquery name="get_keyword_tracking_general" datasource="#SESSION.BDDSOURCE#">
        SELECT k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_id
        FROM tracking_keyword tk
        INNER JOIN lms_keyword2 k ON k.keyword_id = tk.keyword_id AND k.keyword_cat_id = 3 AND k.is_active = 1
        WHERE tk.tracking_keyword_status_id = 1
        AND tk.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
        </cfquery>

        <cfreturn get_keyword_tracking_general>

    </cffunction>

    <cffunction name="oget_keyword_tracking_business" access="public" returntype="query" description="Retrieve list of sessions attached keywords business">

        <cfargument name="s_id" type="numeric" required="yes">
		
        <cfquery name="get_keyword_tracking_business" datasource="#SESSION.BDDSOURCE#">
        SELECT k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_id
        FROM tracking_keyword tk
        INNER JOIN lms_keyword2 k ON k.keyword_id = tk.keyword_id AND k.keyword_cat_id = 4 AND k.is_active = 1
        WHERE tk.tracking_keyword_status_id = 1
        AND tk.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
        </cfquery>

        <cfreturn get_keyword_tracking_business>

    </cffunction>

    <cffunction name="oget_vocab_tracking" access="public" returntype="query" description="Retrieve list of sessions' attached vocab list">

        <cfargument name="s_id" type="numeric" required="yes">
		
        <cfquery name="get_vocab_tracking" datasource="#SESSION.BDDSOURCE#">
        SELECT vc.voc_cat_name_#SESSION.LANG_CODE# as voc_cat_name, vc.voc_cat_id
        FROM tracking_vocab tv
        INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = tv.voc_cat_id
        WHERE tv.tracking_voc_status_id = 1
        AND tv.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
        </cfquery>

        <cfreturn get_vocab_tracking>

    </cffunction>

    <cffunction name="oget_mapping_tracking" access="public" returntype="query" description="Retrieve list of sessions' attached mapping">

        <cfargument name="s_id" type="numeric" required="yes">
		
        <cfquery name="get_mapping_tracking" datasource="#SESSION.BDDSOURCE#">
        SELECT m.mapping_name, m.mapping_id
        FROM tracking_mapping tm
        INNER JOIN lms_mapping m ON m.mapping_id = tm.mapping_id
        WHERE tm.tracking_mapping_status_id = 1
        AND tm.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
        </cfquery>

        <cfreturn get_mapping_tracking>

    </cffunction>

</cfcomponent>