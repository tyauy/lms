<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "7,8,13,2,5,12">
<cfinclude template="./incl/incl_secure.cfm">	


<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.USER_ACCOUNT_RIGHT_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.USER_ACCOUNT_RIGHT_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>
<cfif SESSION.USER_ISMANAGER eq 1 AND !isDefined('SESSION.AL_ID')>
	<cfif isDefined("SESSION.CUR_A_ID")>
		<cfset SESSION.AL_ID = SESSION.CUR_A_ID>
	<cfelse>
		<cfset SESSION.AL_ID = SESSION.ACCOUNT_ID>
	</cfif>
</cfif>


<cfset get_account_tm = obj_query.oget_account_tm(list_account="#SESSION.USER_ACCOUNT_RIGHT_ID#")>
<cfparam name="al_id" default="#SESSION.AL_ID#">
<cfset display_all_selected = false>
<cfif al_id eq "" OR al_id eq 0>
	<cfset al_id = SESSION.USER_ACCOUNT_RIGHT_ID>
	<cfset display_all_selected = true>
<cfelse>
	<cfset SESSION.AL_ID = al_id>
</cfif>
<cfset SESSION.ACCOUNT_ID = listgetat(al_id,1)>

<cfparam name="display" default="tp">
<cfparam name="usty_id" default="3">

<cfif SESSION.USER_PROFILE eq "partner">
	<cfparam name="ust_id" default="7">
<cfelse>
	<cfparam name="ust_id" default="4">
</cfif>

<cfparam name="display_all" default="0">

<cfquery name="get_user_status" datasource="#SESSION.BDDSOURCE#">
SELECT user_status_id, user_status_name_#SESSION.LANG_CODE# as user_status_name FROM user_status WHERE user_status_id IN (1,2,3,4,5) 
</cfquery>

<cfquery name="get_user_profile" datasource="#SESSION.BDDSOURCE#">
SELECT profile_id, profile_name FROM user_profile WHERE profile_id IN (3,5,7) 
</cfquery>

