<cfset __day = ucase(obj_translater.get_translate('day'))>

<cfif planner_view eq "edit">


<cfoutput>
	
<!---<h3>S&eacute;lectionner Trainer</h3>
<hr>
	
	<cfselect query="get_trainer" display="trainer_name" value="user_id" name="u_id" class="form-control"></cfselect>
	
--->



<cfif not findnocase("modal_window_trainer2",CGI.SCRIPT_NAME)><h6>Param&eacute;trer dispo</h6></cfif>

	<table class="table table_condensed">
		<tr bgcolor="##ECECEC">
			<td><cfoutput>#__day#</cfoutput></td>
			<td>AM</td>
			<td>PM</td>
		</tr>
		<cfloop list="#SESSION.DAYWEEK_EN_MIN#" index="cor">	
		<tr <cfif evaluate("get_workinghour.day_#cor#") neq "1">class="bg-disabled"</cfif>>
			<td id="colday_#cor#">
				<label>
				<input type="checkbox" class="select_day" name="#cor#" id="#cor#" <cfif evaluate("get_workinghour.day_#cor#") eq "1">checked</cfif>>
				#ucase(cor)#
				</label>
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
				<input type="checkbox" class="select_am" name="select_am_#cor#" id="select_am_#cor#" style="float:left;" <cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">checked<cfelse>disabled</cfif>>
				<label style="float:left;">#obj_translater.get_translate('short_from')#&nbsp;</label>
				<select name="day_#cor#_start_am" id="day_#cor#_start_am" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm') eq hour>selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>				
				<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>
				<select name="day_#cor#_end_am" id="day_#cor#_end_am" <cfif evaluate("get_workinghour.day_#cor#_end_am") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm') eq hour>selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
				<input type="checkbox" class="select_pm" name="select_pm_#cor#" id="select_pm_#cor#" style="float:left;" <cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">checked<cfelse>disabled</cfif>>
				<label style="float:left;">#obj_translater.get_translate('short_from')#&nbsp;</label>
				<select name="day_#cor#_start_pm" id="day_#cor#_start_pm" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm') eq hour>selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>				
				<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>
				<select name="day_#cor#_end_pm" id="day_#cor#_end_pm" <cfif evaluate("get_workinghour.day_#cor#_end_pm") eq "">disabled</cfif> class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm') eq hour>selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>
			</td>
		</tr>
		</cfloop>
		<!---<cfloop from="1" to="7" index="day">		
		<tr class="bg-disabled">
			<td id="colday_#day#"><input type="checkbox" class="select_day" name="#day#" id="#day#">
				#listgetat(SESSION.DAYWEEK_EN,day)#
			</td>
			<td id="colam_#day#">
				<input type="checkbox" disabled class="select_am" name="select_am_#day#" id="select_am_#day#" style="float:left;">
				<label style="float:left;">#obj_translater.get_translate('short_from')#&nbsp;</label>
				<select name="start_am_#day#" id="start_am_#day#" disabled class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif hour eq "8:00">selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>				
				<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>
				<select name="end_am_#day#" id="end_am_#day#" disabled class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif hour eq "12:00">selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>
			</td>
			<td id="colpm_#day#">
				<input type="checkbox" disabled class="select_pm" name="select_pm_#day#" id="select_pm_#day#" style="float:left;">
				<label style="float:left;">#obj_translater.get_translate('short_from')#&nbsp;</label>			
				<select name="start_pm_#day#" id="start_pm_#day#" disabled class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif hour eq "14:00">selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>				
				<label style="float:left;">&nbsp;#obj_translater.get_translate('short_to')#&nbsp;</label>		
				<select name="end_pm_#day#" id="end_pm_#day#" disabled class="form-control" style="float:left; width:120px">
				<cfloop list="#SESSION.LIST_HOURS#" index="hour" delimiters=",">
				<option value="#hour#" <cfif hour eq "18:00">selected="selected"</cfif>>#hour#</option>
				</cfloop>
				</select>
			</td>
		</tr>		
		</cfloop>--->
	</table>
	<!---
<h6>Activer pause automatique - 15min</h6>
<input type="radio" name="pause" id="pause" value="1"> Oui
<input type="radio" name="pause" id="pause" value="0"> Non
<br><br>
	--->
	<!---
	<input type="radio" name="choice" id="choice_1"><cfoutput>#obj_translater.get_translate('panel_planner_overwrite')#</cfoutput>
	<br>
	<input type="radio" name="choice" id="choice_1" checked="checked"><cfoutput>#obj_translater.get_translate('panel_planner_complete')#</cfoutput>
	<br>--->


	


	</cfoutput>
	

