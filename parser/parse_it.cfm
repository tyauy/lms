<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/trad_it.tsv" variable="vartemp" charset="utf-8">

<cfset specialchar = "|">

<!--- <cfset vartemp = replacenocase(vartemp,"#specialchar##specialchar#","#specialchar# #specialchar#","ALL")> --->

<cfset counter = 0>


<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfset counter ++>


<cfoutput>
<cfset sessionmaster_id = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>sessionmaster_id = #sessionmaster_id#<br>
<cfset sessionmaster_name_it = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>sessionmaster_name_it = #sessionmaster_name_it#<br>
<cfset sessionmaster_description_it = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>sessionmaster_description_it = #sessionmaster_description_it#<br>


<cfquery name="updt_resource" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_tpsessionmaster2 SET 
sessionmaster_name_it = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_name_it#">,
sessionmaster_description_it = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sessionmaster_description_it#">
WHERE sessionmaster_id = #sessionmaster_id#
</cfquery>

</cfoutput>
<br><br>
</cfloop>

<cfoutput>TOTAL : #counter#</cfoutput>