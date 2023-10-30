<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>

<cfif isdefined("act") AND act eq "updt_qu" AND isdefined("quiz_id") AND isdefined("qu_id") AND not isdefined("ans_id")>

	<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_question
		SET
		qu_title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_title#">,
		qu_advise = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_advise#">,
		qu_text = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_text#">,
		qu_header = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_header#">,
		qu_timer = <cfif qu_timer eq "">null,<cfelse><cfqueryparam cfsqltype="cf_sql_integer" value="#qu_timer#">,</cfif>
		qu_category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_category#">,
		qu_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_type#">,
		material_id = <cfif material_id eq "0">null<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#material_id#"></cfif>
		WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>

	<cfquery name="updt_cor" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_cor
		SET qu_ranking = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_ranking#">
		WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>

	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">

<cfelseif isdefined("act") AND act eq "ins_quiz" AND not isdefined("quiz_id")>

	<cfquery name="ins_quiz" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_quiz
	(
	quiz_name, 
	sessionmaster_id,
	quiz_type, 
	quiz_description
	)
	VALUES 
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_name#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#sessionmaster_id#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_description#">
	)
	</cfquery>
	
	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT max(quiz_id) as id FROM lms_quiz
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#get_id.id#">
	
<cfelseif isdefined("act") AND act eq "ins_question">

	<cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_quiz_question
	(
	qu_title,
	qu_text,
	qu_timer,
	qu_category_id,
	qu_type,
	material_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_title#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_text#">,
	 <cfif qu_timer eq "">null,<cfelse><cfqueryparam cfsqltype="cf_sql_integer" value="#qu_timer#">,</cfif>
	<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_category#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_type#">,
	<cfif material_id eq "0">null<cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="#material_id#"></cfif>
	)
	</cfquery>
	
	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT max(qu_id) as id FROM lms_quiz_question
	</cfquery>
	
	<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_quiz_cor
	(
	quiz_id,
	qu_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.id#">
	)
	</cfquery>
	
	<cfquery name="get_max_rank" datasource="#SESSION.BDDSOURCE#">
	SELECT max(qu_ranking) as id FROM lms_quiz_cor 
	WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	<!---AND qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.id#">--->
	</cfquery>
	
	<cfif get_max_rank.id eq "">
		<cfquery name="updt_cor" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_cor SET qu_ranking = 1
		WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		AND qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.id#">
		</cfquery>
	<cfelse>
		<cfquery name="updt_cor" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_cor SET qu_ranking = #get_max_rank.id+1#
		WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		AND qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_id.id#">
		</cfquery>
	</cfif>
	
	<cfquery name="get_count" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(qu_id) as nb FROM lms_quiz_cor WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_quiz SET quiz_nbqu = #get_count.nb#
	WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#get_id.id#">
	
<cfelseif isdefined("act") AND act eq "updt_quiz" AND isdefined("quiz_id")>

	<cfquery name="ins_quiz" datasource="#SESSION.BDDSOURCE#">
	UPDATE lms_quiz SET 
	quiz_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_name#">,
	quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_type#">,
	quiz_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_description#">,
	quiz_active = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_active#">
	WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cfquery name="get_id" datasource="#SESSION.BDDSOURCE#">
	SELECT max(quiz_id) as id FROM lms_quiz
	</cfquery>
	
	<cfif isdefined("qu_id")>
		<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">
	<cfelse>
		<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&k=1">
	</cfif>
	
<cfelseif isdefined("act") AND act eq "duplicate_qu" AND isdefined("quiz_id") AND isdefined("qu_id")>

	<cfquery name="get_qu" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz_question WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_quiz_question
	(
	qu_title,
	qu_text,
	qu_header,
	qu_timer,
	qu_category_id,
	qu_type,
	material_id
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_title#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_text#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_header#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_timer#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_category_id#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.qu_type#">,
	<cfqueryparam cfsqltype="cf_sql_varchar" value="#get_qu.material_id#">
	)
	</cfquery>
	
	<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
	SELECT max(qu_id) as id FROM lms_quiz_question
	</cfquery>
	
	<cfquery name="get_max_rank" datasource="#SESSION.BDDSOURCE#">
	SELECT max(qu_ranking) as id FROM lms_quiz_cor 
	WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cfquery name="updt_cor" datasource="#SESSION.BDDSOURCE#">
	INSERT INTO lms_quiz_cor
	(
	quiz_id,
	qu_id,
	qu_ranking
	)
	VALUES
	(
	<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
	<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_rank.id+1#">
	)
	</cfquery>
			
	<cfquery name="get_ans" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_quiz_answer WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cfoutput query="get_ans">
	<cfquery name="ins_sm" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_quiz_answer
		(
		sub_id,
		qu_id,
		quiz_id,
		ans_iscorrect,
		ans_gain,
		ans_type,
		ans_text
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max.id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#ans_iscorrect#">,
		<cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#ans_gain#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_type#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_text#">
		)		
	</cfquery>
	</cfoutput>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#get_max.id#&k=2">

	
	
	

	
<cfelseif isdefined("act") AND act eq "updt_ans" AND isdefined("quiz_id") AND isdefined("qu_id") AND isdefined("ans_id")>

	<cfquery name="updt_sm" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz_answer
		SET
		ans_iscorrect = <cfqueryparam cfsqltype="cf_sql_integer" value="#ans_iscorrect#">,
		ans_gain = <cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#ans_gain#">,
		ans_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_type#">,
		ans_text = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_text#">
		WHERE ans_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ans_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">
	
<cfelseif isdefined("act") AND act eq "ins_ans" AND isdefined("quiz_id") AND isdefined("qu_id")>

	<cfquery name="ins_sm" datasource="#SESSION.BDDSOURCE#">
		INSERT INTO lms_quiz_answer
		(
		sub_id,
		qu_id,
		quiz_id,
		ans_iscorrect,
		ans_gain,
		ans_type,
		ans_text
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#ans_iscorrect#">,
		<cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#ans_gain#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_type#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" value="#ans_text#">
		)		
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">
	
<cfelseif isdefined("act") AND act eq "del_ans" AND isdefined("ans_id") AND isdefined("qu_id") AND isdefined("quiz_id")>

	<cfquery name="del_sm" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_answer
		WHERE ans_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ans_id#"> AND qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">
	
<cfelseif isdefined("act") AND act eq "del_qu" AND isdefined("qu_id") AND isdefined("quiz_id")>

	<cfquery name="del_qu" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_question
		WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cfquery name="del_quiz_cor" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_cor
		WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
	</cfquery>
	
	<cfquery name="del_ans" datasource="#SESSION.BDDSOURCE#">
		DELETE FROM lms_quiz_answer
		WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
	</cfquery>
	
	<cflocation addtoken="no" url="db_quiz_edit.cfm?quiz_id=#quiz_id#&qu_id=#qu_id#&k=1">

</cfif>

</cfif>
