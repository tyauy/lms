<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM user WHERE account_id = 107
</cfquery>


<cfoutput query="get_user">

<cfquery name="create_tp" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tp
(
user_id,
tp_status_id,
order_id,
formation_id,
method_id,
tp_date_start,
tp_date_end,
tp_duration,
tp_vip,
techno_id
)
VALUES
(
#user_id#,
1,
1,
2,
1,
now(),
#dateadd('m',+2,now())#,
45,
0,
'1,2'
)
</cfquery>

</cfoutput>