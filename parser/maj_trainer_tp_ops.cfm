<cfabort>

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT user_id, formation_id FROM `user_teaching` GROUP BY `user_id` ORDER BY `formation_id`
 </cfquery>

<cfoutput query="select">
    <cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_tp t INNER JOIN lms_tpplanner tpl ON t.tp_id = tpl.tp_id SET t.formation_id = #select.formation_id# WHERE tpl.planner_id = #select.user_id# AND t.method_id = 12
    </cfquery>
</cfoutput>



<!--- <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM `user` WHERE `profile_id` = 4 
    AND user_id IN (26444)
 </cfquery>
 <!--- AND `user_status_id` = 6 --->
 
 <cfoutput query="select">

    <cftry>

        <!--- // ! learner get list first or smth id --->
        <cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="new_tp">
            INSERT INTO lms_tp
            (
            user_id,
            order_id,
            tp_status_id,
            tp_date_start,
            tp_date_end,
            tp_duration,
            formation_id,
            method_id,
            
            techno_id,
            elearning_id,
            elearning_duration,
            elearning_url,
            elearning_login,
            elearning_password,
            
            tp_rank,
            tp_vip,
            
            certif_id,
            certif_url,
            certif_login,
            token_id,
            
            destination_id,
            
            creator_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#select.user_id#">, 
            1,
            1,
            "2022-01-01 00:00:00",
            "2222-12-30 00:00:00",
            "1200",
            2,
            12,
            
            3,
            null,
            30,
            null,
            null,
            null,
            
            1,
            0,
            
            36,
            null,
            null,
            0,
            
            
            1,
            
            202
            )
        </cfquery>


        <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpplanner
            (
                planner_id,
                tp_id,
                active
            )
            VALUES
            (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#select.user_id#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                1
            )
        </cfquery>
<!--- 161 dianne
69 VG
2586 Tom
5373 Krys
151 Douglas --->

        <cfloop list="161,69,2586,5373,151" index="userl_id">


            <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpuser
                (
                    user_id,
                    tp_id
                )
                VALUES
                (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#userl_id#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
                )
            </cfquery>
 

        </cfloop>
 
            <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpsession
                (
                tp_id,
                sessionmaster_id,
                session_duration,
                session_rank,
                session_close,
                method_id,
                cat_id
                )
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                1197,
                30,
                1,
                0,
                1,
                4
                );
                </cfquery>

            <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpsession
                (
                tp_id,
                sessionmaster_id,
                session_duration,
                session_rank,
                session_close,
                method_id,
                cat_id
                )
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">,
                1198,
                30,
                2,
                0,
                1,
                4
                );
            </cfquery>

 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>
 
 </cfoutput> --->
