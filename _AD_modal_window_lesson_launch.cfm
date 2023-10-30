<cfparam name="l_id">

<cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
	<cfinvokeargument name="l_id" value="#l_id#">
	<cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
</cfinvoke>

<cfif get_lesson.lesson_redirect neq "">
	<cfset _lesson_redirect = get_lesson.lesson_redirect>
	<cfset _lesson_redirect_key = get_lesson.lesson_redirect_key>
	<cfset _lesson_techno_name = get_lesson.tech_name>
	<cfset _lesson_techno_icon = get_lesson.techno_icon>
<cfelse>
	<cfset get_lesson_tech = obj_query.oget_lesson_default_tech(u_id="#get_lesson.planner_id#")>
	<cfset _lesson_redirect = get_lesson_tech.lesson_redirect>
	<cfset _lesson_redirect_key = get_lesson_tech.lesson_redirect_key>
	<cfset _lesson_techno_name = get_lesson_tech.tech_name>
	<cfset _lesson_techno_icon = get_lesson_tech.techno_icon>
</cfif>

<cfset p_id = get_lesson.planner_id>

<cfinvoke component="api/users/user_get" method="oget_planner" returnvariable="get_planner">
	<cfinvokeargument name="p_id" value="#p_id#">
</cfinvoke>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
</cfinvoke>


<!--------------------- CLASSICAL LESSON LAUNCH ----------------->

