<cfabort>

<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">
<cfparam name="p_id" default="0">

<cfquery name="get_trainers" datasource="#SESSION.BDDSOURCE#">
SELECT user_id, user_firstname, user_name FROM user u
WHERE profile_id = 4
ORDER BY user_firstname
</cfquery>

<cfset get_lessons_scheduled = obj_query.oget_lessons_scheduled(p_id="#p_id#",tselect="#tselect#")>
<cfset get_lessons_missed = obj_query.oget_lessons_missed(p_id="#p_id#",tselect="#tselect#")>
<cfset get_lessons_inprogress = obj_query.oget_lessons_inprogress(p_id="#p_id#",tselect="#tselect#")>
<cfset get_lessons_cancelled = obj_query.oget_lessons_cancelled(p_id="#p_id#",tselect="#tselect#")>
<cfset get_lessons_completed = obj_query.oget_lessons_completed(p_id="#p_id#",tselect="#tselect#")>
	
<cfif get_lessons_scheduled.h neq ""><cfset lesson_scheduled = numberformat(get_lessons_scheduled.h,'____.__')><cfelse><cfset lesson_scheduled = 0></cfif>
<cfif get_lessons_inprogress.h neq ""><cfset lesson_inprogress = numberformat(get_lessons_inprogress.h,'____.__')><cfelse><cfset lesson_inprogress = 0></cfif>
<cfif get_lessons_cancelled.h neq ""><cfset lesson_cancelled = numberformat(get_lessons_cancelled.h,'____.__')><cfelse><cfset lesson_cancelled = 0></cfif>
<cfif get_lessons_missed.h neq ""><cfset lesson_missed = numberformat(get_lessons_missed.h,'____.__')><cfelse><cfset lesson_missed = 0></cfif>
<cfif get_lessons_completed.h neq ""><cfset lesson_completed = numberformat(get_lessons_completed.h,'____.__')><cfelse><cfset lesson_completed = 0></cfif>

<cfset learner_lesson_done = lesson_inprogress+lesson_completed>
<cfset trainer_lesson_done = lesson_completed>

<cfset __tooltip_view_ln = obj_translater.get_translate('tooltip_view_ln')>
<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_fill_pta = obj_translater.get_translate('tooltip_fill_pta')>
<cfset __tooltip_fill_na = obj_translater.get_translate('tooltip_fill_na')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>
<cfset __tooltip_cancel_lesson = obj_translater.get_translate('tooltip_cancel_lesson')>
			
</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Lesson list">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row" style="margin-top:10px">
			
				<div class="col-md-6">
					<div class="card" style="min-height:140px">						
						<div class="card-body">
							<h4 class="card-title">S&eacute;lection : <cfoutput>#mlongsel# #ysel#</cfoutput></h4>
							<div class="row">
								<div class="col-md-12 mt-4">
								<cfform action="cs_lessons.cfm">
								<div class="form-row">
									<div class="col">
										<cfselect class="form-control" name="p_id" query="get_trainers" value="user_id" display="user_firstname" selected="#p_id#">
											<option value="0" <cfif p_id eq "0">selected</cfif>>---ALL TRAINERS----</option>
										</cfselect>
									</div>
									
									<div class="col">
										<select class="form-control" name="msel">

										<cfloop from="1" to="12" index="m">
										<cfoutput>
											<cfif SESSION.LANG_CODE neq "fr">
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
											<cfelse>
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
											</cfif>
											
											
										</cfoutput>
										</cfloop>
										</select>
									</div>
									
									<div class="col">
									
										<select class="form-control" name="ysel">
										<cfloop from="2019" to="#year(now())+1#" index="y">
										<cfoutput>
											<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
										</cfoutput>
										</cfloop>
										</select>
										
										<cfoutput><a href="cs_lessons.cfm" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput>
									</div>
									
									<div class="col">
										<cfoutput>
										<input type="submit" value="GO" class="btn btn-info">
										<a href="exporter/export_lessons.cfm?tselect=#tselect#" class="btn btn-success">Export</a>
										</cfoutput>
									</div>
								</div>
								</cfform>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-md-6">
					<div class="card" style="min-height:140px">				
						<div class="card-body">
							<h4 class="card-title">Activit&eacute; (h)</h4>
							<br><br>
							<cfoutput>	
							<button type="button" class="btn btn btn-warning p-2" onclick="location.href='cs_lessons.cfm?st_id=1'"><i class="far fa-calendar-alt"></i> #obj_translater.get_translate('badge_planned_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_scheduled neq "0">#lesson_scheduled# h<cfelse>-</cfif></h3></button>
							<button type="button" class="btn btn btn-success p-2" onclick="location.href='cs_lessons.cfm?st_id=2'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_inprogress')#<br><h3 class="m-0 text-lowercase"><cfif lesson_inprogress neq "0">#lesson_inprogress# h<cfelse>-</cfif></h3></button>
							<button type="button" class="btn btn btn-success p-2" onclick="location.href='cs_lessons.cfm?st_id=5'"><i class="far fa-thumbs-up"></i> #obj_translater.get_translate('badge_completed_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_completed neq "0">#lesson_completed# h<cfelse>-</cfif></h3></button>
							<button type="button" class="btn btn btn-danger p-2" onclick="location.href='cs_lessons.cfm?st_id=4'"><i class="far fa-thumbs-down"></i> #obj_translater.get_translate('badge_missed_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_missed neq "0">#lesson_missed# h<cfelse>-</cfif></h3></button>
							<button type="button" class="btn btn btn-danger p-2" onclick="location.href='cs_lessons.cfm?st_id=3'"><i class="fas fa-times"></i> #obj_translater.get_translate('badge_cancelled_f_p')#<br><h3 class="m-0 text-lowercase"><cfif lesson_cancelled neq "0">#lesson_cancelled# h<cfelse>-</cfif></h3></button>
							</cfoutput>
						</div>
					</div>
				</div>
				
			</div>
			
			
			
			<div class="row">
			
				<div class="col-md-12">
					<div class="card">
						<div class="card-body">
							<cfset show_tab = "0">
							<cfset period_month = "#ysel#-#msel#">
							
							<cfinclude template="./widget/wid_lesson_list_cs.cfm">
							
						</div>
					</div>
				
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
	$('.btn_view_log').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		alert(idtemp)
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Comments");
		$('##modal_body_lg').load("modal_window_log.cfm?u_id="+idtemp, function() {
		
			
		});
	});
</script>

</body>
</html>