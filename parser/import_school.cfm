<cfabort>
<cffile action="read" file="/home/www/wnotedev1/www/manager/lms/parser/csv/school.csv" variable="vartemp" charset="utf-8">

<cfset specialchar = "|">

<!--- <cfset vartemp = replacenocase(vartemp,"#specialchar##specialchar#","#specialchar# #specialchar#","ALL")> --->

<cfset counter = 0>


<cfloop list="#vartemp#" index="encours" delimiters="#chr(13)##chr(10)#">
<cfset counter ++>



<cfoutput>
<cfset account_id = #replacenocase(listgetat(encours,1,'#specialchar#'),'"','','ALL')#>account_id = #account_id#<br>
<cfset group_id = #replacenocase(listgetat(encours,2,'#specialchar#'),'"','','ALL')#>group_id = #group_id#<br>
<cfset status_id = #replacenocase(listgetat(encours,3,'#specialchar#'),'"','','ALL')#>status_id = #status_id#<br>
<cfset account_name = #replacenocase(listgetat(encours,5,'#specialchar#'),'"','','ALL')#>account_name = #account_name#<br>


<cfset task_content = #replacenocase(listgetat(encours,7,'#specialchar#'),'"','','ALL')#>task_content = #task_content#<br>

<cfset contact_name = #replacenocase(listgetat(encours,8,'#specialchar#'),'"','','ALL')#>contact_name = #contact_name#<br>

<cfif contact_name neq "" AND findnocase(" ",contact_name)>
<cfset contact_name_solo = MID(contact_name,1,findnocase(" ",contact_name))>
contact_name_solo = #contact_name_solo#<br>
<cfset contact_prenom_solo = MID(contact_name,findnocase(" ",contact_name),50)>
contact_prenom_solo = #contact_prenom_solo#<br>
</cfif>

<cfset contact_tel = #replacenocase(listgetat(encours,9,'#specialchar#'),'"','','ALL')#>contact_tel = #contact_tel#<br>
<cfset contact_email = #replacenocase(listgetat(encours,10,'#specialchar#'),'"','','ALL')#>contact_email = #contact_email#<br>

<cfif account_id eq " ">
    
    <cfif group_id neq " ">
        <cfset group_id = group_id>
    <cfelse>
        <cfquery name="ins_group" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO account_group
        (
            group_name,
            country_id,
            provider_id
        )
        VALUES
        (
            '#account_name#',
            1,
            1
        )
        </cfquery>

        <cfquery name="get_max_group" datasource="#SESSION.BDDSOURCE#">
        SELECT MAX(group_id) as id FROM account_group
        </cfquery>

        <cfset group_id = get_max_group.id>

    </cfif>

    <cfquery name="ins_account" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO account
    (
        user_id,
        owner_id,
        type_id,
        status_id,
        group_id,
        account_name,
        provider_id
    )
    VALUES
    (
        1,
        1,
        9,
        #status_id#,
        #group_id#,
        '#account_name#',
        1
    )
    </cfquery>

    <cfquery name="get_max_account" datasource="#SESSION.BDDSOURCE#">
    SELECT MAX(account_id) as id FROM account
    </cfquery>

    <cfif contact_name neq "" AND findnocase(" ",contact_name)>
    <cfquery name="ins_ctc" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO account_contact
    (
        contact_firstname,
        contact_name,
        contact_tel1,
        contact_email
    )
    VALUES
    (
       '#contact_prenom_solo#',
       '#contact_name_solo#',
       '#contact_tel#',
       '#contact_email#'
    )
    </cfquery>
    <cfquery name="get_max_ctc" datasource="#SESSION.BDDSOURCE#">
    SELECT MAX(contact_id) as id FROM account_contact
    </cfquery>
    <cfquery name="ins_ctc" datasource="#SESSION.BDDSOURCE#">
        INSERT INTO account_contact_cor
        (
            a_id,
            ctc_id
        )
        VALUES
        (
            #get_max_account.id#,
            #get_max_ctc.id#
        )
    </cfquery>
    </cfif>


    <cfquery name="ins_log" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO logs
    (
    account_id,
    log_text,
    log_date,
    from_id,
    task_channel_id
    )
    VALUES
    (
    #get_max_account.id#,
    '#task_content#',
    '2022-01-01',
    1,
    6
    )
    </cfquery>

    <cfquery name="get_max_log" datasource="#SESSION.BDDSOURCE#">
    SELECT MAX(log_id) as id FROM logs
    </cfquery>

    <cfquery name="ins_log" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO logs_item
    (
    log_id,
    task_type_id
    )
    VALUES
    (
    #get_max_log.id#,
    58
    )
    </cfquery>
</cfif>
</cfoutput>
<br><br>


</cfloop>

<cfoutput>TOTAL : #counter#</cfoutput>