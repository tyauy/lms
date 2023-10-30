<cfform action="updater_upload.cfm" enctype="multipart/form-data" method="POST" id="form_ln">
<table class="table table-sm table-bordered">

	<cfdirectory directory="#SESSION.BO_ROOT#/assets/attachment/" name="dirQuery" action="LIST">
	
	<cfset counter = 0>
	<cfoutput>
	<cfloop query="dirQuery">
	<cfset counter ++>
	<cfif findnocase("#l_id#_",#name#)>
	<tr>
		<th class="bg-light" width="30%">
		<label>Attach #counter#</label>
		</th>
		<td colspan="2">
		<a href="/assets/attachment/#name#" target="_blank">#name#</a>
		<a href="updater_upload.cfm?lesson_delete=#name#&l_id=#l_id#" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a>
		</td>
	</tr>
	</cfif>
	
	</cfloop>
	</cfoutput>

</table>

<table class="table table-sm table-bordered">
	<tr>
		<th class="bg-light" width="30%">
		<label>Pi&egrave;ce jointe</label><br><small>pdf / doc / docx / jpg / jpeg / png / txt</small>
		</th>
		<td colspan="2">
		<input type="file" id="lesson_attach" class="form-control" name="lesson_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc">
		</td>
	</tr>
</table>


<div align="center">
<br>
<label><input type="checkbox" name="finalise_lesson" id="finalise_lesson" class="finalise_lesson" value="1" <cfif counter eq "0">disabled</cfif>><cfoutput>#obj_translater.get_translate('modal_ln_finalize')#</cfoutput></label>		
</div>

<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
<input type="hidden" name="t_id" value="<cfoutput>#t_id#</cfoutput>">
<input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>">
</cfif>

<input type="hidden" name="add_ln" value="1">
<input type="hidden" name="l_id" value="<cfoutput>#l_id#</cfoutput>">

<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>

</cfform>

<script>
$("#lesson_attach").change(function() {

	if($("#lesson_attach").val() != "") {
		$("#finalise_lesson").removeAttr("disabled");
	}
	else {
		$("#finalise_lesson").attr("disabled", true);
	}

});
</script>
