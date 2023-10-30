<!DOCTYPE html>

<cfsilent>

<!---
1183	Discussion Lesson
697		Workshop
1112	Certification
1182	Review Lesson
1063	eLearning
769		Test Lesson
694		Post Training Assessment
695		First Lesson
1181	Web Lesson
1197	Training lesson for Trainer
1198	Ops Meeting
1199	Resource Creation
1200	Translation
1201	Bonus Standard
1202	Bonus Variable
1267	Bonus Variable
--->

<cfparam name="u_id" default="0">

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",schedule_only="1")>
<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#")>

<cfif SESSION.USER_PROFILE eq "trainer">
	<cfset get_learner_trainer = obj_query.oget_learner_trainer(p_id="#SESSION.USER_ID#",ust_id="2,3,4")>
</cfif>

<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">

	<cfif isdefined("SESSION.USER_ACCESS_TP") AND SESSION.USER_ACCESS_TP neq "0">
	
	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.*, tp.*, tm.module_name, (SELECT COUNT(quiz_id) as quiz_id FROM lms_quiz WHERE sessionmaster_id = sm.sessionmaster_id) AS quiz_id
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
	LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
	LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
	WHERE <!---tp.tpmaster_id IN (#SESSION.USER_ACCESS_TP#) AND ---> tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#">
	AND sm.sessionmaster_online_visio = 1
	AND tp.tpmaster_prebuilt = 0
	ORDER BY tpmaster_rank ASC, sm.module_id
	</cfquery>
	
	</cfif>
	
	
<cfelse>

	<cfset get_learner = obj_query.oget_learner_solo(u_id="#u_id#")>

	<cfquery name="get_session_access" datasource="#SESSION.BDDSOURCE#">
	SELECT tc.*, sm.*, tp.*, tm.module_name, (SELECT COUNT(quiz_id) as quiz_id FROM lms_quiz WHERE sessionmaster_id = sm.sessionmaster_id) AS quiz_id
	FROM lms_tpmaster2 tp
	INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
	LEFT JOIN lms_tpmodulemaster2 tm ON sm.module_id = tm.module_id	
	LEFT JOIN lms_quiz q ON q.sessionmaster_id = sm.sessionmaster_id
	WHERE tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_tp.formation_id#"> 
	AND sm.sessionmaster_online_visio = 1
	AND tp.tpmaster_prebuilt = 0
	GROUP BY sm.sessionmaster_id
	ORDER BY tpmaster_rank ASC, sm.module_id
	</cfquery>

</cfif>

<cfquery name="get_wefit_session" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 WHERE 
sessionmaster_id = 697
OR sessionmaster_id = 1182
OR sessionmaster_id = 1183
OR sessionmaster_id = 1181
<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
OR sessionmaster_id = 769
OR sessionmaster_id = 694
OR sessionmaster_id = 695
OR sessionmaster_id = 1267
OR sessionmaster_id = 1437
OR sessionmaster_id = 1438
OR sessionmaster_id = 1439
</cfif>
</cfquery>

<cfif listFindNoCase("FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfquery name="get_bonus_session" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_tpsessionmaster2 WHERE sessionmaster_cat_id = 7
	</cfquery>

	<cfquery name="get_ops_session" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_tpsessionmaster2 WHERE sessionmaster_cat_id = 6
	</cfquery>

	<cfset list_special_lesson = "wefit,ops,bonus">

<cfelse>

	<cfset list_special_lesson = "wefit">

</cfif>


<cfif isnumeric(get_tp.session_duration)>
	<cfset tp_session_duration = get_tp.session_duration>
<cfelse>
	<cfset tp_session_duration = 0>
</cfif>

<cfset __text_about = obj_translater.get_translate('text_about')>
<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>

</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>


<style>
.item {
    position:relative;
    /*padding-top:20px;*/
    display:inline-block;
}
.notify-badge{
    position: absolute;
    right:5%;
    top:80%;
    background:red;
    text-align: center;
    border-radius: 5px;
    color:white;
   /* padding:5px 10px;*/
    font-size:14px;
}
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}

.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}

.sidebar-outer {
    position: relative;
}
.fixed {
    position: fixed;
}

