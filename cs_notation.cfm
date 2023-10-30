<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,4,5,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="g_id" default="0">
<cfparam name="t_id" default="0">
<cfparam name="f_id" default="0">
<cfparam name="type" default="learner">

<cfquery name="get_account_group" datasource="#SESSION.BDDSOURCE#">
SELECT g.group_id, g.group_name, COUNT(rating_id) as nb
FROM account_group g

LEFT JOIN account a ON a.group_id = g.group_id
LEFT JOIN user u ON u.account_id = a.account_id
LEFT JOIN lms_rating r ON u.user_id = r.user_id

GROUP BY group_id
order by g.group_name
</cfquery>

<cfquery name="get_formation_lang" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name
FROM lms_formation f
</cfquery>
<!--- <cfinvoke component="api/ratings/ratings_get" method="oget_notation" returnvariable="get_notation">
	<cfinvokeargument name="l_id" value="#l_id#">
	<cfinvokeargument name="type" value="#type#">
</cfinvoke>	--->
<cfif type eq "learner">

	<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
	SELECT u.user_id, u.user_firstname, u.user_name FROM user u
	INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
	WHERE upc.profile_id = 4
	AND u.user_status_id = 4
	ORDER BY u.user_firstname
	</cfquery>

	<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT
	r.*,
	u.user_id, u.user_firstname, u.user_name,
	u2.user_id as trainer_id, u2.user_firstname as trainer_firstname,
	sm.sessionmaster_name,
	a.account_name, a.account_id,
	l.lesson_start,
	f.formation_id,
	COALESCE(r.rating_date, l.lesson_start) as filtered_date

	FROM lms_rating r

	INNER JOIN user u ON u.user_id = r.user_id
	INNER JOIN user u2 ON u2.user_id = r.trainer_id

	INNER JOIN account a ON a.account_id = u.account_id

	INNER JOIN lms_lesson2 l ON r.lesson_id = l.lesson_id
	INNER JOIN lms_tpsession s ON s.session_id = l.session_id
	INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	
	left join user_teaching t on u2.user_id=t.user_id
	INNER JOIN lms_formation f ON f.formation_id = t.formation_id 
	
	<cfif SESSION.USER_PROFILE eq "TRAINER">
	WHERE u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
	<cfelseif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND isdefined("u_id"))>
	WHERE u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
	<cfelseif (listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE) AND not isdefined("u_id"))>
	WHERE 1 = 1
	<cfelse>
	WHERE 1 = 0
	</cfif>

	<cfif isdefined("g_id") AND g_id neq "0">
	AND a.group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#g_id#">
	</cfif>

	<cfif isdefined("t_id") AND t_id neq "0">
	AND u2.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	</cfif>

	<cfif isdefined("f_id") AND f_id neq "0">
	AND t.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
	</cfif>
	GROUP BY r.rating_id
	ORDER BY rating_id DESC limit 100
	

	</cfquery>

	<cfquery name="get_rating_trainer_lang" datasource="#SESSION.BDDSOURCE#">
	SELECT g.group_id, g.group_name, COUNT(rating_id) as nb
	FROM account_group g
	
	LEFT JOIN account a ON a.group_id = g.group_id
	LEFT JOIN user u ON u.account_id = a.account_id
	LEFT JOIN lms_rating r ON u.user_id = r.user_id
	
	GROUP BY group_id
	ORDER BY g.group_name
	</cfquery>

<cfelseif type eq "tm">

	<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	r.*
	FROM lms_rating_tm r
	ORDER BY rating_tm_id DESC
	</cfquery>

</cfif>



</cfsilent> 
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.perso_img .st0{  
	fill:#933088;
}
.badge_img .st0{    
	fill:#80BB46;
}
</style>

<body>

