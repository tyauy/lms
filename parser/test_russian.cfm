<cfprocessingdirective pageencoding="utf-8">
<cfcontent type="text/html; charset=utf-8">
<cfheader name="charset" value="utf-8">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<style>
body{
font-family:Arial;
}
</style>
</head>


<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/quiz_togo/PT_russian_A1.csv" variable="vartemp" charset="utf-8">
<cfoutput>
<table>

		<cfset liner="0">
		
		<cfset vartemp = replacenocase(vartemp,"||"," | | ","ALL")>
		
		<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
		<cfif listlen(encours,"|") eq "8">
		
			<cfset liner ++>
			
			<cfif liner neq "1">
			
			<cfset qu_id = #replacenocase(listgetat(encours,1,'|'),'"','','ALL')#>
				
			<cfif qu_id neq " ">
				
				<cfset qu_category = #replacenocase(listgetat(encours,2,'|'),'"','','ALL')#>
				<cfset qu_title = #replacenocase(listgetat(encours,3,'|'),'"','','ALL')#>
				<cfset qu_text = #replacenocase(listgetat(encours,4,'|'),'"','','ALL')#>
				<cfset qu_timer = #replacenocase(listgetat(encours,5,'|'),'"','','ALL')#>
				
				<cfset qu_ans = #replacenocase(listgetat(encours,6,'|'),'"','','ALL')#>
				<cfset qu_good = #replacenocase(listgetat(encours,7,'|'),'"','','ALL')#>
				<cfset qu_point = #replacenocase(listgetat(encours,8,'|'),'"','','ALL')#>
								
				<tr>
					<td style="background-color:##ECECEC">qu_id</td>
					<td style="background-color:##ECECEC">qu_category</td>
					<td style="background-color:##ECECEC">qu_title</td>
					<td style="background-color:##ECECEC">qu_text</td>
					<td style="background-color:##ECECEC">qu_timer</td>
					<td style="background-color:##ECECEC">qu_answer</td>
					<td style="background-color:##ECECEC">qu_good</td>
					<td style="background-color:##ECECEC">qu_point</td>
				</tr>
				
				<tr>
					<td>#qu_id#</td>
					<td>#qu_category#</td>
					<td>#qu_title#</td>		
					<td>#qu_text#</td>
					<td>#qu_timer#</td>
					<td>#qu_ans#</td>		
					<td>#qu_good#</td>
					<td>#qu_point#</td>
				</tr>
								
		
				<!--- <cfif isdefined("oktreat")> --->
				<!--- <cfquery name="ins_qu" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- INSERT INTO lms_quiz_question --->
				<!--- ( --->
				<!--- qu_text, --->
				<!--- qu_title, --->
				<!--- qu_type, --->
				<!--- qu_timer, --->
				<!--- qu_category, --->
				<!--- qu_category_temp --->
				<!--- ) --->
				<!--- VALUES --->
				<!--- ( --->
				<!--- '#qu_text#', --->
				<!--- '#qu_title#', --->
				<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="radio">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_timer#">, --->
				<!--- '#qu_category#', --->
				<!--- '#qu_category#' --->
				<!--- ) --->
				<!--- </cfquery> --->

				<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- SELECT MAX(qu_id) as id FROM lms_quiz_question --->
				<!--- </cfquery> --->

				<!--- <cfset idcor = get_max.id> --->

				<!--- <cfquery name="ins_cor" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- INSERT INTO lms_quiz_cor --->
				<!--- ( --->
				<!--- qu_id, --->
				<!--- quiz_id, --->
				<!--- qu_ranking --->
				<!--- ) --->
				<!--- VALUES --->
				<!--- ( --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> --->
				<!--- ) --->
				<!--- </cfquery> --->

				<!--- <cfquery name="ins_ans" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- INSERT INTO lms_quiz_answer --->
				<!--- ( --->
				<!--- qu_id, --->
				<!--- sub_id, --->
				<!--- quiz_id, --->
				<!--- ans_text, --->
				<!--- ans_iscorrect, --->
				<!--- ans_type, --->
				<!--- ans_gain --->
				<!--- ) --->
				<!--- VALUES --->
				<!--- ( --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">, --->
				<!--- 1, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">, --->
				<!--- '#qu_ans#', --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_good#">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="radio">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_point#"> --->
				<!--- ) --->
				<!--- </cfquery> --->
				
				<!--- </cfif> --->

			<cfelse>
			
				<cfset qu_ans = #replacenocase(listgetat(encours,6,'|'),'"','','ALL')#>
				<cfset qu_good = #replacenocase(listgetat(encours,7,'|'),'"','','ALL')#>
				<cfset qu_point = #replacenocase(listgetat(encours,8,'|'),'"','','ALL')#>

				<tr>
					<td></td>
					<td></td>
					<td></td>		
					<td></td>
					<td></td>
					<td>#qu_ans#</td>		
					<td>#qu_good#</td>
					<td>#qu_point#</td>
				</tr>
				
				
				<!--- <cfif isdefined("oktreat")> --->
				<!--- <cfquery name="ins_ans" datasource="#SESSION.BDDSOURCE#"> --->
				<!--- INSERT INTO lms_quiz_answer --->
				<!--- ( --->
				<!--- qu_id, --->
				<!--- sub_id, --->
				<!--- quiz_id, --->
				<!--- ans_text, --->
				<!--- ans_iscorrect, --->
				<!--- ans_type, --->
				<!--- ans_gain --->
				<!--- ) --->
				<!--- VALUES --->
				<!--- ( --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#idcor#">, --->
				<!--- 1, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">, --->
				<!--- '#qu_ans#', --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_good#">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="radio">, --->
				<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_point#"> --->
				<!--- ) --->
				<!--- </cfquery> --->
				<!--- </cfif> --->
				

			</cfif>

			</cfif>

		</cfif>
		</cfloop>


</table>
</cfoutput>





