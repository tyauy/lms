<!DOCTYPE html>

<cfsilent>
	
<cfparam name="st_id" default="1,2">

<cfset get_tps_solo_learners = obj_tp_get.oget_tps(p_id="#SESSION.USER_ID#",m_id="1,2",st_id="#st_id#",o_by="user_firstname")>
<cfset get_tps_group_learners = obj_tp_get.oget_tps(p_id="#SESSION.USER_ID#",m_id="11",st_id="#st_id#",o_by="user_firstname")>
<cfset get_tps_virtual_learners = obj_tp_get.oget_tps(p_id="#SESSION.USER_ID#",m_id="10",st_id="#st_id#",o_by="user_firstname",no_users="1")>
 
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
		<cfif st_id eq "1">
			<cfset title_page = "#obj_translater.get_translate('title_page_trainer_program')# : #obj_translater.get_translate('sidemenu_trainer_awaiting')#">
		<cfelseif st_id eq "2">
			<cfset title_page = "#obj_translater.get_translate('title_page_trainer_program')# : #obj_translater.get_translate('sidemenu_trainer_active')#">
		<cfelseif st_id eq "3">
			<cfset title_page = "#obj_translater.get_translate('title_page_trainer_program')# : #obj_translater.get_translate('sidemenu_trainer_inactive')#">
		<cfelseif st_id eq "5">
			<cfset title_page = "#obj_translater.get_translate('title_page_trainer_program')# : #obj_translater.get_translate('sidemenu_trainer_anomaly')#">
		<cfelse>
			<cfset title_page = "#obj_translater.get_translate('title_page_trainer_program')#">
		</cfif>
		
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">
	  	
		<!---<cfdump var="#get_tps#">--->
			<!---<cfset case = "learners">
			<cfinclude template="./incl/incl_nav_trainer.cfm">--->
		
			<div class="row">
			
				<div class="col-md-12">
					<div class="card border-top border-info">
						
						<div class="card-body">

							<cfinclude template="./widget/wid_learner_list_trainer.cfm">
							
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
$(document).ready(function() {

	/******************** VIEW LOG *****************************/	
	$('.btn_view_log').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		$('#modal_title_xl').text("Follow-Up Learner");
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_body_xl').load("modal_window_log.cfm?u_id="+u_id, function() {})
	});
	
	$('.btn_edit_tpgroup').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("TP group");
		$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id, function() {});
	});
				
	
 })
</script>
</body>
</html>