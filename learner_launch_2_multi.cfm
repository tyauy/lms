<!DOCTYPE html>

<cfsilent>
	
<cfset step = "4">
<cfset test = "1">
<!--- BOOL DISPLAY FILTER BLOCK IN get_slot_multi --->
<cfset showfilter = "1">
<cfset SESSION.LAUNCH_MULTI = "1">

<cfset secure = "3,9">
<cfinclude template="./incl/incl_secure.cfm">	
			
<!--- TODO recuperer le TP ID --->
<cfset u_id = SESSION.USER_ID>
<cfset t_id = SESSION.TP_ID>


<cfif t_id eq "" OR t_id eq 0>
	<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",m_id="1,2,7,11")>
	<cfset t_id = get_tps.tp_id>
</cfif>

<cfset progress_completed = 0>
<cfset progress_total = 0>
<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#",l_by="yes")>
<cfoutput query="get_session" group="session_id">
	<cfset progress_total += 1>
	<cfif status_id neq "">
		<cfset progress_completed += 1>
	</cfif>

</cfoutput>


</cfsilent>
	
	<!--- <cfset s_dur = 60> --->
	<cfset __alert_no_avail = obj_translater.get_translate('alert_no_avail')>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<script type = "text/javascript" >  
		function preventBack() { window.history.forward(); }  
		setTimeout("preventBack()", 0); 
		window.onunload = function () { null };  
	</script>
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			<cfinclude template="./incl/incl_nav_learner.cfm">

			<cfinclude template="./incl/incl_multi_filter.cfm">

			<cfinclude template="get_slot_multi.cfm">
			
		</div>
	</div>
</div>
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  	<!--- <td>
	<cfif lesson_id neq "">
		<cfoutput group="lesson_id">
			<span class="badge badge-#status_css# btn_view_lesson" id="l_#lesson_id#" style="cursor:pointer">#status_name#</span>															
		</cfoutput>
	</cfif>
</td> --->

<!--- <cfinclude template="./incl/incl_scripts.cfm"> --->
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_multi_script.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	$(document).ready(function() {})
</script>


</body>
</html>