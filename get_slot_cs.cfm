<cfif isdefined("p_id") AND isdefined("date_select") AND isdefined("l_dur")>

<cfset date_display = dateformat(date_select,'dd/mm/yyyy')>
<cfset date_link = dateformat(date_select,'yyyy-mm-dd')>

<cfset get_planner = obj_query.oget_planner(p_id)>

<div class="row justify-content-center">		
	
	<cfinvoke component="api/users/user_trainer_get" method="get_calendar_dispo_cs" returnvariable="available_date_list">
		<cfinvokeargument name="date_link" value="#date_link#">
		<cfinvokeargument name="user_id" value="#p_id#">
		<cfinvokeargument name="s_dur" value="#l_dur#">
	</cfinvoke>

	<cfset list_slot_clean = "">

	<!---- GET BOOKED LESSON / IGNORE CANCELLED--->
	<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT 
	l.lesson_id, l.lesson_start, l.lesson_end,
	ls.status_name_#SESSION.LANG_CODE# as status_name, ls.status_css,
	ul.user_firstname, ul.user_name
	FROM lms_lesson2 l
	INNER JOIN user ul ON ul.user_id = l.user_id
	INNER JOIN user ut ON ut.user_id = l.planner_id
	INNER JOIN lms_lesson_status ls ON ls.status_id = l.status_id
	WHERE l.planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	
	AND DATE_FORMAT(lesson_start,'%Y-%m-%d') = '#date_link#' 
	AND (l.status_id <> "3")
	<!---AND s.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">--->
	ORDER BY lesson_start ASC
	</cfquery>



	<div class="col-md-12">

		<div class="p-2 bg-light border">
		
			<div align="center"><cfoutput>#obj_lms.get_thumb(user_id="#p_id#",size="40")# #get_planner.user_firstname#</cfoutput></div>
				
				<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
				<cfif get_lesson.recordcount neq "0">
		
					<h6 class="text-warning mt-3"><cfoutput>#obj_translater.get_translate('modal_planning_title')#</cfoutput></h6>
					<div class="border-bottom border-warning mb-1"></div>
								
					<cfoutput query="get_lesson">
					
					
						
							<a href="##" id="l_#lesson_id#" class="btn btn-sm btn-#status_css# btn_view_lesson my-1" style="width:100px" data-toggle="tooltip" data-html="true" title="#status_name#">#TimeFormat(lesson_start,'HH:mm')#</a>SET UP [ #get_lesson.user_firstname# #get_lesson.user_name# ]
						
						<div class="clearfix"></div>
							
					</cfoutput>
					
				</cfif>
				</cfif>
			
				<h6 class="text-info mt-3"><cfoutput>#obj_translater.get_translate('modal_avail_title')#</cfoutput></h6>
					<div class="border-bottom border-info mb-1"></div>
					
					<cfif Arraylen(available_date_list) neq "0">
					<cfoutput>
						<cfset counter = 0>

						<cfloop array="#available_date_list#" index="temp"> 


							<cfset counter++>
							<a href="##" id="a_#dateformat(temp,'yyyy-mm-dd')#_#timeformat(temp,'HH-mm')#_#get_planner.user_id#" class="btn btn-sm <cfif temp gt dateadd('h',7,now())>btn-outline-info<cfelse>btn-outline-warning</cfif> btn_book_lesson my-1" style="width:100px">#timeformat(temp,'HH:mm')#</a>
						</cfloop>

						<cfif counter eq "0">
						
							<div class="alert alert-secondary mt-3" role="alert">
								<div class="text-center"><em>#obj_translater.get_translate('alert_no_avail')#</em></div>
							</div>
							
						</cfif>
					</cfoutput>
					<cfelse>

					<div class="alert alert-secondary mt-3" role="alert">
						<div class="text-center"><em><cfoutput>#obj_translater.get_translate('alert_no_avail')#</cfoutput></em></div>
					</div>
									
					</cfif>				
		</div>
	</div>		
						
						
	
		
</div>

			
<script>
$(document).ready(function() {
	
	$('.btn_book_lesson').click(function(event) {		
		event.preventDefault();		
		var temp = $(this).attr("id");
		var res = temp.split("_");
		var lesson_date_start = res[1];
		var lesson_time_start = res[2];
		var planner_id = res[3];
		
		if(confirm("<cfoutput>#obj_translater.get_translate('js_book_confirm')#</cfoutput>"))
		{
			// var urlgo = <cfoutput>"updater_lesson.cfm?cs_event=1&u_id=#u_id#&p_id="+planner_id+"&l_dur=#l_dur#&l_date_start="+lesson_date_start+"&l_time_start="+lesson_time_start</cfoutput>;
			// document.location.href=urlgo;

			$.ajax({
				url : 'api/lesson/lesson_post.cfc?method=insert_lesson_cs',
				type : 'POST',
				context: this,
				data : {
					u_id:<cfoutput>#u_id#</cfoutput>,
					p_id:planner_id,
					l_dur:<cfoutput>#l_dur#</cfoutput>,
					l_date_start:lesson_date_start,
					l_time_start:lesson_time_start,
				},				
				success : function(result, status) {
					if (result == 1) {
						alert("<cfoutput>#encodeForJavaScript(trim(obj_translater.get_translate('js_book_ok')))#</cfoutput>");
						$('#window_item_ctc').modal('hide');
					} else {
						// on error alert
						alert("<cfoutput>#encodeForJavaScript(trim(obj_translater.get_translate('js_book_fail')))#</cfoutput>");
						$('#window_item_ctc').modal('hide');
					}
				}
			});	
		}
		
	});
	
});
</script>


</cfif>