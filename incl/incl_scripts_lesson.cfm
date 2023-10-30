<script>
$(document).ready(function() {

    
    // $(".btn_join_class").off("click",handler_join_class);
    // $(".btn_view_tp").off("click",handler_view_tp);
    
    handler_view_tp = function launch_lesson(){
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var tp_id = idtemp[1];
		var view = idtemp[2];
        $('#modal_body_xl').empty();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('card_title_vc'))#</cfoutput>");
		$('#modal_body_xl').load("modal_window_tpview_virtual.cfm?referrer=vc&tp_id="+tp_id+"&view="+view, function() {});
	}
    $(".btn_view_tp").bind("click",handler_view_tp);

    handler_launch_lesson = function launch_lesson(){
        event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.substr(idtemp.indexOf("_")+1,50);
		$('#window_item_lg').modal({backdrop: 'static', keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_nextlesson'))#</cfoutput>");
		$('#modal_body_lg').load("modal_window_lesson_launch.cfm?l_id="+idtemp, function() {});
    }    
    $(".btn_launch_lesson").bind("click",handler_launch_lesson);


    handler_join_class = function join_class(){
        event.preventDefault();		

		var btn = $(this);
        tp_id = $(this).data("tid");
        l_id = $(this).data("lid");
        level_alias = $(this).data("levelalias");
        l_duration = $(this).data("lduration");

        $.ajax({				 
			url: './api/virtualclass/virtualclass_post.cfc?method=book_class',
			type: 'POST',
			data: {"tp_id": tp_id, "l_id": l_id},
			success : function(result, status){
                
			    var obj_result = jQuery.parseJSON(result);

                if(obj_result["LESSON_STATUS"]=="booked")
                {

                    $('#pill_'+l_id).removeClass("text-"+level_alias);
                    $('#pill_'+l_id).removeClass("bg-"+level_alias);
                    $('#pill_'+l_id).removeClass("border-"+level_alias);
                    $('#i_'+l_id).removeClass("text-"+level_alias);

                    $('#pill_'+l_id).addClass("bg-red");
                    $('#pill_'+l_id).addClass("text-white");
                    $('#pill_'+l_id).addClass("border-red");
                    $('#i_'+l_id).addClass("text-white");

					<cfoutput>btn.parent().after('<div><button class="btn btn-red disabled font-weight-normal" id="l_'+l_id+'">#obj_translater.get_translate('btn_launch_lesson')#</button></div>')</cfoutput>
					$('#l_'+l_id).bind("click",handler_launch_lesson);

                    // $('#pillcalendar_'+l_id).addClass("bg-"+level_alias);
                    // $('#pillcalendar_'+l_id).addClass("text-white");
                    // $('#pillcalendar_'+l_id).removeClass("text-dark");

                    $('#join_'+l_id).removeClass("btn-"+level_alias);
                    $('#join_'+l_id).addClass("btn-outline-red");
                    $('#join_'+l_id).text("<cfoutput>#__btn_cancel_short#</cfoutput>");
                    
                    $('#joincalendar_'+l_id).removeClass("btn-"+level_alias);
                    $('#joincalendar_'+l_id).addClass("btn-outline-red");
                    $('#joincalendar_'+l_id).text("<cfoutput>#__btn_cancel_short#</cfoutput>");

                    var show_info = "vc_confirm_booking";
                }
                else
                {
                    $('#pill_'+l_id).removeClass("bg-red");
                    $('#pill_'+l_id).removeClass("text-white");
                    $('#pill_'+l_id).removeClass("border-red");
                    $('#i_'+l_id).removeClass("text-white");

                    $('#pill_'+l_id).addClass("text-"+level_alias);
                    $('#pill_'+l_id).addClass("bg-white");
                    $('#pill_'+l_id).addClass("border-"+level_alias);
                    $('#i_'+l_id).addClass("text-"+level_alias);

                    $('#l_'+l_id).remove();
                    $('#l_'+l_id).off("click",handler_launch_lesson);

                    // $('#pillcalendar_'+l_id).removeClass("bg-"+level_alias);
                    // $('#pillcalendar_'+l_id).removeClass("text-white");
                    // $('#pillcalendar_'+l_id).addClass("text-dark");

                    $('#join_'+l_id).addClass("btn-"+level_alias);
                    $('#join_'+l_id).removeClass("btn-outline-red");
                    $('#join_'+l_id).text("<cfoutput>#__btn_book_short#</cfoutput> "+l_duration+ " <cfoutput>#__min#</cfoutput>");
                    
                    $('#joincalendar_'+l_id).addClass("btn-"+level_alias);
                    $('#joincalendar_'+l_id).removeClass("btn-outline-red");
                    $('#joincalendar_'+l_id).text("<cfoutput>#__btn_book_short#</cfoutput> "+l_duration+ " <cfoutput>#__min#</cfoutput>");

                    var show_info = "vc_cancel_booking";

                }
                $('#modal_body_lg').empty();
                $('#window_item_lg').modal({keyboard: true});
                $('#modal_title_lg').text("*WEFIT LMS*");
                $('#modal_body_lg').load("modal_window_info.cfm?l_id="+l_id+"&show_info="+show_info, function() {});
                
                $('#remaining_'+l_id).html("<strong>"+obj_result["COUNT"]+"</strong>");
                $('#remainingcalendar_'+l_id).html("<strong>"+obj_result["COUNT"]+"</strong>");
                
			},
			error : function(result, status, erreur){
			},
			complete : function(result, status){
			}	
		});
    }
    $(".btn_join_class").bind("click",handler_join_class);

});


</script>