<cfparam name="token_list">
	

	<form id="form_token_edit">
	<table class="table">

		<tr>
			<th>
				Account
			</th>
			<th>
				Session
			</th>
			<th>
				Name
			</th>
			<th>
				Firstname
			</th>
			<th>
				Token
			</th>
			<th>
				Certif
			</th>
			<th>
				New Token
			</th>
		</tr>
		<cfloop list="#token_list#" item="token_id">


			<cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
				SELECT lt.user_id, lt.token_code, lt.token_description, lt.token_status_id,
				lc.certif_name,
				lts.token_session_method, lts.token_session_certif_type, lts.token_session_name,
				lts.token_session_start, lts.token_session_end
				FROM lms_list_token lt
				INNER JOIN lms_list_certification lc ON lc.certif_id = lt.certif_id
				INNER JOIN lms_list_token_session lts ON lt.token_session_id = lts.token_session_id
				WHERE lt.token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#token_id#">
			</cfquery>

			<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
				<cfinvokeargument name="u_id" value="#get_token.user_id#">
			</cfinvoke>
		
			<!--- <cfdump var="#get_token#"> --->
			<tr>
				<td>
					<label>
						<cfoutput>#get_user.account_name#</cfoutput>
					</label>
				</td>
				<td>
					<label>
						<cfoutput>#get_token.token_session_name#</cfoutput>
					</label>
				</td>
				<td>
					<label>
						<cfoutput>#get_user.user_name#</cfoutput>
					</label>
				</td>
				<td>
					<label>
						<cfoutput>#get_user.user_firstname#</cfoutput>
					</label>
				</td>
				<td>
					<label>
						<cfoutput>#get_token.token_code#</cfoutput>
					</label>
				</td>
				<td>
					<label>
						<cfoutput>#get_token.certif_name#</cfoutput>
					</label>
				</td>
				
				<td>
					<input type="text" name="new_token_<cfoutput>#token_id#</cfoutput>" class="form-control form-control-sm" value="">
				</td>
			</tr>
		</cfloop>

	</table>

	<div>
		<cfoutput>
			<input type="hidden" id="token_list" name="token_list" value="#token_list#">
			<input type="submit" id="submit_session_edit" class="btn btn-info" value="#obj_translater.get_translate('btn_save')#">
		</cfoutput>
	</div>

	</form>
	

<script>
$(document).ready(function() {

	$('#submit_session_edit').click(function(){
		event.preventDefault();

		console.log($('#form_token_edit').serialize()); 
		$.ajax({
			url: './api/token/token_post.cfc?method=attribute_new_token',
			type: 'POST',
			data : $('#form_token_edit').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

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



