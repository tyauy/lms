<cfset get_planner = obj_query.oget_planner(p_id="#p_id#")>

<cfset user_gender = get_planner.user_gender>
<cfset user_name = get_planner.user_name>
<cfset user_email = get_planner.user_email>
<cfset user_email_2 = get_planner.user_email_2>
<cfset user_alias = get_planner.user_alias>
<cfset user_firstname = get_planner.user_firstname>
<cfset user_phone = get_planner.user_phone>	
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
<cfset user_remind_cancelled = get_planner.user_remind_cancelled>
<cfset user_remind_scheduled = get_planner.user_remind_scheduled>

<cfset user_remind_sms_15m = get_planner.user_remind_sms_15m>
<cfset user_remind_sms_missed = get_planner.user_remind_sms_missed>
<cfset user_remind_sms_scheduled = get_planner.user_remind_sms_scheduled>	

<cfset user_blocker = get_planner.user_blocker>	
<cfset user_timezone = get_planner.user_timezone>
<cfset user_timezone_id = get_planner.timezone_id>
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
<cfset get_certif_solo = obj_query.oget_certif(p_id="#p_id#")>
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


	<!---- HARD QUERIES--->
	<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(lesson_id) as nb FROM lms_lesson2 WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#"> AND status_id <> 3
	</cfquery>
								
	<cfquery name="get_learner" datasource="#SESSION.BDDSOURCE#">
	SELECT COUNT(DISTINCT(t.user_id)) as nb FROM lms_tp t
	INNER JOIN lms_tpplanner p ON t.tp_id = p.tp_id AND p.active = 1
	WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>

	<cfquery name="get_rating" datasource="#SESSION.BDDSOURCE#">
	SELECT AVG(rating_teaching) as avg_rating, COUNT(rating_id) as sum_rating FROM lms_rating WHERE trainer_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>
		
<cfif isdefined("display_back")>
<div class="row">
	<div class="col-md-12" align="center">
		<cfoutput>		
		<button class="btn btn-link text-red fo btn_back"><i class="fal fa-chevron-double-left"></i> #obj_translater.get_translate('btn_return')#</button>
		<button class="btn btn-red btn_choose_trainer" id="t_#p_id#"><i class="fal fa-thumbs-up"></i> #obj_translater.get_translate('btn_choose_this_trainer')#</button>
		</cfoutput>
	</div>
</div>
</cfif>

