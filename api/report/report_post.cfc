<cfcomponent>

    <cffunction name="get_tp_deadline" access="remote" hint="Gets all task from the database" method="POST" returntype="any" returnformat="json">
        <cfargument name="lmethod" type="numeric" required="no" default="0">
        <cfargument name="end_date" type="date" required="no" default="#LSDateFormat(DateAdd('d', 30, now()),'yyyy-mm-dd', 'fr')#">
        <cfargument name="start_date" type="date" required="no" default="#LSDateFormat(now(),'yyyy-mm-dd', 'fr')#">

        <cftry>

        <cfquery name="get_deadline" datasource="#SESSION.BDDSOURCE#">
            SELECT req.* FROM (
                SELECT 
                u.user_id,
                u.user_firstname as firstname,
                u.user_name as lastname,
                o.order_id,
                tp.tp_date_end,
                o.order_end,
                llm.method_id,
                llm.method_alias_fr,
                tp.tp_duration as tp_duration,
                SUM(ll.lesson_duration) as lesson_book,
                (SELECT SUM(ue2.sm_elapsed) FROM user_elapsed ue2 WHERE ue2.user_id = tp.user_id GROUP BY ue2.user_id) as time_elapsed,
                u.user_lastconnect as lastview
                FROM lms_tp tp
                LEFT JOIN orders o ON tp.order_id = o.order_id
                LEFT JOIN lms_tpsession lts ON tp.tp_id = lts.tp_id
                LEFT JOIN lms_lesson2 as ll ON ll.session_id = lts.session_id  AND ll.status_id <> 3
                LEFT JOIN user u ON tp.user_id = u.user_id
                LEFT JOIN lms_lesson_method llm ON tp.method_id = llm.method_id
                WHERE o.order_end BETWEEN "#start_date#" AND "#end_date#"
                AND tp.tp_status_id = 2
        
                <cfif lmethod neq 0>
                    AND tp.method_id = #lmethod#
                </cfif>
                GROUP BY tp.tp_id) as req
            WHERE req.lesson_book < req.tp_duration OR req.lesson_book IS NULL 
            ORDER BY `req`.`order_end`  ASC
        
        </cfquery>
    
        <cfprocessingdirective suppresswhitespace="yes">
          <cfset table_js = SerializeJSON(get_deadline, "struct")>
        </cfprocessingdirective>
    
        <cfreturn table_js>

        <cfcatch type="any">
            get_tp_deadline: <cfoutput>#cfcatch.message#</cfoutput>
            <cfoutput>#cfcatch.extendedInfo#</cfoutput>
            <cfoutput>#cfcatch.detail#</cfoutput>
            <cfif cfcatch.type eq "database"><cfoutput>#cfcatch.queryError#</cfoutput></cfif>
            <cfreturn 0>
        </cfcatch>
        </cftry>
      </cffunction>


</cfcomponent>