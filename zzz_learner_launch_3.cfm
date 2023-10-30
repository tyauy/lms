<!DOCTYPE html>
<cfsilent>

	<cfset secure = "3,9">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
	
	<cfset step = "3">
	<cfset u_id = SESSION.USER_ID>
	<cfset t_id = SESSION.TP_ID>	
	<cfset user_needs_nbtrainer = "2">

	<cfinclude template="./incl/incl_trainer_list.cfm">

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
			<!--- <cfset help_page = "help_lstep2"> --->

			<cfinclude template="./incl/incl_nav.cfm">

			<div class="content">
				
				
				<cfif SESSION.USER_ID eq "7767">
					t_list = <cfoutput>#t_list#</cfoutput>
					<br>
				</cfif>
				<cfif REMOTE_ADDR eq "88.174.185.170">
				<!--- <cfoutput>
				<cfoutput>#speaking_criteria_id#</cfoutput>
				<cfdump var="#get_trainer#">
				t_list = #t_list#
				<br>
				u_level =#u_level#
				<br>
				lvl_id = #lvl_id#
				lvl_code = #lvl_code#
				</cfoutput> --->
				</cfif>
				<!--- <cfif SESSION.USER_PROFILE eq "test">
				<cfdump var="#get_trainer#">
				
				<br>
				<cfoutput>
				trainer_hour_list = #trainer_hour_list#<br>
				score_accuracy = #score_accuracy#<br>
				score_charge = #score_charge#
				</cfoutput>
				
				
				</cfif> --->

				<cfinclude template="./incl/incl_nav_learner.cfm">

				<cfif get_trainer.recordcount GT 3 OR teaching_criteria_id eq 2 OR get_trainer.recordcount eq 0>
					<cfinclude template="./widget/wid_trainer_list_learner.cfm">
				</cfif>	

			</div>

			<cfinclude template="./incl/incl_footer.cfm">


		</div>

	</div>

