<cfparam name="obj_id" default = "1">
<cfparam name="kw_id" default = "0">
<cfparam name="lvl_id" default = "0">

<div class="container">

    <div class="row">
        <div class="col-3 bg-light border">
            <div class="py-3">

                <div class="sidebar_loader">

                    <cfinclude template="./incl/incl_module_syllabus_sidebar.cfm">
                
                </div>

            </div>
        </div>
        <div class="col-9">
            <div class="spinner-border text-danger d-none" id="loader_mapping" role="status">
            <span class="sr-only">Loading...</span>
            </div>
            
            <div class="content_loader">

                

            </div>
        </div>
    </div>

</div>




<script>
    $(document).ready(function() {

        var lvl_id = <cfoutput>#lvl_id#</cfoutput>;
        var obj_id = <cfoutput>#obj_id#</cfoutput>;
        var kw_id = <cfoutput>#kw_id#</cfoutput>;

        go_search(obj_id,lvl_id,kw_id);

        function go_search(obj_id,lvl_id,kw_id)
        {
            
            $('#loader_mapping').removeClass("d-none");
            $('#loader_mapping').addClass("d-block");
            
            if(obj_id == 6)
            {
                var urlgo = './api/elearning/elearning_get.cfc?method=get_module_card';
            }
            else
            {
                var urlgo = './api/elearning/elearning_get.cfc?method=get_sessionmaster_row';
            }

            $.ajax({
                url: urlgo,
                type: "POST",
                data: {lvl_id:lvl_id,obj_id:obj_id,kw_id:kw_id,read_mode:"1"},
                datatype : "html",
                success : function(result, statut){
                    // console.log(result);            

                    $('#loader_mapping').addClass("d-none");
                    $('#loader_mapping').removeClass("d-block");

                    $(".content_loader").append(result);
                    $(".btn_add_tp").off("click");
                    $(".btn_add_tp").bind("click",handler_add_module_tp);
    
                    $(".btn_player").off("click");
                    $(".btn_player").bind("click",handler_play_module);
                    
                }
            })
        }

    function go_sidebar(obj_id,lvl_id,kw_id)
    {
        $.ajax({
            url: './incl/incl_module_el_sidebar.cfm',
            type: "POST",
            data: {lvl_id:lvl_id,obj_id:obj_id,kw_id:kw_id},
            datatype : "html",
            success : function(result, statut){
                // console.log(result);            
                $(".sidebar_loader").append(result);
                $(".btn_obj").bind("click",handler_change_obj);
                $(".btn_level").bind("click",handler_change_level);
                $(".btn_keyword").bind("click",handler_change_keyword);
                $(".btn_add_tp").bind("click",handler_add_module_tp);
                $(".btn_player").bind("click",handler_play_module);

            }
        })
    }
    
    var handler_change_keyword = function change_keyword(){
        event.preventDefault();

        kw_id = $(this).attr('data-kwid');

        $(".sidebar_loader").empty();
        
        go_sidebar(obj_id,lvl_id,kw_id);

        $(".content_loader").empty();
        $('.btn_keyword').removeClass("font-weight-bold");
        $('.btn_keyword').removeClass("text-red");
        $(this).addClass("font-weight-bold");
        $(this).addClass("text-red");
        
        go_search(obj_id,lvl_id,kw_id);

    };
    $(".btn_keyword").bind("click",handler_change_keyword);


    var handler_change_level = function change_level(){
        event.preventDefault();

        lvl_id = $(this).attr('data-levelid');

        $(".sidebar_loader").empty();

        go_sidebar(obj_id,lvl_id,kw_id);

        $(".content_loader").empty();
        $('.btn_level').removeClass("font-weight-bold");
        $('.btn_level').removeClass("text-red");
        $(this).addClass("font-weight-bold");
        $(this).addClass("text-red");

        go_search(obj_id,lvl_id,kw_id);

    };
    $(".btn_level").bind("click",handler_change_level);

    
    var handler_change_obj = function change_obj(){
        event.preventDefault();

        obj_id = $(this).attr('data-objid');

        $(".sidebar_loader").empty();

        go_sidebar(obj_id,lvl_id,kw_id);
            
        $(".content_loader").empty();
        $('.btn_obj').removeClass("font-weight-bold");
        $('.btn_obj').removeClass("text-red");
        $(this).addClass("font-weight-bold");
        $(this).addClass("text-red");

        go_search(obj_id,lvl_id,kw_id);

    };    
    $(".btn_obj").bind("click",handler_change_obj);







    var handler_add_module_tp = function add_module_tp(){
        event.preventDefault();
        sm_id = $(this).attr('data-smid');
        module_id = $(this).attr('data-mid');
        lvl_alias = $(this).attr('data-lalias');
        _status = $(this).attr('data-status');
        var obj = $(this);

        //console.log("sm_id" + sm_id);
        //console.log("module_id" + module_id);
        //console.log("lvl_id" + lvl_id);
        //console.log("lvl_alias" + lvl_alias);

        $.ajax({
			url: 'api/tracking/tracking_post.cfc?method=insert_elearning_session',
			type: 'POST',
			data : {
                user_id: <cfoutput>#SESSION.USER_ID#</cfoutput>,
                module_id: module_id
            },
			datatype : "html", 
			success : function(result, status){ 
                if (_status == 'in') {
                           
                    obj.attr('data-status','up');           
                    obj.empty();

                    if(obj_id == 6)
                    {
                        $("#container_"+sm_id).prepend("<div class='triangle triangle_red'></div><i class='fa-sharp fa-light fa-check text-white triangle_check'></i>");
                        $("#container_"+sm_id).addClass("border-red");
                        obj.removeClass('btn-outline-red');
                        obj.addClass('btn-red');
                        obj.append('<i class="fa-thin fa-check fa-lg"></i>');
                    }
                    else
                    {
                        $("#container_"+sm_id).prepend("<div class='triangle triangle_"+lvl_alias+"'></div><i class='fa-sharp fa-light fa-check text-white triangle_check'></i>");
                        $("#container_"+sm_id).addClass("border-"+lvl_alias);
                        obj.removeClass('btn-outline-'+lvl_alias);
                        obj.addClass('btn-'+lvl_alias);
                        obj.append('<i class="fa-thin fa-check fa-lg"></i> <cfoutput>#encodeForJavascript(obj_translater.get_translate('btn_tp_added'))#</cfoutput>');
                    }             
                    
                } else if (_status == 'up') {
                    $("#container_"+sm_id).find(".triangle").remove();
                    $("#container_"+sm_id).find(".fa-sharp").remove();

                    obj.attr('data-status','in');
                    obj.empty();

                    if(obj_id == 6)
                    {
                    $("#container_"+sm_id).removeClass("border-red");
                    obj.addClass('btn-outline-red');
                    obj.removeClass('btn-red');
                    obj.append('<i class="fa-thin fa-floppy-disk fa-lg"></i>');
                    }
                    else
                    {
                    $("#container_"+sm_id).removeClass("border-"+lvl_alias);
                    obj.removeClass('btn-'+lvl_alias);
                    obj.addClass('btn-outline-'+lvl_alias);
                    obj.append('<i class="fa-thin fa-floppy-disk fa-lg"></i> <cfoutput>#encodeForJavascript(obj_translater.get_translate('btn_tp_add'))#</cfoutput>');
                    }


                }
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});
    }
    $(".btn_add_tp").bind("click",handler_add_module_tp);
    
    


    var handler_play_module = function trigger_modal(){
        sm_id = $(this).attr('data-smid');
        event.preventDefault();
        $('#window_item_el_syllabus').modal('hide');
    }
    $(".btn_player").bind("click",handler_play_module);
    
});
</script>