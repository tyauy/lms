<cfif isDefined('quiz_user_id')>
	<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
	</cfquery>
</cfif>



<!---------------------- TRAITEMENT LST ----------------------->
<cfif isdefined("display_result_lst")>
	
	<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
	SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
	FROM lms_quiz_question qq
	INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
	INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
	INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
	LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
	WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	ORDER BY qc.qu_ranking ASC
	</cfquery>

	<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(ans_gain) as score
	FROM lms_quiz_result
	WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	</cfquery>
	
	<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
	SELECT SUM(ans_gain) as quiz_score
	FROM lms_quiz_answer a 
	INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
	INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
	WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
	</cfquery>
	
	
	
	<!---------------------- TRAITEMENT LINGUASKILL ----------------------->
<cfelseif isdefined("display_result_linguaskill")>
	
		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
		</cfquery>

		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		</cfquery>
		
		
		
		
		
		
		
	<!---------------------- TRAITEMENT UNIT OR EXERCICE QUIZ----------------------->	
	<cfelseif isdefined("display_result_unit") OR isdefined("display_result_exercice")>

		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
		</cfquery>

		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		</cfquery>
		
		<!---<cfquery name="get_quiz_rule" datasource="#SESSION.BDDSOURCE#">
		SELECT rule_text, rule_title
		FROM lms_quiz_rule qr 
		WHERE qr.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		AND rule_min_score < <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#"> AND rule_max_score >= <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#">
		</cfquery>--->
		
		
		
		
		
		
		
	<!---------------------- TRAITEMENT BRIGHT ----------------------->	
	<cfelseif isdefined("display_result_bright_listening") OR isdefined("display_result_bright_reading")>

		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
		</cfquery>

		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		</cfquery>
		
		<!---<cfquery name="get_quiz_rule" datasource="#SESSION.BDDSOURCE#">
		SELECT rule_text, rule_title
		FROM lms_quiz_rule qr 
		WHERE qr.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		AND rule_min_score < <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#"> AND rule_max_score >= <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#">
		</cfquery>--->
		
		
		
		
		
		
		
	<!---------------------- TRAITEMENT TOEIC ----------------------->	
	<cfelseif isdefined("display_result_toeic")>

		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
		</cfquery>

		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		</cfquery>
		
		<!---<cfquery name="get_quiz_rule" datasource="#SESSION.BDDSOURCE#">
		SELECT rule_text, rule_title
		FROM lms_quiz_rule qr 
		WHERE qr.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		AND rule_min_score < <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#"> AND rule_max_score >= <cfqueryparam cfsqltype="cf_sql_integer" value="#get_result_score.score#">
		</cfquery>--->
	<cfelseif isdefined("display_result_toeic_online")>

		<cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name
		FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
		INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
		LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
		WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		ORDER BY qc.qu_ranking ASC
		</cfquery>

		<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as score
		FROM lms_quiz_result
		WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
		</cfquery>
		
		<cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
		SELECT SUM(ans_gain) as quiz_score
		FROM lms_quiz_answer a 
		INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
		INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
		WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
		</cfquery>
		
		
		
	</cfif>
	
	
<cfif isdefined("display_result_unit") OR isdefined("display_result_exercice")>
								
	<h4 class="card-title d-inline">
	<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
		<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
	<cfelse>
		<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
	</cfif>								
	</h4>
	<div class="row">

		<div class="col-md-4">
			<canvas id="qpt2_result" height="200"></canvas>
		</div>

		<div class="col-md-8">
			<table class="table table-sm">
				<tr>
					<th width="200"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput> <!---<cfoutput>#get_quiz_id.quiz_id#</cfoutput>---></th>
					<td>
					
					<cfif get_result_score.score neq "">
						<cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
					<cfelse>
						<cfset global_note = "0">
					</cfif>

					<cfif global_note gte 80>
						<cfset cssgo = "success">
					<cfelseif global_note gt 20 AND global_note lt 80>
						<cfset cssgo = "warning">
					<cfelseif global_note lte 20>
						<cfset cssgo = "danger">
					</cfif>
					
					<cfoutput>
					<h5 class="m-0"><span class="badge badge-pill badge-#cssgo# text-white">#global_note#%<!--- / #get_quiz_score.quiz_score#---></span></h5>
					<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 20>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
					<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 40>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
					<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 60>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
					<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 80>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
					<span class="float-left"><h4 class="mt-0 mb-0"><i class="<cfif global_note gte 100>text-#cssgo#<cfelse>text-secondary</cfif> fa fa-star"></i></h4></span>
					</cfoutput>
					
					</td>
					<td align="center">
						<cfif SESSION.USER_PROFILE eq "TEST">
							<cfoutput><a href="learner_practice.cfm?sm_id=#get_quiz_id.sessionmaster_id#" class="btn btn-outline-success">#obj_translater.get_translate('btn_return_quiz')#</a></cfoutput>
						</cfif>
					</td>
					
				</tr>
			</table>
			
		</div>
		
	</div>


