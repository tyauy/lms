<cfabort>

<cfprocessingdirective pageencoding="utf-8">

<cffile action="read" file="/home/www/winegroup/www/manager/lms3/parser/vocabulary.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = "|">


<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">

<cfoutput>
<cfset voc_word_en = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>voc_word_en = #voc_word_en#<br>
<cfset voc_desc_en = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>voc_desc_en = #voc_desc_en#<br>
<cfset voc_category = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>voc_category = #voc_category#<br>
<cfif listlen(encours,"|") eq "4">
	<cfset voc_type = #replacenocase(listgetat(encours,4,'#specialchar#'),'"','','ALL')#>
<cfelse>
	<cfset voc_type = "">
</cfif>
voc_type = #voc_type#<br><br><br>

<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_vocabulary
(
voc_word_en,
voc_desc_en,
voc_category,
voc_type
)
VALUES
(
'#voc_word_en#',
'#voc_desc_en#',
'#voc_category#',
'#voc_type#'
)
</cfquery>


</cfoutput>

</cfloop>

