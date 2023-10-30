<cfif isdefined("start")>
	<cfset lesson_st = "#listgetat(start,1,'_')# #replace(listgetat(start,2,'_'),'-',':','ALL')#">
<cfelse>
	<cfset lesson_st = dateformat(now(), 'dd-mm-yyyy 08:00:00')>
</cfif>

<cfif isdefined("end")>
	<cfset lesson_en = "#listgetat(end,1,'_')# #replace(listgetat(end,2,'_'),'-',':','ALL')#">
<cfelse>
	<cfset lesson_en = dateformat(now(), 'dd-mm-yyyy 09:00:00')>
</cfif>	

<cfif SESSION.USER_PROFILE eq "trainer">
	<cfset p_id = SESSION.USER_ID>
</cfif>

<!---------------------- REMOVE AVAILABITITY BY CREATING A BLOCKER LESSON -------------->
<cfif avail_choice eq "remove">

	<cfform action="updater_avail.cfm">	
	<table class="table">					
		<tr>
			<td class="bg-light" width="20%">
				<label><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong> 
			</td>
			<td colspan="2">
			<cfoutput>#dateformat(lesson_st,"dd/mm/yyyy")#</cfoutput>
			</td>
		</tr>
		<tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_st,"HH:mm")#</cfoutput>
			</td>
		</tr>		
		<tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_end')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_en,"HH:mm")#</cfoutput>
			</td>
		</tr>
		<tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_reason')#</cfoutput></label>
			</td>
			<td colspan="2">
				<cfoutput>
				<input type="text" name="blocker_name" class="form-control" required="yes" placeholder="#obj_translater.get_translate('form_message_entitled')#">
				</cfoutput>
			</td>
		</tr>
	</table>
	<cfoutput>
	<input type="hidden" name="updt_avail" value="1">
	<input type="hidden" name="lesson_st" value="#lesson_st#">
	<input type="hidden" name="lesson_en" value="#lesson_en#">
	<input type="hidden" name="avail_choice" value="remove">
	<input type="hidden" name="p_id" value="#p_id#">
	<div align="center"><input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-outline-info"></div>
	</cfoutput>
	</cfform>

<cfelse>











<!---------------------- ADD AVAILABITITY BY POPULATING user_slots -------------->

	<cfform action="updater_avail.cfm">	
	<table class="table">					
		<tr>
			<td class="bg-light" width="20%">
				<label><cfoutput>#obj_translater.get_translate('table_th_date')#</cfoutput></strong> 
			</td>
			<td colspan="2">
			<cfoutput>#dateformat(lesson_st,"dd/mm/yyyy")#</cfoutput>
			</td>
		</tr>
		<tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_start')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_st,"HH:mm")#</cfoutput>
			</td>
		</tr>		
		<tr>
			<td class="bg-light">
				<label><cfoutput>#obj_translater.get_translate('table_th_end')#</cfoutput></label> 
			</td>
			<td colspan="2">
			<cfoutput>#timeformat(lesson_en,"HH:mm")#</cfoutput> <!---<cfset lesson_en = dateadd("n",-15,lesson_en)> <cfoutput>#lesson_en#</cfoutput>--->
			</td>
		</tr>
	</table>
		
	<cfoutput>
	<input type="hidden" name="updt_avail" value="1">
	<input type="hidden" name="lesson_st" value="#lesson_st#">
	<input type="hidden" name="lesson_en" value="#lesson_en#">
	<input type="hidden" name="avail_choice" value="add">
	<input type="hidden" name="p_id" value="#p_id#">
	<div align="center"><input type="submit" value="#obj_translater.get_translate('btn_save')#" class="btn btn-outline-info"></div>
	</cfoutput>
	</cfform>


</cfif>


