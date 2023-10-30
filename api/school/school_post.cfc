<cfcomponent>

    <cffunction name="update_school_session" access="remote" method="POST" returntype="any" returnformat="json">
        <cfargument name="token_session_name" type="string" required="no" default="">
        <cfargument name="token_session_status" type="string" required="no">
        <cfargument name="token_session_start" type="string" required="no">
        <cfargument name="token_session_end" type="string" required="no">
        <cfargument name="token_session_method" type="string" required="no">
        <cfargument name="token_session_certif_type" type="string" required="no">
        <cfargument name="token_session_description" type="string" required="no">
        <cfargument name="a_id" type="numeric" required="yes">
        <cfargument name="ts_id" type="numeric" required="yes">


        <!--- <cftry> --->

            <cfquery name="select" datasource="#SESSION.BDDSOURCE#">
                SELECT `token_session_id` FROM `lms_list_token_session` 
                WHERE `token_session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
            </cfquery>

            <cfif select.recordcount eq 0>

                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                    INSERT INTO `lms_list_token_session` (
                        <cfif isDefined("token_session_status")>`token_session_status`, </cfif>
                        <cfif isDefined("token_session_start")>`token_session_start`, </cfif>
                        <cfif isDefined("token_session_end")>`token_session_end`, </cfif>
                        <cfif isDefined("token_session_method")>`token_session_method`, </cfif>
                        <cfif isDefined("token_session_certif_type")>`token_session_certif_type`, </cfif>
                        <cfif isDefined("token_session_description")>`token_session_description`, </cfif>
                        `account_id`,
                        `token_session_name`
                    ) 
                    VALUES (
                    <cfif isDefined("token_session_status")><cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_status#">,</cfif>
                    <cfif isDefined("token_session_start")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("token_session_end")><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("token_session_method")><cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_method#">,</cfif>
                    <cfif isDefined("token_session_certif_type")><cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_certif_type#">,</cfif>
                    <cfif isDefined("token_session_description")><cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_description#">,</cfif>
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_name#">
                    )
                </cfquery>

                <cfset _srlist = "">
                <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
                    <cfset _srlist = SESSION.USER_SESSION_RIGHT_ID>
                </cfif>

                <cfset _srlist = listAppend(_srlist,insert_res.generatedkey)>

                <cfquery name="up_right" datasource="#SESSION.BDDSOURCE#">
                    UPDATE user SET 
                    user_session_right_id = '#_srlist#'
                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                </cfquery>
                <!--- <cfset return_id = insert_res.generatedkey> --->

            <cfelse>

                <cfquery datasource="#SESSION.BDDSOURCE#">
                    UPDATE `lms_list_token_session` SET
                    <cfif isDefined("token_session_status")> token_session_status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_status#">,</cfif>
                    <cfif isDefined("token_session_start")> token_session_start = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("token_session_end")> token_session_end = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                    <cfif isDefined("token_session_method")> token_session_method = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_method#">,</cfif>
                    <cfif isDefined("token_session_certif_type")> token_session_certif_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_certif_type#">,</cfif>
                    <cfif isDefined("token_session_description")> token_session_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_description#">,</cfif>
                    token_session_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_name#">
                    WHERE `token_session_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
                </cfquery>
    
            </cfif>

        <cfreturn 1>

        <!--- <cfcatch type="any">
            update_school_session: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
    </cffunction>


    <cffunction name="add_manager" access="remote" method="POST" returntype="any" returnformat="json">
        <cfargument name="user_email" type="string" required="yes">
        <cfargument name="user_firstname" type="string" required="yes">
        <cfargument name="user_name" type="string" required="yes">
        <cfargument name="user_phone" type="string" required="yes">
        <cfargument name="user_gender" type="string" required="yes">
        <cfargument name="account_id" type="string" required="yes">

        <cfargument name="selected_session" type="string" required="yes">

        <cfset session_list = "" />

        <!--- <cfdump var="#arguments#"> --->
        <cftry>

            <cfif isDefined("selected_session") AND selected_session neq "" AND selected_session neq 0>

                <cfloop from="1" to="#selected_session#" index="idx">
                    <cfdump var="#arguments["new_session_#idx#"]#">

                    <cfif arguments["new_session_#idx#"] neq 0 AND arguments["new_session_#idx#"] neq "">
                        <cfset session_list = listAppend(session_list,arguments["new_session_#idx#"]) >
                    </cfif>
                    
                </cfloop>

            </cfif>

            <!--- <cfdump var="#session_list#"> --->

            <cfset user_pwd = RandRange(100000, 999999)>

            <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="new_user">
                INSERT INTO user
                (
                user_gender,
                user_firstname,
                user_name,
                user_phone,
                user_email,
                user_password,
                account_id,
                timezone_id,
                user_create,
                profile_id,
                user_status_id,
                user_account_right_id,
                user_session_right_id
                )
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_name#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#listgetat(account_id,1)#">,
                6,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                11,
                4,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#account_id#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#selected_session#">
                )
            </cfquery>

            <cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
            SELECT MAX(user_id) as id FROM user
            </cfquery>

            <cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
            INSERT INTO user_profile_cor
            (
            user_id,
            profile_id
            )
            VALUES
            (
            <cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_user.id#">,
            11
            )
            </cfquery>

            <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                <cfinvokeargument name="user_session_right_id" value="#session_list#">
            </cfinvoke>

            <cfset user_firstname = user_firstname>
            <cfset user_lastname = user_name>
            <cfset user_email = user_email>
            <cfset user_pwd_chg = 0>

            <cfset subject = "WEFIT | Accès Gestionnaire | Certification LINGUASKILL">

            <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                <cfset lang = "fr">
                <cfinclude template="/email/email_new_cm.cfm">
            </cfmail>
    
        <cfreturn 1>

        <cfcatch type="any">
            add_manager: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="send_manager_login" access="remote" method="POST" returntype="any" returnformat="json">
        <cfargument name="u_id" type="numeric" required="yes">


        <cftry>

            <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                <cfinvokeargument name="u_id" value="#u_id#">
            </cfinvoke>

            <cfif get_user.user_session_right_id eq "">
                <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                    <cfinvokeargument name="user_session_right_id" value="#get_user.user_session_right_id#">
                </cfinvoke>
            <cfelse>
                <cfinvoke component="api/school/school_get" method="oget_session_access" returnvariable="get_session_access">
                    <cfinvokeargument name="user_account_right_id" value="#get_user.user_account_right_id#">
                </cfinvoke> 
            </cfif>

            <cfset user_firstname = get_user.user_firstname>
            <cfset user_lastname = get_user.user_name>
            <cfset user_email = get_user.user_email>
            <cfset user_pwd_chg = get_user.user_pwd_chg>

            <!--- if new password needed --->
            <cfif user_pwd_chg neq "1">
                <cfset user_pwd = RandRange(100000, 999999)>

                <cfquery name="updt_pwd" datasource="#SESSION.BDDSOURCE#">
                    UPDATE user
                    SET user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">
                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                </cfquery>
            </cfif>
            
            <cfset subject = "WEFIT | Accès Gestionnaire | Certification LINGUASKILL">

            <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                <cfset lang = "fr">
                <cfinclude template="/email/email_new_cm.cfm">
            </cfmail>
    
        <cfreturn 1>

        <cfcatch type="any">
            send_manager_login: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction>


    <cffunction name="insert_token_user" access="remote" returntype="any" output="true" returnFormat="JSON">
        <cfargument name="token_start" type="string" required="no">
        <cfargument name="token_end" type="string" required="no">
        <cfargument name="a_id" type="numeric" required="yes">
        <cfargument name="ts_id" type="numeric" required="yes">

        <cfargument name="user_email" type="string" required="yes">
        <cfargument name="user_lastname" type="string" required="yes">
        <cfargument name="user_firstname" type="string" required="yes">
        <cfargument name="token_session_certif_type" type="string" required="yes">
        <!--- <cfargument name="user_phone" type="string" required="yes"> --->

        <cfargument name="att_new_token" type="string" required="no" default="0">

        <!--- <cftry> --->

            <cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
                SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">
            </cfquery>

            <cfif check_user.recordcount eq "0">

                <cfset temp = RandRange(100000, 999999)>

                <cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#" result="new_user">
                    INSERT INTO user
                    (
                    account_id,
                    profile_id,
                    timezone_id,
                    user_firstname,
                    user_name,
                    user_email,
                    user_password,
                    user_create,
                    user_lang,
                    user_status_id,
                    user_type_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#">,
                    9,
                    6,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_lastname)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                    'fr',
                    4,
                    3
                    );
                </cfquery>

                <cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
                    INSERT INTO user_profile_cor
                    (
                    user_id,
                    profile_id
                    )
                    VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#new_user.generatedkey#">,
                    9
                    )
                </cfquery>


                <cfset u_id =  new_user.generatedkey>

            <cfelse>
                <cfset u_id =  check_user.user_id>

            </cfif>
            

            <cfquery name="get_token_left" datasource="#SESSION.BDDSOURCE#">
                SELECT llt.token_id, llt.token_code
                FROM lms_list_token llt
                INNER JOIN account a ON llt.group_id = a.group_id 
                WHERE llt.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                AND llt.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
                AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
                <cfif token_session_certif_type eq "GENERAL">
                    AND llt.certif_id = 23
                <cfelse>
                    AND llt.certif_id = 22
                </cfif>
                AND llt.token_status_id IN (1,2)
            </cfquery>

            <!--- <cfdump var="#get_token_left#">
            <cfdump var="#att_new_token#"> --->

            <cfif get_token_left.recordCount eq 0 OR att_new_token neq 0>

                <!--- get a free token --->
                <cfquery name="get_token_left" datasource="#SESSION.BDDSOURCE#">
                    SELECT llt.token_id, llt.token_code
                    FROM lms_list_token llt
                    INNER JOIN account a ON llt.group_id = a.group_id 
                    WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
                    AND llt.user_id IS NULL
                    <cfif token_session_certif_type eq "GENERAL">
                        AND llt.certif_id = 23
                    <cfelse>
                        AND llt.certif_id = 22
                    </cfif>
                    LIMIT 1
                </cfquery>

                <cfif get_token_left.recordCount GT 0>

                    <cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_list_token SET 
                        token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">,
                        <cfif isDefined("token_start")>token_start = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_start,'yyyy-mm-dd', 'fr')#">,</cfif>
                        <cfif isDefined("token_end")>token_end = <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_end,'yyyy-mm-dd', 'fr')#">,</cfif>
                        token_status_id = 1,
                        user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
                        WHERE token_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#get_token_left.token_id#">
                    </cfquery>

                    <cfquery name="insert_order" datasource="lms-1" result="new_order">
                        INSERT INTO orders
                        (
                        order_status_id,
                        user_id,
                        account_id,
                        order_date,
                        order_start,
                        order_end,
                        context_id
                        )
                        VALUES
                        (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="3">,<!---EN ATTENTE--->
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                        <cfif isDefined("token_end")><cfqueryparam cfsqltype="cf_sql_timestamp" value="#LSDateFormat(token_end,'yyyy-mm-dd', 'fr')#">,<cfelse>#DateAdd("m",3,now())#,</cfif>
                        <cfqueryparam cfsqltype="cf_sql_integer" value="4"><!---DIRECT--->		
                        )
                    </cfquery>

                    <cfquery name="insert_order_user" datasource="lms-1">
                        INSERT INTO `orders_users`(`order_id`, `user_id`) 
                        VALUES (
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#new_order.generatedkey#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">)
                    </cfquery>

                    <cfquery name="create_tp" datasource="lms-1" result="new_tp">
                        INSERT INTO lms_tp (
                        user_id,
                        tp_status_id,
                        order_id,
                        formation_id,
                        method_id,
                        tp_date_start,
                        tp_date_end,
                        tp_duration,
                        certif_id,
                        elearning_duration
                        )
                        VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        2,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_order.generatedkey#">,
                        2,
                        7,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                        <cfif isDefined("token_end")><cfqueryparam cfsqltype="cf_sql_timestamp" value="#LSDateFormat(token_end,'yyyy-mm-dd', 'fr')#">,<cfelse>#DateAdd("m",3,now())#,</cfif>
                        60,
                        <cfif token_session_certif_type eq "GENERAL">23<cfelse>22</cfif>,
                        2
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
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
                    )
                    </cfquery>

                    <cfquery name="ins_el_tp" datasource="lms-1" result="new_tp_el">
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
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#new_order.generatedkey#">,
                        2,
                        2,
                        3,
                        now(),
                        #DateAdd("m",3,now())#,
                        1,
                        1,
                        90,
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
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp_el.generatedkey#">
                        )
                    </cfquery>


                    <cfquery name="maj_toktp" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_tp SET 
                        token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_token_left.token_id#">
                        WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
                    </cfquery>

                    <cfquery name="maj_toktok" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_list_token SET 
                        tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#new_tp.generatedkey#">
                        WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_token_left.token_id#">
                    </cfquery>

                </cfif>
            </cfif>

            
        

        <cfreturn 1>
        <!--- <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry> --->
	</cffunction>



    <cffunction name="upload_user" access="remote" returntype="any" output="true" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">
        <cfargument name="a_id" type="numeric" required="yes">

        <!--- UPDATE `lms_list_token` SET `group_id`=522 WHERE `user_id` Is NULL AND `tp_id` = 0 AND `token_session_id` IS NULL AND certif_id = 23 LIMIT 50 --->

        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">

            <cfset dir_go = "#SESSION.BO_ROOT#/parser/temp">

            <cffile action = "upload" 
            filefield = "doc_attach" 
            allowedExtensions = ".xlsx,.xls"
            destination = "#dir_go#" 
            result="uploaded_file"
            nameConflict = "Overwrite"
            mode="777">					

            <!--- <cfdump var="#uploaded_file#"> --->
            <cfif uploaded_file.FileWasSaved>

                <cfspreadsheet 
                action="read" 
                src="#dir_go#/#uploaded_file.ClientFile#" 
                query="qData" 
                sheet="1"/>

                <cfset qData = queryDeleteRow(qData,1)>
                <cfset qData = queryDeleteRow(qData,1)>

                <!--- 
                    col_1 - Date Début
                    col_2 - Date Butoir
                    col_3 - Émail
                    col_4 - Nom
                    col_5 - Prénom
                    col_6 - Session
                    col_7 - Méthode
                    col_8 - Version
                --->

                <!--- <cfdump var="#qData#"> --->
                <cfoutput query="qData" group="col_6">

                        
                    <cftry>
                        <!--- SESSION --->

                        <cfif qData['col_6'][currentRow] neq "">

                            <cfquery name="select_session" datasource="#SESSION.BDDSOURCE#">
                                SELECT `token_session_id` FROM `lms_list_token_session` 
                                WHERE `token_session_name` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['col_6'][currentRow]#">
                            </cfquery>
                
                            <cfif select_session.recordcount eq 0>
                
                                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="insert_res">
                                    INSERT INTO `lms_list_token_session` (
                                        `token_session_status`,
                                        `token_session_start`,
                                        `token_session_end`,
                                        `token_session_method`,
                                        `token_session_certif_type`,
                                        `account_id`,
                                        `token_session_name`
                                    ) 
                                    VALUES (
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="WAITING">,
                                    <cfif qData['col_1'][currentRow] neq ""><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(qData['col_1'][currentRow],'yyyy-mm-dd', 'fr')#"><cfelse>NULL</cfif>,
                                    <cfif qData['col_2'][currentRow] neq ""><cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(qData['col_2'][currentRow],'yyyy-mm-dd', 'fr')#"><cfelse>NULL</cfif>,
                                    <cfif qData['col_7'][currentRow] neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['col_7'][currentRow]#"><cfelse>NULL</cfif>,
                                    <cfif qData['col_8'][currentRow] neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['col_8'][currentRow]#"><cfelse>NULL</cfif>,
                                    <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['col_6'][currentRow]#">
                                    )
                                </cfquery>

                                <cfset _srlist = "">
                                <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
                                    <cfset _srlist = SESSION.USER_SESSION_RIGHT_ID>
                                </cfif>

                                <cfset _srlist = listAppend(_srlist,insert_res.generatedkey)>

                                <cfquery name="up_right" datasource="#SESSION.BDDSOURCE#">
                                    UPDATE user SET 
                                    user_session_right_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_srlist#" list="yes">
                                    WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
                                </cfquery>

                                <cfset _session_id = insert_res.generatedkey>

                            <cfelse>

                                <cfset _session_id = select_session.token_session_id>
                            </cfif>

                            <p>UPDATE #qData['col_6'][currentRow]#</p>

                            <cfoutput>
                                    
                                <cfif qData['col_3'][currentRow] neq "">

                                    <!--- USER --->
                                    <cfinvoke component="api/school/school_post" method="insert_token_user" returnVariable="user_new_id">
                                        <cfinvokeargument name="token_session_status" value="1">
                                        <cfif qData['col_1'][currentRow] neq ""><cfinvokeargument name="token_start" value="#qData['col_1'][currentRow]#"></cfif>
                                        <cfif qData['col_2'][currentRow] neq ""><cfinvokeargument name="token_end" value="#qData['col_2'][currentRow]#"></cfif>
                                        <cfinvokeargument name="a_id" value="#a_id#">
                                        <cfinvokeargument name="ts_id" value="#_session_id#">
                                        <cfinvokeargument name="user_email" value="#qData['col_3'][currentRow]#">
                                        <cfinvokeargument name="user_lastname" value="#qData['col_4'][currentRow]#">
                                        <cfinvokeargument name="user_firstname" value="#qData['col_5'][currentRow]#">
                                    </cfinvoke>

                                </cfif>
                                

                            </cfoutput>
                        </cfif>

                    <cfcatch type="any">
                        Error: #cfcatch.message#
                    </cfcatch>
                    </cftry>

                </cfoutput>

				<cffile action="DELETE" file="#dir_go#/#uploaded_file.ClientFile#">
									
			</cfif>
		</cfif>
        

        <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>

    <!--- <cffunction name="export_school_session" access="remote" method="POST" output="true" returntype="any" returnformat="json">
        <cfargument name="ts_id" type="numeric" required="yes">

        <cftry>

            <cfquery name="get_token_attributed" datasource="#SESSION.BDDSOURCE#">
                SELECT 
                lt.token_id, lt.user_id, lt.certif_id, lt.token_creation, lt.token_send, lt.token_code, lt.token_login, lt.token_end, lt.token_status_id, lt.token_use, lt.token_level, lt.token_start,
                ltss.token_session_name,
                lts.token_status_name, lts.token_status_css,
                u.user_id as id, u.user_firstname, u.user_name, u.user_email
                FROM user u
                LEFT JOIN lms_list_token lt ON lt.user_id = u.user_id
                LEFT JOIN lms_list_token_session ltss ON ltss.token_session_id = lt.token_session_id
                LEFT JOIN lms_list_token_status lts ON lts.token_status_id = lt.token_status_id
                WHERE lt.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
                ORDER BY lt.token_id ASC
            </cfquery>
        
            <cfquery name="get_status" datasource="#SESSION.BDDSOURCE#">
                SELECT token_status_id, token_status_name, token_status_css 
                FROM lms_list_token_status 
                ORDER BY lms_list_token_status.token_status_id ASC
            </cfquery>
        
        <cfset name_tab_1 = "Details"> 
        <!----------------------------1ST SPREADSHEET ------------------->
        <cfset sObj = SpreadsheetNew("#name_tab_1#",false)>
        <!--- <cfset SpreadsheetCreateSheet(sObj,"Details")> --->
        
        <cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
        
        <!--- CREATE HEADER FOR GLOBAL SHEET --->
        <cfset listrows_gl = "Session,Nom,Prénom,Statut,Code entry,Envoyé,Passage,Niveau">
        <cfset SpreadsheetAddRow(sObj,listrows_gl)>
            
        
        <cfset FormatStruct = {}>
        <cfset FormatStruct.fontsize = "10">
        <cfset FormatStruct.fgcolor = "pale_blue">
        <cfset FormatStruct.alignment = "center">
        <cfset FormatStruct.textwrap = "false"> 
        <cfset FormatStruct.bottomborder ="medium"> 
        <cfset FormatStruct.bold = "true"> 
        <cfset FormatStruct.verticalalignment = "vertical_top"> 
        
        
        <cfset SpreadsheetFormatRow(sObj,FormatStruct,1)>
        <cfset SpreadSheetSetRowHeight(sObj,1,25)> 
        <cfset spreadsheetSetColumnWidth(sObj,1,30)>
        
            <cfset count_row = 1>
        
            <cfoutput query="get_token_attributed">
                <cfset count_row = count_row+1>
                <!--- <cfset lesson_format = lesson_duration/60> --->
                <cfset SpreadsheetAddRow(sObj,"#token_session_name#, #ucase(user_name)#, #user_firstname#, #token_status_name#, #token_code#, #dateformat(token_send,'dd/mm/yyyy')#, #dateformat(token_use,'dd/mm/yyyy')#, #token_level#",count_row)>	
                <cfset SpreadSheetSetRowHeight(sObj,count_row,25)>
                <cfset spreadsheetSetColumnWidth(sObj,count_row,20)>
            </cfoutput>
            
        <cfset SpreadsheetSetActiveSheetNumber(sObj,1)>
            
            
        <cfheader name="Content-Disposition" value="inline; filename=WEFIT_#get_token_attributed.token_session_name#.xls">
        <cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(sObj)#">
    
        <cfreturn 1>

        <cfcatch type="any">
            update_school_session: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    </cffunction> --->


</cfcomponent>