<div class="wrapper">
	
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_activity_report')#">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif type eq "learner">
			<div class="row mt-2">
				<div class="col-md-12">
					<select class="form-control" name="group" onchange="document.location.href='<cfoutput>cs_notation.cfm?f_id=#f_id#&t_id=#t_id#&g_id='+$(this).val()</cfoutput>">
						<option value="0" <cfif g_id eq "0">selected</cfif>>---Select Group---</option>
						<cfoutput query="get_account_group">
						<option value="#group_id#" <cfif g_id eq get_account_group.group_id>selected</cfif>>#group_name# [#nb#]</option>
						</cfoutput>
					</select>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col-md-12">
					<select class="form-control" name="group" onchange="document.location.href='<cfoutput>cs_notation.cfm?g_id=#g_id#&t_id=#t_id#&f_id='+$(this).val()</cfoutput>">
						<option value="0" <cfif f_id eq "0">selected</cfif>>---Select Language---</option>
						<cfoutput query="get_formation_lang">
						<option value="#formation_id#" <cfif f_id eq get_formation_lang.formation_id>selected</cfif>>#formation_name#</option>
						</cfoutput>
					</select>
				</div>
			</div>
			<div class="row mt-2">
				<div class="col-md-12">
				<select class="form-control" name="group" onchange="document.location.href='<cfoutput>cs_notation.cfm?g_id=#g_id#&f_id=#f_id#&t_id='+$(this).val()</cfoutput>">
					<option value="0" <cfif t_id eq "0">selected</cfif>>---Select Trainer---</option>
					<cfoutput query="get_trainers">
					<option value="#user_id#" <cfif t_id eq user_id>selected</cfif>>#user_firstname# #ucase(user_name)#</option>
					</cfoutput>
				</select>
				</div>
			</div>
			</cfif>

			
			<cfif type eq "learner">
			<div class="card border-top border-success mt-3">
				<div class="card-body">
					
					<h6>Notation lessons Learner</h6>
					<br>
					<div class="table-responsive" id="scrollableElement" style="max-height: 1000px;">
						<table class="table table-bordered" >
							<thead>
							<tr>
								<th class="bg-light">ID</th>
								<th class="bg-light">Date</th>
								<th class="bg-light" width="250">Acc/Lear</th>
								<th class="bg-light">Trainer</th>
								<th class="bg-light">Lesson</th>
								<th class="bg-light">Languages Taught by trainer</th>
								<th class="bg-light">Support</th>
								<th class="bg-light">Trainer</th>
								<th class="bg-light">Techno</th>
								<th class="bg-light">Comments</th>
								<th class="bg-light">Highlight</th>
								<th class="bg-light">Badges</th>
								<th class="bg-light">Perso</th>
								<cfif session.user_id eq 202>
								<th class="bg-light">Admin</th>
								</cfif>
							</tr>
							</thead>
						<cfoutput query="get_notation">


						<!--- GET BADGES --->
						<cfinvoke component="api/ratings/badges_get" method="oread_badges_bylesson" returnvariable="badges">
							<cfinvokeargument name="l_id" value="#lesson_id#">
						</cfinvoke>

						<!--- GET PERSO --->
						<cfinvoke component="api/ratings/ratings_personality_get" method="oread_trainer_personality" returnvariable="perso">
							<cfinvokeargument name="tr_id" value="#trainer_id#">
							<cfinvokeargument name="u_id" value="#user_id#">
						</cfinvoke>

						<cfinvoke component="api/users/user_trainer_get" method="get_trainer_teach_ready" returnvariable="user_ready_go">
							<cfinvokeargument name="user_id" value="#trainer_id#">
						</cfinvoke>
						<tbody>
						<tr>
							<td>#rating_id#</td>
							<td>
								#dateformat(filtered_date,'dd/mm/yyyy')#
							</td>
							<td>
								<a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#</a>
								<br>
								<cfif SESSION.USER_PROFILE neq "trainer"><a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #ucase(user_name)#</a><cfelse>-</cfif>
							</td>
							<td><a href="common_trainer_account.cfm?u_id=#trainer_id#">#trainer_firstname#</a></td>
							<td><small>#sessionmaster_name#</small></td>
							<td data-lang="#user_ready_go.formation_code#"><cfloop query="user_ready_go"><span class="lang-sm m-1" lang="#lcase(user_ready_go.formation_code)#"></span></cfloop></td>
							<td><cfif rating_support lte "3"><span class="badge badge-pill badge-danger">#rating_support#</span><cfelse>#rating_support#</cfif></td>
							<td><cfif rating_teaching lte "3"><span class="badge badge-pill badge-danger">#rating_teaching#</span><cfelse>#rating_teaching#</cfif></td>
							<td><cfif rating_techno lte "3"><span class="badge badge-pill badge-danger">#rating_techno#</span><cfelse>#rating_techno#</cfif></td>
							<td><small>#rating_description#</small></td>
							<td>
								<button class="btn btn-sm btn_switch_status <cfif rating_highlight eq "1">btn-success<cfelse>btn-outline-success</cfif>" id="rating_#rating_id#">
									<i class="fa-regular fa-lightbulb-on"></i>
								</button>
							</td>
							<td>
								<cfif badges.recordcount eq "0">
									-- 
								<cfelse>
								<!--- <cfdump var=#badges#> --->
								<div class="d-flex">
								<cfloop query="#badges#"> 
									<!--- <div style="width:30px"> --->
										<!--- badge image --->
										#badge_name#<br>
										<!--- <div class="badge_img" id="badge_#badge_id#" data-toggle="tooltip" data-placement="top" title="#badge_name#">
											<cffile action="read" file="https://lms.wefitgroup.com/assets/img_badge/#badge_id#_G.svg" variable="badge_#badge_id#">
											#Variables["badge_#badge_id#"]#
										</div> --->
										<!--- badge title --->
										<!--- <div class="cursored text-center text-wrap">
											<label class="form-check-label d-block" for="#badge_id#">#badge_name#</label>
										</div> --->
									<!--- </div> --->
								</cfloop>
								</div>
								</cfif>
							</td>

							<td>
								<cfif perso.recordcount eq "0">
									-- 
								<cfelse>
								<!--- <cfdump var=#badges#> --->
								<div class="d-flex">
								<cfloop query="#perso#"> 
									#perso_name#<br>
									<!--- <div style="width:30px"> --->
										<!--- badge image --->
										<!--- <div class="perso_img" id="perso_#perso_id#" data-toggle="tooltip" data-placement="top" title="#perso_name#">
											<cffile action="read" file="https://lms.wefitgroup.com/assets/img_personality/#perso_id#_G.svg" variable="perso_#perso_id#">
											#Variables["perso_#perso_id#"]#
										</div> --->
										<!--- badge title --->
										<!--- <div class="cursored text-center text-wrap">
											<label class="form-check-label d-block" for="#badge_id#">#badge_name#</label>
										</div> --->
									<!--- </div> --->
								</cfloop>
								</div>
								</cfif>
							</td>
							<cfif session.user_id eq 202>
								<td class="btn btn-danger btn_del_rating" id="rating_#rating_id#"><i class="fa-thin fa-trash"></i>rating_id#rating_id# lesson_id #lesson_id#</td>
								</cfif>
						</tr>
						</cfoutput>
						</tbody>
						</table>
					</div>

				</div>
			</div>

			<div class="card border-top border-success">
				<div class="card-body">
					<h6>Export</h6>

					<form action="exporter/_EM_export_reporting_tm.cfm" method="post">
						<div class="row align-items-end">
							<cfoutput>
							<div class="col-md-8">										
								<div class="control-group">
									<label for="date_schedule_from" class="control-label">#obj_translater.get_translate('short_between2')#</label>
									<div class="controls">
										<div class="input-group">
											<cfset from_dateformat = "#dateformat(now(),'01/mm/yyyy')#">
											<cfset to_dateformat = "#dateformat(now(),'dd/mm/yyyy')#">
											<input id="date_schedule_from" name="date_schedule_from" type="text" class="datepicker form-control" autocomplete="off" value="#from_dateformat#"/>
											<label for="date_schedule_from" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
										</div>
									</div>
								</div>
		
								<div class="control-group">
									<label for="date_schedule_to" class="control-label">#obj_translater.get_translate('short_and2')#</label>
									<div class="controls">
										<div class="input-group">
											<input id="date_schedule_to" name="date_schedule_to" type="text" class="datepicker form-control" autocomplete="off" value="#to_dateformat#" />
											<label for="date_schedule_to" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt text-white"></i></label>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-4">	
								<input type="hidden" name="g_id" value="#g_id#">
								<input type="submit" value="#obj_translater.get_translate('btn_export')#" class="btn btn-info" style="display:inline">											
							</div>
							</cfoutput>
							
						</div>
					</form>
				</div>
			</div>

			<cfelseif type eq "tm">

			<div class="card border-top border-success">
				<div class="card-body">
					<h6>Notation TM</h6>
					<br>
					<table class="table table-bordered">
						<tr>
							<th class="bg-light">Date</th>
							<th class="bg-light" colspan="2">Les formations ont-elles globalement r&eacute;pondu &agrave; vos attentes ?</th>
							<th class="bg-light">Avez-vous pu remarquer la mise en pratique des comp&eacute;tences acquises de vos salari&eacute;(e)s?</th>
							<th class="bg-light" colspan="2">Est-ce que vos collaborateurs/ collaboratrices ont pris du plaisir &agrave; suivre une formation chez WEFIT?</th>
							<th class="bg-light">Quels ont &eacute;t&eacute; les points forts de WEFIT ?</th>
							<th class="bg-light">Quels ont &eacute;t&eacute; les points faibles de WEFIT ?</th>
							<th class="bg-light" colspan="2">Voyez-vous WEFIT comme un partenaire qui vous aide face &agrave; vos probl&eacute;matiques ?</th>
							<th class="bg-light">Comment aller plus loin dans notre partenariat ?</th>
							<th class="bg-light">Pensez-vous continuer &agrave; travailler avec WEFIT pour les 3 prochaines ann&eacute;es ?</th>
							
						</tr>
						<cfoutput query="get_notation">
						<tr>
							<td>#dateformat(rating_tm_date,'dd/mm/yyyy')#</td>
							<td>#ans_1#</td>
							<td>#ans_2#</td>
							<td>#ans_3#</td>
							<td>#ans_4#</td>
							<td>#ans_5#</td>
							<td>#ans_6#</td>
							<td>#ans_7#</td>
							<td>#ans_8#</td>
							<td>#ans_9#</td>
							<td>#ans_10#</td>
							<td>#ans_11#</td>
						</tr>
						</cfoutput>
							
					</table>
				
				</div>
			</div>
			</cfif>

		</div>
	
	<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>


