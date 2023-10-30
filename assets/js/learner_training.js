var counter;
	
$(document).ready(function() {

	
	counter = <cfoutput>#tpcor#</cfoutput>

	$('#tp_list a').click(function(){
		counter = $(this).attr('id').substring(2,10);
	})


	
	
	
	/************************************* ADD SESSION ***************************************/
	
	function add_session(event) {
	
		/*event.preventDefault();
		event.stopPropagation();*/
		
		var sm_id = $(this).attr('id').substring(2,10);
		var duration = $("#d_"+sm_id).val();
		var data_send = "tp_id="+counter+"&sm_id="+sm_id+"&duration="+duration;

		$.ajax({
			url: 'qtest.cfm',
			data: data_send,
			type: "POST",
			success : function(html_return, statut){				
				console.log(html_return);		
				populate_tp(counter,html_return)
				
		/*$('#jstree_build_'+counter).jstree("destroy");	

		$('#jstree_build_'+counter).jstree({
			"core" : {
				"check_callback" : true,
				"data" : jQuery.parseJSON(html_return) 
			},
			"plugins" : ["dnd","state","types","wholerow","changed","conditionalselect"]
		});*/
			
			}
		});
	}	
	
	
	
	
	
	
	
	
	
	
	
	/************************************* MOVE SESSION ***************************************/
	
	function moveup_session(event) {
		
		var s_id = $(this).attr('id').substring(4,10);
		var data_send = "tp_id="+counter+"&s_id="+s_id+"&move_session=up";

		$.ajax({
			url: 'qtest.cfm',
			data: data_send,
			type: "POST",
			success : function(html_return, statut){				
				console.log(html_return);		
				populate_tp(counter,html_return)			
			}
		});
	}	
	function movedown_session(event) {
		
		var s_id = $(this).attr('id').substring(4,10);
		var data_send = "tp_id="+counter+"&s_id="+s_id+"&move_session=down";

		$.ajax({
			url: 'qtest.cfm',
			data: data_send,
			type: "POST",
			success : function(html_return, statut){				
				console.log(html_return);		
				populate_tp(counter,html_return)			
			}
		});
	}	
	
	
	
	

		
	/************************************* DELETE SESSION ***************************************/
	
	function del_session(event) {
		/*event.preventDefault();
		event.stopPropagation();*/
		

		if(confirm('Supprimer session ?')){
		var s_id = $(this).attr('id').substring(2,10);
		var data_send = "tp_id="+counter+"&del_session=1&s_id="+s_id;
		$.ajax({
			url: 'qtest.cfm',
			data: data_send,
			type: "POST",
			success : function(html_return, statut){		
				console.log(html_return);		
				populate_tp(counter,html_return);
			}	
		});		
		}		
	}	

	
	
	
	/************************************* DELETE MODULE ***************************************/
	
	function del_module(event) {	
		/*event.preventDefault();
		event.stopPropagation();*/
		
		if(confirm("Effacer tout le module ?"))
		{		
			var m_id = $(this).attr('id').substring(2,10);
			var data_send = "tp_id="+counter+"&del_module=1&m_id="+m_id;

			$.ajax({
				url: 'qtest.cfm',
				data: data_send,
				type: "POST",
				success : function(html_return, statut){					
					console.log(html_return);		
					populate_tp(counter,html_return)		
				}	
			});			
		}
	}	
	

	
	/************************************* ADD PREBUILT ***************************************/
	
	function add_prebuilt(event) {
		/*event.preventDefault();
		event.stopPropagation();*/
		
		var prebuilt_id = $(this).attr('id').substring(2,10);
		var data_send = "tp_id="+counter+"&prebuilt_id="+prebuilt_id+"&add_prebuilt=1";

		$.ajax({
			url: 'qtest.cfm',
			data: data_send,
			type: "POST",
			success : function(html_return, statut){		
				console.log(html_return);
				populate_tp(counter,html_return)	
			}
		});
	}	
	
	
	
	
	
	
	function select_folder(event) {
	
		event.preventDefault();
		counter = $(this).attr('id').substring(2,10);

	}	
	
	
	
	
	function param_tree(event) {
	
		var children = $(this).parent('li.parent_li').find(' > ul > li');
		if (children.is(":visible")) {
			children.hide('fast');
			$(this).attr('title', 'Expand').find(' > i').removeClass('glyphicon-minus-sign').addClass('glyphicon-plus-sign');
		} else {
			children.show('fast');
			$(this).attr('title', 'Collapse').find(' > i').removeClass('glyphicon-plus-sign').addClass('glyphicon-minus-sign');
		}
		event.stopPropagation();
		
	}
	
	
	
	
	
	/************************************* RECREATE TREE ***************************************/
	
	
	function populate_tp(counter,html_return)
	{
		var json_obj = $.parseJSON(html_return);
		/*alert(counter);*/
				
<!----
<ul style="padding:0px">									
<li><span style="background-color:#000; color:#FFF; font-size:14px">A1 - GENERAL ENGLISH LEVEL 1</span>
<a class="btn btn-default btn-xs btn_del_module" id="m_1"><i class="glyphicon glyphicon-remove"></i></a>
<ul>
<li><span style="background-color:#FFF;"><img src="../img/picto_methode_.png" style="margin-right:2px" width="18">[60] To be</span> <a class="btn btn-default btn-xs btn_del_session" id="s_1395"><i class="glyphicon glyphicon-remove"></i></a><a class="btn btn-default btn-xs"><i class="glyphicon glyphicon-chevron-up"></i></a><a class="btn btn-default btn-xs"><i class="glyphicon glyphicon-chevron-down"></i></a>
</li>
<li><span style="background-color:#FFF;"><img src="../img/picto_methode_.png" style="margin-right:2px" width="18">[60] To be</span> <a class="btn btn-default btn-xs btn_del_session" id="s_1396"><i class="glyphicon glyphicon-remove"></i></a><a class="btn btn-default btn-xs"><i class="glyphicon glyphicon-chevron-up"></i></a><a class="btn btn-default btn-xs"><i class="glyphicon glyphicon-chevron-down"></i></a>
</li>
</ul>
---->
		
				
				
				
				
		$('#tree_build_'+counter).empty();
		/*var newtree = '<ul style="padding:0px"><li class="tree_1"><span class="btn-xs" style="background-color:#888; color:#FFF"><i class="glyphicon glyphicon-plus-sign"></i> TP #'+counter+'</span></ul>';*/
		var newtree = '<ul style="padding:0px" class="tree_1"></ul>';
		$('#tree_build_'+counter).append(newtree);
						
		$.each(json_obj, function(key) {
			
			if(key == 0)
			{
			$("#tp_duration_"+json_obj[key].TP_ID).val(json_obj[key].TOTAL_HOUR);
			}
			else
			{
			
			var appendtree = '';
			var appendtree_child = '';			
			
			if(json_obj[key].PARENT_ID == "")
			{
				appendtree += '<li> <span style="background-color:#000; color:#FFF; font-size:14px">'+json_obj[key].SESSIONMASTER_NAME+'</span> <a class="btn btn-default btn-xs btn_del_module" id="m_'+json_obj[key].MODULE_ID+'"><i class="glyphicon glyphicon-remove"></i></a><ul class="tree_2_'+json_obj[key].MODULE_ID+'_'+json_obj[key].RANK+'"></ul></li>';
				$('.tree_1').append(appendtree);			
				
			}
			else{
				appendtree_child += '<li> <span> ['+json_obj[key].SESSION_DURATION+'] '+json_obj[key].SESSIONMASTER_NAME+'</span> <a class="btn btn-default btn-xs btn_del_session" id="s_'+json_obj[key].SESSION_ID+'"><i class="glyphicon glyphicon-remove"></i></a><a class="btn btn-default btn-xs btn_moveup_session" id="mup_'+json_obj[key].SESSION_ID+'"><i class="glyphicon glyphicon-menu-up"></i></a><a class="btn btn-default btn-xs btn_movedown_session" id="mdo_'+json_obj[key].SESSION_ID+'"><i class="glyphicon glyphicon-menu-down"></i>';
				$('.tree_2_'+json_obj[key].MODULE_ID+'_'+json_obj[key].RANK).append(appendtree_child);			

			}
			}
	
		})

				
	}
	
	
	
	
	/*
	function populate_tp_old(html_return)
	{
		var json_obj = $.parseJSON(html_return);
					
		$('#tree_build_'+counter).empty();
		var newtree = '<ul style="padding:0px"><li class="tree_1"><span class="btn-xs" style="background-color:#888; color:#FFF"><i class="glyphicon glyphicon-plus-sign"></i> TP #'+counter+'</span></ul>';
		var newtree = '<ul style="padding:0px" class="tree_1"></ul>';
		$('#tree_build_'+counter).append(newtree);
						
		$.each(json_obj, function(key) {
			var appendtree = '';					
			
			if(json_obj[key].MODULE_ID != "")			{

				appendtree += '<li> <span style="background-color:#BBB; color:#FFF">'+json_obj[key].SESSIONMASTER_NAME+'</span> <a class="btn btn-default btn-xs btn_del_module" id="m_'+json_obj[key].MODULE_ID+'"><i class="glyphicon glyphicon-remove"></i></a><ul class="tree_2_'+json_obj[key].MODULE_ID+'"></ul></li>';
				$('.tree_1').append(appendtree);			
				
			}
			else{
				appendtree += '<li> <span>'+json_obj[key].SESSIONMASTER_NAME+'</span> <a class="btn btn-default btn-xs btn_del_session" id="s_'+json_obj[key].SESSION_ID+'"><i class="glyphicon glyphicon-remove"></i></a>';
				$('.tree_2_'+json_obj[key].PARENT_ID).append(appendtree);			

			}
			
	
		})

		/***************RE-PARAM ACTION **********
		$('.btn_del_session').on("click", del_session);
		$('.btn_del_module').on("click", del_module);			
		$('#tree_build_'+counter).addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
		$('#tree_build_'+counter+' li.parent_li > span').on("click", param_tree);
				
				
	}
	*/

	/*
		
	$('.fc-drag').data('duration', '01:00'); */
	
	$('.fc-drag').each(function() {

		/*var id = $(this).attr('id');
		var count = id.lastIndexOf("_");
		var go = id.substring(count+1,10);
		var test = go/60;
		
		$(this).data('duration', '00:45'); */
		
		$(this).draggable({
			zIndex: 999,
			revert: true,      // will cause the event to go back to its
			revertDuration: 0  //  original position after the drag
		});

	});
	
	
	
$(document).on("click",".tp_folder",select_folder);
$(document).on("click",".btn_add_prebuilt",add_prebuilt);
$(document).on("click",".btn_del_session",del_session);
$(document).on("click",".btn_add_session",add_session);
$(document).on("click",".btn_del_module",del_module);
$(document).on("click",".btn_moveup_session",moveup_session);
$(document).on("click",".btn_movedown_session",movedown_session);	

});