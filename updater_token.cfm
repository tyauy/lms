<cfif isdefined("t_id") AND isdefined("action")>

	<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_token t
	INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
	WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfquery>
	
	<cfif action eq "create">

		<cfquery name="check_user" datasource="#SESSION.BDDSOURCE#">
		SELECT user_id FROM user WHERE user_email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#user_email#"> AND profile_id <> 8
		</cfquery>
		
		<cfif check_user.recordcount neq "0">
		
			<cflocation addtoken="no" url="db_certif_list.cfm?e=1">
			<cfabort>
			
		<cfelse>
			
			<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#" result="insert_user">
			INSERT INTO user
			(
			account_id,
			profile_id,
			timezone_id,
			user_gender,
			user_firstname,
			user_name,
			user_email,
			user_password,
			<cfif user_phone neq "">
				user_phone,
				user_phone_code,
			</cfif>
			user_create,
			user_lang,
			user_status_id,
			user_type_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#account_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#profile_id#">,
			6,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_gender#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_firstname#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#ucase(user_lastname)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(user_email))#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(user_pwd)#">,
			<cfif user_phone neq "">
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_phone_code#">,
			</cfif>
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#user_lang#">,			
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_status_id#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#user_type_id#">
			);
			</cfquery>
			
			<!--- <cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(user_id) as id FROM user
			</cfquery> --->

			<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO user_profile_cor
			(
			user_id,
			profile_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#profile_id#">
			)
			</cfquery>

			
			<!----- TOKEN ATTRIBUTION ----->
			<cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
			UPDATE lms_list_token SET 
			user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			token_status_id = 2,
			token_send = now()			
			WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
			</cfquery>
			
			<cfif isdefined("user_create_el") AND user_create_el eq "1">
			<!----- ELEARNING TP CREATION IF NEEDED ---->
			<cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#" result="insert_tp">		
			INSERT INTO lms_tp
			(
			user_id,
			tp_status_id,
			tp_date_start,
			tp_date_end,
			tp_duration,
			order_id,
			formation_id,
			method_id,
			elearning_id,
			elearning_duration
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			2,
			now(),
			#DateAdd("m",1,now())#,
			1,
			1,
			2,
			3,
			1,
			1
			)
			</cfquery>

			<!--- <cfquery name="get_max_tp" datasource="#SESSION.BDDSOURCE#">
			SELECT MAX(tp_id) as id FROM lms_tp
			</cfquery> --->

			<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpuser
			(
			user_id,
			tp_id
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_user.generatedkey#">,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
			)
			</cfquery>

			<cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_tpplanner (
                    tp_id,
                    planner_id,
                    active
                )
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
                    4784,
                    1
                )
            </cfquery>

			</cfif>
		
			<cfif user_lang eq "fr">
				<cfset subject = "WEFIT | Passage de votre certification">
			<cfelseif user_lang eq "en">
				<cfset subject = "WEFIT | Certification">
			<cfelseif user_lang eq "de">
				<cfset subject = "WEFIT | Certification">
			<cfelseif user_lang eq "es">
				<cfset subject = "WEFIT | Certification">
			<cfelseif user_lang eq "it">
				<cfset subject = "WEFIT | Certification">
			</cfif>			
			
			<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
				<cfset lang = user_lang>
				<cfinclude template="./email/email_token.cfm">
			</cfmail>
			
			<cflocation addtoken="no" url="db_certif_list.cfm?u_id=#insert_user.generatedkey#&k=1">

			
		</cfif>
		
	<cfelseif action eq "send">
	
		<cfset subject = "WEFIT | Passage de votre certification">

		<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
			<cfinvokeargument name="u_id" value="#get_token.user_id#">
		</cfinvoke>
		
		<cfset user_create_el = "1">
		
		<cfset user_email = get_user.user_email>
		<!--- <cfset user_pwd = get_user.user_pwd> --->
		<cfset user_pwd = "">

		<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" subject="#subject#" type="html" server="localhost">
			<cfset lang = "fr">
			<cfinclude template="./email/email_token.cfm">
		</cfmail>
		
		MAIL SENT !
		
		<!--- <cflocation addtoken="no" url="db_certif_list.cfm?k=2##user_#get_token.user_id#"> --->
		
	<cfelseif action eq "affect" AND isdefined("user_id")>
	
		<cfset subject = "WEFIT | Passage de votre certification">

		<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
			<cfinvokeargument name="u_id" value="#user_id#">
		</cfinvoke>
		
		<cfset user_email = get_user.user_email>
		
		<!----- TOKEN ATTRIBUTION ----->
		<cfquery name="maj_token" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_list_token SET 
		user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
		token_status_id = 2,
		token_send = now()			
		WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		</cfquery>
			
		<cfif isdefined("user_create_el") AND user_create_el eq "1">
		<!----- ELEARNING TP CREATION IF NEEDED ---->
		<cfquery name="insert_user" datasource="#SESSION.BDDSOURCE#" result="insert_tp">		
		INSERT INTO lms_tp
		(
		user_id,
		tp_status_id,
		tp_date_start,
		tp_date_end,
		tp_duration,
		order_id,
		formation_id,
		method_id,
		elearning_id,
		elearning_duration
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
		2,
		now(),
		#DateAdd("m",1,now())#,
		1,
		1,
		2,
		3,
		1,
		1
		)
		</cfquery>
		
		<!--- <cfquery name="get_max_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(tp_id) as id FROM lms_tp
		</cfquery> --->

		<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_tpuser
		(
		user_id,
		tp_id
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
		)
		</cfquery>
		
		<cfquery name="update_trainer" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_tpplanner (
				tp_id,
				planner_id,
				active
			)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
				4784,
				1
			)
		</cfquery>

		</cfif>
		
		<cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
			<cfset lang = "fr">
			<cfinclude template="./email/email_token.cfm">
		</cfmail>
		
		<cflocation addtoken="no" url="db_certif_list.cfm?k=2##user_#user_id#">
	
	
	
	</cfif>
	

</cfif>