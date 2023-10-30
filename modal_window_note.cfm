<cfif isdefined("l_id")>

	<cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#",u_id="#SESSION.USER_ID#")>

	<cfif get_lesson.recordcount neq "0">

		<form action="_updater_note.cfm" method="post">
		<table class="table">
			<tr>
				<td width="50%">
					<cfoutput>#obj_translater.get_translate('table_th_rating_support')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_support_tooltip')#</cfoutput>">?</span>
				</td>
				<td>
					<div class="starrr" id="star_support"></div>
				</td>
				<td>
					<span class="choice_support" style="display: none;">Note : <span class="choice"></span></span>
				</td>
			</tr>
			<tr>
				<td>
					<cfoutput>#obj_translater.get_translate('table_th_rating_teaching')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_teaching_tooltip')#</cfoutput>">?</span>
				</td>
				<td>
					<div class="starrr" id="star_teaching"></div>
				</td>
				<td>
					<span class="choice_teaching" style="display: none;">Note : <span class="choice"></span></span>
				</td>
			</tr>	
			<tr>
				<td>
					<cfoutput>#obj_translater.get_translate('table_th_rating_techno')#</cfoutput> <span style="cursor:pointer" class="badge badge-primary" role="button" data-toggle="tooltip" data-placement="top" title="<cfoutput>#obj_translater.get_translate('table_th_rating_techno_tooltip')#</cfoutput>">?</span>
				</td>
				<td>
					<div class="starrr" id="star_techno"></div>
				</td>
				<td>
					<span class="choice_techno" style="display: none;">Note : <span class="choice"></span></span>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<cfoutput>#obj_translater.get_translate('table_th_rating_description')#</cfoutput>
					<textarea name="note_description" class="form-control" rows="3"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="center">
					<cfoutput>
					<input type="hidden" id="l_id" name="l_id" value="#l_id#">
					<input type="hidden" id="note_teaching" name="note_teaching" value="">
					<input type="hidden" id="note_support" name="note_support" value="">
					<input type="hidden" id="note_techno" name="note_techno" value="">
					<input type="submit" class="btn btn-info" value="#obj_translater.get_translate('btn_note')#">
					</cfoutput>
				</td>
			</tr>
			
		</table>
		</form>
		

<script>
$(document).ready(function() {


	$('[data-toggle="popover"]').popover({
	  trigger: 'focus',
	  html: true
	});
	$('[data-toggle="tooltip"]').tooltip({html: true});
		
	$("#star_support").starrr({
		change: function(e, value){
			if (value) {
			  $("#note_support").val(value);
			  $(".choice_support").show();
			  $(".choice_support .choice").text(value);
			} else {
			  $(".choice_support").hide();
			}
		}
	});
	$("#star_teaching").starrr({
		change: function(e, value){
			if (value) {
			  $("#note_teaching").val(value);
			  $(".choice_teaching").show();
			  $(".choice_teaching .choice").text(value);
			} else {
			 $(".choice_teaching").hide();
			}
		}
	});
	$("#star_techno").starrr({
		change: function(e, value){
			if (value) {
			  $("#note_techno").val(value);
			  $(".choice_techno").show();
			  $(".choice_techno .choice").text(value);
			} else {
			  $(".choice_techno").hide();
			}
		}
	});

});

</script>
		
	</cfif>


</cfif>
