<!DOCTYPE html>

<cfsilent>

<cfparam name="f_id" default="2">
<cfparam name="lev_id" default="pA">


<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_tpmaster2 tp
INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id	
WHERE tp.tpmaster_prebuilt = 1 AND tp.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
<cfif lev_id eq "pA">
AND tpmaster_level like '%A%'
<cfelseif lev_id eq "pB1">
AND tpmaster_level like '%B1%'
<cfelseif lev_id eq "pB2">
AND tpmaster_level like '%B2%'
<cfelseif lev_id eq "pC">
AND tpmaster_level like '%C%'
</cfif>
ORDER BY tp.tpmaster_id, tc.sessionmaster_rank ASC 
</cfquery>	


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

<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#")>

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
      
		<cfset title_page = "Mon Training Center">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">

			<div class="row">
				<div class="col-md-12">
				
					<!--- <cfinclude template="./incl/incl_nav_tc.cfm"> --->
					
					<div class="card border-top border-info">
						<div class="card-body">
						
							<div class="row">
								<div class="col-xl-10">
									<h5 class="d-inline mr-4">Parcours conseill&eacute;s : </h5>
									<cfoutput>								
									<a class="btn <cfif lev_id eq "pA">btn-success active<cfelse>btn-link</cfif>" type="button" href="common_prefilled.cfm?f_id=#f_id#&lev_id=pA<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>&u_id=#u_id#</cfif>">#obj_translater.get_translate('level')# A<br>(#obj_translater.get_translate('l_beginner')# )</a>
									<a class="btn <cfif lev_id eq "pB1">btn-info active<cfelse>btn-link</cfif>" type="button" href="common_prefilled.cfm?f_id=#f_id#&lev_id=pB1<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>&u_id=#u_id#</cfif>">#obj_translater.get_translate('level')# B1<br>(#obj_translater.get_translate('l_preintermediate')# )</a>
									<a class="btn <cfif lev_id eq "pB2">btn-info active<cfelse>btn-link</cfif>" type="button" href="common_prefilled.cfm?f_id=#f_id#&lev_id=pB2<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>&u_id=#u_id#</cfif>">#obj_translater.get_translate('level')# B2<br>(#obj_translater.get_translate('l_intermediate')# )</a>
									<a class="btn <cfif lev_id eq "pC">btn-danger active<cfelse>btn-link</cfif>" type="button" href="common_prefilled.cfm?f_id=#f_id#&lev_id=pC<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>&u_id=#u_id#</cfif>">#obj_translater.get_translate('level')# C<br>(#obj_translater.get_translate('l_advanced')# )</a>
									</cfoutput>
								</div>
							</div>
							
							<div class="alert alert-info mt-3" role="alert">
								<div class="media">
									<i class="fas fa-bookmark fa-3x mr-3"></i>
									<div class="media-body">
										<strong>D&eacute;couvrez notre s&eacute;lection de cours</strong>
										<br>
										Vous avez la possibilit&eacute; de construire votre parcours de formation sur-mesure ou opter directement pour l'un de nos packages de formation.
									</div>
								</div>								
							</div>
						
						
							<ul class="nav nav-tabs" id="tp_list" role="tablist">
								<cfoutput query="get_sm" group="tpmaster_hour">
								<li class="nav-item">		
								<a href="##f_#tpmaster_hour#" class="nav-link <cfif tpmaster_hour eq "5">active</cfif>" role="tab" data-toggle="tab">
								#tpmaster_hour# h
								</a>
								</li>
								</cfoutput>
							</ul>
							
							<div class="tab-content">
								<!---<cfset counter = "0">--->
								<cfoutput query="get_sm" group="tpmaster_hour">
								<div role="tabpanel" class="tab-pane <cfif tpmaster_hour eq "5">active show</cfif>" id="f_#tpmaster_hour#" style="margin-top:15px;">
									
									<div class="accordion" id="accordion">
									
									<cfoutput group="tpmaster_id">
									<!---<cfset counter ++>--->
									<div>
										<div class="card-header p-1">
											<button class="btn btn-link btn-sm" type="button" data-toggle="collapse" data-target="##collapse_#tpmaster_id#" aria-expanded="true" aria-controls="collapse_#tpmaster_id#">
											#tpmaster_name# [#tpmaster_hour#h]
											</button>
										</div>
										<div id="collapse_#tpmaster_id#" class="collapse <!---<cfif counter eq "1">show</cfif>--->" data-parent="##accordion">
											<div>
												<table class="table">
													<cfoutput>
													<tr class="bg-white">
														<td>
														
															<cfif fileexists("/home/www/winegroup/www/manager/lms3/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
															<img src="#SESSION.BO_ROOT_URL#/assets/img_material/thumbs/#sessionmaster_code#.jpg" width="60" class="img-responsive">
															<cfelseif fileexists("/home/www/winegroup/www/manager/lms3/assets/img_material/thumbs/#sessionmaster_id#.jpg")>			
															<img src="#SESSION.BO_ROOT_URL#/assets/img_material/thumbs/#sessionmaster_id#.jpg" width="60" class="img-responsive">
															<cfelse>
															<img src="#SESSION.BO_ROOT_URL#/assets/img/wefit_lesson.jpg" width="60" class="img-responsive">
															</cfif>
														</td>
														<td>#sessionmaster_name#<br><small>#sessionmaster_description#</small></td>
														<td>
														<div align="center" class="bg-light px-2 border">
														#sessionmaster_schedule_duration#<br>min
														</div>
														</td>
													</tr>
													</cfoutput>
												</table>
											</div>
										</div>
									</div>													
									</cfoutput>
									</div>
								</div>
								</cfoutput>
							</div>
											
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
	
	$('.btn_menu').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
		$('.tabmenu').collapse('hide');
		$('#tabmenu_'+idtemp).collapse('show');
	});
})
</script>

<script>

</script>

</body>
</html>