<cfabort>

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT u.user_id, u.user_firstname, u.user_name, u.user_email, us.user_status_name_fr, t.method_id, t.tp_date_end, t.elearning_id, t.tp_id FROM user u
INNER JOIN lms_tpuser tpu ON tpu.user_id = u.user_id
INNER JOIN lms_tp t ON t.tp_id = tpu.tp_id
INNER JOIN user_status us ON us.user_status_id = u.user_status_id

AND (u.user_status_id = 4)
AND (t.method_id = 3 OR t.method_id = 4)
AND (t.formation_id = 2)
AND u.user_lang = 'de'
ORDER BY u.user_id
</cfquery>

<!--- AND user_id = 411 --->

<cfoutput query="get_user" group="user_id">
    
<cfset abo_el = 0>

<cfoutput>

    <cfif method_id eq "3" AND tp_date_end gt now() AND elearning_id eq "1">
        <cfset abo_el = 1>
    </cfif>

</cfoutput>

    <cfif abo_el eq "1">
        <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#user_id#" target="_blank">[#user_status_name_fr#] #user_firstname# #ucase(user_name)#</a>
        <br>
        ABO EL NON EXPIRÉ / #method_id# / #tp_date_end# / #elearning_id#
        <br>
    <cfelse>
        <a href="https://lms.wefitgroup.com/common_learner_account.cfm?u_id=#user_id#" target="_blank">[#user_status_name_fr#] #user_firstname# #ucase(user_name)#</a>
        <br>
        ABO EXPIRÉ !! / #method_id# / #tp_date_end# / #elearning_id#
        <br>

        <cfquery name="ins_tp" datasource="#SESSION.BDDSOURCE#" result="insert_tp">
            INSERT INTO lms_tp
            (
            user_id,
            order_id,
            tp_status_id,
            formation_id,
            method_id,
            tp_date_start,
            tp_date_end,
            tp_rank,
            elearning_id,
            elearning_duration,
            tp_duration
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">,
            1,
            2,
            2,
            3,
            "2023-02-07 00:00:00",
            <cfif get_user.profile_id eq "3">"2023-05-07 00:00:00",<cfelse>"2023-05-07 00:00:00",</cfif>
            1,
            1,
            <cfif profile_id eq 3>
                60,
            <cfelseif profile_id eq 7>
                30,
            </cfif>
            0
            )
        </cfquery>
    
    
        <cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO lms_tpuser
            (
            user_id,
            tp_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">,
            <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
            )
        </cfquery>


    </cfif>


    

    <!--- <cfquery name="updt_learner" datasource="#SESSION.BDDSOURCE#">
        UPDATE user SET user_status_id = 4 WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">
    </cfquery> --->



<br>
--------------------------------------
<br><br>
</cfoutput>


DONE !