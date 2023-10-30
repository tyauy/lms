<cfinclude template="incl_scripts_modal.cfm">

<script>

$(document).ready(function() {
	
	
<!-------------------- INIT BOOSTRAP COMPONENTS -------------------->
$('[data-toggle="popover"]').popover({
  trigger: 'focus',
  html: true
});
$('[data-toggle="tooltip"]').tooltip();
		

<!-------------------- PARAM BTN FOR MODAL OPENING -------------------->	
<cfoutput>

$('.btn_view_lesson').click(function(event) {	
	event.preventDefault();		
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
	$('##window_item_lg').modal({keyboard: true});
	$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_detail')#");
	$('##modal_body_lg').load("modal_window_event_light2.cfm?lesson_id="+idtemp, function() {});
});

<!-------------------- VIEW SESSION DETAILS -------------------->
$('.btn_view_session').click(function(event) {	
	event.preventDefault();
	var idtemp = $(this).attr("id");
	var sgo = idtemp.substr(0,2);
	var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
	$('##window_item_lg').modal({keyboard: true});
	$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_session')#");
	if(sgo == "sm")
	{$('##modal_body_lg').load("modal_window_session.cfm?sm_id="+idtemp, function() {});}
	else
	{$('##modal_body_lg').load("modal_window_session.cfm?s_id="+idtemp, function() {});}
});


function param_tag(event) {
	event.preventDefault();
	var base = $(this).attr("id");
	var id_temp = base.substr(base.lastIndexOf("_")+1,50);
	var cat_temp = base.substr(0,base.lastIndexOf("_"));	
	$('input:checkbox[id="'+cat_temp+'"][value="'+id_temp+'"]').prop('checked', false);
	summarize();
	$(this).remove();	
}
$(".badge_canal").bind("click",param_tag);

	
</cfoutput>
		
<!-------------------- PARAM MODAL CLOSING -------------------->
$("#window_item").on('hidden.bs.modal', function () {
	/*$(this).data('bs.modal', null);*/
	$('#modal_body').empty();
	$('#modal_title').empty();
	tinymce.remove('#lesson_open_main');
	tinymce.remove('#lesson_feedback');
	tinymce.remove('#lesson_grammar');
	tinymce.remove('#lesson_vocabulary');
	tinymce.remove('#lesson_na_needs');
	tinymce.remove('#lesson_pta_achievement');
	tinymce.remove('#lesson_pta_initial');
	tinymce.remove('#task_explanation_long');
});

$("#window_item_lg").on('hidden.bs.modal', function () {
	/*$(this).data('bs.modal', null);*/
	$('#modal_body_lg').empty();
	$('#modal_title_lg').empty();
	tinymce.remove('#lesson_open_main');
	tinymce.remove('#lesson_feedback');
	tinymce.remove('#lesson_grammar');
	tinymce.remove('#lesson_vocabulary');
	tinymce.remove('#lesson_na_needs');
	tinymce.remove('#lesson_pta_achievement');
	tinymce.remove('#lesson_pta_initial');
	tinymce.remove('#task_explanation_long');
});

$('#window_item').on('hide.bs.modal', function () {
	tinymce.remove('#lesson_open_main');
	tinymce.remove('#lesson_feedback');
	tinymce.remove('#lesson_grammar');
	tinymce.remove('#lesson_vocabulary');
	tinymce.remove('#lesson_na_needs');
	tinymce.remove('#lesson_pta_achievement');
	tinymce.remove('#lesson_pta_initial');
	tinymce.remove('#task_explanation_long');
});

$('#window_item_lg').on('hide.bs.modal', function () {
	tinymce.remove('#lesson_open_main');
	tinymce.remove('#lesson_feedback');
	tinymce.remove('#lesson_grammar');
	tinymce.remove('#lesson_vocabulary');
	tinymce.remove('#lesson_na_needs');
	tinymce.remove('#lesson_pta_achievement');
	tinymce.remove('#lesson_pta_initial');		
	tinymce.remove('#task_explanation_long');
});

	







	
<!-------------------- SEARCH BAR DISPLAYED FOR SOME PROFILES -------------------->
<cfif listFindNoCase("SALES,FINANCE,CS,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>


	<!-------------------- QUERIES FOR FILLING SEARCH BAR -------------------->
	<cfsilent>

		<cfif SESSION.USER_PROFILE eq "TRAINER">
			
			<cfquery name="get_learner_search" datasource="#SESSION.BDDSOURCE#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, u.user_phone, us.user_status_name_#SESSION.LANG_CODE# as status_name
			
				FROM user u
				LEFT JOIN lms_tpuser tu ON tu.user_id = u.user_id AND tu.tpuser_active = 1
				LEFT JOIN lms_tpplanner p ON p.tp_id = tu.tp_id AND p.active = 1
				LEFT JOIN user_status us ON us.user_status_id = u.user_status_id
				LEFT JOIN account a ON a.account_id = u.account_id
				
				WHERE p.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
			</cfquery>
			
		<cfelseif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
			<cfquery name="get_acc_search" datasource="#SESSION.BDDSOURCE#">
			SELECT account_id, account_name
			FROM account
			</cfquery>
			
			<cfquery name="get_gp_search" datasource="#SESSION.BDDSOURCE#">
			SELECT group_id, group_name
			FROM account_group
			</cfquery>
			
			<cfquery name="get_ctc_search" datasource="#SESSION.BDDSOURCE#">
			SELECT ac.contact_id, a.account_id, CONCAT(ac.contact_firstname, " ",UCASE(ac.contact_name), " (", a.account_name, ")") as contact_name
			FROM account_contact ac
			INNER JOIN account_contact_cor acc ON acc.ctc_id = ac.contact_id
			INNER JOIN account a ON a.account_id = acc.a_id
			</cfquery>
			
			<cfquery name="get_learner_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name), "<br>(", a.account_name, ")") as learner_name, Replace(Replace(u.user_phone,CHAR(13),' '),CHAR(10), ' ') as user_phone, 
			us.user_status_name_#SESSION.LANG_CODE# as status_name 
			FROM user u 
			INNER JOIN user_status us ON us.user_status_id = u.user_status_id
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="3">
			ORDER BY u.user_name
			</cfquery>
			
			<cfquery name="get_lead_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="7">
			</cfquery>
			
			<cfquery name="get_test_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="9">
			</cfquery>
			
			<cfquery name="get_contact_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as learner_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="10">
			</cfquery>
		
			<cfquery name="get_sm_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as sm_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="11">
			</cfquery>
		
			<cfquery name="get_tm_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as tm_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="8">
			</cfquery>
		
			<cfquery name="get_partner_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, u.account_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as partner_name
			FROM user u 
			INNER JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="13">
			</cfquery>
			
			<cfquery name="get_trainer_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT u.user_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as trainer_name
			FROM user u 
			LEFT JOIN account a ON a.account_id = u.account_id
			INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id AND upc.profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4">
			</cfquery>
		
			<cfquery name="get_list_token_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT llt.token_id, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as token_name, llt.token_code
			FROM lms_list_token llt 
			INNER JOIN user u ON u.user_id = llt.user_id
			</cfquery>
		
			<cfquery name="get_order_search" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 3, 0 )#">
			SELECT o.order_id, o.order_ref, o.order_ref2, o.account_id, a.account_name as account_name, CONCAT(u.user_firstname, " ",UCASE(u.user_name)) as user_name, u.user_id
			FROM orders o 
			INNER JOIN account a on a.account_id = o.account_id
			LEFT JOIN orders_users ou on ou.order_id = o.order_id
			LEFT JOIN user u on u.user_id = ou.user_id
			</cfquery>
			
		</cfif>
		
	</cfsilent>


	<!-------------------- TYPEAHEAD SEARCH BAR -------------------->
	$.typeahead({
		input: '.js_typeahead_global',
		order: "desc",
		minLength: 1,
		maxItem: 15,
		emptyTemplate: 'Pas de resultats pour "{{query}}"',
		/*matcher: function(item) {
			return true
		}*/
		<cfif listFindNoCase("SALES,FINANCE,CS,TRAINERMNG", SESSION.USER_PROFILE)>
		dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
		
		group: {
			template: "{{group}}"
		},
		</cfif>

		source: {
			<cfif listFindNoCase("SALES,FINANCE,CS,TRAINERMNG", SESSION.USER_PROFILE)>
			Groups: {
				display:"group_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/crm_account_edit.cfm?g_id={{group_id}}",
				data: [
					<cfoutput query="get_gp_search">{"group_id": #group_id#,"group_name": "#group_name#"},</cfoutput>
				]
			},
			Accounts: {
				display:"account_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/crm_account_edit.cfm?a_id={{account_id}}",
				data: [
					<cfoutput query="get_acc_search">{"account_id": #account_id#,"account_name": "#account_name#"},</cfoutput>
				]
			},
			Learners: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_learner_search" group="user_id">{"account_id": "#account_id#","user_id": #user_id#,"learner_name": "#learner_name#<br>**#replacenocase(status_name,"+","","ALL")#** [#replacenocase(user_phone,"+","","ALL")#]<!---<cfoutput>   #order_ref#</cfoutput>--->"},</cfoutput>				
				]
			},
			Guests: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_lead_search">{"user_id": #user_id#,"learner_name": "#learner_name#"},</cfoutput>		
				]
			},
			Tests: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_test_search">{"account_id": "#account_id#","user_id": #user_id#,"learner_name": "#learner_name#"},</cfoutput>		
				]
			},
			ContactWeb: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_contact_search">{"account_id": "#account_id#","user_id": #user_id#,"learner_name": "#learner_name#"},</cfoutput>		
				]
			},
			Contacts: {
				display:"contact_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/crm_account_edit.cfm?a_id={{account_id}}&c_id={{contact_id}}",
				data: [
					<cfoutput query="get_ctc_search">{"account_id": #account_id#,"contact_id": #contact_id#,"contact_name": "#contact_name#"},</cfoutput>				
				]
			},
			<!--- SchoolMNG: {
				display:"sm_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/crm_account_edit.cfm?a_id={{account_id}}",
				data: [
					<cfoutput query="get_sm_search">{"account_id": #account_id#,"user_id": #user_id#,"sm_name": "#sm_name#"},</cfoutput>				
				]
			}, --->
			TM: {
				display:"tm_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_tm_search">{"user_id": #user_id#,"tm_name": "#tm_name#"},</cfoutput>				
				]
			},
			Partner: {
				display:"partner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_partner_search">{"account_id": #account_id#,"user_id": #user_id#,"partner_name": "#partner_name#"},</cfoutput>	
				]
			},
			Trainers: {
				display:"trainer_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_trainer_account.cfm?p_id={{user_id}}",
				data: [
					<cfoutput query="get_trainer_search">{"user_id": #user_id#,"trainer_name": "#trainer_name#"},</cfoutput>				
				]
			},
			CodeEntry: {
				display:"token_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/db_certif_list.cfm?ce_id={{token_id}}",
				data: [
					<cfoutput query="get_list_token_search">{"token_id": #token_id#,"token_name": "#token_name# - #REReplace(token_code,"[^0-9A-Za-z -]","","all")#"},</cfoutput>				
				]
			},
			Orders: {
				display:"order_name",
				<cfif listFindNoCase("FINANCE,CS", SESSION.USER_PROFILE)>
					href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				<cfelse>
					href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/crm_account_edit.cfm?a_id={{account_id}}",
				</cfif>
				data: [
					<cfoutput query="get_order_search">{"account_id": #account_id#,"user_id": "#user_id#","order_name": "#order_ref# <cfif order_ref2 neq "">#REReplace(order_ref2,"[^0-9A-Za-z -]","","all")#</cfif> - #account_name#<br>#user_name#"},</cfoutput>				
				]
			}
			<cfelseif SESSION.USER_PROFILE eq "trainer">
			Learners: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/common_learner_account.cfm?u_id={{user_id}}",
				data: [
					<cfoutput query="get_learner_search">{"account_id": "#account_id#","user_id": #user_id#,"learner_name": "#learner_name# **#status_name#**"},</cfoutput>				
				]
			},
			<!--- <cfelseif SESSION.USER_PROFILE eq "SchoolMNG">
			Learners: {
				display:"learner_name",
				href:"<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/cm_index.cfm?token_code={{token_code}}",
				data: [
					<cfoutput query="get_token_search" group="user_id">{
						"user_id": #user_id#,
						"learner_name": "#learner_name#<br>**#replacenocase(status_name,"+","","ALL")#** - #REReplace(token_code,"[^0-9A-Za-z -]","","all")# <cfif user_phone neq ""><br> - [#replacenocase(user_phone,"+","","ALL")#]</cfif>",
						"token_code": "#REReplace(token_code,"[^0-9A-Za-z -]","","all")#"
					},
					</cfoutput>				
				]
			}, --->
			</cfif>
		},
		callback: {
				
		}
	});
</cfif>















<!-------------------- COMMON BUTTONS -------------------->
<cfif listFindNoCase("SALES,CS,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		
	<cfoutput>
		
	$('.btn_open_syllabus').click(function(event) {
		event.preventDefault();
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("*WEFIT LMS*");
		$('##modal_body_xl').load("modal_window_syllabus.cfm", function() {});
	});	


	/******************** CREATE TRAINER *****************************/	
	$('.btn_add_trainer').click(function(event) {
		event.preventDefault();
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Ajouter trainer");
		$('##modal_body_lg').load("modal_window_trainer.cfm?display=create", function() {});
	});	
	/******************** CREATE LEARNER *****************************/	
	$('.btn_add_learner').click(function(event) {		
		event.preventDefault();
		$('##modal_title_lg').text("Ajouter user");
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_body_lg').load("modal_window_learner.cfm?create=1<cfif isdefined("a_id")>&a_id=<cfoutput>#a_id#</cfoutput></cfif>", function() {});
	});

	$('.btn_add_tm').click(function(event) {		
		event.preventDefault();
		$('##modal_title_lg').text("Ajouter user");
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_body_lg').load("modal_window_learner.cfm?tm=1&create=1<cfif isdefined("a_id")>&a_id=<cfoutput>#a_id#</cfoutput></cfif>", function() {});
	});

	$('.btn_update_learner').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		$('##modal_title_lg').text("Update user");
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_body_lg').load("modal_window_learner.cfm?display=updt_status&u_id=" + u_id + "<cfif isdefined("a_id")>&a_id=<cfoutput>#a_id#</cfoutput></cfif>", function() {});
	});

	/******************** VIEW LOG *****************************/	
	$('.btn_view_log').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Follow-Up");
		$('##modal_body_xl').load("modal_window_log.cfm?u_id="+u_id, function() {});
	});	
	/******************** VIEW ORDER *****************************/	
	$('.btn_read_order').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var o_id = idtemp[1];
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Edition order "+o_id);
		$('##modal_body_xl').load("modal_window_order_read.cfm?o_id="+o_id, function(){});
	});


	/******************** EDIT CONTACT *****************************/	
	$('.btn_edit_ctc').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var c_id = idtemp[1];	
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("\u00c9diter contact");
		$('##modal_body_lg').load("modal_window_crm.cfm?ctc_edit=1&contact_id="+c_id+"<cfif isdefined("a_id")>&a_id=#a_id#</cfif>", function() {});
	});	
	
	/******************** CREATE CONTACT *****************************/	
	$('.btn_create_ctc').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Cr\u00e9er contact");
		$('##modal_body_lg').load("modal_window_crm.cfm?ctc_create=1&a_id="+a_id, function() {});

	});		

	/******************** EDIT GROUP PRICE *****************************/
	$('.btn_edit_price').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("\u00c9diter grille tarifaire");
		$('##modal_body_xl').load("modal_window_crm.cfm?price_edit=1&account_id="+a_id, function() {});

	});	
	
	/******************** EDIT ACCOUNT *****************************/
	$('.btn_edit_account').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("\u00c9diter compte");
		$('##modal_body_xl').load("modal_window_crm.cfm?account_edit=1&account_id="+a_id, function() {});
	});	
	/******************** EDIT GROUP *****************************/
	$('.btn_edit_group').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");		
		var idtemp = idtemp.split("_");
		var g_id = idtemp[1];		
		var a_id = idtemp[2];		
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("\u00c9diter group");
		$('##modal_body_xl').load("modal_window_crm.cfm?group_edit=1&group_id="+g_id+"&a_id="+a_id, function() {});

	});	
	/******************** CREATE ACCOUNT *****************************/
	$('.btn_create_account').click(function(event) {	
		event.preventDefault();
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Cr\u00e9er Compte");
		$('##modal_body_xl').load("modal_window_crm.cfm?account_create=1", function() {});

	});
	/******************** CREATE GROUP *****************************/
	$('.btn_create_group').click(function(event) {	
		event.preventDefault();
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Cr\u00e9er Group");
		$('##modal_body_xl').load("modal_window_crm.cfm?group_create=1", function() {});

	});

	/******************** CREATE ORDER *****************************/
	$('.btn_new_order').click(function(event) {	
		event.preventDefault();	
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_title_xl').text("Create new order");
		$('##modal_body_xl').empty();
		$('##modal_body_xl').load("modal_window_order_create.cfm<cfif isDefined("a_id") AND a_id neq "">?a_id=<cfoutput>#a_id#</cfoutput></cfif>");
	});
	
	/******************** VIEW LEARNER *****************************/
	$('.btn_view_learner').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Vue learner");
		$('##modal_body_lg').load("modal_window_lms.cfm?view_user=1&u_id="+u_id, function() {});

	});
	
	/******************** EDITION TASK *****************************/
	$('.btn_edit_task').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("\u00c9diter task");
		$('##modal_body_lg').load("modal_window_crm.cfm?task_edit=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>&task_id="+t_id, function() {});
	});
	
		
	/******************** EDITION OPPORT *****************************/
	$('.btn_edit_opport').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("\u00c9diter opportunit\u00e9");
		$('##modal_body_lg').load("modal_window_crm.cfm?opport_edit=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>&task_id="+t_id, function() {});
	});
	
	
	/******************** CREATION OPPORT *****************************/
	$('.btn_create_opport').click(function(event) {		
		event.preventDefault();		
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("Cr\u00e9er opportunit\u00e9");
		$('##modal_body_lg').load("modal_window_crm.cfm?opport_create=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>", function() {
		
			$('##task_alert_opport').click(function() {		
				if($('##task_date_remind_opport').is(':disabled'))
				{
					$('##task_date_remind_opport').prop("disabled",false);
				}
				else{
					$('##task_date_remind_opport').prop("disabled",true);
				}
			});
			
			$('##task_date_deadline_opport').datepicker({	
				weekStart: 1,
				changeMonth: true,
				dateFormat: 'dd/mm/yy'
					/*onClose: function( selectedDate ) {
					$( "##task_remind" ).datepicker( "option", "minDate", selectedDate );
					}*/		
				})
				
			$('##task_date_remind_opport').datepicker({	
				weekStart: 1,
				changeMonth: true,
				dateFormat: 'dd/mm/yy'
			})
			
			$('##account_select_opport').change(function() {

				$.ajax({
					url: 'get_datainfo.cfm',
					data: "get_contact=1&a_id="+$(this).val(),
					type: 'POST',
					dataType: 'json',				 
					success: function(response){
						$('##contact_select_opport').empty();
						$('##contact_select_opport').prop("disabled",false);  
						$.each(response, function(index, value) {
							$('##contact_select_opport').append('<option value="'+ response[index].CONTACT_ID +'">'+ response[index].CONTACT_FIRSTNAME + " " + response[index].CONTACT_NAME +'</option>');
						})
					},
					error: function(e){	

					}
				});				 
			});
			
		});
	});
	
	
	/******************** CREATION TASK *****************************/
	$('.btn_create_task').click(function(event) {	
		event.preventDefault();		
		$('##window_item_lg').modal({keyboard: true});	
		$('##modal_title_lg').text("Cr\u00e9er task");
		$('##modal_body_lg').load("modal_window_crm.cfm?task_create=1<cfif isdefined("a_id")>&a_id=#a_id#</cfif>", function() {

			$('##task_alert').click(function() {		
				if($('##task_date_remind').is(':disabled'))
				{
					$('##task_date_remind').prop("disabled",false);
				}
				else{
					$('##task_date_remind').prop("disabled",true);
				}
			});

			$('##task_date_deadline').datepicker({
				weekStart: 1,
				changeMonth: true,
				dateFormat: 'dd/mm/yy'
			});
			
			$('##task_date_remind').datepicker({	
				weekStart: 1,
				changeMonth: true,
				dateFormat: 'dd/mm/yy'
			})
			
			$('##account_select_task').change(function() {
				$.ajax({
					url: 'get_datainfo.cfm',
					data: "get_contact=1&a_id="+$(this).val(),
					type: 'POST',
					dataType: 'json',				 
					success: function(response){
						$('##contact_select_task').empty();
						$('##contact_select_task').prop("disabled",false);  
						$.each(response, function(index, value) {
							$('##contact_select_task').append('<option value="'+ response[index].CONTACT_ID +'">'+ response[index].CONTACT_FIRSTNAME + " " + response[index].CONTACT_NAME +'</option>');
						})
					},
					error: function(e){	

					}
				});				 
			});
		
		});
		
	});
	
	
	</cfoutput>
