<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8,2,5,12">
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
<!--- <cfparam name="a_id" default="#listgetat(SESSION.USER_ACCOUNT_RIGHT_ID,1)#"> --->
<cfparam name="al_id" default="#SESSION.AL_ID#">
<cfset display_all_selected = false>
<cfif al_id eq "" OR al_id eq 0>
	<cfset al_id = SESSION.USER_ACCOUNT_RIGHT_ID>
	<cfset display_all_selected = true>
<cfelse>
	<cfset SESSION.AL_ID = al_id>
</cfif>
<cfset SESSION.ACCOUNT_ID = listgetat(al_id,1)>

<cfset get_learner_account = obj_query.oget_learner(list_account="#al_id#",pf_id="3,7,9",o_by="account_id")>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	</style>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Learner">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row justify-content-md-center">
				<div class="col-md-2">
					<button class=" btn btn-sm btn-success btn_add_user_tm"><i class="fa-light fa-square-plus"></i><p>D&eacute;PLOYER APPRENANT</p></button>
				</div>
				<div class="col-md-4">
				</div>
				<div class="col-md-6">
					<!--- <cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1> --->
						
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
					<!--- </cfif> --->
				</div>
			</div>


			<div class="row" style="margin-top:10px">

				<div class="col-md-12">
					<div class="card border-top border-info">						
						<div class="card-body">
							<div class="table-responsive">
								<table width="3000" class="table table-sm bg-white">
									<tbody>
									<tr class="bg-light" align="center">
										<!---<th>ID</th>--->
										<th>TYPE</th>
										<th>STATUS</th>
										<th>CR&Eacute;ATION/LMS</th>
										<th width="250">LEARNER</th>
										<th>ENTIT&Eacute;</th>
										<!--- <th>PT</th>
										<th>LST</th> --->
										<th>+</th>
									</tr>
									
								
									<cfoutput query="get_learner_account">
									<cfset get_tp = obj_tp_get.oget_tp(u_id="#user_id#")>
									
									<tr align="center">
										<!---<td width="1%">
											#user_id#
										</td>--->
										<td width="100">
											<span class="badge badge-pill badge-#profile_css# text-white">#profile_name#</span>
										</td>
										<td width="100">
											<span class="badge badge-pill text-white badge-#user_status_css#">#user_status_name#</span>
										</td>
										<td width="100">
										#dateformat(user_create,'dd/mm/yyyy')#	<cfif user_elapsed neq ""><br><small><strong>#replace(obj_lms.get_format_hms(toformat="#user_elapsed#")," ","","ALL")#</strong></small><cfelse>-</cfif>
										</td>
										
										<!---<td width="150">
											<cfif user_steps eq "">
												<span class="badge badge-pill badge-warning text-white">OK</span>
											<cfelse>
												<cfif listfind(user_steps,"1")><span class="badge badge-pill badge-secondary text-white">PT</span><cfelse><span class="badge badge-pill badge-primary text-white">PT</span></cfif>
												<cfif listfind(user_steps,"2")><span class="badge badge-pill badge-secondary text-white">LST</span><cfelse><span class="badge badge-pill badge-primary text-white">LST</span></cfif>
												<cfif listfind(user_steps,"3")><span class="badge badge-pill badge-secondary text-white">RB</span><cfelse><span class="badge badge-pill badge-primary text-white">RB</span></cfif>
											</cfif>
											
										</td>--->
										<td width="250">			
											#user_firstname#<br><strong>#ucase(user_name)#</strong>
										</td>
										<td width="200">
											<small><strong>#mid(account_name,1,20)#</strong></small>
										</td>
										<!--- <td><span class="badge badge-pill <cfif user_qpt eq "A0">bg-danger<cfelseif user_qpt eq "A1">bg-success<cfelseif user_qpt eq "A2">bg-success<cfelseif user_qpt eq "B1">bg-info<cfelseif user_qpt eq "B2">bg-info<cfelseif user_qpt eq "C1">bg-warning<cfelseif user_qpt eq "C2">bg-warning</cfif> text-white">#user_qpt# <cfif user_qpt_lock eq "0">[en cours]</cfif></td>
										<td><cfif user_lst neq ""><span class="badge badge-pill bg-success text-white">DONE</span><cfelse>-</cfif></td> --->
										<td>
											<div class="btn-group">
												<a type="button" id="deploy_tp_#user_id#" class="deploy_tp btn btn-sm btn-info"><i class="fa-light fa-chart-user"></i></a>
												<a type="button" id="edit_user_#user_id#" class="edit_user btn btn-sm btn-info"><i class="fa-light fa-edit"></i></a>
												<!--- <a type="button" id="deactivate_user_#user_id#" class="deactivate_user btn btn-sm btn-info">
													<!--- <i class="fa-light fa-trash-alt"></i> --->
													<i class="fa-light fa-user-slash"></i>
												</a> --->
											</div>
										</td>
										
	
								
											
									</tr>
									</cfoutput>
									
								</table>
								</div>
								
								
								
									
							<!--- <div class="row">

								<div class="col-md-2">
									#user_status_name#
								</div>
								<div class="col-md-2">
									#profile_name#
								</div>
								<div class="col-md-2">
									#user_name#
								</div>
								<div class="col-md-2">
									#user_firstname#
								</div>
								<div class="col-md-2">
								</div>
							</div> --->
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
		document.location.href="tm_admin_learners.cfm?al_id=0";
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
		
	document.location.href="tm_admin_learners.cfm?al_id="+(options == [] ? ['0'] : options);
	return false;
	});


	$('.btn_add_user_tm').click(function(event) {		
		event.preventDefault();
		$('#modal_title_lg').text("Créer Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_learner_tm.cfm?ins_learner=1", function() {});
	});

	$('.edit_user').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[2];

		$('#modal_title_lg').text("Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_learner_tm.cfm?up_learner=1&u_id=" + u_id, function() {});
	});
	
	$('.deploy_tp').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[2];

		$('#modal_title_lg').text("Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_learner_tm.cfm?u_id=" + u_id, function() {});
	});

	<!--- $('.deactivate_user').click(function(event) {
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[2];

		$.ajax({				 
        url: 'api/users/user_post.cfc?method=deactivate_user_tm',
        type: "POST",
        data: {
			u_id: u_id
		},
        datatype : "html",
        success : function(result, statut){
            console.log(result);
            // window.location.href=("partner_index.cfm?k=1")
        },
        error : function(result, statut, error){
        }
    });
	}); --->

});
</script>


</body>
</html>