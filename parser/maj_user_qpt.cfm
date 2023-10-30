<cfabort>

<cfsetting requestTimeOut = "9000" />

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT u.user_id, u.user_qpt_lock, u.user_qpt_fr, u.user_qpt_lock_fr, u.user_qpt_en, u.user_qpt_lock_en, u.user_qpt_es, u.user_qpt_lock_es, u.user_qpt_de, u.user_qpt_lock_de, u.user_qpt_it, u.user_qpt_lock_it, u.user_qpt_ar, u.user_qpt_lock_ar, u.user_qpt_iw, u.user_qpt_lock_iw, u.user_qpt_zh, u.user_qpt_lock_zh, u.user_qpt_nl, u.user_qpt_lock_nl, u.user_qpt_pl, u.user_qpt_lock_pl, u.user_qpt_pt, u.user_qpt_lock_pt, u.user_qpt_ru, u.user_qpt_lock_ru, u.user_qpt_ja, u.user_qpt_lock_ja, u.user_qpt_da, u.user_qpt_lock_da, u.user_qpt_gr, u.user_qpt_lock_gr
    FROM user u 
 </cfquery>
 
 
 <!--- THERE ARE QPT WITH NUMBER WE IGNORE THEM WITH THE TRY CATCH --->
 <cfoutput query="select">

    <cftry>

        <cfloop list="#SESSION.LIST_PT#" index="cor">

            <cfif evaluate("select.user_qpt_#cor#") neq "">
                #cor# - #user_id#

                <cfquery name="insert_user_level" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO `user_level`(
                        `user_id`,
                        `skill_id`,
                        `formation_id`, 
                        `formation_code`,
                        `level_id`,
                        `level_code`,
                        `level_verified`
                        ) 
                    VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
                        0,
                        (SELECT formation_id FROM lms_formation WHERE formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(cor)#">,
                        (SELECT level_id FROM lms_level WHERE level_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("select.user_qpt_#cor#")#">),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate("select.user_qpt_#cor#")#">,
                        0
                        )
                </cfquery>

            </cfif>
            <!--- <cfset "SESSION.USER_QPT_#cor#" = evaluate("get_user.user_qpt_#cor#")>
            <cfset "SESSION.USER_QPT_LOCK_#cor#" = evaluate("get_user.user_qpt_lock_#cor#")>	 --->
        </cfloop>
 
 
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <!--- <cfreturn 0> --->
        </cfcatch>
    </cftry>

 
 </cfoutput>


<cfset obj_quiz_post = createobject("component", "#SESSION.BO_ROOT_API#.quiz.quiz_post")>

<cfquery name="select" datasource="#SESSION.BDDSOURCE#">
    SELECT user_id, quiz_user_group_id
    FROM lms_quiz_user_score
    WHERE quiz_global_level IS NOT NULL
    AND quiz_global_score IS NULL
</cfquery>


<cfscript>
    x = 1;
    for (i in select) {
        x++;
        writeOutput(select.user_id);
        writeOutput("<br />");
        obj_quiz_post.updt_quiz_level(select.user_id, select.quiz_user_group_id)

        if ((x % 10) == 0) {
            writeOutput("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
            writeOutput("<br />");
            sleep(2000);
        }
    }
</cfscript>
