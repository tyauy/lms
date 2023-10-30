<!DOCTYPE html>
<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
	
	<cfset step = "1">
	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>	

	<cfset get_tp = obj_tp_get.oget_tps(u_id="#u_id#",st_id="1",m_id="1")>

	<cfset SESSION.TP_ID = get_tp.tp_id>	
	<cfset t_id = SESSION.TP_ID>	
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>

	<cfquery name="get_trainer_tp" datasource="#SESSION.BDDSOURCE#">
		SELECT planner_id FROM lms_tpplanner
		WHERE tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
		AND active = 1
	</cfquery>

	<cfif get_trainer_tp.recordCount GT 0>
		<cflocation addtoken="no" url="learner_launch_partner_2.cfm">
	</cfif>

	<!--- <cfinclude template="./incl/incl_trainer_list.cfm"> --->

    <cfquery name="get_trainer_go" datasource="#SESSION.BDDSOURCE#">
    SELECT u.user_id, u.user_firstname, u.user_status_id, u.country_id, u.speciality_id, u.method_id, u.user_based, u.user_abstract, u.user_create, u.user_add_course, u.user_add_learner,
    c.country_name_#SESSION.LANG_CODE# as country_name, c.country_alpha,
    s.user_status_name_#SESSION.LANG_CODE# as user_status_name, s.user_status_css
    FROM user u
    LEFT JOIN settings_country c ON c.country_id = u.country_id
    LEFT JOIN user_status s ON s.user_status_id = u.user_status_id
    WHERE user_id IN (<cfif get_tp.formation_id eq "2"><cfif SESSION.USER_QPT_EN eq "A1" or SESSION.USER_QPT_EN eq "A0">26382,140<cfelse>161,15095,26382</cfif><cfelseif get_tp.formation_id eq "4">140<cfelse>140</cfif>)
	ORDER BY rand()
    </cfquery>

    <!---
	140 ADAM
	151 DOUGLAS
	15095 ROBERT Y
	26382 NOURHANE
	26383 AMEL
	27129 SOFIA
	161 DIANNE
	--->

</cfsilent>

<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>
	<!--- <cfoutput>---#u_level# // #level_criteria_id#</cfoutput> --->

<head>

	<cfinclude template="./incl/incl_head.cfm">

	<style>
		.btn-outline-info {
			text-transform:none !important; 
			border: 1px solid #51bcda !important;
		}
		.btn-outline-danger {
			text-transform:none !important; 
			border: 1px solid #ef8157 !important;
		}												
	</style>

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

			<cfset title_page = "#obj_translater.get_translate('title_page_learner_index')#">

			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">

			
				<!--- <cfif REMOTE_ADDR eq "91.162.168.203">
				<cfdump var="#get_trainer#">
				</cfif> --->
				<!--- <cfif SESSION.USER_PROFILE eq "test">
				<cfdump var="#get_trainer#">
				
				<br>
				<cfoutput>
				trainer_hour_list = #trainer_hour_list#<br>
				score_accuracy = #score_accuracy#<br>
				score_charge = #score_charge#
				</cfoutput>
				
				
				</cfif> --->

				<!--- 

				<cfif get_trainer.recordcount GT 3 OR teaching_criteria_id eq 2 OR get_trainer.recordcount eq 0>
					<cfinclude template="./widget/wid_trainer_list_learner.cfm">
				</cfif>	 --->

                <cfinclude template="./incl/incl_nav_partner.cfm">

                <cfset display = "video">

                <cfoutput query="get_trainer_go">

                    <cfinclude template="./widget/wid_trainer_details_partner.cfm">
                
                </cfoutput>	



			</div>

			<cfinclude template="./incl/incl_footer.cfm">


		</div>

	</div>

</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	<cfif not isdefined("notrigger")>
	$('#window_item_lg').modal({keyboard: false,backdrop:'static'});
	$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_welcome_learner')#</cfoutput>");		
	$('#modal_body_lg').load("modal_window_partner.cfm?view=welcome_partner", function() {});
	</cfif>

		
	$('.btn_view_trainer').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#</cfoutput>");
		$('#modal_body_xl').empty();
		$('#modal_body_xl').load("modal_window_trainerview.cfm?p_id="+p_id, function() {});
	});


	$('.btn_choose_trainer').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];

		$.ajax({				 
			url: 'api/launching/launching_post.cfc?method=attach_trainer',
			type: "POST",
			data:  {p_id:p_id,tp_id:<cfoutput>#t_id#</cfoutput>},
			datatype : "html",
			success : function(result, statut){
				window.location.href=("learner_launch_partner_2.cfm")
			},
			error : function(result, statut, error){
			}
		});

	});
	


	
});
</script>
</body>
</html>





