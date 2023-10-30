<cfparam name="l_id">
<cfparam name="admin" default="1">

<cfquery name="get_comfirm_late_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT canceled_adv_id, canceled_adv_date, canceled_adv_closed, canceled_adv_clicked, canceled_adv_new_lesson_id 
	FROM lms_lesson_canceled_adv 
	WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
	AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
</cfquery>

<cfif get_comfirm_late_lesson.recordCount eq 1 AND get_comfirm_late_lesson.canceled_adv_clicked neq 1>

	<cfquery name="updt_lesson_adv" datasource="#SESSION.BDDSOURCE#">
		UPDATE lms_lesson_canceled_adv SET 
		canceled_adv_clicked = 1,
		canceled_adv_clicked_date = NOW()
		WHERE lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	</cfquery>
	
</cfif>

<!--- TODO comparatif entre session et user session --->
<cfquery name="get_lesson_info" datasource="#SESSION.BDDSOURCE#">
	SELECT s.session_id, s.session_duration, s.session_name,
	l.lesson_start, l.lesson_end, l.lesson_duration,
	t.method_id, t.tp_id,
	lv.level_id, lv.level_alias, lv.level_css,
	sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_name, sm.sessionmaster_description,
	p.user_firstname as trainer_firstname
	FROM lms_lesson2 l 
	INNER JOIN lms_tp t ON l.tp_id = t.tp_id
	INNER JOIN lms_tpsession s ON l.session_id = s.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_level lv ON lv.level_id = s.level_id
	INNER JOIN user p ON p.user_id = l.planner_id
	WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
</cfquery>

<!--- <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#"> --->
<cfquery name="get_next_session" datasource="#SESSION.BDDSOURCE#">
	SELECT s.session_id, s.session_duration, s.session_name,
	t.method_id, t.tp_id,
	lv.level_id, lv.level_alias, lv.level_css,
	sm.sessionmaster_id, sm.sessionmaster_code, sm.sessionmaster_name, sm.sessionmaster_description
	FROM lms_tp t
	INNER JOIN lms_tpuser tu ON t.tp_id = tu.tp_id AND tpuser_active = 1
	INNER JOIN lms_tpsession s ON s.tp_id = t.tp_id
	LEFT JOIN lms_lesson2 l ON s.session_id = l.session_id AND l.status_id <> 3
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_level lv ON lv.level_id = s.level_id
	WHERE tu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	AND t.tp_status_id = 2
	AND t.method_id = 1
	AND s.sessionmaster_id <> 694
	AND s.session_duration <= #get_lesson_info.lesson_duration#
	AND l.lesson_id IS NULL
	ORDER BY s.session_rank ASC 
	LIMIT 1
</cfquery>

<cfset t_id = get_next_session.tp_id>
<cfset u_id = SESSION.USER_ID>
<cfset m_id= get_next_session.method_id>
<cfset s_id = get_next_session.session_id>
<cfset s_dur = get_next_session.session_duration>

<cfif get_comfirm_late_lesson.recordCount eq 0 OR get_comfirm_late_lesson.canceled_adv_closed eq 1>
	<cfset _taken = 1>
<cfelseif get_comfirm_late_lesson.canceled_adv_closed eq 0>
	<cfset _taken = 0>
</cfif>

<cfset trainer_firstname = get_lesson_info.trainer_firstname>
<cfset arr = ['trainer_firstname']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<!---  !!! for testing --->
<!--- <cfset _taken = admin> --->

<cfif _taken eq 0>
	<!--- form take the spot --->

	<div class="alert bg-light text-dark border mt-3" role="alert">
		<div class="d-flex">
			<div>
				<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
			</div>
			<div class="ms-2">
				<cfoutput>#obj_translater.get_translate_complex(id_translate="alert_adv_spot_free", argv="#argv#")#</cfoutput>
			</div>
		</div>
	</div>
	
