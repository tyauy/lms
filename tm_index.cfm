<!DOCTYPE html>

<cfsilent>
	
<cfset secure = "8">
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

<!--- <cfquery name="get_price_unit" datasource="#SESSION.BDDSOURCE#"> --->
<!--- SELECT * FROM account_group_price --->
<!--- WHERE group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.GROUP_ID#"> --->
<!--- </cfquery> --->

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


<cfquery name="get_widget" datasource="#SESSION.BDDSOURCE#">
SELECT widget_id, widget_code, widget_name_#SESSION.LANG_CODE# as widget_name FROM user_widget
</cfquery>
		

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">
	<style type="text/css">
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	
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
      
		<cfset title_page = obj_translater.get_translate('title_page_tm_index')>
		
		<cfinclude template="./incl/incl_nav.cfm">


		<div class="content">
		
		
			<div class="row justify-content-md-center">
				<div class="col-md-6">
					<cfif listlen("#SESSION.USER_ACCOUNT_RIGHT_ID#") gt 1>
						<!---  document.location.href='tm_index.cfm?a_id='+ --->
						<!--- <select class="form-control" name="a_id" id="a_id" onchange="document.location.href='tm_index.cfm?a_id='+$(this).val()">
						<cfoutput query="get_account_tm">
						<option value="#account_id#" <cfif a_id eq account_id>selected</cfif>>#account_name#</option>
						</cfoutput>
						<cfoutput>
						<option value="0" <cfif a_id eq 0>selected</cfif>>#obj_translater.get_translate('table_th_all_accounts')#</option>
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
			</div>
										
			<!---<div class="row">
			
				<div class="col-md-8">	
				
					<div class="card">
					
						<div class="card-body">
				
							<!---<div class="row">
								<div class="col-md-12">			
									Statut Apprenant
									<cfoutput>
									<a href="tm_index.cfm?ust_id=100&st_id=#st_id#&m_id=#m_id#" class="btn btn-sm <cfif ust_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-graduation-cap"></i>&nbsp;ALL</a>
									</cfoutput>
									
									<cfoutput query="get_user_status">
									<a href="tm_index.cfm?ust_id=#user_status_id#&st_id=#st_id#&m_id=#m_id#" class="btn btn-sm <cfif ust_id eq user_status_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-users"></i>&nbsp;#user_status_name#</a>
									</cfoutput>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">			
									M&eacute;thode
									<cfoutput>
									<a href="tm_index.cfm?ust_id=#ust_id#&st_id=#st_id#&m_id=100" class="btn btn-sm <cfif m_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-graduation-cap"></i>&nbsp;ALL</a>
									</cfoutput>
									<cfoutput query="get_tp_method">
									<a href="tm_index.cfm?ust_id=#ust_id#&st_id=#st_id#&m_id=#method_id#" class="btn btn-sm <cfif m_id eq method_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-graduation-cap"></i>&nbsp;#method_name#</a>
									</cfoutput>
								</div>
							</div>--->
							<!---<div class="row">
								<div class="col-md-12">
									Statut Parcours
									<cfoutput>
									<a href="tm_learners.cfm?ust_id=#ust_id#&st_id=100&m_id=#m_id#" class="btn btn-sm <cfif st_id eq "100">btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-bookmark"></i>&nbsp;ALL</a>
									<a href="tm_learners.cfm?ust_id=#ust_id#&st_id=0&m_id=#m_id#" class="btn btn-sm <cfif st_id eq "0">btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-bookmark"></i>&nbsp;NO TP</a>
									</cfoutput>
									<cfoutput query="get_tp_status">
									<a href="tm_learners.cfm?ust_id=#ust_id#&st_id=#tp_status_id#&m_id=#m_id#" class="btn btn-sm <cfif st_id eq tp_status_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fal fa-bookmark"></i>&nbsp;#status_name#</a>
									</cfoutput>
								</div>
							</div>--->
							
						</div>
						
					</div>
					
				</div>
				
				
				
				
			</div>--->
				
			<cfif isdefined("pconnect")>
				<div class="alert alert-danger" role="alert" align="center">
				<cfoutput>#obj_translater.get_translate('alert_no_access')#</cfoutput>
				</div>
			</cfif>
			
			<div class="row mt-3">
				
				<cfloop query="get_widget">
					<cfif listFind(SESSION.USER_WIDGET, get_widget.widget_id)>
						<!--- <cfif NOT listFind("7,8,9,10", get_widget.widget_id)> --->
							<cfoutput>
								<div class="col-lg-4 col-md-6 col-sm-6 mb-4" id="widget_container_#get_widget.widget_code#">
									<div class='loader'></div>    
									<!--- 
									<cfset view = get_widget.widget_code>
									<cfset widget_name = get_widget.widget_name>
									<cfinclude template="./widget/wid_tm_dashboard.cfm"> 
									--->
								</div>
							</cfoutput>
						<!--- </cfif> --->
					</cfif>
				</cfloop>
				
				
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  






<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$(document).ready(function() {

	let widget = [
		<cfset counter_w = 0>
		<cfloop query="get_widget">
			<cfif listfind(SESSION.USER_WIDGET,get_widget.widget_id)>
				<!---<cfif get_widget.widget_id neq "7" AND get_widget.widget_id neq "8" AND get_widget.widget_id neq "9" AND get_widget.widget_id neq "10">--->

					<cfif counter_w GT 0 >,</cfif>{
						widget_name: "<cfoutput>#REReplace(get_widget.widget_name,"[^0-9A-Za-z -]","","all")#</cfoutput>",
						view: "<cfoutput>#get_widget.widget_code#</cfoutput>"
					}
					<cfset counter_w++>
				<!---</cfif>--->
			</cfif>
		</cfloop>
	]



	function init_dashboard(nb = 0) {
		while (nb < widget.length) {
			$('#widget_container_'+widget[nb].view).load("./widget/wid_tm_dashboard.cfm?view=" + widget[nb].view + "&al_id=<cfoutput>#al_id#</cfoutput>", function() {});
			nb++;
		}
	}
	init_dashboard();


	$('.btn_view_conv').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var o_type = idtemp[0];		
		var o_md = idtemp[1];	
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Apercu document");
		$('#modal_body_lg').load("modal_window_viewer.cfm?o_md="+o_md+"&o_type="+o_type, function() {});
	});

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
		
	document.location.href='tm_index.cfm?al_id='+ (options == [] ? ['0'] : options);
	return false;
	});
		
});
</script>


</body>
</html>