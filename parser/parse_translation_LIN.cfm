<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/italian.tsv" variable="vartemp" charset="utf-8">
<!--- <cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/bus.tsv" variable="vartemp" charset="utf-8"> --->
<!--- <cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/gram.tsv" variable="vartemp" charset="utf-8"> --->

<!--- <cfdump var="#vartemp#"> --->
<cfset specialchar = "|">
<cfset delimiter = "#chr(09)#">

<cfset vartemp = replacenocase(vartemp,"#specialchar#","#delimiter#","ALL")>

<!--- <cfdump var="#vartemp#"> --->

<cfset counter = 0>
<!--- ID,TITLE EN,TITLE DE,TITLE FR,TITLE ES,DESCRIPTION EN,DESCRIPTION DE,DESCRIPTION FR,DESCRIPTION ES --->
<cfloop list="#vartemp#" index="encours" delimiters="#chr(10)##chr(13)#">
<cfoutput>
<cfset counter ++>

<cfset translation_id = #replacenocase(listgetat(encours,1,'#delimiter#', true),'"','','ALL')#><!---translation_id = #translation_id#<br>--->
<cfset translation_string_it = #replacenocase(listgetat(encours,3,'#delimiter#', true),'"','','ALL')#><!---translation_string_it = #translation_string_it#<br><br>--->

<cfif translation_string_it neq "">
-------------------------------------------------<br>
UPDATE lms_translation SET<br>
translation_string_it = #translation_string_it#<br>
WHERE translation_id = #translation_id#<br><br>
-------------------------------------------------
<br><br>
</cfif>
<cfquery name="up_translation" datasource="#SESSION.BDDSOURCE#">
    UPDATE lms_translation SET
    translation_string_it = <cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_string_it#">
    WHERE translation_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#translation_id#">
</cfquery>

</cfoutput>
</cfloop>

<!--- #encours#<br> --->
<!--- <cfset col1 = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>col1 = #col1#<br> --->
<!--- <cfset translation_id = #replacenocase(listgetat(encours,1,'#delimiter#', true),'"','','ALL')#>translation_id = #translation_id#<br>
<cfset translation_title_en = #replacenocase(listgetat(encours,2,'#delimiter#', true),'"','','ALL')#>translation_title_en = #translation_title_en#<br>
<cfset translation_title_de = #replacenocase(listgetat(encours,3,'#delimiter#', true),'"','','ALL')#>translation_title_de = #translation_title_de#<br>
<cfset translation_title_fr = #replacenocase(listgetat(encours,4,'#delimiter#', true),'"','','ALL')#>translation_title_fr = #translation_title_fr#<br>
<cfset translation_title_es = #replacenocase(listgetat(encours,5,'#delimiter#', true),'"','','ALL')#>translation_title_es = #translation_title_es#<br>
<cfset translation_desc_en = #replacenocase(listgetat(encours,6,'#delimiter#', true),'"','','ALL')#>translation_desc_en = #translation_desc_en#<br>
<cfset translation_desc_de = #replacenocase(listgetat(encours,7,'#delimiter#', true),'"','','ALL')#>translation_desc_de = #translation_desc_de#<br>
<cfset translation_desc_fr = #replacenocase(listgetat(encours,8,'#delimiter#', true),'"','','ALL')#>translation_desc_fr = #translation_desc_fr#<br>
<cfset translation_desc_es = #replacenocase(listgetat(encours,9,'#delimiter#', true),'"','','ALL')#>translation_desc_es = #translation_desc_es#<br>

<cfdump var="#translation_id#">
</br>

<cfif isDefined("translation_id") AND translation_id neq "" AND IsNumeric(translation_id)>

<cfquery name="up_translation" datasource="#SESSION.BDDSOURCE#">
    UPDATE `lms_tpsessionmaster2` SET
    <cfif isDefined("translation_title_fr") AND translation_title_fr neq "">`sessionmaster_name_fr`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_title_fr#">,</cfif>
    <cfif isDefined("translation_title_en") AND translation_title_en neq "">`sessionmaster_name_en`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_title_en#">,</cfif>
    <cfif isDefined("translation_title_de") AND translation_title_de neq "">`sessionmaster_name_de`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_title_de#">,</cfif>
    <cfif isDefined("translation_title_es") AND translation_title_es neq "">`sessionmaster_name_es`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_title_es#">,</cfif>
    <cfif isDefined("translation_desc_fr") AND translation_desc_fr neq "">`sessionmaster_description_fr`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_desc_fr#">,</cfif>
    <cfif isDefined("translation_desc_en") AND translation_desc_en neq "">`sessionmaster_description_en`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_desc_en#">,</cfif>
    <cfif isDefined("translation_desc_de") AND translation_desc_de neq "">`sessionmaster_description_de`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_desc_de#">,</cfif>
    <cfif isDefined("translation_desc_es") AND translation_desc_es neq "">`sessionmaster_description_es`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#translation_desc_es#">,</cfif>
    `sessionmaster_id`=<cfqueryparam cfsqltype="cf_sql_numeric" value="#translation_id#">
    WHERE `sessionmaster_id` = <cfqueryparam cfsqltype="cf_sql_numeric" value="#translation_id#">
</cfquery>
</cfif> --->




