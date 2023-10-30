<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/complex.tsv" variable="vartemp" charset="utf-8">

<cfset specialchar = ";">
<cfset delimiter = "|">

<cfset vartemp = replacenocase(vartemp,"#specialchar#","#delimiter#","ALL")>

<!--- <cfdump var="#vartemp#"> --->

<cfset counter = 0>

<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfoutput>
<cfset counter ++>
#encours#<br>
<!--- <cfset col1 = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>col1 = #col1#<br> --->
<cfset translation_long_type = #replacenocase(listgetat(encours,1,'#delimiter#'),'"','','ALL')#>translation_long_type = #translation_long_type#<br>
<cfset translation_long_code = #replacenocase(listgetat(encours,2,'#delimiter#'),'"','','ALL')#>translation_long_code = #translation_long_code#<br>
<cfset translation_long_string_fr = #replacenocase(listgetat(encours,3,'#delimiter#'),'"','','ALL')#>translation_long_string_fr = #translation_long_string_fr#<br>
<cfset translation_long_string_en = #replacenocase(listgetat(encours,4,'#delimiter#'),'"','','ALL')#>translation_long_string_en = #translation_long_string_en#<br>
<cfset translation_long_string_de = #replacenocase(listgetat(encours,5,'#delimiter#'),'"','','ALL')#>translation_long_string_de = #translation_long_string_de#<br>
<cfset translation_long_string_es = #replacenocase(listgetat(encours,6,'#delimiter#'),'"','','ALL')#>translation_long_string_es = #translation_long_string_es#<br>


<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_translation_long
(
translation_long_code,
translation_long_type,
translation_long_string_fr,
translation_long_string_en,
translation_long_string_de,
translation_long_string_es
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_code#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_type#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_string_fr#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_string_en#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_string_de#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_long_string_es#">
)
</cfquery>


</cfoutput>
</cfloop>
