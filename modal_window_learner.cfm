<cfparam name="tm" default="0">
<cfsilent>
	
	<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
	SELECT account_id, account_name
	FROM account 
	ORDER BY account_name
	</cfquery>

	<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
	SELECT user_status_id, UCASE(user_status_name_fr) AS user_status_name FROM user_status
	</cfquery>
	
	<cfquery name="get_profile" datasource="#SESSION.BDDSOURCE#">
	SELECT profile_id, UCASE(profile_name) as profile_name, profile_description FROM user_profile WHERE profile_id = 3 OR profile_id = 7 OR profile_id = 9 OR profile_id = 10
	</cfquery>

	<cfquery name="get_profile_all" datasource="#SESSION.BDDSOURCE#">
	SELECT profile_id, UCASE(profile_name) as profile_name, profile_description FROM user_profile WHERE profile_id IN (3,7,9,8,10,11,13) ORDER BY field(profile_id,3,7,9,10,8,11,13) 
	</cfquery>
	
	<cfquery name="get_user_type" datasource="#SESSION.BDDSOURCE#">
	SELECT user_type_id, user_type_name_#SESSION.LANG_CODE# as user_type_name, user_type_description FROM user_type WHERE user_type_id > 2
	</cfquery>

	<cfif isdefined("a_id")>
		<cfquery name="get_this_account" datasource="#SESSION.BDDSOURCE#">
		SELECT a.account_id, a.account_name,ap.provider_id, ap.provider_code as provider_code, a.account_pt_mandatory
		FROM account a 
		left join account_provider ap on ap.provider_id = a.provider_id
		where a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
		LIMIT 1
		</cfquery>
	
		<cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
			SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name 
			FROM settings_country 
			WHERE country_alpha = "#get_this_account.provider_code#" LIMIT 1
		</cfquery>
	<cfelse>
		<cfquery name="get_country_phone" datasource="#SESSION.BDDSOURCE#">
			SELECT country_code, country_alpha, phone_code, country_name_#SESSION.LANG_CODE# as country_name 
			FROM settings_country 
			WHERE country_alpha = "#SESSION.LANG_CODE eq "en" ? "gb" : SESSION.LANG_CODE#" LIMIT 1
		</cfquery>
	</cfif>


	
	<cfset phone_code_init = "">
	<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
		<cfscript>
			if ( lg neq "en") {
				phone_code_init=ListAppend(phone_code_init,'"#lg#"',",");
			} else {
				phone_code_init=ListAppend(phone_code_init,'"gb"',",");
			}
		</cfscript>
	</cfloop>
	</cfsilent>
		
	
	<cfif isdefined("create") AND listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
		<cfform id="user_create">

			<table class="table table-sm">
				<tr>
					<td colspan="3" bgcolor="#ECECEC"><strong>User</strong></td>
				</tr>
			
				<tr>
					<td class="bg-light" width="30%">
					<label>Profile(s) User*</label>
					</td>
					<td colspan="2">
						<cfoutput query="get_profile_all">
							<cfif tm eq 1>
								<label><input type="checkbox" name="profile_cor_id" value="#profile_id#" <cfif profile_id eq "8">checked</cfif>> #profile_name#</label>
							<cfelse>
								<label><input type="checkbox" name="profile_cor_id" value="#profile_id#" <cfif profile_id eq "3">checked</cfif>> #profile_name#</label>
							</cfif>
						</cfoutput>
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="20%"><label>Status*</label></td>
					<td colspan="2">
						<select name="user_status_id" class="form-control">
							<cfoutput query="get_user_status">
							<option value="#user_status_id#" <cfif user_status_id eq "2">selected</cfif>>#user_status_name#</option>
							</cfoutput>
						</select>
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="20%"><label>Ranking User*</label></td>
					<td colspan="2">
						<cfif tm eq 1>
							<cfselect name="user_type_id" class="form-control" query="get_user_type" display="user_type_name" value="user_type_id" selected="4"></cfselect>
						<cfelse>
							<cfselect name="user_type_id" class="form-control" query="get_user_type" display="user_type_name" value="user_type_id" selected="3"></cfselect>
						</cfif>
					</td>
				</tr>
				
				<tr>
					<td class="bg-light" width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_lms_language')#</cfoutput>*</label></td>
					<td colspan="2">
						<select name="user_lang" class="form-control">
						<cfoutput>
							<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
								<option value="#cor#" <cfif (cor eq "fr" AND isdefined("get_this_account") AND get_this_account.provider_id NEQ 2) OR (cor eq "de" AND isdefined("get_this_account") AND get_this_account.provider_id EQ 2)>selected</cfif>>#ucase(cor)#</option>
							</cfloop>
						</cfoutput>
						</select>
					</td>
				</tr>
					
				<tr>
					<td colspan="3" bgcolor="#ECECEC"><strong>Coordonn&eacute;es</strong></td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Civilit&eacute;*</label>
					</td>
					<td colspan="2">
						<label><input name="user_gender" type="radio" value="M." checked> M.</label>&nbsp;&nbsp;&nbsp;
						<label><input name="user_gender" type="radio" value="Mme"> Mme</label>
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Pr&eacute;nom*</label>
					</td>
					<td colspan="2">
					<input type="text" class="form-control" name="user_firstname" required="yes" placeholder="Pr&eacute;nom">
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Nom*</label>
					</td>
					<td colspan="2">
					<input type="text" class="form-control" name="user_lastname" required="yes" placeholder="Nom">
					</td>
				</tr>
				
		<!--- 		<tr>
					<td class="bg-light" width="30%">
					<label>Compte*</label>
					</td>
					<td colspan="2">
						<select name="account_id" id="account_id" class="form-control">
						<cfoutput query="get_account">
						<option value="#account_id#" 
						<cfif isdefined("a_id") AND account_id eq a_id>selected<cfelse><cfif account_id eq "47">selected</cfif></cfif>>#account_name#</option>
						</cfoutput>
						</select>
					</td>
				</tr> --->
				<tr>
					<td class="bg-light" width="30%">
						<label>Compte*</label>
					</td>
					<td colspan="2">
						<select name="account_id" id="account_id" class="form-control">
							<cfoutput query="get_account">
								<cfif isDefined("a_id") AND account_id eq a_id>
									<option value="#account_id#" selected>#account_name#</option>
								<cfelse>
									<option value="#account_id#">#account_name#</option>
								</cfif>
							</cfoutput>
						</select>
					</td>
				</tr>
				
				<tr>

					<td class="bg-light" width="30%">
					<label>T&eacute;l&eacute;phone 1</label>
					</td>
					<td colspan="2">
		
					<input id="user_phone" type="tel" name="user_phone" />
					<input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />

				</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>T&eacute;l&eacute;phone 2</label>
					</td>
					<td colspan="2">
			
					<input id="user_phone_2" type="tel" name="user_phone_2" />
					<input id="user_phone_2_code" type="hidden" name="user_phone_2_code" value="<cfoutput>#get_country_phone.phone_code#</cfoutput>" />
					</td>
				</tr>
				<tr>
					<td colspan="3" bgcolor="#ECECEC"><strong>Identifiants de connexion</strong></td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Email (connexion)*</label>
					</td>
					<td colspan="2">
					<input type="text" class="form-control" name="user_email" required="yes" placeholder="Email principal">
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Email secondaire</label>
					</td>
					<td colspan="2">
					<input type="text" class="form-control" name="user_email_2" placeholder="Email secondaire">
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%">
					<label>Mot de passe <em>(temporaire)</em></label>
					</td>
					<td colspan="2">
					<cfset temp = RandRange(100000, 999999)>
					<input type="text" class="form-control" name="user_pwd" required="yes" value="<cfoutput>#temp#</cfoutput>">
					</td>
				</tr>
				<tr>
					<td class="bg-light" width="30%"><label>PT Mandatory</label></td>
					<td colspan="3"><input type="checkbox" name="user_pt_mandatory" value="1" <cfif isdefined("get_this_account") AND get_this_account.account_pt_mandatory eq "1">checked</cfif>></td>
				</tr>
				<!--- <tr>
					<td class="bg-light" width="30%"><label>Create ToDo</label></td>
					<td colspan="2"><input type="checkbox" name="user_create_todo" value="1"></td>
				</tr> --->
		
			</table>
			<!---<input type="hidden" name="updt_steps" value="1">--->
			<input type="hidden" name="ins_learner" value="1">
			<div align="center"><input type="submit" class="btn btn-outline-info" value="Cr&eacute;er user"></div>
		</cfform>
	
			
	<script>
	$(document).ready(function() {
		
		$('#user_create').submit(function(event) {
			event.preventDefault();
			if($('#account_id').val() == "0")
			{
				alert("Selectionnez un compte SVP.");
				return false;
			};

			$.ajax({				 
				url: './api/users/user_post.cfc?method=insert_user',
				type: 'POST',
				data: $(event.target).serialize(),
				success : function(result, status){
					var obj_result = jQuery.parseJSON(result);

					<cfif isDefined("from_order")>
						sessionStorage.setItem("new_order_learner", result);
						$('#window_item_lg').modal('hide');
						$('#modal_body_lg').empty();
					<cfelse>
						console.log(obj_result.user_id);
						if (obj_result.state == "already") {
							alert("User already exists !");
						}
						else if (obj_result.state == "created") {
							window.location.href=("common_learner_account.cfm?u_id=" + obj_result.user_id + "&k=2")
						}
					</cfif>
					
				},
				error : function(result, status, erreur){
				},
				complete : function(result, status){
				}	
			});

		});		
		
	})
		
	</script>
	
	
	<cfelse>
	
		<cfif isdefined("u_id") AND listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>	
			
			<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
				<cfinvokeargument name="u_id" value="#u_id#">
			</cfinvoke>

			<cfquery name="get_user_profile" datasource="#SESSION.BDDSOURCE#">
			SELECT upc.profile_id
			FROM user u
			INNER JOIN user_profile_cor upc ON u.user_id = upc.user_id
			WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
			</cfquery>

			<cfset profile_list = "">
		
			<cfoutput query="get_user_profile">
				<cfset profile_list = listappend(profile_list,profile_id)>
			</cfoutput>
			
			<cfset u_id = get_user.user_id>
			<cfset a_id = get_user.account_id>
			
			<cfset user_lastname = get_user.user_name>
			<cfset user_profile = get_user.profile_name>
			<cfset user_profile_id = get_user.profile_id>
			<cfset user_email = get_user.user_email>
			<cfset user_email_2 = get_user.user_email_2>
			<cfset user_alias = get_user.user_alias>
			<cfset user_firstname = get_user.user_firstname>
			<cfset user_gender = get_user.user_gender>
			<cfset user_phone = get_user.user_phone>
			<cfset user_phone_code = get_user.user_phone_code>
			<cfset user_phone_2 = get_user.user_phone_2>
			<cfset user_phone_2_code = get_user.user_phone_2_code>
			<cfset user_jobtitle = get_user.user_jobtitle>
			
			<cfset user_lang = get_user.user_lang>
			
			<cfset account_name = get_user.account_name>
			<cfset group_name = get_user.group_name>
			<cfset group_id = get_user.group_id>
			<cfset user_account_right_id = get_user.user_account_right_id>
			
			<cfset avail_id = get_user.avail_id>
			<cfset user_based = get_user.user_based>
			<cfset int_id = get_user.interest_id>
			
			<cfset user_needs_course = get_user.user_needs_course>
			<cfset user_needs_trainer = get_user.user_needs_trainer>
			<cfset user_needs_nbtrainer = get_user.user_needs_nbtrainer>
			<cfset user_needs_frequency = get_user.user_needs_frequency>
			<cfset user_needs_learn = get_user.user_needs_learn>
			<cfset user_needs_complement = get_user.user_needs_complement>
			<cfset user_needs_trainer_complement = get_user.user_needs_trainer_complement>
			<cfset user_needs_theme = get_user.user_needs_theme>
			<cfset user_needs_duration = get_user.user_needs_duration>
			
			<cfset user_access_tp = get_user.user_access_tp>
			<cfset user_steps = get_user.user_steps>
			<cfset user_status_id = get_user.user_status_id>

			<cfset user_pt_mandatory = get_user.user_pt_mandatory>
			<!--- <cfset user_type_id = get_user.user_type_id> --->
			
			<cfset user_remind_1d = get_user.user_remind_1d>
			<cfset user_remind_3h = get_user.user_remind_3h>
			<cfset user_remind_15m = get_user.user_remind_15m>	
			<cfset user_remind_missed = get_user.user_remind_missed>
			<cfset user_remind_cancelled = get_user.user_remind_cancelled>
			<cfset user_remind_scheduled = get_user.user_remind_scheduled>
			<cfset user_notification_late_canceled = get_user.user_notification_late_canceled>
			<cfset user_timezone_id = get_user.timezone_id>
			
			<cfset user_remind_sms_15m = get_user.user_remind_sms_15m>
			<cfset user_remind_sms_missed = get_user.user_remind_sms_missed>
			<cfset user_remind_sms_scheduled = get_user.user_remind_sms_scheduled>
			
		<cfelseif listFindNoCase("LEARNER,TEST", SESSION.USER_PROFILE)>
			
			<cfset u_id = SESSION.USER_ID>
			<cfset user_lastname = SESSION.USER_LASTNAME>
			<cfset user_profile = SESSION.USER_PROFILE>
			<cfset user_email = SESSION.USER_EMAIL>
			<cfset user_email_2 = SESSION.USER_EMAIL_2>
			<cfset user_alias = SESSION.USER_ALIAS>
			<cfset user_firstname = SESSION.USER_FIRSTNAME>
			<cfset user_gender = SESSION.USER_GENDER>
			<cfset user_phone = SESSION.USER_PHONE>
			<cfset user_phone_code = SESSION.USER_PHONE_CODE>
			<cfset user_phone_2 = SESSION.USER_PHONE_2>
			<cfset user_phone_2_code = SESSION.USER_PHONE_2_CODE>
			<cfset user_jobtitle = SESSION.USER_JOBTITLE>
			
			<cfset user_lang = SESSION.USER_LANG>
			
			<cfset avail_id = SESSION.AVAIL_ID>
			<cfset user_based = SESSION.USER_BASED>
			<cfset int_id = SESSION.INTEREST_ID>
			
			<cfset user_needs_course = SESSION.USER_NEEDS_COURSE>
			<cfset user_needs_trainer = SESSION.USER_NEEDS_TRAINER>
			<cfset user_needs_nbtrainer = SESSION.USER_NEEDS_NBTRAINER>
			<cfset user_needs_frequency = SESSION.USER_NEEDS_FREQUENCY>
			<cfset user_needs_learn = SESSION.USER_NEEDS_LEARN>
			<cfset user_needs_complement = SESSION.USER_NEEDS_COMPLEMENT>
			<cfset user_needs_trainer_complement = SESSION.USER_NEEDS_TRAINER_COMPLEMENT>
			<cfset user_needs_theme = SESSION.USER_NEEDS_THEME>
			<cfset user_needs_duration = SESSION.USER_NEEDS_DURATION>
			
			<cfset user_access_tp = SESSION.USER_ACCESS_TP>
			<cfset user_steps = SESSION.STEPS>
			<cfset user_status_id = SESSION.USER_STATUS_ID>
			
			<cfset user_pt_mandatory = SESSION.USER_PT_MANDATORY>

			<cfset user_remind_1d = SESSION.USER_REMIND_1D>
			<cfset user_remind_3h = SESSION.USER_REMIND_3H>
			<cfset user_remind_15m = SESSION.USER_REMIND_15M>
			<cfset user_remind_missed = SESSION.USER_REMIND_MISSED>
			<cfset user_remind_cancelled = SESSION.USER_REMIND_CANCELLED>
			<cfset user_remind_scheduled = SESSION.USER_REMIND_SCHEDULED>
			<cfset user_notification_late_canceled = SESSION.USER_NOTIFICATION_LATE_CANCELED>
			<cfset user_timezone_id = SESSION.USER_TIMEZONE_ID>
			
			<cfset user_remind_sms_15m = SESSION.USER_REMIND_SMS_15M>
			<cfset user_remind_sms_missed = SESSION.USER_REMIND_SMS_MISSED>
			<cfset user_remind_sms_scheduled = SESSION.USER_REMIND_SMS_SCHEDULED>
	
		</cfif>
	
		<cfif isdefined("display")>
	
		
		
		
		
		
			<!---------------------------  LEARNER ACCOUNT / GROUP --------------------------->
		
			<cfif display eq "account_group">
	
				<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
				SELECT a.account_id, a.account_name, g.group_id, g.group_name FROM account a
				INNER JOIN account_group g ON a.group_id = g.group_id
				ORDER BY group_name
				</cfquery>
			
				<cfform action="updater_learner.cfm">
	
				<select name="account_id" class="form-control">
				<cfoutput query="get_account" group="group_id">
				<optgroup label="#group_name#">
				<cfoutput>
				<option value="#account_id#" <cfif account_id eq a_id>selected</cfif>>#account_name#</option>
				</cfoutput>
				</optgroup>
				</cfoutput>			
				</select>
				
	
				<cfoutput><input type="hidden" name="u_id" value="#u_id#"></cfoutput>
				<input type="hidden" name="updt_account_group" value="1">
				<input type="hidden" name="updt_learner" value="1">
				<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
				</cfform>
				
				
			
				
			<!--------------------------- AVAIL LEARNER --------------------------->
				
			<cfelseif display eq "avail">
	
				<cfform action="updater_learner.cfm">
	
				<cfset edit_avail = "1">
				<cfinclude template="./widget/wid_user_availability.cfm">
	
				<cfoutput><input type="hidden" name="u_id" value="#u_id#"></cfoutput>
				<input type="hidden" name="updt_avail" value="1">
				<input type="hidden" name="updt_learner" value="1">
				<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
				</cfform>
			
			
			<!--------------------------- STATUT / TYPE LEARNER --------------------------->
			
			<cfelseif display eq "updt_status">
				
				<cfform action="updater_learner.cfm">
				
				<table class="table table-sm">
					<tr>
						<td colspan="2" bgcolor="#ECECEC"><strong>USER</strong></td>
					</tr>
				
					<tr>
						<td class="bg-light" width="30%">
						<label>Profile(s) User*</label>
						</td>
						<td colspan="2"><table class="table table-sm">
							<cfoutput query="get_profile_all">
								<tr>
									<td>
										<label><input type="checkbox" name="profile_cor_id" value="#profile_id#" <cfif listfind(profile_list,profile_id)>checked</cfif>> #profile_name#</option></label>
									</td>
									<td>
										<small>#profile_description#</small>
									</td>
								</tr>
							</cfoutput>
							</table>
						</td>
					</tr>
					<tr>
						<td width="20%"><label>Status</label></td>
						<td>
							<cfselect name="user_status_id" class="form-control" query="get_user_status" display="user_status_name" value="user_status_id" selected="#user_status_id#"></cfselect>
						</td>
					</tr>
					<tr>
						<td width="20%"><label>Ranking User</label></td>
						<td>
							<select name="user_type_id" class="form-control">
							<cfoutput query="get_user_type">
							<option value="#user_type_id#" <cfif user_type_id eq get_user.user_type_id>selected</cfif>>#user_type_name# - #user_type_description#</option>
							</cfoutput>
							</select>
						</td>
					</tr>

					<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

						<cfif group_id eq "" >
							<span style="color: red">!! ERROR please go to the user page and attribute him an account !</span>

						<cfelse>
						<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
							SELECT a.account_id, a.account_name FROM account a
							WHERE a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#group_id#">
						</cfquery>
		
						<cfif listfind(profile_list,'8') OR listfind(profile_list,'13')>
							<cfquery name="get_account_tm" datasource="#SESSION.BDDSOURCE#">
								SELECT a.account_id, a.account_name FROM account a
								WHERE a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" value="#user_account_right_id#">)
							</cfquery>
						

							<tr>
								<td class="bg-light" width="20%"><label>TM ONLY<br>Account gestion</label></td>
								<!--- <td class="bg-light" width="25%"><label>Trainer principal</label></td> --->
								<td width="60%">
								<select id="_new_account_id" class="form-control">
								<option value="0" selected>--Selectionner--</option>
								<cfoutput query="get_account">
								<option value="#account_id#">#account_name#</option>
								</cfoutput>
								</select>
								</td>
								<td width="20%">
									<!--- <i class="fal fa-trash-alt"></i> --->
									<button type="button" class="btn btn-sm btn-outline-info btn_add_account_tm">add</button>
									<!--- <button>add</button> --->
								</td>
							</tr>
							<cfloop query="get_account_tm">
								<tr>
									<td width="20%"><label><cfoutput>#currentrow#</cfoutput></label></td>
									<td>
									<p><cfoutput>#account_name#</cfoutput></p>
									</td>
									<td>
										<button type="button" class="btn btn-sm btn-outline-info btn_remove_tp_trainer" id="del_account_<cfoutput>#account_id#</cfoutput>"><i class="fal fa-trash-alt"></i></button>
										<!--- <button>remove</button> --->
									</td>
								</tr>
							</cfloop>
						</cfif>
					</cfif>
				</cfif>
					
				</table>
				
				<br>
				
				<br>
				<cfoutput><input type="hidden" name="u_id" value="#u_id#"></cfoutput>
				<input type="hidden" name="updt_status" value="1">
				<input type="hidden" name="updt_learner" value="1">
				<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
				</cfform>
				
				
				
				<script>
				$(document).ready(function() {
	
					$('[data-toggle="tooltip"]').tooltip({html: true});
					
				})

				handler_add_account_tm = function add_account_tm(){
					event.preventDefault();

					var _a_id = $('#_new_account_id').val();
					console.log(_a_id)
					
					$.ajax({
						url : 'api/users/user_post.cfc?method=updt_tmaccount_add',
						type : 'POST',
						data : {
							u_id:<cfoutput>#u_id#</cfoutput>,
							a_id:_a_id
						},				
						success : function(result, status) {
							// console.log(result)
							$('#window_item_lg').modal({keyboard: true});
							$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_account_edit')#</cfoutput>");		
							$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_status&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
						}
					});
				
				};
				$(".btn_add_account_tm").bind("click",handler_add_account_tm);	


				handler_del_account_tm = function del_account_tm(){
					event.preventDefault();
					var idtemp = $(this).attr("id");
					var idtemp = idtemp.split("_");
					_a_id = idtemp[2];

					console.log(_a_id)
					
					$.ajax({
						url : 'api/users/user_post.cfc?method=updt_tmaccount_add',
						type : 'POST',
						data : {
							u_id:<cfoutput>#u_id#</cfoutput>,
							a_id:_a_id
						},				
						success : function(result, status) {
							$('#window_item_lg').modal({keyboard: true});
							$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_account_edit')#</cfoutput>");		
							$('#modal_body_lg').load("modal_window_learner.cfm?display=updt_status&u_id=<cfoutput>#u_id#</cfoutput>", function() {});
						}
					});
				
				};
				$(".btn_remove_tp_trainer").bind("click",handler_del_account_tm);	
				</script>
				
				
				
				
			<!--------------------------- SETTINGS LEARNER --------------------------->
				
			<cfelseif display eq "updt_settings">
				
				<cfform action="updater_learner.cfm">
				
				<cfoutput>
				<table class="table table-sm">
					<tr>
						<th colspan="4" class="bg-light">
							#ucase(obj_translater.get_translate('table_th_notifications'))#
						</th>
					</tr>
					<tr>
						<td><label>#obj_translater.get_translate('table_th_24h')#</label></td>
						<td><input type="checkbox" name="user_remind_1d" value="1" <cfif user_remind_1d eq "1">checked</cfif>></td>
						<td><label>#obj_translater.get_translate('table_th_scheduled_lesson')#</label></td>
						<td><input type="checkbox" name="user_remind_scheduled" value="1" <cfif user_remind_scheduled eq "1">checked</cfif>></td>
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
					<tr>
						<td colspan="2"><label>#obj_translater.get_translate('table_notif_cancel')#</label></td>
						<td colspan="2"><input type="checkbox" name="user_notification_late_canceled" value="1" <cfif user_notification_late_canceled eq "1">checked</cfif>></td>
					</tr>
					<cfif user_lang eq "fr">
					<tr>
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
					</tr>
					</cfif>
					<tr>
						<th colspan="4" class="bg-light">
							<label>#obj_translater.get_translate('table_th_params')#</label>
						</th>
					</tr>
			
					<tr>
						<td><label>#obj_translater.get_translate('table_th_lms_language')#</label></td>
						<td colspan="3">
						<select name="user_lang" class="form-control">
						<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="cor">
							<option value="#cor#" <cfif user_lang eq cor>selected</cfif>>#ucase(cor)#</option>
						</cfloop>
						</select>					
						</td>
					</tr>
					<tr>
						<td><label>#obj_translater.get_translate('table_th_mini_course_duration')#</label></td>
						<td colspan="3">
							<select name="user_needs_duration" class="form-control">
								<option value="60" <cfif user_needs_duration eq "60">selected</cfif>>60 min</option>
								<option value="45" <cfif user_needs_duration eq "45">selected</cfif>>45 min</option>
								<option value="30" <cfif user_needs_duration eq "30">selected</cfif>>30 min</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label>PT Mandatory</label></td>
						<td colspan="3"><input type="checkbox" name="user_pt_mandatory" value="1" <cfif user_pt_mandatory eq "1">checked</cfif>></td>
					</tr>
				</table>
				</cfoutput>
				
				<br>
				<cfoutput><input type="hidden" name="u_id" value="#u_id#"></cfoutput>
				<input type="hidden" name="updt_settings" value="1">
				<input type="hidden" name="updt_learner" value="1">
				<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
				</cfform>
				
	
				
			<!--------------------------- LEARNER ACCOUNT--------------------------->			
				
			<cfelseif display eq "account">
	
				<cfform action="updater_learner.cfm" enctype="multipart/form-data" method="POST">
	
				<table class="table table-sm">
					<tr>
						<td colspan="2" bgcolor="#ECECEC"><strong>Vos coordonn&eacute;es</strong></td>
					</tr>
					<tr>
						<td width="20%"><label>Civilit&eacute;</label></td>
						<td>
							<label><input name="user_gender" type="radio" value="M." <cfif user_gender eq "M.">checked</cfif> required> M.</label>&nbsp;&nbsp;&nbsp;
							<label><input name="user_gender" type="radio" value="Mme" <cfif user_gender eq "Mme">checked</cfif>> Mme</label>
						</td>
					</tr>
					<tr>
						<td><label>Pr&eacute;nom</label></td>
						<td><input type="text" class="form-control" name="user_firstname" value="<cfoutput>#user_firstname#</cfoutput>" <cfif SESSION.USER_PROFILE eq "learner">disabled</cfif>></td>
					</tr>
					<tr>
						<td><label>Nom</label></td>
						<td><input type="text" class="form-control" name="user_lastname" value="<cfoutput>#user_lastname#</cfoutput>" <cfif SESSION.USER_PROFILE eq "learner">disabled</cfif>></td>
					</tr>
					<tr>
						<td><label>T&eacute;l&eacute;phone</label></td>
						<td>
							
							<input id="user_phone" type="tel" name="user_phone" />
							<input id="user_phone_code" type="hidden" name="user_phone_code" value="<cfif user_phone_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_code#</cfoutput></cfif>" />

						</td>
					</tr>
					<tr>
						<td><label>T&eacute;l&eacute;phone 2</label></td>
						<td>
	
							<input id="user_phone_2" type="tel" name="user_phone_2" />
							<input id="user_phone_2_code" type="hidden" name="user_phone_2_code" value="<cfif user_phone_2_code eq ""><cfoutput>#get_country_phone.phone_code#</cfoutput><cfelse><cfoutput>#user_phone_2_code#</cfoutput></cfif>" />
					
						</td>
					</tr>
					<tr>
						<td>
							<label>Photo</label> <small>(.JPG - 300x300)</small>
						</td>
						<td>
							<input type="file" class="form-control" name="user_file" accept=".jpg" <cfif SESSION.USER_PROFILE eq "learner">disabled</cfif>>
						</td>
					</tr>
					<tr>
						<td colspan="2" bgcolor="#ECECEC"><strong>EMAIL</strong></td>
					</tr>
					<tr>
						<td><label>Email principal (connexion)</label></td>
						<td><cfoutput>#user_email#</cfoutput></td>
					</tr>
					<tr>
						<td><label>Email secondaire</label></td>
						<td><input type="text" class="form-control" name="user_email_2" value="<cfoutput>#user_email_2#</cfoutput>" <cfif SESSION.USER_PROFILE eq "learner">disabled</cfif>></td>
					</tr>
				</table>
				
				<cfoutput><input type="hidden" name="u_id" value="#u_id#"></cfoutput>
				<input type="hidden" name="updt_account" value="1">
				<input type="hidden" name="updt_learner" value="1">		
				<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>" <cfif SESSION.USER_PROFILE eq "learner">disabled</cfif>></div>		
				</cfform>
				
				
			
	
			<cfelseif display eq "profile">
	
	
			</cfif>
	
		</cfif>
	
	
	</cfif>
			<!--- <cfif get_default.recordCount eq 1>.setCountry("<cfoutput>#get_default.country_alpha#</cfoutput>")</cfif> --->
	<script>
	
		$(document).ready(function() {
	
	
			<cfif isDefined("user_phone_code")>
				<cfif user_phone_code neq "">
					<cfquery name="get_default_code" datasource="#SESSION.BDDSOURCE#">
						SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_code#" LIMIT 1
					</cfquery>
				</cfif>
			</cfif>
			
			
			const phoneInputField = document.querySelector("#user_phone");
			const phoneInput = window.intlTelInput(phoneInputField, {
				customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
					return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
				},
				preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
				<cfif isDefined("user_phone_code")><cfif user_phone_code neq "" AND get_default_code.recordCount eq 1>initialCountry: "<cfoutput>#get_default_code.country_alpha#</cfoutput>",</cfif><cfelse><cfif isdefined("a_id")>initialCountry: "<cfoutput>#get_this_account.provider_code#</cfoutput>",</cfif></cfif>
				utilsScript:
				"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
			});
			<cfif isDefined("user_phone")>phoneInput.setNumber("<cfoutput>#user_phone#</cfoutput>");</cfif>
	
			$('#user_phone').on('countrychange', function(e) {
				var countryData = phoneInput.getSelectedCountryData();
				// console.log(countryData);
				var codetmp = countryData.dialCode;
				
				if (countryData.areaCodes) {
					// for (let index = 0; index < countryData.areaCodes.length; index++) {
					// 	const element = countryData.areaCodes[index];
					// 	codetmp += "-" + element;
					// }
					if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
					
				}
	
				$("#user_phone_code").val(codetmp);
			});
	
			<cfif isDefined("user_phone_2_code")>
				<cfif user_phone_2_code neq "">
					<cfquery name="get_default_code_2" datasource="#SESSION.BDDSOURCE#">
						SELECT country_alpha FROM `settings_country` WHERE phone_code LIKE "#user_phone_2_code#" LIMIT 1
					</cfquery>
				</cfif>
			</cfif>
	
			const phoneInputField2 = document.querySelector("#user_phone_2");
			const phoneInput2 = window.intlTelInput(phoneInputField2, {
				customPlaceholder: function(selectedCountryPlaceholder, selectedCountryData) {
					return "<cfoutput>#obj_translater.get_translate('form_placeholder_phone')#</cfoutput>";;
				},
				preferredCountries: [<cfoutput>#phone_code_init#</cfoutput>],
				<cfif isDefined("user_phone_2_code")><cfif user_phone_2_code neq "" AND get_default_code_2.recordCount eq 1>initialCountry: "<cfoutput>#get_default_code_2.country_alpha#</cfoutput>",</cfif><cfelse><cfif isdefined("a_id")>initialCountry: "<cfoutput>#get_this_account.provider_code#</cfoutput>",</cfif></cfif>
				utilsScript:
				"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
			});
			<cfif isDefined("user_phone_2")>phoneInput2.setNumber("<cfoutput>#user_phone_2#</cfoutput>");</cfif>
			
			$('#user_phone_2').on('countrychange', function(e) {
				var countryData = phoneInput2.getSelectedCountryData();
				var codetmp = countryData.dialCode;
				console.log(countryData)
				if (countryData.areaCodes) {
					if (countryData.areaCodes.length == 1) codetmp += "-" + countryData.areaCodes[0];
				}
				
				
				$("#user_phone_2_code").val(codetmp);
			});
	
		})
	</script>
	
	