<cfinclude template="./incl/incl_scripts.cfm">
<cfinclude template="./incl/incl_scripts_param.cfm">


<script>

$(document).ready(function() {

	

	/****** INIT BOOSTRAP COMPONENTS *******/	
	$('[data-toggle="popover"]').popover({
	trigger: 'focus',
	html: true
	});
	$('[data-toggle="tooltip"]').tooltip();



	$('.btn_switch_status').click(function(event) {		
		event.preventDefault();

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var rating_id = idtemp[1];	

		// alert(rating_id);
		// Store the current vertical scroll position
		 var scrollableElement = document.getElementById('scrollableElement');
        localStorage.setItem("scroll_x", scrollableElement.scrollLeft.toString());
        localStorage.setItem("scroll_y", scrollableElement.scrollTop.toString());
		$.ajax({
			url : './api/ratings/ratings_post.cfc?method=switch_rating_highlight',
			method : 'POST',
			data : {r_id: rating_id},				
			success : function(result, status) {
				console.log(result);
				if(result === 1)
				{
					$("rating_"+rating_id).addClass("btn-success");
					$("rating_"+rating_id).removeClass("btn-outline-success");
				}
				else
				{
					$("rating_+"+rating_id).removeClass("btn-success");
					$("rating_"+rating_id).addClass("btn-outline-success");
				}
				// Reload the page and restore the vertical scroll position
				
			
				location.reload();
				
			}
		});

		

	});

		$('.btn_del_rating').click(function(event) {		
				event.preventDefault();

				var idtemp = $(this).attr("id");
				var idtemp = idtemp.split("_");
				var rating_id = idtemp[1];	
				// Store the current vertical scroll position
			 var scrollableElement = document.getElementById('scrollableElement');
			 console.log('scrollableElement:', scrollableElement);  // Log the element itself
        	localStorage.setItem("scroll_x", scrollableElement.scrollLeft.toString());
        	localStorage.setItem("scroll_y", scrollableElement.scrollTop.toString());
 console.log('Before AJAX - scrollLeft:', scrollableElement.scrollLeft, 'scrollTop:', scrollableElement.scrollTop);  
				//alert(rating_id);
				
			
				$.ajax({
					url : './api/ratings/ratings_post.cfc?method=delete_rating',
					method : 'POST',
					data : {r_id: rating_id},				
					success : function(result, status) {
						alert ('deleted');
							location.reload();
						
					}
				});

			});
 window.addEventListener("load", function (e) {
        var x = parseInt(localStorage.getItem("scroll_x"), 10) || 0;
        var y = parseInt(localStorage.getItem("scroll_y"), 10) || 0;

        var scrollableElement = document.getElementById('scrollableElement');
        console.log('After Load - stored x:', x, 'stored y:', y);  // Add this line

        scrollableElement.scrollLeft = x;
        scrollableElement.scrollTop = y;

        console.log('After Load - applied scrollLeft:', scrollableElement.scrollLeft, 'scrollTop:', scrollableElement.scrollTop);  // Add this line

        localStorage.removeItem("scroll_x");
        localStorage.removeItem("scroll_y");
    });

		
});
</script>
	


</body>
</html>