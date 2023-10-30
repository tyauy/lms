<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,7,9">
<cfinclude template="./incl/incl_secure.cfm">

<cfparam name="f_id" default="2">
<cfparam name="lev_id" default="sign">

<cfif listFindNoCase("LEARNER,TEST,GUEST", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif SESSION.USER_PROFILE eq "TRAINER">

	<cfset u_id = u_id>
	<cfset p_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_learner_trainer" returnvariable="get_learner_trainer">
		<cfinvokeargument name="p_id" value="#p_id#">
	</cfinvoke>

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset u_id = SESSION.USER_ID>
	
	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	
</cfif>

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",schedule_only="1",m_id="1,2")>

<cfif not isdefined("t_id")>
	<cfset t_id = get_tps.tp_id>
</cfif>

	<cfset get_lesson = obj_query.oget_lessons(u_id="#u_id#",t_id="#t_id#",st_id="4,5",tosign="1",m_id="1")>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
h1,h2,h3,h4,h5{
	font-family: 'Titillium Web', sans-serif;
}
</style>

<body>

<div class="wrapper">
							
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_signature')#">
		
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="row">
				<div class="col-md-12">
				
					<!----<cfinclude template="./incl/incl_nav_tc.cfm">--->
					<div class="tabmenu row" id="tabmenu_sign">
			
						<div class="col-xl-12">
							<cfoutput query="get_tps">
							<a href="learner_sign.cfm?t_id=#tp_id#<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>&u_id=#u_id#</cfif>" class="btn <cfif isdefined("t_id") AND t_id eq tp_id>btn-info active<cfelse>btn-link</cfif>">
							#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
							</a>
							</cfoutput>
						</div>
					</div>
					
					<div class="card border">
						<div class="card-body">
					
							<div class="w-100">
								<h5 class="d-inline"><i class="fa-thin fa-rocket-launch fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_awaiting_signature')#</cfoutput></h5>
								<hr class="border-dark mb-1 mt-2">
							</div>

							<cfif get_lesson.recordcount neq "0">
							<div class="alert alert-info mt-3" role="alert">
								<div class="media">
									<i class="fa-light fa-signature fa-3x mr-3"></i>
									<div class="media-body">
										<strong><cfoutput>#obj_translater.get_translate('alert_title_signature')#</cfoutput></strong>
										<br>
										<cfoutput>#obj_translater.get_translate('alert_body_signature')#</cfoutput>
									</div>
								</div>								
							</div>
							<cfelse>
							<div class="alert alert-success mt-3" role="alert">
								<div class="media">
									<i class="fa-light fa-signature fa-3x mr-3"></i>
									<div class="media-body">
										<strong><cfoutput>#obj_translater.get_translate('alert_title_no_signature')#</cfoutput></strong>
									</div>
								</div>								
							</div>
							</cfif>
						
							<cfif get_lesson.recordcount neq "0">
							<div class="table-responsive">			
							<table class="table">				
													
							<tr bgcolor="#F3F3F3">
								<cfoutput>
								<th width="7%"><label>#obj_translater.get_translate('table_th_status')#</label></th>
								<th width="10%"><label>#obj_translater.get_translate('table_th_trainer')#</label></th>
								<th width="10%"><label>#obj_translater.get_translate('table_th_tp')#</label></th>
								<th width="17%"><label>#obj_translater.get_translate('table_th_course')#</label></th>
								<th width="4%"><label>#obj_translater.get_translate('table_th_method')#</label></th>
								<th width="10%"><label>#obj_translater.get_translate('table_th_date')#</label></th>
								<th width="4%"><label>#obj_translater.get_translate('table_th_duration_short')#</label></th>
								<!---<th width="4%"><label>#ucase(obj_translater.get_translate('table_th_signature'))# Formateur</label></th>--->
								<th width="20%" align="center" colspan="2"><label>#ucase(obj_translater.get_translate('table_th_signature'))#</label></th>
								</cfoutput>
							</tr>
							<cfoutput query="get_lesson">
							<cfform id="launch_form_#lesson_id#" action="updater_sign.cfm">
							<tr>
								<td>
									<span class="badge badge-#status_css#">#status_name#</span>
								</td>
								<td>
									#planner_firstname# <!---#obj_lms.get_thumb(user_id="#planner_id#",size="24",responsive="no")# --->
								</td>
								<td>
									<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#"><cfif tp_id neq "">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#")#<cfelse>-</cfif></a>
								</td>
								<td>
									<!---<span class="badge badge-primary btn_view_session" id="sm_#sessionmaster_id#" style="cursor:pointer">?</span>	--->
									#sessionmaster_name#
									<cfif sessionmaster_id eq "694">
									
									#obj_translater.get_translate_complex('lrn_last_lesson')#
									
									</cfif>
								</td>
								<td>
									<img src="./assets/img/picto_methode_#method_id#.png" width="20" style="margin-right:2px">
								</td>
								<td>
									#dateformat(lesson_start,'dd/mm/yyyy')# #timeformat(lesson_start,'HH:mm')#
								</td>
								<td>
									#lesson_duration# min
								</td>
								<!---<td align="center">
									#obj_lms.get_trainer_signature(p_id="#planner_id#", size="80")#
								</td>--->
								<cfif fileexists("#SESSION.BO_ROOT#/assets/signature/#lesson_id#.png")>
								<td align="center" colspan="2">
									<img src="../assets/signature/#lesson_id#.png" align="center" width="200">
								</td>
								<cfelseif signature_base64 neq "">
									<td align="center" colspan="2">
										<img src="#signature_base64#" align="center" width="200">
									</td>
								<cfelse>
								<td align="center">
									<div id="content_#lesson_id#" style="border:1px solid ##000000; width:300px;"><div id="signatureparent"><div id="signature_#lesson_id#"></div></div><div id="tools"></div></div>
								</td>
								<td>	
									<input type="submit" name="" class="btn btn-sm" value="#obj_translater.get_translate('btn_sign_short')#">
									<input type="hidden" name="signature_base64_#lesson_id#" id="signature_base64_#lesson_id#" value="">
									<input type="hidden" name="l_id" value="#lesson_id#">
									<input type="hidden" name="t_id" value="#t_id#">
									<input type="hidden" name="u_id" value="#u_id#">
								</td>
								</cfif>
								<!---<td>
									<a href="##" class="btn btn-sm btn-outline-info btn_view_session" id="sm_#sessionmaster_id#" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"><i class="fas fa-book"></i> <span class="d-none d-xl-block">#__btn_support_short#</span></a>
								</td>
								<td>
									<cfif status_id eq "5" OR status_id eq "6">
										<cfif note_id neq "" AND lesson_lock eq "1">
											<a target="_blank" href="./tpl/ln_container.cfm?l_id=#lesson_id#" class="btn btn-sm btn-outline-info" role="button" data-toggle="tooltip" data-placement="top" title="#__tooltip_view_ln#"><i class="fas fa-bookmark"></i> <span class="d-none d-xl-block">#__btn_notes_short#</span></a>
										</cfif>
									</cfif>
								</td>--->
							</tr>

							</cfform>

							</cfoutput>
							</table>
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
$(document).ready(function() {

	
	<cfoutput query="get_lesson">
	var $sigdiv_#lesson_id# = $("##signature_#lesson_id#").jSignature({'UndoButton':true});
	$("##signature_#lesson_id#").resize();
	
	
	$("##launch_form_#lesson_id#").submit(function( event ) {
		
		if( $sigdiv_#lesson_id#.jSignature('getData', 'native').length == 0) {
			alert('<cfoutput>#obj_translater.get_translate('js_warning_signature')#</cfoutput>');
			return false;
		}
		else
		{
		var data = $sigdiv_#lesson_id#.jSignature('getData', 'default');
			$('##signature_base64_#lesson_id#').val(data);
		}
		
	});
	
	</cfoutput>

})	
</script>


</body>
</html>