<div class="row">
	<div class="col-md-6">
	
			<div align="center">
				<cfoutput>#obj_lms.get_thumb(user_id="#p_id#",size="120")#</cfoutput>
				<h4 class="mt-0"><strong><cfoutput>#user_firstname#</cfoutput></strong></h4>	
			</div>
				
				
			<table class="table mt-3">
				<tr>
					<td width="30%" class="bg-light"><strong style="font-size:12px"><cfoutput>#obj_translater.get_translate('lives')#</cfoutput></strong></td>
					<td><cfoutput>#user_based#</cfoutput></td>
				</tr>	
				<tr>
					<td class="bg-light"><strong style="font-size:12px"><cfoutput>#obj_translater.get_translate('table_th_personnality')#</cfoutput></strong></td>
					<td>
						<cfoutput>
							<!--- <cfdump var="#get_personnality_solo#"> --->
							<cfloop query="get_personnality_solo">
								<cfif get_personnality_solo.user_id neq "">
									<span class="badge badge-light border">#get_personnality_solo.perso_name#</span>
								</cfif>
							</cfloop>
						</cfoutput>
					</td>
				</tr>
				<tr>
					<td class="bg-light"><strong style="font-size:12px"><cfoutput>#obj_translater.get_translate('table_th_teaches')#</cfoutput></strong></td>
					<td>
						<cfoutput>
						<cfloop query="get_teaching_solo">
							<span class="lang-lg" lang="#get_teaching_solo.formation_code#"></span>
						</cfloop>
						</cfoutput>
									
					</td>
				</tr>
				<tr>
					<td class="bg-light"><strong style="font-size:12px"><cfoutput>#obj_translater.get_translate('table_th_speaks')#</cfoutput></strong></td>
					<td>
						<cfoutput>
						<cfloop query="get_speaking_solo">
							<span class="badge badge-pill font-weight-normal" style="font-size:12px" align="center">
							#get_speaking_solo.formation_name# 
							<cfset level_id = get_speaking_solo.level_id>
							<div class="clearfix"></div>
							<div class="gauge <cfif level_id eq 1>bg-danger<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-danger<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-warning<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-warning<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-success<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							<div class="gauge <cfif level_id eq 1>bg-light2<cfelseif level_id eq 2>bg-light2<cfelseif level_id eq 3>bg-light2<cfelseif level_id eq 4>bg-light2<cfelseif level_id eq 5>bg-light2<cfelseif level_id eq 6>bg-success</cfif> float-left ml-1 mt-1"></div>
							</span>
						</cfloop>
						</cfoutput>
									
					</td>
				</tr>

				<!--- <cfoutput>
					<cfloop query="get_teaching_solo">	
					<cfquery name="get_level_teaching" datasource="#SESSION.BDDSOURCE#">
					SELECT * FROM lms_level WHERE level_id IN (#get_teaching_solo.level_id#) ORDER BY level_id
					</cfquery>							
					<tr>
						<td width="5%">
						<span class="lang-sm" lang="#lcase(get_teaching_solo.formation_code)#"></span>
						</td>
						<td width="30%">
						#get_teaching_solo.formation_name#
						</td>
						<cfif SESSION.USER_PROFILE neq "TRAINER">
						<td width="15%">
						<cfif get_teaching_solo.accent_name eq "">
							-
						<cfelse>
							#get_teaching_solo.accent_name#
						</cfif>
						</td>
						</cfif>
						<td width="40%">
						<cfloop query="get_level_teaching">
						<span class="badge badge-pill bg-white border border-info p-2 badge-light"> #get_level_teaching.level_alias# </span>
						</cfloop>
						</td>
					</tr>
					</cfloop>	
				</cfoutput> --->
				
			</table>


		<div class="card border">
			<div class="card-body">

				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-calendar-alt fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('table_th_availabilities')#</cfoutput></h5>
					<hr class="border-top border-red mb-1 mt-2">
				</div>

				<cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
					<cfinvokeargument name="u_id" value="#p_id#">
				</cfinvoke>
				<cfset planner_view = "pdf_version">
				<cfinclude template="./widget/wid_planner.cfm">
			</div>
		</div>
		
		

		<cfif get_expertise_business_solo.recordcount neq "0" OR get_function_solo.recordcount neq "0" OR get_certif_solo.recordcount neq "0">
			
		
		<div class="card border">
			<div class="card-body">

				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-star fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('table_th_skills')#</cfoutput></h5>
					<hr class="border-top border-red mb-3 mt-2">
				</div>
				
				<cfif get_expertise_business_solo.recordcount neq "0">
					<table class="table table_business_expertise">
						<tr class="bg-light text-dark">
							<td>
								<strong><cfoutput>#obj_translater.get_translate('table_th_expertise_business_area')#</cfoutput></strong>
							</td>
							<td>
								<strong><cfoutput>#obj_translater.get_translate('table_th_expertise_practical')#</cfoutput></strong>
							</td>
							<td>
								<strong><cfoutput>#obj_translater.get_translate('table_th_expertise_taught')#</cfoutput></strong>
							</td>
						</tr>
						<cfoutput query="get_expertise_business_solo">
							<tr class="tr_expertise_#expertise_business_id#">
								<td>#keyword_name#</td>
								<td>
									<cfif expertise_business_practical_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_practical_duration# <cfif expertise_business_practical_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
								</td>
								<td>
									<cfif expertise_business_teaching_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_teaching_duration# <cfif expertise_business_teaching_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
								</td>
							</tr>
						</cfoutput>
					
					</table> 
				</cfif>

				<cfif get_certif_solo.recordcount neq "0">
					<table class="table table_certif">
						<tr class="bg-light text-dark">
							<td colspan="2">
								<strong><cfoutput>#obj_translater.get_translate('table_th_exam_preparation')#</cfoutput></strong>
							</td>
						</tr>
						<cfoutput query="get_certif_solo">
						<tr>
							<cfif get_certif_solo.user_id neq "">
								<td>#certif_name#</td>
							</cfif>
							
						</tr>
						</cfoutput>
					</table>  
				</cfif>

				<cfif get_function_solo.recordcount neq "0">   
					<table class="table table_teaching">
						<tr class="bg-light text-dark">
							<td>
								<strong><cfoutput>#obj_translater.get_translate('table_th_business')#</cfoutput></strong>
							</td>
						</tr>
						<tr>
							<td>                                                 
								<cfoutput>
								<cfloop query="get_function_solo">
									<span class="badge badge-pill bg-white border p-2 mb-2 badge-light font-weight-normal">#keyword_name#</span>
								</cfloop>
								</cfoutput>
							</td>
						</tr>
					</table>  
				</cfif>

				<cfif get_interest_solo.recordcount neq "0">      
					<table class="table table_teaching">
						<tr class="bg-light text-dark">
							<td>
								<strong><cfoutput>#obj_translater.get_translate('table_th_interests')#</cfoutput></strong>
							</td>
						</tr>
						<tr>
							<td>                                             
								<cfoutput>
								<cfloop query="get_interest_solo">
									<span class="badge badge-pill bg-white border p-2 mb-2 badge-light font-weight-normal">#keyword_name#</span>
								</cfloop>
								</cfoutput>
							</td>
						</tr>
					</table> 
				</cfif>
				
			</div>
		</div>

		</cfif>

		<div class="card border">
			<div class="card-body">

				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-graduation-cap fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('table_th_education')#</cfoutput></h5>
					<hr class="border-top border-red mb-3 mt-2">
				</div>

				
				<cfif get_cursus_solo.recordcount neq "0">
					<table class="table table-sm mt-3">
						<cfoutput>
						<cfloop query="get_cursus_solo">
						<tr>
							<td width="30%" class="bg-light">
								<label>
									<cfset listmonths = evaluate("SESSION.LISTMONTHS_SHORT_#SESSION.LANG_CODE#")>
									#ListGetAt(listmonths,dateformat(get_cursus_solo.cursus_start,'mm'))# #year(get_cursus_solo.cursus_start)# > 
									#ListGetAt(listmonths,dateformat(get_cursus_solo.cursus_end,'mm'))# #year(get_cursus_solo.cursus_end)#
								</label>
							</td>
							<td bgcolor="##FFFFFF">
								<strong>#get_cursus_solo.cursus_title#</strong><br>
								#replacenocase(get_cursus_solo.cursus_description,chr(10),"<br>","ALL")#
							</td>
						</tr>				
						</cfloop>
						</cfoutput>
					</table>
				</cfif>
				
			</div>
		</div>

				


		
			 

			

		
	</div>
	
	<div class="col-md-6">
		<div class="card bg-light p-2">
		<cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/video.mp4")>
			<cfoutput>
			<video controls preload class="m-0" width="100%" height="250" <cfif fileexists("#SESSION.BO_ROOT#/assets/user/#p_id#/photo_video.jpg")>poster="./assets/user/#p_id#/photo_video.jpg"</cfif>>
				<source src="#SESSION.BO_ROOT_URL#/assets/user/#p_id#/video.mp4" type="video/mp4">
					<!--- <p> --->
					<!--- <cfset user_id = get_trainer_go.user_id> --->
					<!--- <cfset arr = ['SESSION.BO_ROOT_URL', 'user_id']> --->
					<!--- <cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})> --->
					<!--- #obj_translater.get_translate_complex(id_translate="download_trainer_video", argv="#argv#")#</p> --->
			</video>
			</cfoutput>
		<cfelse>
			<div align="center" class="mt-4">
				<h2 class="text-muted"><i class="fal fa-stopwatch fa-3x"></i></h2>																							
				<cfoutput>#obj_translater.get_translate('coming_soon')#</cfoutput>
			</div>
		</cfif>
		
		<br><br>
		
		<table class="table table-sm table-borderless">
			<tr align="center">
				<td width="33%"><i class="fa-thin fa-users fa-2x text-red"></i></td>
				<td width="33%"><i class="fa-thin fa-chalkboard-teacher fa-2x text-red"></i></td>
				<!---<td width="33%"><i class="fal fa-history fa-2x text-info"></i></td>--->
				<td width="33%"><i class="fa-thin fa-star fa-2x text-red"></i></td>
			</tr>
			<tr align="center">
				<td><cfoutput>#get_learner.nb+user_add_learner#<br>#obj_translater.get_translate('table_th_learners')#</cfoutput></td>
				<td><cfoutput>#get_lesson.nb+user_add_course#<br>#obj_translater.get_translate('lessons')#</cfoutput></td>
				<!---<td>#obj_translater.get_translate('table_th_since')#<br><cfif user_create neq "">#year(user_create)#<cfelse>NC</cfif></td>--->
				<td><cfoutput><cfif get_rating.sum_rating gte 1>#numberformat(get_rating.avg_rating,'_._')#<br>#get_rating.sum_rating# vote<cfif get_rating.sum_rating gt 1>(s)</cfif><cfelse>-</cfif></cfoutput></td>
			</tr>
		</table>
		
		<cfoutput>
		<cfloop query="get_about_solo">
		<br><strong>#quest#</strong><br>
		#user_about_desc#
		</cfloop>
		</cfoutput>

		<cfoutput>
		<cfloop query="get_paragraph_solo">
		<p>
		#user_about_desc#
		</p>
		</cfloop>
		</cfoutput>
		</div>





		<div class="card border">
			<div class="card-body">

				<div class="w-100">
					<h5 class="d-inline"><i class="fa-thin fa-address-card fa-lg mr-1 text-red"></i> <cfoutput>#obj_translater.get_translate('table_th_experience')#</cfoutput></h5>
					<hr class="border-top border-red mb-3 mt-2">
				</div>

				<cfif get_experience_solo.recordcount neq "0">
				<cfoutput>
					<table class="table table-sm mt-3">
						<cfloop query="get_experience_solo">
						<tr>
							<td width="30%" class="bg-light">
								<label>
								<cfset listmonths = evaluate("SESSION.LISTMONTHS_SHORT_#SESSION.LANG_CODE#")>
									#ListGetAt(listmonths,dateformat(get_experience_solo.experience_start,'mm'))# #year(get_experience_solo.experience_start)#
								<cfif get_experience_solo.experience_today eq "1">
									- #obj_translater.get_translate("today")#
								<cfelse>
									> #listgetat(listmonths,month(experience_end))# #year(experience_end)#		
								</cfif>
								</label>
							</td>
							<td bgcolor="##FFFFFF">
								<strong>#get_experience_solo.experience_title#</strong><br>
								<p class="my-1">[#get_experience_solo.experience_localisation#]</p>
								<p class="my-1">#replacenocase(get_experience_solo.experience_description,chr(10),"<br>","ALL")#</p>
							</td>
						</tr>	
						</cfloop>
					</table>
				</cfoutput>
				</cfif>
				
			</div>
		</div>



	</div>





	
</div>


<cfif isdefined("display_back") AND isdefined("t_id") AND isdefined("u_id")>
	<script>
	$(document).ready(function() {
	
		<cfoutput>
		$('.btn_back').click(function(event) {	
			$('##modal_body_xl').load("modal_window_tptrainer.cfm?t_id=#t_id#&u_id=#u_id#");

		})
		</cfoutput>

		$('.btn_choose_trainer').click(function(event) {	
			
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var p_id = idtemp[1];	
			
			<cfoutput>
			if(confirm("#encodeForJavaScript(obj_translater.get_translate('js_choose_trainer_confirm'))#"))
			{
				$.ajax({				  
					url: 'api/tp/tp_post.cfc?method=updt_tptrainer_add',
					type: 'POST',
					data : "t_id=#t_id#&u_id=#u_id#&p_id="+p_id, 
					datatype : "html", 
					success : function(result, status){ 
						console.log(result); 
						window.location.reload(true);
					}, 
					error : function(result, status, error){ 
						/*console.log(resultat);*/ 
					}, 
					complete : function(result, status){ 
						/*console.log(resultat);*/ 
					}	 
				});
			}
			</cfoutput>
			
		});


	})
	</script>
</cfif>