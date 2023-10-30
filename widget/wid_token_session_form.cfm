<cfparam name="ts_id" default="0">
<cfparam name="a_id" default="">

<cfif a_id eq "" AND isDefined("SESSION.USER_ACCOUNT_RIGHT_ID")>
	<cfset a_id = SESSION.USER_ACCOUNT_RIGHT_ID>
</cfif>

<cfquery name="get_token_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT `token_status_id`, `token_status_name`, `token_status_css` FROM `lms_list_token_status`
</cfquery>

<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
	SELECT `account_id`, `token_session_start`, `token_session_end`, `token_session_name`, `token_session_method`,
	`token_session_certif_type`, `token_session_status`, `token_session_description`
	FROM lms_list_token_session 
	WHERE token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
</cfquery>


<cfif get_session.recordcount neq "0">
	
	<cfset token_session_name = get_session.token_session_name>
	<cfset token_session_status = get_session.token_session_status>
	<cfset token_session_start = LSDateFormat(get_session.token_session_start,'dd/mm/yyyy', 'fr')>
	<cfset token_session_end = LSDateFormat(get_session.token_session_end,'dd/mm/yyyy', 'fr')>
	<cfset token_session_method = get_session.token_session_method>
	<cfset token_session_certif_type = get_session.token_session_certif_type>
	<cfset token_session_description = get_session.token_session_description>
    <cfset a_id = get_session.account_id>

<cfelse>

	<cfset token_session_name = "">
	<cfset token_session_status = "WAITING">
	<cfset token_session_start = LSDateFormat(now(),'dd/mm/yyyy', 'fr')>
	<cfset token_session_end = LSDateFormat(dateAdd('m', "3", now()),'dd/mm/yyyy', 'fr')>
	<cfset token_session_method = "DISTANCIEL">
	<cfset token_session_certif_type = "GENERAL">
	<cfset token_session_description = "">
	
</cfif>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
    SELECT ag.group_name, a.account_name, a.account_id, a.group_id
    FROM account a 
    INNER JOIN account_group ag ON ag.group_id = a.group_id 
    WHERE a.type_id = 9
	<cfif a_id neq "">
		AND a.account_id IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#a_id#" list="yes">)
	</cfif>
    GROUP BY a.account_id
    ORDER BY ag.group_name
</cfquery>

<!--- <cfdump var="#get_session#"> --->


<form id="form_session_edit">
	<table class="table bg-white">
		<tr>
            <td colspan="2" bgcolor="#ECECEC">
                <strong><cfif ts_id eq 0>CREER<cfelse>MODIFIER</cfif> UNE SESSION</strong>
            </td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Nom*</label>
			</td>
			<td>
				<input type="text" name="token_session_name" placeholder="Nom" class="form-control form-control-sm" value="<cfoutput>#token_session_name#</cfoutput>">
			</td>
		</tr>
        <tr>
            <td class="bg-light" width="20%">
                <label>Composantes*</label>
                </td>
                <td>
                    <select class="form-control" name="a_id">
                        <cfoutput query="get_account">
                            <option value="#account_id#">
                                #account_name#
                            </option>
                        </cfoutput>
                    </select>
                </td>
        </tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Status*</label>
			</td>
			<td>
				<select name="token_session_status" class="form-control form-control-sm">
					<option value="WAITING" <cfif token_session_status eq "WAITING">selected</cfif>>WAITING</option>
					<option value="SENT" <cfif token_session_status eq "SENT">selected</cfif>>SENT</option>
					<option value="CLOSE" <cfif token_session_status eq "CLOSE">selected</cfif>>CLOSE</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Date de début*</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="token_session_start" name="token_session_start" type="text" class="datepicker form-control" value="<cfoutput>#token_session_start#</cfoutput>" />
						<label for="token_session_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
					</div>
				</div>					
			
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Date de fin*</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="token_session_end" name="token_session_end" type="text" class="datepicker form-control" value="<cfoutput>#token_session_end#</cfoutput>" />
						<label for="token_session_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
					</div>
				</div>					
			
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Methode de passage*</label>
			</td>
			<td>
				<!---------------- IF SESSION EDIT, DONT ALLOW TYPE CHANGE ------------>
				<select name="token_session_method" class="form-control form-control-sm">
					<cfif get_session.recordcount neq "0">
						<cfif token_session_method eq "DISTANCIEL">
							<option value="DISTANCIEL" selected>DISTANCIEL</option>
						<cfelse>
							<option value="PRESENTIEL" selected>PRESENTIEL</option>
						</cfif>
					<cfelse>
						<option value="DISTANCIEL" <cfif token_session_method eq "DISTANCIEL">selected</cfif>>DISTANCIEL</option>
						<option value="PRESENTIEL" <cfif token_session_method eq "PRESENTIEL">selected</cfif>>PRESENTIEL</option>
					</cfif>
				</select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Type*</label>
			</td>
			<td>
				<!---------------- IF SESSION EDIT, DONT ALLOW TYPE CHANGE ------------>
				<select name="token_session_certif_type" class="form-control form-control-sm">
					<cfif get_session.recordcount neq "0">
						<cfif token_session_certif_type eq "GENERAL">
							<option value="GENERAL" selected>GENERAL</option>
						<cfelse>
							<option value="BUSINESS" selected>BUSINESS</option>
						</cfif>
					<cfelse>
						<option value="GENERAL" <cfif token_session_certif_type eq "GENERAL">selected</cfif>>GENERAL</option>
						<option value="BUSINESS" <cfif token_session_certif_type eq "BUSINESS">selected</cfif>>BUSINESS</option>
					</cfif>
				</select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Description</label>
			</td>
			<td>
				<textarea name="token_session_description" class="form-control" rows="3"><cfoutput>#token_session_description#</cfoutput></textarea>
			</td>
		</tr>
		
	</table>

    <div align="center">
        <cfoutput>
            <input type="hidden" id="ts_id" name="ts_id" value="#ts_id#">
            <input type="submit" id="submit_session_edit" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
</cfoutput>
    </div>
</form>