</cfif>













<!-------------------- SPECIFIC BUTTONS TM -------------------->

<cfif SESSION.USER_PROFILE eq "TM">
	/******************** CREATE LEARNER *****************************/	
	$('.btn_add_learner').click(function(event) {		
		event.preventDefault();
		$('#modal_title_lg').text("Ajouter learner");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_learner_tm.cfm?create=1", function() {});
	});

</cfif>





<!-------------------- SPECIFIC BUTTONS TRAINER + LAUNCHING ACTION -------------------->
	
<cfif SESSION.USER_PROFILE eq "TRAINER">

	<cfif SESSION.USER_STATUS_ID eq "1">
		<cflocation addtoken="no" url="common_trainer_account.cfm?view=validate">
	</cfif>
	
	<cfif SESSION.USER_STATUS_ID eq "2">
		<cflocation addtoken="no" url="common_trainer_account.cfm?view=confirm">
	</cfif>
		
	<cfoutput>	
	$('.btn_ln_lesson').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_edit_ln')#");		
		$('##modal_body_lg').load("modal_window_ln_lesson.cfm?l_id="+l_id);
	});
	
	$('.btn_ln_na').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_edit_na')#");		
		$('##modal_body_lg').load("modal_window_ln_na.cfm?l_id="+l_id);
	});
	
	$('.btn_ln_pta').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_edit_pta')#");		
		$('##modal_body_lg').load("modal_window_ln_pta.cfm?l_id="+l_id);
	});
	
	$('.btn_ln_upload').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var l_id = idtemp[1];
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#obj_translater.get_translate('js_modal_title_upload')#");		
		$('##modal_body_lg').load("modal_window_ln_upload.cfm?l_id="+l_id);
	});
	</cfoutput>
	