.nav-link {
	color: #999 !important;
}
.nav-link.active
{
	color:#51BCDA !important;
}
</style>	

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      

		<!--- <cfdump var="#get_session#"> --->
		<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test">
			<cfset title_page = "#obj_translater.get_translate('title_page_common_tp_builder')#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_common_tp_builder')# : #get_learner.user_firstname# #get_learner.user_name#">
		</cfif>

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfinclude template="./incl/incl_nav_tp.cfm">

			<div class="row">
				<div class="col-md-5">

					<div class="card border-top border-info mr-3">
						<div class="card-body">
							<cfif not listFindNoCase("LEARNER,TEST,CONTACT,CM,GUEST", SESSION.USER_PROFILE)>
								<form id="form_tp_name" name="form_tp_name">

									<div class="row">
										<div class="col-10">
											<input class="form-control" type="text" maxlength="120" name="tp_name" value="<cfoutput>#get_tp.tp_name#</cfoutput>" placeholder="<cfoutput>#obj_lms.get_tp_text(tp_id="#get_tp.tp_id#",formation_code="#get_tp.formation_code#",method_id="#get_tp.method_id#",tp_duration="#get_tp.tp_duration#",elearning_name="#get_tp.elearning_name#",elearning_duration="#get_tp.elearning_duration#",certif_name="#get_tp.certif_name#")#</cfoutput>">
											<input type="hidden" name="t_id" value="<cfoutput>#get_tp.tp_id#</cfoutput>">									
										</div>
										<div class="col-2">
											<button type="submit" class="btn btn-outline-success btn-sm my-0"><i class="fal fa-repeat"></i></button>
										</div>

									</div>
								</form>
								<br>
							</cfif>

							<div class="row">
								<div class="col">
								<h5 class="card-title"><cfoutput>#obj_translater.get_translate('card_add_lesson')#</cfoutput></h5>
								</div>
								<div class="col">
								<cfif get_tp.user_needs_duration eq "">
									<cfset user_needs_duration = "45">
								<cfelse>
									<cfset user_needs_duration = get_tp.user_needs_duration>
								</cfif>
								<select class="form-control" name="session_duration" id="session_duration">
									<!---F2F TRICK TO PREVENT BOOKING LESS THAN 1h FOR F2F --->
									<!--- <cfif get_tp.method_id neq "2"> --->
									<option value="15" <cfif user_needs_duration eq "15">selected</cfif>>15min</option>
									<option value="30" <cfif user_needs_duration eq "30">selected</cfif>>30min</option>
									<option value="45" <cfif user_needs_duration eq "45">selected</cfif>>45min</option>
									<!--- </cfif> --->
									<option value="60" <cfif user_needs_duration eq "60">selected</cfif>>1h</option>	
									<option value="75" <cfif user_needs_duration eq "75">selected</cfif>>1h15min</option>
									<option value="90" <cfif user_needs_duration eq "90">selected</cfif>>1h30min</option>
									<option value="105" <cfif user_needs_duration eq "105">selected</cfif>>1h45min</option>
									<option value="120" <cfif user_needs_duration eq "120">selected</cfif>>2h</option>
									<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>				
									
										<option value="135" <cfif user_needs_duration eq "135">selected</cfif>>	2h15min</option>
										<option value="150" <cfif user_needs_duration eq "150">selected</cfif>>	2h30min</option>
										<option value="165" <cfif user_needs_duration eq "165">selected</cfif>>	2h45min</option>
										<option value="180" <cfif user_needs_duration eq "180">selected</cfif>>	3h</option>
										<option value="195" <cfif user_needs_duration eq "195">selected</cfif>>	3h15min</option>
										<option value="210" <cfif user_needs_duration eq "210">selected</cfif>>	3h30min</option>
										<option value="225" <cfif user_needs_duration eq "225">selected</cfif>>	3h45min</option>
										<option value="240" <cfif user_needs_duration eq "240">selected</cfif>>	4h</option>
										<option value="255" <cfif user_needs_duration eq "255">selected</cfif>>	4h15min</option>
										<option value="270" <cfif user_needs_duration eq "270">selected</cfif>>	4h30min</option>
										<option value="285" <cfif user_needs_duration eq "285">selected</cfif>>	4h45min</option>
										<option value="300" <cfif user_needs_duration eq "300">selected</cfif>>	5h</option>
										<option value="315" <cfif user_needs_duration eq "315">selected</cfif>>	5h15min</option>
										<option value="330" <cfif user_needs_duration eq "330">selected</cfif>>	5h30min</option>
										<option value="345" <cfif user_needs_duration eq "345">selected</cfif>>	5h45min</option>
										<option value="360" <cfif user_needs_duration eq "360">selected</cfif>>	6h</option>
										<option value="375" <cfif user_needs_duration eq "375">selected</cfif>>	6h15min</option>
										<option value="390" <cfif user_needs_duration eq "390">selected</cfif>>	6h30min</option>
										<option value="405" <cfif user_needs_duration eq "405">selected</cfif>>	6h45min</option>
										<option value="420" <cfif user_needs_duration eq "420">selected</cfif>>	7h</option>
										<option value="435" <cfif user_needs_duration eq "435">selected</cfif>>	7h15min</option>
										<option value="450" <cfif user_needs_duration eq "450">selected</cfif>>	7h30min</option>
										<option value="465" <cfif user_needs_duration eq "465">selected</cfif>>	7h45min</option>
										<option value="480" <cfif user_needs_duration eq "480">selected</cfif>>	8h</option>
										<option value="495" <cfif user_needs_duration eq "495">selected</cfif>>	8h15min</option>
										<option value="510" <cfif user_needs_duration eq "510">selected</cfif>>	8h30min</option>
										<option value="525" <cfif user_needs_duration eq "525">selected</cfif>>	8h45min</option>
										<option value="540" <cfif user_needs_duration eq "540">selected</cfif>>	9h</option>
										<option value="555" <cfif user_needs_duration eq "555">selected</cfif>>	9h15min</option>
										<option value="570" <cfif user_needs_duration eq "570">selected</cfif>>	9h30min</option>
										<option value="585" <cfif user_needs_duration eq "585">selected</cfif>>	9h45min</option>
										<option value="600" <cfif user_needs_duration eq "600">selected</cfif>>	10h</option>
										<option value="615" <cfif user_needs_duration eq "615">selected</cfif>>	10h15min</option>
										<option value="630" <cfif user_needs_duration eq "630">selected</cfif>>	10h30min</option>
										<option value="645" <cfif user_needs_duration eq "645">selected</cfif>>	10h45min</option>
										<option value="660" <cfif user_needs_duration eq "660">selected</cfif>>	11h</option>
										<option value="675" <cfif user_needs_duration eq "675">selected</cfif>>	11h15min</option>
										<option value="690" <cfif user_needs_duration eq "690">selected</cfif>>	11h30min</option>
										<option value="705" <cfif user_needs_duration eq "705">selected</cfif>>	11h45min</option>
										<option value="720" <cfif user_needs_duration eq "720">selected</cfif>>	12h</option>
										<option value="735" <cfif user_needs_duration eq "735">selected</cfif>>	12h15min</option>
										<option value="750" <cfif user_needs_duration eq "750">selected</cfif>>	12h30min</option>
										<option value="765" <cfif user_needs_duration eq "765">selected</cfif>>	12h45min</option>
										<option value="780" <cfif user_needs_duration eq "780">selected</cfif>>	13h</option>
										<option value="795" <cfif user_needs_duration eq "795">selected</cfif>>	13h15min</option>
										<option value="810" <cfif user_needs_duration eq "810">selected</cfif>>	13h30min</option>
										<option value="825" <cfif user_needs_duration eq "825">selected</cfif>>	13h45min</option>
										<option value="840" <cfif user_needs_duration eq "840">selected</cfif>>	14h</option>
										<option value="855" <cfif user_needs_duration eq "855">selected</cfif>>	14h15min</option>
										<option value="870" <cfif user_needs_duration eq "870">selected</cfif>>	14h30min</option>
										<option value="885" <cfif user_needs_duration eq "885">selected</cfif>>	14h45min</option>
										<option value="900" <cfif user_needs_duration eq "900">selected</cfif>>	15h</option>									
									
									</cfif>
								</select>
								</div>
							</div>
							
							<div id="accordion">
							





								
								<cfloop list="#list_special_lesson#" index="cor">
									<cfoutput>
									<div class="mt-2">
										<button class="btn btn-warning btn-block" data-toggle="collapse" data-target="##tp_#cor#" aria-expanded="true">
											#ucase(cor)#
										</button>
									</div>
									</cfoutput>
									<div id="tp_<cfoutput>#cor#</cfoutput>" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
										<table class="table table-sm bg-white">
											<cfoutput query="get_#cor#_session">
											<tr>	
												<td width="50"><img src="./assets/img/wefit_lesson.jpg"  alt="" width="40" /></td>
												<td width="20">
													<span style="cursor:pointer" class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#">?</span>
												</td>
												<td width="200" class="sessionmaster_title">#sessionmaster_name#</td>
												<td width="120"></td>
												<td align="right">
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
													<!--- <cfif SESSION.USER_ISMANAGER eq "1"> --->
														<a href="##" class="btn btn-sm btn-primary add_line" id="STS_#sessionmaster_id#_#sessionmaster_cat_id#"><i class="fas fa-arrow-right"></i></a>
													<!--- </cfif> --->
												<cfelse>
												<cfif sessionmaster_id neq "769" AND sessionmaster_id neq "694" AND sessionmaster_id neq "695" AND sessionmaster_id neq "1063" AND sessionmaster_id neq "1112">
												<a href="##" class="btn btn-sm btn-primary add_line" id="STS_#sessionmaster_id#_#sessionmaster_cat_id#"><i class="fas fa-arrow-right"></i></a>
												</cfif>
												</cfif>
												</td>
												
											</tr>	
											</cfoutput>									
										</table>
									</div>


								</cfloop>



								
								





























								
								<cfoutput query="get_session_access" group="tpmaster_biglevel">
								
								
								<cfif tpmaster_biglevel eq "A">
										<cfset id_acc = "A">
										<cfset css = "success">
									<cfelseif tpmaster_biglevel eq "A1">
										<cfset id_acc = "A1">
										<cfset css = "success">
									<cfelseif tpmaster_biglevel eq "A2">
										<cfset id_acc = "A2">
										<cfset css = "success">
									<cfelseif tpmaster_biglevel eq "B1">
										<cfset id_acc = "B1">
										<cfset css = "info">
									<cfelseif tpmaster_biglevel eq "B2">
										<cfset id_acc = "B2">
										<cfset css = "info">
									<cfelseif tpmaster_biglevel eq "B">
										<cfset id_acc = "B">
										<cfset css = "info">
									<cfelseif tpmaster_biglevel eq "C">
										<cfset id_acc = "C">
										<cfset css = "danger">
									<cfelse>
										<cfset id_acc = "Z">
										<cfset css = "secondary">
									</cfif>
								
								<div>
									<button class="btn btn-#css# btn-block" data-toggle="collapse" data-target="##tcat_#id_acc#" aria-expanded="true">
									[ #obj_translater.get_translate('level')# #tpmaster_biglevel# ]
									</button>
								</div>
								
								<div id="tcat_#id_acc#" class="collapse" data-parent="##accordion">
								
								<cfoutput group="tpmaster_id">
								
									<div>
										<button class="btn btn-outline-#css# btn-block text-left" data-toggle="collapse" data-target="##tp_#tpmaster_id#" aria-expanded="true">
										[ #tpmaster_level# ] #tpmaster_name# 
										</button>
									</div>
									
									<div id="tp_#tpmaster_id#" class="collapse" data-parent="##tcat_#id_acc#">

										<table class="table table-sm bg-white">
											<cfoutput group="module_id">
												<cfif module_id neq "">
												<tr>	
													<td colspan="9" class="bg-light font-weight-bold">#ucase(module_name)#</td>
												</tr>
												</cfif>
												<cfoutput group="sessionmaster_id">
												<tr>	
													<td width="50">
													#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="40")#
													</td>
													<!---<td width="20">
													
													<cfif sessionmaster_rank neq "">
													<span class="badge badge-#css#">#sessionmaster_rank#</span>
													</cfif>
													</td>--->
													<td width="300" class="sessionmaster_title">
													#sessionmaster_name#
													</td>
													<td width="120">
													<small>#__text_about# #sessionmaster_duration# m</small>
													</td>
													<td>
													<i style="cursor:pointer" class="fas fa-book text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
													</td>
													<td>
													<cfif sessionmaster_audio_bool eq "1">
													<i style="cursor:pointer" class="fas fa-volume-up text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
													</cfif>
													</td>
													<td>
													<cfif sessionmaster_video_bool eq "1">
													<i style="cursor:pointer" class="fas fa-video text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
													</cfif>
													</td>
													<td>
													<cfif quiz_id neq "">
													<i style="cursor:pointer" class="fas fa-tasks text-#css# btn_view_session" id="sm_#sessionmaster_id#" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i>
													</cfif>
													</td>
													<td align="right">
													<a href="##" class="btn btn-sm btn-#css# add_line" id="STS_#sessionmaster_id#_#sessionmaster_cat_id#"><i class="fas fa-arrow-right"></i></a>
													</td>
												</tr>
												</cfoutput>
											</cfoutput>
										</table>
									</div>
									</cfoutput>
								</div>
								</cfoutput>						
							</div>
						
						</div>
					</div>
				</div>
		
				<cfform action="updater_tp2.cfm" method="post" id="tp_build">
				<div class="col-md-6 sidebar-outer">
				
					<div class="row">
					
						<div class="fixed col-md-6 ml-0">
						
							<div class="card border-top border-info mr-5">
								<div class="card-body">
									<div class="row">
										<div class="col-md-12">
											<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_program')#</cfoutput></h6>
												<!---<cfoutput>
												<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
													<div class="float-right"><a href="common_tp_details.cfm?t_id=#t_id#&u_id=#u_id#" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-calendar-alt"></i> BOOK</a></div>
												</cfif>
												<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
													<div class="float-right"><a href="common_learner_account.cfm?u_id=#u_id#&tab=3" class="btn btn-outline-info btn-sm my-0"><i class="fas fa-edit"></i> EDIT</a></div>
												</cfif>
												</cfoutput>
											
											<br><br>--->
										
											<div class="input-group">
											<input type="text" class="form-control form-control-lg" disabled value="<cfoutput>#obj_lms.get_formath(tp_session_duration)#</cfoutput>" id="tp_duration" style="text-align:right; background-color:##FFFFFF; min-width:80px">
											<div class="input-group-append">
												<cfif obj_lms.get_formath(tp_session_duration) eq obj_lms.get_formath(get_tp.tp_duration)>
												<div id="pindic" class="input-group-text bg-success text-white">&nbsp;&nbsp;<strong>/ <cfoutput>#obj_lms.get_formath(get_tp.tp_duration)#</cfoutput> h</strong></div>
												<cfelse>
												<div id="pindic" class="input-group-text bg-warning text-white">&nbsp;&nbsp;<strong>/ <cfoutput>#obj_lms.get_formath(get_tp.tp_duration)#</cfoutput> h</strong></div>
												</cfif>												
											</div>
											</div>	
											<div class="progress" style="margin:0px; width:100%">	
												<cfif tp_session_duration neq "0" AND get_tp.tp_duration neq 0 AND get_tp.tp_duration neq "">
													<cfset pource = round(tp_session_duration/get_tp.tp_duration*100)>
												<cfelse>
													<cfset pource = 0>
												</cfif>
												<cfif obj_lms.get_formath(tp_session_duration) eq obj_lms.get_formath(get_tp.tp_duration)>
												<div id="pbar" class="progress-bar progress-bar-striped bg-success progress-bar-animated" style="width:<cfoutput>#pource#</cfoutput>%">
												<cfelse>
												<div id="pbar" class="progress-bar progress-bar-striped bg-warning progress-bar-animated" style="width:<cfoutput>#pource#</cfoutput>%">
												</cfif>		
												</div>
											</div>	
			
											<div class="float-right">
												<!--- <cfif obj_lms.get_formath(tp_session_duration) lte obj_lms.get_formath(get_tp.tp_duration)> --->
													<input type="submit" class="btn btn-outline-success btn-sm btn_saver" value="Sauvegarder">
												<!--- </cfif>							 --->
											</div>
											
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">		
											<!--- <cfdump var="#get_session#"> --->
											<h6 class="card-title"><cfoutput>#obj_translater.get_translate('card_details')#</cfoutput></h6>
											<div style="height:350px; overflow:auto; -ms-overflow-style:scrollbar;" id="div_content">
												<table id="table_tp" class="table table-sm mt-3" width="100%">
													<thead>
														<tr bgcolor="#F3F3F3">
															<th width="1%"></th>
															<th width="3%"><label>N&deg;</label></th>
															<th width="20%"><label><cfoutput>#obj_translater.get_translate('table_th_course_type')#</cfoutput></label></th>
															<th width="10%"><label><cfoutput>#obj_translater.get_translate('table_th_duration_short')#</cfoutput></label></th>
															<th><label><cfoutput>#obj_translater.get_translate('table_th_course')#</cfoutput></label></th>
															<th><label><cfoutput>#obj_translater.get_translate('table_th_status')#</cfoutput></label></th>
															<th width="12%"></th>
														</tr>
													</thead>
													<tbody id="tbody_sortable">
													<cfif get_session.recordcount neq "0">
													
														<cfoutput query="get_session" group="session_id">
														
														<!--- IF LESSON BOOKED, UNSORTABLE--->
														<cfif lesson_id neq "">
														<tr class="unsortable bg-light" id="tr_#session_rank#">
															<td></td>
														<!--- IF NA, UNSORTABLE--->
														<cfelseif sessionmaster_id eq "695">
														<tr class="unsortable bg-light" id="tr_#session_rank#">
															<td></td>
														<!--- IF PTA, UNSORTABLE--->
														<cfelseif sessionmaster_id eq "694">
														<tr class="unsortable bg-light last_tr" id="tr_#session_rank#">
															<td></td>
														<cfelse>
														<tr id="tr_#session_rank#">
															<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>
														</cfif>
															<td>	
																<h5 class="d-inline"><span class="badge badge-pill badge-secondary">#session_rank#</span></h5>
															</td>
															<td>
																<small>#cat_name#</small>
															</td>
															<td>
																<small>#session_duration# min</small>
															</td>
															<td>									
																#sessionmaster_name#
															</td>
															<td>
																<cfif lesson_id neq "">
																<cfoutput group="lesson_id">
																<span class="badge badge-#status_css# btn_view_lesson" id="l_#lesson_id#" style="cursor:pointer">#status_name#</span>															
																</cfoutput>
																</cfif>
															</td>
															<td>
																<!---<a href="" id="ss_x" class="btn btn-success btn-sm btn_attach_syllabus disabled"><i class="fas fa-plus"></i>--->
																<cfif cat_id eq "4">
																	
																	<cfif lesson_id eq "" AND (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE))>
																	<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>
																	<cfelse>
																	<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm disabled"><i class="far fa-trash-alt"></i></a>
																	</cfif>
																<cfelse>												
																	<cfif lesson_id neq "">
																		<div class="btn-group" role="group">
																		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) OR (SESSION.USER_PROFILE eq "TRAINER" AND !(sessionmaster_id eq "694" or sessionmaster_id eq "695"))>
																		<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm disabled"><i class="far fa-trash-alt"></i></a>
																	
																		<!---- DISPLAY SWITCH BUTTON IF THERE IS A SCHEDULED ONE ON THE LIST ---->
																		<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
																		<cfoutput group="lesson_id">
																		<cfif status_id eq "1">
																		<a class="btn btn-warning btn-sm btn_switch_solo ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#"><i class="fas fa-random"></i></a>
																		</cfif>
																		</cfoutput>
																		</cfif>
																		</cfif>
																		</div>
																		
																	<cfelse>
																		<div class="btn-group" role="group">
																		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) OR (SESSION.USER_PROFILE eq "TRAINER" AND !(sessionmaster_id eq "694" or sessionmaster_id eq "695"))>

																			
																		<a id="r_#session_rank#_#session_duration#" class="btn btn-warning btn-sm btn_remove_line"><i class="far fa-trash-alt"></i></a>
																	
																		<cfif listFindNoCase("TRAINER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) >
																		<a class="btn btn-warning btn-sm btn_switch_all ml-1" id="lts_#tp_id#_#session_id#_#sessionmaster_id#_#session_duration#"><i class="fas fa-random"></i></a>
																		</cfif>
																		</cfif>
																		</div>
																	</cfif>		
																</cfif> 
																<input type="hidden" class="session_final_rank" name="S_#session_id#" value="#session_rank#_#sessionmaster_id#_#session_duration#_#cat_id#_#session_rank#">
															</td>
														</tr>
														
														<cfif currentrow eq recordcount AND sessionmaster_id neq "694">
														<tr class="unsortable bg-light last_tr"></tr>
														</cfif>
														
														</cfoutput>
													<cfelse>
														<tr class="unsortable bg-light last_tr" id="tr_0"></tr>
													</cfif>
													
													
													</tbody>
												</table>
										</div>
									</div>
										
								</div>
									
							</div>	
						</div>
					</div>
				</div>
			</div>
			<cfoutput>
			<input type="hidden" name="t_id" value="#t_id#">
			<input type="hidden" name="u_id" value="#u_id#">
			</cfoutput>
			<input type="hidden" name="updt_tp" value="1">
			</cfform>
		</div>
			
		
	</div>
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>
$(document).ready(function() {
	

    $('#tbody_sortable').sortable({
		items: "tr:not(.unsortable)",
		update: function(e, ui) {
			// $("tr td:nth-child(2)").empty();
			reorder();			
		}
	});
	$("#tbody_sortable").disableSelection();
	
	
	$('.btn_switch_solo').click(function(event) {	
		<cfoutput>
		var idtemp = $(this).attr("id");
		var valtemp = idtemp.split("_");
		var tp_id = valtemp[1];
		var session_id = valtemp[2];
		var sm_id = valtemp[3];			
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Switch lesson");
		$('##modal_body_lg').load("modal_window_lesson_switch.cfm?u_id=#u_id#&s_id="+session_id+"&t_id="+tp_id+"&sm_id="+sm_id, function() {});
		</cfoutput>
	});

	$('.btn_switch_all').click(function(event) {	
		<cfoutput>
		var idtemp = $(this).attr("id");
		var valtemp = idtemp.split("_");
		var tp_id = valtemp[1];
		var session_id = valtemp[2];
		var sm_id = valtemp[3];	
		var s_dur = valtemp[4];			
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Switch lesson");
		$('##modal_body_lg').load("modal_window_lesson_switch.cfm?u_id=#u_id#&s_id="+session_id+"&t_id="+tp_id+"&sm_id="+sm_id+"&s_dur="+s_dur, function() {});
		</cfoutput>
	});


	$("#form_tp_name").submit(function( event ) {
		event.preventDefault();

		console.log($(event.target).serialize());

		$.ajax({				 
			url: './api/tp/tp_post.cfc?method=update_tp_name',
			type: 'POST',
			data: $(event.target).serialize(),
			success : function(result, status){
				console.log(result);
				// window.location.href = "db_certif_school.cfm?ts_id=" + result
				alert("name changed successfully");
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});

	});
	
	
	$(".btn_remove_line").bind("click",remove_line);
	 
	function param_attach(event) {

		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Attacher cours");
		$('#modal_body_lg').load("modal_window_syllabus.cfm?s_id="+idtemp, function() {
		
		});
		
	}
	
	total_duration = <cfoutput>#get_tp.tp_duration#</cfoutput>;
	<cfif tp_session_duration neq "0">
	counter = <cfoutput>#get_session.session_rank[get_session.recordcount]#</cfoutput>;
	<cfelse>
	counter = 1;
	</cfif>
	total_booked = <cfoutput>#tp_session_duration#</cfoutput>;
	
	
	function calculate()
		{
			$(".session_duration").each(function( index ) {
			  console.log( index + ": " + $( this ).val() );
			});	
		}
		
	$( ".session_duration" ).change(function() {
	  calculate()
	});
	
	
	function reorder()
	{
		$("#table_tp tr td:nth-child(2)").empty();
		$("#table_tp tr td:nth-child(2)").html(function() {
			return '<h5 class="d-inline"><span class="badge badge-pill badge-secondary">'+$(this).parent().index("#table_tp tr")+'</span></h5>';
		});
		
		$("#table_tp tr td:nth-child(2)").each(function( index ) {
			var valtemp = $(this).parent().find(".session_final_rank").val();
			/*alert(valtemp);*/
			var valtemp = valtemp.split("_");
			var idgo = valtemp[0];		
			var durtemp = valtemp[1];
			var sessiomaster_id = valtemp[2];	
			var session_cat = valtemp[3];
			var session_rank = $(this).parent().index("#table_tp tr");
			
			$(this).parent().find(".session_final_rank").val(idgo+"_"+durtemp+"_"+sessiomaster_id+"_"+session_cat+"_"+session_rank)
			
			/*console.log($(this).parent().find(".session_final_rank").val());*/
		});	
	}		
			
	function remove_line()
	{		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idgo = idtemp[1];		
		var durtemp = idtemp[2];

		/*alert(idgo);*/
		$("#tr_"+idgo).remove();
		total_booked -= parseInt(durtemp);
		var total_booked_hour = parseFloat(total_booked/60);
		$("#tp_duration").val(total_booked_hour);
		var pource = (+total_booked/+total_duration)*100;
		$("#pbar").css('width', pource+'%');
		
		if($(".session_adder").hasClass("d-none")){$(".session_adder").toggleClass("d-none");};
		
		
		if($(".btn_saver").hasClass("btn-info")){$(".btn_saver").removeClass("btn-info").addClass("btn-success");};
		/*$(".btn_saver").val("Sauvegarde temporaire");*/
		
		/*if(!$(".session_saver").hasClass("d-none")){$(".session_saver").toggleClass("d-none");};*/
		
		if($("#pbar").hasClass("bg-success")){$("#pbar").toggleClass("bg-success");$("#pbar").toggleClass("bg-warning");};
		if($("#pindic").hasClass("bg-success")){$("#pindic").toggleClass("bg-success");$("#pindic").toggleClass("bg-warning")};
		
		reorder();

	}

	
	$(".add_line").on('click', function () {
	
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var sessionmaster_id = idtemp[1];		
	var sessionmaster_cat_id = idtemp[2];
	
	var valtemp = $(this).parent().parent().find(".sessionmaster_title").text();

	
	var session_duration = $("#session_duration").val();
	/*var session_type = $("#session_type").val();*/
	total_booked += parseInt(session_duration);
	
	if(total_booked == total_duration)
	{
		$(".session_adder").toggleClass("d-none");
		/*$(".session_saver").toggleClass("d-none");*/
		
		/*$(".btn_saver").val("Finaliser TP"); */
		
		
		$("#pbar").toggleClass("bg-warning");
		$("#pbar").toggleClass("bg-success");
		$("#pindic").toggleClass("bg-warning");
		$("#pindic").toggleClass("bg-success");
	}
	if(total_booked > total_duration)
	{
		alert("<cfoutput>#obj_translater.get_translate('js_book_credential')#</cfoutput>");
		total_booked -= parseInt(session_duration);
	}
	else{
		var test = document.getElementById("div_content").scrollHeight+500;
		
		$("#div_content").scrollTop(test);
		
		var total_booked_hour = parseFloat(total_booked/60);
		$("#tp_duration").val(total_booked_hour);
		
		counter ++;
		
		var pource = (+total_booked/+total_duration)*100;

		/******************* CONSTRUCT LINE TO ADD *************/
		<!--- * if there is no PTA we add last_tr so other  lesson can be inserted --->
		if (sessionmaster_id == 694) {
			var liner = '<tr class="unsortable bg-light last_tr" id="tr_'+counter+'">';
		} else {
			var liner = '<tr id="tr_'+counter+'">';
		}
		
		liner += '<td style="cursor:pointer"><i class="fas fa-arrows-alt-v"></i></td>';		
		liner += '<td><h5 class="d-inline"><span class="badge badge-pill badge-secondary">'+counter+'</span></h5></td>';
		
		liner += '<td></td>';
		liner += '<td>'+session_duration+' min</td>';
		liner += '<td>'+valtemp+'</td>';
		liner += '<td></td>';
		liner += '<td><a id="r_'+counter+'_'+session_duration+'" class="btn btn-warning btn-sm"><i class="far fa-trash-alt"></i></td>';
		liner += '<input type="hidden" class="session_final_rank" id="STC_'+counter+'" name="STC_'+counter+'" value="'+counter+'_'+sessionmaster_id+'_'+session_duration+'_'+sessionmaster_cat_id+'_'+counter+'">';
		
		liner += '</tr>';
				
		if (sessionmaster_id == 694 || !$(".last_tr")[0]) {
			$('#tbody_sortable tr:last').after(liner);
		} else {
			$(".last_tr").before(liner);
		}
				
		$("#pbar").css('width', pource+'%');
		
		$("#s_"+counter+"_"+session_duration).bind("click",param_attach);
		$("#r_"+counter+"_"+session_duration).bind("click",remove_line);
		/*$("#d_"+counter+"_"+session_duration).bind("change",calculate);*/
		
		$("#sel_"+counter).bind("change",attach_sessionmaster_id);
	
		reorder();
			
	}
	});

	function attach_sessionmaster_id()
	{
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idgo = idtemp[1];
		
		var sessionmaster_id = $(this).val();
		
		
		
		/* RECONSTRUCT */
		var idtemp2 = $("#STC_"+idgo).val();
		var idtemp2 = idtemp2.split("_");
			
		var durtemp = idtemp2[2];
		var session_cat = idtemp2[3];
		var session_rank = idtemp2[4];
		/*var durtemp = idtemp[2];*/
		/*alert(idgo);
		alert(durtemp);*/
		/*alert(session_cat);*/
		
		$("#STC_"+idgo).val(idgo+"_"+sessionmaster_id+"_"+durtemp+"_"+session_cat+"_"+session_rank);
		
	}
	
	$("#tp_build").submit(function( event ) {
	
		$(".session_select").each(function( index ) {
			if($(this).val() == 0)
			{
				event.preventDefault();
				alert("Au moins un cours structur\u00e9 n'\est pas renseign\u00e9.");
				return false;
			}
		});

	});
	


	$('.change_learner').change(function(){
		document.location.href="common_learner_account.cfm?u_id="+$(this).val();	
	})

})
</script>

</body>
</html>