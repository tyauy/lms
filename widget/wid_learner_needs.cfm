<cfif listlen(user_needs_learn) neq "0">
<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#SESSION.LANG_CODE# as skill_objectives FROM lms_skill WHERE skill_id IN (#user_needs_learn#) 
</cfquery>
</cfif>

<cfif listlen(interest_id) neq "0">
<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
FROM lms_keyword k 
INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
WHERE keyword_id IN (#interest_id#) ORDER BY k.keyword_cat_id DESC
</cfquery>
</cfif>

<!--- <cfquery name="get_expertise" datasource="#SESSION.BDDSOURCE#">
SELECT uei.expertise_id, uei.expertise_name_#SESSION.LANG_CODE# as expertise_name FROM user_expertise_index uei 
JOIN user_expertise ue ON uei.expertise_id = ue.expertise_id AND ue.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery> --->

<div class="row">
	<div class="col-md-12">
		<table class="table table-sm">															
			<tr>
				<th colspan="2" class="bg-light">
					<label><cfoutput>#obj_translater.get_translate('table_th_general')#</cfoutput></label>
					<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)><div class="float-right"><button class="btn btn-info btn-sm btn_learner_edit_profile my-0"><i class="fas fa-edit"></i></button></div></cfif>
				</th>
			</tr>	
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_job')#</cfoutput></label>
				</td>
				<td>
					<cfoutput>#user_jobtitle#</cfoutput>
				</td>
			</tr>
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_hobbies')#</cfoutput></label>
				</td>
				<td>
				<cfif listlen(interest_id) neq "0">
					<cfoutput query="get_keywords" group="keyword_cat_id">
						<strong>#keyword_cat_name#</strong>
						<br>
						<cfoutput>
						#keyword_name#<br>
						</cfoutput>
					</cfoutput>					
				</cfif>
				
				</td>
			</tr>
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_needs')#</cfoutput></label>
				</td>
				<td>
				<cfif listlen(user_needs_learn) neq "0">
					<cfloop query="get_skill">
						<cfoutput>#get_skill.skill_objectives#<br></cfoutput>
					</cfloop>
				</cfif>
				
				<!---<cfif listfind(user_needs_learn,1)>#obj_translater.get_translate('needs_txt_exp_write_improve')#<br></cfif>
				<cfif listfind(user_needs_learn,2)>#obj_translater.get_translate('needs_txt_exp_oral_improve')#<br></cfif>
				<cfif listfind(user_needs_learn,3)>#obj_translater.get_translate('needs_txt_exp_both_improve')#<br></cfif>
				<cfif listfind(user_needs_learn,4)>#obj_translater.get_translate('needs_txt_comp_write_improve')#<br></cfif>
				<cfif listfind(user_needs_learn,5)>#obj_translater.get_translate('needs_txt_comp_oral_improve')#<br></cfif>
				<cfif listfind(user_needs_learn,6)>#obj_translater.get_translate('needs_txt_comp_both_improve')#<br></cfif>--->
				</td>
			</tr>
			<!--- <tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_certification')#</cfoutput></label>
				</td>
				<td>
					<cfdump var="#get_expertise#">
					<cfloop query="get_expertise">
						<cfoutput>#get_expertise.expertise_name#<br></cfoutput>
					</cfloop>
				</td>
			</tr> --->
			<tr>
				<th colspan="2" class="bg-light"><label><cfoutput>#obj_translater.get_translate('table_th_training')#</cfoutput></label></th>
			</tr>
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_course_pref')#</cfoutput></label>
				</td>
				<td>
					<cfloop list="#user_needs_course#" index="cor">
						<cfif cor eq "1">Structural Lesson<br></cfif>
						<cfif cor eq "2">Open lessons<br></cfif>
						<cfif cor eq "3">Workshop<br></cfif>
					</cfloop>
				</td>
			</tr>
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_course_freq')#</cfoutput></label>
				</td>
				<td>
					<cfoutput>
					<cfif user_needs_frequency eq "1">1 #obj_translater.get_translate('lesson')# / #obj_translater.get_translate('day')#</cfif>
					<cfif user_needs_frequency eq "2">3 #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#</cfif>
					<cfif user_needs_frequency eq "3">2 #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#</cfif>
					<cfif user_needs_frequency eq "4">1 #obj_translater.get_translate('lesson')# / #obj_translater.get_translate('week')#</cfif>
					</cfoutput>
				</td>
			</tr>
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_course_duration')#</cfoutput></label>
				</td>
				<td>
					<cfoutput>#user_needs_duration# min</cfoutput>
				</td>
			</tr>
			<cfif user_needs_complement neq "">
			<tr>
				<td width="40%">
					<label><cfoutput>#obj_translater.get_translate('table_th_mini_complement')#</cfoutput></label>
				</td>
				<td>
				<cfoutput>#user_needs_complement#</cfoutput>
				</td>
			</tr>
			</cfif>
			<tr>
				<td width="40%"><label><cfoutput>Trainer parlant</cfoutput></label><br><small><cfoutput>#obj_translater.get_translate('needs_txt_advise')#</cfoutput></small></td>
				<td colspan="2">
					<cfoutput>
					<cfloop list="fr,en,de,es" index="cor">
					<cfif listlen(user_needs_speaking_id) neq "" AND listfind(user_needs_speaking_id,cor)><span class="lang-sm lang-lbl" lang="#cor#"></span>&nbsp;&nbsp;&nbsp;</cfif>
					</cfloop>
					</cfoutput>
				</td>
			</tr>
			<!--- <tr> --->
				<!--- <th colspan="2" class="bg-light"><label><cfoutput>#obj_translater.get_translate('table_th_trainer')#</cfoutput></label></th> --->
			<!--- </tr> --->
			<!--- <tr> --->
				<!--- <td width="40%"> --->
					<!--- <label><cfoutput>#obj_translater.get_translate('table_th_mini_trainer_franco')#</cfoutput></label> --->
				<!--- </td> --->
				<!--- <td> --->
					<!--- <cfoutput> --->
					<!--- <cfif user_needs_trainer eq "1">#obj_translater.get_translate('yes')#</cfif> --->
					<!--- <cfif user_needs_trainer eq "0">#obj_translater.get_translate('no')#</cfif> --->
					<!--- </cfoutput> --->
				<!--- </td> --->
			<!--- </tr> --->
			<!--- <tr> --->
				<!--- <td width="40%"> --->
					<!--- <label><cfoutput>#obj_translater.get_translate('table_th_mini_trainer_nb')#</cfoutput></label> --->
				<!--- </td> --->
				<!--- <td> --->
					<!--- <cfoutput> --->
					<!--- <cfif user_needs_nbtrainer eq "1">#obj_translater.get_translate('needs_txt_trainer_mono')#</cfif> --->
					<!--- <cfif user_needs_nbtrainer eq "2">#obj_translater.get_translate('needs_txt_trainer_several')#</cfif> --->
					<!--- </cfoutput> --->
				<!--- </td> --->
			<!--- </tr> --->
			<!--- <cfif user_needs_trainer_complement neq ""> --->
			<!--- <tr> --->
				<!--- <td width="40%"> --->
					<!--- <label><cfoutput>#obj_translater.get_translate('table_th_mini_trainer_complement')#</cfoutput></label> --->
				<!--- </td> --->
				<!--- <td> --->
					<!--- <cfoutput>#user_needs_trainer_complement#</cfoutput> --->
				<!--- </td> --->
			<!--- </tr> --->
			<!--- </cfif> --->
		</table>
	</div>
</div>