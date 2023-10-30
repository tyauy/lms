<cfsilent>

<cfif SESSION.USER_PROFILE eq "TRAINER">
	
	<cfquery name="get_learner_search" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, u.user_phone, us.user_status_name_#SESSION.LANG_CODE# as status_name
	
		FROM user u
		LEFT JOIN lms_tpuser tu ON tu.user_id = u.user_id AND tu.tpuser_active = 1
		LEFT JOIN lms_tpplanner p ON p.tp_id = tu.tp_id AND p.active = 1
		LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		
		WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfquery name="get_acc_search" datasource="#SESSION.BDDSOURCE#">
	SELECT account_id, account_name
	FROM account
	</cfquery>
	
	<cfquery name="get_gp_search" datasource="#SESSION.BDDSOURCE#">
	SELECT group_id, group_name
	FROM account_group
	</cfquery>
	
	<cfquery name="get_ctc_search" datasource="#SESSION.BDDSOURCE#">
	SELECT ac.contact_id, a.account_id, CONCAT(ac.contact_firstname, " ",UCASE(ac.contact_name), " (", a.account_name, ")") as contact_name
	FROM account_contact ac
	INNER JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id
	INNER JOIN account a ON a.account_id = acc.a_id
	</cfquery>
	
	<cfquery name="get_learner_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, Replace(Replace(u.user_phone,CHAR(13),' '),CHAR(10), ' ') as user_phone, 
	us.user_status_name_#SESSION.LANG_CODE# as status_name 
	FROM user u 
	INNER JOIN user_status us ON us.user_status_id = u.user_status_id
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="3">
	ORDER BY u.user_name
	</cfquery>
	
	<cfquery name="get_lead_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="7">
	</cfquery>
	
	<cfquery name="get_test_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="9">
	</cfquery>
	
	<cfquery name="get_contact_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="10">
	</cfquery>

	<cfquery name="get_sm_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as sm_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="10">
	</cfquery>

	<cfquery name="get_tm_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as tm_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="8">
	</cfquery>

	<cfquery name="get_partner_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as partner_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="13">
	</cfquery>
	
	<cfquery name="get_trainer_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT u.user_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as trainer_name
	FROM user u 
	INNER JOIN account a ON a.account_id = u.account_id
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
	</cfquery>

	<cfquery name="get_list_token_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT llt.token_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as token_name, llt.token_code
	FROM lms_list_token llt 
	INNER JOIN user u ON u.user_id = llt.user_id
	</cfquery>

	<!--- <cfquery name="get_order_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
	SELECT o.order_id, o.order_ref, o.order_ref2, o.account_id, a.account_name as account_name, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as user_name, u.user_id
	FROM orders o 
	INNER JOIN account a on a.account_id = o.account_id
	LEFT JOIN orders_users ou on ou.order_id = o.order_id
	LEFT JOIN user u on u.user_id = ou.user_id
	</cfquery> --->
	
</cfif>


</cfsilent>