<cfabort>

<cfset listgo ="12848,
12849,
12850,
12851,
12852,
12853,
12854,
12855,
12856,
12857,
12858,
12859,
12860,
12861,
12862,
12863,
12864,
12865,
12866,
12867,
12868,
12869,
12870,
12871,
12872,
12873,
12874,
12875,
12876,
12877,
12878,
12879,
12880,
12881,
12882,
12883,
12884,
12885,
12886,
12887,
12888,
12889,
12890,
12891,
12892,
12893,
12894,
12895,
12896,
12897,
12898,
12899,
12900,
12901,
12902,
12903,
12904,
12905,
12906,
12907,
12908,
12909,
12910,
12911,
12912,
12913,
12914,
12915,
12916,
12917,
12918,
12919,
12920,
12921,
12922,
12923,
12924,
12925
">

<cfloop list=#listgo# index="cor">
    <cfoutput>

<!--- <cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
SELECT order_id FROM lms_tp WHERE user_id = #cor#  
</cfquery>


<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
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
certif_id,
elearning_id,
token_id,
elearning_duration
)
VALUES
(
#cor#,
1,
#get_order.order_id#,
2,
7,
'2021-11-01',
'2022-01-31',
1,
21,
null,
null,
null
)


</cfquery>
<br><br> --->

<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
    SELECT tp_id FROM lms_tp WHERE user_id = #cor# AND method_id = 1  
    </cfquery>

<!--- CREATE NA --->
<cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_tpsession
    (
    tp_id,
    sessionmaster_id,
    session_duration,
    session_rank,
    session_close,
    method_id,
    cat_id
    )
    VALUES
    (
    #get_tp.tp_id#,
    695,
    30,
    1,
    0,
    1,
    4
    );
    </cfquery>
    <br>
    <!--- CREATE PTA --->
    <cfquery name="ins_session" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_tpsession
    (
    tp_id,
    sessionmaster_id,
    session_duration,
    session_rank,
    session_close,
    method_id,
    cat_id
    )
    VALUES
    (
    #get_tp.tp_id#,
    694,
    30,
    2,
    0,
    1,
    4
    );
    </cfquery>

    <br><br><br><br>

</cfoutput>
</cfloop>