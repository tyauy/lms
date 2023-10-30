<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "13">
<cfinclude template="./incl/incl_secure.cfm">	

<cfset list_formation = "1,2,3,4,5">

<cfparam name="st_tm_id" default="1">
<cfparam name="ust_id" default="100">
<cfparam name="m_id" default="100">

<cfparam name="msel" default="#month(now())#">
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#">

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


<cfquery name="get_widget" datasource="#SESSION.BDDSOURCE#">
SELECT widget_id, widget_code, widget_name_#SESSION.LANG_CODE# as widget_name FROM user_widget
</cfquery>
		

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	
	.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
		background-color: #51bcda !important;
	}

	.loader{
		/*display:none; */
		background-repeat:no-repeat; 
		background-position:center center; 
		background-image:url('./assets/img/ajax-loader.gif'); 
		min-width:16px; 
		min-height:16px;
	}

	</style>
	<cfinclude template="./incl/incl_scripts.cfm">
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "WEFIT Partner Management System">
		
		<cfinclude template="./incl/incl_nav.cfm">


		<div class="content">
		
			<cfif isdefined("k") AND k eq "1">
				<div class="alert alert-success">
					Apprenant correctement lancé.
				</div>
			</cfif>

			<div class="row justify-content-md-center">
				<div class="col-md-6">
					<cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						
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
			</div>
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			<div class="row mt-3">
				
				<cfloop query="get_widget">
				
				<cfif listfind(SESSION.USER_WIDGET,get_widget.widget_id)>
					<cfoutput>
						<div class="col-lg-4 col-md-6 col-sm-6 mb-4" id="widget_container_#get_widget.widget_code#">
							<div class="loader"></div>	
						</div>
					</cfoutput>

				</cfif>
				</cfloop>
				
				
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	<cfif isdefined("SESSION.USER_PWD_CHG") AND SESSION.USER_PWD_CHG eq "0">
		$('#window_item_pw').modal({keyboard: false,backdrop:'static'});
		$('#modal_title_pw').text("<cfoutput>#obj_translater.get_translate('js_modal_title_mdp_reset')#</cfoutput>");		
		$('#modal_body_pw').load("modal_window_mdp.cfm?init=1", function() {});
	</cfif>

	let widget = [
		<cfset counter_w = 0>
		<cfloop query="get_widget">
			<cfif listfind(SESSION.USER_WIDGET,get_widget.widget_id)>
			<cfif counter_w GT 0 >,</cfif>{
				widget_name: "<cfoutput>#REReplace(get_widget.widget_name,"[^0-9A-Za-z -]","","all")#</cfoutput>",
				view: "<cfoutput>#get_widget.widget_code#</cfoutput>"
			}
			<cfset counter_w++>
			</cfif>
		</cfloop>
	]

	function init_dashboard(nb = 0) {

		while (nb < widget.length) {
			$('#widget_container_'+widget[nb].view).load("./widget/wid_tm_dashboard.cfm?partner=1&view=" + widget[nb].view + "&al_id=<cfoutput>#al_id#</cfoutput>", function() {});
			nb++;
		}
	}

	init_dashboard();


	var options = [<cfoutput>#al_id#</cfoutput>];

	$( '#tm_account_select a' ).on( 'click', function( event ) {

	var target = $( event.currentTarget );
	var val = target.attr( 'data-value' ) * 1;
	var inp = target.find( 'input' );

	if (val == 0) {
		options = [];
		document.location.href='tm_index.cfm?al_id=0';
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

	document.location.href='partner_index.cfm?al_id='+ (options == [] ? ['0'] : options);
	return false;
	});


	$('.btn_add_user').click(function(event) {		
		event.preventDefault();
		$('#modal_title_lg').text("Créer Apprenant");
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_body_lg').load("modal_window_partner.cfm?create_user=1", function() {});
	});

		
});
</script>


</body>
</html>