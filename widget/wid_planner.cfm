<cfif isdefined("planner_view")>
<cfif planner_view eq "pdf_version">

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

<cfelseif planner_view eq "view_toggle_vertical">

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
	<!--- <div class="table-responsive"> --->
	<table class="table table-sm table-borderless bg-white" style="vertical-align:top !important">
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
	<!--- </div> --->
</cfif>
</cfif>