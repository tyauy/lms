<cfparam name="view" default="full">
<cfset list_lang = "fr,en,de,es,it">

<cfquery name="get_language" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name, formation_code FROM lms_formation WHERE formation_language = 1
</cfquery>

<cfquery name="get_interest" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 1, 0, 0 )#">
SELECT interest_id, interest_name_#SESSION.LANG_CODE# as interest_name FROM user_interest
</cfquery>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#SESSION.LANG_CODE# as skill_objectives FROM lms_skill
</cfquery>

<cfquery name="get_expertise" datasource="#SESSION.BDDSOURCE#">
SELECT expertise_id, expertise_name_#SESSION.LANG_CODE# as expertise_name FROM user_expertise_index
</cfquery>

<cfquery name="get_techno_primary" datasource="#SESSION.BDDSOURCE#">
SELECT techno_id, techno_name_#SESSION.LANG_CODE# as techno_name, techno_icon, techno_active, techno_tooltip FROM lms_list_techno WHERE techno_active = 1
</cfquery>

<!--- <cfquery name="get_techno_secondary" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT techno_id, techno_name_#SESSION.LANG_CODE# as techno_name, techno_icon, techno_active FROM lms_list_techno WHERE techno_active = 0 --->
<!--- </cfquery> --->

<cfquery name="get_personnality" datasource="#SESSION.BDDSOURCE#">
SELECT perso_id, perso_name_#SESSION.LANG_CODE# as perso_name FROM user_personality_index
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id <> 1 AND keyword_cat_id <> 5 ORDER BY FIELD(keyword_cat_id,3,2,4)
</cfquery>

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

