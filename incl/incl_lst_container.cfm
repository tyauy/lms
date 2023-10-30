<cfquery name="get_total_lst" datasource="#SESSION.BDDSOURCE#">
SELECT lqa.ans_flag, COUNT(lqr.ans_id) as nb
FROM lms_quiz_answer lqa
INNER JOIN lms_quiz_result lqr ON lqa.ans_id = lqr.ans_id
WHERE lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
GROUP BY lqa.ans_flag
</cfquery>

<cfset TEMP_LB = 0>
<cfset TEMP_RB = 0>
<cfset TEMP_INT = 0>
<cfset TEMP_EXT = 0>
<cfset TEMP_VNV = 0>
<cfset TEMP_K = 0>
<cfset TEMP_VV = 0>
<cfset TEMP_AV = 0>
		
<cfoutput query="get_total_lst">
	<cfif ans_flag eq "LB"> 
		<cfset TEMP_LB = nb>
	<cfelseif ans_flag eq "RB">
		<cfset TEMP_RB = nb>
	<cfelseif ans_flag eq "INT">
		<cfset TEMP_INT = nb>
	<cfelseif ans_flag eq "EXT">
		<cfset TEMP_EXT = nb>
	<cfelseif ans_flag eq "VNV">
		<cfset TEMP_VNV = nb>
	<cfelseif ans_flag eq "K">
		<cfset TEMP_K = nb>
	<cfelseif ans_flag eq "VV">
		<cfset TEMP_VV = nb>
	<cfelseif ans_flag eq "AV">
		<cfset TEMP_AV = nb>
	</cfif>
</cfoutput>

<cfset total_brain = TEMP_LB+TEMP_RB>
<cfset total_social = TEMP_INT+TEMP_EXT>
<cfset total_sensory = TEMP_VNV+TEMP_K+TEMP_VV+TEMP_AV>

<!--- <cfoutput> --->
<!--- total_brain= #total_brain#<br> --->
<!--- total_social= #total_social#<br> --->
<!--- total_sensory = #total_sensory#<br> --->
<!--- </cfoutput> --->

<!--- <cfabort> --->

<cfset user_lst = "#round((TEMP_LB/total_brain)*100)#,#round((TEMP_RB/total_brain)*100)#,#round((TEMP_INT/total_social)*100)#,#round((TEMP_EXT/total_social)*100)#,#round((TEMP_VNV/total_sensory)*100)#,#round((TEMP_K/total_sensory)*100)#,#round((TEMP_VV/total_sensory)*100)#,#round((TEMP_AV/total_sensory)*100)#">

<div class="row mt-2">										
	<div class="col-md-3">									
	<cfset lst_display = "radar">
	<cfinclude template="./incl_lst.cfm">
	</div>
	<div class="col-md-9">
	<cfset lst_display = "radar_txt">
	<cfinclude template="./incl_lst.cfm">
	</div>
</div>
<h5 class="border-bottom border-gray pb-2 mb-4"><cfoutput>#obj_translater.get_translate('card_brain_dominance')#</cfoutput></h5>
<div class="row" style="margin-top:25px">
	<div class="col-md-2">									
	<cfset lst_display = "brain">
	<cfinclude template="./incl_lst.cfm">
	</div>
	<div class="col-md-10">
	<cfset lst_display = "brain_txt">
	<cfinclude template="./incl_lst.cfm">
	</div>
</div>
<h5 class="border-bottom border-gray pb-2 mb-4"><cfoutput>#obj_translater.get_translate('card_socialization')#</cfoutput></h5>
<div class="row" style="margin-top:25px">									
	<div class="col-md-2">									
	<cfset lst_display = "social">
	<cfinclude template="./incl_lst.cfm">
	</div>
	<div class="col-md-10">
	<cfset lst_display = "social_txt">
	<cfinclude template="./incl_lst.cfm">
	</div>
</div>
<h5 class="border-bottom border-gray pb-2 mb-4 mt-3"><cfoutput>#obj_translater.get_translate('card_sensory_perception')#</cfoutput></h5>
<div class="row" style="margin-top:25px">
	<div class="col-md-2">									
	<cfset lst_display = "sensory">
	<cfinclude template="./incl_lst.cfm">
	</div>
	<div class="col-md-10">
	<cfset lst_display = "sensory_txt">
	<cfinclude template="./incl_lst.cfm">
	</div>
</div>
	