<cfelseif planner_view eq "pdf_version">

	<cfset list_week = ValueArray(get_trainer_businesshour,"week_day")>
	<table bgcolor="#F8F9FA" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
		<cfloop list="1,2,3,4,5,6,0" index="week_go">
			<cfif arrayFind(list_week,week_go)>
				<tr bgcolor="#FFF">
					<td><cfoutput>#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</cfoutput></td>
					<td>
						<cfoutput query="get_trainer_businesshour">
						<cfif week_go eq week_day>
							#timeformat(start_time,'HH:nn')# - #timeformat(end_time,'HH:nn')# &nbsp;&nbsp;&nbsp;
						</cfif>
						</cfoutput>
					</td>
				</tr>
			<cfelse>
				<tr bgcolor="#F8F9FA">
					<td><cfoutput>#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</cfoutput></td>
					<td>-</td>
				</tr>
			</cfif>
		</cfloop>
	</table>


<!--- <table bgcolor="#F8F9FA" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
	<tr bgcolor="#F8F9FA">
		<th><label><cfoutput>#__day#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('am')#</cfoutput></label></th>
		<th><label><cfoutput>#obj_translater.get_translate('pm')#</cfoutput></label></th>
	</tr>
	<cfoutput>
		<cfset listref = evaluate("SESSION.DAYWEEK_EN_MIN")>
		<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN")>
		<cfset counter = "0">
		<cfloop list="#listref#" index="cor">	
		<cfset counter ++>
		<tr <cfif evaluate("get_workinghour.day_#cor#") neq "1">bgcolor="##F8F9FA"<cfelse>bgcolor="##FFF"</cfif>>
			<td id="colday_#cor#">
				#ucase(listgetat(listgo,counter))#
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">bgcolor="##F8F9FA"<cfelse>bgcolor="##FFF"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm')# - 
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm')#
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">bgcolor="##F8F9FA"<cfelse>bgcolor="##FFF"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm')# - 	
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm')#
			</td>
		</tr>
		</cfloop>
		</cfoutput>
</table> --->

<!--- <cfelseif planner_view eq "view_toggle">

	<cfif isdefined("p_id")>
		<cfset user_id = p_id>
	</cfif>
	
		<table id="<cfoutput>avail_#user_id#</cfoutput>" class="table table-sm collapse">

		<cfoutput>
		<cfset listref = evaluate("SESSION.DAYWEEK_EN_MIN")>
		<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN")>
		<cfset counter = "0">
		<cfloop list="#listref#" index="cor">	
		<cfset counter ++>
		<tr <cfif evaluate("get_workinghour.day_#cor#") neq "1">class="bg-disabled"</cfif>>
			<td id="colday_#cor#">
				#ucase(listgetat(listgo,counter))#
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm')#
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm')#
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm')#	
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm')#
			</td>
		</tr>
		</cfloop>
		</cfoutput>
		</table> --->
<cfelseif planner_view eq "view_toggle_vertical">
	<!--- <cfif isdefined("p_id")>
		<cfset user_id = p_id>
	</cfif>
	
	<cfset total_h_week = "0">
	<cfset listref = evaluate("SESSION.DAYWEEK_EN_MIN")>
	<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN")>
		
		<cfoutput>
		<table class="table table-sm bg-white m-0 border">

		<tr align="center">							
			<cfloop list="#SESSION.DAYWEEK_EN_MIN#" index="cor">	
				<cfif evaluate("get_workinghour.day_#cor#_timediff_am") neq "">
				<cfset total_h_week = total_h_week+hour(evaluate("get_workinghour.day_#cor#_timediff_am"))>
				</cfif>
				<cfif evaluate("get_workinghour.day_#cor#_timediff_pm") neq "">
				<cfset total_h_week = total_h_week+hour(evaluate("get_workinghour.day_#cor#_timediff_pm"))>
				</cfif>
				<cfif evaluate("get_workinghour.day_#cor#") neq "">
				<td width="12%" class="bg-success text-white"><small><strong>#cor# <cfif isdefined("test")>#test#</cfif></strong></small></td>							
				<cfelse>
				<td width="12%" class="bg-light text-dark"><small>#cor#</small></td>
				</cfif>
			</cfloop>		
		</tr>
		
		
		<cfset counter = "0">
		
		<tr class="collapse"id="avail_#user_id#">
			<cfloop list="#listref#" index="cor">	
			<cfset counter ++>
			<td width="12%" id="colday_#cor#"><small><strong>
			
			<cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm')#
			<cfelse>
				-
			</cfif>
			<br>
			<cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm')#
			<cfelse>
				-
			</cfif>
			<br>
			<cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm')#	
			<cfelse>
				-
			</cfif>
			<br>
			<cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm')#
			<cfelse>
				-
			</cfif>
			</strong></small></td>
			</cfloop>
			</tr>		
		</table>
		
					
		</cfoutput> --->

		<cfset list_week = ValueArray(get_trainer_businesshour,"week_day")>
		<table class="table table-sm bg-white m-0 border">
			<tr>
				<cfoutput>
				<cfloop list="1,2,3,4,5,6,0" index="week_go">
					<cfif arrayFind(list_week,week_go)>
						<td>
							<span class="badge badge-success">#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</span>
						</td>
					<cfelse>
						<td>#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</td>
					</cfif>
				</cfloop>
				</cfoutput>
			</tr>
		</table>
		
		
