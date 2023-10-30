<cfsilent>


<cfif display neq "create">

	<cfif SESSION.USER_PROFILE neq "TRAINER" AND not isdefined("p_id")>
		<cflocation addtoken="no" url="index.cfm">
	<cfelse>
		<cfif SESSION.USER_PROFILE eq "TRAINER">
			<cfset p_id = SESSION.USER_ID>
			<cfset u_id = SESSION.USER_ID>
		</cfif>

		<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>

		<cfset p_id = get_planner.user_id>
		<cfset u_id = get_planner.user_id>
		<cfset user_gender = get_planner.user_gender>
		<cfset user_name = get_planner.user_name>
		<cfset user_email = get_planner.user_email>
		<cfset user_email_2 = get_planner.user_email_2>
		<cfset user_alias = get_planner.user_alias>
		<cfset user_firstname = get_planner.user_firstname>
		<cfset user_phone = get_planner.user_phone>	
		<cfset user_phone_code = get_planner.user_phone_code>	
		<cfset avail_id = get_planner.avail_id>
		<cfset user_based = get_planner.user_based>	
		<cfset user_resume = get_planner.user_resume>
		<cfset user_abstract = get_planner.user_abstract>
		<cfset user_video = get_planner.user_video>
		<cfset user_create = get_planner.user_create>
		<cfset user_video_link = get_planner.user_video_link>

		<cfset country_id_solo = get_planner.country_id>
		<cfset interest_id_solo = get_planner.interest_id>
		<cfset function_id_solo = get_planner.function_id>
		<cfset certif_id_solo = get_planner.certif_id>
		<!--- <cfset perso_id_solo = get_planner.perso_id> --->

		<cfset user_remind_1d = get_planner.user_remind_1d>
		<cfset user_remind_3h = get_planner.user_remind_3h>
		<cfset user_remind_15m = get_planner.user_remind_15m>	
		<cfset user_remind_missed = get_planner.user_remind_missed>
		<cfset user_send_late_canceled_24h = get_planner.user_send_late_canceled_24h>
		<cfset user_send_late_canceled_6h = get_planner.user_send_late_canceled_6h>
		<cfset user_remind_cancelled = get_planner.user_remind_cancelled>
		<cfset user_remind_scheduled = get_planner.user_remind_scheduled>

		<cfset user_remind_sms_15m = get_planner.user_remind_sms_15m>
		<cfset user_remind_sms_missed = get_planner.user_remind_sms_missed>
		<cfset user_remind_sms_scheduled = get_planner.user_remind_sms_scheduled>	

		<cfset user_blocker = get_planner.user_blocker>	
		<!--- <cfset user_timezone = get_planner.user_timezone>
		<cfset user_timezone_id = get_planner.timezone_id> --->
		<cfset user_lang = get_planner.user_lang>

		<cfset user_status_name = get_planner.user_status_name>
		<cfset user_status_id = get_planner.user_status_id>
		<cfset user_status_css = get_planner.user_status_css>

		<cfset user_type_id = get_planner.user_type_id>
		<cfset user_type_name = get_planner.user_type_name>

		<cfloop list="#SESSION.LIST_PT#" index="cor">
		<cfset "user_qpt_#cor#" = evaluate("get_planner.user_qpt_#cor#")>
		<cfset "user_qpt_lock_#cor#" = evaluate("get_planner.user_qpt_lock_#cor#")>
		</cfloop>

		<cfset user_lst = get_planner.user_lst>
		<cfset user_lst_lock = get_planner.user_lst_lock>

		<cfset user_add_learner = get_planner.user_add_learner>
		<cfset user_add_course = get_planner.user_add_course>
		<cfset user_add_weight = get_planner.user_add_weight>
		
		<!------------------ OBJ QUERIES ----------------->
		<cfset get_teaching_solo = obj_query.oget_teaching(p_id="#p_id#")>
		<cfset get_speaking_solo = obj_query.oget_speaking(p_id="#p_id#")>
		<cfset get_personnality_solo = obj_query.oget_personnality(p_id="#p_id#")>
		<cfset get_method_solo = obj_query.oget_method(p_id="#p_id#")>
		<cfset get_country_solo = obj_query.oget_country(p_id="#p_id#")>
		<cfset get_experience_solo = obj_query.oget_experience(p_id="#p_id#")>
		<cfset get_cursus_solo = obj_query.oget_cursus(p_id="#p_id#")>
		<cfset get_interest_solo = obj_query.oget_interest(p_id="#p_id#")>
		<cfset get_function_solo = obj_query.oget_function(p_id="#p_id#")>
		<cfset get_expertise_business_solo = obj_query.oget_expertise_business(p_id="#p_id#")>
		<cfset get_certif_solo = obj_query.oget_certif(p_id="#p_id#",exclude_ol="1")>
		<cfset get_techno_solo = obj_query.oget_techno(p_id="#p_id#")>
		<cfset get_about_solo = obj_query.oget_about(p_id="#p_id#")>
		<cfset get_paragraph_solo = obj_query.oget_paragraph(p_id="#p_id#")>

		<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#p_id#")>
		<cfset get_result_lst = obj_query.oget_result_lst(p_id="#p_id#")>
		<cfset get_workinghour = obj_query.oget_workinghour(p_id="#p_id#")>

		<cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#p_id#")>

		<cfinvoke component="api/users/user_trainer_get" method="get_trainer_teach_ready" returnvariable="user_ready">
			<cfinvokeargument name="user_id" value="#p_id#">
		</cfinvoke>
		
	</cfif>
</cfif>

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,8)
</cfquery>	

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_alias, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level ORDER BY level_id ASC
</cfquery>	

<cfquery name="get_lesson_method" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT method_id, method_name_#SESSION.LANG_CODE# as method_name FROM lms_lesson_method ORDER BY method_id ASC
</cfquery>

<cfquery name="get_language" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name FROM lms_formation WHERE formation_language = 1 ORDER BY language_name
</cfquery>

