<cfabort>
<cfset listgym = "29694,
29695,
29696,
29697,
29698,
29699,
29700,
29701,
29702,
29703,
29704,
29705,
29706,
29707,
29708,
29709,
29710,
29711,
29712,
29713,
29714,
29715,
29716,
29717,
29718,
29719,
29720,
29721,
29722,
29723,
29724,
29725,
29726,
29727,
29728,
29729,
29730,
29731,
29732,
29733,
29734,
29735,
29736,
29737,
29738,
29739,
29740">


<cfloop list="#listgym#" index="go">


<cfquery name="ins_tp" datasource="lms-1" result="insert_tp">
INSERT INTO lms_tp
(
user_id,
tp_status_id,
tp_date_start,
tp_date_end,

tp_duration,
formation_id,
method_id,
tp_type_id,

techno_id,            
tp_rank,
tp_vip,

creator_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#go#">,
1,
<cfqueryparam cfsqltype="cf_sql_date" value="2023-02-20">,
<cfqueryparam cfsqltype="cf_sql_date" value="2023-08-19">,

600,
2,
1,            
4,

3,
1,
0,

29350
)
</cfquery>


<cfquery name="create_cor" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpuser
(
    user_id,
    tp_id
)
VALUES
(
    <cfqueryparam cfsqltype="cf_sql_integer" value="#go#">,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">
)
</cfquery>


<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO orders_users
(
    order_id,
    user_id
) 
VALUES 
(
    13863,
    <cfqueryparam cfsqltype="cf_sql_integer" value="#go#">
)
</cfquery>


<!--- CREATE FIRST --->
<cfquery name="ins_session" datasource="lms-1">
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
<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
695,
30,
1,
0,
1,
1
);
</cfquery>

<cfloop from="2" to="19" index="cor">

<cfquery name="ins_session" datasource="lms-1">
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
<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
1267,
30,
<cfqueryparam cfsqltype="cf_sql_integer" value="#cor#">,
0,
1,
1
);
</cfquery>

</cfloop>

<!--- CREATE PTA --->
<cfquery name="ins_session" datasource="lms-1">
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
<cfqueryparam cfsqltype="cf_sql_integer" value="#insert_tp.generatedkey#">,
694,
30,
20,
0,
1,
1
);
</cfquery>



</cfloop>
















<!--- <cfabort><cfset listgym = "denis.michel@groupe-mma.fr,
gilles.lefrand@groupe-mma.fr,
mohamed.bessassi@groupe-mma.fr,
pierre-olivier.brevet@groupe-mma.fr,
franck.charles@groupe-mma.fr,
quentin.demangeau@groupe-mma.fr,
laurent.lacheny@groupe-mma.fr,
sebastien.nico@groupe-mma.fr,
laurent.roux@groupe-mma.fr,
ludovic.vigneron@groupe-mma.fr,
ilf@saverglass.com,
nam@saverglass.com,
atk@saverglass.com,
nzd@saverglass.com,
esc@saverglass.com,
vjf@saverglass.com,
krm@saverglass.com,
iad@saverglass.com,
rbl@saverglass.com,
acn@saverglass.com,
lgm@saverglass.com,
ccv@saverglass.com,
ilf@saverglass.com,
francine.baudot@crtc.ccomptes.fr,
emmanuelle.borel@crtc.ccomptes.fr,
edouard-nicolas.derinck@ccomptes.fr,
jean-yves.giot@ccomptes.fr,
thierry.ledroit@ccomptes.fr,
delphine.hlavaty@ccomptes.fr,
aymeric.dhondt@ccomptes.fr,
hind.labidi-farsi@ccomptes.fr,
sonia.penela@crtc.ccomptes.fr,
solange.quoy@crtc.ccomptes.fr,
geoffroy.chamouton@crtc.ccomptes.fr,
nathalie.burette@ccomptes.fr,
fazia.mezianeboutemeur@ccomptes.fr,
elodie.vongoc@banque-france.fr,
serge.arneton@banque-france.fr,
pauline.apeke@banque-france.fr,
valerie.chouard@banque-france.fr,
pauline.charpy@acpr.banque-france.fr,
natacha.ako@banque-france.fr,
claire.dereydetdevulpillieres@banque-france.fr,
magali.hureaux@banque-france.fr,
frulgence.noumagnon@banque-france.fr,
alison.linstrument@banque-france.fr,
esthel.nissan@banque-france.fr">

<cfloop list="#listgym#" index="go">

    <cfset temp = RandRange(100000, 999999)>

<cfquery name="ins_user" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user
(
account_id,
profile_id,
timezone_id,
user_firstname,
user_name,
user_email,
user_password,
user_create,
user_lang,
user_status_id,
user_type_id
)
VALUES
(
1000,
3,
6,
'',
'',
<cfqueryparam cfsqltype="cf_sql_varchar" value="#lcase(trim(go))#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(temp)#">,
<cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#">,
'fr',			
1,
7
)
</cfquery>

<cfquery name="get_max_user" datasource="#SESSION.BDDSOURCE#">
SELECT MAX(user_id) as id FROM user
</cfquery>

<cfquery name="create_profile" datasource="#SESSION.BDDSOURCE#">
INSERT INTO user_profile_cor
(
user_id,
profile_id
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#get_max_user.id#">,
3
)
</cfquery>

</cfloop> --->