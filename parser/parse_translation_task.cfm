
<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/task.tsv" variable="vartemp" charset="utf-8">

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
<cfset translation_id = #replacenocase(listgetat(encours,1,'#delimiter#', true),'"','','ALL')#>translation_id = #translation_id#<br>
<cfset status = #replacenocase(listgetat(encours,4,'#delimiter#', true),'"','','ALL')#>status = #status#<br>
<cfset type = #replacenocase(listgetat(encours,5,'#delimiter#', true),'"','','ALL')#>type = #type#<br>
<cfset code = #replacenocase(listgetat(encours,6,'#delimiter#', true),'"','','ALL')#>code = #code#<br>
<cfset alias = #replacenocase(listgetat(encours,7,'#delimiter#', true),'"','','ALL')#>alias = #alias#<br>
<cfset sub = #replacenocase(listgetat(encours,8,'#delimiter#', true),'"','','ALL')#>sub = #sub#<br>
<cfset profil = #replacenocase(listgetat(encours,10,'#delimiter#', true),'"','','ALL')#>profil = #profil#<br>
<cfset title = #replacenocase(listgetat(encours,16,'#delimiter#', true),'"','','ALL')#>title = #title#<br>
<cfset fr = #replacenocase(listgetat(encours,17,'#delimiter#', true),'"','','ALL')#>fr = #fr#<br>
<cfset en = #replacenocase(listgetat(encours,18,'#delimiter#', true),'"','','ALL')#>en = #en#<br>
<cfset de = #replacenocase(listgetat(encours,19,'#delimiter#', true),'"','','ALL')#>de = #de#<br>
<cfset es = #replacenocase(listgetat(encours,20,'#delimiter#', true),'"','','ALL')#>es = #es#<br>
<cfset auto = #replacenocase(listgetat(encours,21,'#delimiter#', true),'"','','ALL')#>auto = #auto#<br>

<cfdump var="#translation_id#">
</br>

<cfif isDefined("translation_id") AND translation_id neq "" AND IsNumeric(translation_id)>

    <cfif status eq "DONE">

        <cfquery name="up_translation" datasource="#SESSION.BDDSOURCE#">
            UPDATE `task_type` SET
            <cfif isDefined("fr") AND fr neq "">`task_explanation_fr`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#fr#">,</cfif>
            <cfif isDefined("en") AND en neq "">`task_explanation_en`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#en#">,</cfif>
            <cfif isDefined("de") AND de neq "">`task_explanation_de`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#de#">,</cfif>
            <cfif isDefined("es") AND es neq "">`task_explanation_es`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#es#">,</cfif>
            `task_type_name`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#title#">,
            `task_group`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#">,
            `task_group_alias`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#alias#">,
            `task_group_sub`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#sub#">,
            `task_automation`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#auto#">,
            `task_category`=<cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
            WHERE `task_type_id` = <cfqueryparam cfsqltype="cf_sql_numeric" value="#translation_id#">
        </cfquery> 

    </cfif>

<cfelse>

    <cfif status eq "TO ADD">

    <cfquery name="ins_translation" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO task_type
        (
        task_type_name,
        <cfif isDefined("fr") AND fr neq "">task_explanation_fr,</cfif>
        <cfif isDefined("en") AND en neq "">task_explanation_en,</cfif>
        <cfif isDefined("de") AND de neq "">task_explanation_de,</cfif>
        <cfif isDefined("es") AND es neq "">task_explanation_es,</cfif>
        task_group,
        task_group_alias,
        task_group_sub,
        task_automation,
        task_category
        )
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#title#">,
        <cfif isDefined("fr") AND fr neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#fr#">,</cfif>
        <cfif isDefined("en") AND en neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#en#">,</cfif>
        <cfif isDefined("de") AND de neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#de#">,</cfif>
        <cfif isDefined("es") AND es neq ""><cfqueryparam cfsqltype="cf_sql_varchar" value="#es#">,</cfif>
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#code#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#alias#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#sub#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#auto#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#type#">
        )
    </cfquery>

    </cfif>
</cfif>

</cfoutput>
</cfloop>
