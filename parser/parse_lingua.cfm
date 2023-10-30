<cfprocessingdirective pageencoding="windows-1252">

<cffile action="read" file="/home/www/winegroup/www/manager/lms3/parser/bddlingua.csv" variable="vartemp" charset="windows-1252">

<cfset specialchar = "||">

<cfset vartemp = replacenocase(vartemp,"#specialchar##specialchar#","#specialchar# #specialchar#","ALL")>

<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">

<cfoutput>
<cfset sessionmaster_id = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>sessionmaster_id = #sessionmaster_id#<br>
<cfset sessionmaster_step = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>sessionmaster_step = #sessionmaster_step#<br>
<cfset sessionmaster_type = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>sessionmaster_type = #sessionmaster_type#<br>
<cfset sessionmaster_subtype = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>sessionmaster_subtype = #sessionmaster_subtype#<br>
<cfset sessionmaster_duration = #replacenocase(listgetat(encours,5,'#specialchar#'),'"','','ALL')#>sessionmaster_duration = #sessionmaster_duration#<br>
<cfset sessionmaster_name = #replacenocase(listgetat(encours,6,'#specialchar#'),'"','','ALL')#>sessionmaster_name = #sessionmaster_name#<br>
<cfset sessionmaster_code = #replacenocase(listgetat(encours,7,'#specialchar#'),'"','','ALL')#>sessionmaster_code = #sessionmaster_code#<br>
<cfset sessionmaster_7 = #replacenocase(listgetat(encours,8,'#specialchar#'),'"','','ALL')#>sessionmaster_7 = #sessionmaster_7#<br>
<cfset sessionmaster_8 = #replacenocase(listgetat(encours,9,'#specialchar#'),'"','','ALL')#>sessionmaster_8 = #sessionmaster_8#<br>
<cfset sessionmaster_url = #replacenocase(listgetat(encours,10,'#specialchar#'),'"','','ALL')#>sessionmaster_url = #sessionmaster_url#<br>
<cfset sessionmaster_ressource = #replacenocase(listgetat(encours,11,'#specialchar#'),'"','','ALL')#>sessionmaster_ressource = #sessionmaster_ressource#<br>
<cfset sessionmaster_level = #replacenocase(listgetat(encours,12,'#specialchar#'),'"','','ALL')#>sessionmaster_level = #sessionmaster_level#<br>
<cfset sessionmaster_description = #replacenocase(listgetat(encours,13,'#specialchar#'),'"','','ALL')#>sessionmaster_description = #sessionmaster_description#<br>

<!---
<cfset sessionmaster_british = #replacenocase(listgetat(encours,13,'#specialchar#'),'"','','ALL')#>sessionmaster_british = #sessionmaster_british#<br>
<cfset sessionmaster_american = #replacenocase(listgetat(encours,14,'#specialchar#'),'"','','ALL')#>sessionmaster_american = #sessionmaster_american#<br>
<cfset sessionmaster_video = #replacenocase(listgetat(encours,15,'#specialchar#'),'"','','ALL')#>sessionmaster_video = #sessionmaster_video#<br>
<cfset sessionmaster_audio = #replacenocase(listgetat(encours,16,'#specialchar#'),'"','','ALL')#>sessionmaster_audio = #sessionmaster_audio#<br>--->

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpsessionmaster2
(
sessionmaster_id,
sessionmaster_type,
sessionmaster_subtype,
sessionmaster_duration,
sessionmaster_name,
sessionmaster_code,
sessionmaster_level,
sessionmaster_url,
sessionmaster_ressource,
sessionmaster_description
)
VALUES
(
'#sessionmaster_id#',
'#sessionmaster_type#',
'#sessionmaster_subtype#',
'#sessionmaster_duration#',
'#sessionmaster_name#',
'#sessionmaster_code#',
'#sessionmaster_level#',
'#sessionmaster_url#',
'#sessionmaster_ressource#',
'#sessionmaster_description#'
)
</cfquery>



</cfoutput>

</cfloop>

