<!DOCTYPE html>

<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
		
	<cfset step = "2">
	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>
	<cfset a_id = SESSION.ACCOUNT_ID>

</cfsilent>

<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">

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
		.btn-outline-success {
			text-transform:none !important; 
			border: 1px solid #6bd098 !important;
		}
		.btn-outline-warning {
			text-transform:none !important; 
			border: 1px solid #fbc658 !important;
		}	
		.btn-outline-primary {
			text-transform:none !important; 
			border: 1px solid #51cbce !important;
		}
		.btn-outline-secondary {
			text-transform:none !important; 
			border: 1px solid #ECECEC !important;
		}
		
		.card_module:hover {
			border-color:#FFA100;
			-webkit-filter: grayscale(0%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(0%); /* Firefox */
		}
		.card_module {
			border:1px solid #ECECEC;
			-webkit-filter: grayscale(90%); /* Pour les navigateurs Chrome, Safari, Opera */
			filter: grayscale(90%); /* Firefox */
		}
		.sidebar-outer {
			position: relative;
		}
		.fixed {
			position: fixed;
		}
		.tp_type_id,.tp_orientation_id{
			display: inline-block;
			-webkit-appearance: none;
			-moz-appearance: none;
			-o-appearance: none;
			appearance: none;
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

				<cfif isdefined("k") AND k eq "1">
					<div class="alert alert-success" role="alert" align="center">				
						<cfoutput>#obj_translater.get_translate('alert_needs_ok')#</cfoutput>
					</div>
				</cfif>

				<cfinclude template="./incl/incl_nav_launching.cfm">

			</div>	
			
		<cfinclude template="./incl/incl_footer.cfm">

	</div>
</div>


<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">


<script>
$(document).ready(function() {

	$('[data-toggle="tooltip"]').tooltip();

	<cfoutput>	
	<cfif not isdefined("tp_choice")>
		$('##window_item_xl_unclosable').modal({backdrop: 'static',keyboard: false});
		$('##modal_title_xl_unclosable').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl_unclosable').empty();
		$('##modal_body_xl_unclosable').load("modal_window_launch2.cfm?view=param_tp", function() {});
	<cfelse>
		<cfif isdefined("kw_choice")>
		$('##window_item_xl_unclosable').modal({keyboard: false});
		$('##modal_title_xl_unclosable').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_launch_step2')))#");
		$('##modal_body_xl_unclosable').empty();
		$('##modal_body_xl_unclosable').load("modal_window_launch2.cfm?view=param_themes&tp_choice=#tp_choice#", function() {});
		</cfif>
	</cfif>		
	</cfoutput>
});
</script>
</body>
</html>