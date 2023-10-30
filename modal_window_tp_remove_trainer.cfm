<cfparam name="p_id">
<cfparam name="u_id">
<cfparam name="t_id">
<cfparam name="multi" default="0">

<cfif multi eq 1>
	<cfquery name="get_lesson_done" datasource="#SESSION.BDDSOURCE#">
		SELECT lesson_id FROM lms_lesson2 
		WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
		AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
		AND status_id IN (1,2,5,4)
	</cfquery>


	<cfif get_lesson_done.recordCount eq 0>
		<script>
		$.ajax({
			url: 'api/tp/tp_post.cfc?method=updt_tptrainer_delete',
			type: 'POST',
			data : {
				<cfoutput>
					u_id: #u_id#,
					p_id: #p_id#,
					t_id: #t_id#,
					interne: 'yes',
				</cfoutput>
				},
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});
		// $('#window_item_xl').modal('hide');
		</script>
	</cfif>
</cfif>
<!--- <cfdump var="#p_id#"> --->
<!--- <cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#",u_id="#SESSION.USER_ID#")> --->
<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT user_firstname FROM user WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
</cfquery>


<cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">
	SELECT lesson_id FROM lms_lesson2 
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#"> 
	AND planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	AND status_id = 1
</cfquery>

<cfset _trainer = get_trainer.user_firstname>

<cfset arr = ['_trainer']>
<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>

<!--- <cfdump var="#get_trainer#"> --->

<cfif get_trainer.recordcount neq 0 AND get_lesson.recordCount eq 0>

	
	<form id="form_orientation">
	<table class="table">
		<tr>
			<strong><cfoutput> #obj_translater.get_translate_complex(id_translate='modal_remove_trainer_title',argv="#argv#")# </cfoutput> </strong>
		</tr>
		<tr>
			<td width="90%">
				<label for="avail"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_avail')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="avail" name="avail">
			</td>
		</tr>
		<tr>
			<td width="90%">
				<label for="accent"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_accent')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="accent" name="accent">
			</td>
		</tr>	
		<tr>
			<td width="90%">
				<label for="method"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_method')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="method" name="method">
			</td>
		</tr>
		<tr>
			<td width="90%">
				<label for="style"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_style')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="style" name="style">
			</td>
		</tr>	
		<tr>
			<td width="90%">
				<label for="skills"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_skills')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="skills" name="skills">
			</td>
		</tr>	
		<tr>
			<td width="90%">
				<label for="trainer"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_trainer')#</cfoutput></label>
			</td>
			<td>
				<input type="checkbox" id="trainer" name="trainer">
			</td>
		</tr>	
		<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			<tr>
				<td>
					Office :
				</td>
			</tr>
			<tr>
				<td width="90%">
					<label for="trainer_left"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_trainer_left')#</cfoutput></label>
				</td>
				<td>
					<input type="checkbox" id="trainer_left" name="trainer_left">
				</td>
			</tr>	
			<tr>
				<td width="90%">
					<label for="not_booked"><cfoutput>#obj_translater.get_translate('modal_remove_trainer_not_booked')#</cfoutput></label>
				</td>
				<td>
					<input type="checkbox" id="not_booked" name="not_booked">
				</td>
			</tr>	
		</cfif>
		<!--- <tr>
			<td>
				<cfoutput>#obj_translater.get_translate('table_th_rating_techno')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_techno_tooltip')#</cfoutput>">?</span>
			</td>
			<td>
				<div class="starrr" id="star_techno"></div>
			</td>
			<td>
				<span class="choice_techno" style="display: none;">Note : <span class="choice"></span></span>
			</td>
		</tr> --->
		<tr>
			<td colspan="3">
				<cfoutput>#obj_translater.get_translate('table_th_rating_description')#</cfoutput>
				<textarea name="review_description" class="form-control" rows="3"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<cfoutput>
					<input type="hidden" id="p_id" name="p_id" value="#p_id#">
					<input type="hidden" id="u_id" name="u_id" value="#u_id#">
					<input type="hidden" id="t_id" name="t_id" value="#t_id#">
					<!--- <input type="hidden" id="umd" name="umd" value="#hash(SESSION.USER_ID)#"> --->
				<!--- <input type="hidden" id="note_techno" name="note_techno" value=""> --->
				<input type="submit" id="submit_review" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
				</cfoutput>
			</td>
		</tr>
		
	</table>
</form>
		

<script>
$(document).ready(function() {


	$('#submit_review').click(function(){
		event.preventDefault();

		if ($('input:checkbox').is(':checked')) {
				$.ajax({				  
					url: 'api/tp/tp_post.cfc?method=updt_tptrainer_delete',
					type: 'POST',
					data : $('#form_orientation').serialize(),
					datatype : "html", 
					success : function(result, status){ 
						console.log(result); 
						window.location.reload(true);
					}, 
					error : function(result, status, error){ 
						/*console.log(resultat);*/ 
					}	 
				});
		} else {
			alert("<cfoutput>#obj_translater.get_translate('alert_no_answer')#</cfoutput>");
			return false;
		}

		

	})

	$('[data-toggle="popover"]').popover({
	  trigger: 'focus',
	  html: true
	});
	$('[data-toggle="tooltip"]').tooltip({html: true});
		
	// $("#star_techno").starrr({
	// 	change: function(e, value){
	// 		if (value) {
	// 		  $("#note_techno").val(value);
	// 		  $(".choice_techno").show();
	// 		  $(".choice_techno .choice").text(value);
	// 		} else {
	// 		  $(".choice_techno").hide();
	// 		}
	// 	}
	// });

});

</script>
		
<cfelse>

	<cfset _lesson_nb = get_lesson.recordCount>

	<cfset argv = arrayMap(['_trainer','_lesson_nb'], function(item){return [item, evaluate(item)]})>

	<strong><cfoutput> #obj_translater.get_translate_complex(id_translate='modal_remove_trainer_error_lesson',argv="#argv#")# </cfoutput> </strong>

</cfif>
