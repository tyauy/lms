
<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/shop_translate.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = ",">

<cfset vartemp = replacenocase(vartemp,"#specialchar##specialchar#","#specialchar# #specialchar#","ALL")>

<!--- <cfdump var="#vartemp#"> --->

<cfset counter = 0>

<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfoutput>
<cfset counter ++>
<!--- #encours#<br> --->
<cfset translation_code = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>translation_code = #translation_code#<br>
<!--- <cfset col1 = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>col1 = #col1#<br> --->
<cfset translation_type = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>translation_type = #translation_type#<br>
<cfset translation_cat = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>translation_cat = #translation_cat#<br>
<!--- <cfset translation_string_fr = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>translation_string_fr = #translation_string_fr#<br> --->
<!--- <cfset translation_string_en = #replacenocase(listgetat(encours,5,'#specialchar#'),'"','','ALL')#>translation_string_en = #translation_string_en#<br> --->
<!--- <cfset translation_string_de = #replacenocase(listgetat(encours,6,'#specialchar#'),'"','','ALL')#>translation_string_de = #translation_string_de#<br> --->
<!--- <cfset translation_string_es = #replacenocase(listgetat(encours,7,'#specialchar#'),'"','','ALL')#>translation_string_es = #translation_string_es#<br> --->


<cfquery name="ins_translate" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_translation
(
translation_code,
translation_type,
<!--- translation_string_fr, --->
<!--- translation_string_en, --->
<!--- translation_string_de, --->
translation_cat
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_code#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_type#">,
<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_fr#">, --->
<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_en#">, --->
<!--- <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_de#">, --->
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_cat#">
)
</cfquery>
<br><br><br>

</cfoutput>
</cfloop>