</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {

	console.log("<cfoutput>#avail_id#</cfoutput>")

	$('#btn_update_avail').click(function(){
		event.preventDefault();

		$.ajax({	  
			url: 'api/users/user_post.cfc?method=update_search_criteria',
			type: 'POST',
			data : $('#form_user_avail').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
				// window.location.reload(true);
				window.location.href="learner_launch_3.cfm?s=1";
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});
	})

	$('#btn_update_need_speak').click(function(){
		event.preventDefault();

		$.ajax({	  
			url: 'api/users/user_post.cfc?method=update_search_criteria',
			type: 'POST',
			data : $('#form_user_need_speak').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
				// window.location.reload(true);
				window.location.href="learner_launch_3.cfm?s=1";
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});
	})

	$('#btn_update_need_nb').click(function(){
		event.preventDefault();

		$.ajax({	  
			url: 'api/users/user_post.cfc?method=update_search_criteria',
			type: 'POST',
			data : $('#form_user_need_nb').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				// console.log(result); 
				// window.location.reload(true);
				window.location.href="learner_launch_3.cfm?s=1";
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});
	})
	
	$('[data-toggle="tooltip"]').tooltip({html: true});
	
	<!--- <cfif not isdefined("trainer_choice") AND not isdefined("form.user_needs_nbtrainer") AND not isdefined("form.avail_id") AND not isdefined("form.user_needs_speaking_id") AND s eq 0>

		$('#window_item_xl_unclosable').modal({backdrop:'static',keyboard:false});

		<cfif get_trainer.recordcount LTE 3>
		$('#modal_title_xl_unclosable').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_launch_step3_ol'))#</cfoutput>");
		<cfelse>
		$('#modal_title_xl_unclosable').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_launch_step3'))#</cfoutput>");
		</cfif>
		$('#modal_body_xl_unclosable').empty();
		$('#modal_body_xl_unclosable').load("modal_window_launch3.cfm?trainercount="+<cfoutput>#get_trainer.recordcount#</cfoutput> , function() {});

	<cfelseif get_trainer.recordcount LTE 3 and teaching_criteria_id neq 2 and get_trainer.recordcount neq 0> --->

	<cfif get_trainer.recordcount LTE 3 and teaching_criteria_id neq 2 and get_trainer.recordcount neq 0>

		$('#window_item_xl_unclosable').modal({backdrop:'static',keyboard:false});
		$('#modal_title_xl_unclosable').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer_ol'))#</cfoutput>");
		$('#modal_body_xl_unclosable').empty();
		$('#modal_body_xl_unclosable').load("modal_window_launch3.cfm?show_info=chooseforme_trainer&ol=1&user_needs_nbtrainer=<cfoutput>#user_needs_nbtrainer#&u_id=#u_id#&t_id=#t_id#&t_list=#t_list#&trainercount=#get_trainer.recordcount#</cfoutput>", function() {});
	
	</cfif>

	
	var nbtrainer = [];
	
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
	
	<cfoutput>
	$('.btn_choose_trainer').click(function(event) {	
	
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];	
		
		if($(this).parent().hasClass("active"))
		{
			$(this).parent().toggleClass("active");
			nbtrainer.splice(nbtrainer.indexOf($(this).val()), 1);
			<cfif user_needs_nbtrainer eq "2">
				$('##window_item_lg').modal({keyboard: true});
				$('##modal_title_lg').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#");
				$('##modal_body_lg').empty();
				$('##modal_body_lg').load("modal_window_launch3.cfm?show_info=choose_trainer&user_needs_nbtrainer=#user_needs_nbtrainer#&u_id=#u_id#&t_id=#t_id#&p_list="+nbtrainer, function() {});
			</cfif>
		}
		else
		{
			<cfif user_needs_nbtrainer eq "1">
			if(nbtrainer.length == 0)
			{
				$(this).parent().toggleClass("active");
				nbtrainer.push($(this).val());
				$('##window_item_lg').modal({keyboard: true});
				$('##modal_title_lg').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#");
				$('##modal_body_lg').empty();
				$('##modal_body_lg').load("modal_window_launch3.cfm?show_info=choose_trainer&user_needs_nbtrainer=#user_needs_nbtrainer#&u_id=#u_id#&t_id=#t_id#&p_list="+nbtrainer, function() {});
			}
			else
			{
				window.scrollTo(0, 0);
				alert("#obj_translater.get_translate('js_warning_trainer_max')#");
				$(this).prop("checked",false);
			}
			<cfelse>
			
			<!--- if(nbtrainer.length < 2) --->
			<!--- { --->
				<!--- $(this).parent().toggleClass("active"); --->
				<!--- nbtrainer.push($(this).val()); --->
			<!--- } --->
			if(nbtrainer.length <= 2)
			{
				$(this).parent().toggleClass("active");
				nbtrainer.push($(this).val());
				$('##window_item_lg').modal({keyboard: true});
				$('##modal_title_lg').text("#encodeForJavaScript(trim(obj_translater.get_translate('js_modal_title_confirm_trainer')))#");
				$('##modal_body_lg').empty();
				$('##modal_body_lg').load("modal_window_launch3.cfm?show_info=choose_trainer&user_needs_nbtrainer=#user_needs_nbtrainer#&u_id=#u_id#&t_id=#t_id#&p_list="+nbtrainer, function() {});
			}
			else
			{
				window.scrollTo(0, 0);
				alert("#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#");
				$(this).prop("checked",false);
			}
			</cfif>
		}
		
		if(nbtrainer.length == 0)
		{
			$(".btn_validate_step").prop("disabled",true);
			<!--- alert($(".btn_validate_step").prop("disabled")); --->
		}
		else
		{
			$('.btn_validate_step').prop("disabled",false);
			<!--- alert($('.btn_validate_step').prop("disabled")); --->
		}
		<!--- event.preventDefault(); --->
		<!--- alert($(this).val()); --->
		<!--- var idtemp = $(this).attr("id"); --->
		<!--- var idtemp = idtemp.split("_"); --->
		<!--- var p_id = idtemp[1];	 --->
	});
	
	
	$('.btn_whotochoose').click(function(event) {	
		$('##window_item_lg').modal({keyboard: true});
		$('##modal_title_lg').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_confirm_trainer'))#");
		$('##modal_body_lg').empty();
		$('##modal_body_lg').load("modal_window_launch3.cfm?show_info=chooseforme_trainer&trainercount=#get_trainer.recordcount#&user_needs_nbtrainer=#user_needs_nbtrainer#&u_id=#u_id#&t_id=#t_id#&t_list=#t_list#", function() {});
	})
	

	</cfoutput>

	});
</script>
</body>
</html>