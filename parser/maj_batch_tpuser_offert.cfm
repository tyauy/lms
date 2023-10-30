<!--- 1	A LANCER
2	EN COURS
3	TERMINÉ
4	ANNULÉ
5	ANOMALIE
6	LANCER À DATE
7	TRANSFÉRÉ
9	ATTENTE TRANSFERT
10	HÉRITÉ
11	ARRÊTÉ 

(3,7,9)

--->

<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_tp t
    INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id
    INNER JOIN user u ON u.user_id = tpu.user_id
    INNER JOIN user_profile_cor upc ON tpu.user_id = upc.user_id AND upc.profile_id IN (3)
    WHERE u.user_status_id = 4
    ORDER BY tpu.user_id
</cfquery>

<cfoutput query="get_tp" group="user_id">
    <cfset scan_active = 0>
<a href="../common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a><br>
<cfoutput>
<cfif tp_status_id eq "1" OR tp_status_id eq "2" OR tp_status_id eq "6" OR tp_status_id eq "7" OR tp_status_id eq "10">
    <cfset scan_active = 1>
    >> #tp_id#<br>

</cfif>
</cfoutput>
<cfif scan_active eq "1">
    AU MOINS 1 TP ACTIVE
<cfelse>
    pas de TP actif > 1 passage en INACTIF

    <cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
        UPDATE user SET user_status_id = 5
        WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id#">
    </cfquery>

</cfif>
<br><br>
</cfoutput>