<!--- <cfquery name="get_certif" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT c.certif_id, c.certif_alias, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_code FROM lms_list_certification c
INNER JOIN lms_formation f ON f.formation_id = c.formation_id
WHERE certif_parent_id IS NULL
AND c.formation_id IN (SELECT formation_id FROM user_teaching WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">)
</cfquery> --->

<cfquery name="get_expertise_business" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 2 ORDER BY keyword_name
</cfquery>

<cfquery name="get_interest" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 3 ORDER BY keyword_name
</cfquery>

<cfquery name="get_core_skill" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 4 ORDER BY keyword_name
</cfquery>

<cfquery name="get_specific_skill" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
SELECT keyword_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_cat_id = 5 ORDER BY keyword_name
</cfquery>

<cfquery name="get_country" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT country_id, country_name_#SESSION.LANG_CODE# as country_name FROM settings_country ORDER BY country_name_#SESSION.LANG_CODE# ASC
</cfquery>

<!--- <cfquery name="get_personnality" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index
</cfquery> --->

<!--- <cfquery name="get_timezone" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM settings_timezone
</cfquery> --->

<cfquery name="get_about_questions" datasource="#SESSION.BDDSOURCE#">
SELECT user_about_question_id as quest_id, about_question_#SESSION.LANG_CODE# as quest FROM user_about_question
</cfquery>

<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
SELECT user_status_id, UCASE(user_status_trainer_name_fr) AS user_status_trainer_name FROM user_status 
WHERE user_status_id = 4 OR user_status_id = 5 OR user_status_id = 1 OR user_status_id = 2 OR user_status_id = 3 OR user_status_id = 6
</cfquery>

<cfquery name="get_user_type" datasource="#SESSION.BDDSOURCE#">
SELECT user_type_id, UCASE(user_type_name_fr) AS user_type_name FROM user_type
WHERE user_type_id = 1 OR user_type_id = 2
</cfquery>

<cfset __day = ucase(obj_translater.get_translate('day'))>

<cfset phone_code_init = '"#SESSION.LANG_CODE eq "en" ? "gb" : SESSION.LANG_CODE#"'>
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
		<cfscript>
			if (lg neq SESSION.LANG_CODE) {
				if ( lg neq "en") {
					phone_code_init=ListAppend(phone_code_init,'"#lg#"',",");
				} else {
					phone_code_init=ListAppend(phone_code_init,'"gb"',",");
				}
			}
		</cfscript>
	</cfloop>
	
	<cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
		SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name 
		FROM settings_country 
		WHERE country_alpha = "#SESSION.LANG_CODE eq "en" ? "gb" : SESSION.LANG_CODE#" LIMIT 1
	</cfquery>

</cfsilent>














































<cfswitch expression="#display#">

<cfcase value="create">

	<cfform action="updater_trainer.cfm">

	<table class="table table-sm">
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_genre')#</cfoutput></label>
			</th>
			<td colspan="2">
				<label><input name="user_gender" type="radio" value="M." checked> M.</label>&nbsp;&nbsp;&nbsp;
				<label><input name="user_gender" type="radio" value="Mme"> Mme</label>
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_firstname')#</cfoutput></label>
			</th>
			<td colspan="2">
			<input type="text" class="form-control" name="user_firstname" required="yes" value="">
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_lastname')#</cfoutput></label>
			</th>
			<td colspan="2">
			<input type="text" class="form-control" name="user_name" required="yes" value="">
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%"><label>Type</label></th>
			<td colspan="2">
				<cfselect name="user_type_id" class="form-control" query="get_user_type" display="user_type_name" value="user_type_id"></cfselect>
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label>
			</th>
			<td colspan="2">
				<cfselect name="user_status_id" class="form-control" query="get_user_status" display="user_status_trainer_name" value="user_status_id"></cfselect>
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_email')#</cfoutput></label>
			</th>
			<td colspan="2">
			<input type="text" class="form-control" validate="email" name="user_email" required="yes" value="">
			</td>
		</tr>
		<tr>
			<th class="bg-light" width="30%">
			<label><cfoutput>#obj_translater.get_translate('table_th_password')#</cfoutput></label>
			</th>
			<td colspan="2">
			<cfset temp = RandRange(100000, 999999)>
			<input type="text" class="form-control" name="user_pwd" value="<cfoutput>#temp#</cfoutput>">
			</td>
		</tr>
	</table>

	<input type="hidden" name="ins_trainer" value="1">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="Cr&eacute;er trainer"></div>
	</cfform>

</cfcase>










<cfcase value="avail">

	<form action="updater_trainer.cfm">

	<cfset edit_avail = "1">
	<cfinclude template="./widget/wid_user_availability.cfm">

	<cfoutput><input type="hidden" name="p_id" value="#p_id#"></cfoutput>
	<input type="hidden" name="updt_avail" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
	</form>
	
</cfcase>













<cfcase value="signature">

	<form id="launch_form" action="updater_trainer.cfm" enctype="multipart/form-data" method="POST">
	<div id="content" style="border:1px solid #000000"><div id="signatureparent"><div id="signature"></div></div><div id="tools"></div></div>
	<cfoutput><input type="hidden" name="p_id" value="#p_id#"></cfoutput>
	<input type="hidden" name="updt_signature" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<input type="hidden" name="signature_base64" id="signature_base64" value="">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
	</form>

	<script>
	$(document).ready(function() {

		var $sigdiv = $("#signature").jSignature({'UndoButton':true});
		$("#signature").resize();			
		
		$("#launch_form").submit(function( event ) {
			
			if( $sigdiv.jSignature('getData', 'native').length == 0) {
				alert('<cfoutput>#obj_translater.get_translate('js_warning_signature')#</cfoutput>');
				return false;
			}
			else
			{
			var data = $sigdiv.jSignature('getData', 'default');
			$('#signature_base64').val(data);
			}
			
		});

	})	
	</script>


</cfcase>














<cfcase value="speciality">

	<form action="updater_trainer.cfm">
		<table class="table table-sm">
			
			<tr>
				<th class="bg-light" width="20%">
				<label><cfoutput>#obj_translater.get_translate('table_th_methods')#</cfoutput></label>
				</th>
				<td colspan="2">
				<label><input type="checkbox" name="method_id" value="1" <cfif listfind(method_id,"1")>checked</cfif>> Web Conf&eacute;rence</label><br>
				<label><input type="checkbox" name="method_id" value="2" <cfif listfind(method_id,"2")>checked</cfif>> F2F</label><br>
				</td>
			</tr>
			<tr>
				<th class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput></label>
				</th>
				<td colspan="2">
				<cfselect query="get_country" display="country_name" name="country_id" value="country_id" selected="#country_id#" class="form-control">
				</cfselect>
				</td>
			</tr>
			<tr>
				<th class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_localisation')#</cfoutput></label>
				</th>
				<td colspan="2">
				<input type="text" class="form-control" name="user_based" value="<cfoutput>#user_based#</cfoutput>">
				</td>
			</tr>
			<tr>
				<th class="bg-light">
					<label><cfoutput>#obj_translater.get_translate('table_th_teaches')#</cfoutput></label>
				</th>
				<td colspan="2">
					<table class="table table-sm">
						<cfoutput query="get_language">
						<tr>
							<td><label><input name="teaching_formation_#formation_id#" type="checkbox" value="#formation_id#" <cfloop query="get_teaching"><cfif get_teaching.formation_id eq get_language.formation_id>checked</cfif></cfloop>> #language_name#</label></td>
							<td class="bg-light">
							<cfloop query="get_level">
							<label><input name="teaching_level_#get_language.formation_id#" type="checkbox" value="#level_id#" <cfif arraylen(array_teaching[get_language.formation_id]) neq "0" AND listfind(array_teaching[get_language.formation_id][3],level_id)>checked</cfif>> #level_alias#</label>
							</cfloop>
							</td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
			<tr>
				<th class="bg-light">
					<label><cfoutput>#obj_translater.get_translate('table_th_speaks')#</cfoutput>
					<br>1 = A1<br>2 = A2<br>3 = B1<br>4 = B2<br>5 = C1<br>6 = C2/native</label>
				</th>
				<td>
					<table class="table table-sm">
						<cfoutput query="get_language" startrow="1" maxrows="#ceiling(get_language.recordcount/2)#">
						<tr>
							<td><label><input name="speaking_formation_#formation_id#" type="checkbox" value="#formation_id#" <cfloop query="get_speaking"><cfif get_speaking.formation_id eq get_language.formation_id>checked</cfif></cfloop>> #language_name#</label></td>
							<td>
							<select name="speaking_level_#formation_id#" class="form-control form-control-sm">
							<cfloop from="1" to="6" index="cor">
							<option value="#cor#" <cfif ArrayIsDefined(array_speaking,formation_id) AND array_speaking[formation_id] eq cor>selected</cfif>>#cor#</option>
							</cfloop>
							</select>
							</td>
						</tr>
						</cfoutput>
					</table>
				</td>
				<td>
					<table class="table table-sm">
						<cfoutput query="get_language" startrow="#(ceiling(get_language.recordcount/2)+1)#" maxrows="#get_language.recordcount#">
						<tr>
							<td><label><input name="speaking_formation_#formation_id#" type="checkbox" value="#formation_id#" <cfloop query="get_speaking"><cfif get_speaking.formation_id eq get_language.formation_id>checked</cfif></cfloop>> #language_name#</label></td>
							<td>
							<select name="speaking_level_#formation_id#" class="form-control form-control-sm">
							<cfloop from="1" to="6" index="cor">
							<option value="#cor#" <cfif ArrayIsDefined(array_speaking,formation_id) AND array_speaking[formation_id] eq cor>selected</cfif>>#cor#</option>
							</cfloop>
							</select>
							</td>
						</tr>
						</cfoutput>
					</table>
				</td>
			</tr>			
											
		</table>

		<cfoutput><input type="hidden" name="p_id" value="#p_id#"></cfoutput>
		<input type="hidden" name="updt_speciality" value="1">
		<input type="hidden" name="updt_trainer" value="1">
		<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
		
		</form>





</cfcase>












<cfcase value="status">
			
	<cfform action="updater_trainer.cfm">
	
	<table class="table table-sm">
		<tr>
			<td colspan="2" bgcolor="#ECECEC"><strong>TRAINER</strong></td>
		</tr>
		<tr>
			<td width="20%"><label>Type</label></td>
			<td>
				<cfselect name="user_type_id" class="form-control" query="get_user_type" display="user_type_name" value="user_type_id" selected="#user_type_id#"></cfselect>
			</td>
		</tr>
		<tr>
			<td width="20%"><label>Status</label></td>
			<td>
				<cfselect name="user_status_id" class="form-control" query="get_user_status" display="user_status_trainer_name" value="user_status_id" selected="#user_status_id#"></cfselect>
			</td>
		</tr>
	</table>
	
	<br>
	
	<cfoutput><input type="hidden" name="p_id" value="#p_id#"></cfoutput>
	<input type="hidden" name="updt_status" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>

	</cfform>

</cfcase>

















<cfcase value="ready">


	<cfoutput query="user_ready">
		<form action="updater_trainer.cfm">
		<table class="table table-sm">
			<tr class="bg-light text-dark">
				<td><strong>TRAINER</strong></td>
				<td><strong>W F</strong></td>
				<td><strong>W GER</strong></td>
				<td><strong>TEST</strong></td>
				<td><strong>GROUP</strong></td>
				<td><strong>CLASSIC</strong></td>
				<td><strong>TM</strong></td>
				<td><strong>VIP</strong></td>
				<td><strong>CHILD</strong></td>
				<td><strong>GYM</strong></td>
				<td><strong>ASS</strong></td>
				<td></td>
			</tr>
		<tr>
			<td>
				<span class="lang-sm" lang="#lcase(formation_code)#"></span>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_france" <cfif user_ready_france eq 1>checked</cfif>> --->
				<select name="user_ready_france" id="user_ready_france" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_france eq 0 OR user_ready_france eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_france eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_france eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_germany" <cfif user_ready_germany eq 1>checked</cfif>> --->
				<select name="user_ready_germany" id="user_ready_germany" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_germany eq 0 OR user_ready_germany eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_germany eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_germany eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<select name="user_ready_test" id="user_ready_test" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_test eq 0 OR user_ready_test eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_test eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_test eq 2>selected</cfif>>SUS</option>
				</select>
				<!--- <input type="checkbox" name="user_ready_test" <cfif user_ready_test eq 1>checked</cfif>> --->
			</td>
			<td>
				<select name="user_ready_group" id="user_ready_group" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_group eq 0 OR user_ready_group eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_group eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_group eq 2>selected</cfif>>SUS</option>
				</select>
				<!--- <input type="checkbox" name="user_ready_test" <cfif user_ready_test eq 1>checked</cfif>> --->
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_classic" <cfif user_ready_classic eq 1>checked</cfif>> --->
				<select name="user_ready_classic" id="user_ready_classic" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_classic eq 0 OR user_ready_classic eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_classic eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_classic eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_tm" <cfif user_ready_tm eq 1>checked</cfif>> --->
				<select name="user_ready_tm" id="user_ready_tm" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_tm eq 0 OR user_ready_tm eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_tm eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_tm eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_vip" <cfif user_ready_vip eq 1>checked</cfif>> --->
				<select name="user_ready_vip" id="user_ready_vip" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_vip eq 0 OR user_ready_vip eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_vip eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_vip eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_vip" <cfif user_ready_vip eq 1>checked</cfif>> --->
				<select name="user_ready_children" id="user_ready_children" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_children eq 0 OR user_ready_children eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_children eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_children eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_vip" <cfif user_ready_vip eq 1>checked</cfif>> --->
				<select name="user_ready_partner" id="user_ready_partner" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_partner eq 0 OR user_ready_partner eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_partner eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_partner eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<!--- <input type="checkbox" name="user_ready_vip" <cfif user_ready_vip eq 1>checked</cfif>> --->
				<select name="user_ready_assessment" id="user_ready_assessment" class="form-control form-control-sm">
					<option value="0" <cfif user_ready_assessment eq 0 OR user_ready_assessment eq "">selected</cfif>>NO</option>
					<option value="1" <cfif user_ready_assessment eq 1>selected</cfif>>OK</option>
					<option value="2" <cfif user_ready_assessment eq 2>selected</cfif>>SUS</option>
				</select>
			</td>
			<td>
				<input type="hidden" name="updt_ready" value="1">
				<input type="hidden" name="updt_trainer" value="1">
				<input type="hidden" name="p_id" value="#p_id#">
				<input type="hidden" name="formation_id" value="#formation_id#">
				<input type="submit" class="btn btn-sm btn-success" value="#obj_translater.get_translate('btn_update')#">
			</td>
		</tr>
		</table>
		</form>
	</cfoutput>








</cfcase>












<cfcase value="details">

	<form action="updater_trainer.cfm" method="POST">

		<table class="table table-sm">
			<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_genre')#</cfoutput></label>
				</td>
				<td colspan="2">
					<label><input name="user_gender" type="radio" value="M." <cfif user_gender eq "M.">checked</cfif>> M.</label>&nbsp;&nbsp;&nbsp;
					<label><input name="user_gender" type="radio" value="Mme" <cfif user_gender eq "Mme">checked</cfif>> Mme</label>
				</td>
			</tr>
			</cfif>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_firstname')#</cfoutput></label>
				</th>
				<td colspan="2">
				<input type="text" class="form-control" name="user_firstname" value="<cfoutput>#get_planner.user_firstname#</cfoutput>" <cfif not listFindNoCase("CS,SALES,TrainerMNG",SESSION.USER_PROFILE)>disabled</cfif>>
				</td>
			</tr>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_lastname')#</cfoutput></label>
				</th>
				<td colspan="2">
				<input type="text" class="form-control" name="user_name" value="<cfoutput>#get_planner.user_name#</cfoutput>" <cfif not listFindNoCase("CS,SALES,TrainerMNG",SESSION.USER_PROFILE)>disabled</cfif>>
				</td>
			</tr>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_email')#</cfoutput></label>
				</th>
				<td colspan="2">
				<input type="text" class="form-control" name="user_email" value="<cfoutput>#get_planner.user_email#</cfoutput>" disabled>
				</td>
			</tr>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_email')# 2</cfoutput></label>
				</th>
				<td colspan="2">
				<input type="text" class="form-control" name="user_email_2" value="<cfoutput>#get_planner.user_email_2#</cfoutput>" placeholder="secondary email">
				</td>
			</tr>
			<tr>
				<th class="bg-light" width="30%">
				<label><cfoutput>#obj_translater.get_translate('table_th_phone')#</cfoutput></label>
				</th>
				<td colspan="2">
				<!--- <input type="text" class="form-control" name="user_phone" value="<cfoutput>#get_planner.user_phone#</cfoutput>" placeholder="0607060706"> --->
				<input id="user_phone" type="tel" name="user_phone" />
				<input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfif user_phone_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_code#</cfoutput></cfif>" />
				</td>
			</tr>
		</table>
		
		<cfoutput>
		<input type="hidden" name="p_id" value="#p_id#">
		<input type="hidden" name="updt_details" value="1">
		<input type="hidden" name="updt_trainer" value="1">
		<input type="hidden" name="updt_trainer_coord" value="1">
		<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>

		</cfoutput>
		</form>
		
		<script>
			$(document).ready(function() {
			
				<cfif isDefined("user_phone_code")>
				<cfif user_phone_code neq "">
					<cfquery name="get_default_code" datasource="#SESSION.BDDSOURCE#">
						SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_code#" LIMIT 1
					</cfquery>
				</cfif></cfif>
					
			
				const phoneInputField = document.querySelector("#user_phone");
				const phoneInput = window.intlTelInput(phoneInputField, {
					customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
						return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
					},
					preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
					<cfif isDefined("user_phone_code")><cfif user_phone_code neq "" AND get_default_code.recordCount eq 1>initialCountry: "<cfoutput>#get_default_code.country_alpha#</cfoutput>",</cfif></cfif>
					utilsScript:
					"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
				});
				phoneInput.setNumber("<cfoutput>#user_phone#</cfoutput>");
			
				$('#user_phone').on('countrychange', function(e) {
					var countryData = phoneInput.getSelectedCountryData();
					var codetmp = countryData.dialCode;
			
					if (countryData.areaCodes) {
						if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
					}
					$("#user_phone_code").val(codetmp);
				});
			});
		</script>

</cfcase>





























<cfcase value="techno">

	
	<form action="updater_trainer.cfm" enctype="multipart/form-data" method="POST">
	
	<table class="table table-sm">
		<tr class="bg-light text-dark">
			<td colspan="2">
				<strong>Technology</strong>
			</td>
			<td>
				<strong>Link</strong>
			</td>
			<td>
				<strong>Preferred</strong>
			</td>
		</tr>
	
		<cfoutput query="get_techno_list">
		<tr>
			<td class="bg-light" width="30%">
				<cfif techno_icon neq ""><i class="#techno_icon#"></i></cfif>
				<label>#techno_alias#</label>
				<cfif user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif>
			</td>
			<td colspan="2">
				<cfif SESSION.USER_PROFILE eq "TRAINER">
					<input type="text" class="form-control" name="techno_#techno_id#" value="#user_techno_link#" placeholder="#techno_alias#" readonly>
				<cfelse>
					<input type="text" class="form-control" name="techno_#techno_id#" value="#user_techno_link#" placeholder="#techno_alias#">
				</cfif>
			<!--- <cfif techno_id eq 6>
				<input type="text" class="form-control" name="techno_#techno_id#_key" value="#user_techno_key#" placeholder="12345">
			</cfif> --->
			</td>
			<td>
				<label><input type="radio" name="user_techno_preferred" value="#techno_id#" <cfif user_techno_preferred eq 1>checked</cfif>></label>				
			</td>
		</tr>
		</cfoutput>
	</table>
		
	<cfoutput><input type="hidden" name="p_id" value="#p_id#"></cfoutput>
	<input type="hidden" name="updt_details" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<input type="hidden" name="updt_trainer_tech" value="1">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
	</form>
	
	
	
	
	</cfcase>
