<cfif isdefined("u_id") AND (listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>	
		
		<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
		SELECT u.*, up.profile_name,
		a.account_name, g.group_name
		FROM user u
		INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
		INNER JOIN user_profile up ON upc.profile_id = up.profile_id
		LEFT JOIN account a ON a.account_id = u.account_id
		LEFT JOIN account_group g ON g.group_id = a.group_id
		WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
		GROUP BY u.user_id
		</cfquery>
				
		<cfset avail_id = get_user.avail_id>
		<cfif avail_id eq "">
			<cfset avail_id = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28">
		</cfif>
		<cfset techno_id = get_user.techno_id>
		<cfset int_id = get_user.interest_id>		
		<cfset user_jobtitle = get_user.user_jobtitle>
		<cfset user_needs_course = get_user.user_needs_course>
		<cfset user_needs_frequency = get_user.user_needs_frequency>
		<cfset user_needs_learn = get_user.user_needs_learn>
		<cfset user_needs_complement = get_user.user_needs_complement>
		<cfset user_needs_duration = get_user.user_needs_duration>
		<cfset user_needs_expertise_id = get_user.user_needs_expertise_id>
		<cfset user_needs_speaking_id = get_user.user_needs_speaking_id>
		<!--- <cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement> --->
		<!--- <cfset user_needs_trainer = get_user.user_needs_trainer> --->
		<cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
		
		<cfset user_phone = get_user.user_phone>
		<cfset user_phone_code = get_user.user_phone_code>
		
	<cfelseif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST" OR SESSION.USER_PROFILE eq "TM">
		
		<cfset u_id = SESSION.USER_ID>
	
		<cfif isdefined("SESSION.AVAIL_ID")>
			<cfset avail_id = SESSION.AVAIL_ID>
		<cfelse>
			<cfset avail_id = "">
		</cfif>
		<cfif avail_id eq "">
			<cfset avail_id = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28">
		</cfif>
		
		<cfif isdefined("SESSION.TECHNO_ID")>
			<cfset techno_id = SESSION.TECHNO_ID>
		<cfelse>
			<cfset techno_id = "">
		</cfif>
		
		<cfif isdefined("SESSION.INTEREST_ID")>
			<cfset int_id = SESSION.TECHNO_ID>
		<cfelse>
			<cfset int_id = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_jobtitle = SESSION.USER_JOBTITLE>
		<cfelse>
			<cfset user_jobtitle = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_course = SESSION.USER_NEEDS_COURSE>
		<cfelse>
			<cfset user_needs_course = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_frequency = SESSION.USER_NEEDS_FREQUENCY>
		<cfelse>
			<cfset user_needs_frequency = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_learn = SESSION.USER_NEEDS_LEARN>
		<cfelse>
			<cfset user_needs_learn = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_complement = SESSION.USER_NEEDS_COMPLEMENT>
		<cfelse>
			<cfset user_needs_complement = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_duration = SESSION.USER_NEEDS_DURATION>
		<cfelse>
			<cfset user_needs_duration = "">
		</cfif>
		
		<cfif user_needs_duration eq "">
			<cfset user_needs_duration = "60">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_expertise_id = SESSION.USER_NEEDS_EXPERTISE_ID>
		<cfelse>
			<cfset user_needs_expertise_id = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_JOBTITLE")>
			<cfset user_needs_speaking_id = SESSION.USER_NEEDS_SPEAKING_ID>
		<cfelse>
			<cfset user_needs_speaking_id = "">
		</cfif>
		
		<cfif isdefined("SESSION.USER_NEEDS_NBTRAINER")>
			<cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER>
		<cfelse>
			<cfset user_needs_nbtrainer = "">
		</cfif>
		
		<!--- <cfset user_needs_trainer_complement = SESSION.USER_NEEDS_TRAINER_COMPLEMENT> --->
		<!--- <cfset user_needs_trainer = SESSION.USER_NEEDS_TRAINER> --->
		
		
		<cfif SESSION.USER_PROFILE eq "test">
			<cfset user_needs_nbtrainer = 2>
		<cfelse>
			<cfif user_needs_nbtrainer eq "">
				<cfset user_needs_nbtrainer = 1>
			</cfif>
		</cfif>
		<cfset user_phone = SESSION.USER_PHONE>
		<cfset user_phone_code = SESSION.USER_PHONE_CODE>
	</cfif>

<form action="updater_form.cfm" method="post" id="needs_form">

	<div class="row">
					
		<div class="col-md-12">	
				
					<!--- <div class="card-header bg-light border"> --->
						<!--- <button class="btn btn-link" data-toggle="collapse" data-target="#collapse_general" aria-expanded="true" aria-controls="collapse_general"> --->
						<!--- 1 - <cfoutput>#obj_translater.get_translate('table_th_general')#</cfoutput> --->
						<!--- </button> --->
					<!--- </div> --->

					<!--- <div id="collapse_general" class="collapse show" data-parent="#accordion"> --->
					
					<!--- <tr> --->
						<!--- <td class="bg-light" width="15%">Votre langue maternelle</td> --->
						<!--- <td colspan="2"> --->
							<!--- <select class="form-control" name="formation_id"> --->
							<!--- <cfoutput> --->
							<!--- <cfloop query="get_language"> --->
							<!--- <option value="#formation_id#">#language_name#</option> --->
							<!--- </cfloop> --->
							<!--- </cfoutput> --->
							<!--- </select> --->
						<!--- </td> --->
					<!--- </tr> --->
					
					<!--- <tr> --->
						<!--- <td class="bg-light" width="15%"><cfoutput>personnalité (dispo dans le CV des Trainers)</cfoutput></td> --->
						<!--- <td valign="top" colspan="2"> --->
							<!--- <div class="row"> --->
								<!--- <div class="col-md-4"> --->
								<!--- <cfoutput query="get_personnality" startrow="1" maxrows="8"> --->
								<!--- <label><input type="checkbox" name="perso_id" value="#perso_id#"> #perso_name#</label><br> --->
								<!--- </cfoutput> --->
								<!--- </div> --->
								<!--- <div class="col-md-4"> --->
								<!--- <cfoutput query="get_personnality" startrow="9" maxrows="8"> --->
								<!--- <label><input type="checkbox" name="perso_id" value="#perso_id#"> #perso_name#</label><br> --->
								<!--- </cfoutput> --->
								<!--- </div> --->
								<!--- <div class="col-md-4"> --->
								<!--- <cfoutput query="get_personnality" startrow="17" maxrows="500"> --->
								<!--- <label><input type="checkbox" name="perso_id" value="#perso_id#"> #perso_name#</label><br> --->
								<!--- </cfoutput> --->
								<!--- </div> --->
							<!--- </div> --->
						<!--- </td> --->
					<!--- </tr> --->
				<cfif view eq "full">
				<cfoutput>
				<p>
				#obj_translater.get_translate_complex('start_na_info')#
				</p>						
				</cfoutput>
				</cfif>
				
				<div class="accordion" id="accordion_needs">
				
					<div class="card border border-info">
					
						<div class="card-header">
							
							<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_visio_el" aria-expanded="true" aria-controls="collapse_visio_el">
								<cfoutput>
								<h5 class="my-1 text-info">
								<strong>#obj_translater.get_translate('card_needs')# </strong>
								&nbsp;&nbsp;/&nbsp;&nbsp;
								#obj_translater.get_translate('card_skills_interests')#
								</cfoutput>
								</h5>
							</button>
							
						</div>


						<div id="collapse_visio_el" class="collapse <cfif view eq "light">show</cfif>" data-parent="#accordion_needs">
							<table class="table m-0">
								<cfif view eq "light">
								<tr>
									<td class="bg-light" width="15%">
										<cfoutput>#obj_translater.get_translate('level')# <span style="color:##FF0000">*</span></cfoutput>
									</td>
									<td>
										<cfoutput>
										<label><input type="checkbox" name="level_id" id="level_id" value="A0"> #obj_translater.get_translate('level_a0')#</label><br>
										<label><input type="checkbox" name="level_id" id="level_id" value="A1"> #obj_translater.get_translate('level_a1')#</label><br>
										<label><input type="checkbox" name="level_id" id="level_id" value="A2"> #obj_translater.get_translate('level_a2')#</label><br>
										<label><input type="checkbox" name="level_id" id="level_id" value="B1"> #obj_translater.get_translate('level_b1')#</label><br>
										<label><input type="checkbox" name="level_id" id="level_id" value="B2"> #obj_translater.get_translate('level_b2')#</label><br>
										<label><input type="checkbox" name="level_id" id="level_id" value="C1"> #obj_translater.get_translate('level_c1')#</label>
										</cfoutput>
									</td>
								</tr>
								</cfif>
			
			
								<tr>
									<td class="bg-light" width="15%">
										<cfoutput>#obj_translater.get_translate('table_th_mini_hobbies')# <span style="color:##FF0000">*</span></cfoutput>
									</td>
									<td valign="top">
										<div class="accordion_int" id="accordion_int">
											<cfloop query="get_keyword_cat">
											<div class="card border border-info mb-1">
											
												<div class="card-header">
													
													<cfoutput><button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="##collapse_#keyword_cat_id#"></cfoutput>
														
														<h6 class="my-1 text-info">
														<cfoutput>#keyword_cat_name#</cfoutput>
														</h6>
													</button>
													
												</div>

												<cfoutput><div id="collapse_#keyword_cat_id#" class="collapse <cfif keyword_cat_id eq "1">show</cfif> p-2" data-parent="##accordion_int"></cfoutput>
															
													<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
													SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> ORDER BY keyword_name
													</cfquery>
													
													<cfif get_keyword.recordcount gt 3>
													<div class="row">
														<div class="col-md-4">
														
														<cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
														<label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>							
														</cfoutput>
														</div>
														
														<div class="col-md-4">
														<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
														<label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
														</cfoutput>
														</div>
														
														<div class="col-md-4">
														<cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
														<label><input type="checkbox" name="interest_id" id="interest_id" class="interest_id" value="#keyword_id#" <cfif listfind(int_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
														</cfoutput>
														</div>
														
													</div>
													</cfif>
												
												</div>
												
												
											</div>
											</cfloop>
										</div>
											
									</td>
									
								</tr>
								<tr>
									<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_mini_needs')# <span style="color:##FF0000">*</span></cfoutput></td>
									<td valign="top">
										<div class="row">

											<div class="col-md-6">
											<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
											<label><input type="checkbox" name="user_needs_learn" id="user_needs_learn" value="#skill_id#" <cfif listfind(user_needs_learn,skill_id)>checked</cfif>> #skill_objectives#</label><br>							
											</cfoutput>
											</div>
											
											<div class="col-md-6">
											<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
											<label><input type="checkbox" name="user_needs_learn" id="user_needs_learn" value="#skill_id#" <cfif listfind(user_needs_learn,skill_id)>checked</cfif>> #skill_objectives#</label><br>				
											</cfoutput>
											</div>
											
										</div>
										
									</td>
								</tr>
								<!---<tr>
									<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_certification')#</cfoutput></td>
									<td valign="top">
										<div class="row">
											<div class="col-md-6">
											<cfoutput query="get_expertise" startrow="1" maxrows="4">
											<label><input type="checkbox" name="expertise_id" id="expertise_id" value="#expertise_id#" <cfif listfind(user_needs_expertise_id,expertise_id)>checked</cfif>> #expertise_name#</label><br>
											</cfoutput>
											</div>
											<div class="col-md-6">
											<cfoutput query="get_expertise" startrow="5" maxrows="4">
											<label><input type="checkbox" name="expertise_id" id="expertise_id" value="#expertise_id#" <cfif listfind(user_needs_expertise_id,expertise_id)>checked</cfif>> #expertise_name#</label><br>
											</cfoutput>
											</div>
										</div>
									</td>
								</tr>--->
								<tr>
									<td colspan="2">
									<small><span style="color:#FF0000">* <cfoutput>#obj_translater.get_translate('tooltip_required_field')#</cfoutput></small></span>
									</td>
								</tr>
							</table>
						</div>
						
					</div>
						
					<cfif view eq "full">
					<div class="card border border-info">
						
						<div class="card-header">
							<button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_visio" aria-expanded="true" aria-controls="collapse_visio">
								<h5 class="my-1 text-info">
								<cfoutput>
								<strong>#obj_translater.get_translate('table_th_mini_needs')#</strong>
								&nbsp;&nbsp;/&nbsp;&nbsp;
								#obj_translater.get_translate('card_visio_settings')#
								</cfoutput>
								</h5>
							</button>
						</div>
							
						
						<div id="collapse_visio" class="collapse" data-parent="#accordion_needs">
							<table class="table m-0">

							<tr>
								<td class="bg-light" width="30%">
									<cfoutput>#obj_translater.get_translate('table_th_mini_avail')# </cfoutput> <span style="color:#FF0000">*</span>
									
									<cfoutput><span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('needs_availability')#">?</span></cfoutput>
									
								</td>
								<td colspan="2">
									<cfset edit_avail = "1">
									<cfset remove_day = "6">
									<cfinclude template="./widget/wid_user_availability.cfm">
								</td>
							</tr>

							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_mini_course_freq')#</cfoutput></td>
								<td colspan="2">
									<select name="user_needs_frequency" class="form-control">
										<cfoutput>
										<option value="1" <cfif user_needs_frequency eq "1">selected</cfif>>1 #obj_translater.get_translate('lesson')# / #obj_translater.get_translate('day')#</option>
										<option value="2" <cfif user_needs_frequency eq "2">selected</cfif>>3 #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#</option>
										<option value="3" <cfif user_needs_frequency eq "3">selected</cfif>>2 #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#</option>
										<option value="4" <cfif user_needs_frequency eq "4">selected</cfif>>1 #obj_translater.get_translate('lesson')# / #obj_translater.get_translate('week')#</option>
										</cfoutput>
									</select>
								</td>
							</tr>
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_mini_course_duration')#</cfoutput> 
								<cfoutput><span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('needs_course_duration')#">?</span></cfoutput>
								
								<td colspan="2">
									<select name="user_needs_duration" class="form-control">
										<option value="15" <cfif user_needs_duration eq "15">selected</cfif><cfif SESSION.USER_PROFILE eq "test">disabled</cfif>>15 min</option>
										<option value="30" <cfif user_needs_duration eq "30">selected</cfif><cfif SESSION.USER_PROFILE eq "test">disabled</cfif>>30 min</option>
										<option value="45" <cfif user_needs_duration eq "45" OR SESSION.USER_PROFILE eq "test">selected</cfif>>45 min</option>
										<option value="60" <cfif user_needs_duration eq "60">selected</cfif><cfif SESSION.USER_PROFILE eq "test">disabled</cfif>>60 min</option>
										<option value="75" <cfif user_needs_duration eq "75">selected</cfif><cfif SESSION.USER_PROFILE eq "test">disabled</cfif>>75 min</option>
										<option value="90" <cfif user_needs_duration eq "90">selected</cfif><cfif SESSION.USER_PROFILE eq "test">disabled</cfif>>90 min</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_mini_job')#</cfoutput></td>
								<td colspan="2">
									<input class="form-control" type="text" name="user_jobtitle" value="<cfoutput>#user_jobtitle#</cfoutput>" placeholder="<cfoutput>#obj_translater.get_translate('form_placeholder_jobtitle')#</cfoutput>">
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_phone')#</cfoutput></td>
								<td valign="top" colspan="2">
									<!--- <input type="text" class="form-control" name="user_phone" required="yes" value="<cfoutput>#user_phone#</cfoutput>"> --->
									<input id="user_phone" type="tel" name="user_phone" />
									<input id="user_phone_code" type="hidden" name="user_phone_code"  value="<cfif user_phone_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_code#</cfoutput></cfif>" />
								</td>
							</tr>
							
							<!---<tr>
								<td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_techno')#</cfoutput></td>
								<td valign="top" colspan="2">
									<div class="row">
										<div class="col-md-6">
										<cfoutput query="get_techno_primary">
										<label><input type="radio" name="techno_id" id="techno_id" value="#techno_id#" <cfif listfind(techno_id,get_techno_primary.techno_id)>checked</cfif> onclick="return false;"> <!---<i class="#techno_icon# fa-lg text-primary"></i> --->#techno_name#</label>  <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate_complex('#techno_tooltip#')#">?</span>
										<br>				
										</cfoutput>
										</div>
									</div>
								</td>
							</tr>--->
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('needs_trainer_speaks')#<br><small>#obj_translater.get_translate('needs_txt_advise')#</cfoutput></small></td>
								<td colspan="2">
									<cfoutput>
									<cfloop list="1,2,3,4" index="cor">
									<cfif isdefined("f_id")>
										<cfif cor neq f_id>
										<label><input type="radio" name="speaking_id" value="#cor#" <cfif listlen(user_needs_speaking_id) neq "" AND listfind(user_needs_speaking_id,cor)>checked</cfif>> <span class="lang-sm lang-lbl" lang="#listgetat(list_lang,cor)#"></span></label>&nbsp;&nbsp;&nbsp;
										</cfif>
									<cfelse>
										<label><input type="radio" name="speaking_id" value="#cor#" <cfif listlen(user_needs_speaking_id) neq "" AND listfind(user_needs_speaking_id,cor)>checked</cfif>> <span class="lang-sm lang-lbl" lang="#listgetat(list_lang,cor)#"></span></label>&nbsp;&nbsp;&nbsp;
									</cfif>
									</cfloop>
									</cfoutput>
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_mini_trainer_nb')#</cfoutput></small></td>
								<td colspan="2">
									<label><input type="radio" required="yes" name="user_needs_nbtrainer" value="1" <cfif user_needs_nbtrainer eq "1">checked</cfif><cfif SESSION.USER_PROFILE eq "Test">disabled</cfif>> <cfoutput>#obj_translater.get_translate('needs_txt_trainer_mono')#</cfoutput></label><br>
									<label><input type="radio" required="yes" name="user_needs_nbtrainer" value="2" <cfif user_needs_nbtrainer eq "2">checked</cfif>> <cfoutput>#obj_translater.get_translate('needs_txt_trainer_several')#</cfoutput></label>
								</td>
							</tr>
							
							<tr>
								<td class="bg-light" width="30%"><cfoutput>#obj_translater.get_translate('table_th_mini_complement')#</cfoutput></td>
								<td colspan="2">
									<textarea class="form-control" name="user_needs_complement"><cfoutput>#user_needs_complement#</cfoutput></textarea>
								</td>
							</tr>
							
							<tr>
								<td colspan="3">
								<small><span style="color:#FF0000">* <cfoutput>#obj_translater.get_translate('tooltip_required_field')#</cfoutput></small></span>
								</td>
							</tr>
							
						</table>
							
							
						</div>
					</div>
					</cfif>
					
					<div align="center">
					<cfoutput>
					<input type="hidden" name="view" value="#view#">
					<input type="hidden" name="u_id" value="#u_id#">
					</cfoutput>
					<input type="hidden" name="form_type" value="needs_form">
					<button class="btn btn-info" type="submit">
					<i class="fas fa-check"></i> <cfoutput>#obj_translater.get_translate('btn_save')#</cfoutput>
					</button>
					</div>
					
				</div>
			</div>

		
			
		</div>				

		
		
	</div>

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

	$('[data-toggle="tooltip"]').tooltip({html: true});
	
	$("#needs_form").submit(function(){

			var interest = [];
            $.each($("input[id='interest_id']:checked"), function(){
                interest.push($(this).val());
            });
			
			var skill = [];
			$.each($("input[id='user_needs_learn']:checked"), function(){
                skill.push($(this).val());
            });
			
			if(skill.length == 0 || interest.length == 0){
				alert('<cfoutput>#encodeForJavaScript(obj_translater.get_translate('alert_na_select_skills'))#</cfoutput>');
				return false;
			}
			
			<cfif view eq "full">
			var avail = [];
			$.each($("input[name='avail_id']:checked"), function(){
                avail.push($(this).val());
            });
			if(avail.length == 0){
				alert('<cfoutput>#encodeForJavaScript(obj_translater.get_translate('alert_na_select_visio'))#</cfoutput>');
				return false;
			}
			</cfif>
			
			<cfif view eq "light">
			var level = [];
			$.each($("input[name='level_id']:checked"), function(){
                level.push($(this).val());
            });
			if(level.length == 0){
				alert('<cfoutput>#encodeForJavaScript(obj_translater.get_translate('alert_enter_valid_level'))#</cfoutput>');
				return false;
			}
			</cfif>

	});
	
})
</script>

			