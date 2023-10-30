<script>

	<cfif not isdefined("picker")>
	<cfset picker = dateformat(now(),"yyyy-mm-dd")>
	</cfif>
	
	var avail_choice = "remove";
	var currentTimezone = "UTC";
	
	var scroll = 0;
	
$(document).ready(function() {
	
	var booked = {
		<cfoutput query="get_session" group="session_id">
		<cfoutput group="lesson_id">
			<cfif lesson_id neq "">
				'#session_rank#' : {
					date: '#dateformat(lesson_start,"yyyy-mm-dd")#',
					hour: '#timeformat(lesson_start,'HH')#',
					min: '#timeformat(lesson_start,'mm')#',
					id: #planner_id#,
					l_id: #lesson_id#
				},
			</cfif>
		</cfoutput>
	</cfoutput>
	};
	
	var interval = "<cfoutput>#interval#</cfoutput>";
	
	var cur_rk = 1;
	
	var s_dur = <cfoutput>#s_dur#</cfoutput>;
	
	var _id = [<cfoutput query="get_trainer">#get_trainer.planner_id#,</cfoutput>]
	
	var show_booked_lesson = function(_id = 0, _rk = 0) {	
		console.log("show_booked_lesson",booked)
		// console.log(booked.size())
	
		// for (const key in booked) {
		// 	if (Object.hasOwnProperty.call(booked, key)) {
		// 		const element = booked[key];
		// 		// console.log(element);
		// 		if (element.id == _id || _id == 0) {
		// 			// console.log("show_booked_lesson",_id)
					
		// 			// console.log("1",document.getElementById('as_140_2023-01-30'))
		// 			// console.log("2",'as_'+element.id+'_'+element.date)
		// 			// console.log("3",document.getElementById('as_'+element.id+'_'+element.date))
		// 			if($('#as_'+element.id+'_'+element.date)) {
	
		// 				let tmp = $("<a></a>");
	
		// 				// console.log(_rk,key,cur_rk)
	
		// 				if (_rk == key || (_rk == 0 && cur_rk == key)) {
		// 					// tmp.attr("style", 'width:100px; background-color:#00FF00;');
				
	
		// 					$('#rkl_'+key).removeClass('badge-red');
		// 					$('#rkl_'+key).addClass('badge-success');
	
		// 					// console.log($('#rkl_'+_rk))
		// 					// console.log($('#as_'+element.id+'_'+element.date))
		// 					if (scroll == 1) {
		// 						$('#avail_container_'+element.id)[0].scrollIntoView({ block: 'center',  behavior: 'smooth' });
		// 						scroll = 0;
		// 					}
	
		// 					tmp.attr("style", 'width:100px;');
		// 					css = "btn-success";
							
		// 				} else {
	
		// 					$('#rkl_'+key).removeClass('badge-success');
		// 					$('#rkl_'+key).addClass('badge-red');
	
		// 					// tmp.attr("style", 'width:100px; background-color:#DE9F21;');
		// 					tmp.attr("style", 'width:100px;');
		// 					css = "btn-red ";
		// 				}
	
		// 				tmp.attr("class", 'btn '+ css + ' mt-1 m-0 py-2 a_' + element.date + '_' + element.hour + '_' + element.min + ' btn_book_lesson');
		// 				tmp.attr("href", '#');
		// 				tmp.attr("id", 'a_' + element.date + '_' + element.hour + '_' + element.min + '_' + element.id);
		// 				tmp.text(element.hour + ':' + element.min)
	
		// 				$('#as_'+element.id+'_'+element.date).append($("<div></div>").attr("class", "clearfix"));
		// 				$('#as_'+element.id+'_'+element.date).append(tmp)
	
		// 			}
		// 		}
	
		// 	}
		// }
	
		$(".btn_book_lesson").off("click")
		$(".btn_book_lesson").bind("click",handler_book_lesson);
		
		// booked.push({"day":date, "hour":hour, "min":min, "id":id});
	};
	show_booked_lesson();
	
	
	var handler_validate_tp = function(event) {	
		event.preventDefault();
		$.ajax({
			url: './api/launching/launching_post.cfc?method=switch_user',
			type: "POST",
			data: {t_id:<cfoutput>#SESSION.TP_ID#</cfoutput>},
			datatype : "html",
			success : function(result, statut){
				window.location.href="common_tp_details.cfm?t_id=<cfoutput>#SESSION.TP_ID#</cfoutput>&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>&tp_firstlesson=1";
			}
		})
	};
	$('#btn_validate_tp').bind("click",handler_validate_tp);
	
	<cfif SESSION.USER_ID eq 202 or SESSION.USER_ID eq "2072" or SESSION.USER_ID eq "2586">
		<!--- test here --->
		var handler_view_session = function(event) {	
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var s_id = idtemp[1];

			$('#window_item_xl').modal({keyboard: true});
			$('#modal_title_xl').text("<cfoutput>#obj_translater.get_translate('js_modal_title_session')#</cfoutput>");
			$('#modal_body_xl').load("modal_window_session_read.cfm?<cfoutput>t_id=#t_id#&u_id=#u_id#</cfoutput>&s_id="+s_id, function() {});

			$('#window_item_xl').on('hidden.bs.modal', function (e) {
				go_display()
			});

		};

		$('.btn_view_session_test').bind("click",handler_view_session);
	</cfif>


	function go_display() {
		$("#container_session").empty();

		$('#multi_header').load("./incl/incl_multi_header.cfm", {t_id: <cfoutput>#SESSION.TP_ID#</cfoutput>}, function() {
			$(".btn_book_lesson").off("click");
			$(".btn_book_lesson").bind("click",handler_book_lesson);
			$("#btn_validate_tp").off("click");
			$("#btn_validate_tp").bind("click",handler_validate_tp);
			<cfif SESSION.USER_ID eq 202 or SESSION.USER_ID eq "2072" or SESSION.USER_ID eq "2586">
				$(".btn_view_session_test").off("click");
				$(".btn_view_session_test").bind("click",handler_view_session);
			</cfif>
			$(".btn_del_session").off("click");
			$('.btn_del_session').bind("click",handler_del_session);
			$(".btn_display_session").off("click");
			$('.btn_display_session').bind("click",handler_display_session);
		});

		// $.ajax({
		// 	url: './api/tp/tp_get.cfc?method=oget_session_display',
		// 	type: "POST",
		// 	data: {t_id:<cfoutput>#SESSION.TP_ID#</cfoutput>},
		// 	datatype : "html",
		// 	success : function(result, statut){
		// 		// console.log(result);            
		// 		$("#container_session").append(result);
		// 		$(".btn_book_lesson").off("click");
		// 		$(".btn_book_lesson").bind("click",handler_book_lesson);
		// 	}
		// })
	}
	
	go_display();

	// function handle_css(_rk) {
	
	// 	if(booked[_rk]) {
	
	// 		$('#rkl_'+_rk).addClass('badge-warning text-white');
	// 		let tmp_date = new Date(booked[_rk].date);
	// 		let _month = tmp_date.getMonth();
	// 		let _day = tmp_date.getDate();
	// 		$('#rkl_text_'+_rk).text((_day <= 9 ? "0" + _day : _day) + "/" + (_month <= 9 ? "0" + _month : _month) + " " + booked[_rk].hour + ":" + booked[_rk].min);
	// 		$('.tthumb_'+_rk).remove();
	// 		$('#rkl_'+_rk).prepend('<img src="./assets/user/'+booked[_rk].id+'/photo.jpg" class="tthumb_'+_rk+'" width="30" title="" style="border-radius:50%; border: 2px solid #8A2128 !important; margin-right:3px" align="left">');
	// 		$('#btns_'+_rk).toggleClass('disabled');
	
	// 	} else {
	
	// 		$('#rkl_'+_rk).removeClass('badge-warning text-white');
	// 		$('#rkl_'+_rk).removeClass('badge-success');
	// 		$('#rkl_text_'+_rk).text("");
	// 		$('.tthumb_'+_rk).remove();
	// 		$('#rkl_'+_rk).prepend('<img src="./assets/img/unknown_male.png" class="tthumb_'+_rk+'" width="30" title="" style="border-radius:50%; border: 2px solid #8A2128 !important; margin-right:3px" align="left">');
	// 		$('#btns_'+_rk).toggleClass('disabled');
	// 		$('.btn_display_session').removeClass("selected_rk");
	// 		$('#rkl_'+_rk).toggleClass('selected_rk');
	
	// 	}
	
	// 	let progress_cur = Object.keys(booked).length;
	// 	let progress_percent = (progress_cur/<cfoutput>#progress_total#</cfoutput>)*100;
	// 	let progress_remain = <cfoutput>#progress_total#</cfoutput> - progress_cur;
	
	// 	// console.log("yoooooo", progress_percent);
	// 	$(".progress_completed_general_bar").css("width",progress_percent+"%");

	// 	$('.display_tp_progress').html(progress_remain+" cours restants");
	
	// 	if (progress_percent < 25) {
	// 		$("#btn_validate_tp").addClass('disabled');
	// 	} else {
	// 		$("#btn_validate_tp").removeClass('disabled');
	// 	}
	// }
	
	var handler_book_lesson = function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var date = idtemp[1];
		var hour = parseInt(idtemp[2]);
		var min = parseInt(idtemp[3]);
		var id = idtemp[4];	
		
		var book_rk = 0;
	
		if (!booked[cur_rk] && cur_rk != 0) {
			book_rk = cur_rk;
		}

		if (Object.keys(booked).length == 0) {
			book_rk = 1;
		}
	
		

	

		// console.log(date,hour,min,id)
	
		$.ajax({
			url : './api/tp/tp_post.cfc?method=speedbook_lesson',
			type : 'POST',	   
			<cfoutput>
			data : {t_id: #t_id#, u_id: #u_id#, p_id: id, date: date, hour: hour, min: min, s_dur: s_dur, rank: book_rk},
			</cfoutput>
			success : function(resultat, statut){
	
				// var obj_result = jQuery.parseJSON(result);
				// console.log(resultat);
	
				let _res = jQuery.parseJSON(resultat);
				console.log(_res);
				if (_res == 4) {
					document.location.href="common_tp_details.cfm?t_id=<cfoutput>#t_id#</cfoutput>&u_id=<cfoutput>#u_id#</cfoutput>&tp_book=1";	
				}
	
				// console.log(_res);
				// console.log(_res['rk']);
				// console.log(_res.id);
	
				if (booked[_res.rk]) {
					delete booked[_res.rk];
				} else {
					booked[_res.rk] = {
						date: date,
						hour: hour <= 9 ? "0" + hour : hour,
						min: min <= 9 ? "0" + min : min,
						id: id,
						l_id: _res.id
					}			
				}
	
				cur_rk = _res.rk;
	
				// handle_css(_res.rk);

				go_display();
	
				go_next(id, date, 0, 1)
			},
			error : function(resultat, statut, erreur){
				// alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
			}
		})
	
	};
	$('.btn_book_lesson').bind("click",handler_book_lesson);
	
	
	var handler_del_session = function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id").split("_");
		var _rk = idtemp[1];	
	
		if (booked[_rk]) {
			$.ajax({
			url : './api/tp/tp_post.cfc?method=speedbook_lesson',
			type : 'POST',	   
			<cfoutput>
			data : {t_id: #t_id#, u_id: #u_id#, p_id: booked[_rk].id, date: booked[_rk].date, hour: booked[_rk].hour, min: booked[_rk].min, s_dur: s_dur},
			</cfoutput>
			success : function(resultat, statut){
	
				let _res = jQuery.parseJSON(resultat);
	
				let tmpdate =  booked[_res.rk].date;
				let tmpid =  booked[_res.rk].id;
	
				delete booked[_res.rk];
	
				go_next(tmpid, tmpdate, 0, 1);
	
	
				// handle_css(_res.rk);
	
				go_display();
	
			},
			error : function(resultat, statut, erreur){
				// alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
			},
			complete : function(resultat, statut){}
		})
		}
		
	};
	$('.btn_del_session').bind("click",handler_del_session);
	
	var handler_display_session = function(event) {	
		event.preventDefault();
		var idtemp = $(this).attr("id").split("_");
		var _rk = idtemp[1];	
	
		cur_rk = _rk;
	
	
		$('.btn_display_session').removeClass("selected_rk");
		$('.badge-success').addClass('badge-red');
		$('.btn-success').addClass('btn-red');
	
	
		if (booked[_rk]) {
			// console.log("gonext")
			// console.log(booked[_rk])
			scroll = 1;
			go_next(booked[_rk].id, booked[_rk].date, 0, 1);
		} else {
			$('#rkl_'+_rk).toggleClass('selected_rk');
		}
		
	};
	$('.btn_display_session').bind("click",handler_display_session);
	
	$('#btn_update_day_interval').click(function(event) {
		event.preventDefault();
	
		interval = "";
		$.each($("input[name='day_interval']:checked"), function(){
			if (interval != "") interval += ","
			interval += $(this).val()
		});
	
		for (let index = 0; index < _id.length; index++) {
			let u_id = _id[index];
			
	
			$('#avail_container_'+u_id).empty();
			var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+u_id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
			$('#avail_container_'+u_id).append(loader);	
			$('#avail_container_'+u_id).load("./incl/incl_calendar_week_slot.cfm?user_id="+u_id+"&s_dur=<cfoutput>#s_dur#</cfoutput>"+"&interval="+interval, function() {
				<!----- KILL & REAFFECT ACTION ---->
				$(".btn_avail_prev").off("click");
				$(".btn_avail_prev").bind("click",handler_prev);
				$(".btn_avail_next").off("click");
				$(".btn_avail_next").bind("click",handler_next);
				$(".btn_display_avail").off("click")
				$(".btn_display_avail").bind("click",handler_display_more);
				$(".btn_jump_next_avail").off("click")
				$(".btn_jump_next_avail").bind("click",handler_jump_next);
				$(".btn_book_lesson").off("click")
				$(".btn_book_lesson").bind("click",handler_book_lesson);
	
				// show_booked_lesson(u_id)
				if (index == _id.length -1) {
					setTimeout(() => {  show_booked_lesson() }, 500);
				}
			});
	
		}
	
	
	});
	
	function go_next(id, date, add = 1, jump = 0) {
	
		<!--- full update overwrite single update --->
		for (let index = 0; index < _id.length; index++) {
			u_id = _id[index];
			console.log(u_id);
	
			$('#avail_container_'+u_id).empty();	
			var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+u_id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
			$('#avail_container_'+u_id).append(loader);	
			$('#avail_container_'+u_id).load("./incl/incl_calendar_week_slot.cfm?jump="+jump+"&date_ref="+date+"&date_add="+(7*add)+"&user_id="+u_id+"&s_dur=<cfoutput>#s_dur#</cfoutput>"+"&interval="+interval, function() {
				<!----- KILL & REAFFECT ACTION ---->
				$(".btn_avail_prev").off("click");
				$(".btn_avail_prev").bind("click",handler_prev);
				$(".btn_avail_next").off("click");
				$(".btn_avail_next").bind("click",handler_next);
				$(".btn_display_avail").off("click");
				$(".btn_display_avail").bind("click",handler_display_more);		
				$(".btn_jump_next_avail").off("click");
				$(".btn_jump_next_avail").bind("click",handler_jump_next);
				$(".btn_book_lesson").off("click");
				$(".btn_book_lesson").bind("click",handler_book_lesson);
	
				// show_booked_lesson(u_id)
				if (index == _id.length -1) {
					setTimeout(() => {  show_booked_lesson() }, 500);
				}
			});
		}
	
	}
	
	var handler_next = function get_next(){	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];	
		var date_ref = $('#date_ref_'+u_id).val();	
		go_next(u_id, date_ref)
	};
	$(".btn_avail_next").bind("click",handler_next);
	
	var handler_jump_next = function(event) {	
		event.preventDefault();
		var nametmp = $(this).attr("name");
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var date_ref = $('#date_ref_'+idtemp[1]).val();
		go_next(idtemp[1], date_ref, nametmp);
	};
	$(".btn_jump_next_avail").bind("click",handler_jump_next);
		
	var handler_display_more = function get_more(){	
	
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];
		
		$('.avail_display_add_'+u_id).collapse('toggle');			
	}
	$(".btn_display_avail").bind("click",handler_display_more);
	
	var handler_prev = function get_prev(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var u_id = idtemp[1];
		var date_ref = $('#date_ref_'+u_id).val();	
		<!--- alert(date_ref); --->
		for (let index = 0; index < _id.length; index++) {
			u_id = _id[index];
			
			$('#avail_container_'+u_id).empty();
			var loader = '<div class="d-flex justify-content-center"><div class="spinner-border text-info" role="status" id="loading_'+u_id+'" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>';
			$('#avail_container_'+u_id).append(loader);	
			$('#avail_container_'+u_id).load("./incl/incl_calendar_week_slot.cfm?date_ref="+date_ref+"&date_add=-7&user_id="+u_id+"&s_dur=<cfoutput>#s_dur#</cfoutput>"+"&interval="+interval, function() {
				<!----- KILL & REAFFECT ACTION ---->
				$(".btn_avail_prev").off("click");
				$(".btn_avail_prev").bind("click",handler_prev);
				$(".btn_avail_next").off("click");
				$(".btn_avail_next").bind("click",handler_next);
				$(".btn_display_avail").off("click")
				$(".btn_display_avail").bind("click",handler_display_more);
				$(".btn_jump_next_avail").off("click")
				$(".btn_jump_next_avail").bind("click",handler_jump_next);
				$(".btn_book_lesson").off("click")
				$(".btn_book_lesson").bind("click",handler_book_lesson);
	
				// show_booked_lesson(u_id)
				if (index == _id.length -1) {
					setTimeout(() => {  show_booked_lesson() }, 500);
				}
			});
		}
	
	}
	$(".btn_avail_prev").bind("click",handler_prev);
	
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
	
	$('#tbody_sortable').sortable({
		items: "tr:not(.unsortable)",
		update: function(e, ui) {
			let tmp = {};
			let l_list = "";
			let r_list = "";
	
			console.log(booked);
			$("#table_tp tr").each(function( index ) {
				var idtemp = this.getAttribute("id").split("_");
				if (booked[idtemp[1]]) {
					tmp[index + 1] = booked[idtemp[1]];
					// l_list.push(booked[idtemp[1]].l_id)
					if (l_list != "") l_list += ",";
					l_list += booked[idtemp[1]].l_id;
	
					if (r_list != "") r_list += ",";
					r_list += index + 1;
					// r_list.push(idtemp[1])
				} 
	
				if(cur_rk == idtemp[1]) cur_rk = index + 1;
	
				$("#rkl_textnb_" + idtemp[1]).html("<strong>" + index + "</strong>");
	
			});	
			// $(this).sortable('cancel');
	
			console.log(l_list, r_list)
	
			$.ajax({
				url : './api/tp/tp_post.cfc?method=speedbook_reorder_lesson',
				type : 'POST',
				<cfoutput>
				data : {t_id: #t_id#, l_list: l_list, r_list: r_list},
				</cfoutput>
				success : function(resultat, statut){
	
					// let _res = jQuery.parseJSON(resultat);
	
					console.log(resultat);
					// for (const key in booked) {
					// 	if (Object.hasOwnProperty.call(booked, key)) {
					// 		handle_css(key)
					// 	}
					// }
	
					booked = tmp;
					go_next(cur_rk, booked[cur_rk].date, 0, 1);
	
	
					// handle_css(cur_rk);
				},
				error : function(resultat, statut, erreur){
					// alert("<cfoutput>#obj_translater.get_translate('js_warning_issue')#</cfoutput>");
				}
			})
			
		}
	});
	
	$(".select_session_length").click(function() {
	
		$(".collapse_length").collapse("hide");
		$(".select_session_length").removeClass("active");
		$(this).addClass("active");
	
		session_length_min = $(this).val();
		if(session_length_min == 0)
		{
			$(".length_text").html("Durée variable");
			$("session_length_solo option[value='0']").prop('selected', true);
		}
		else
		{
			$(".length_text").html(session_length_min+"<cfoutput>#__shortminute#</cfoutput>");
			$(".session_length_solo option[value='"+session_length_min+"']").prop('selected', true);			
		}
	
		$("#collapse_length").collapse("hide");		
		$("#container_category").collapse("show");
		$("#collapse_category").collapse("show");
	
		progress_delta = parseInt((session_length_min/tp_duration_min)*100);
	
	
		});
			
		$('.btn_view_tp').click(function(event) {	
		event.preventDefault();
		document.location.href="common_tp_details.cfm?t_id=<cfoutput>#t_id#</cfoutput>&u_id=<cfoutput>#u_id#</cfoutput>&tp_book=1";	
		
		});
	});


	$( function() {
		$( "#sortable" ).sortable();
		$( "#sortable" ).disableSelection();
	} );
</script>