<cfcase value="about">

	

	<div class="accordion mt-4" id="accordion_trainer">
                        
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_1" aria-expanded="true" aria-controls="collapse_trainer_1">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-language"></i> QUESTIONS & ABOUT ME
					</cfoutput>
					
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_1"></i>
					
					</h5>
				</button>

				<div id="collapse_trainer_1" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<div class="row">
					
						<div class="col-md-12">

							<form action="updater_trainer.cfm" enctype="multipart/form-data" method="POST">
		
								
								<cfoutput>
								<table class="table table-sm table-striped p-2" id="about_table">		
								<tr>
								Questions:
								</tr>
								<!---- ABOUT ALREADY FILLED ---->
								<cfloop query="get_about_solo">
								<tr id="#user_about_id#">
									<td width="40%">#quest#: </td>
									<td width="55%"><input name="update_#user_about_id#" class="form-control" type="text" value="#user_about_desc#"></td>
									<td width="5%">
										<button type="button" class="btn btn-sm btn-outline-info btn_rm_about" id="#user_about_id#"><i class="fal fa-trash-alt" aria-hidden="true"></i></button>
									</td>
								</tr>
								</cfloop>
								
								<tr height="20px"></tr>
								
								<!---- ADD A NEW ABOUT ---->
								<tr class="last_tr">
									<td width="40%"></td>
									<td width="55%"><a class="btn btn-sm btn-info btn_add_about"><i class="fas fa-plus"></i></a></td>
									<td width="5%"></td>
								</tr>
										
								<!---- PARAGRAPHE ---->
								<tr height="30px"></tr>
								<tr id="#get_paragraph_solo.user_about_id#" class="mt-3" height="50px">
									<td width="40%">#obj_translater.get_translate('table_about_paragraph')#:</td>
									<cfif get_paragraph_solo.recordcount neq 0>
										<td width="55%"><textarea id="about_paragraph" name="update_#get_paragraph_solo.user_about_id#" class="form-control" value="#get_paragraph_solo.user_about_desc#">#get_paragraph_solo.user_about_desc#</textarea></td>
									<cfelse>
										<td width="55%">
										<textarea id="about_paragraph" name="para_insert_#p_id#" class="form-control" placeholder="Write a little paragraph about yourself" value=""></textarea>
										
										</td>
									</cfif>
									<td width="5%"><cfif get_paragraph_solo.recordcount neq 0><i class="fal fa-trash-alt fa-lg btn_rm_about cursored" id="#get_paragraph_solo.user_about_id#"></i></cfif></td>
								</tr>
								
								</table>
						
								<input type="hidden" name="p_id" value="#p_id#">
								</cfoutput>
								<input type="hidden" name="updt_about" value="1">
								<input type="hidden" name="updt_trainer" value="1">
								<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
								
								</form>
								


						</div>						
						
					</div>
					
				</div>
				
			</div>
		
		</div>
		
		


		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_2" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_2" aria-expanded="false" aria-controls="collapse_trainer_2">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-globe-europe"></i> PERSONNALITY
					</cfoutput>
					
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_2"></i>
					
					</h5>
				</button>

				<div id="collapse_trainer_2" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<form method="post" id="form_perso" name="form_perso" onsubmit="return submit_form_perso();">
					<div class="row">
					
						<div class="col-md-12">

							<div class="row btn-group-toggle" data-toggle="buttons">
						
								<cfoutput query="get_personnality_solo">
								

									<div class="col-md-3">
										
									<label class="btn btn-lg card p-2 m-1 btn-outline-info cursored <cfif get_personnality_solo.user_id neq "">active</cfif>">
										
										<div class="media">
											<input type="checkbox" name="perso_id" class="perso_id" value="#perso_id#" autocomplete="off" <cfif get_personnality_solo.user_id neq "">checked="checked"</cfif>>
											<div class="media-body">
											<h6 align="center" class="mb-1" style="white-space:normal !important">#perso_name#</h6>
											</div>
										</div>
										
									</label>
									</div>
								</cfoutput>
							
							</div>	

							<cfoutput>
							<input type="hidden" name="p_id" value="#p_id#">
							<input type="hidden" name="updt_perso" value="1">
							<input type="hidden" name="updt_trainer" value="1">
							<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
							</cfoutput>

			
						</div>						
						
					</div>
					</form>
					
				</div>
				
			</div>

		</div>

	</div>
	
	
	<script>

	var count = 0;
	
	$( ".btn_rm_about" ).click(function() {
			
		var id_temp = $(this).attr("id");
		if (id_temp != 0) {
				
			var idtemp = id_temp.split("_");
			var uid = idtemp[0];
			var vid = idtemp[1];

			$.ajax({
				url : './components/about.cfc?method=rm_user_about',
				type : 'POST',
				data : {act:"rm_user_about", uaid:id_temp},
					
				success : function(resultat, status) {
				
					$("#"+id_temp).remove();
				}
			});
				
			$(this).attr('id', '0');
			
			
		}
	});
	
	tinymce.init({
		selector:'#about_paragraph',
		branding: false,
		contextmenu: "link image imagetools table spellchecker",
		contextmenu_never_use_native: true,
		draggable_modal: false,
		menubar: '',	
		toolbar: 'undo redo | bold italic underline',
		plugins: "lists",
		fontsize_formats: '11px 12px 14p'
	});
	
	
	$('.btn_add_about').click(function(event) {
		event.preventDefault();

		count++;

		var liner = '';
		liner += '<tr id="insert_'+count+'">';
		liner += '<td width="40%">';
		liner += '<select name="insert_type_'+count+'" class="form-control">';

		liner += '<cfoutput query="get_about_questions"><option value="#quest_id#" selected>';
		
		liner += '<cfscript>#writeOutput(EncodeForHTML(quest))#</cfscript>';
		
		liner+= '</option></cfoutput>';
		
		liner += '</select>';
		liner += '</td>';
		liner += '<td width="55%"><input name="insert_desc_'+count+'" type="text" class="form-control"></td>';
		liner += '<td></td></tr>';
		liner += '';
		
		$(".last_tr").before(liner);
		
	});





	function submit_form_perso() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=updt_perso',
			method : 'GET',
			data: $('#form_perso').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_about=1##trainer_about")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_about=1##trainer_about";
				}
				</cfoutput>
			}

		})

	}

	</script>
			
</cfcase>
	
	




























<cfcase value="settings">
	

	<form method="post" id="form_settings" name="form_settings" onsubmit="return submit_form_settings();">
	
		<cfoutput>
		<table class="table table-borderless border">
		
		<tr>
			<th colspan="4" class="bg-light text-dark"><label><cfoutput>#obj_translater.get_translate('table_th_params')#</cfoutput></label></th>
		</tr>
		<!--- <tr>
			<td><label>#obj_translater.get_translate('table_th_timezone')#</label></td>
			<td colspan="3">
				<select name="timezone_id" id="timezone_id" class="form-control">
				<cfloop query="get_timezone">
				<option value="#timezone_id#" <cfif user_timezone_id eq get_timezone.timezone_id>selected</cfif>>#timezone_text#</option>
				</cfloop>
				</select>
			</td>
		</tr> --->
		<tr>
			<td><label>#obj_translater.get_translate('table_th_lms_language')#</label></td>
			<td colspan="3">
			<input type="radio" name="user_lang" value="fr" <cfif user_lang eq "fr">checked</cfif>> FR
			&nbsp;&nbsp;&nbsp;
			<input type="radio" name="user_lang" value="en" <cfif user_lang eq "en">checked</cfif>> EN
			&nbsp;&nbsp;&nbsp;
			<input type="radio" name="user_lang" value="de" <cfif user_lang eq "de">checked</cfif>> DE
			&nbsp;&nbsp;&nbsp;
			<input type="radio" name="user_lang" value="es" <cfif user_lang eq "es">checked</cfif>> ES
			</td>
		</tr>
		<tr>
			<td><label>#obj_translater.get_translate('table_th_blocker')#</label></td>
			<td colspan="3">
				<select name="user_blocker" class="form-control">
					<option value="0" <cfif user_blocker eq "0">selected</cfif>>Pas de blocker</option>
					<option value="15" <cfif user_blocker eq "15">selected</cfif>>15 min</option>
					<option value="30" <cfif user_blocker eq "30">selected</cfif>>30 min</option>
				</select>
			</td>
		</tr>
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			<tr>
				<td><label>weight</label></td>
				<td colspan="3">
					<input type="number" min="0" step="1" name="user_add_weight" id="user_add_weight" value="#user_add_weight#" class="form-control" required="yes" validate="integer">
				</td>
			</tr>
		</cfif>
	</table>

	<table class="table table-borderless border">
		<tr>
			<th colspan="4" class="bg-light">
				<strong>#obj_translater.get_translate('table_th_notifications')#</strong>
			</th>
		</tr>
		<tr>
			<td width="25%"><label>#obj_translater.get_translate('table_th_24h')#</label></td>
			<td width="25%"><input type="checkbox" name="user_remind_1d" value="1" <cfif user_remind_1d eq "1">checked</cfif>></td>
			<td width="25%"><label>#obj_translater.get_translate('table_th_scheduled_lesson')#</label></td>
			<td width="25%"><input type="checkbox" name="user_remind_scheduled" value="1" <cfif user_remind_scheduled eq "1">checked</cfif>></td>
		</tr>
		<tr>
			<td><label>#obj_translater.get_translate('table_th_3h')#</label></td>
			<td><input type="checkbox" name="user_remind_3h" value="1" <cfif user_remind_3h eq "1">checked</cfif>></td>
			<td><label>#obj_translater.get_translate('table_th_cancelled_lesson')#</label></td>
			<td><input type="checkbox" name="user_remind_cancelled" value="1" <cfif user_remind_cancelled eq "1">checked</cfif>></td>
		</tr>
		<tr>
			<td><label>#obj_translater.get_translate('table_th_15m')#</label></td>
			<td><input type="checkbox" name="user_remind_15m" value="1" <cfif user_remind_15m eq "1">checked</cfif>></td>
			<td><label>#obj_translater.get_translate('table_th_missed_lesson')#</label></td>
			<td><input type="checkbox" name="user_remind_missed" value="1" <cfif user_remind_missed eq "1">checked</cfif>></td>
		</tr>
		<!---<tr>
			<th colspan="4" class="bg-light">
				<strong>#obj_translater.get_translate('table_th_notifications_sms')#</strong>
			</th>
		</tr>
		<tr>
			<td><label>#obj_translater.get_translate('table_th_15m')#</label></td>
			<td><input type="checkbox" name="user_remind_sms_15m" value="1" <cfif user_remind_sms_15m eq "1">checked</cfif>></td>
			<td><label>#obj_translater.get_translate('table_th_missed_lesson')#</label></td>
			<td><input type="checkbox" name="user_remind_sms_missed" value="1" <cfif user_remind_sms_missed eq "1">checked</cfif>></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td><label>#obj_translater.get_translate('table_th_scheduled_lesson')#</label></td>
			<td><input type="checkbox" name="user_remind_sms_scheduled" value="1" <cfif user_remind_sms_scheduled eq "1">checked</cfif>></td>
		</tr>--->
	</table>

	<table class="table table-borderless border">
		<tr>
			<th colspan="4" class="bg-light">
				<strong>#obj_translater.get_translate('table_trainer_notif_cancel_title')#</strong>
			</th>
		</tr>
		<tr>
			<td><label>#obj_translater.get_translate('table_trainer_notif_cancel_24h')#</label></td>
			<td><input type="checkbox" name="user_send_late_canceled_24h" value="1" <cfif user_send_late_canceled_24h eq "1">checked</cfif>></td>
			<td><label>#obj_translater.get_translate('table_trainer_notif_cancel_6h')#</label></td>
			<td><input type="checkbox" name="user_send_late_canceled_6h" value="1" <cfif user_send_late_canceled_6h eq "1">checked</cfif>></td>
		</tr>
	</table>
	
	<input type="hidden" name="p_id" value="#p_id#">
	<input type="hidden" name="updt_settings" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
	
	</cfoutput>

	</form>

	<script>
	function submit_form_settings() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=updt_settings',
			method : 'GET',
			data: $('#form_settings').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				console.log(window.location.href);
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_settings=1##trainer_settings")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_settings=1##trainer_settings";
				}
				</cfoutput>
			}

		})

	}

	</script>

	
</cfcase>
	














































