<!--- <cfinclude template="./widget/wid_token_session_form.cfm"> --->

<cfparam name="ts_id">

<cfquery name="get_token_status" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
	SELECT `token_status_id`, `token_status_name`, `token_status_css` FROM `lms_list_token_status`
</cfquery>

<cfquery name="get_session" datasource="#SESSION.BDDSOURCE#">
	SELECT `account_id`, `token_session_start`, `token_session_end`, `token_session_name`, `token_session_method`,
	`token_session_certif_type`, `token_session_status`, `token_session_description`
	FROM lms_list_token_session 
	WHERE token_session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#ts_id#">
</cfquery>

<cfset token_session_name = get_session.token_session_name>
<cfset token_session_status = get_session.token_session_status>
<cfset token_session_start = LSDateFormat(get_session.token_session_start,'dd/mm/yyyy', 'fr')>
<cfset token_session_end = LSDateFormat(get_session.token_session_end,'dd/mm/yyyy', 'fr')>
<cfset token_session_method = get_session.token_session_method>
<cfset token_session_certif_type = get_session.token_session_certif_type>
<cfset token_session_description = get_session.token_session_description>
<cfset a_id = get_session.account_id>

<cfquery name="get_account" datasource="#SESSION.BDDSOURCE#">
    SELECT ag.group_name, a.account_name, a.account_id, a.group_id
    FROM account a 
    INNER JOIN account_group ag ON ag.group_id = a.group_id 
    WHERE a.type_id = 9
	AND a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
    GROUP BY a.account_id
    ORDER BY ag.group_name
</cfquery>

<cfquery name="get_token_left" datasource="#SESSION.BDDSOURCE#">
	SELECT llt.token_id, COUNT(*) as nb
	FROM lms_list_token llt
	INNER JOIN account a ON llt.group_id = a.group_id 
	WHERE a.account_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#a_id#">
	<cfif token_session_certif_type eq "BUSINESS">
AND llt.certif_id = 22
	<cfelse>
		AND llt.certif_id = 23
	</cfif>
	AND llt.user_id IS NULL
</cfquery>
<!--- <cfdump var="#get_session#"> --->

<form id="form_user_edit">
	<table class="table bg-white">
		<tr>
            <td colspan="2" bgcolor="#ECECEC">
                <strong><cfif ts_id eq 0>CREER<cfelse>MODIFIER</cfif> UN CANDIDAT</strong>
            </td>
		</tr>


        <tr>
            <td class="bg-light" width="20%">
                <label>Composantes</label>
                </td>
                <td>
                    <select class="form-control" disabled>
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
				<label>Methode de passage</label>
			</td>
			<td>
				<select name="token_session_method" class="form-control form-control-sm" disabled>
					<option value="DISTANCIEL" <cfif token_session_method eq "DISTANCIEL">selected</cfif>>DISTANCIEL</option>
					<option value="PRESENTIEL" <cfif token_session_method eq "PRESENTIEL">selected</cfif>>PRESENTIEL</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Type</label>
			</td>
			<td>
				<select name="token_session_certif_type" class="form-control form-control-sm">
					<option value="GENERAL" <cfif token_session_certif_type eq "GENERAL">selected</cfif>>GENERAL</option>
					<option value="BUSINESS" <cfif token_session_certif_type eq "BUSINESS">selected</cfif>>BUSINESS</option>
				</select>
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Email*</label>
			</td>
			<td>
				<input type="text" name="user_email" placeholder="Email" class="form-control form-control-sm" value="">
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Nom*</label>
			</td>
			<td>
				<input type="text" name="user_lastname" placeholder="Nom" class="form-control form-control-sm" value="">
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Prénom*</label>
			</td>
			<td>
				<input type="text" name="user_firstname" placeholder="Prénom" class="form-control form-control-sm" value="">
			</td>
		</tr>
		<!--- <tr>
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
		</tr> --->
		<tr>
			<td width="20%" class="bg-light">
				<label>Date de début</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="token_start" name="token_start" type="text" class="datepicker form-control" value="<cfoutput>#token_session_start#</cfoutput>" />
						<label for="token_start" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
					</div>
				</div>
			
			</td>
		</tr>
		<tr>
			<td width="20%" class="bg-light">
				<label>Date de fin</label>
			</td>
			<td>
				<div class="controls">
					<div class="input-group">
						<input id="token_end" name="token_end" type="text" class="datepicker form-control" value="<cfoutput>#token_session_end#</cfoutput>" />
						<label for="token_end" class="input-group-addon btn"><i class="far fa-calendar-alt"></i></label>
					</div>
				</div>					
			
			</td>
		</tr>
		<!--- <tr>
			<td width="20%" class="bg-light">
				<label>Description</label>
			</td>
			<td>
				<textarea name="token_session_description" class="form-control" rows="3"><cfoutput>#token_session_description#</cfoutput></textarea>
			</td>
		</tr> --->
		
	</table>

	<div align="center">
		Vous avez <cfoutput>#get_token_left.nb#</cfoutput> crédit(s) restant(s)
	</div>

    <div align="center">
        <cfoutput>
            <input type="hidden" id="ts_id" name="ts_id" value="#ts_id#">
            <input type="hidden" id="a_id" name="a_id" value="#a_id#">
            <input type="submit" id="submit_user_edit" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
		</cfoutput>
    </div>
</form>


<script>
$(document).ready(function() {

	$("#token_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}
	});
	
	$("#token_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	});

	$('#submit_user_edit').click(function(){
		event.preventDefault();
		console.log($('#form_user_edit').serialize()); 
		$.ajax({				  
			url: 'api/school/school_post.cfc?method=insert_token_user',
			type: 'POST',
			data : $('#form_user_edit').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				// window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

	})

});

</script>