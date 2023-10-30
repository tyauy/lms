<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
	
	<!---
1183	Discussion Lesson
697		Workshop
1112	Certification
1182	Review Lesson
1063	eLearning
769		Test Lesson
694		Post Training Assessment
695		First Lesson
1181	Web Lesson
1197	Training lesson for Trainer
1198	Ops Meeting
1199	Resource Creation
1200	Translation
1201	Bonus Standard
1202	Bonus Variable
1267 	Gymglish
--->

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",schedule_only="1")>
<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#")>
<cfset get_learner = obj_query.oget_learner_solo(u_id="#u_id#")>
	
<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
SELECT tc.*, sm.*, tp.*, tm.module_name 
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
WHERE sm.sessionmaster_online_visio = 1
AND tp.tpmaster_prebuilt = 0
AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#">
ORDER BY tpmaster_rank ASC, sm.module_id
</cfquery>

<cfquery name="get_wefit_session" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 sm
WHERE 
sm.sessionmaster_id = 697
OR sm.sessionmaster_id = 1182
OR sm.sessionmaster_id = 1183
OR sm.sessionmaster_id = 1181
<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
OR sm.sessionmaster_id = 769
OR sm.sessionmaster_id = 694
OR sm.sessionmaster_id = 695
OR sessionmaster_id = 1267
</cfif>

</cfquery>



<form action="updater_tp2.cfm" method="post">

<select class="form-control" name="sm_id">
<optgroup label="WEFIT lessons">
<cfoutput query="get_wefit_session">
<option value="#sessionmaster_id#" <cfif sessionmaster_id eq sm_id>selected</cfif>>#sessionmaster_name#</option>
</cfoutput>
</optgroup>

<cfoutput query="get_session_access" group="tpmaster_biglevel">
<optgroup label="---------------------------------#obj_translater.get_translate('level')# #tpmaster_biglevel#------------------------------------">
<cfoutput group="tpmaster_id">
<optgroup label="[ #tpmaster_level# ] #tpmaster_name# ">

<cfoutput group="module_id">
	<optgroup label="#ucase(module_name)#">
	<cfoutput>
	<option value="#sessionmaster_id#" <cfif sessionmaster_id eq sm_id>selected</cfif>> #sessionmaster_name#</option>
	</cfoutput>
</optgroup>

</cfoutput>

</cfoutput>		
</optgroup>
</cfoutput>

</select>

<br>
<!--- s_dur --- <cfoutput>#s_dur#</cfoutput> --->
<cfif isdefined("s_dur")>
<select class="form-control" name="session_duration">
	<option value="15" <cfif s_dur eq "15">selected</cfif>>15 min</option>
	<option value="30" <cfif s_dur eq "30">selected</cfif>>30 min</option>
	<option value="45" <cfif s_dur eq "45">selected</cfif>>45 min</option>
	<option value="60" <cfif s_dur eq "60">selected</cfif>>60 min</option>
	<option value="75" <cfif s_dur eq "75">selected</cfif>>75 min</option>
	<option value="90" <cfif s_dur eq "90">selected</cfif>>90 min</option>
</select>
</cfif>

<cfoutput>
<input type="hidden" name="u_id" value="#u_id#">
<input type="hidden" name="t_id" value="#t_id#">	
<input type="hidden" name="s_id" value="#s_id#">	
<input type="hidden" name="updt_switch" value="1">	
</cfoutput>

<div align="center">
<input type="submit" value="Go" class="btn btn-outline-success">
</div>

</form>


</cfif>