<cfelse>
	<!--- No spot found --->

	<div class="alert bg-light text-dark border mt-3" role="alert">
		<div class="d-flex">
			<div>
				<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
			</div>
			<div class="ms-2">
				<cfoutput>#obj_translater.get_translate_complex(id_translate="alert_adv_spot_taken", argv="#argv#")#</cfoutput>
			</div>
		</div>
	</div>

</cfif>

<!---<cfoutput query="get_lesson_info">

	<div class="card border p-1">
		<div class="card-body" id="heading_#session_id#">
                                            
			<div class="row">

				<!--------------------->
				<!--- COL THUMBNAIL --->
				<!--------------------->
				<!---<div class="col-lg-1">

					<div align="center">
						<cfdirectory directory="#SESSION.BO_ROOT#/assets/lessons/#t_id#/#session_id#" name="dirQuery" action="LIST">

						<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_code#.jpg")>			
							<img src="./assets/img_material/#sessionmaster_code#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
						<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#sessionmaster_id#.jpg")>			
							<img src="./assets/img_material/#sessionmaster_id#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#session_id#">
							
						<cfelse>
							<cfif sessionmaster_id eq "695">
								<i class="fal fa-road fa-3x btn_view_session" id="s_#session_id#"></i>
							<cfelseif sessionmaster_id eq "694">
								<i class="fal fa-tasks fa-3x btn_view_session" id="s_#session_id#"></i>                                                                    
							</cfif>
						</cfif>

					</div>
				</div>--->
			
				<!------------------------->
				<!--- COL TITLE + FLAGS --->
				<!------------------------->
				<!---<div class="col-sm-3">
					<h6 class="py-2 d-inline"><!---#__lesson#&nbsp;#session_rank# : #format_title# --->
						<cfif session_name neq "">#session_name#<cfelse>#sessionmaster_name#</cfif>
					</h6>
					<br>
					<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-clock"></i> #session_duration# min</span> 
					
					<cfif level_id neq "">
						<span class="badge badge-pill bg-white border border-#level_css# px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-chart-bar"></i> #level_alias#</span> 
					</cfif>

					
					<cfif listfindnocase("10,11,12", method_id)>
						<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fal fa-users"></i> #method_name#</span> 
					<cfelseif listfindnocase("12", method_id)>
						<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fa-light fa-chalkboard-user"></i> #method_name#</span> 
					</cfif>

				</div>--->

				<!--------------------->
				<!--- COL THUMBNAIL --->
				<!--------------------->
				<div class="col-lg-1">

					<div align="center">
						<cfdirectory directory="#SESSION.BO_ROOT#/assets/lessons/#t_id#/#get_next_session.session_id#" name="dirQuery" action="LIST">

						<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_next_session.sessionmaster_code#.jpg")>			
							<img src="./assets/img_material/#get_next_session.sessionmaster_code#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#get_next_session.session_id#">
						<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/#get_next_session.sessionmaster_id#.jpg")>			
							<img src="./assets/img_material/#get_next_session.sessionmaster_id#.jpg" class="btn_view_session mr-2 img-responsive handle cursored" id="s_#get_next_session.session_id#">
							
						<cfelse>
							<cfif get_next_session.sessionmaster_id eq "695">
								<i class="fal fa-road fa-3x btn_view_session" id="s_#get_next_session.session_id#"></i>
							<cfelseif get_next_session.sessionmaster_id eq "694">
								<i class="fal fa-tasks fa-3x btn_view_session" id="s_#get_next_session.session_id#"></i>                                                                    
							</cfif>
						</cfif>

					</div>
				</div>
			
				<!------------------------->
				<!--- COL TITLE + FLAGS --->
				<!------------------------->
				<div class="col-sm-3">
					<h6 class="py-2 d-inline"><!---#__lesson#&nbsp;#session_rank# : #format_title# --->
						<cfif get_next_session.session_name neq "">#get_next_session.session_name#<cfelse>#get_next_session.sessionmaster_name#</cfif>
					</h6>
					<br>
					<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-clock"></i> #get_next_session.session_duration# min</span> 
					
					<cfif level_id neq "">
						<span class="badge badge-pill bg-white border border-#get_next_session.level_css# px-3 py-3 mt-2 font-weight-normal" style="font-size:14px"><i class="fal fa-chart-bar"></i> #get_next_session.level_alias#</span> 
					</cfif>

					
					<cfif listfindnocase("10,11,12", get_next_session.method_id)>
						<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fal fa-users"></i> #get_next_session.method_name#</span> 
					<cfelseif listfindnocase("12", get_next_session.method_id)>
						<span class="badge badge-pill bg-white border border-dark px-3 py-3 mt-2 font-weight-normal btn_edit_tpgroup cursored" id="group_#tp_id#_#lesson_id#" style="font-size:14px"><i class="fa-light fa-chalkboard-user"></i> #get_next_session.method_name#</span> 
					</cfif>

				</div>

				<!------------------------->
				<!---  BOOKING BUTTON   --->
				<!------------------------->
				<div class="col-sm-4">
					
					
				</div>
			</div>
		</div>
	</div>
