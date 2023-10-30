<cfcomponent>

    <!--- output="false" --->
    <cffunction name="insert_task" access="remote" httpMethod="post" returntype="any" returnformat="json" >
	
        <cfargument name="task_type_id" type="any" required="yes">
        <cfargument name="log_text" type="any" required="no">
        <cfargument name="task_category" type="any" required="no">

        <cfargument name="task_channel_id" type="any" required="no">
		<cfargument name="log_remind" type="any" required="no">
		<cfargument name="log_remind_ok" type="any" required="no">
		<cfargument name="u_id" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
        <cfargument name="g_id" type="any" required="no">
        <cfargument name="order_id" type="any" required="no">
        <cfargument name="to_id" type="any" required="no">
        <cfargument name="profile_id" type="any" required="no">

        <cfif isdefined("log_remind_ok")>
            <cfset log_remind_date = "#LSdateformat(log_remind,'yyyy-mm-dd', 'fr')# #LStimeformat(log_remind,'HH:mm:00', 'fr')#">
        </cfif>

        <cfquery name="insert_log" datasource="#SESSION.BDDSOURCE#" result="get_log">
        INSERT INTO logs (
        user_id, 
        account_id,
        group_id,
        order_id,
        log_text, 
        log_date, 
        <cfif isdefined("log_remind_ok")>log_remind,</cfif>
        from_id,
        to_id,
        log_status,
        task_channel_id
        )
        VALUES 
        (
        <cfif isdefined("u_id") AND u_id neq "0" AND u_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"><cfelse>null</cfif>,
        <cfif isdefined("a_id") AND a_id neq "0" AND a_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#"><cfelse>null</cfif>,
        <cfif isdefined("g_id") AND g_id neq "0" AND g_id neq ""><cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#"><cfelse>null</cfif>,
        <cfif isdefined("order_id") AND order_id neq "0"><cfqueryparam cfsqltype="cf_sql_varchar" value="#order_id#"><cfelse>null</cfif>,
        <cfif isdefined("log_text")><cfqueryparam cfsqltype="cf_sql_varchar" value="#log_text#"><cfelse>null</cfif>,
        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
        <cfif isdefined("log_remind_ok")><cfqueryparam cfsqltype="cf_sql_timestamp" value="#log_remind_date#">,</cfif>
        <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
        <cfif isdefined("to_id") AND to_id neq "0"><cfqueryparam cfsqltype="cf_sql_integer" value="#to_id#">,<cfelse>null,</cfif>
        <cfif isdefined("task_category") AND task_category eq "TO DO">null<cfelse>1</cfif>,
        <cfif isdefined("task_channel_id")><cfqueryparam cfsqltype="cf_sql_varchar" value="#task_channel_id#"><cfelse>null</cfif>
        )	
        </cfquery>

        <!--- <cfdump var="#get_log#"> --->
        <cfloop list="#task_type_id#" index="cor">
        <cfquery name="ins_item" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO logs_item
        (
            log_id,
            task_type_id
        )
        VALUES
        (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_log.generatedkey#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">
        )
        </cfquery>
        </cfloop>

        <cfset obj_task_get = createobject("component", "#SESSION.BO_ROOT_API#.task.task_get")>
        <cfset get_log = obj_task_get.oget_log(log_id="#get_log.generatedkey#")>
        <cfreturn get_log>

    </cffunction>


    <cffunction name="delete_task" access="remote" returntype="any" output="false">
	
        <cfargument name="log_id" type="any" required="yes">

        <cfquery name="delete_task" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM logs 
        WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfquery name="delete_item" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM logs_item
        WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfreturn "ok">

    </cffunction>









    <!--- <cffunction name="delete_task" access="remote" returntype="any" output="false">
	
        <cfargument name="log_id" type="any" required="yes">

        <cfquery name="delete_task" datasource="#SESSION.BDDSOURCE#">
        DELETE FROM logs 
        WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfreturn "ok">

    </cffunction> --->


    
    <cffunction name="updt_task_type" access="remote" httpMethod="post" returntype="any" returnformat="plain" output="true">
	
        <cfargument name="tt_id" type="numeric" required="yes">
        <cfargument name="task_explanation_long" type="any" required="yes">
        

        <cfoutput>#task_explanation_long#</cfoutput>

        <cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
        UPDATE task_type 
        SET task_explanation_long = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_long#">
        WHERE task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#tt_id#">
        </cfquery>

        <cfreturn task_explanation_long>
    </cffunction>



    <cffunction name="updt_task" access="remote" httpMethod="post" returntype="any" output="false">
	
        <cfargument name="log_id" type="any" required="yes">
        <cfargument name="log_remind" type="any" required="yes">
        <cfargument name="to_id" type="any" required="no">


        <!--- <cfif day(log_remind) lte "12">		
            <cfset log_remind_date = "#dateformat(log_remind,'yyyy-dd-mm')# #timeformat(log_remind,'HH:mm:00')#">
            <cfset log_remind_from = "#timeformat(dateadd("n",-120,log_remind),'HHmm')#">
            <cfset log_remind_to = "#timeformat(dateadd("n",-90,log_remind),'HHmm')#">
            <cfset log_remind_gg = "#dateformat(log_remind,'yyyyddmm')#T#log_remind_from#00Z/#dateformat(log_remind,'yyyyddmm')#T#log_remind_to#00Z">
        <cfelse>
            <cfset log_remind_date = "#dateformat(log_remind,'yyyy-mm-dd')# #timeformat(log_remind,'HH:mm:00')#">
            <cfset log_remind_from = "#timeformat(dateadd("n",-120,log_remind),'HHmm')#">
            <cfset log_remind_to = "#timeformat(dateadd("n",-90,log_remind),'HHmm')#">
            <cfset log_remind_gg = "#dateformat(log_remind,'yyyymmdd')#T#log_remind_from#00Z/#dateformat(log_remind,'yyyymmdd')#T#log_remind_to#00Z">
        </cfif> --->
    
        <cfset log_remind_date = "#LSdateformat(log_remind,'yyyy-mm-dd', 'fr')# #LStimeformat(log_remind,'HH:mm:00', 'fr')#">

        <cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
        UPDATE logs SET log_remind = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#log_remind_date#">
        <cfif isDefined("to_id")>
            ,to_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#to_id#">
        </cfif>
        WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfreturn "ok">

    </cffunction>

    <cffunction name="updt_date" access="remote" httpMethod="post" returntype="any" output="false">
	
        <cfargument name="log_id" type="any" required="yes">
        <cfargument name="selectedDate" type="any" required="yes">
        <cfargument name="to_id" type="any" required="no">

    
        <cfset log_remind_date = "#LSdateformat(selectedDate,'yyyy-mm-dd', 'fr')# #LStimeformat(selectedDate,'HH:mm:00', 'fr')#">

        <cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
        UPDATE logs SET log_remind = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#log_remind_date#">
        <cfif isDefined("to_id")>
            ,to_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#to_id#">
        </cfif>
        WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfreturn "ok">

    </cffunction>


    <cffunction name="updt_task_item" access="remote" httpMethod="post" returntype="any" output="false">
	
        <cfargument name="item_id" type="numeric" required="yes">
        <cfargument name="log_id" type="numeric" required="yes">
        <cfargument name="status" type="numeric" required="yes">
    
        <cfquery name="updt_task" datasource="#SESSION.BDDSOURCE#">
        UPDATE logs_item SET log_item_status = <cfqueryparam cfsqltype="cf_sql_integer" value="#status#">
        WHERE task_type_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#item_id#">
        AND log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">

        </cfquery>

        <cfreturn "ok">

    </cffunction>



    <cffunction name="close_task" access="remote" returntype="any" returnFormat="plain" output="false">

        <cfargument name="log_id" type="any" required="yes">

        <!--- If there is only 1 subtask there is no need to wait for the checkbox to be checked to close the task --->
        <cfquery name="check_task_o" datasource="#SESSION.BDDSOURCE#">
            SELECT `log_id`, `task_type_id`, `log_item_status` FROM `logs_item` 
            WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfif check_task_o.recordcount GT 1 >
            <!--- we look if there is unchecked task left --->
            <cfquery name="check_task" datasource="#SESSION.BDDSOURCE#">
                SELECT `log_id`, `task_type_id`, `log_item_status` FROM `logs_item` 
                WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
                AND (log_item_status != 1 OR log_item_status IS NULL)
            </cfquery>
    
            <cfif check_task.recordcount GT 0 >
                <cfreturn 0>
            </cfif>
        </cfif>

        <!--- if everything is ok we close the task --->
        <cfquery name="close_log" datasource="#SESSION.BDDSOURCE#">
        UPDATE logs SET log_status = 1 WHERE log_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#log_id#">
        </cfquery>

        <cfreturn 1>

    </cffunction>
    <cffunction name="archive_task" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="id" type="any" required="yes">
        <cfquery name="archive_task_type" datasource="#SESSION.BDDSOURCE#">
            UPDATE task_type 
            SET task_online = NOT task_online
            Where task_type_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
        </cfquery>
    </cffunction>

    <cffunction name="rename_task" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="id" type="any" required="yes">
        <cfargument name="name" type="any" required="yes">
        <cfquery name="rename_task_type" datasource="#SESSION.BDDSOURCE#">
            UPDATE task_type 
            SET task_type_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#name#">
            Where task_type_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
        </cfquery>
    </cffunction>

    <cffunction name="change_desc" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="id" type="any" required="yes">
        <cfargument name="desc" type="any" required="yes">
        <cfargument name="lang" type="any" required="yes">
        <cfquery name="rename_task_desc" datasource="#SESSION.BDDSOURCE#">
            UPDATE task_type
            SET task_explanation_#lang# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#desc#">
            Where task_type_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
        </cfquery>
    </cffunction>

    <cffunction name="create_task_type" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="task_type_name" type="string" required="yes">
        <cfargument name="task_group" type="string" required="no">
        <cfargument name="task_group_alias" type="string" required="no">
        <cfargument name="task_group_sub" type="string" required="no">
        <cfargument name="task_color" type="string" required="no">
        <cfargument name="profile_id" type="string" required="yes">
        <cfargument name="task_online" type="string" required="yes">
        <cfargument name="task_group_rank" type="string" required="yes">
        <cfargument name="task_explanation_en" type="string" required="no">
        <cfargument name="task_explanation_fr" type="string" required="no">
        <cfargument name="task_automation" type="string" required="no">
    
        <cfquery name="new_task_type" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO task_type (task_type_name,  task_group,
            task_group_alias,
            task_group_sub,
            task_color,
            profile_id, 
            task_online,
            task_group_rank,
            task_explanation_en,
            task_explanation_fr,
            task_category,
            task_automation)
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_type_name#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_alias#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_sub#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_color#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#profile_id#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_online#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_rank#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_en#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_explanation_fr#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_category#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_automation#">

            )
        </cfquery>
    </cffunction>
    <cffunction name="update_profile" access="remote" returntype="any" returnFormat="plain" output="false">
        <cfargument name="task_id" type="any" required="yes">
        <cfargument name="profile_ids" type="any" required="yes">
       
        <cfquery name="rename_task_desc" datasource="#SESSION.BDDSOURCE#">
            UPDATE task_type
            SET profile_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#profile_ids#">
            Where task_type_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#task_id#">
        </cfquery>
    </cffunction>

</cfcomponent>