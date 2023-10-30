<cfabort>

<cfprocessingdirective pageencoding="windows-1252">

<head>
<style>
body{
font-family:Arial;
}
</style>
</head>

<cfoutput>
<table style="border:1px" cellpadding="3" cellspacing="3">
				<tr>
					<td style="background-color:##ECECEC">ID</td>
					<td style="background-color:##ECECEC">Cat</td>
					<td style="background-color:##ECECEC">Cat 2</td>
					<td style="background-color:##ECECEC">intitule</td>
					<td style="background-color:##ECECEC">Sample1</td>
					<td style="background-color:##ECECEC">Sample2</td>
					<td style="background-color:##ECECEC">Sample3</td>
					<td style="background-color:##ECECEC">Sample4</td>
					<td style="background-color:##ECECEC">Sample5</td>
					<td style="background-color:##ECECEC">Sample6</td>
					<td style="background-color:##ECECEC">Sample7</td>
					<td style="background-color:##ECECEC">Sample8</td>
				</tr>
		<cffile action="read" file="/home/www/winegroup/www/manager/lms3/parser/wemail.csv" variable="vartemp" charset="windows-1252">
		
		<cfset counter = 0>
		<cfset vartemp = replacenocase(vartemp,"||"," | | ","ALL")>
		
						
		<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">

		

				<cfset col_1 = #replacenocase(listgetat(encours,1,'|'),'"','','ALL')#>
				<cfset col_2 = #replacenocase(listgetat(encours,2,'|'),'"','','ALL')#>
				<cfset col_3 = #replacenocase(listgetat(encours,3,'|'),'"','','ALL')#>
				<cfset col_4 = #replacenocase(listgetat(encours,4,'|'),'"','','ALL')#>
				<cfset col_5 = #replacenocase(listgetat(encours,5,'|'),'"','','ALL')#>
				<cfset col_5 = #replacenocase(col_5,'<br><br><br>','<br>','ALL')#>
				<cfset col_5 = #replacenocase(col_5,'<br><br><br>','<br>','ALL')#>
				<cfset col_6 = #replacenocase(listgetat(encours,6,'|'),'"','','ALL')#>
				<cfset col_6 = #replacenocase(col_6,'<br><br><br>','<br>','ALL')#>
				<cfset col_6 = #replacenocase(col_6,'<br><br><br>','<br>','ALL')#>
				<cfset col_7 = #replacenocase(listgetat(encours,7,'|'),'"','','ALL')#>
				<cfset col_7 = #replacenocase(col_7,'<br><br><br>','<br>','ALL')#>
				<cfset col_7 = #replacenocase(col_7,'<br><br><br>','<br>','ALL')#>
				<cfset col_8 = #replacenocase(listgetat(encours,8,'|'),'"','','ALL')#>
				<cfset col_8 = #replacenocase(col_8,'<br><br><br>','<br>','ALL')#>
				<cfset col_8 = #replacenocase(col_8,'<br><br><br>','<br>','ALL')#>
				<cfset col_9 = #replacenocase(listgetat(encours,9,'|'),'"','','ALL')#>
				<cfset col_9 = #replacenocase(col_9,'<br><br><br>','<br>','ALL')#>
				<cfset col_9 = #replacenocase(col_9,'<br><br><br>','<br>','ALL')#>
				<cfset col_10 = #replacenocase(listgetat(encours,10,'|'),'"','','ALL')#>
				<cfset col_10 = #replacenocase(col_10,'<br><br><br>','<br>','ALL')#>
				<cfset col_10 = #replacenocase(col_10,'<br><br><br>','<br>','ALL')#>
				<cfset col_11 = #replacenocase(listgetat(encours,11,'|'),'"','','ALL')#>
				<cfset col_11 = #replacenocase(col_11,'<br><br><br>','<br>','ALL')#>
				<cfset col_11 = #replacenocase(col_11,'<br><br><br>','<br>','ALL')#>
				<cfset col_12 = #replacenocase(listgetat(encours,12,'|'),'"','','ALL')#>
				<cfset col_12 = #replacenocase(col_12,'<br><br><br>','<br>','ALL')#>
				<cfset col_12 = #replacenocase(col_12,'<br><br><br>','<br>','ALL')#>
				
				
				
				<tr>
					<td>#col_1#</td>
					<td>#col_2#</td>
					<td>#col_3#</td>		
					<td>#col_4#</td>
					<td>#col_5#</td>
					<td>#col_6#</td>
					<td>#col_7#</td>
					<td>#col_8#</td>
					<td>#col_9#</td>
					<td>#col_10#</td>
					<td>#col_11#</td>
					<td>#col_12#</td>
				</tr>
				
				<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
				INSERT INTO lms_wemail
(
wemail_subcategory,
wemail_category,
wemail_category_clean,
wemail_subject,
wemail_sample_1,
wemail_sample_2,
wemail_sample_3,
wemail_sample_4,
wemail_sample_5,
wemail_sample_6,
wemail_sample_7,
wemail_sample_8
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_4#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_5#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_6#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_7#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_8#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_9#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_10#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_11#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#col_12#">
)


				</cfquery>
				
				
				
		</cfloop>


</table>
</cfoutput>