</cfif>























<!-------------------- AUTOMATIC TRIGGER -------------------->


<cfif isDefined("late_lesson") AND late_lesson neq "">
	$('#modal_title_lg').text("<cfoutput>#encodeForJavascript(obj_translater.get_translate('js_modal_title_book'))#</cfoutput>");
	$('#window_item_lg').modal({keyboard: true});
	$('#modal_body_lg').load("modal_window_lesson_late_adv.cfm?l_id=<cfoutput>#late_lesson#</cfoutput>", function() {});
</cfif>


<cfif isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "0">
	$('#window_item_pw').modal({keyboard: false,backdrop:'static'});
	$('#modal_title_pw').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");		
	$('#modal_body_pw').load("modal_window_mdp.cfm?init=1", function() {
	});
<cfelse>

	<cfif SESSION.USER_PROFILE eq "LEARNER">
		
		<cfif SESSION.USER_STATUS_ID eq "3" AND not isDefined("SESSION.LAUNCH_NO_TP_AV")>
			
			<cfif SESSION.USER_TYPE_ID eq "7">
				<cflocation addtoken="no" url="learner_launch_partner.cfm">
			<cfelse>
				<cflocation addtoken="no" url="learner_launch_1.cfm">
			</cfif>

		</cfif>

	</cfif>
		
</cfif>

	
})		
</script>