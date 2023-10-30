<cfset obj_lms = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.lms")>
<html>
<body style="width:100%; margin:0px; padding:0px">
<cfoutput>
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<cfif page eq "1">

	<tr>
		<td colspan="3" width="100%" align="center" style="padding:10px 20px 0px 20px">

			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="10" cellspacing="5">
				<tr>
					<td width="120" align="center">
						#obj_lms.get_avatar(user_id="#user_id#",size="120")#
					</td>
					<td>
						<table bgcolor="##ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
								
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_name')#</span>
								</td>
								<td bgcolor="##FFFFFF">
									<h2>#user_firstname#</h2>
								</td>
							</tr>
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_nationality')#</span>
								</td>
								<td bgcolor="##FFFFFF">
									#country_name#
								</td>
							</tr>
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_localisation')#</span>
								</td>
								<td bgcolor="##FFFFFF">
									#user_based#
								</td>
							</tr>
							<cfif method_id neq "">
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_methods')#</span>
								</td>
								<td bgcolor="##FFFFFF">
									<cfloop query="get_method_solo">
									#method_name#
									</cfloop>
								</td>
							</tr>	
							</cfif>
							<cfif get_teaching_solo.recordCount gt 0>
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_teaches')#</span>
								</td>
								<td bgcolor="##FFFFFF">
								
									<cfloop query="get_teaching_solo">
									#get_teaching_solo.formation_name# (
									<cfloop list="#get_teaching_solo.level_id#" index="cor">						
									<cfif cor eq "0">A0
									<cfelseif cor eq "1">A1
									<cfelseif cor eq "2">A2
									<cfelseif cor eq "3">B1
									<cfelseif cor eq "4">B2
									<cfelseif cor eq "5">C1
									<cfelseif cor eq "6">C2
									</cfif>	
									</cfloop>
									)
									<br>
									</cfloop>
								</td>
							</tr>
							</cfif>
							<cfif get_speaking_solo.recordCount gt 0>
							<tr>
								<td width="200">
									<span style="font-size:12px;">#obj_translater.get_translate('table_th_speaks')#</span>
								</td>
								<td bgcolor="##FFFFFF">	
									<cfloop query="get_speaking_solo">
									#get_speaking_solo.formation_name#  (#level_alias#)
									<cfset level_id = get_speaking_solo.level_id>
									
									<br>
									</cfloop>
								</td>
							</tr>
							</cfif>
						</table>


					</td>
				</tr>
			</table>

		</td>
	</tr>

	<tr>
		<td colspan="3" valign="top" style="padding:10px 20px 0px 20px" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;">
			<h3 style="margin:2px">#ucase(obj_translater.get_translate('card_trainer_availability'))#</h3>
			<div style="border-top:1px solid ##000; width:100%; height:1px"></div>

			<cfinvoke component="api/users/user_trainer_get" method="get_trainer_businesshour" returnvariable="get_trainer_businesshour">
				<cfinvokeargument name="u_id" value="#user_id#">
			</cfinvoke>
			<cfset planner_view = "pdf_version">
			<cfinclude template="../widget/wid_planner.cfm">
			
		</td>
	</tr>
	<cfif get_experience_solo.recordcount neq "0">
	<tr>
		<td colspan="3" width="100%" align="center" style="padding:10px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_experience_long'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="13">
				<cfloop query="get_experience_solo">
				<tr>
					<td width="25%" align="left" valign="top">
						#ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_experience_solo.experience_start,'mm'))# #year(get_experience_solo.experience_start)# > 
						<cfif get_experience_solo.experience_today eq "1">
							#obj_translater.get_translate("today")#
						<cfelse>
						#ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_experience_solo.experience_end,'mm'))# #year(get_experience_solo.experience_end)#
						</cfif>
					</td>
					<td width="75%" align="left" valign="top">
						<strong>#get_experience_solo.experience_title#</strong><br>
						<cfif get_experience_solo.experience_localisation neq "">[#get_experience_solo.experience_localisation#]<br></cfif>
						#replacenocase(get_experience_solo.experience_description,chr(10),"<br>","ALL")#
					</td>
				</tr>				
				</cfloop>
			</table>
		</td>
	</tr>
	</cfif>
	<cfif get_cursus_solo.recordcount neq "0">
	<tr>
		<td colspan="3" width="100%" align="center" style="padding:0px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">CURSUS (FORMATION)</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="13">
				<cfloop query="get_cursus_solo">
				<tr>
					<td width="25%" align="left" valign="top">
						#ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_cursus_solo.cursus_start,'mm'))# #year(get_cursus_solo.cursus_start)# > 
						<cfif get_cursus_solo.cursus_today eq "1">
							#obj_translater.get_translate("today")#
						<cfelse>
						#ListGetAt(SESSION.LISTMONTHS_SHORT,dateformat(get_cursus_solo.cursus_end,'mm'))# #year(get_cursus_solo.cursus_end)#
						</cfif>
					</td>
					<td width="75%" align="left" valign="top">
						<strong>#get_cursus_solo.cursus_title#</strong><br>
						<cfif get_cursus_solo.cursus_localisation neq "">[#get_cursus_solo.cursus_localisation#]<br></cfif>
						#replacenocase(get_cursus_solo.cursus_description,chr(10),"<br>","ALL")#
					</td>
				</tr>				
				</cfloop>
			</table>
		</td>
	</tr>
	</cfif>


	<cfelseif page eq "2">



	<tr>
		<td width="50%" align="center" style="padding:5px 20px 0px 20px" valign="top">
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_interests'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left" valign="top" style="padding-top:10px">
						<cfif listlen(interest_id) neq "0">
						<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
						SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
						FROM lms_keyword k 
						INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
						WHERE keyword_id IN (#interest_id#) AND k.keyword_cat_id = 3 ORDER BY k.keyword_cat_id DESC 
						</cfquery>
						<cfloop query="get_keywords">
							<li>#keyword_name#</li>
						</cfloop>
						</cfif>
					</td>
				</tr>						
			</table>

			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:10px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_business'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left" valign="top" style="padding-top:10px">
						<cfif listlen(function_id) neq "0">
						<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
						SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
						FROM lms_keyword k 
						INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
						WHERE keyword_id IN (#function_id#) AND (k.keyword_cat_id = 4 OR k.keyword_cat_id = 5) ORDER BY k.keyword_cat_id DESC 
						</cfquery>
						<cfloop query="get_keywords">
							<li>#keyword_name#</li>
						</cfloop>
						</cfif>
					</td>
				</tr>						
			</table>

		</td>
		<td width="50%" align="center" style="padding:5px 20px 0px 20px" valign="top">

			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_personnality'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left" valign="top" style="padding-top:10px">
						<cfloop query="get_personnality_solo">
							<cfif get_personnality_solo.user_id neq "">
							<li>#perso_name#</li>
							</cfif>
						</cfloop>
					</td>
				</tr>	
			</table>

			<cfif get_expertise_business_solo.recordcount neq "0">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:10px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_expertise'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>			
			<br>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="5" cellspacing="2">		
				<tr bgcolor="##F8F9FA">
					<td>
						<strong>#obj_translater.get_translate('table_th_expertise_business_area')#</strong>
					</td>
					<td>
						<strong>#obj_translater.get_translate('table_th_expertise_practical')#</strong>
					</td>
					<td>
						<strong>#obj_translater.get_translate('table_th_expertise_taught')#</strong>
					</td>
				</tr>
				<cfloop query="get_expertise_business_solo">
					<tr class="tr_expertise_#expertise_business_id#">
						<td>#keyword_name#</td>
						<td>
							<cfif expertise_business_practical_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_practical_duration# <cfif expertise_business_practical_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
						</td>
						<td>
							<cfif expertise_business_teaching_duration neq ""><span class="badge badge-pill bg-white border border-info p-2 font-weight-normal">#expertise_business_teaching_duration# <cfif expertise_business_teaching_duration neq "1">#obj_translater.get_translate('short_years')#<cfelse>#obj_translater.get_translate('short_year')#</cfif> </span><cfelse>-</cfif>
						</td>
					</tr>
				</cfloop>
				
			</table>  
			</cfif>

			<cfif get_certif_solo.recordcount neq "0">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:10px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2" width="100%" align="left" valign="top">
						<h3 style="margin:2px">#ucase(obj_translater.get_translate('table_th_exam_preparation'))#</h3>
						<div style="border-top:1px solid ##000; width:100%"></div>
					</td>
				</tr>
			</table>

			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left" valign="top" style="padding-top:10px">
						<cfloop query="get_certif_solo">
							<cfif get_certif_solo.user_id neq "">
							<li>#certif_name#</li>
							</cfif>
						</cfloop>
					</td>
				</tr>						
			</table>
			</cfif>


		</td>
	</tr>

	</cfif>
	
</table>
</cfoutput>
</body>
</html>