<cfcase value="language">

	<div class="accordion mt-4" id="accordion_trainer">
                        
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_1" aria-expanded="true" aria-controls="collapse_trainer_1">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-language"></i> #obj_translater.get_translate('title_trainer_teaching')#
					</cfoutput>
					
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_1"></i>
					
					</h5>
				</button>

				<div id="collapse_trainer_1" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<div class="row">
					
						<div class="col-md-12">
							<form method="post" id="form_teaching" name="form_teaching" onsubmit="return submit_form_teaching();">
							<table class="table table_teaching border bg-white">
								<tr style="background-color:#ECECEC">
									<td colspan="2">
										<cfoutput>#obj_translater.get_translate('table_th_teached_language')#</cfoutput>
										<span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_trainer_teaching')#</cfoutput>">?</span>
									</td>
									<td colspan="2">
										<cfoutput>#obj_translater.get_translate('table_th_teached_level')#</cfoutput>
									</td>
									<td>
										<cfoutput>#obj_translater.get_translate('table_th_teached_accent')#</cfoutput>
									</td>
									<td>
										<cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput>							
									</td>
								</tr>
								<cfoutput>
								<cfloop query="get_teaching_solo">		
								<cfquery name="get_level_teaching" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_level WHERE level_id IN (#get_teaching_solo.level_id#) ORDER BY level_id
								</cfquery>
								<tr class="tr_teaching_#teaching_id#">
									<td width="5%">
										<span class="lang-sm" lang="#lcase(get_teaching_solo.formation_code)#"></span>
									</td>
									<td width="30%">
										#get_teaching_solo.formation_name#
									</td>
									<td colspan="2" width="40%">
										<cfloop query="get_level_teaching">
										<span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_teaching.level_alias# </span>
										</cfloop>
									</td>
									<td width="15%">
										<cfif get_teaching_solo.accent_name eq "">
											-
										</cfif>
										#get_teaching_solo.accent_name#
									</td>
									<td width="10%" align="center">
										<button type="button" class="btn btn-sm btn-outline-info btn_remove_teaching" id="del_teaching_id_#get_teaching_solo.teaching_id#"><i class="fal fa-trash-alt"></i></button>
									</td>
								</tr>
								</cfloop>	
								</cfoutput>
								<tr class="table-info last_tr_teaching">
								
									<td colspan="2">
										<select class="form-control" id="formation_teaching_id" name="formation_teaching_id">
										<option value="">--Select--</option>
										<cfoutput query="get_language">
										<option value="#formation_id#">#language_name#</option>
										</cfoutput>
										</select>
									</td>
									<td>
										<cfoutput query="get_level">
										<label><input class="level_teaching_id" name="level_teaching_id" type="checkbox" checked value="#level_id#"> #level_alias#</label>
										</cfoutput>
									</td>
									<td colspan="2">
										<select class="form-control" id="formation_accent_id" name="formation_accent_id">
										<option value="0">--Select--</option>
										</select>
									</td>
									<td>
										<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
										<input type="submit" class="btn btn-sm btn-info btn_add_teaching" value="<cfoutput>#obj_translater.get_translate('btn_add_language')#</cfoutput>">				
									</td>
								</tr>
								
							</table>
							</form>

						</div>						
						
					</div>

					<form method="post" id="form_specials" name="form_specials" onsubmit="return submit_form_specials();">
								
						<cfoutput>
						<input type="hidden" name="p_id" value="#p_id#">
						<input type="hidden" name="updt_specials" value="1">
						<input type="hidden" name="updt_trainer" value="1">
						<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
						</cfoutput>
			
					</form>
					
				</div>
				
			</div>
		
		</div>
		
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_2" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_2" aria-expanded="false" aria-controls="collapse_trainer_2">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-globe-europe"></i> #obj_translater.get_translate('title_trainer_speaking')#
					</cfoutput>
					
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_2"></i>
					
					</h5>
				</button>

				<div id="collapse_trainer_2" class="collapse pb-2" data-parent="#accordion_trainer">
				
					
					<div class="row">
						<div class="col-md-12">
						
							<form method="post" id="form_speaking" name="form_speaking" onsubmit="return submit_form_speaking();">
							<table class="table bg-white border">
								<tr style="background-color:#ECECEC">
									<td width="50%">
									<cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput>
									</td>
									<td width="50%">
									<cfoutput>#obj_translater.get_translate('table_th_localisation')#</cfoutput>
									</td>
								</tr>
								
								<tr>
									<td>
									<select name="country_id" id="country_id" class="form-control">
									<cfoutput>
									<cfloop query="get_country">
									<option value="#get_country.country_id#" <cfif get_country.country_id eq country_id_solo>selected</cfif>>#get_country.country_name#</option>
									</cfloop>
									</cfoutput>
									</select>
									</td>
									<td>
									<input type="text" class="form-control" name="user_based" id="user_based" value="<cfoutput>#user_based#</cfoutput>">
									</td>
								</tr>
								
							</table>
									
							<table class="table border table_speaking bg-white">
								<tr style="background-color:#ECECEC">
									<td colspan="2">
									Language <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_trainer_speaking')#</cfoutput>.">?</span>
									</td>
									<td>
										<cfoutput>#obj_translater.get_translate('level')#</cfoutput>
									</td>
									<td>
										<cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput>							
									</td>
								</tr>
								<cfoutput>
								<cfloop query="get_speaking_solo">	
								<cfquery name="get_level_speaking" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_level WHERE level_id IN (#get_speaking_solo.level_id#)
								</cfquery>							
								<tr class="tr_speaking_#speaking_id#">
									<td width="5%">
									<span class="lang-sm" lang="#lcase(get_speaking_solo.formation_code)#"></span>
									</td>
									<td width="35%">
									#get_speaking_solo.formation_name#
									</td>
									<td width="50%">
									<cfloop query="get_level_speaking">
									<span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_speaking.level_alias# </span>
									</cfloop>
									</td>
									<td width="10%" align="center">
									<button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_#get_speaking_solo.speaking_id#"><i class="fal fa-trash-alt"></i></button>
									</td>
								</tr>
								</cfloop>	
								</cfoutput>
								<tr class="table-info last_tr_speaking">								
									<td colspan="2">
									<select class="form-control" id="formation_speaking_id" name="formation_speaking_id">
									<option value="">--Select--</option>
									<cfoutput query="get_language">
									<option value="#formation_id#">#language_name#</option>
									</cfoutput>
									</select>
									</td>
									<td>
									<cfoutput query="get_level">
									<cfif level_id neq "0">
									<label><input class="level_speaking_id" name="level_speaking_id" type="radio" value="#level_id#">&nbsp; #level_alias# &nbsp;</label>
									</cfif>
									</cfoutput>
									</td>
									<td>
									<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
									<input type="submit" class="btn btn-sm btn-info btn_add_speaking" value="<cfoutput>#obj_translater.get_translate('btn_add_language')#</cfoutput>">							
									</td>
								</tr>
							</table>
							</form>

						</div>
						
						
					</div>

					<form method="post" id="form_specials" name="form_specials" onsubmit="return submit_form_specials();">
								
						<cfoutput>
						<input type="hidden" name="p_id" value="#p_id#">
						<input type="hidden" name="updt_specials" value="1">
						<input type="hidden" name="updt_trainer" value="1">
						<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
						</cfoutput>
			
					</form>
					
				</div>
				
			</div>
		
		</div>

		
		
	</div>


<script>

$("#formation_teaching_id").change(function(event) {
	// console.log($(this).val());
	$.ajax({
		url : './api/users/user_trainer_get.cfc?method=get_accent',
		type : 'POST',
		data : {formation_teaching_id:$(this).val()},				
		success : function(result, status) {
			// $(".tr_teaching_"+teaching_id+"").remove();
			var obj_result = jQuery.parseJSON(result);
			$('#formation_accent_id').empty()
			$('#formation_accent_id').append($('<option>', { 
					value: "0",
					text : "--Select--"
				}));


			$.each(obj_result, function (i, item) {
				$('#formation_accent_id').append($('<option>', { 
					value: item["FORMATION_ACCENT_ID"],
					text : item["<cfoutput>FORMATION_ACCENT_NAME</cfoutput>".toUpperCase()]
				}));
			});
		}
	});
});


handler_del_teaching = function del_teaching(){
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	teaching_id = idtemp[3];	
	
	$.ajax({
		url : './components/trainer.cfc?method=del_teaching',
		type : 'POST',
		data : {teaching_id:teaching_id, p_id:<cfoutput>#p_id#</cfoutput>},				
		success : function(result, status) {
			$(".tr_teaching_"+teaching_id+"").remove();
			
		}
	});

};
$(".btn_remove_teaching").bind("click",handler_del_teaching);	
	

function submit_form_teaching() {
	event.preventDefault();

	var fd = new FormData(document.getElementById("form_teaching"));

	var formation_id = $('#formation_teaching_id').val();
	var accent_id = $("#formation_accent_id").val();
	var level_id = [];
	$.each($("input[class='level_teaching_id']:checked"), function(){
		level_id.push($(this).val());
	});
	
	if(formation_id == "" || level_id == "")
	{
		alert("Veuillez entrer une langue et un niveau SVP.");
	}
	else
	{
		
		$.ajax({
			url : './components/trainer.cfc?method=ins_teaching',
			type : 'POST',
			data : fd,
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				
				var obj_result = jQuery.parseJSON(result);

				console.log(obj_result);
				
				<!----- CONSTRUCT TR TEACHING---->
				var liner = '<tr class="tr_teaching_'+obj_result[0]+'">';
				liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[1]+'"></span></td>';
				liner += '<td width="30%">'+obj_result[2]+'</td><td width="40%">';

			
				var array_level = obj_result[3].split(",");

				$.each(array_level, function( index, value ) {
					if(value == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
					if(value == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
					if(value == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
					if(value == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
					if(value == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
					if(value == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
					if(value == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};
					
				});

				liner += '</td><td width="15%">'+obj_result[9]+'</td>';
				
				liner += '</td><td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_teaching"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_teaching" id="del_teaching_id_'+obj_result[0]+'"><i class="fal fa-trash-alt"></i></button></td>';
				$(".last_tr_teaching").before(liner);
				
				
				<!----- CONSTRUCT TR SPEAKING---->
				var liner = '<tr class="tr_speaking_'+obj_result[4]+'">';
				liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[5]+'"></span></td>';
				liner += '<td width="30%">'+obj_result[6]+'</td><td width="40%">';
				
				if(obj_result[7] == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
				if(obj_result[7] == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
				if(obj_result[7] == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
				if(obj_result[7] == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
				if(obj_result[7] == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
				if(obj_result[7] == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
				if(obj_result[7] == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};


				liner += '</td><td width="15%">'+obj_result[9]+'</td>';

				liner += '<td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_speaking"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_'+obj_result[4]+'"><i class="fal fa-trash-alt"></i></button></td>';
				$(".last_tr_speaking").before(liner);
				
				
				
				<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
				$(".btn_remove_teaching").off("click");
				$(".btn_remove_teaching").bind("click",handler_del_teaching);
				
				<!----- CLEAN CHECKOBXES ---->
				// $(".level_teaching_id").prop("checked", false );
				$('#formation_teaching_id option[value=""]').prop('selected', true);
				
				
				
			}
		});

	}

}

handler_del_speaking = function del_speaking(){
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	speaking_id = idtemp[3];	
	
	$.ajax({
		url : './components/trainer.cfc?method=del_speaking',
		type : 'POST',
		data : {speaking_id:speaking_id, p_id:<cfoutput>#p_id#</cfoutput>},				
		success : function(result, status) {
			$(".tr_speaking_"+speaking_id+"").remove();
			
		}
	});

};
$(".btn_remove_speaking").bind("click",handler_del_speaking);	

	


function submit_form_speaking() {

	event.preventDefault();

	var fd = new FormData(document.getElementById("form_speaking"));

	var formation_id = $('#formation_speaking_id').val();
	var level_id = [];
	$.each($("input[class='level_speaking_id']:checked"), function(){
		level_id.push($(this).val());
	});
	
		if(formation_id == "" || level_id == "")
		{
			alert("Veuillez entrer une langue et un niveau SVP.");
		}
		else
		{
			
			$.ajax({
				url : './components/trainer.cfc?method=ins_speaking',
				type : 'POST',
				data : fd,
				contentType: false,
				cache      : false,
				processData: false,

				success : function(result, status) {

					var obj_result = jQuery.parseJSON(result);
					
					
					<!----- CONSTRUCT TR SPEAKING ---->
					var liner = '<tr class="tr_speaking_'+obj_result[0]+'">';
					liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[1]+'"></span></td>';
					liner += '<td width="35%">'+obj_result[2]+'</td><td width="50%">';

					if(obj_result[3] == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
					if(obj_result[3] == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
					if(obj_result[3] == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
					if(obj_result[3] == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
					if(obj_result[3] == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
					if(obj_result[3] == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
					if(obj_result[3] == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};
						
					
					liner += '</td><td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_speaking"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_'+obj_result[0]+'"><i class="fal fa-trash-alt"></i></button></td>';
					$(".last_tr_speaking").before(liner);
					
					<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
					$(".btn_remove_speaking").off("click");
					$(".btn_remove_speaking").bind("click",handler_del_speaking);
					
					<!----- CLEAN CHECKOBXES ---->
					$(".level_speaking_id").prop("checked", false );
					$('#formation_speaking_id option[value=""]').prop('selected', true);
					
					
					
				}
			});

		}

	}

	function submit_form_specials() {

		event.preventDefault();


		var fd = new FormData(document.getElementById("form_speaking"));

		$.ajax({
			url : './components/trainer.cfc?method=updt_nationality',
			type : 'POST',
			data : fd,
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {

				// var obj_result = jQuery.parseJSON(result);

				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_specials=1##trainer_specials")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_specials=1##trainer_specials";
				}
				</cfoutput>

					
			}
		});


	}

</script>

</cfcase>


























<cfcase value="interest">

	<form method="post" id="form_interest" name="form_interest" onsubmit="return submit_form_interest();">
		
	<div class="accordion mt-4" id="accordion_trainer">
                        
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_1" aria-expanded="true" aria-controls="collapse_trainer_1">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
						<i class="fal fa-tasks-alt" aria-hidden="true"></i> CORE & SPECIFIC SKILLS 
					</cfoutput>
					</h5>
				</button>

				<div id="collapse_trainer_1" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<div class="row">
					
						<div class="col-md-12">

							<h6>Core Skills</h6>
							<hr>
							<div class="row">
					
								<div class="col-md-12">
						
									<div class="card-columns">
							
										<cfoutput query="get_core_skill">
										
										<div class="card border">
											<label>
											<div class="p-1">
												<h6><input type="checkbox" name="function_id" id="function_id" value="#keyword_id#" <cfif listfind(function_id_solo,get_core_skill.keyword_id)>checked</cfif>> #keyword_name#</h6>					
											</div>
											</label>
										</div>
										
										</cfoutput>
										
									</div>

								</div>
							
							</div>	

							<br><br>
							<h6>Job specific Skills</h6>
							<hr>
							<div class="row">
					
								<div class="col-md-12">
						
									<div class="card-columns">
							
										<cfoutput query="get_specific_skill">
										
										<div class="card border">
											<label>
											<div class="p-1">
												<h6><input type="checkbox" name="function_id" id="function_id" value="#keyword_id#" <cfif listfind(function_id_solo,get_specific_skill.keyword_id)>checked</cfif>> #keyword_name#</h6>					
											</div>
											</label>
										</div>
										
										</cfoutput>
										
									</div>

								</div>
							
							</div>	
							
						</div>						
						
					</div>
					
				</div>
				
			</div>
		
		</div>
		
		


		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_2" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_2" aria-expanded="false" aria-controls="collapse_trainer_2">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
						<i class="fal fa-lightbulb-on"></i> INTERESTS
					</cfoutput>
					</h5>
				</button>

				<div id="collapse_trainer_2" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<div class="row">
					
						<div class="col-md-12">

							<div class="card-columns">
						
								<cfoutput query="get_interest">
								
								<div class="card border">
									<label>
									<div class="p-1">
										<h6><input type="checkbox" name="interest_id" id="interest_id" value="#keyword_id#" <cfif listfind(interest_id_solo,get_interest.keyword_id)>checked</cfif>> #keyword_name#</h6>					
									</div>
									</label>
								</div>
								
								</cfoutput>
								
							</div>

						</div>						
						
					</div>
					
				</div>
				
			</div>

		</div>

	</div>

	<cfoutput>
	<input type="hidden" name="p_id" value="#p_id#">
	<input type="hidden" name="updt_interest" value="1">
	<input type="hidden" name="updt_trainer" value="1">
	<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
	</cfoutput>

	</form>
	
	<script>

	function submit_form_interest() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=updt_interest',
			method : 'GET',
			data: $('#form_interest').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				console.log(window.location.href);
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_interest=1##trainer_interest")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_interest=1##trainer_interest";
				}
				</cfoutput>
			}

		})

	}

	</script>
			
</cfcase>


















































<cfcase value="expertise">

	<div class="accordion mt-4" id="accordion_trainer">
                        
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_1" aria-expanded="true" aria-controls="collapse_trainer_1">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
						<i class="fal fa-briefcase"></i> #obj_translater.get_translate('table_th_expertise')#
					</cfoutput>
					</h5>
				</button>

				<div id="collapse_trainer_1" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<div class="row">
					
						<div class="col-md-12">

							<form method="post" id="form_expertise" name="form_expertise" onsubmit="return submit_form_expertise();">
								<table class="table table_expertise border bg-white">
									<tr style="background-color:#ECECEC">
										<td>
											<cfoutput>#obj_translater.get_translate('table_th_expertise_business_area')#</cfoutput>
										</td>
										<td>
											<cfoutput>#obj_translater.get_translate('table_th_expertise_practical')#</cfoutput>
										</td>
										<td>
											<cfoutput>#obj_translater.get_translate('table_th_expertise_taught')#</cfoutput>
										</td>
										<td>
											<cfoutput>#obj_translater.get_translate('table_th_action')#</cfoutput>							
										</td>
									</tr>
									<cfoutput>
									<cfloop query="get_expertise_business_solo">		
									<tr class="tr_expertise_#expertise_business_id#">
										<td width="35%">
											#get_expertise_business_solo.keyword_name#
										</td>
										<td>
											<cfif expertise_business_practical_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_practical_duration# <cfif expertise_business_practical_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
										</td>
										<td>
											<cfif expertise_business_teaching_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_teaching_duration# <cfif expertise_business_teaching_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
										</td>
										<td width="10%" align="center">
											<button type="button" class="btn btn-sm btn-outline-info btn_remove_expertise" id="del_expertise_#get_expertise_business_solo.expertise_business_id#"><i class="fal fa-trash-alt"></i></button>
										</td>
									</tr>
									</cfloop>	
									</cfoutput>
									<tr class="table-info last_tr_expertise">
									
										<td>
											<select class="form-control" id="keyword_id" name="keyword_id">
											<option value="">--Select--</option>
											<cfoutput query="get_expertise_business">
											<option value="#keyword_id#">#keyword_name#</option>
											</cfoutput>
											</select>
										</td>
										<td>
											<select name="expertise_business_practical_duration" class="form-control">
												<cfoutput>
												<option value="0">0 #obj_translater.get_translate('short_year')#</option>
												<option value="1" selected>1 #obj_translater.get_translate('short_year')#</option>
												<option value="2">2 #obj_translater.get_translate('short_years')#</option>
												<option value="3">3 #obj_translater.get_translate('short_years')#</option>
												<option value="4">4 #obj_translater.get_translate('short_years')#</option>
												<option value="5/10">5/10 #obj_translater.get_translate('short_years')#</option>
												<option value="10/15">10/15 #obj_translater.get_translate('short_years')#</option>
												<option value="15/20">15/20 #obj_translater.get_translate('short_years')#</option>
												<option value=">20">>20 #obj_translater.get_translate('short_years')#</option>
												</cfoutput>
											</select>
										</td>
										<td>
											<select name="expertise_business_teaching_duration" class="form-control">
												<cfoutput>
												<option value="0">0 #obj_translater.get_translate('short_year')#</option>
												<option value="1" selected>1 #obj_translater.get_translate('short_year')#</option>
												<option value="2">2 #obj_translater.get_translate('short_years')#</option>
												<option value="3">3 #obj_translater.get_translate('short_years')#</option>
												<option value="4">4 #obj_translater.get_translate('short_years')#</option>
												<option value="5/10">5/10 #obj_translater.get_translate('short_years')#</option>
												<option value="10/15">10/15 #obj_translater.get_translate('short_years')#</option>
												<option value="15/20">15/20 #obj_translater.get_translate('short_years')#</option>
												<option value=">20">>20 #obj_translater.get_translate('short_years')#</option>
												</cfoutput>
											</select>

										</td>
										<td>
											<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
											<input type="submit" class="btn btn-sm btn-info btn_add_expertise" value="add expertise">				
										</td>
									</tr>
									
								</table>
								</form>

						</div>						
						
					</div>

					<form method="post" id="form_expertise_close" name="form_expertise_close" onsubmit="return submit_form_expertise_close();">
								
						<cfoutput>
						<input type="hidden" name="p_id" value="#p_id#">
						<input type="hidden" name="updt_expertise" value="1">
						<input type="hidden" name="updt_trainer" value="1">
						<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
						</cfoutput>
			
					</form>
					
				</div>
				
			</div>
		
		</div>
		
		


		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_2" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_2" aria-expanded="false" aria-controls="collapse_trainer_2">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
						<i class="fal fa-file-certificate"></i> #obj_translater.get_translate('table_th_exam_preparation')#
					</cfoutput>
					</h5>
				</button>

				<div id="collapse_trainer_2" class="collapse pb-2" data-parent="#accordion_trainer">
					
					<form method="post" id="form_certif" name="form_certif" onsubmit="return submit_form_certification();">
						<div class="row">
							<cfoutput query="get_certif_solo" group="formation_code">
								<div class="col-md-4">

									<h6 align="center">
										<span class="lang-lg" lang="#lcase(get_certif_solo.formation_code)#"></span>
										#get_certif_solo.formation_name#
									</h6>

									<cfoutput>
									
									
										<div class="card border">
											<div class="card-body">
											<label>
											<input type="checkbox" name="certif_id" class="certif_id" value="#certif_id#" autocomplete="off" <cfif get_certif_solo.user_id neq "">checked="checked"</cfif>>
												<img src="./assets/img_certif/#get_certif_solo.certif_id#.png" width="100">
												<br>
												<!--- <h6 align="center" class="mb-1" style="white-space:normal !important">#certif_alias#</h6> --->
											</label>
											</div>
										</div>

									
									</cfoutput>

								</div>
							</cfoutput>
						</div> 
							
						<div align="center">

							<cfoutput>
							<input type="hidden" name="p_id" value="#p_id#">
							<input type="hidden" name="updt_expertise" value="1">
							<input type="hidden" name="updt_trainer" value="1">
							<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
							</cfoutput>
			
						</div>						
						
					</div>
					</form>
					
				</div>
				
			</div>

		</div>

	</div>
	
	
	<script>

	function submit_form_certification() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=updt_certif',
			method : 'GET',
			data: $('#form_certif').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				console.log(window.location.href);
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_expertise=1##trainer_expertise")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_expertise=1##trainer_expertise";
				}
				</cfoutput>
			}

		})

	}



	function submit_form_expertise_close() {

	event.preventDefault();

			<cfoutput>
			if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_expertise=1##trainer_expertise")
			{
				window.location.reload();
			}
			else
			{
				window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_expertise=1##trainer_expertise";
			}
			</cfoutput>
	}



	handler_del_expertise = function del_expertise(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		exp_id = idtemp[2];	
		
		
		$.ajax({
			url : './components/trainer.cfc?method=del_expertise_business',
			type : 'GET',
			data : {exp_id:exp_id, p_id:<cfoutput>#p_id#</cfoutput>},				
			success : function(result, status) {
				$(".tr_expertise_"+exp_id+"").remove();
			}
		});

	};
	$(".btn_remove_expertise").bind("click",handler_del_expertise);	
			
		
	function submit_form_expertise() {

		event.preventDefault();

			
		$.ajax({
			url : './components/trainer.cfc?method=ins_expertise_business',
			type : 'GET',
			data: $('#form_expertise').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {

				
				var obj = JSON.parse(result);
				
				console.log()
				<!----- CONSTRUCT TR EXPERTISE---->
				var liner = '<tr class="tr_expertise_'+obj[0]+'">';
				liner += '<td>'+obj[1]+'</td>';
				if(obj[2] != "")
				{
					liner +='<td><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">'+obj[2]+'</span></td>';
				}
				else
				{
					liner += '<td>-</td>';
				} 
				if(obj[3] != "")
				{
					liner +='<td><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">'+obj[3]+'</span></td>';
				}
				else
				{
					liner += '<td>-</td>';
				}
					
				liner += '</td><td width="10%" align="center"><button type="button" class="btn btn-sm btn-outline-info btn_remove_expertise" id="del_expertise_'+obj[0]+'"><i class="fal fa-trash-alt"></i></button></td>';
				
				$(".last_tr_expertise").before(liner);
				
							
				<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
				$(".btn_remove_expertise").off("click");
				$(".btn_remove_expertise").bind("click",handler_del_expertise);
				
				
				
			}
		});

	}

	</script>
			
</cfcase>
	
	



















































<cfcase value="experience">

	<div class="alert alert-success collapse" id="alert_modif_ok">
	<cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput>
		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		<span aria-hidden="true">&times;</span>
		</button>
	</div>

	<table class="table table_experience_modal table-borderless border">
		<tbody class="table_experience">
		<tr class="bg-light text-dark">
			<td>
				<strong><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong>
			</td>
			<td colspan="2">
				<strong><cfoutput>#obj_translater.get_translate('table_th_experience')#</cfoutput></strong>
			</td>
		</tr>
		
		<cfoutput query="get_experience_solo">
		<tr class="e_#experience_id#">
			<td width="20%" align="top">
				#listgetat(SESSION.LISTMONTHS_SHORT,month(experience_start))# #year(experience_start)#			
				<cfif experience_today eq "1">
					- #obj_translater.get_translate("today")#
				<cfelse>
					> #listgetat(SESSION.LISTMONTHS_SHORT,month(experience_end))# #year(experience_end)#		
				</cfif>
			</th>
			<td>
				<strong>#experience_title#</strong><br>
				<cfif experience_localisation neq ""><p class="my-1">[#experience_localisation#]</p></cfif>
				<cfif experience_description neq ""><p class="my-1">#experience_description#</p></cfif>
			</td>				
			<td width="5%">
				<a id="e_#experience_id#" class="btn btn-sm btn-info btn_remove_experience"><i class="far fa-trash-alt"></i></a>
			</td>
		</tr>
		</cfoutput>	
		</tbody>		
	</table>

	<form method="post" id="form_experience" name="form_experience" onsubmit="return submit_form_experience();">
	<div class="card border">
		<div class="card-header p-0">
			<div class="container">
			<div class="row bg-light p-2">
				<div class="col-md-1"><cfoutput><strong>#obj_translater.get_translate('short_from')#</strong></cfoutput></div>
				<div class="col-md-2"><select class="form-control" name="experience_monthdate_start"><cfloop from="01" to="12" index="cor"><cfoutput><option value="#cor#">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><select class="form-control" name="experience_yeardate_start"><cfloop from="1980" to="#year(now())#" index="cor2"><cfoutput><option value="#cor2#">#cor2#</option></cfoutput></cfloop></select></div>
				<div class="col-md-1"><cfoutput><strong>#obj_translater.get_translate('short_to')#</strong></cfoutput></div>
				<div class="col-md-2"><select class="form-control" name="experience_monthdate_end"><cfloop from="01" to="12" index="cor"><cfoutput><option value="#cor#">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><select class="form-control" name="experience_yeardate_end"><cfloop from="1980" to="#year(now())#" index="cor2"><cfoutput><option value="#cor2#">#cor2#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><input type="checkbox" name="experience_today" value="1"> <cfoutput>#obj_translater.get_translate("short_to")# #obj_translater.get_translate("today")#</cfoutput></div>
			</div>
		</div>
		</div>
		<div class="card-body">
			
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><input class="form-control" type="text" name="experience_title" value="" placeholder="Job Description" required="yes"></div>
			</div>
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><input class="form-control" type="text" name="experience_localisation" value="" placeholder="Place, COUNTRY" required="yes"></div>
			</div>
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><textarea class="form-control" name="experience_description" placeholder="Description" required="yes"></textarea></div>
			</div>
			<cfoutput>
			<input type="hidden" name="p_id" value="#p_id#">
			<input type="hidden" name="updt_experience" value="1">
			<input type="hidden" name="updt_trainer" value="1">
			<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
			</cfoutput>
			
		</div>

	</div>
	</form>
	
	
<script>

	handler_del_experience = function del_experience(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		exp_id = idtemp[1];	

		$.ajax({
			url : './components/trainer.cfc?method=del_experience',
			method : 'POST',
			data : {experience_id:exp_id, p_id:"<cfoutput>#p_id#</cfoutput>"},				
			success : function(result, status) {
				$(".e_"+exp_id).remove();		
				$("#alert_xp").collapse();		
			}
		});
	
	};
	$(".btn_remove_experience").bind("click",handler_del_experience);	

	function submit_form_experience() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=ins_experience',
			method : 'GET',
			data: $('#form_experience').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				console.log(window.location.href);
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_xp=1##trainer_xp")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_xp=1##trainer_xp";
				}
				</cfoutput>
			}

		})

	}

</script>

</cfcase>




























<cfcase value="cursus">

	<div class="alert alert-success collapse" id="alert_modif_ok">
	<cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput>
		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
		<span aria-hidden="true">&times;</span>
		</button>
	</div>

	<table class="table table_cursus_modal table-borderless border">
		<tbody class="table_cursus">
		<tr class="bg-light text-dark">
			<td>
				<strong><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong>
			</td>
			<td colspan="2">
				<strong><cfoutput>#obj_translater.get_translate('table_th_education')#</cfoutput></strong>
			</td>
		</tr>
		
		<cfoutput query="get_cursus_solo">
		<tr class="e_#cursus_id#">
			<td width="20%" align="top">
				#listgetat(SESSION.LISTMONTHS_SHORT,month(cursus_start))# #year(cursus_start)#			
				<cfif cursus_today eq "1">
					- #obj_translater.get_translate("today")#
				<cfelse>
					> #listgetat(SESSION.LISTMONTHS_SHORT,month(cursus_end))# #year(cursus_end)#		
				</cfif>
			</th>
			<td>
				<strong>#cursus_title#</strong><br>
				<cfif cursus_localisation neq ""><p class="my-1">[#cursus_localisation#]</p></cfif>
				<cfif cursus_description neq ""><p class="my-1">#cursus_description#</p></cfif>
			</td>				
			<td width="5%">
				<a id="e_#cursus_id#" class="btn btn-sm btn-info btn_remove_cursus"><i class="far fa-trash-alt"></i></a>
			</td>
		</tr>
		</cfoutput>	
		</tbody>		
	</table>

	<form method="post" id="form_cursus" name="form_cursus" onsubmit="return submit_form_cursus();">
	<div class="card border">
		<div class="card-header p-0">
			<div class="container">
			<div class="row bg-light p-2">
				<div class="col-md-1"><cfoutput><strong>#obj_translater.get_translate('short_from')#</strong></cfoutput></div>
				<div class="col-md-2"><select class="form-control" name="cursus_monthdate_start"><cfloop from="01" to="12" index="cor"><cfoutput><option value="#cor#">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><select class="form-control" name="cursus_yeardate_start"><cfloop from="1980" to="#year(now())#" index="cor2"><cfoutput><option value="#cor2#">#cor2#</option></cfoutput></cfloop></select></div>
				<div class="col-md-1"><cfoutput><strong>#obj_translater.get_translate('short_to')#</strong></cfoutput></div>
				<div class="col-md-2"><select class="form-control" name="cursus_monthdate_end"><cfloop from="01" to="12" index="cor"><cfoutput><option value="#cor#">#listgetat(SESSION.LISTMONTHS_SHORT,cor)#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><select class="form-control" name="cursus_yeardate_end"><cfloop from="1980" to="#year(now())#" index="cor2"><cfoutput><option value="#cor2#">#cor2#</option></cfoutput></cfloop></select></div>
				<div class="col-md-2"><input type="checkbox" name="cursus_today" value="1"> <cfoutput>#obj_translater.get_translate("short_to")# #obj_translater.get_translate("today")#</cfoutput></div>
			</div>
		</div>
		</div>
		<div class="card-body">
			
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><input class="form-control" type="text" name="cursus_title" value="" placeholder="Diploma Title" required="yes"></div>
			</div>
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><input class="form-control" type="text" name="cursus_localisation" value="" placeholder="Place, COUNTRY" required="yes"></div>
			</div>
			<div class="row my-1">
				<div class="col-md-1"></div>
				<div class="col-md-11"><textarea class="form-control" name="cursus_description" placeholder="Description"></textarea></div>
			</div>
			<cfoutput>
			<input type="hidden" name="p_id" value="#p_id#">
			<input type="hidden" name="updt_cursus" value="1">
			<input type="hidden" name="updt_trainer" value="1">
			<div align="center"><input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_save')#"></div>
			</cfoutput>
			
		</div>

	</div>
	</form>
	
	
<script>

	handler_del_cursus = function del_cursus(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		cursus_id = idtemp[1];	

		$.ajax({
			url : './components/trainer.cfc?method=del_cursus',
			method : 'POST',
			data : {cursus_id:cursus_id, p_id:"<cfoutput>#p_id#</cfoutput>"},				
			success : function(result, status) {
				$(".c_"+cursus_id).remove();		
				$("#alert_cursus").collapse();		
			}
		});
	
	};
	$(".btn_remove_cursus").bind("click",handler_del_cursus);	

	function submit_form_cursus() {

		event.preventDefault();
		$.ajax({
			url : './components/trainer.cfc?method=ins_cursus',
			method : 'GET',
			data: $('#form_cursus').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				console.log(window.location.href);
				<cfoutput>
				if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_cursus=1##trainer_cursus")
				{
					window.location.reload();
				}
				else
				{
					window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_cursus=1##trainer_cursus";
				}
				</cfoutput>
			}

		})

	}

</script>

</cfcase>





























<cfcase value="photovideo">
		
	<!--- <div class="accordion mt-4" id="accordion_trainer">
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_4" class="btn btn-link btn-block text-left" disabled type="button" data-toggle="collapse" data-target="#collapse_trainer_4" aria-expanded="true" aria-controls="collapse_trainer_4">
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-photo-video"></i> #obj_translater.get_translate('title_trainer_picture_video')#
					</cfoutput>				
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_4"></i>				
					</h5>
				</button>

				<div id="collapse_trainer_4" class="collapse pb-2" data-parent="#accordion_trainer"> --->
				
					<div class="row">
					
						<div class="col-md-5">
							<div class="card border h-100">
								<div class="card-body">
									<h6>Upload Picture</h6>
									
									<div id="container_picture" align="center">		
									<img class="border-gray" src="../assets/img/unknown_female.png">
									</div>
									<div align="center">
									<form method="post" id="form_picture" name="form_picture" onsubmit="return submit_form_picture();">
									<label>*jpg / square / < 1Mo</label><br>
									<input type="file" name="file_picture" id="file_picture" accept="image/jpeg" required>
									<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
									<input type="submit" class="btn btn-info btn-sm" value="upload">
									</form>
									</div>

									<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_picture" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
									</div>


								</div>
							</div>
						</div>
						
						<div class="col-md-7">
							<div class="card border h-100">
								<div class="card-body">
									<h6>Upload Video</h6>

							
									<div id="container_video" align="center">		
									<img class="border-gray" src="../assets/img/unknown_male.png">
									</div>
									
									<form method="post" id="form_video" name="form_video" onsubmit="return submit_form_video();">
									
									<table class="table-borderless borderless">
										<!--- <tr> --->
											<!--- <td> --->
												<!--- <label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_wetransfer"> <cfoutput>#obj_translater.get_translate('form_label_video_choice_wetransfer')#</cfoutput></label> --->
											<!--- </td> --->
										<!--- </tr> --->
										<tr>
											<td>
												<label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_link" <cfif user_video_link neq "">checked</cfif>> <cfoutput>#obj_translater.get_translate('form_label_video_choice_link')#</cfoutput></label>
												<input type="text" class="form-control" name="user_video_link" id="user_video_link" value="<cfoutput>#user_video_link#</cfoutput>" <cfif user_video_link eq "">disabled</cfif>>
											</td>
										</tr>
										<tr>
											<td>
												<label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_upload"> <cfoutput>#obj_translater.get_translate('form_label_video_choice_upload')#</cfoutput> [*.mp4]</label>
											</td>
										</tr>
									</table>
									<div>
									<input type="file" name="file_video" id="file_video" accept=".mp4" required disabled>
									<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
									<input type="submit" id="btn_upload_file_video" class="btn btn-info btn-sm" disabled value="upload">
									</form>
									</div>


									<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_video" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									
								</div>
							</div>
						</div>
						
						<!--- <div class="col-md-2 d-flex align-items-end">
						
							<button class="btn btn-block btn-success btn_step_4" disabled><i class="fal fa-arrow-right"></i><br><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
						</div> --->
						
						
					</div>
					
<!--- 					
				</div>
				
			</div>
		
		</div>
		
	</div>
</div> --->



	<script>

	function submit_form_picture() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_picture"));

		$.ajax({
			url        : './components/trainer.cfc?method=upload_picture',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_picture").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_picture").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
				$("#container_picture").empty().append('<img src="./assets/user/<cfoutput>#p_id#</cfoutput>/photo.jpg" class="rounded-circle" width="180">');
			}
		});
			
					
	};




	function submit_form_video() {
		event.preventDefault();
			
		var fd = new FormData(document.getElementById("form_video"));

		$.ajax({
			url        : './components/trainer.cfc?method=upload_video',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						$("#progress_video").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						$("#progress_video").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
				$("#container_video").empty().append('<video controls preload width="100%" height="250"><source src="<cfoutput>#SESSION.BO_ROOT_URL#/assets/user/#p_id#/video.mp4</cfoutput>" type="video/mp4"></video>');																		
			}
		});
			
					
	};


	$('.video_choice').change(function(event) {

	$('.btn_step_4').prop("disabled", false);

	if($(this).val() == "video_upload")
	{
		$('#file_video').prop("disabled", false);
		$('#btn_upload_file_video').prop("disabled", false);
		$('#user_video_link').prop("disabled", true);
		
		
	}		
	else if($(this).val() == "video_link")
	{
		$('#file_video').prop("disabled", true);
		$('#btn_upload_file_video').prop("disabled", true);
		$('#user_video_link').prop("disabled", false);
		
	}
	else
	{
		$('#btn_upload_file_video').prop("disabled", true);
		$('#file_video').prop("disabled", true);
		$('#user_video_link').prop("disabled", true);
	}



	})



</script>



</cfcase>










<cfcase value="welcome">




	<div class="alert alert-success">
		<div class="media">
			<img class="mr-3" src="./assets/img/lst_extrovert.jpg" width="200">
			<div class="media-body">
			<h5 class="mt-0"><cfoutput>#obj_translater.get_translate('congrats')#</cfoutput></h5>
			<cfoutput>#obj_translater.get_translate_complex('alert_trainer_account_created')#</cfoutput>
			</div>
		</div>
	</div>
		
		
		
		
		
		
		
		
		<div class="accordion mt-4" id="accordion_trainer">
						
			<div class="card border border-info bg-light">
			
				<div class="card-header">
				
					<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_trainer_1" aria-expanded="true" aria-controls="collapse_trainer_1">
						
						<h5 class="my-1 text-info" align="center">
						<cfoutput>
						<i class="fal fa-language"></i> #obj_translater.get_translate('title_trainer_teaching')#
						</cfoutput>
						
						<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_1"></i>
						
						</h5>
					</button>
		
					<div id="collapse_trainer_1" class="collapse pb-2" data-parent="#accordion_trainer">
						
						<div class="row">
						
							<div class="col-md-10">
								<form method="post" id="form_teaching" name="form_teaching" onsubmit="return submit_form_teaching();">
								<table class="table table_teaching border bg-white">
									<tr style="background-color:#ECECEC">
										<td colspan="2">
											<cfoutput>#obj_translater.get_translate('table_th_teached_language')#</cfoutput>
											<span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_trainer_teaching')#</cfoutput>">?</span>
										</td>
										<td>
											<cfoutput>#obj_translater.get_translate('table_th_teached_level')#</cfoutput>	
										</td>
										<td align="center">
																	
										</td>
									</tr>
									<cfoutput>
									<cfloop query="get_teaching_solo">		
									<cfquery name="get_level_teaching" datasource="#SESSION.BDDSOURCE#">
									SELECT * FROM lms_level WHERE level_id IN (#get_teaching_solo.level_id#) ORDER BY level_id
									</cfquery>
									<tr class="tr_teaching_#teaching_id#">
										<td width="5%">
										<span class="lang-sm" lang="#lcase(get_teaching_solo.formation_code)#"></span>
										<!--- <img src="./assets/img/training_#lcase(get_teaching.formation_code)#.png" width="30"> --->
										</td>
										<td width="35%">
										#get_teaching.formation_name#
										</td>
										<td width="50%">
										<cfloop query="get_level_teaching">
										<!--- <label><input type="checkbox" name="level_teaching_id_#get_teaching.teaching_id#" value="#get_level.level_id#"> #get_level.level_alias#</label> --->
										<span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_teaching.level_alias# </span>
										</cfloop>
										</td>
										<td width="10%" align="center">
										<!--- <button class="btn btn-sm btn-outline-info btn_updt_teaching" id="updt_teaching_id_#get_teaching.teaching_id#"><i class="fal fa-sync"></i></button> --->
										<button type="button" class="btn btn-sm btn-outline-info btn_remove_teaching" id="del_teaching_id_#get_teaching_solo.teaching_id#"><i class="fal fa-trash-alt"></i></button>
										</td>
									</tr>
									</cfloop>	
									</cfoutput>
									<tr class="table-info last_tr_teaching">
									
										<td colspan="2">
										<select class="form-control" id="formation_teaching_id" name="formation_teaching_id">
										<option value="">--Select--</option>
										<cfoutput query="get_language">
										<option value="#formation_id#">#language_name#</option>
										</cfoutput>
										</select>
										</td>
										<td>
										<cfoutput query="get_level">
										<label><input class="level_teaching_id" name="level_teaching_id" type="checkbox" checked value="#level_id#"> #level_alias#</label>
										</cfoutput>
										</td>
										<td>
										<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
										<input type="submit" class="btn btn-sm btn-info btn_add_speaking" value="<cfoutput>#obj_translater.get_translate('btn_add_language')#</cfoutput>">				
										</td>
									</tr>
									
								</table>
								</form>
							</div>
							
							<div class="col-md-2 d-flex align-items-end">
								<button class="btn btn-block btn-success btn_step_1" disabled><i class="fal fa-arrow-right"></i><br><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
							</div>
							
						</div>
						
					</div>
					
				</div>
			
			</div>
			
			<div class="card border border-info bg-light">
			
				<div class="card-header">
				
					<button id="btn_head_2" class="btn btn-link btn-block text-left" disabled type="button" data-toggle="collapse" data-target="#collapse_trainer_2" aria-expanded="true" aria-controls="collapse_trainer_2">
						
						<h5 class="my-1 text-info" align="center">
						<cfoutput>
						<i class="fal fa-globe-europe"></i> #obj_translater.get_translate('title_trainer_speaking')#
						</cfoutput>
						
						<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_2"></i>
						
						</h5>
					</button>
		
					<div id="collapse_trainer_2" class="collapse pb-2" data-parent="#accordion_trainer">
					
						
						
						<div class="row">
							<div class="col-md-10">
							
								<form method="post" id="form_speaking" name="form_speaking" onsubmit="return submit_form_speaking();">
								<table class="table bg-white border">
									<tr style="background-color:#ECECEC">
										<td width="50%">
										<cfoutput>#obj_translater.get_translate('table_th_nationality')#</cfoutput>
										</td>
										<td width="50%">
										<cfoutput>#obj_translater.get_translate('table_th_localisation')#</cfoutput>
										</td>
									</tr>
									
									<tr>
										<td>
										<select name="country_id" id="country_id" class="form-control">
										<cfoutput>
										<cfloop query="get_country">
										<option value="#get_country.country_id#" <cfif country_id eq "75">selected</cfif>>#get_country.country_name#</option>
										</cfloop>
										</cfoutput>
										</select>
										</td>
										<td>
										<input type="text" class="form-control" name="user_based" id="user_based" value="<cfoutput>#user_based#</cfoutput>">
										</td>
									</tr>
									
								</table>
										
								<table class="table border table_speaking bg-white">
									<tr style="background-color:#ECECEC">
										<td colspan="2">
										Language <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_trainer_speaking')#</cfoutput>.">?</span>
										</td>
										<td>
										Level
										</td>
										<td>
										Action							
										</td>
									</tr>
									<cfoutput>
									<cfloop query="get_speaking_solo">	
									<cfquery name="get_level_speaking" datasource="#SESSION.BDDSOURCE#">
									SELECT * FROM lms_level WHERE level_id IN (#get_speaking.level_id#)
									</cfquery>							
									<tr class="tr_speaking_#speaking_id#">
										<td width="5%">
										<span class="lang-sm" lang="#lcase(get_speaking.formation_code)#"></span>
										</td>
										<td width="35%">
										#get_speaking.formation_name#
										</td>
										<td width="50%">
										<cfloop query="get_level_speaking">
										<span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_speaking.level_alias# </span>
										</cfloop>
										</td>
										<td width="10%" align="center">
										<button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_#get_speaking.speaking_id#"><i class="fal fa-trash-alt"></i></button>
										</td>
									</tr>
									</cfloop>	
									</cfoutput>
									<tr class="table-info last_tr_speaking">
									
										<td colspan="2">
										<select class="form-control" id="formation_speaking_id" name="formation_speaking_id">
										<option value="">--Select--</option>
										<cfoutput query="get_language">
										<option value="#formation_id#">#language_name#</option>
										</cfoutput>
										</select>
										</td>
										<td>
										<cfoutput query="get_level">
										<cfif level_id neq "0">
										<label><input class="level_speaking_id" name="level_speaking_id" type="radio" value="#level_id#">&nbsp; #level_id# &nbsp;</label>
										</cfif>
										</cfoutput>
										</td>
										<td>
										<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
										<input type="submit" class="btn btn-sm btn-info btn_add_speaking" value="<cfoutput>#obj_translater.get_translate('btn_add_language')#</cfoutput>">							
										</td>
									</form>
									</tr>
								</table>
								
							</div>
							
							<div class="col-md-2 d-flex align-items-end">
								<button class="btn btn-block btn-success btn_step_2"><i class="fal fa-arrow-right"></i><br><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
							</div>
						
							
						</div>
						
					</div>
					
				</div>
			
			</div>





		
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_3" class="btn btn-link btn-block text-left" disabled type="button" data-toggle="collapse" data-target="#collapse_trainer_3" aria-expanded="true" aria-controls="collapse_trainer_3">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-calendar-alt"></i> #obj_translater.get_translate('title_trainer_workinghour')#
					</cfoutput>
					
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_3"></i>
					
					</h5>
				</button>

				<div id="collapse_trainer_3" class="collapse pb-2" data-parent="#accordion_trainer">
					<form method="post" id="form_workinghour" name="form_workinghour" onsubmit="return submit_form_workinghour();">
					<div class="row">
					
						<div class="col-md-10">
						
							<table class="table table_condensed">
								<tr bgcolor="#ECECEC">
									<td><cfoutput>#__day#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate_complex('tooltip_explain_trainer_workinghour')#</cfoutput>">?</span></td>
									<td>AM</td>
									<td>PM</td>
								</tr>
								<cfoutput>
								<cfloop list="#SESSION.DAYWEEK_EN_MIN#" index="cor">	
								<tr <cfif evaluate("get_workinghour.day_#cor#") neq "1">class="bg-disabled"</cfif>>
									<td id="colday_#cor#">
										<label>
										<input type="checkbox" class="select_day" name="#cor#" id="#cor#" <cfif evaluate("get_workinghour.day_#cor#") eq "1">checked</cfif>>
										#ucase(cor)#
										</label>
									</td>
									<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
										<input type="checkbox" class="select_am" name="select_am_#cor#" id="select_am_#cor#" style="float:left;" <cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">checked<cfelse>disabled</cfif>>
										<label style="float:left;">&nbsp;#obj_translater.get_translate('short_from')#&nbsp;</label>
										<select name="day_#cor#_start_am" id="day_#cor#_start_am" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
										<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
										<option value="#hour#" <cfif hour eq "09:00">selected="selected"</cfif>>#hour#</option>
										</cfloop>
										</select>				
										<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>
										<select name="day_#cor#_end_am" id="day_#cor#_end_am" <cfif evaluate("get_workinghour.day_#cor#_end_am") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
										<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
										<option value="#hour#" <cfif hour eq "12:00">selected="selected"</cfif>>#hour#</option>
										</cfloop>
										</select>
									</td>
									<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
										<input type="checkbox" class="select_pm" name="select_pm_#cor#" id="select_pm_#cor#" style="float:left;" <cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">checked<cfelse>disabled</cfif>>
										<label style="float:left;">#obj_translater.get_translate('short_from')#&nbsp;</label>
										<select name="day_#cor#_start_pm" id="day_#cor#_start_pm" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
										<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
										<option value="#hour#" <cfif hour eq "14:00">selected="selected"</cfif>>#hour#</option>
										</cfloop>
										</select>				
										<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>
										<select name="day_#cor#_end_pm" id="day_#cor#_end_pm" <cfif evaluate("get_workinghour.day_#cor#_end_pm") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
										<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
										<option value="#hour#" <cfif hour eq "18:00">selected="selected"</cfif>>#hour#</option>
										</cfloop>
										</select>
									</td>
								</tr>
								</cfloop>
								</cfoutput>
							</table>
									
						</div>
						
					
						<div class="col-md-2 d-flex align-items-end">
							<button type="submit" class="btn btn-block btn-success btn_step_3" disabled><i class="fal fa-arrow-right"></i><br><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
						</div>
						
						
						
					</div>
					
					</form>
					
				</div>
				
			</div>
		
		</div>
		
		<div class="card border border-info bg-light">
		
			<div class="card-header">
			
				<button id="btn_head_4" class="btn btn-link btn-block text-left" disabled type="button" data-toggle="collapse" data-target="#collapse_trainer_4" aria-expanded="true" aria-controls="collapse_trainer_4">
					<h5 class="my-1 text-info" align="center">
					<cfoutput>
					<i class="fal fa-photo-video"></i> #obj_translater.get_translate('title_trainer_picture_video')#
					</cfoutput>				
					<i class="fas fa-check-circle fa-2x pull-right text-success collapse" id="check_4"></i>				
					</h5>
				</button>

				<div id="collapse_trainer_4" class="collapse pb-2" data-parent="#accordion_trainer">
				
					<div class="row">
					
						<div class="col-md-4">
							<div class="card border h-100">
								<div class="card-body">
									<h6>Upload Picture</h6>
									
									<div id="container_picture" align="center">		
									<img class="border-gray" src="../assets/img/unknown_female.png">
									</div>
									<div align="center">
									<form method="post" id="form_picture" name="form_picture" onsubmit="return submit_form_picture();">
									<label>*jpg / square / < 1Mo</label><br>
									<input type="file" name="file_picture" id="file_picture" accept="image/jpeg" required>
									<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
									<input type="submit" class="btn btn-info btn-sm" value="upload">
									</form>
									</div>

									<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_picture" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
									</div>


								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="card border h-100">
								<div class="card-body">
									<h6>Upload Video</h6>

							
									<div id="container_video" align="center">		
									<img class="border-gray" src="../assets/img/unknown_male.png">
									</div>
									
									<form method="post" id="form_video" name="form_video" onsubmit="return submit_form_video();">
									
									<table class="table-borderless borderless">
										<!--- <tr> --->
											<!--- <td> --->
												<!--- <label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_wetransfer"> <cfoutput>#obj_translater.get_translate('form_label_video_choice_wetransfer')#</cfoutput></label> --->
											<!--- </td> --->
										<!--- </tr> --->
										<tr>
											<td>
												<label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_link" <cfif user_video_link neq "">checked</cfif>> <cfoutput>#obj_translater.get_translate('form_label_video_choice_link')#</cfoutput></label>
												<input type="text" class="form-control" name="user_video_link" id="user_video_link" value="<cfoutput>#user_video_link#</cfoutput>" <cfif user_video_link eq "">disabled</cfif>>
											</td>
										</tr>
										<tr>
											<td>
												<label><input type="radio" class="video_choice" name="video_choice" id="video_choice" value="video_upload"> <cfoutput>#obj_translater.get_translate('form_label_video_choice_upload')#</cfoutput> [*.mp4]</label>
											</td>
										</tr>
									</table>
									<div>
									<input type="file" name="file_video" id="file_video" accept=".mp4" required disabled>
									<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
									<input type="submit" id="btn_upload_file_video" class="btn btn-info btn-sm" disabled value="upload">
									</form>
									</div>


									<div class="progress">
									<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_video" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
									
								</div>
							</div>
						</div>
						
						<div class="col-md-2 d-flex align-items-end">
						
							<button class="btn btn-block btn-success btn_step_4" disabled><i class="fal fa-arrow-right"></i><br><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
						</div>
						
						
					</div>
					
					
				</div>
				
			</div>
		
		</div>
		
	</div>


	<div align="center">
	<form method="post" id="form_apply" name="form_apply" action="./components/trainer.cfm">
	<input type="hidden" method="updt_status">
	<input type="submit" id="btn_apply" class="btn btn-success btn-lg" disabled value="Apply !">
	</form>
	</div>

	<script>
	function submit_form_workinghour() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_workinghour"));

		$.ajax({
			url : './components/trainer.cfc?method=updt_workinghour',
			type : 'POST',
			data : fd,
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {	
				$('#btn_head_3').prop("disabled",true);	
				$('#check_3').collapse('show');
				$('#collapse_trainer_3').collapse();
				$('#collapse_trainer_4').collapse();
				$('#btn_head_4').prop("disabled",false);	
			}
			
		})
			
					
	};


	function submit_form_picture() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_picture"));

		$.ajax({
			url        : './components/trainer.cfc?method=upload_picture',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_picture").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_picture").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
					$("#container_picture").empty().append('<img src="./assets/user/<cfoutput>#p_id#</cfoutput>/photo.jpg" class="rounded-circle" width="180">');
			}
		});
			
					
	};




	function submit_form_video() {
		event.preventDefault();
			
		var fd = new FormData(document.getElementById("form_video"));

		$.ajax({
			url        : './components/trainer.cfc?method=upload_video',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						$("#progress_video").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						$("#progress_video").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{
					$("#container_video").empty().append('<video controls preload width="100%" height="250"><source src="<cfoutput>#SESSION.BO_ROOT_URL#/assets/user/#p_id#/video.mp4</cfoutput>" type="video/mp4"></video>');																		
			}
		});
			
					
	};
		
		
		
		
		
		
		
		
		
		
		
	handler_del_teaching = function del_teaching(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		teaching_id = idtemp[3];	
		
		$.ajax({
			url : './components/trainer.cfc?method=del_teaching',
			type : 'POST',
			data : {teaching_id:teaching_id, p_id:<cfoutput>#p_id#</cfoutput>},				
			success : function(result, status) {
				$(".tr_teaching_"+teaching_id+"").remove();
				
			}
		});

	};
	$(".btn_remove_teaching").bind("click",handler_del_teaching);	
			
		
	function submit_form_teaching() {

		event.preventDefault();

		var fd = new FormData(document.getElementById("form_teaching"));

		var formation_id = $('#formation_teaching_id').val();
		var level_id = [];
		$.each($("input[class='level_teaching_id']:checked"), function(){
			level_id.push($(this).val());
		});
		
		if(formation_id == "" || level_id == "")
		{
			alert("Veuillez entrer une langue et un niveau SVP.");
		}
		else
		{
			
			$.ajax({
				url : './components/trainer.cfc?method=ins_teaching',
				type : 'POST',
				data : fd,
				contentType: false,
				cache      : false,
				processData: false,

				success : function(result, status) {

					$('.btn_step_1').prop("disabled", false);
					
					var obj_result = jQuery.parseJSON(result);
					
					
					<!----- CONSTRUCT TR TEACHING---->
					var liner = '<tr class="tr_teaching_'+obj_result[0]+'">';
					liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[1]+'"></span></td>';
					liner += '<td width="35%">'+obj_result[2]+'</td><td width="50%">';
					
					var array_level = obj_result[3].split(",");

					$.each(array_level, function( index, value ) {
						if(value == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
						if(value == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
						if(value == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
						if(value == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
						if(value == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
						if(value == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
						if(value == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};
						
					});
					
					liner += '</td><td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_teaching"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_teaching" id="del_teaching_id_'+obj_result[0]+'"><i class="fal fa-trash-alt"></i></button></td>';
					$(".last_tr_teaching").before(liner);
					
					
					<!----- CONSTRUCT TR SPEAKING---->
					var liner = '<tr class="tr_speaking_'+obj_result[4]+'">';
					liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[5]+'"></span></td>';
					liner += '<td width="35%">'+obj_result[6]+'</td><td width="50%">';
					
					if(obj_result[7] == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
					if(obj_result[7] == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
					if(obj_result[7] == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
					if(obj_result[7] == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
					if(obj_result[7] == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
					if(obj_result[7] == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
					if(obj_result[7] == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};

					liner += '</td><td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_speaking"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_'+obj_result[4]+'"><i class="fal fa-trash-alt"></i></button></td>';
					$(".last_tr_speaking").before(liner);
					
					
					
					<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
					$(".btn_remove_teaching").off("click");
					$(".btn_remove_teaching").bind("click",handler_del_teaching);
					
					<!----- CLEAN CHECKOBXES ---->
					// $(".level_teaching_id").prop("checked", false );
					$('#formation_teaching_id option[value=""]').prop('selected', true);
					
					
					
				}
			});

		}

	}



		
		
		
		
		
	handler_del_speaking = function del_speaking(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		speaking_id = idtemp[3];	
		
		$.ajax({
			url : './components/trainer.cfc?method=del_speaking',
			type : 'POST',
			data : {speaking_id:speaking_id, p_id:<cfoutput>#p_id#</cfoutput>},				
			success : function(result, status) {
				$(".tr_speaking_"+speaking_id+"").remove();
				
			}
		});

	};
	$(".btn_remove_speaking").bind("click",handler_del_speaking);	
		
			
		
		
	function submit_form_speaking() {

		event.preventDefault();

		var fd = new FormData(document.getElementById("form_speaking"));

		var formation_id = $('#formation_speaking_id').val();
		var level_id = [];
		$.each($("input[class='level_speaking_id']:checked"), function(){
			level_id.push($(this).val());
		});
		
		if(formation_id == "" || level_id == "")
		{
			alert("Veuillez entrer une langue et un niveau SVP.");
		}
		else
		{
			
			$.ajax({
				url : './components/trainer.cfc?method=ins_speaking',
				type : 'POST',
				data : fd,
				contentType: false,
				cache      : false,
				processData: false,

				success : function(result, status) {

					var obj_result = jQuery.parseJSON(result);
					
					
					<!----- CONSTRUCT TR SPEAKING ---->
					var liner = '<tr class="tr_speaking_'+obj_result[0]+'">';
					liner += '<td width="5%"><span class="lang-sm" lang="'+obj_result[1]+'"></span></td>';
					liner += '<td width="35%">'+obj_result[2]+'</td><td width="50%">';

					if(obj_result[3] == "0"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A0</span> ';};
					if(obj_result[3] == "1"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A1</span> ';};
					if(obj_result[3] == "2"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">A2</span> ';};
					if(obj_result[3] == "3"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B1</span> ';};
					if(obj_result[3] == "4"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">B2</span> ';};
					if(obj_result[3] == "5"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C1</span> ';};
					if(obj_result[3] == "6"){liner += '<span class="badge badge-pill bg-white border border-info p-2 badge-light">C2</span> ';};
						
					
					liner += '</td><td width="10%" align="center"><!---<button class="btn btn-sm btn-outline-info btn_remove_speaking"><i class="fal fa-sync"></i></button>---><button type="button" class="btn btn-sm btn-outline-info btn_remove_speaking" id="del_speaking_id_'+obj_result[0]+'"><i class="fal fa-trash-alt"></i></button></td>';
					$(".last_tr_speaking").before(liner);
					
					<!----- KILL & REAFFECT ACTION TO REMOVE BTN ---->
					$(".btn_remove_speaking").off("click");
					$(".btn_remove_speaking").bind("click",handler_del_speaking);
					
					<!----- CLEAN CHECKOBXES ---->
					$(".level_speaking_id").prop("checked", false );
					$('#formation_speaking_id option[value=""]').prop('selected', true);
					
					
					
				}
			});

		}

	}

	$('.video_choice').change(function(event) {

	$('.btn_step_4').prop("disabled", false);

	if($(this).val() == "video_upload")
	{
		$('#file_video').prop("disabled", false);
		$('#btn_upload_file_video').prop("disabled", false);
		$('#user_video_link').prop("disabled", true);
		
		
	}		
	else if($(this).val() == "video_link")
	{
		$('#file_video').prop("disabled", true);
		$('#btn_upload_file_video').prop("disabled", true);
		$('#user_video_link').prop("disabled", false);
		
	}
	else
	{
		$('#btn_upload_file_video').prop("disabled", true);
		$('#file_video').prop("disabled", true);
		$('#user_video_link').prop("disabled", true);
	}



	})



	$('.btn_step_1').click(function(event) {
	event.preventDefault();
	$('#btn_head_1').prop("disabled", true);
	$('#check_1').collapse('show');
	$('#collapse_trainer_1').collapse();
	$('#collapse_trainer_2').collapse();
	$('#btn_head_2').prop("disabled", false);
	})

	$('.btn_step_2').click(function(event) {
	event.preventDefault();


	var country_id = $('#country_id').val();
	var user_based = $('#user_based').val();
	<!--- console.log(country_id); --->
	<!--- console.log(user_based); --->



	$.ajax({
		url : './components/trainer.cfc?method=updt_nationality',
		type : 'GET',
		data : 'country_id='+country_id+'&user_based='+user_based,
		contentType: false,
		cache      : false,
		processData: false,

		success : function(result, status) {
			$('#btn_head_2').prop("disabled", true);
			$('#check_2').collapse('show');
			$('#collapse_trainer_2').collapse();
			$('#collapse_trainer_3').collapse();
			$('#btn_head_3').prop("disabled", false);
			
		}
	});

	})

	$('.btn_step_4').click(function(event) {
	event.preventDefault();
	$('#check_4').collapse('show');
	$('#collapse_trainer_4').collapse();
	$('#btn_apply').prop("disabled", false);
	})

	$(".select_day").change(function() {

	$('.btn_step_3').prop("disabled", false);

	if($(this).is(':checked'))
	{
		$("#colday_"+$(this).attr("id")).removeClass("bg-disabled");
		$("#colday_"+$(this).attr("id")).addClass("bg-white");
		
		$("#select_am_"+$(this).attr("id")).prop('disabled', false);
		$("#select_pm_"+$(this).attr("id")).prop('disabled', false);
		
		
		$("#start_am_"+$(this).attr("id")).prop('disabled', false);
		$("#end_am_"+$(this).attr("id")).prop('disabled', false);
	}
	else
	{

		$("#colday_"+$(this).attr("id")).removeClass("bg-white");
		$("#colday_"+$(this).attr("id")).addClass("bg-disabled");
		$("#colam_"+$(this).attr("id")).removeClass("bg-white");
		$("#colam_"+$(this).attr("id")).addClass("bg-disabled");
		$("#colpm_"+$(this).attr("id")).removeClass("bg-white");
		$("#colpm_"+$(this).attr("id")).addClass("bg-disabled");
		
		
		$("#select_am_"+$(this).attr("id")).prop('checked', false);
		$("#select_am_"+$(this).attr("id")).prop('disabled', true);
		$("#select_pm_"+$(this).attr("id")).prop('checked', false);
		$("#select_pm_"+$(this).attr("id")).prop('disabled', true);
		
		$("#day_"+$(this).attr("id")+"_start_am").prop('disabled', true);
		$("#day_"+$(this).attr("id")+"_end_am").prop('disabled', true);
		
		$("#day_"+$(this).attr("id")+"_start_pm").prop('disabled', true);
		$("#day_"+$(this).attr("id")+"_end_pm").prop('disabled', true);
		
		
		/*$("#start_am_"+$(this).attr("id")).prop('disabled', true);
		$("#end_am_"+$(this).attr("id")).prop('disabled', true);*/
	}

	});

	$(".select_am").change(function() {
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);

	if($(this).is(':checked'))
	{
		
		$("#colam_"+idtemp).removeClass("bg-disabled");
		$("#colam_"+idtemp).addClass("bg-white");
		$("#day_"+idtemp+"_start_am").prop('disabled', false);
		$("#day_"+idtemp+"_end_am").prop('disabled', false);
	}
	else{
		$("#colam_"+idtemp).removeClass("bg-white");
		$("#colam_"+idtemp).addClass("bg-disabled");
		$("#day_"+idtemp+"_start_am").prop('disabled', true);
		$("#day_"+idtemp+"_end_am").prop('disabled', true);
	}

	});

	$(".select_pm").change(function() {
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);

	if($(this).is(':checked'))
	{
		$("#colpm_"+idtemp).removeClass("bg-disabled");
		$("#colpm_"+idtemp).addClass("bg-white");
		$("#day_"+idtemp+"_start_pm").prop('disabled', false);
		$("#day_"+idtemp+"_end_pm").prop('disabled', false);
	}
	else{
		$("#colpm_"+idtemp).removeClass("bg-white");
		$("#colpm_"+idtemp).addClass("bg-disabled");
		$("#day_"+idtemp+"_start_pm").prop('disabled', true);
		$("#day_"+idtemp+"_end_pm").prop('disabled', true);
	}

});

</script>



</cfcase>


















<cfcase value="confirm">


	<div class="alert alert-success">
	<div class="media">
		<img class="mr-3" src="./assets/img/lst_extrovert.jpg" width="200">
		<div class="media-body">
		<h5 class="mt-0"><cfoutput>#obj_translater.get_translate('congrats')#</cfoutput></h5>
		<cfoutput>#obj_translater.get_translate_complex('alert_trainer_account_confirmed')#</cfoutput>
		
		<div align="center"><a href="connect_out.cfm" class="btn btn-success"><cfoutput>#obj_translater.get_translate('btn_disconnect')#</cfoutput></a></div>
		
		</div>
	</div>
	</div>

</cfcase>














<cfcase value="cursusupload">

	<div class="row">
		<div class="col-md-12">
			<div class="card border h-100">
				<div class="card-body">

					<h6><i class="fal fa-lg fa-file-pdf"></i> UPLOAD CERTIFICATE <cfoutput>#id#</cfoutput></h6>
					
					<div align="center">
						<form method="post" id="form_cursus" name="form_cursus" onsubmit="return submit_form_cursus();">
						<input type="file" name="file_cursus" id="file_cursus" accept="application/pdf,.jpg,.jpeg,.JPEG,.JPG" required>
						<input type="hidden" name="p_id" value="<cfoutput>#p_id#</cfoutput>">
						<input type="hidden" name="cursus_id" value="<cfoutput>#id#</cfoutput>">
						<input type="submit" class="btn btn-info btn-sm" value="upload">
						</form>
					</div>

					<div class="progress">
						<div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_cursus" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script>
	function submit_form_cursus() {
		event.preventDefault();

		var fd = new FormData(document.getElementById("form_cursus"));

		$.ajax({
			url        : './components/trainer.cfc?method=upload_cursus',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						console.log( 'Uploaded percent', percentComplete );
						$("#progress_cursus").css("width",percentComplete+"%");
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{

				console.log(data)
				
				// <cfoutput>
				// if(window.location.href=="#SESSION.BO_ROOT_URL#/common_trainer_account.cfm?p_id=#p_id#&trainer_cursus=1##trainer_cursus")
				// {
				// 	window.location.reload();
				// }
				// else
				// {
				// 	window.location.href="common_trainer_account.cfm?p_id=#p_id#&trainer_cursus=1##trainer_cursus";
				// }
				// </cfoutput>

			}
		});
			
					
	};
	</script>

</cfcase>



</cfswitch>
































































<cfabort>



	<script>
	$(document).ready(function() {

		
		$(".test").click(function() {
			$('.test').removeClass("active");
			$(this).addClass("active");
			$('#collapse_tp_2').collapse('toggle');
			$('#check_1').collapse('show');
			
			
		})
		
		$(".test2").click(function() {
			<!--- $('.test2').removeClass("active"); --->
			$(this).toggleClass("active");
			<!--- $('#collapse_tp_3').collapse('toggle'); --->
			
		})
		$(".test2_ok").click(function() {
			<!--- $('.test2').removeClass("active"); --->
			<!--- $(this).addClass("active"); --->
			$('#collapse_tp_3').collapse('toggle');
			$('#check_2').collapse('show');
			
		})
		
		$(".test3").click(function() {
		
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var collapse_id = idtemp[1];
			
			$('.test3').removeClass("active");
			$(this).addClass("active");
			$('#collapse_tp_4').collapse('toggle');
			$('#check_3').collapse('show');

			$('.collapse_kw').collapse('hide');
			$('#collapse_'+collapse_id).collapse('show');
			
			
			
		})
		
		
		$(".test4").click(function() {
			<!--- $('.test2').removeClass("active"); --->
			$(this).toggleClass("active");
			<!--- $('#collapse_tp_3').collapse('toggle'); --->
			
		})
		
		
		tp_duration = 10;
		level = "A2";
		
		var interest = [];
		$.each($("input[id='interest_id']:checked"), function(){
			interest.push($(this).val());
		});
		
		$(".loading_material").show("fast");
		
		
		$('.btn_go_suggested').click(function(event) {
			event.preventDefault();		
			document.location.href="learner_launch_2b.cfm?tp_choice=solo&tp_suggested=1&kwish_id="+interest;
			
		});
			
		<!--- var level = []; --->
		<!--- $.each($("input[name='level_id']:checked"), function(){ --->
			<!--- level.push($(this).val()); --->
		<!--- }); --->
		
		$.ajax({
			url : 'updater_counter.cfc?method=oget_material',
			type : 'GET',
			data : 'interest_id='+interest+'&level_id='+level,
			success : function(result, statut){
				$(".loading_material").hide("slow");
				$(".counter_material").text(result);
				$(".greenlight_material").hide();
				$(".show_counter").hide();
				
				if(result == "0")
				{
				$(".counter_material").removeClass("btn-success");
				$(".counter_tp").removeClass("btn-success");
				$(".counter_material").addClass("btn-secondary");
				$(".counter_tp").addClass("btn-secondary");
				}
				
			}
		})
		
		$(".interest_id").click(function() {
			
			var interest = [];
			$.each($("input[id='interest_id']:checked"), function(){
				interest.push($(this).val());
			});
			$(".loading_material").show("fast");
			$(".counter_theme").text(interest.length);
			<!--- var level = []; --->
			<!--- $.each($("input[name='level_id']:checked"), function(){ --->
				<!--- level.push($(this).val()); --->
			<!--- }); --->
			
			$.ajax({
				url : 'updater_counter.cfc?method=oget_material',
				type : 'GET',
				data : 'interest_id='+interest+'&level_id='+level,
				success : function(result, statut){
					$(".loading_material").hide("slow");
					$(".counter_material").text(result);
					$(".show_counter").show("fast");
					if(result == "0")
					{
						$(".counter_material").removeClass("btn-success");
						$(".counter_tp").removeClass("btn-success");
						$(".counter_material").addClass("btn-secondary");
						$(".counter_tp").addClass("btn-secondary");
						$(".greenlight_material").hide();
					}
					else if(result != "0" && result < tp_duration)
					{
						
						$(".greenlight_material").hide();
						<!--- $(".greenlight_material").text("Valider mon choix"); --->
						$(".counter_material").removeClass("btn-success");
						$(".counter_tp").removeClass("btn-success");
						$(".counter_material").addClass("btn-secondary");
						$(".counter_tp").addClass("btn-secondary");
						
						$(".greenlight_material").removeClass("btn-success");
						$(".greenlight_material").addClass("btn-secondary");
						$(".greenlight_material").addClass("disabled");
						
						$(".warning_message").show();
						
						<!--- $(".warning_message").hide("slow"); --->
						
					}
					else
					{
						$(".greenlight_material").show();
						$(".counter_material").removeClass("btn-secondary");
						$(".counter_tp").removeClass("btn-secondary");
						$(".counter_material").addClass("btn-success");
						$(".counter_tp").addClass("btn-success");
						
						$(".greenlight_material").removeClass("btn-secondary");
						$(".greenlight_material").addClass("btn-success");
						$(".greenlight_material").removeClass("disabled");
						
						$(".warning_message").hide("slow");
					}
					
				}
			})
		});
	});

		</script>