<cfquery name="get_user_type" datasource="#SESSION.BDDSOURCE#">
SELECT user_type_id, user_type_name_#SESSION.LANG_CODE# as user_type_name FROM user_type 
<cfif SESSION.USER_PROFILE eq "partner">
WHERE user_type_id IN (3,4,5,8,7) 
<cfelse>
WHERE user_type_id IN (3,4,5,8) 
</cfif>
</cfquery>
</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	<style type="text/css">
	   /* .custom-table{border-collapse:collapse;width:100%;border:solid 1px #c0c0c0;font-family:open sans;font-size:11px}
            .custom-table th,.custom-table td{text-align:left;padding:8px;border:solid 1px #c0c0c0}
            .custom-table th{color:#000080}
            .custom-table tr:nth-child(odd){background-color:#f7f7ff}
            .custom-table>thead>tr{background-color:#dde8f7!important}
            .tbtn{border:0;outline:0;background-color:transparent;font-size:13px;cursor:pointer}
            .toggler{display:none}
            .toggler1{display:table-row;}
            .custom-table a{color: #0033cc;}
            .custom-table a:hover{color: #f00;}
            .page-header{background-color: #eee;} */
	</style>


	<cfset __table_th_last_connect = obj_translater.get_translate('table_th_last_connect')>
	<cfset __table_th_total_lms = obj_translater.get_translate('table_th_total_lms')>
	<cfset __table_th_visio= obj_translater.get_translate('card_visio')>
	<cfset __table_th_activity = obj_translater.get_translate('table_th_activity')>
	<cfset __table_th_level = obj_translater.get_translate('level')>
	<cfset __table_th_courses_launched = obj_translater.get_translate('table_th_courses_launched')>
	<cfset __table_th_mock_tests = obj_translater.get_translate('table_th_mock_tests')>
	<cfset __table_th_quizzes = obj_translater.get_translate('table_th_quizzes')>
	<cfset __card_level = obj_translater.get_translate('card_level')>
	<cfset __card_learner_pt = obj_translater.get_translate('card_learner_pt')>

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Welcome to *WEFIT LMS*">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			
			<div class="row justify-content-between mt-3 mb-1">
				<div class="col-md-4">
					<cfif ListLen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						<!--- <select class="form-control" name="a_id" id="a_id" onchange="document.location.href='tm_learners.cfm?a_id='+$(this).val()">
						<cfoutput query="get_account_tm">
						<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
						</cfoutput>
						<cfoutput>
						<option value="0" <cfif a_id eq 0>selected</cfif>>#Ucase('#obj_translater.get_translate("table_th_all_accounts")#')#</option>
						</cfoutput>
						</select> --->

						<div class="row">
							<div class="col-lg-12">
							<button type="button" class="btn btn-sm btn-default form-control dropdown-toggle" style="text-align: left;overflow:hidden; white-space:nowrap; text-overflow:ellipsis;" data-toggle="dropdown">
								<span class="account-display" style="">
									<cfif al_id eq 0 OR display_all_selected eq true>
										<cfoutput>
											#obj_translater.get_translate('table_th_all_accounts')#
										</cfoutput>
									<cfelse>
										<cfoutput query="get_account_tm">
											<cfif ListContains(al_id,account_id) GT 0> &nbsp;#account_name#,&nbsp;
											</cfif>
										</cfoutput>
									</cfif>
								</span>
							</button>
								<ul id="tm_account_select" class="dropdown-menu form-control">
									<cfoutput>
									<li><a href="##" class="form-control" data-value="0" tabIndex="-1">
										-&nbsp;#obj_translater.get_translate('table_th_all_accounts')#
									</a></li>
									</cfoutput>

									<cfoutput query="get_account_tm">
										<li><a href="##" class="form-control" data-value="#account_id#" tabIndex="-1">
											<input type="checkbox" <cfif ListContains(al_id,account_id) GT 0> checked </cfif>/>
											&nbsp;#account_name#
										</a></li>
									</cfoutput>
								</ul>
							</div>
					   </div>
						
					</cfif>
				</div>
				<div class="col-md-4">
					<div align="center">
					<cfoutput>
						<a class="btn btn-link <cfif display eq "tp">text-info</cfif>" href="tm_learners.cfm?display=tp" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate("tooltip_display_tp")#"><i class="fal fa-webcam fa-2x"></i></a>
						<a class="btn btn-link <cfif display eq "level">text-info</cfif>" href="tm_learners.cfm?display=level" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate("tooltip_display_activity")#"><i class="fal fa-trophy-alt fa-2x"></i></a>
						<a class="btn btn-link <cfif display eq "el">text-info</cfif>" href="tm_learners.cfm?display=el" data-toggle="tooltip" data-placement="top" title="#obj_translater.get_translate("tooltip_display_el")#"><i class="fal fa-laptop fa-2x"></i></a>
					</cfoutput>
					</div>
				</div>
			</div>
							
			<div class="row mt-3">
			
				<div class="col-md-12">
					<div class="card border-top border-info">
						
						<div class="card-body">

                            <h5><cfoutput>#obj_translater.get_translate('sidemenu_tm_learners')#</cfoutput></h5>

							<cfinclude template="./widget/wid_learner_list_tm.cfm">
						
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

	var options = [<cfoutput>#al_id#</cfoutput>];

	$( '#tm_account_select a' ).on( 'click', function( event ) {

	var target = $( event.currentTarget );
	var val = target.attr( 'data-value' ) * 1;
	var inp = target.find( 'input' );

	if (val == 0) {
		options = [];
		document.location.href="tm_learners.cfm?al_id=0";
		return false;
	}

	if ( ( idxall = options.indexOf( 0 ) ) > -1 ) {
		options.splice( idxall, 1 );
	}

	if ( ( idx = options.indexOf( val ) ) > -1 ) {
		options.splice( idx, 1 );
		setTimeout( function() { inp.prop( 'checked', false ) }, 0);
	} else {
		options.push( val );
		setTimeout( function() { inp.prop( 'checked', true ) }, 0);
	}
		
	document.location.href="tm_learners.cfm?al_id="+(options == [] ? ['0'] : options);
	return false;
	});

	$('.btn_contact_wefit').click(function(event) {	
		event.preventDefault();

		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Contacter Wefit");
		$('#modal_body_lg').load("modal_window_contact.cfm", function() {});
	});
	
	$('.btn_order_create').click(function(event) {	
		event.preventDefault();		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Contacter Wefit");
		$('#modal_body_lg').load("modal_window_contact.cfm", function() {});
	});
	
	$('.btn_view_tp').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];	
		var u_id = idtemp[2];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('table_th_program'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_tpview_tm.cfm?t_id="+t_id+"&u_id="+u_id, function() {});
	});

	$('.btn_edit_tpgroup').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var t_id = idtemp[1];
		var l_id = idtemp[2];
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("TP group");
		$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
	});

	
	<cfoutput>
	$('.btn_view_qpt').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_group_id = idtemp[1];	
		var quiz_user_id = idtemp[2];	
		var user_id = idtemp[3];
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_pt'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_qpt.cfm?quiz_user_group_id="+quiz_user_group_id+"&quiz_user_id="+quiz_user_id+"&u_id="+user_id, function() {});
	})
	</cfoutput>


	// $('.tbtn').click(function(event) {
	// 	alert("hop");
	// 	$(this).parents(".custom-table").find(".toggler1").removeClass("toggler1");
	// 	$(this).parents("tbody").find(".toggler").addClass("toggler1");
	// 	$(this).parents(".custom-table").find(".fa-minus-circle").removeClass("fa-minus-circle");
	// 	$(this).parents("tbody").find(".fa-plus-circle").addClass("fa-minus-circle");
	// });

	$('.tabquiz').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var id = idtemp[2];

		console.log(id);
		$('#activity_container_'+id).load("./widget/wid_learner_list_tm_activity.cfm?u_id=" + id, function() {

		});
	});
	
	// $('.tabtp').click(function(event) {
	// 	event.preventDefault();		
	// 	var idtemp = $(this).attr("id");
	// 	var idtemp = idtemp.split("_");
	// 	var id = idtemp[2];

	// 	console.log(id);
	// 	$('#tp_container_'+id).load("./widget/wid_learner_list_tm_tp.cfm?u_id=" + id, function() {

	// 	});
	// });
			
});
</script>

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
	

				
	
 })
</script>

</body>
</html>