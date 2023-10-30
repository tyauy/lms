<cfcomponent>

    <cffunction name="insert_token_session" access="remote" returntype="any" returnFormat="JSON">
        <cfargument name="token_session_name" type="string" required="yes">
        <cfargument name="a_id" type="numeric" required="yes">
        <cfargument name="token_session_start" type="any" required="yes">
        <cfargument name="token_session_end" type="any" required="yes">

        <cftry>
    
            <cfquery name="insert" datasource="#SESSION.BDDSOURCE#" result="new_token_session">
                INSERT INTO lms_list_token_session
                (
                token_session_name,
                account_id,
                token_session_start,
                token_session_end
                )
                VALUES
                (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_session_name#">,
                <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">,
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_start,'yyyy-mm-dd', 'fr')#">, 
                <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(token_session_end,'yyyy-mm-dd', 'fr')#">
                )
            </cfquery>

            <cfset _srlist = "">
            <cfif isDefined("SESSION.USER_SESSION_RIGHT_ID") AND SESSION.USER_SESSION_RIGHT_ID neq "">
                <cfset _srlist = SESSION.USER_SESSION_RIGHT_ID>
            </cfif>

            <cfset _srlist = listAppend(_srlist,new_token_session.generatedkey)>

            <cfquery name="up_right" datasource="#SESSION.BDDSOURCE#">
                UPDATE user SET 
                user_session_right_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_srlist#" list="yes">
                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
            </cfquery>

            <cfreturn new_token_session.generatedkey>
        
        <cfreturn 0>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
    
    
    </cffunction>

    <cffunction name="update_token_level" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="level" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">

        <cftry>

            <cfquery name="maj_token_level" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_list_token SET 
                token_level = <cfqueryparam cfsqltype="cf_sql_varchar" value="#level#">
                WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>

        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>

    <cffunction name="update_token_used" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="date" type="any" required="yes">
		<cfargument name="t_id" type="any" required="yes">

        <cftry>

            <cfquery name="maj_token_used" datasource="#SESSION.BDDSOURCE#">
                UPDATE lms_list_token SET 
                token_use = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#LSdateformat(date,'yyyy-mm-dd', 'fr')#">
                WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
            </cfquery>

        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


    <cffunction name="attribute_new_token" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<!--- <cfargument name="t_id" type="any" required="yes"> --->

        <cftry>

            
            <cfloop list="#token_list#" item="token_id">

                <!--- <cfdump var="#arguments["new_token_#token_id#"]#"> --->

                <cfif arguments["new_token_#token_id#"] neq "">

                    <cfquery name="insert_session" datasource="#SESSION.BDDSOURCE#" result="insert_session_id">
                        INSERT INTO lms_list_token SELECT 
                        NULL, 
                        tp_id, 
                        user_id, 
                        group_id,
                        certif_id, 
                        1,  <!--- token_status_id --->
                        token_session_id, 
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments["new_token_#token_id#"]#">, <!--- token_code --->
                        NULL, <!--- token_login --->
                        now(), <!--- token_creation --->
                        NULL,  <!--- token_send --->
                        NULL,  <!--- token_use --->
                        NULL,  <!--- token_end --->
                        NULL,  <!--- token_start --->
                        NULL,  <!--- token_level --->
                        token_method, 
                        0,  <!--- token_technic_remind --->
                        0,  <!--- token_certif_remind --->
                        token_description
                        FROM lms_list_token WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#"> 
                    </cfquery>

                </cfif>

            </cfloop>

        <cfreturn 1>

        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>

    <cffunction name="send_token" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cftry>


            <cfloop list="#arguments["token_list[]"]#" item="token_id">


                <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT lt.user_id, lt.token_code, lt.token_description, lt.token_status_id, lt.token_end,
                    lc.certif_name,
                    lts.token_session_method, lts.token_session_certif_type,
                    lts.token_session_start, lts.token_session_end
                    FROM lms_list_token lt
                    INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
                    INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
                    WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                 </cfquery>

                 <cfif get_token.token_status_id eq 1 OR get_token.token_status_id eq 2>
                    
                    <cfset subject = "WEFIT | Passage de votre certification LINGUASKILL">

                    <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                        <cfinvokeargument name="u_id" value="#get_token.user_id#">
                    </cfinvoke>


                    <cfset display_warning = "Bonjour #get_user.user_firstname#, vous allez passer la certification :<br><strong>#get_token.certif_name#</strong><br>">

                    <cfif get_token.token_session_method eq "PRESENTIEL">

                        <cfif get_token.token_session_start neq "">
                            <cfset display_warning &= "Votre certification en présentiel est prévue le :<br><strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>Veuillez impérativement conserver cet email et l'imprimer pour votre session en présentiel. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        <cfelse>
                            <cfset display_warning &= "Le passage de votre certification est prévu en présentiel.<br>Veuillez impérativement conserver cet email et l'imprimer ou noter les informations pour votre session. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        </cfif>
                            
                            <cfset no_install = 1>

                    <cfelse>

                        <cfif get_token.token_session_start neq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Votre certification doit être réalisée entre le <strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong> et le <strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')#</strong><br>">
                        <cfelseif get_token.token_session_start eq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Votre certification doit être réalisée avant le <strong>#lsDateFormat(get_token.token_end, 'dd/mm/yyyy', 'fr')#</strong><br>">
                        <cfelseif get_token.token_session_start neq "" AND get_token.token_session_end eq "">
                            <cfset display_warning &= "La date de passage de votre certification est fixée le <strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>">
                        </cfif>

                    </cfif>
                    
                    <cfset display_warning &= "<br>Les codes suivants seront nécessaires au passage de votre certification :">
                    
                    
                    <cfset user_email = get_user.user_email>
                    <!--- <cfset user_pwd = get_user.user_pwd> --->
                    <cfset user_pwd_chg = get_user.user_pwd_chg>

                    <cfset user_pwd = RandRange(100000, 999999)>

                    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                        UPDATE user 
                        SET 
                        user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                        user_pwd_chg = 0
                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">
                    </cfquery>


                    <p>
                        <cfoutput>
                            #get_token.token_code# #get_user.user_name#
                        </cfoutput>
                    </p>
                    

                    <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                        <cfset lang = "fr">
                        <cfset user_create_el = "1">
                        <cfinclude template="/email/email_token.cfm">
                    </cfmail>

                    <cfquery name="maj_user_status" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_list_token SET 
                        token_status_id = 2,
                        token_send = now()
                        WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                    </cfquery>
                </cfif>


            </cfloop>

            <cfreturn "ok">
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>







    <cffunction name="send_technic_reminder" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cftry>


            <cfloop list="#arguments["token_list[]"]#" item="token_id">


                <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT lt.user_id, lt.token_code, 
                    lc.certif_name,
                    lts.token_session_method, lts.token_session_certif_type,
                    lts.token_session_start, lts.token_session_end
                    FROM lms_list_token lt
                    INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
                    INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
                    WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                 </cfquery>

                <cfset subject = "WEFIT | Rappel et vérification technique pour votre certification LINGUASKILL">

                <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                    <cfinvokeargument name="u_id" value="#get_token.user_id#">
                </cfinvoke>

                <cfset display_warning = "Bonjour #get_user.user_firstname#, la date limite pour passer votre certification approche :<br><strong>#get_token.certif_name#</strong><br><br>N'attendez pas le dernier moment pour tester votre matériel ;)<br><br>">

                <cfif get_token.token_session_start neq "" AND get_token.token_session_end neq "">
                    <cfset display_warning &= "Votre certification doit être réalisée entre le <strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong> et le <strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')#</strong><br>">
                <cfelseif get_token.token_session_start eq "" AND get_token.token_session_end neq "">
                    <cfset display_warning &= "Votre certification doit être réalisée avant le <strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')#</strong><br>">
                <cfelseif get_token.token_session_start neq "" AND get_token.token_session_end eq "">
                    <cfset display_warning &= "La date de passage de votre certification est fixée le <strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>">
                </cfif>

                <cfset display_warning &= "<br>Vous avez déjà reçu dans un précédent email vos codes pour passer l'examen. Voici trois liens utiles :">
                

                <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_user.user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = "fr">
                    <cfinclude template="/email/email_token_technic_reminder.cfm">
                </cfmail>

            </cfloop>

            <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


    <cffunction name="send_deadline_approach" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cftry>


            <cfloop list="#arguments["token_list[]"]#" item="token_id">


                <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT lt.user_id, lt.token_code, lt.token_description, lt.token_status_id,
                    lc.certif_name,
                    lts.token_session_method, lts.token_session_certif_type,
                    lts.token_session_start, lts.token_session_end
                    FROM lms_list_token lt
                    INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
                    INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
                    WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                 </cfquery>

                 <cfif get_token.token_status_id eq 2>
                    
                    <cfset subject = "Plus que quelques jours pour passer le LINGUASKILL">

                    <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                        <cfinvokeargument name="u_id" value="#get_token.user_id#">
                    </cfinvoke>

                    <cfset display_warning = "Bonjour #get_user.user_firstname#, nous vous avons contacté il y a quelques temps pour le passage de votre certification :<br><strong>#get_token.certif_name#</strong><br><br>">

                    <cfif get_token.token_session_method eq "PRESENTIEL">

                        <cfif get_token.token_session_start neq "">
                            <cfset display_warning &= "Votre certification en présentiel est prévue le :<br><strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>Veuillez impérativement conserver cet email et l'imprimer pour votre session en présentiel. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        <cfelse>
                            <cfset display_warning &= "Le passage de votre certification est prévu en présentiel.<br>Veuillez impérativement conserver cet email et l'imprimer ou noter les informations pour votre session. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        </cfif>
                            
                            <cfset no_install = 1>

                    <cfelse>

                        <cfif get_token.token_session_start neq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Comme vous le savez peut-être, la certification n'est plus obligatoire. Cependant, il s'agit d'une opportunité réelle pour obtenir, gratuitement, un document officiel attestant de votre niveau. Vous avez jusqu'au <br><strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')# au soir pour passer votre certification.</strong><br>">
                        <cfelseif get_token.token_session_start eq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Comme vous le savez peut-être, la certification n'est plus obligatoire. Cependant, il s'agit d'une opportunité réelle pour obtenir, gratuitement, un document officiel attestant de votre niveau. Vous avez jusqu'au <br><strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')# au soir pour passer votre certification.</strong><br>">
                        <cfelseif get_token.token_session_start neq "" AND get_token.token_session_end eq "">
                            <cfset display_warning &= "La date de passage de votre certification est fixée le<br><strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>">
                        </cfif>

                    </cfif>
                    
                    <cfset display_warning &= "<br>Les codes suivants seront nécessaires au passage de votre certification :">
                    
                    
                    <cfset user_email = get_user.user_email>
                    <!--- <cfset user_pwd = get_user.user_pwd> --->

                    <cfset user_pwd = RandRange(100000, 999999)>

                    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                        UPDATE user 
                        SET 
                        user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                        user_pwd_chg = 0
                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">
                    </cfquery>

                    <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                        <cfset lang = "fr">
                        <cfinclude template="/email/email_token.cfm">
                    </cfmail>

                </cfif>


            </cfloop>

            <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


    <cffunction name="send_deadline_outdated_delay" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cftry>


            <cfloop list="#arguments["token_list[]"]#" item="token_id">


                <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT lt.user_id, lt.token_code, lt.token_description, lt.token_status_id,
                    lc.certif_name,
                    lts.token_session_method, lts.token_session_certif_type,
                    lts.token_session_start, lts.token_session_end
                    FROM lms_list_token lt
                    INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
                    INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
                    WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                 </cfquery>

                 <cfif get_token.token_status_id eq 2>
                    
                    <cfset subject = "WEFIT | Délai supplémentaire pour passer la certification">

                    <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                        <cfinvokeargument name="u_id" value="#get_token.user_id#">
                    </cfinvoke>

                    <cfset display_warning = "Bonjour #get_user.user_firstname#, nous vous avons contacté il y a quelques temps pour le passage de votre certification :<br><strong>#get_token.certif_name#</strong><br><br>">

                    <cfif get_token.token_session_method eq "PRESENTIEL">

                        <cfif get_token.token_session_start neq "">
                            <cfset display_warning &= "Votre certification en présentiel était prévue le :<br><strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>Veuillez impérativement conserver cet email et l'imprimer pour votre session en présentiel. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        <cfelse>
                            <cfset display_warning &= "Le passage de votre certification était prévu en présentiel.<br>Veuillez impérativement conserver cet email et l'imprimer ou noter les informations pour votre session. Munissez-vous également d'une pièce d'identité en cours de validité.<br>">
                        </cfif>
                            
                            <cfset no_install = 1>

                    <cfelse>

                        <cfif get_token.token_session_start neq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Votre certification devait être réalisée avant le<br><strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')# au soir</strong><br>">
                        <cfelseif get_token.token_session_start eq "" AND get_token.token_session_end neq "">
                            <cfset display_warning &= "Votre certification devait être réalisée avant le<br><strong>#lsDateFormat(get_token.token_session_end, 'dd/mm/yyyy', 'fr')# au soir</strong><br>">
                        <cfelseif get_token.token_session_start neq "" AND get_token.token_session_end eq "">
                            <cfset display_warning &= "La date de passage de votre certification était fixée le<br><strong>#lsDateFormat(get_token.token_session_start, 'dd/mm/yyyy', 'fr')#</strong><br>">
                        </cfif>

                    </cfif>
                    
                    <cfset display_warning &= "<br><br> L'Université vous accorde un délai supplémentaire d'une semaine à partir de la réception de cet email, vous avez jusqu'au : <br> <strong>10 juin 2022 au soir</strong><br> pour passer votre certification.<br>Les codes suivants seront nécessaires au passage de votre certification :">
                    
                    
                    <cfset user_email = get_user.user_email>
                    <!--- <cfset user_pwd = get_user.user_pwd> --->

                    <cfset user_pwd = RandRange(100000, 999999)>

                    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                        UPDATE user 
                        SET 
                        user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                        user_pwd_chg = 0
                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">
                    </cfquery>

                    <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                        <cfset lang = "fr">
                        <cfinclude template="/email/email_token.cfm">
                    </cfmail>

                </cfif>


            </cfloop>

            <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>





    <cffunction name="send_regenerate_token" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="token_list" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cftry>


            <cfloop list="#arguments["token_list[]"]#" item="token_id">


                <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT lt.user_id, lt.token_code, lt.token_description, lt.token_status_id,
                    lc.certif_name,
                    lts.token_session_method, lts.token_session_certif_type,
                    lts.token_session_start, lts.token_session_end
                    FROM lms_list_token lt
                    INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
                    INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
                    WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                 </cfquery>

                 <!--- <cfif get_token.token_status_id eq 2> --->
                    
                    <cfset subject = "WEFIT | Linguaskill : Non respect des conditions de passage">

                    <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                        <cfinvokeargument name="u_id" value="#get_token.user_id#">
                    </cfinvoke>

                    <cfset display_warning = "Bonjour #get_user.user_firstname#, vous avez récemment passé votre certification LINGUASKILL en ligne<br><br>">
                    
                    <cfset display_warning &= "Notre équipe n'a pas été en mesure de valider votre certification.<br>Certaines conditions de passage non pas été respectées (mauvaise utilisation du logiciel, problèmes de webcam...).<br><br>A la demande de l'Université, vous allez devoir passer à nouveau le test, dans le respect des conditions de passage.<br><br>Si vous le souhaitez, vous pouvez contacter notre équipe pour plus d'information.<br><br>Voici votre nouveau code, nécessaire au passage de votre certification :">
                    
                    
                    <cfset user_email = get_user.user_email>
                    <!--- <cfset user_pwd = get_user.user_pwd> --->

                    <cfset user_pwd = RandRange(100000, 999999)>

                    <cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
                        UPDATE user 
                        SET 
                        user_password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
                        user_pwd_chg = 0
                        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.user_id#">
                    </cfquery>

                    <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                        <cfset lang = "fr">
                        <cfinclude template="/email/email_token.cfm">
                    </cfmail>

                    <cfquery name="maj_user_status" datasource="#SESSION.BDDSOURCE#">
                        UPDATE lms_list_token SET 
                        token_status_id = 2,
                        token_send = now()
                        WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
                    </cfquery>

                <!--- </cfif> --->


            </cfloop>

            <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>




    <cffunction name="upload_certif_user" access="remote" returntype="any" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">
		<cfargument name="u_id" type="any" required="no">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="t_id" type="any" required="no">

        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">

            <cfset dir_go = "#SESSION.BO_ROOT#/admin/cert/#u_id#">

            <cfif not directoryExists(dir_go)>
			
                <cfdirectory directory="#dir_go#" action="create" mode="777">
                
            </cfif>

            <cffile action = "upload" 
            filefield = "doc_attach" 
            allowedExtensions = ".pdf"
            destination = "#dir_go#" 
            result="uploaded_file"
            nameConflict = "Overwrite"
            mode="777">					
                                
            <cfdump var="#uploaded_file#">
            <cfif uploaded_file.FileWasSaved>

                <cfdump var="#t_id#">

                <cffile action="rename" 
                source = "#dir_go#/#uploaded_file.ClientFile#" 
                destination = "#dir_go#/#t_id#.#lcase(uploaded_file.clientFileExt)#" 
                attributes="normal"
                mode="777"> 

                <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                    <cfinvokeargument name="u_id" value="#u_id#">
                </cfinvoke>

                <cfset subject= "Votre résultat de certification Linguaskill">

                    <!--- to="#get_user.user_email#" --->
                <cfmail from="WEFIT <service@wefitgroup.com>" to="#get_user.user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                    <cfset lang = "fr">
                    <cfinclude template="/email/email_token_certif_send.cfm">
                    <cfmailparam file = "#dir_go#/#t_id#.#uploaded_file.clientFileExt#" type="application/pdf">
                </cfmail>

                <!--- <cfthread name="delete_file" action="run">
                    <cfset sleep(5000)>
                    <cffile action="DELETE" file="#dir_go#/#uploaded_file.ClientFile#">
                </cfthread> --->


                <cfquery name="maj_user_status" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_list_token SET 
                    token_status_id = 3
                    WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
                </cfquery>

			</cfif>

		</cfif>
        <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


    <cffunction name="upload_token_batch" access="remote" returntype="any" output="false" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">
		<cfargument name="a_id" type="any" required="no">
		<cfargument name="s_id" type="any" required="no">

        <cfset school = {
            873 = {
                firstname = 5,
                name = 3,
                email = 6,
                token_code = 9,
                deadline = 7,
                wefit_send = 8,
                passing_date = 10,
                grade = 11
            }
        }>
        
        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">

            <cfset dir_go = "#SESSION.BO_ROOT#/parser/temp">

            <cffile action = "upload" 
            filefield = "doc_attach" 
            allowedExtensions = ".csv"
            destination = "#dir_go#" 
            result="uploaded_file"
            nameConflict = "Overwrite"
            mode="777">					
                                
            <cfdump var="#uploaded_file#">
            <cfif uploaded_file.FileWasSaved>

				<cffile action="read" 
                file="#dir_go#/#uploaded_file.ClientFile#" 
                variable="vartemp" 
                charset="utf-8">

                <cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
                <cfoutput>
                    
                    <cftry>

                        <cfset data = StructNew()>

                        <cfloop index="i" from="1" to="#listLen(encours)#" >
                            <cfset data[i] = replacenocase(listgetat(encours,i,',',true),'"','','ALL')>
                            <p>#data[i]#</p>
                        </cfloop>
                        
                        <cfquery name="select_token" datasource="#SESSION.BDDSOURCE#">
                            SELECT token_id, user_id FROM lms_list_token
                            WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data[school[a_id].token_code]#">
                        </cfquery>
                         
                        <cfif select_token.recordcount eq 0>
                            <p>INSERT</p>
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
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data[school[a_id].firstname]#">,
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(data[school[a_id].name])#">,
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(data[school[a_id].email]))#">,
                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
                                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
                                'fr',			
                                4,
                                3
                                );
                            </cfquery>


                            <cfquery name="ins_token" datasource="#SESSION.BDDSOURCE#">
                                INSERT INTO lms_list_token 
                                (
                                    tp_id,
                                    certif_id,
                                    user_id,
                                    token_send,
                                    token_creation,
                                    token_code,
                                    token_session_id,
                                    token_end
                                )
                                VALUES
                                (
                                    0,
                                    23,
                                    <cfqueryparam cfsqltype="cf_sql_integer" value="#new_user.generatedkey#">,
                                    <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(data[school[a_id].wefit_send],'yyyy-mm-dd', 'fr')#">, 
                                    now(),
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data[school[a_id].token_code]#">,
                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#s_id#">,
                                    <cfqueryparam cfsqltype="CF_SQL_DATE" value="#LSDateFormat(data[school[a_id].deadline],'yyyy-mm-dd', 'fr')#">
                                )
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

                        <cfelse>
                            <p>UPDATE</p>

                            <!--- // TODO add result to bdd --->
                            <cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
                                UPDATE lms_list_token SET 
                                token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
                                WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#data[school[a_id].token_code]#">
                            </cfquery>

                         </cfif>

                        
                        <cfcatch type="any">
                            Error: <cfoutput>#cfcatch.message#</cfoutput>
                        </cfcatch>
                    </cftry>
                   

                </cfoutput>
                </cfloop>


                <cfquery name="maj_token_session" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_list_token_session SET 
                    token_session_last_update = now()
                    WHERE token_session_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#s_id#">
                </cfquery>


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

    <cffunction name="upload_token_batch_cambridge" access="remote" returntype="any" output="true" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">
        
        <cfset list_updated = "">
        <cfset SESSION.BATCH_CAMBRIDGE_UPLOAD = 1>


        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">

            <cfset dir_go = "#SESSION.BO_ROOT#/parser/temp">

            <cffile action = "upload" 
            filefield = "doc_attach" 
            allowedExtensions = ".xlsx"
            destination = "#dir_go#" 
            result="uploaded_file"
            nameConflict = "Overwrite"
            mode="777">					
                                
            <cfdump var="#uploaded_file#">
            <cfif uploaded_file.FileWasSaved>

                
                <cfspreadsheet 
                action="read" 
                src="#dir_go#/#uploaded_file.ClientFile#" 
                query="qData" 
                sheet="1"/>

                <cfset qData = queryDeleteRow(qData,1)>
                <cfset qData = queryDeleteRow(qData,1)>

                <!--- 
                    col_1 - Client Name
                    col_9 - Reading & Listening#chr(10)#Entry Code
                    col_12 - Reading & Listening#chr(10)#End Time
                    col_3 - Candidate#chr(10)#Login
                    col_30 - CEFR#chr(10)#Level
                --->
                <cfdump var="#qData#">
                
                <cfloop query="qData">
                    <cfdump var="#currentRow#">

                    <cfif currentRow GT 0>
                        
                        <cftry>

                            <!--- <cfquery name="select_token" datasource="#SESSION.BDDSOURCE#">
                                SELECT lt.token_id, lt.user_id, lts.token_session_start, lts.token_session_end, lts.account_id
                                FROM lms_list_token_session lts 
                                LEFT JOIN lms_list_token lt ON lt.token_session_id = lts.token_session_id AND lt.token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['Reading & Listening#chr(10)#Entry Code'][currentRow]#">
                                WHERE lts.token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
                            </cfquery> --->
                            
                            <cfif qData['col_17'][currentRow] neq "">
                                <cfset token_code = qData['col_17'][currentRow]>
                                <cfset token_use = lsDateTimeFormat(qData['col_20'][currentRow],'yyyy-mm-dd HH:nn:ss', 'fr')>
                            </cfif>
                            <cfif qData['col_13'][currentRow] neq "">
                                <cfset token_code = qData['col_13'][currentRow]>
                                <cfset token_use = lsDateTimeFormat(qData['col_16'][currentRow],'yyyy-mm-dd HH:nn:ss', 'fr')>
                            </cfif>
                            <cfif qData['col_9'][currentRow] neq "">
                                <cfset token_code = qData['col_9'][currentRow]>
                                <cfset token_use = lsDateTimeFormat(qData['col_12'][currentRow],'yyyy-mm-dd HH:nn:ss', 'fr')>
                            </cfif>

                            
                            <p>UPDATE <cfoutput>#token_code# - #token_use#</cfoutput></p>

                            <cfset status = -1>

                            <cfif qData['col_1'][currentRow] eq 1>

                                <cfquery name="select_token" datasource="#SESSION.BDDSOURCE#">
                                    SELECT token_status_id 
                                    FROM lms_list_token 
                                    WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_code#">
                                </cfquery>
                                
                                <cfif select_token.token_status_id eq 4>
                                    <cfset status = 2>
                                </cfif>
                            </cfif>

                            <cfif qData['col_1'][currentRow] eq 0 >
                                <cfset status = 4>
                            </cfif>

                            <cfset _login = Replace(qData['col_3'][currentRow], " ", "", "ALL")/>

                            <cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
                                UPDATE lms_list_token SET 
                                <cfif status neq -1> token_status_id = #status#,</cfif>
                                token_use = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#token_use#">, 
                                token_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_login#">,
                                token_level = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qData['col_30'][currentRow]#">
                                WHERE token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#token_code#">
                            </cfquery>

                            <cfset list_updated = listappend(token_code,list_updated)>

                        <cfcatch type="any">
                            Error: <cfoutput>#cfcatch.message#</cfoutput>
                        </cfcatch>
                        </cftry>

                    </cfif>
                </cfloop>


                <!--- <cfquery name="maj_token_session" datasource="#SESSION.BDDSOURCE#">
                    UPDATE lms_list_token_session SET 
                    token_session_last_update = now()
                    WHERE token_session_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#s_id#">
                </cfquery> --->


				<cffile action="DELETE" file="#dir_go#/#uploaded_file.ClientFile#">

                <cfset SESSION.BATCH_CAMBRIDGE_UPLOAD = 0>
									

			</cfif>

					

		</cfif>
        
        <cfset SESSION.TOKEN_LIST = list_updated>

        <cfreturn 1>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>






    <cffunction name="upload_certif_batch" access="remote" returntype="any" output="true" returnFormat="JSON">
		<cfargument name="doc_attach" type="any" required="yes">


        <cftry>

		<cfif isdefined("doc_attach") AND doc_attach neq "">

            <cfdump var="#arguments#">

            <cfset nope_list = "">

            
            <cfpdf action="getinfo"
            source= "#doc_attach#" 
            name = "fullPdf">

            <cfdump var="#fullPdf#">
            
            <cfloop index = "idx" from="1" to="#fullPdf.TotalPages#" step="2">

                <cftry>

                <cfpdf action="extracttext"
                source= "#doc_attach#" 
                pages = "#idx#"
                type = "xml"
                name = "_pdfpage" 
                usestructure = "true">

                <cfset a = _pdfpage.Split(" ")>

                <cfset _login = "">
                <cfset index = 7>


                <cfloop condition="!(a[index] eq 'Ref' AND a[index + 1] eq '.' AND a[index + 2] eq 'No' AND a[index + 3] eq '.')">
                    <cfset _login &= a[index]>
                    <cfset index++>
                </cfloop>

                <!--- pdf wtf ... --->
                <cfset results = reMatchNoCase("[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,63}", _login)>

                <cfif arrayLen(results) GT 0>
                    <cfset _login = results[1]>
                </cfif>

                <cfif right(_login, 2) eq "FR" AND right(_login, 3) neq ".fr">
                    <cfset _login = left(_login, len(_login) - 2)>
                </cfif>

                <p>Login : <cfoutput>#_login#</cfoutput></p>

                <cfquery name="select_token" datasource="#SESSION.BDDSOURCE#">
                    SELECT token_id, token_code, user_id, token_status_id FROM lms_list_token
                    WHERE token_login = <cfqueryparam cfsqltype="cf_sql_varchar" value="#_login#">
                    ORDER BY token_send DESC
                    LIMIT 1
                </cfquery>


                <!---  AND token_status_id NOT IN (3,4) --->
                <cfif select_token.recordCount GT 0>
                    <cfif select_token.token_status_id neq 3 AND select_token.token_status_id neq 4>

                        <cfset dir_go = "#SESSION.BO_ROOT#/admin/cert/#select_token.user_id#">

                        <cfif not directoryExists(dir_go)>
                        
                            <cfdirectory directory="#dir_go#" action="create" mode="777">
                            
                        </cfif>

                        <cfpdf action="merge"
                        source= "#doc_attach#" 
                        pages = "#idx#,#idx+1#"
                        overwrite = "yes"
                        destination="#dir_go#/#select_token.token_code#.pdf">

                        <cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
                            <cfinvokeargument name="u_id" value="#select_token.user_id#">
                        </cfinvoke>

                        <cfset subject= "Votre résultat de certification Linguaskill">

                            <!--- to="#get_user.user_email#"  bcc="rremacle@wefitgroup.com"  --->
                        <cfmail from="WEFIT <service@wefitgroup.com>"  to="#get_user.user_email#" bcc="certif@wefitgroup.com" subject="#subject#" type="html" server="localhost">
                            <cfset lang = "fr">
                            <cfinclude template="/email/email_token_certif_send.cfm">
                            <cfmailparam file = "#dir_go#/#select_token.token_code#.pdf" type="application/pdf">
                        </cfmail>

                        <!--- <cfthread name="delete_file" action="run">
                            <cfset sleep(5000)>
                            <cffile action="DELETE" file="#dir_go#/#uploaded_file.ClientFile#">
                        </cfthread> --->


                        <cfquery name="maj_user_status" datasource="#SESSION.BDDSOURCE#">
                            UPDATE lms_list_token SET 
                            token_status_id = 3,
                            token_certif_send = now()
                            WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#select_token.token_id#">
                        </cfquery>

                    <cfelse>
                        <cfset nope_list = listappend(_login,nope_list)>
                    </cfif>
                <cfelse>
                    <cfset nope_list = listappend(_login,nope_list)>
                </cfif>

                <cfcatch type="any">
                    Error: <cfoutput>#cfcatch.message#</cfoutput>
                </cfcatch>
                </cftry>

            </cfloop>


		</cfif>
        <cfreturn nope_list>
        <cfcatch type="any">
            Error: <cfoutput>#cfcatch.message#</cfoutput>
            <cfreturn 0>
        </cfcatch>
        </cftry>
	</cffunction>


</cfcomponent>