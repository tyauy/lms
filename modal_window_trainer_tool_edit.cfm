<cfsilent>

	<cfparam name="u_id" default="0">
	<cfparam name="group" default="0">
	<cfparam name="vc" default="0">
	<cfparam name="o_id" default="">

	<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
		<cfinvokeargument name="u_id" value="#u_id#">
	</cfinvoke>
	<!--- added webex for BdF and Krys learner demo --->
	<cfif get_user.account_id EQ 1003 or get_user.user_id EQ 11743>
		<cfquery name="get_techno" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM lms_list_techno WHERE techno_id NOT IN (2, 9, 11)
		</cfquery>
	<cfelse>
		<cfquery name="get_techno" datasource="#SESSION.BDDSOURCE#">
			SELECT * FROM lms_list_techno WHERE techno_id NOT IN (2, 10, 9, 11)
		</cfquery>
	</cfif>
</cfsilent>

<cfif isdefined("t_id")>

	<cfform action="updater_learner_tp.cfm">

    <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
	<cfset get_techno_list = obj_user_trainer_get.get_trainer_techno(user_id="#SESSION.USER_ID#")>

	<table class="table table-sm table-bordered">
		<tr>
			<td colspan="3" bgcolor="#ECECEC"><strong>Parcours</strong></td>
		</tr>
		
		
				<cfoutput query="get_techno_list">
					<cfif len(trim(get_techno_list.user_techno_link))> <!-- Check if the user_techno_link is not null or empty -->
						<tr>
							<td width="50%" class="bg-light">
								<label>
									<input type="radio" name="techno_id" class="techno_id" value="#techno_id#" 
									<cfif listfind(get_tp.tp_techno_id,techno_id)>checked</cfif>> <!-- Radio input for techno change -->
									#get_techno_list.techno_alias# <!-- Display techno.alias -->
									
								</label>
							</td>
						</tr>
					</cfif>
				</cfoutput>
	</table>
	<cfoutput>
	<input type="hidden" name="t_id" value="#t_id#">

	<input type="hidden" name="u_id" value="#u_id#">
	<input type="hidden" name="ins_tp_vc" value="#vc#">

	</cfoutput>
	<input type="hidden" name="updt_tp" value="1">
	<div align="center"><input type="submit" class="btn btn-success" value="Mettre &agrave; jour"></div>		
	</cfform>

</cfif>
