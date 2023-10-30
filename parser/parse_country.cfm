<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/country.tsv" variable="vartemp" charset="utf-8">
<!--- <cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/bus.tsv" variable="vartemp" charset="utf-8"> --->

<cfset specialchar = ";">
<cfset delimiter = "#chr(09)#">

<cfset vartemp = replacenocase(vartemp,"#specialchar#","#delimiter#","ALL")>

<!--- <cfdump var="#vartemp#"> --->

<cfset counter = 0>
<!--- ID,TITLE EN,TITLE DE,TITLE FR,TITLE ES,DESCRIPTION EN,DESCRIPTION DE,DESCRIPTION FR,DESCRIPTION ES --->
<cfloop list="#vartemp#" index="encours" delimiters="#chr(10)##chr(13)#">
<cfoutput>
<cfset counter ++>
<!--- #encours#<br> --->
<!--- <cfset col1 = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>col1 = #col1#<br> --->
<cfset alpha = #replacenocase(listgetat(encours,10,'#delimiter#', true),'"','','ALL')#>alpha = #alpha#<br>
<cfset phone = #replacenocase(listgetat(encours,2,'#delimiter#', true),'"','','ALL')#>phone = #phone#<br>
<cfset name = #replacenocase(listgetat(encours,17,'#delimiter#', true),'"','','ALL')#>name = #name#<br>




<cfif isDefined("alpha") AND alpha neq "">
    <cfdump var="#alpha#">
</br>
<cfif isDefined("phone") AND phone neq "">
<cfquery name="up_translation" datasource="#SESSION.BDDSOURCE#">
    UPDATE `settings_country` SET
    `phone_code`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#phone#">
    WHERE `country_alpha` = <cfqueryparam cfsqltype="cf_sql_varchar" value="#alpha#">
</cfquery>
</cfif>
</cfif>

<!--- <cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
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
</cfquery> --->


</cfoutput>
</cfloop>