<cfelseif isdefined("display_result_linguaskill")>

	<cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>

	<h4 class="card-title d-inline">
	<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
	<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
	<cfelse>
	<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
	</cfif>
	</h4>
	
	<div class="row">

		<div class="col-md-4">
			<canvas id="qpt2_result" height="200"></canvas>
		</div>

		<div class="col-md-8">
			<table class="table table-sm">
				<tr>
				
					<th width="200"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></th>
					<td>
					<cfoutput><h5><span class="badge badge-pill badge-info text-white">#global_note#%</span></h5></cfoutput>
	
					</td>
					
				</tr>
				<tr>
					<th><cfoutput>#obj_translater.get_translate('table_th_scale')#</cfoutput></th>
					<td>
						
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<cfif isdefined("show_return") AND show_return eq "false">
						<cfelse>
							<a href="learner_test.cfm?subm=linguaskill" class="btn btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_return_quiz')#</cfoutput></a>
						</cfif>
					</td>
				</tr>
			</table>
			
		</div>
		
	</div>
				
<cfelseif isdefined("display_result_bright_reading") OR isdefined("display_result_bright_listening")>

	<h4 class="card-title d-inline">
	<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
	<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
	<cfelse>
	<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
	</cfif>
	</h4>
	
	<div class="row">

		<div class="col-md-4">
			<canvas id="qpt2_result" height="200"></canvas>
		</div>

		<div class="col-md-8">
			<table class="table table-sm">
				<tr>
				
					<th width="200"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></th>
					<td>
					<cfoutput><h5><span class="badge badge-pill badge-info text-white">#get_result_score.score# / #get_quiz_score.quiz_score#</span></h5></cfoutput>
	
					</td>
					
				</tr>
				<tr>
					<th><cfoutput>#obj_translater.get_translate('table_th_scale')#</cfoutput></th>
					<td>
						<cfif isdefined("display_result_bright_reading")>
						<table class="table">
							<tr class="bg-light">
								<td><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></td>
								<td><cfoutput>#obj_translater.get_translate('table_th_estimated_level')#</cfoutput></td>
							</tr>
							<tr <cfif get_result_score.score lte "3">class="bg-info"</cfif>>
								<td><= 3</td>
								<td>A0</td>
							</tr>
							<tr <cfif get_result_score.score gte "4" AND get_result_score.score lte "10">class="bg-info"</cfif>>
								<td>4-10</td>
								<td>A1</td>
							</tr>
							<tr <cfif get_result_score.score gte "11" AND get_result_score.score lte "13">class="bg-info"</cfif>>
								<td>11-13</td>
								<td>A1+/A2</td>
							</tr>
							<tr <cfif get_result_score.score gte "13" AND get_result_score.score lte "14">class="bg-info"</cfif>>
								<td>13-14</td>
								<td>A2</td>
							</tr>
							<tr <cfif get_result_score.score gte "15" AND get_result_score.score lte "17">class="bg-info"</cfif>>
								<td>15-17</td>
								<td>A2+/B1</td>
							</tr>
							<tr <cfif get_result_score.score gte "18" AND get_result_score.score lte "19">class="bg-info"</cfif>>
								<td>18-19</td>
								<td>B1</td>
							</tr>
							<tr <cfif get_result_score.score gte "20" AND get_result_score.score lte "22">class="bg-info"</cfif>>
								<td>20-22</td>
								<td>B1+/B2</td>
							</tr>
							<tr <cfif get_result_score.score gte "23" AND get_result_score.score lte "24">class="bg-info"</cfif>>
								<td>23-24</td>
								<td>B2</td>
							</tr>
							<tr <cfif get_result_score.score gte "25" AND get_result_score.score lte "26">class="bg-info"</cfif>>
								<td>25-26</td>
								<td>B2+/C1</td>
							</tr>
							<tr <cfif get_result_score.score gte "27" AND get_result_score.score lte "28">class="bg-info"</cfif>>
								<td>27-28</td>
								<td>C1</td>
							</tr>
							<tr <cfif get_result_score.score gte "29">class="bg-info"</cfif>>
								<td>29-30</td>
								<td>C1+/C2</td>
							</tr>
						</table>
						<cfelseif isdefined("display_result_bright_listening")>
						<table class="table">
							<tr class="bg-light">
								<td><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></td>
								<td><cfoutput>#obj_translater.get_translate('table_th_estimated_level')#</cfoutput></td>
							</tr>
							<tr <cfif get_result_score.score lte "1">class="bg-info"</cfif>>
								<td>0-1</td>
								<td>A0</td>
							</tr>
							<tr <cfif get_result_score.score gte "2" AND get_result_score.score lte "4">class="bg-info"</cfif>>
								<td>2-4</td>
								<td>A1</td>
							</tr>
							<tr <cfif get_result_score.score gte "5" AND get_result_score.score lte "7">class="bg-info"</cfif>>
								<td>5-7</td>
								<td>A1+/A2</td>
							</tr>
							<tr <cfif get_result_score.score gte "8" AND get_result_score.score lte "10">class="bg-info"</cfif>>
								<td>8-10</td>
								<td>A2</td>
							</tr>
							<tr <cfif get_result_score.score gte "11" AND get_result_score.score lte "13">class="bg-info"</cfif>>
								<td>11-13</td>
								<td>A2+/B1</td>
							</tr>
							<tr <cfif get_result_score.score gte "14" AND get_result_score.score lte "17">class="bg-info"</cfif>>
								<td>14-17</td>
								<td>B1</td>
							</tr>
							<tr <cfif get_result_score.score gte "18" AND get_result_score.score lte "20">class="bg-info"</cfif>>
								<td>18-20</td>
								<td>B1+/B2</td>
							</tr>
							<tr <cfif get_result_score.score gte "21" AND get_result_score.score lte "23">class="bg-info"</cfif>>
								<td>21-23</td>
								<td>B2</td>
							</tr>
							<tr <cfif get_result_score.score gte "24" AND get_result_score.score lte "26">class="bg-info"</cfif>>
								<td>24-26</td>
								<td>B2+/C1</td>
							</tr>
							<tr <cfif get_result_score.score gte "27" AND get_result_score.score lte "28">class="bg-info"</cfif>>
								<td>27-28</td>
								<td>C1</td>
							</tr>
							<tr <cfif get_result_score.score gte "29">class="bg-info"</cfif>>
								<td>29-30</td>
								<td>C1+/C2</td>
							</tr>
						</table>
						</cfif>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<cfif isdefined("show_return") AND show_return eq "false">
						<cfelse>
							<a href="learner_test.cfm?subm=bright" class="btn btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_return_quiz')#</cfoutput></a>
						</cfif>
					</td>
				</tr>
			</table>
			
		</div>
		
	</div>

