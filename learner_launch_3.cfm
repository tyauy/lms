<!DOCTYPE html>

<cfsilent>
	
<!--- <cfif SESSION.USER_ID eq "28538">
<cfset SESSION.LAUNCHING_STEP_4_MODAL = "0">
</cfif> --->

<cfset step = "3">
<cfset SESSION.CUR_STEP = "3">

<!--- BOOL DISPLAY FILTER BLOCK IN get_slot_multi --->
<cfset showfilter = "0">
<cfset show_partner_header = "1">

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

<cfquery name="get_tp_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT t.tp_id
	FROM lms_tp t 
	inner join lms_tpplanner tpp on tpp.tp_id = t.tp_id AND tpp.active = 1
	WHERE t.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
	
</cfquery>

<cfif get_tp_trainer.recordcount neq 0 >
	<cfset SESSION.LAUNCHING_STEP_4_MODAL = "1">
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

<cfset showfilter = "1">
<cfset SESSION.showheader = 1>
<cfset showheader = "1">

<!--- <cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")> --->
</cfsilent>
	
	<!--- <cfset s_dur = 60> --->
	<cfset __alert_no_avail = obj_translater.get_translate('alert_no_avail')>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

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
      
		<cfset title_page = "*WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<!--- SESSION.LAUNCHING_STEP_4_MODAL
			= <cfoutput>#SESSION.LAUNCHING_STEP_4_MODAL#</cfoutput> --->
	  
			<!--- <cfoutput>#t_id#</cfoutput> --->
			
			<cfinclude template="./incl/incl_nav_launching.cfm">

			<!--- <cfinclude template="./incl/incl_nav_learner.cfm"> --->

			<!--- <div class="container"> --->

			<div id="multi_header" class="sticky-top mt-3">
				<cfinclude template="./incl/incl_multi_header.cfm">
			</div>
			<!--- </div> --->

			<!--- <cfdump var="#SESSION.CUR_STEP#"> --->

			<cfinclude template="./incl/incl_multi_filter.cfm">
			<div class="row">
			
				<div class="col-md-12">

					<cfset showfilter = "1">
					<cfset SESSION.show_delete_trainer = 1>
					<cfinclude template="get_slot_multi.cfm">

				</div>
			
			</div>

			
		</div>
	</div>
		
	<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_multi_script.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">



<script>
$(document).ready(function() {

	<cfif not isDefined("SESSION.LAUNCHING_STEP_4_MODAL") OR SESSION.LAUNCHING_STEP_4_MODAL eq "0">
		$('#modal_title_lg').text("*WEFIT LMS*");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_launch3.cfm", function() {});
	
		<cfinvoke component="api/task/task_post" method="insert_task" returnVariable="user_new_id">
			<cfinvokeargument name="task_type_id" value="72">
			<cfinvokeargument name="u_id" value="#u_id#">
			<cfinvokeargument name="task_channel_id" value="6">
		</cfinvoke>
		
		<!--- UPDATE SESSION FOR NOT DISPLAYING ANYMORE --->
		<cfset SESSION.LAUNCHING_STEP_4_MODAL = 1>
	</cfif>
	
	$('.btn_del_trainer').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];

		$.ajax({
			url: 'api/tp/tp_post.cfc?method=updt_tptrainer_delete',
			type: 'POST',
			data : {
				<cfoutput>
					u_id: #u_id#,
					p_id: p_id,
					t_id: #t_id#,
					interne: 'yes',
				</cfoutput>
				},
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

		// $('#window_item_xl').modal({keyboard: true});
		// $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_remove_trainer'))#</cfoutput>");	
		// $('#modal_body_xl').empty();	
		// $('#modal_body_xl').load("<cfoutput>modal_window_tp_remove_trainer.cfm?multi=1&t_id=#t_id#&u_id=#u_id#&p_id=</cfoutput>"+p_id);
	});

})
</script>




</body>
</html>