<cfelseif planner_view eq "view_toggle_vertical_read" OR planner_view eq "view_toggle_vertical_read_tiny">
	
	
	<cfset list_week = ValueArray(get_trainer_businesshour,"week_day")>
	<table class="table table-borderless bg-white" style="vertical-align:top !important">
		<tr>
			<cfloop list="1,2,3,4,5,6,0" index="week_go">
				<cfif arrayFind(list_week,week_go)>
					<td style="vertical-align:top !important">
						<span class="badge badge-info m-2">
							<cfoutput>#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</cfoutput>
						</span>
							
						<cfoutput query="get_trainer_businesshour">
							<cfif week_go eq week_day>
								#timeformat(start_time,'HH:nn')# <br> #timeformat(end_time,'HH:nn')# <br><br>
							</cfif>
						</cfoutput>
						
					</td>
				<cfelse>
					<td style="vertical-align:top !important">
						<span class="badge m-2 border">
							<cfoutput>#listgetat(evaluate("SESSION.DAYWEEK_ORDERED_#SESSION.LANG_CODE#"),week_go+1)#</cfoutput>
						</span>
					</td>
				</cfif>
			</cfloop>
		</tr>
	</table>
		
		
	<!--- <cfif isdefined("p_id")>
		<cfset user_id = p_id>
	</cfif>
	
	<cfset total_h_week = "0">
	<cfset listref = evaluate("SESSION.DAYWEEK_EN_MIN")>
	<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN")>
		
		<cfoutput>
		<table class="table <cfif planner_view eq "view_toggle_vertical_read_tiny">table-sm</cfif> table-borderless bg-white m-0 h-100">

		<tr align="center">	
			<cfset counter = "0">
			<cfloop list="#SESSION.DAYWEEK_EN_MIN#" index="cor">	
			<cfset counter ++>
				<cfif evaluate("get_workinghour.day_#cor#_timediff_am") neq "">
				<cfset total_h_week = total_h_week+hour(evaluate("get_workinghour.day_#cor#_timediff_am"))>
				</cfif>
				<cfif evaluate("get_workinghour.day_#cor#_timediff_pm") neq "">
				<cfset total_h_week = total_h_week+hour(evaluate("get_workinghour.day_#cor#_timediff_pm"))>
				</cfif>
				<cfif evaluate("get_workinghour.day_#cor#") neq "">
				<td width="12%"><h5 style="font-size:18px"><span class="badge badge-info">#ucase(listgetat(listgo,counter))#</span></h5></td>							
				<cfelse>
				<td width="12%"><h5 style="font-size:18px"><span class="badge bg-light border text-muted">#ucase(listgetat(listgo,counter))#</span></h5></td>
				</cfif>
			</cfloop>	
		</tr>
		
		
		<cfset counter = "0">
		
		<tr id="avail_#user_id#">
			<cfloop list="#listref#" index="cor">	
			<cfset counter ++>
			<td width="12%" id="colday_#cor#" class="text-center align-top" style="line-height:30px !important">
			<cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm')#
			<cfelse>
				<!--- <br>&nbsp; --->
			</cfif>
			
			<cfif evaluate("get_workinghour.day_#cor#_start_am") neq "">
				<br>#TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm')#
			<cfelse>
				<br>&nbsp;
			</cfif>
			
			<cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">
				<br><br>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm')#	
			<cfelse>
				<!--- <br><br> - --->
			</cfif>
			
			<cfif evaluate("get_workinghour.day_#cor#_start_pm") neq "">
				<br>#TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm')#
			<cfelse>
				<!--- <br> - --->
			</cfif>
			</td>
			</cfloop>
			</tr>		
		</table>
		
					
		</cfoutput> --->
		
<cfelseif planner_view eq "read">
		
		<table class="table table-sm table_bordered">
		<tr bgcolor="#F3F3F3">
			<th><cfoutput>#__day#</cfoutput></th>
			<th colspan="2">AM</th>
			<th colspan="2">PM</th>
		</tr>
		<!---<tr bgcolor="#F3F3F3">
			<td></td>
			<td>DE</td>
			<td>A</td>
			<td>DE</td>
			<td>A</td>
		</tr>--->
		<cfoutput>
		<cfset listref = evaluate("SESSION.DAYWEEK_EN_MIN")>
		<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#_MIN")>
		<cfset counter = "0">
		<cfloop list="#listref#" index="cor">	
		<cfset counter ++>
		<tr <cfif evaluate("get_workinghour.day_#cor#") neq "1">class="bg-disabled"</cfif>>
			<td id="colday_#cor#">
				#ucase(listgetat(listgo,counter))#
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_am"),'HH:mm')#
			</td>
			<td id="colam_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_am") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_am"),'HH:mm')#
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_start_pm"),'HH:mm')#	
			</td>
			<td id="colpm_#cor#" <cfif evaluate("get_workinghour.day_#cor#_start_pm") eq "">class="bg-disabled"</cfif>>
				#TimeFormat(evaluate("get_workinghour.day_#cor#_end_pm"),'HH:mm')#
			</td>
		</tr>
		</cfloop>
		</cfoutput>
	</table>
	
</cfif>
	