</cfoutput>--->

<div class="row justify-content-middle">
	<div class="col-md-12">

		<cfif _taken eq 0>

			<div class="media">
				<cfoutput>#obj_lms.get_thumb_session(sessionmaster_id="#get_next_session.sessionmaster_id#",sessionmaster_code="#get_next_session.sessionmaster_code#",size="150",align="left")#</cfoutput>
				<div class="media-body ml-3">
				<h6 class="mt-0"><cfoutput>#get_next_session.sessionmaster_name#</cfoutput></h6>
				<cfoutput>#get_next_session.sessionmaster_description#</cfoutput>
				</div>
			</div>

			
			<!--- form take the spot --->
			<button class="btn btn-outline-warning p-2 btn_book_lesson btn-block">
				<cfoutput>#obj_translater.get_translate('btn_book_with')# #get_lesson_info.trainer_firstname#</cfoutput>
				<br><i class="fal fa-calendar-alt fa-2x mt-2"></i>
				<cfoutput><br><strong>#obj_dater.get_dateformat(get_lesson_info.lesson_start)#</strong> #timeformat(get_lesson_info.lesson_start,'HH:mm')#-#timeformat(get_lesson_info.lesson_end,'HH:mm')#</cfoutput>
			</button>
		
		<!--- 						<cfoutput>#obj_translater.get_translate('cadv_spot_free')#</cfoutput> --->
		<cfelse>
			<!--- No spot found --->
			<!--- <cfoutput>#obj_translater.get_translate('cadv_spot_taken_button')#</cfoutput> --->
		</cfif>

	</div>

</div>






<cfif get_comfirm_late_lesson.recordCount eq 0 OR get_comfirm_late_lesson.canceled_adv_closed eq 1>
	<!--- No spot found --->


<cfelseif get_comfirm_late_lesson.canceled_adv_closed eq 0>

</cfif>
<cfif _taken eq 0>
<!---  ?  --->
<cfelse>
	<!--- No spot found --->
	<!--- <cfoutput>#obj_translater.get_translate('cadv_spot_taken_calltoaction')#</cfoutput> --->
	

	<!--- list of late lesson not mailed --->

	<!--- calendar --->
	<cfinclude template="modal_window_calendar.cfm">
</cfif>

<script>
$(document).ready(function() {

	$(".btn_book_lesson").click(function(event) {
		event.preventDefault();

		$.ajax({
			url: './api/tp/tp_post.cfc?method=rebook_canceled_spot',
			type: 'POST',
			data : {
				l_id:<cfoutput>#l_id#</cfoutput>, 
				t_id:<cfoutput>#get_next_session.tp_id#</cfoutput>, 
				s_id:<cfoutput>#get_next_session.session_id#</cfoutput>, 
				u_id:<cfoutput>#SESSION.USER_ID#</cfoutput>
			},
			success : function(result, statut){
				console.log(result);

				// $('#window_item_lg').modal('hide');
				document.location.href="common_tp_details.cfm";
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
			}
		});

	})
})
</script>
	
	
