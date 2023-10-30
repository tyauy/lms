<!DOCTYPE html>

<cfsilent>
	
<cfparam name="u_id" default="#SESSION.USER_ID#">
<cfparam name="t_id" default="#SESSION.TP_ID#">

	<cfset get_tps = obj_tp_get.oget_tps(u_id="#u_id#",m_id="1,2,7,11")>
	<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>

	<cfif t_id eq "" OR t_id eq 0>
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


	<cfset showfilter = "1">
	<cfset showheader = "1">
	<!--- <cfset SESSION.LAUNCH_MULTI = "1"> --->

	<!--- <cfset s_dur = 60> --->
	<cfset __alert_no_avail = obj_translater.get_translate('alert_no_avail')>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<!--- <script type = "text/javascript" >  
		function preventBack() { window.history.forward(); }  
		setTimeout("preventBack()", 0); 
		window.onunload = function () { null };  
	</script> --->
	
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<cfinclude template="./incl/incl_nav_tp.cfm">

			<cfinclude template="./incl/incl_multi_filter.cfm">

			<cfset SESSION.showheader = 1>
			<div id="multi_header">
				<cfinclude template="./incl/incl_multi_header.cfm">
			</div>


			<cfset SESSION.show_delete_trainer = 1>
			<cfinclude template="get_slot_multi.cfm">

			<cfif get_trainer.recordCount LT 3>
				<cfoutput>
				</cfoutput>

				<div id="container_solo" class="collapse show">
					<div class="row">
						<div class="col-md-12" style="padding-right: 0px !important">
				
							<cfoutput>
							<cfset temp = randrange(1,2)>
							<div class="card border">
								<div class="card-body" style="min-height: 350px">
									<div class="row">
										<div class="col-md-2">
											<div class="p-2">
														
				
												<div align="center" class="mt-4">
													<img src="./assets/img/<cfif temp eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>">
												</div>

												<div align="center" class="mt-4">
													<!--- <strong style="font-size:18px" class="text-dark">#user_firstname# </strong> --->
													<button class="btn btn-outline-red btn-sm btn_edit_trainer">#obj_translater.get_translate('btn_add')#</button>
													<!--- <br>
													<cfif country_alpha neq ""><img src="./assets/css/flags/blank.gif" class="flag_xs flag-#lcase(country_alpha)#"></cfif> Corporate Trainer --->
												</div>
													
																	
											</div>
										</div>
										<div class="col-md-10 col-12">
											<div class="p-2">
												<div>			
												</div>
												
											</div>
										</div>	
									</div>
								</div>
							</div>
						</cfoutput>
				
					</div>
				</div>

			</cfif>
			<!--- <cfinvoke component="get_slot_multi.cfm"></cfinvoke> --->
			

			
		</div>
	</div>
<cfinclude template="./incl/incl_footer.cfm">
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_multi_script.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	$(document).ready(function() {

		$('.btn_edit_trainer').click(function(event) {
		event.preventDefault();
        <cfif get_trainer.recordCount lt "3">
            $('#window_item_xl').modal({keyboard: true});
            $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_change_trainer'))#</cfoutput>");	
            $('#modal_body_xl').empty();	
            $('#modal_body_xl').load("<cfoutput>modal_window_tptrainer.cfm?t_id=#t_id#<cfif u_id neq 0>&u_id=#u_id#</cfif>&single=1</cfoutput>");
        <cfelse>
           alert("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#</cfoutput>");
        </cfif>
		
	});

	$('.btn_del_trainer').click(function(event) {	
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var p_id = idtemp[1];

        $('#window_item_xl').modal({keyboard: true});
        $('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_remove_trainer'))#</cfoutput>");	
        $('#modal_body_xl').empty();	
        $('#modal_body_xl').load("<cfoutput>modal_window_tp_remove_trainer.cfm?multi=1&t_id=#t_id#&u_id=#u_id#&p_id=</cfoutput>"+p_id);
    });

	})
</script>


</body>
</html>