<cfif get_lesson.method_id neq "7">

	<form id="launch_form">
	<cfoutput>


	<div class="d-flex">
		<div class="p-2">
			<div class="card border">
				<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_lesson.sessionmaster_code#.jpg")>			
					<img src="../assets/img_material/#get_lesson.sessionmaster_code#.jpg" class="card-img-top" style="width:250px">
				<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_lesson.sessionmaster_id#.jpg")>			
					<img src="../assets/img_material/#get_lesson.sessionmaster_id#.jpg" class="card-img-top" style="width:250px">
				<cfelse>
					<img src="../assets/img/wefit_lesson.jpg" class="card-img-top" style="width:250px">
				</cfif>
				<div class="card-body">
					<div align="center">
						#get_lesson.sessionmaster_name#
					</div>
				</div>

			</div>
		</div>

		<div class="p-2 w-100">
			<table class="table table-sm w-100 border">		
				<cfif listFindNoCase("TRAINER", SESSION.USER_PROFILE)>	
				<tr>
					<th class="bg-light" width="25%">
						<label>#obj_translater.get_translate('table_th_learner')#</label> 
					</th>
					<td colspan="2">
						<a href="common_learner_account.cfm?u_id=#get_user.user_id#">#get_user.user_firstname# #get_user.user_name#</a>
					</td>
				</tr>
				</cfif>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_trainer')#</label> 
					</th>
					<td colspan="2">
						#obj_lms.get_thumb(user_id="#get_planner.user_id#",size="30")# #UCASE(get_planner.user_firstname)#
					</td>
				</tr>		
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_method')#</label> 
					</th> 
					<td colspan="2">
						#get_lesson.method_name#
					</td>
				</tr>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_date')#</label>
					</th>
					<td colspan="2">
						#obj_function.get_dateformat(get_lesson.lesson_start)# | #TimeFormat(get_lesson.lesson_start, "HH:mm")# - #TimeFormat(get_lesson.lesson_end, "HH:mm")#
					</td>
				</tr>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_duration')#</label>
					</th> 
					<td colspan="2">
						#get_lesson.lesson_duration#min
					</td>
				</tr>
				<cfif _lesson_redirect neq "" AND get_lesson.method_id neq "2">
					<tr>
						<th class="bg-light">
							<label><cfoutput>#obj_translater.get_translate('table_th_techno')#</cfoutput></label>
						</th>
						<td colspan="2">
							<i class="#_lesson_techno_icon#"></i>
							#_lesson_techno_name#
						</td>
					</tr>
				</cfif>
				<cfif _lesson_redirect_key neq "" AND get_lesson.method_id neq "2">
					<tr>
						<th class="bg-light">
							<label><cfoutput>#obj_translater.get_translate('table_th_techno_key')#</cfoutput></label>
						</th>
						<td colspan="2">
							#_lesson_redirect_key#
						</td>
					</tr>
				</cfif>
				
				<!---<tr>
					<th class="bg-light">
						<label><cfoutput>#obj_translater.get_translate('table_th_bookedby')#</cfoutput></label>
					</th>
					<td colspan="2">
						#get_lesson.booker_firstname#		
					</td>
				</tr>--->
				
			</table>

		</div>

	</div>

	
	

	<cfif (get_lesson.method_id neq "10") AND (get_lesson.provider_id eq "" OR get_lesson.provider_id neq 2)>
		<div class="alert bg-light text-dark border mt-3" role="alert">
			<div class="d-flex">
				<!---- PTA SPECIAL TREATMENT ---->
				<cfif get_lesson.sessionmaster_id eq "694">
					Il s'agit de votre dernier cours dans le cadre de votre formation. En signant ci-dessous, vous reconnaissez avoir réalisé l'action de formation dans sa globalité.
				<!---- CLASSIC LESSON ---->
				<cfelse>
					<label><em><cfoutput>#obj_translater.get_translate('table_th_accept_sign')#</cfoutput></em></label>
				</cfif>
			</div>
			<div class="ms-2">
			
				<div id="content" style="border:1px solid ##000000"><div id="signatureparent"><div id="signature"></div></div><div id="tools"></div></div>
			
			</div>
		</div>		
	</cfif>

	<cfif get_lesson.method_id eq "10">
		<div class="alert bg-light text-dark border mt-3" role="alert">
			<div class="d-flex">
				<div>
					<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
				</div>
				<div class="ms-2">
				
				<cfoutput>
				#obj_translater.get_translate('vc_disclaimer_text')#
				<br><br>
				<label class="text-dark"><input type="checkbox" name="accept_policy" id="accept_policy" required> #obj_translater.get_translate('vc_disclaimer_optin')#</label>
				</cfoutput>

				</div>
			</div>
		</div>
	</cfif>

	<input type="hidden" name="token" value="1">
	<input type="hidden" name="ugo" value="#_lesson_redirect#">
	<cfif (get_lesson.method_id neq "10") AND (get_lesson.provider_id eq "" OR get_lesson.provider_id neq 2)>
	<input type="hidden" name="signature_base64" id="signature_base64" value="">
	</cfif>
	<input type="hidden" name="launch" value="1">
	<input type="hidden" name="lesson_id" value="#l_id#">
	<input type="hidden" name="tp_id" value="#get_lesson.tp_id#">


	<cfif get_lesson.status_id eq "1" OR get_lesson.status_id eq "2">
		
		<div align="center">
		
		<!--- <cfif now() gte dateadd("n",-15,get_lesson.lesson_start) AND now() lte dateadd("n",+15,get_lesson.lesson_start)>				 --->
			<input type="submit" class="btn btn-outline-red btn_submit" value="#obj_translater.get_translate('btn_launch_lesson')#">
		<!--- <cfelse>
			<cfset rule_launch = "1">
			<input type="submit" class="btn btn-outline-info disabled" value="#obj_translater.get_translate('btn_launch_lesson')#*">
		</cfif> --->
		
		</div>
		
		<cfif isdefined("rule_launch")>
			
			#obj_translater.get_translate_complex('course_rule_launch')#
			
		</cfif>
		
	</cfif>
		
		
	</cfoutput>
	</form>

	<script>
	$(document).ready(function() {
		
		<cfif (get_lesson.method_id neq "10") AND (get_lesson.provider_id eq "" OR get_lesson.provider_id neq 2)>
		var $sigdiv = $("#signature").jSignature({'UndoButton':true});
		$("#signature").resize();
		
		$('.btn_submit').click(function(event) {
			
			event.preventDefault();
			
			if( $sigdiv.jSignature('getData', 'native').length == 0 && (<cfoutput>#get_lesson.provider_id#</cfoutput> !== 2 || <cfoutput>#get_lesson.method_id#</cfoutput> != 10)) {
				alert('<cfoutput>#obj_translater.get_translate('js_warning_signature')#</cfoutput>');
				return false;
			}
			else
			{
				var data = $sigdiv.jSignature('getData', 'default');
				$('#signature_base64').val(data);

				$.ajax({				 
					url: './components/gateway.cfc?method=updt_lesson',
					type: 'POST',
					data: $('#launch_form').serialize(),
					success : function(result, statut){
						// $('#alert_todo_ok').collapse('show');
						$('#modal_body_lg').empty();
						$('#modal_body_lg').load("_AD_modal_window_lesson_air.cfm?l_id=<cfoutput>#l_id#</cfoutput>");
					},
					error : function(resultat, statut, erreur){
						// alert("pas ok");
					},
					complete : function(resultat, statut){
					}	
				});
			}
		});


		</cfif>

	})	
	</script>

<cfelse>

	<!--------------------- GET TP INFO ----------------->
	<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">
	SELECT *
	FROM lms_tp tp
	INNER JOIN lms_list_certification lc ON lc.certif_id = tp.certif_id 
	WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
	</cfquery>

	<!--------------------- CERTIF LESSON LAUNCH ----------------->
	<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
	SELECT lt.token_code, tp.certif_id, lc.certif_url
	FROM lms_tp tp
	INNER JOIN lms_list_token lt ON lt.token_id = tp.token_id 
	INNER JOIN lms_list_certification lc ON lc.certif_id = tp.certif_id 
	WHERE tp.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_lesson.tp_id#">
	</cfquery>
	

	<form id="launch_form" action="gateway.cfm">
	<cfoutput>
	<table class="table table-sm">			
		<tr>
			<th class="bg-light" width="25%">
				<label>#obj_translater.get_translate('table_th_learner')#</label> 
			</th>
			<td colspan="2">
				<a href="common_learner_account.cfm?u_id=#get_user.user_id#">#get_user.user_firstname# #get_user.user_name#</a>
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>#obj_translater.get_translate('table_th_method')#</label> 
			</th> 
			<td colspan="2">
				#get_lesson.method_name#
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>#obj_translater.get_translate('table_th_date')#</label>
			</th>
			<td colspan="2">
				#dateformat(get_lesson.lesson_start,'dd/mm/yyyy')#
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>#obj_translater.get_translate('table_th_time')#</label>
			</th>
			<td colspan="2">
				#TimeFormat(get_lesson.lesson_start, "HH:mm")# - #TimeFormat(get_lesson.lesson_end, "HH:mm")#
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>#obj_translater.get_translate('table_th_duration')#</label>
			</th> 
			<td colspan="2">
				#get_lesson.lesson_duration#min
			</td>
		</tr>
		<cfif findnocase("bright",get_tp.certif_name)>
		<tr>
			<th class="bg-light">
				<label>URL PLATEFORME CERTIFICATION</label>
			</th>
			<td colspan="2">
				#get_tp.certif_url#
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>IDENTIFIANT BRIGHT</label>
			</th>
			<td colspan="2">
				#get_user.user_email#
			</td>
		</tr>
		<tr>
			<th class="bg-light">
				<label>MOT DE PASSE</label>
			</th>
			<td colspan="2">
				#get_tp.certif_password#
			</td>
		</tr>
		<cfelse>			
		<tr>
			<th class="bg-light">
				<label>CODE / JETON</label>
			</th>
			<td colspan="2">
				<cfif get_token.recordcount neq "0" AND get_token.token_code neq "">
				#get_token.token_code#
				<cfelse>
				Le code est en cours d'attribution. <br>Veuillez contacter notre &eacute;quipe Customer Service.
				</cfif>
			</td>
		</tr>
		</cfif>
		<cfif (get_lesson.method_id neq "10") AND (provider_id eq "" OR provider_id neq 2)>
		<tr>
			<th class="bg-light">
				<label><em><cfoutput>#obj_translater.get_translate('table_th_accept_sign')#</cfoutput></em></label>
			</th> 
			<td colspan="2">
				<div id="content" style="border:1px solid ##000000"><div id="signatureparent"><div id="signature"></div></div><div id="tools"></div></div>
			</td>
		</tr>
		</cfif>
	</table>

	<cfif get_token.certif_id eq "1" or get_token.certif_id eq "21">
	<div class="alert alert-success" align="center">
	
	#obj_translater.get_translate_complex('go_cambridge_with_code')#
	
	</div>
	</cfif>

	<input type="hidden" name="method_id" value="7">
	<cfif findnocase("bright",get_tp.certif_name)>
	<input type="hidden" name="ugo" value="#get_tp.certif_url#">
	<cfelse>
	<input type="hidden" name="ugo" value="#get_token.certif_url#">
	</cfif>
	<input type="hidden" name="launch" value="1">
	<input type="hidden" name="lesson_id" value="#l_id#">	
	<input type="hidden" name="tp_id" value="#get_lesson.tp_id#">

	<div align="center">
		<input type="submit" class="btn btn-outline-red" value="#obj_translater.get_translate('btn_launch_lesson')#">
	</div>
	<!---<cfif get_lesson.status_id eq "1" OR get_lesson.status_id eq "2">
		
		<div align="center">
		
		<cfif now() gte dateadd("n",-15,get_lesson.lesson_start) AND now() lte dateadd("n",+15,get_lesson.lesson_start)>				
			<input type="submit" class="btn btn-outline-info" value="#obj_translater.get_translate('btn_launch_lesson')#">
		<cfelse>
			<cfset rule_launch = "1">
			<input type="submit" class="btn btn-outline-info disabled" value="#obj_translater.get_translate('btn_launch_lesson')#*">
		</cfif>
		
		</div>
		
		<cfif isdefined("rule_launch")>
			<cfif SESSION.LANG_CODE eq "fr">
			<br><small><em>* Vous ne pouvez lancer un cours que 15 minutes avant et jusqu'&agrave; 15 minutes apr&egrave;s le d&eacute;but pr&eacute;vu.</em></small>
			<cfelseif SESSION.LANG_CODE eq "en">
			<br><small><em>* Starting the lesson is only possible 15 min before and 15 min after the expected time.</em></small>
			<cfelseif SESSION.LANG_CODE eq "es">
			<br><small><em>* Vous ne pouvez lancer un cours que 15 minutes avant et jusqu'&agrave; 15 minutes apr&egrave;s le cours.</em></small>
			<cfelseif SESSION.LANG_CODE eq "de">
			<br><small><em>* Die Stunde kann maximal 15 Minuten vor und nach der gebuchten Zeit in Anspruch genommen werden.</em></small>
			<cfelseif SESSION.LANG_CODE eq "it">
			<br><small><em>* Starting the lesson is only possible 15 min before and 15 min after the expected time.</em></small>
			</cfif>
		</cfif>
		
	</cfif>--->
		
		
	</cfoutput>
	</form>

	<script>
	$(document).ready(function() {

		var $sigdiv = $("#signature").jSignature({'UndoButton':true});
		$("#signature").resize();
		
		$("#launch_form").submit(function( event ) {
			
			if( $sigdiv.jSignature('getData', 'native').length == 0 && <cfoutput>#provider_id#</cfoutput> !== 2 ) {
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
	
</cfif>
	
