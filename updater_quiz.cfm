<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfif (isdefined("u_id") OR isdefined("p_id"))
	AND 
	(isdefined("del_qpt_fr") 
	OR isdefined("del_qpt_en") 
	OR isdefined("del_qpt_de") 
	OR isdefined("del_qpt_es") 
	OR isdefined("del_qpt_it") 
	OR isdefined("del_qpt_ru") 
	OR isdefined("del_qpt_pt") 
	OR isdefined("del_qpt_nl")
	OR isdefined("del_qpt_zh")
	)
	>

		<cfif isDefined("quiz_user_group_id")>

		<cfquery name="get_quiz_user" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_user_id FROM lms_quiz_user WHERE user_id = 

		<cfif isdefined("u_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		<cfelseif isdefined("p_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
		</cfif>

		AND quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> 

		<!---<cfif isdefined("del_qpt_fr")>
		AND (quiz_id = 1605 OR quiz_id = 1606 OR quiz_id = 1607 OR quiz_id = 1608 OR quiz_id = 1608)
		<cfelseif isdefined("del_qpt_en")>
		AND (quiz_id = 8 OR quiz_id = 9 OR quiz_id = 10 OR quiz_id = 17 OR quiz_id = 18)
		<cfelseif isdefined("del_qpt_de")>
		AND (quiz_id = 1564 OR quiz_id = 1565 OR quiz_id = 1566 OR quiz_id = 1567 OR quiz_id = 1568)
		<cfelseif isdefined("del_qpt_es")>
		AND (quiz_id = 1612 OR quiz_id = 1613 OR quiz_id = 1614 OR quiz_id = 1615 OR quiz_id = 1616)
		<cfelseif isdefined("del_qpt_it")>
		AND (quiz_id = 1760 OR quiz_id = 1761 OR quiz_id = 1762 OR quiz_id = 1763 OR quiz_id = 1764)
		<cfelseif isdefined("del_qpt_ru")>
		AND (quiz_id = 1722 OR quiz_id = 1723 OR quiz_id = 1724 OR quiz_id = 1725 OR quiz_id = 1726)
		<cfelseif isdefined("del_qpt_pt")>
		AND (quiz_id = 1627 OR quiz_id = 1628 OR quiz_id = 1629 OR quiz_id = 1630 OR quiz_id = 1631)
		<cfelseif isdefined("del_qpt_nl")>
		AND (quiz_id = 1750 OR quiz_id = 1751 OR quiz_id = 1752 OR quiz_id = 1753 OR quiz_id = 1754)
		<cfelseif isdefined("del_qpt_zh")>
		AND (quiz_id = 1727 OR quiz_id = 1728 OR quiz_id = 1729 OR quiz_id = 1730 OR quiz_id = 1731)
		</cfif>--->

		</cfquery>

		<cfdump var="#get_quiz_user#">

		<cfoutput query="get_quiz_user">

			<cfquery name="del_answers" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_result WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
			</cfquery>
			
			<cfquery name="del_quiz" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_user WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> 
			AND user_id = 
			<cfif isdefined("u_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			<cfelseif isdefined("p_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
			</cfif>
			</cfquery>
			
		</cfoutput>

		<cfquery name="del_quiz_score" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_user_score WHERE quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> 
			AND user_id = 
			<cfif isdefined("u_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			<cfelseif isdefined("p_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
			</cfif>
		</cfquery>

		</cfif>


		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET 
		
		<cfif isdefined("del_qpt_fr")>
		user_qpt_fr = null, user_qpt_lock_fr = null 
		<cfelseif isdefined("del_qpt_en")>
		user_qpt_en = null, user_qpt_lock_en = null 
		<cfelseif isdefined("del_qpt_de")>
		user_qpt_de = null, user_qpt_lock_de = null 
		<cfelseif isdefined("del_qpt_es")>
		user_qpt_es = null, user_qpt_lock_es = null 
		<cfelseif isdefined("del_qpt_it")>
		user_qpt_it = null, user_qpt_lock_it = null 
		<cfelseif isdefined("del_qpt_ru")>
		user_qpt_ru = null, user_qpt_lock_ru = null 
		<cfelseif isdefined("del_qpt_pt")>
		user_qpt_pt = null, user_qpt_lock_pt = null 
		<cfelseif isdefined("del_qpt_nl")>
		user_qpt_nl = null, user_qpt_lock_nl = null 
		<cfelseif isdefined("del_qpt_zh")>
		user_qpt_zh = null, user_qpt_lock_zh = null 
		</cfif>
		
		WHERE user_id = 
		<cfif isdefined("u_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		<cfelseif isdefined("p_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
		</cfif>
		
		</cfquery>
		
		

	</cfif>


	






















	<cfif (isdefined("u_id") OR isdefined("p_id")) AND isdefined("del_lst")>

		<cfquery name="get_quiz_user" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_user_id, quiz_user_group_id FROM lms_quiz_user WHERE user_id = 
			<cfif isdefined("u_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			<cfelseif isdefined("p_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
			</cfif> 
			AND quiz_id = 3
		</cfquery>

<cfdump var="#get_quiz_user#">

		<cfif get_quiz_user.recordcount eq "1">
		<cfoutput query="get_quiz_user">
			
			<!--- REMOVE ANSWERS --->
			<cfquery name="del_quiz" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_result WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
			</cfquery>
			
			<!--- REMOVE QUIZ --->
			<cfquery name="del_quiz" datasource="#SESSION.BDDSOURCE#">
			DELETE FROM lms_quiz_user WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND user_id = 
			<cfif isdefined("u_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
			<cfelseif isdefined("p_id")>
				<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
			</cfif> 
			</cfquery>
			
			<cfquery name="del_quiz_score" datasource="#SESSION.BDDSOURCE#">
				DELETE FROM lms_quiz_user_score WHERE quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> 
				AND user_id = 
				<cfif isdefined("u_id")>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
				<cfelseif isdefined("p_id")>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
				</cfif>
			</cfquery>

		</cfoutput>

		<cfquery name="updt_user" datasource="#SESSION.BDDSOURCE#">
		UPDATE user SET user_lst = null, user_lst_lock = null WHERE user_id = 
		<cfif isdefined("u_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		<cfelseif isdefined("p_id")>
			<cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> 
		</cfif> 
		</cfquery>
		</cfif>
		
		
	</cfif>


	<cfif isdefined("u_id")>
		<cflocation addtoken="no" url="common_learner_account.cfm?u_id=#u_id#&k=1">
	<cfelseif isdefined("p_id")>
		<cflocation addtoken="no" url="common_trainer_account.cfm?p_id=#p_id#&k=1">
	</cfif>


</cfif>