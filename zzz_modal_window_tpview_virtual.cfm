<!DOCTYPE html>

<cfsilent>

<cfset get_tp = obj_tp_get.oget_tp(tp_id)>
<cfset get_session = obj_tp_get.oget_session(t_id="#get_tp.tp_id#")>

<cfset __lesson = obj_translater.get_translate('lesson')>
<cfset __tooltip_fill_ln = obj_translater.get_translate('tooltip_fill_ln')>

<cfset __with = obj_translater.get_translate('with')>
<cfset __cancel = obj_translater.get_translate('tooltip_cancel_lesson')>

<cfset __card_tp_description = obj_translater.get_translate('card_tp_description')>
<cfset __card_tp_lessonnote = obj_translater.get_translate('card_tp_lessonnote')>
<cfset __card_tp_exercice = obj_translater.get_translate('card_tp_exercice')>
<cfset __card_tp_note = obj_translater.get_translate('card_tp_note')>

<cfset __modal_supports = obj_translater.get_translate('modal_supports')>
<cfset __modal_link_ws = obj_translater.get_translate('modal_link_ws')>
<cfset __modal_link_wsk = obj_translater.get_translate('modal_link_wsk')>
<cfset __modal_link_video = obj_translater.get_translate('modal_link_video')>
<cfset __modal_link_audio = obj_translater.get_translate('modal_link_audio')>

<cfset __btn_book_short = obj_translater.get_translate('btn_book_short')>
<cfset __btn_upload_notes = obj_translater.get_translate('btn_upload_notes')>
<cfset __btn_start = obj_translater.get_translate('btn_start')>
<cfset __btn_start_again = obj_translater.get_translate('btn_start_again')>
<cfset __btn_results = obj_translater.get_translate('btn_results')>
<cfset __btn_note = obj_translater.get_translate('btn_note')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
<cfset __tooltip_keyword_connected = obj_translater.get_translate('tooltip_keyword_connected')>		

<cfdirectory directory="#SESSION.BO_ROOT#/assets/attachment/" name="dirQuery" action="LIST">

<cfif not isDefined("u_id")>
	<cfset u_id = SESSION.USER_ID>
</cfif>
</cfsilent>


<cfloop query="get_tp">

	<cfif isdefined("k")>

		<cfif k eq "1">									
			<div class="alert alert-success mb-5" role="alert">
				<cfoutput>#obj_translater.get_translate('vc_alert_tp_follow')#</cfoutput>
			</div>
		<cfelseif k eq "2">									
			<div class="alert alert-success mb-5" role="alert">
				<cfoutput>#obj_translater.get_translate('vc_alert_tp_unfollow')#</cfoutput>
			</div>
		</cfif>

	</cfif>

	<cfset view="subscribe">
	<cfinclude template="./incl/incl_tp_header.cfm">

	<div class="row mt-3">
		<div class="col-md-12">
			
			<div class="accordion" id="tpgo">

				<cfoutput query="get_session" group="session_id">

					<cfset display_toolbox = "1">
					<cfinclude template="./incl/incl_session_container.cfm">
							
				</cfoutput>
				
			</div>
		</div>
		
	</div>
</div>

</cfloop>
      
		
<script>
$(document).ready(function() {

/*<cfoutput>
	$('.btn_view_quiz').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var quiz_user_id = idtemp[1];	
		$('##modal_title_xl').text("#encodeForJavaScript(obj_translater.get_translate('js_modal_title_quiz_result'))#");
		$('##window_item_xl').modal({keyboard: true});
		$('##modal_body_xl').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&u_id=#u_id#", function() {});
	})
</cfoutput>*/

	$('.btn_subscribe_class').click(function(event) {
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];	
		// alert(tp_id);
        $.ajax({				 
			url: './api/virtualclass/virtualclass_post.cfc?method=subscribe_class',
			type: 'POST',
			data: {"tp_id": tp_id },
			success : function(result, status){
                $('#modal_body_xl').empty();
				<cfif isdefined("referrer") AND referrer eq "hp">
					// alert("coming from HP");
					document.location.href="learner_index.cfm";
				<cfelseif isdefined("referrer") AND referrer eq "vc">
					// alert("coming from VC");
					if(result == "2")
					{
						$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&k=1&tp_id="+tp_id, function() {});
					}
					else
					{
						$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&k=2&tp_id="+tp_id, function() {});
					}
				<cfelse>
					document.location.href="learner_virtual.cfm?k=1";
				</cfif> 
				
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

	$('.btn_join_class').click(function(event) {
		event.preventDefault();		

		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];	
		var l_id = idtemp[2];	

        $.ajax({				 
			url: './api/virtualclass/virtualclass_post.cfc?method=book_class',
			type: 'POST',
			data: {"tp_id": tp_id, "l_id": l_id},
			success : function(result, status){
				//console.log("result = "+result);
				$('#modal_body_xl').empty();
				$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?tp_id="+tp_id+"&l_id="+l_id, function() {});
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
	});

	<cfif isdefined("l_id")>
		var l_id = $("#lesson_<cfoutput>#l_id#</cfoutput>").offset().top-100;
		$('#window_item_xl').animate({
			scrollTop: (l_id)
		}, 1000);
	</cfif>
	


})
</script>