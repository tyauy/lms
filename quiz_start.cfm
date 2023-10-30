<!DOCTYPE html>
<!--- <cfset cor = listgetat(t,2,"_")> --->

<!--- <cfoutput>#cor#</cfoutput> --->
<cfsilent>

	<cfif t neq "lst">
	
		<cfset cor = listgetat(t,2,"_")>
		
		<cfquery name="get_qpt_all" datasource="#SESSION.BDDSOURCE#">
		SELECT quiz_id, quiz_name, quiz_rank, quiz_alias, quiz_type FROM lms_quiz
		WHERE quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="qpt_#cor#">
		ORDER BY quiz_rank ASC
		</cfquery>

		<cfquery name="get_result_qpt" datasource="#SESSION.BDDSOURCE#">
		SELECT qu.quiz_user_id, qu.quiz_success, q.quiz_id, q.quiz_alias, SUM(qr.ans_gain) as score
		FROM lms_quiz_result qr
		INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
		INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
		WHERE qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="qpt_#cor#">
		GROUP BY qu.quiz_user_id
		ORDER BY quiz_alias
		</cfquery>

		<cfset list_qpt_result = "">
		<cfset list_qpt_success = "">
		<cfset list_qpt_id = "">
		<cfloop query="get_result_qpt">
			<cfset list_qpt_result = listappend(list_qpt_result,score)>
			<cfset list_qpt_success = listappend(list_qpt_success,quiz_success)>
			<cfset list_qpt_id = listappend(list_qpt_id,quiz_id)>
		</cfloop>
	
	<cfelse>
	
		<cfquery name="get_quiz_lst" datasource="#SESSION.BDDSOURCE#">
		SELECT * FROM lms_quiz q WHERE quiz_type = "lst"
		</cfquery>
	
	</cfif>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.card {
	border-radius: 0px 0px 2px 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>


<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
 
		<cfif isdefined("t") AND t eq "lst">
			<cfset title_page = "#obj_translater.get_translate('title_page_quiz_lst')#">
		<cfelseif isdefined("t") AND (t eq "qpt_en" OR t eq "qpt_de" OR t eq "qpt_fr" OR t eq "qpt_es" OR t eq "qpt_it" OR t eq "qpt_pt" OR t eq "qpt_ru" OR t eq "qpt_zh" OR t eq "qpt_nl")>
			<cfset title_page = "#obj_translater.get_translate('title_page_quiz_pt')# - #obj_translater.get_translate('lang_#cor#')#">
		</cfif>		
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
		
			<div class="row">	
			
				<div class="col-lg-10 offset-lg-1 col-md-12">

					<div class="card border-top border-info">
						<div class="card-body">
						
							<cfif isdefined("t") AND t eq "lst">
							<div class="row">
								<div class="col-md-12">		
									<div class="media">
										<img src="./assets/img_material/a265417047adfd29c84ff53a33aedbe0.jpg" class="rounded float-left mr-3" width="220">	
										<div class="media-body">
											<cfoutput>
											<h5 class="mt-0">#obj_translater.get_translate_complex('start_lst_title')#</h5>
											<br>
											#obj_translater.get_translate_complex('start_lst_subtitle')#
											</cfoutput>
											
											
											<div align="center">
											<cfoutput query="get_quiz_lst">					
											
												<cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
												SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
												</cfquery>

													<cfif get_result.recordcount neq "0" AND get_result.quiz_user_end neq "">
														<a href="./quiz_eval.cfm?quiz_user_id=#get_result.quiz_user_id#" class="btn btn btn-success"><cfoutput>#obj_translater.get_translate('btn_results')#</cfoutput> #quiz_name#</a>														
													<cfelseif get_result.recordcount neq "0" AND get_result.quiz_user_end eq "">
														<a href="./quiz.cfm?quiz_user_id=#get_result.quiz_user_id#&f=go" class="btn btn btn-danger"><cfoutput>#obj_translater.get_translate('btn_continue')#</cfoutput> #quiz_name#</a>														
													<cfelse>
														<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#" class="btn btn-primary"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>														
													</cfif>
													
											</cfoutput>
											</div>
										</div>
									</div>
								</div>
							</div>
							<cfelseif isdefined("t") AND isdefined("cor")>
							<div class="row">
								<div class="col-md-12">		
									<div class="media">
										<cfoutput><img src="./assets/img/qpt_#cor#.jpg" class="rounded float-left mr-3" width="220"></cfoutput>
										<div class="media-body">
										
											<!---COMPLEX
											<cfoutput>
											<h5 class="mt-0">#obj_translater.get_translate_complex('start_lst_title')#</h5>
											<br>
											#obj_translater.get_translate_complex('start_lst_subtitle')#
											#obj_translater.get_translate_complex('start_lst_progress')#
											</cfoutput>
											START_RM--->
											<cfif SESSION.LANG_CODE eq "fr">
											<h5 class="mt-0">Test d'&eacute;valuation WEFIT</h5>
											<br>
											<h6>Petit rappel avant de commencer...</h6>									
											<p>
											<ul>
												<li>Les questions sont chronom&eacute;tr&eacute;es.</li>
												<li>Inutile d'essayer de rafra&icirc;chir votre page pour arr&ecirc;ter le chronom&egrave;tre, vous passerez directement &agrave; la question suivante et perdrez une potentielle bonne r&eacute;ponse...</li>
												<!---<li>Votre progression est sauvegard&eacute;e. Vous pouvez arr&ecirc;ter le test &agrave; &agrave; la fin d'une question et le reprendre plus tard. Assurez-vous n&eacute;anmoins d'avoir s&eacute;lectionn&eacute; une r&eacute;ponse sinon celle-ci sera perdue...</li>--->
											</ul>
											</p>
											
											<h6>Votre progression</h6>
											<p>
											Notre test de niveau global a &eacute;t&eacute; con&ccedil;u avec une difficult&eacute; croissante. Vous ne pouvez acc&eacute;der aux tests sup&eacute;rieurs que si vous avez r&eacute;ussi l'&eacute;tape pr&eacute;c&eacute;dente.
											</p>
											<cfelseif SESSION.LANG_CODE eq "en">
											<h5 class="mt-0">Wefit placement test</h5>
											<p>
											<ul>
												<li>The questions are timed. Do not refresh the page during this test.</li>
												<!---<li>Votre progression est sauvegard&eacute;e. Vous pouvez arr&ecirc;ter le test &agrave; &agrave; la fin d'une question et le reprendre plus tard. Assurez-vous n&eacute;anmoins d'avoir s&eacute;lectionn&eacute; une r&eacute;ponse sinon celle-ci sera perdue...</li>--->
											</ul>
											</p>
											<h6>Your progress</h6>
											<p>
											Our placement test was designed with increasing difficulty. You will only be able to get to the next level if you have passed the previous level test.
											</p>
											<cfelseif SESSION.LANG_CODE eq "de">
											<h5 class="mt-0">Mein Einstufungstest</h5>
											<br>
											<h6>Kleine Erinnerung, bevor Sie anfangen...</h6>	
											<p>
											<ul>
												<li>Die Beantwortung der Fragen ist zeitlich begrenzt</li>
												<li>Es ist nicht m&ouml;glich die Zeit zu stoppen. Nach Ablauf des Countdowns werden Sie direkt zur n&auml;chsten Frage weitergeleitet.</li>
												<!---<li>Ihr Fortschritt wird gespeichert. Sie k&ouml;nnen den Test am Ende einer jeden Frage beenden und zu einem sp&auml;teren Zeitpunkt fortsetzen. Eine nicht beantwortete Frage wird als falsch gewertet.</li>--->
											</ul>
											</p>
											<h6>Ihr Fortschritt</h6>
											<p>
											Unser Einstufungstest wurde mit ansteigender Schwierigkeit entwickelt. Sie k&ouml;nnen nur dann auf h&ouml;here Tests zugreifen, wenn Sie den vorherigen Leveltest bestanden habe
											</p>
											<cfelseif SESSION.LANG_CODE eq "es">

											<cfelseif SESSION.LANG_CODE eq "it">

											</cfif>
											<!---END_RM--->
											
											
												
											<div align="center">
											<!---<cfif get_result_qpt.recordcount eq "0">											
												<a href="quiz_start.cfm?t=pt" class="btn btn-sm btn-outline-info"><cfoutput>#obj_translater.get_translate('btn_go_test')#</cfoutput></a>
											<cfelse>--->
												<cfquery name="get_qpt_all" datasource="#SESSION.BDDSOURCE#">
												SELECT quiz_id, quiz_name, quiz_rank, quiz_alias, quiz_type FROM lms_quiz
												WHERE quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="qpt_#cor#">
												ORDER BY quiz_rank ASC
												</cfquery>							
																					
												<cfoutput query="get_qpt_all">
												
													<cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
													SELECT * FROM lms_quiz_user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> AND quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
													</cfquery>

														<cfif get_result.recordcount neq "0" AND get_result.quiz_user_end neq "">
															<a href="./quiz_eval.cfm?quiz_user_id=#get_result.quiz_user_id#" class="btn btn-sm btn-success">#obj_translater.get_translate('btn_results')# #quiz_alias#</a>
														<!---<cfelseif get_result.recordcount neq "0" AND get_result.quiz_user_end eq "">
															<a href="./quiz.cfm?quiz_user_id=#get_result.quiz_user_id#&f=go" class="btn btn-sm btn-danger">#obj_translater.get_translate('btn_continue')# #quiz_alias#</a>--->
														<cfelse>
															
															<cfif quiz_alias eq "A1">
																<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#&pt_speed=fpt" class="btn btn-sm btn-primary">Test #quiz_alias#</a>
															<cfelseif quiz_alias eq "A2">
																<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#&pt_speed=fpt" class="btn btn-sm btn-primary <cfif listlen(list_qpt_success) eq "1" AND listgetat(list_qpt_success,1) eq "1"><cfelse>disabled</cfif>">Test #quiz_alias#</a>
															<cfelseif quiz_alias eq "B1">
																<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#&pt_speed=fpt" class="btn btn-sm btn-primary <cfif listlen(list_qpt_success) eq "2" AND listgetat(list_qpt_success,2) eq "1"><cfelse>disabled</cfif>">Test #quiz_alias#</a>
															<cfelseif quiz_alias eq "B2">
																<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#&pt_speed=fpt" class="btn btn-sm btn-primary <cfif listlen(list_qpt_success) eq "3" AND listgetat(list_qpt_success,3) eq "1"><cfelse>disabled</cfif>">Test #quiz_alias#</a>
															<cfelseif quiz_alias eq "C1">
																<a href="./quiz.cfm?new_quiz=1&quiz_id=#quiz_id#&pt_speed=fpt" class="btn btn-sm btn-primary <cfif listlen(list_qpt_success) eq "4" AND listgetat(list_qpt_success,4) eq "1"><cfelse>disabled</cfif>">Test #quiz_alias#</a>
															</cfif>	
																		
														</cfif>
														
												</cfoutput>
											<!---</cfif>--->
												

											</div>
										
										</div>
									</div>
								</div>
							</div>
							</cfif>
							
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<script>

$(function() {	


})
</script>

</body>
</html>