<cfelseif isdefined("display_result_toeic")>


	<h4 class="card-title d-inline">
	<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
	<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
	<cfelse>
	<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
	</cfif>
	</h4>
	
	<div class="row">

		<div class="col-md-4">
			<canvas id="qpt2_result" height="200"></canvas>
		</div>

		<div class="col-md-8">
			<table class="table table-sm">
				<tr>
				
					<th width="15%"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></th>
					
					<td>
					<cfoutput><h5><span class="badge badge-pill badge-info text-white">#get_result_score.score# / #get_quiz_score.quiz_score#</span></h5></cfoutput>
					</td>
					
				</tr>
				<tr>
					<th><cfoutput>#obj_translater.get_translate('table_th_scale')#</cfoutput></th>			
					<td>
						<table class="table">
							<tr class="bg-light">
								<td width="100"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></td>
								<td width="100">Level</td>
								<td><cfoutput>#obj_translater.get_translate('table_th_analyse')#</cfoutput></td>
							</tr>
							<cfif get_result_score.score lt "120">
							<tr class="bg-info text-white">
								<td><strong>< 120</strong></td>
								<td><strong>A1</strong></td>
								<td>
									<cfoutput>
									<strong>#obj_translater.get_translate_complex('toeic_result_A1_title')#</strong>
									<small>#obj_translater.get_translate_complex('toeic_result_A1_explain')#</small>
									</cfoutput>
								</td>
							</tr>
							<cfelse>
							<tr>
								<td>< 120</td>
								<td>A1</td>
								<td>
									<cfoutput>
									#obj_translater.get_translate_complex('toeic_result_A1_title')#
									</cfoutput>
								</td>
							</tr>														
							</cfif>
							
							<cfif get_result_score.score gte "120" AND get_result_score.score lt "225">
							<tr class="bg-info text-white">
								<td><strong>120-225</strong></td>
								<td><strong>A2</strong></td>
								<td>
									<cfoutput>
									<strong>#obj_translater.get_translate_complex('toeic_result_A2_title')#</strong>
									<small>#obj_translater.get_translate_complex('toeic_result_A2_explain')#</small>
									</cfoutput>
								</td>
							</tr>
							<cfelse>
							<tr>
								<td>120-225</td>
								<td>A2</td>
								<td>																
									<cfoutput>
									#obj_translater.get_translate_complex('toeic_result_A2_title')#
									</cfoutput>																
								</td>
							</tr>														
							</cfif>
							<cfif get_result_score.score gte "225" AND get_result_score.score lt "550">
							<tr class="bg-info text-white">
								<td><strong>225-550</strong></td>
								<td><strong>B1</strong></td>
								<td>																
									<cfoutput>
									<strong>#obj_translater.get_translate_complex('toeic_result_B1_title')#</strong>
									<small>#obj_translater.get_translate_complex('toeic_result_B1_explain')#</small>
									</cfoutput>																
								</td>
							</tr>
							<cfelse>
							<tr>
								<td>225-550</td>
								<td>B1</td>
								<td>																
									<cfoutput>
									#obj_translater.get_translate_complex('toeic_result_B1_title')#
									</cfoutput>																
								</td>
							</tr>														
							</cfif>
							<cfif get_result_score.score gte "550" AND get_result_score.score lt "785">
							<tr class="bg-info text-white">
								<td><strong>550-785</strong></td>
								<td><strong>B2</strong></td>
								<td>																
									<cfoutput>
									<strong>#obj_translater.get_translate_complex('toeic_result_B2_title')#</strong>
									<small>#obj_translater.get_translate_complex('toeic_result_B2_explain')#</small>
									</cfoutput>																
								</td>
							</tr>
							<cfelse>
							<tr>
								<td>550-785</td>
								<td>B2</td>
								<td>																
									<cfoutput>
									#obj_translater.get_translate_complex('toeic_result_B2_title')#
									</cfoutput>																
								</td>
							</tr>														
							</cfif>
							<cfif get_result_score.score gte "785">
							<tr class="bg-info text-white">
								<td><strong>785-945</strong></td>
								<td><strong>C1</strong></td>
								<td>																
									<cfoutput>
									<strong>#obj_translater.get_translate_complex('toeic_result_C1_title')#</strong>
									<small>#obj_translater.get_translate_complex('toeic_result_C1_explain')#</small>
									</cfoutput>																
								</td>
							</tr>
							<cfelse>
							<tr>
								<td>785-945</td>
								<td>C1</td>
								<td>																
									<cfoutput>
									#obj_translater.get_translate_complex('toeic_result_C1_title')#
									</cfoutput>																
								</td>
							</tr>														
							</cfif>
						</table>
					</td>
				</tr>
				<!--- <tr>
					<td colspan="2" align="center">
					<a href="learner_test.cfm?subm=toeic" class="btn btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_return_quiz')#</cfoutput></a>
					</td>
				</tr> --->
			</table>
			
		</div>
		
	<cfelseif isdefined("display_result_toeic_online")>


		<h4 class="card-title d-inline">
		<cfif evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#") neq "">
		<cfoutput>#evaluate("get_quiz_id.quiz_name_#SESSION.LANG_CODE#")#</cfoutput>
		<cfelse>
		<cfoutput>#get_quiz_id.quiz_name#</cfoutput>
		</cfif>
		</h4>
		
		<div class="row">
	
			<div class="col-md-4">
				<canvas id="qpt2_result" height="200"></canvas>
			</div>
	
			<div class="col-md-8">
				<table class="table table-sm">
					<tr>
					
						<th width="15%"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></th>
						<cfset adjusted_score = get_result_score.score * 11>
						<td>
						<cfoutput><h5><span class="badge badge-pill badge-info text-white">#adjusted_score# / 990</span></h5></cfoutput>
						</td>
						
						
						
					</tr>
				
					<tr>
						<th><cfoutput>#obj_translater.get_translate('table_th_scale')#</cfoutput></th>			
						<td>
							<table class="table">
								<tr class="bg-light">
									<td width="100"><cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput></td>
									<td width="100">Level</td>
									<td><cfoutput>#obj_translater.get_translate('table_th_analyse')#</cfoutput></td>
								</tr>
								<cfif adjusted_score lt "120">
								<tr class="bg-info text-white">
									<td><strong>< 120</strong></td>
									<td><strong>A1</strong></td>
									<td>
										<cfoutput>
										<strong>#obj_translater.get_translate_complex('toeic_result_A1_title')#</strong>
										<small>#obj_translater.get_translate_complex('toeic_result_A1_explain')#</small>
										</cfoutput>
									</td>
								</tr>
								<cfelse>
								<tr>
									<td>< 120</td>
									<td>A1</td>
									<td>
										<cfoutput>
										#obj_translater.get_translate_complex('toeic_result_A1_title')#
										</cfoutput>
									</td>
								</tr>														
								</cfif>
								
								<cfif adjusted_score gte "120" AND adjusted_score lt "225">
								<tr class="bg-info text-white">
									<td><strong>120-225</strong></td>
									<td><strong>A2</strong></td>
									<td>
										<cfoutput>
										<strong>#obj_translater.get_translate_complex('toeic_result_A2_title')#</strong>
										<small>#obj_translater.get_translate_complex('toeic_result_A2_explain')#</small>
										</cfoutput>
									</td>
								</tr>
								<cfelse>
								<tr>
									<td>120-225</td>
									<td>A2</td>
									<td>																
										<cfoutput>
										#obj_translater.get_translate_complex('toeic_result_A2_title')#
										</cfoutput>																
									</td>
								</tr>														
								</cfif>
								<cfif adjusted_score gte "225" AND adjusted_score lt "550">
								<tr class="bg-info text-white">
									<td><strong>225-550</strong></td>
									<td><strong>B1</strong></td>
									<td>																
										<cfoutput>
										<strong>#obj_translater.get_translate_complex('toeic_result_B1_title')#</strong>
										<small>#obj_translater.get_translate_complex('toeic_result_B1_explain')#</small>
										</cfoutput>																
									</td>
								</tr>
								<cfelse>
								<tr>
									<td>225-550</td>
									<td>B1</td>
									<td>																
										<cfoutput>
										#obj_translater.get_translate_complex('toeic_result_B1_title')#
										</cfoutput>																
									</td>
								</tr>														
								</cfif>
								<cfif adjusted_score gte "550" AND adjusted_score lt "785">
								<tr class="bg-info text-white">
									<td><strong>550-785</strong></td>
									<td><strong>B2</strong></td>
									<td>																
										<cfoutput>
										<strong>#obj_translater.get_translate_complex('toeic_result_B2_title')#</strong>
										<small>#obj_translater.get_translate_complex('toeic_result_B2_explain')#</small>
										</cfoutput>																
									</td>
								</tr>
								<cfelse>
								<tr>
									<td>550-785</td>
									<td>B2</td>
									<td>																
										<cfoutput>
										#obj_translater.get_translate_complex('toeic_result_B2_title')#
										</cfoutput>																
									</td>
								</tr>														
								</cfif>
								<cfif adjusted_score gte "785">
								<tr class="bg-info text-white">
									<td><strong>785-945</strong></td>
									<td><strong>C1</strong></td>
									<td>																
										<cfoutput>
										<strong>#obj_translater.get_translate_complex('toeic_result_C1_title')#</strong>
										<small>#obj_translater.get_translate_complex('toeic_result_C1_explain')#</small>
										</cfoutput>																
									</td>
								</tr>
								<cfelse>
								<tr>
									<td>785-945</td>
									<td>C1</td>
									<td>																
										<cfoutput>
										#obj_translater.get_translate_complex('toeic_result_C1_title')#
										</cfoutput>																
									</td>
								</tr>														
								</cfif>
							</table>
						</td>
					</tr>
					<!--- <tr>
						<td colspan="2" align="center">
						<a href="learner_test.cfm?subm=toeic" class="btn btn-outline-success"><cfoutput>#obj_translater.get_translate('btn_return_quiz')#</cfoutput></a>
						</td>
					</tr> --->
				</table>
				
			</div>

</cfif>