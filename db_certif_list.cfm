<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfparam name="ce_id" default="0">
	<cfparam name="certif_id_selected" default="23">
	<cfparam name="type_token" default="free">

	
	<cfquery name="get_certif" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_list_certification WHERE certif_info = 113047 OR certif_id = 51
	</cfquery>
	
	
	<!--- <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
	SELECT lt.*,
	tp.*,
	lc.certif_name, lc.certif_sub_name,
	u.user_id as id, u.user_firstname, u.user_name,
	l.lesson_start,
	ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css
	FROM lms_list_token lt
	INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
	LEFT JOIN lms_tp tp ON tp.token_id = lt.token_id
	LEFT JOIN lms_tpsession s ON s.tp_id = tp.tp_id
	LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
	LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
	LEFT JOIN user u ON u.user_id = tp.user_id
	ORDER BY lc.certif_id
	</cfquery> --->


	<cfif isDefined("ce_id") AND ce_id neq 0>
		<cfquery name="get_selected_token" datasource="#SESSION.BDDSOURCE#">
			SELECT lt.token_id, lt.token_code, lt.token_creation, lt.token_send,
			lc.certif_name, lc.certif_sub_name, lc.certif_id,
			l.lesson_start,
			ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css,
			uany.user_id as user_id_any, uany.user_firstname as user_firstname_any, uany.user_name as user_name_any, uany.user_email as user_email_any,
			aany.account_id as account_id_any, aany.account_name as account_name_any,
			u.user_id, u.user_id as id, u.user_firstname, u.user_name, u.user_email,
			a.account_id, a.account_name
			FROM lms_list_token lt
			INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
			LEFT JOIN lms_tp tp ON tp.token_id = lt.token_id
			LEFT JOIN lms_tpuser tpu ON tp.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
			LEFT JOIN lms_tpsession s ON s.tp_id = tp.tp_id
			LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
			LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
			LEFT JOIN user uany ON uany.user_id = tpu.user_id
			LEFT JOIN account aany ON aany.account_id = uany.account_id
			LEFT JOIN user u ON u.user_id = lt.user_id
			LEFT JOIN account a ON a.account_id = u.account_id
			WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ce_id#">
		</cfquery>

		<cfset certif_id_selected = get_selected_token.certif_id >

	</cfif>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Certification list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			
		<cfif isdefined("e")>
		<div class="alert alert-danger">
		Un utilisateur existe déjà avec l'adresse email saisie. Veuillez le sélectionner directement lors de l'envoi du token.
		</div>		
		</cfif>
		
		<cfif isdefined("k") AND k eq "1">
		<div class="alert alert-success">
		La procédure d'attribution du token s'est correctement réalisée. 
		</div>
		<cfelseif isdefined("k") AND k eq "2">	
		<div class="alert alert-success">
		L'email a été correctement renvoyé.
		</div>		
		</cfif>
		
			<div class="row">
			
				<div class="col-md-3">
					<div class="card border-top border-info">
						<div class="card-body">
							<!--- <h6>REGULAR (LINKED TO TP)</h6> --->
							<div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
								<!--- <cfoutput query="get_certif">
								<cfif not findnocase("anywhere", certif_name)>
									<a class="nav-link <cfif certif_id eq certif_id_selected>active</cfif>" id="tab_#certif_id#" data-toggle="pill" href="##certif_#certif_id#" role="tab" aria-controls="certif_#certif_id#" aria-selected="true">#certif_name#</a>
								</cfif>
								</cfoutput> --->
								
								<h6 class="clearfix mt-3">ANYWHERE</h6>
								<cfoutput query="get_certif">
								<cfif findnocase("anywhere", certif_name) OR findnocase("LTE", certif_name)>
									<a class="nav-link <cfif certif_id eq certif_id_selected>active</cfif>" id="tab_#certif_id#" href="db_certif_list.cfm?certif_id_selected=#certif_id#" >#certif_name#</a>
								</cfif>
								</cfoutput>
							</div>
							
							
							
							<br><br>
							<strong>Admin (R&eacute;sultats + G&eacute;n&eacute;rer code)</strong>
							<br>
							<a href="https://www.metritests.com/metrica/FR171.aspx">https://www.metritests.com/metrica/FR171.aspx</a>
							<br>
							LOGIN: service
							<br>
							PASSWORD: WEFIT123
							<br><br>
							<strong>Super Admin</strong>
							<br>
							<a href="https://www.metritests.com/metrica/FR171.aspx">https://www.metritests.com/metrica/FR171.aspx</a>
							<br>
							LOGIN: sli
							<br>
							PASSWORD: 8Fit75015
							<br><br>
							<strong>Lien pour passage apprenant</strong>
							<br>
							<a href="https://www.metritests.com/metrica">https://www.metritests.com/metrica</a>
							<br>
							ENTRER TOKEN
							
							
						</div>
						
						
					</div>
				</div>
				
				<div class="col-md-9">

					<div class="card border-top border-info">
						<div class="card-body">
								
							<div class="tab-content" id="v-pills-tabContent">
								<cfloop query="get_certif">
									<cfoutput><div class="tab-pane fade <cfif certif_id eq certif_id_selected> show active</cfif>" id="certif_#certif_id#" role="tabpanel" aria-labelledby="tab_#certif_id#"></cfoutput>
									
									<h5><cfoutput>#certif_name#</cfoutput></h5>
									<cfif certif_id eq certif_id_selected>
									<cfif not findnocase("anywhere", certif_name)>
										<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
										SELECT lt.token_id, lt.token_code, lt.token_creation,
										lc.certif_name, lc.certif_sub_name,
										u.user_id, u.user_firstname, u.user_name, u.user_email,
										l.lesson_start,
										ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css,
										a.account_id, a.account_name
										FROM lms_list_token lt
										INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
										LEFT JOIN lms_tp tp ON tp.token_id = lt.token_id
										LEFT JOIN lms_tpsession s ON s.tp_id = tp.tp_id
										LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
										LEFT JOIN lms_lesson_status ls ON ls.status_id = l.status_id
										LEFT JOIN user u ON u.user_id = tp.user_id
										LEFT JOIN account a ON a.account_id = u.account_id
										WHERE lc.certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_certif.certif_id#">
										</cfquery>
										
										<cfquery name="get_count" datasource="#SESSION.BDDSOURCE#">
										SELECT COUNT(lt.token_id) as nb
										FROM lms_list_token lt
										LEFT JOIN lms_tp tp ON tp.token_id = lt.token_id
										WHERE lt.certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_certif.certif_id#"> AND lt.tp_id = 0  AND lt.user_id IS NULL AND lt.token_session_id IS NULL
										</cfquery>
										
										<cfoutput><h4><span class="badge badge-success">#get_count.nb# REMAINING(S)</span></h4></cfoutput>
										
										<table class="table">
											<tr>
												<th>ID</th>
												<th>Token</th>
												<th>User ID</th>
												<th>Apprenant</th>
												<th>Email</th>
												<th>Account</th>
												<th>Lesson</th>
												<th>Date</th>
												<th>Action</th>
											</tr>
											<cfif isDefined("get_selected_token") AND get_certif.certif_id eq certif_id_selected>
												<cfoutput query="get_selected_token">
													<tr bgcolor="##DCDCDC">	
														<td>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
														<td>#token_code#</td>
														<td>#user_id_any#</td>
														<td><a href="common_learner_account.cfm?u_id=#user_id_any#">#user_firstname_any# #ucase(user_name_any)#</a></td>
														<td>#user_email#</td>
														<td><small><strong><cfif account_id_any neq ""><a href="crm_account_edit.cfm?a_id=#account_id_any#">#account_name_any#<cfelse>-</cfif></strong></small></td>
														<td><span class="badge badge-pill badge-#status_css#">#status_name#</span></td>
														<td>#dateformat(lesson_start,'dd/mm/yyyy')#</td>
														<td></td>
													</tr>
												</cfoutput>
											</cfif>
											
											<cfoutput query="get_token">
											<tr>	
												<td>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
												<td>#token_code#</td>
												<td>#user_id#</td>
												<td><a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #ucase(user_name)#</a></td>
												<td>#user_email#</td>
												<td><small><strong><cfif account_id neq ""><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#<cfelse>-</cfif></strong></small></td>
												<td><span class="badge badge-pill badge-#status_css#">#status_name#</span></td>
												<td>#dateformat(lesson_start,'dd/mm/yyyy')#</td>
												<td></td>
											</tr>
											</cfoutput>
										</table>
										
										
									<cfelse>
										<cfquery name="get_token_free" datasource="#SESSION.BDDSOURCE#">
										SELECT lt.*,
										lc.certif_name, lc.certif_sub_name,
										u.user_id as id, u.user_firstname, u.user_name, u.user_email,
										a.account_id, a.account_name
										FROM lms_list_token lt
										INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
										LEFT JOIN user u ON u.user_id = lt.user_id
										LEFT JOIN account a ON a.account_id = u.account_id
										WHERE lc.certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_certif.certif_id#"> 
										AND u.user_id IS NULL
										AND lt.group_id IS NULL
										AND token_id NOT IN (SELECT token_id FROM lms_tp WHERE token_id <> 0)
										AND lt.tp_id = 0 AND lt.user_id IS NULL AND lt.token_session_id IS NULL
										ORDER BY token_send DESC
										</cfquery>
										
										<cfquery name="get_token_attributed" datasource="#SESSION.BDDSOURCE#">
										SELECT lt.*,
										lc.certif_name, lc.certif_sub_name,
										u.user_id as id, u.user_firstname, u.user_name, u.user_email,
										a.account_id, a.account_name
										FROM lms_list_token lt
										INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
										LEFT JOIN user u ON u.user_id = lt.user_id
										LEFT JOIN account a ON a.account_id = u.account_id
										WHERE lc.certif_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_certif.certif_id#"> AND u.user_id IS NOT NULL
										ORDER BY token_send DESC
										</cfquery>
										
										
										<cfoutput><h4><span class="badge badge-success">#get_token_free.recordcount# REMAINING(S)</span></h4></cfoutput>
										
										<a class="btn <cfif type_token eq "free">btn-info<cfelse>btn-outline-info</cfif>" href="<cfoutput>db_certif_list.cfm?certif_id_selected=#get_certif.certif_id#&type_token=free"</cfoutput>" role="tab">Free Codes</a>
										<a class="btn <cfif type_token eq "attributed">btn-info<cfelse>btn-outline-info</cfif>" href="<cfoutput>db_certif_list.cfm?certif_id_selected=#get_certif.certif_id#&type_token=attributed"</cfoutput>" role="tab">Attributed Codes</a>

											<cfif type_token eq "free">
											
												<table class="table">
													<tr>
														<th>ID</th>
														<th>Token</th>
														<th>Candidat</th>
														<th>Account</th>
														<th>Lesson</th>
														<th>Date</th>
														<th>Action</th>
													</tr>
													<cfif isDefined("get_selected_token") AND get_certif.certif_id eq certif_id_selected>
														<cfoutput query="get_selected_token">
															<tr bgcolor="##DCDCDC">	
																<td>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
																<td>#token_code#</td>
																<td><cfif id neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_firstname# #ucase(user_name)#</a><cfelse>-</cfif></td>
																<!--- <td><cfif user_email neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_email#</a><cfelse>-</cfif></td> --->
																<td><small><cfif account_id neq ""><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#<cfelse>-</cfif></small></td>
																<td>#dateformat(token_send,'dd/mm/yyyy')#</td>
																<td>
																	<a href="##" class="btn btn-sm btn-info btn_create_token m-0" id="token_#token_id#">AFFECT CODE<br> + CREER LEARNER</a>
																	<a href="##" class="btn btn-sm btn-info btn_affect_token m-0" id="token_#token_id#">AFFECT CODE<br>ONLY</a>
																</td>
															</tr>
															</cfoutput>
													</cfif>
													<cfoutput query="get_token_free">
													<tr>	
														<td>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
														<td>#token_code#</td>
														<td><cfif id neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_firstname# #ucase(user_name)#</a><cfelse>-</cfif></td>
														<!--- <td><cfif user_email neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_email#</a><cfelse>-</cfif></td> --->
														<td><small><cfif account_id neq ""><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#<cfelse>-</cfif></small></td>
														<td>#dateformat(token_send,'dd/mm/yyyy')#</td>
														<td>
															<a href="##" class="btn btn-sm btn-info btn_create_token m-0" id="token_#token_id#">AFFECT CODE<br> + CREER LEARNER</a>
															<a href="##" class="btn btn-sm btn-info btn_affect_token m-0" id="token_#token_id#">AFFECT CODE<br>ONLY</a>
														</td>
													</tr>
													</cfoutput>
												</table>
											</cfif>

											<cfif type_token eq "attributed">
												<table class="table">
													<tr>
														<th>ID</th>
														<th>Token</th>
														<th>User ID</th>
														<th>Candidat</th>
														<th>Email</th>
														<th>Account</th>
														<th>Date envoi</th>
														<th>Action</th>
													</tr>
													<cfif isDefined("get_selected_token") AND get_certif.certif_id eq certif_id_selected>
														<cfoutput query="get_selected_token">
															<tr bgcolor="##DCDCDC">	
																<td><a name="user_#user_id#"></a>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
																<td>#token_code#</td>
																<td>#user_id#</td>
																<td><cfif id neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_firstname# #ucase(user_name)#</a><cfelse>-</cfif></td>
																<td><cfif user_email neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_email#</a><cfelse>-</cfif></td>
																<td><small><strong><cfif account_id neq ""><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#<cfelse>-</cfif></strong></small></td>
																<td><cfif isDefined("token_send")>#dateformat(token_send,'dd/mm/yyyy')#<cfelse>-</cfif></td>
																<td>
																	<a href="updater_token.cfm?action=send&t_id=#token_id#" class="btn btn-sm btn-success m-0" id="token_#token_id#" target="_blank">RENVOI MAIL CODE</a>
																	<a href="db_updater.cfm?act=del&token_id=#token_id#" class="btn btn-sm btn-danger m-0" id="token_#token_id#">X LIBérer</a>
																</td>
															</tr>
															</cfoutput>
													</cfif>
													<cfoutput query="get_token_attributed">
													<tr>	
														<td><a name="user_#user_id#"></a>#token_id# (#dateformat(token_creation,'mm/yyyy')#)</td>
														<td>#token_code#</td>
														<td>#user_id#</td>
														<td><cfif id neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_firstname# #ucase(user_name)#</a><cfelse>-</cfif></td>
														<td><cfif user_email neq ""><a href="common_learner_account.cfm?u_id=#id#">#user_email#</a><cfelse>-</cfif></td>
														<td><small><strong><cfif account_id neq ""><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#<cfelse>-</cfif></strong></small></td>
														<td><cfif isDefined("token_send")>#dateformat(token_send,'dd/mm/yyyy')#<cfelse>-</cfif></td>
														<td>
															<a href="updater_token.cfm?action=send&t_id=#token_id#" class="btn btn-sm btn-success m-0" id="token_#token_id#" target="_blank">RENVOI MAIL CODE</a>
															<a href="db_updater.cfm?act=del&token_id=#token_id#" class="btn btn-sm btn-danger m-0" id="token_#token_id#">X LIBérer</a>
														</td>
													</tr>
													</cfoutput>
												</table>
											</cfif>


										
										
									</cfif>
									</cfif>
								</div>
								</cfloop>
							</div>
						</div>
					</div>

				</div>
				
			</div>
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$( document ).ready(function() {


	$('.btn_create_token').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Send Token Anywhere");
		$('#modal_body_lg').load("modal_window_token.cfm?action=create&t_id="+t_id, function() {});

	});

	$('.btn_affect_token').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Send Token Anywhere");
		$('#modal_body_lg').load("modal_window_token.cfm?action=affect&t_id="+t_id, function() {});

	});
	
	$('.btn_send_token').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Relance Token Anywhere");
		$('#modal_body_lg').load("modal_window_token.cfm?action=send&t_id="+t_id, function() {});

	});

});
</script>

</body>
</html>