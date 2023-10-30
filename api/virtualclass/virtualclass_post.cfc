<cfcomponent>

    <cffunction name="subscribe_class" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="tp_id" type="any" required="yes">
        <cfargument name="u_id" type="any" required="no" default="#SESSION.USER_ID#">

        <!--- <cftry> --->

            <cfquery name="get_tpuser" datasource="#SESSION.BDDSOURCE#" result="data">
                SELECT tpuser_id, tpuser_active
                FROM lms_tpuser
                WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                LIMIT 1
            </cfquery>

            <cfif get_tpuser.recordCount eq 0>

                <cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO lms_tpuser(user_id, tp_id) 
                    VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                    )
                </cfquery>

                <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                    <cfinvokeargument name="task_type_id" value="241">
                    <cfinvokeargument name="u_id" value="#u_id#">
                    <cfinvokeargument name="task_channel_id" value="6">
                </cfinvoke>

                <cfreturn "1">

            <cfelse>

                <cfquery name="up" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_tpuser SET
                    tpuser_active = NOT tpuser_active,
                    tpuser_modified = NOW()
                    WHERE tpuser_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tpuser.tpuser_id#">
                </cfquery>

                <cfif get_tpuser.tpuser_active eq 1>

                    <!--- reset attendance if quit tp --->
                    <cfquery name="up_attendance" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_lesson2_attendance SET
                    subscribed = 0
                    WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                    AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                    </cfquery>

                    <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                        <cfinvokeargument name="task_type_id" value="242">
                        <cfinvokeargument name="u_id" value="#u_id#">
                        <cfinvokeargument name="task_channel_id" value="6">
                    </cfinvoke>

                    <cfreturn "1">

                <cfelse>
                    
                    <cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
                        <cfinvokeargument name="task_type_id" value="241">
                        <cfinvokeargument name="u_id" value="#u_id#">
                        <cfinvokeargument name="task_channel_id" value="6">
                    </cfinvoke>
                    
                    <cfreturn "2">

                </cfif>                


            </cfif>

            

        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->

    </cffunction>

    <cffunction name="book_class" access="remote" returntype="any" returnFormat="json" output="false">
        <cfargument name="tp_id" type="any" required="yes">
        <cfargument name="l_id" type="any" required="yes">
        <cfargument name="u_id" type="any" required="no" default="#SESSION.USER_ID#">

            <cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#" result="data">
            SELECT t.tp_max_participants, t.level_id, f.formation_code
            FROM lms_tp t
            LEFT JOIN lms_formation f ON t.formation_id = f.formation_id
            WHERE t.tp_id  = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#"> 
            </cfquery>

            <cfset result_status = "unqualified">

            <cfset level_lock = 6>
            <cfif StructKeyExists(SESSION.USER_LEVEL,get_tp.formation_code)>
                <cfset level_lock = SESSION.USER_LEVEL[get_tp.formation_code].level_id>
                <!--- <cfdump var="#SESSION.USER_LEVEL#"> --->
            </cfif>

            <cfif level_lock gte get_tp.level_id - 1>
                <cfquery name="count" datasource="#SESSION.BDDSOURCE#" result="data">
                SELECT COUNT(*) as nb, t.tp_max_participants as max
                FROM lms_lesson2_attendance la 
                LEFT JOIN lms_tp t ON la.tp_id = t.tp_id 
                WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
                AND subscribed = 1
                </cfquery>

                <cfquery name="get_attendance" datasource="#SESSION.BDDSOURCE#" result="data">
                SELECT tu.tpuser_id, tu.tpuser_active, la.attendance_id, la.subscribed
                FROM lms_tpuser tu
                LEFT JOIN lms_lesson2_attendance la ON tu.user_id = la.user_id AND tu.tp_id = la.tp_id AND la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
                WHERE tu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
                AND tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                </cfquery>

                <cfif get_attendance.recordcount eq 0>

                    <cfinvoke component="api/virtualclass/virtualclass_post" method="subscribe_class">
                        <cfinvokeargument name="tp_id" value="#tp_id#">
                        <cfinvokeargument name="u_id" value="#u_id#">
                    </cfinvoke>

                    <cfif (count.max eq "" OR count.nb LTE count.max)>

                        <cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
                        INSERT INTO lms_lesson2_attendance(
                        lesson_id,
                        tp_id,
                        user_id,
                        subscribed
                        ) 
                        VALUES 
                        (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        1
                        )
                        </cfquery>

                        <cfmail from="W-LMS <service@wefitgroup.com>" to="rremacle@wefitgroup.com" subject="New subscribed VC" type="html" server="localhost">
                            
                            <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#u_id#">LINK USER / tp_id = #tp_id#</a>
                            <a href="https://lms.wefitgroup.com/common_tp_details.cfm?t_id=#tp_id#">LINK TP / tp_id = #tp_id#</a>

                        </cfmail>

                        <cfset result_status = "booked">

                    </cfif>


                <cfelseif get_attendance.attendance_id eq "">
                    
                    <cfinvoke component="api/virtualclass/virtualclass_post" method="subscribe_class">
                        <cfinvokeargument name="tp_id" value="#tp_id#">
                        <cfinvokeargument name="u_id" value="#u_id#">
                    </cfinvoke>
                    
                    <cfif (count.max eq "" OR count.nb LTE count.max)>
                        <cfquery name="ins" datasource="#SESSION.BDDSOURCE#">
                            INSERT INTO lms_lesson2_attendance(
                            lesson_id,
                            tp_id,
                            user_id,
                            subscribed
                            ) 
                            VALUES 
                            (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                            1
                            )
                        </cfquery>

                        <cfmail from="W-LMS <service@wefitgroup.com>" to="rremacle@wefitgroup.com" subject="New subscribed VC" type="html" server="localhost">
                                                
                            <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#u_id#">LINK USER / tp_id = #tp_id#</a>
                            <a href="https://lms.wefitgroup.com/common_tp_details.cfm?t_id=#tp_id#">LINK TP / tp_id = #tp_id#</a>

                        </cfmail>
                        
                        <cfset result_status = "booked">

                    </cfif>

                <cfelse>

                    <cfif get_attendance.subscribed neq 1 AND (count.max eq "" OR count.nb LTE count.max)>

                        <cfquery name="resubscribe" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_lesson2_attendance SET
                        subscribed = 1
                        WHERE attendance_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_attendance.attendance_id#">
                        </cfquery>

                        <cfset result_status = "booked">

                    <cfelseif get_attendance.subscribed eq 1>
                        
                        <cfquery name="del" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_lesson2_attendance SET
                        subscribed = 0
                        WHERE attendance_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_attendance.attendance_id#">
                        </cfquery>
                        
                        <cfset result_status = "cancelled">

                    </cfif>

                </cfif>
            </cfif>

            <cfquery name="count_participant" datasource="#SESSION.BDDSOURCE#">
            SELECT COUNT(*) as nb, t.tp_max_participants
            FROM lms_lesson2_attendance la 
            INNER JOIN lms_tp t ON la.tp_id = t.tp_id 
            WHERE la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#"> 
            AND subscribed = 1
            </cfquery>

            <cfif count_participant.nb neq "0">
                <cfset seats_total = get_tp.tp_max_participants>
                <cfset seats_used = count_participant.nb>
                <cfset seats_remaining = seats_total-seats_used>
            <cfelse>
                <cfset seats_total = get_tp.tp_max_participants>
                <cfset seats_used = 0>
                <cfset seats_remaining = seats_total>
            </cfif>

            <cfset result = structNew()>
            <cfset result.lesson_status = result_status>
            <cfset result.count = seats_remaining>
            <cfreturn result>


    </cffunction>

</cfcomponent>