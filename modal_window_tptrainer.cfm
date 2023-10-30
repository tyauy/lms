<!DOCTYPE html>
<cfsilent>

	<cfset secure = "2,3,7,9,5,8,12">
	<cfinclude template="./incl/incl_secure.cfm">	
	
	<cfif not isdefined("SESSION.TP_ID")>
		<cflocation addtoken="no" url="index.cfm">
	</cfif>
	
	<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
		<cfset u_id = u_id>
		<cfset t_id = t_id>
	<cfelse>
		<cfset u_id = SESSION.USER_ID>
		<cfset t_id = SESSION.TP_ID>	
	</cfif>
	<cfset step = "0">

	<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>	
	<cfset f_id = get_tp.formation_id>
	<cfset f_code = get_tp.formation_code>

	
	<cfinclude template="./incl/incl_trainer_list.cfm">

</cfsilent>

	<cfset hide_filter = "1">
	<cfinclude template="./widget/wid_trainer_list_learner.cfm">
						



<script>
$(document).ready(function() {
	
	$('[data-toggle="tooltip"]').tooltip({html: true});

	
	$('.btn_view_trainer').click(function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];	

		$('#modal_body_xl').empty();
		<cfoutput>
		$('##modal_body_xl').load("modal_window_trainerview.cfm?display_back=1&p_id="+p_id+"&t_id=#t_id#&u_id=#u_id#", function() {
		</cfoutput>

		});

	});
	

	$('.btn_choose_trainer').click(function(event) {	
	
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var p_id = idtemp[1];	

		console.log(idtemp);
		
		<cfoutput>
		if(confirm("#encodeForJavaScript(obj_translater.get_translate('js_choose_trainer_confirm'))#"))
		{
            $.ajax({				  
                url: 'api/tp/tp_post.cfc?method=updt_tptrainer_add',
                type: 'POST',
                data : "t_id=#t_id#&u_id=#u_id#&p_id="+p_id, 
                datatype : "html", 
                success : function(result, status){ 
                    console.log('btn_choose_trainer', result); 
					window.location.reload(true);
                }, 
                error : function(result, status, error){ 
                    console.log('err btn_choose_trainer', result); 
                }, 
                complete : function(result, status){ 
                    console.log('comp btn_choose_trainer', result);
                }	 
            });
        }
        </cfoutput>
		
	});

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
				<cfoutput>
				$('##window_item_xl').modal({keyboard: true});
				$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_change_trainer'))#");	
				$('##modal_body_xl').empty();	
				$('##modal_body_xl').load("modal_window_tptrainer.cfm?t_id=#t_id#&u_id=#u_id#&single=1");
				</cfoutput>
				// $('#modal_title_xl').text("Follow-Up");
				// $('#window_item_xl').modal({keyboard: true});
				// $('#modal_body_xl').load("modal_window_log.cfm?u_id="+<cfoutput>#u_id#</cfoutput>, function() {})
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
				<cfoutput>
				$('##window_item_xl').modal({keyboard: true});
				$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_change_trainer'))#");	
				$('##modal_body_xl').empty();	
				$('##modal_body_xl').load("modal_window_tptrainer.cfm?t_id=#t_id#&u_id=#u_id#&single=1");
				</cfoutput>
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

	})

});
</script>
</body>
</html>