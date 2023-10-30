
<cfprocessingdirective pageencoding="utf-8">

<head>
<style>
body{
font-family:Arial;
}
</style>
</head>
<cfdirectory action="list" directory="/home/www/wnotedev1/www/manager/lms/parser/quiz_ted/" recurse="false" name="myList" sort="name ASC">

<cfoutput>
<cfloop query="myList"> 
<table style="border:1px" cellpadding="3" cellspacing="3">
	<tr>
		<td><h4>#myList.name#</h5></td>
	</tr>
	<cfset temp = mid(myList.name,1,find(".",myList.name)-1)>
	
	<cfset s_id = listgetat(temp,1,"_")>

	<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
	SELECT sessionmaster_name FROM lms_tpsessionmaster2 WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#s_id#">
	</cfquery>

	<cfset q_name = get_sm.sessionmaster_name>

	<cfquery name="get_check" datasource="#SESSION.BDDSOURCE#">
	SELECT quiz_id FROM lms_quiz WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#s_id#">
	</cfquery>

	<cfif get_check.recordcount eq "0">

		<cfif isdefined("oktreat")>
		
			<cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#">
			INSERT INTO lms_quiz
			(
			sessionmaster_id,
			quiz_name,
			quiz_nbqu,
			quiz_score,
			quiz_type,
			quiz_active
			)
			VALUES
			(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#q_name#">,
			10,
			10,
			'unit',
			1
			)
			</cfquery>
			
			<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
			SELECT max(quiz_id) as id FROM lms_quiz
			</cfquery>
			
			<cfset quiz_id = get_max.id>
		
		</cfif>
		
		<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/quiz_ted/#myList.name#" variable="vartemp" charset="utf-8">
		
		<cfset liner="0">
		
		<cfset vartemp = replacenocase(vartemp,"||"," | |","ALL")>
		
		<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
		<cfif listlen(encours,"|") eq "4">
		
			<cfset liner ++>
			
			<cfif liner neq "1">
			
			<cfset qu_id = #replacenocase(listgetat(encours,1,'|'),'"','','ALL')#>
				
			<cfif qu_id neq " ">
				
				<!--- <cfset qu_category = #replacenocase(listgetat(encours,2,'|'),'"','','ALL')#> --->
				<cfset qu_title = #replacenocase(listgetat(encours,1,'|'),'"','','ALL')#>
				<cfset qu_text = #replacenocase(listgetat(encours,2,'|'),'"','','ALL')#>
				<!--- <cfset qu_timer = #replacenocase(listgetat(encours,5,'|'),'"','','ALL')#> --->
				
				<cfset qu_ans = #replacenocase(listgetat(encours,3,'|'),'"','','ALL')#>
				<cfset qu_good = #replacenocase(listgetat(encours,4,'|'),'"','','ALL')#>
				<!--- <cfset qu_anstype = #replacenocase(listgetat(encours,8,'|'),'"','','ALL')#> --->
								
				<tr>
					<td style="background-color:##ECECEC">qu_id</td>
					<!--- <td style="background-color:##ECECEC">qu_category</td> --->
					<!--- <td style="background-color:##ECECEC">qu_title</td> --->
					<td style="background-color:##ECECEC">qu_text</td>
					<!--- <td style="background-color:##ECECEC">qu_timer</td> --->
					<td style="background-color:##ECECEC">qu_answer</td>
					<td style="background-color:##ECECEC">qu_good</td>
					<!--- <td style="background-color:##ECECEC">qu_anstype</td> --->
				</tr>
				
				<tr>
					<td>#qu_id#</td>
					<!--- <td>#qu_category#</td> --->
					<!--- <td>#qu_title#</td>		 --->
					<td>#qu_text#</td>
					<!--- <td>#qu_timer#</td> --->
					<td>#qu_ans#</td>		
					<td>#qu_good#</td>
					<!--- <td>#qu_anstype#</td> --->
				</tr>
								
		
				<cfif isdefined("oktreat")>
				<cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_quiz_question
				(
				qu_text,
				qu_title,
				qu_type,
				qu_timer,
				qu_category
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_text#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="Choose the best option. Only one is correct.">,
				"radio",
				30,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="Comprehension">
				)
				</cfquery>

				<cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
				SELECT MAX(qu_id) as id FROM lms_quiz_question
				</cfquery>

				<cfset idcor = get_max.id>

				<cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_quiz_cor
				(
				qu_id,
				quiz_id,
				qu_ranking
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
				)
				</cfquery>

				<cfquery name="ins_ans" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_quiz_answer
				(
				qu_id,
				sub_id,
				quiz_id,
				ans_text,
				ans_iscorrect,
				ans_type,
				ans_gain
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">,
				1,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_ans#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_good#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="radio">,
				<cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#qu_good#">
				)
				</cfquery>
				
				</cfif>

			<cfelse>
			
				<cfset qu_ans = #replacenocase(listgetat(encours,3,'|'),'"','','ALL')#>
				<cfset qu_good = #replacenocase(listgetat(encours,4,'|'),'"','','ALL')#>
				<!--- <cfset qu_anstype = #replacenocase(listgetat(encours,8,'|'),'"','','ALL')#> --->

				<tr>
					<!--- <td></td>
					<td></td>
					<td></td>		 --->
					<td></td>
					<td></td>
					<td>#qu_ans#</td>		
					<td>#qu_good#</td>
					<!--- <td>#qu_anstype#</td> --->
				</tr>
				
				
				<cfif isdefined("oktreat")>
				<cfquery name="ins_ans" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_quiz_answer
				(
				qu_id,
				sub_id,
				quiz_id,
				ans_text,
				ans_iscorrect,
				ans_type,
				ans_gain
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">,
				1,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#qu_ans#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#qu_good#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="radio">,
				<cfqueryparam cfsqltype="cf_sql_decimal" scale="2" value="#qu_good#">
				)
				</cfquery>
				</cfif>
				

			</cfif>

			</cfif>

		</cfif>
		</cfloop>
		
		<cfif isdefined("oktreat")>
		<cfquery name="get_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score_quiz FROM lms_quiz_answer WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_id#">
		</cfquery>
		
		<cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_quiz SET quiz_score =  #get_score.score_quiz# WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#quiz_id#">
		</cfquery>
		
		</cfif>
		
	</cfif>

<cfif isdefined("oktreat")>
<!--- <cffile action="move" source="/home/www/wnotedev1/www/manager/lms/parser/quiz_ted/#myList.name#" destination="/home/www/wnotedev1/www/manager/lms/parser/quiz_done_ted/" charset="windows-1252"> --->
</cfif>

</cfloop>



</cfoutput>

</table>

<div align="center"><a href="import_quiz_ted.cfm?oktreat=1">Int&eacute;grer QUIZ</a></div>





