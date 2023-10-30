<cfsilent>
<cfif isdefined("pack_id")>

	<cfquery name="get_pack" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_formation_pack WHERE pack_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_id#">
	</cfquery>

	<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_formation
	</cfquery>

	<cfquery name="get_certif" datasource="#SESSION.BDDSOURCE#">
	SELECT certif_id, certif_name FROM lms_list_certification WHERE certif_id IN (4,5,51,53,42,43,44,45,46,47,48,49,50)
	</cfquery>

	<cfoutput query="get_pack">

	<cfset formation_id = "#formation_id#">
	<cfset certif_id = "#certif_id#">
	<cfset pack_name = "#pack_name#">
	<cfset pack_hour = "#pack_hour#">
	<cfset pack_duration = "#pack_duration#">
	<cfset pack_objectives = "#pack_objectives#">
	<cfset pack_results = "#pack_results#">
	<cfset pack_content = "#pack_content#">
	<cfset pack_certif = "#pack_certif#">
	<cfset pack_amount_ht = "#pack_amount_ht#">
	<cfset pack_amount_ttc = "#pack_amount_ttc#">
	<cfset tpmaster_id = "#tpmaster_id#">
	<cfset method_id = "#method_id#">
	<cfset destination_id = "#destination_id#">
	<cfset pack_modalites = "#pack_modalites#">
	<cfset pack_keys = "#pack_keys#">
	<cfset pack_certif_info = "#pack_certif_info#">
	<cfset pack_active = "#pack_active#">

	</cfoutput>

<!--- <cfelse>

	<cfset formation_id = "">
	<cfset certif_id = "">
	<cfset pack_name = "">
	<cfset pack_hour = "">
	<cfset pack_duration = "">
	<cfset pack_objectives = "">
	<cfset pack_results = "">
	<cfset pack_content = "">
	<cfset pack_certif = "">
	<cfset pack_amount_ht = "">
	<cfset pack_amount_ttc = "">
	<cfset tpmaster_id = "">
	<cfset method_id = "">
	<cfset destination_id = "">
	<cfset pack_modalites = "">
	<cfset pack_keys = "">
	<cfset pack_certif_info = "">
	<cfset pack_active = "1"> --->


</cfif>
</cfsilent>


<cfform action="updater_pack.cfm">
<cfoutput>
<div class="row">
								
	<div class="col-md-12">
		
		<table class="table table-sm table-bordered bg-white">
			<tr>
				<td class="bg-light"><label>Intitulé</label></td>
				<td><textarea name="pack_name" class="form-control">#pack_name#</textarea>
			</tr>
			<tr>
				<td class="bg-light"><label>Formation</label></td>
				<td><cfselect name="formation_id" class="form-control" query="get_formation" display="formation_name_fr" value="formation_id" selected="#formation_id#"></cfselect></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Méthodes</label></td>
				<td>
				<input type="checkbox" name="method_id" <cfif listfind(method_id,1)>checked</cfif> value="1"> VISIO
				<br>
				<input type="checkbox" name="method_id" <cfif listfind(method_id,3)>checked</cfif> value="3"> EL
				<br>
				<input type="checkbox" name="method_id" <cfif listfind(method_id,6)>checked</cfif> value="6"> IMMERSION
				</td>
			</tr>
			<tr>
				<td class="bg-light"><label>Online</label></td>
				<td><input type="radio" name="pack_active" <cfif pack_active eq "1">checked</cfif> value="1"> ONLINE &nbsp;&nbsp;&nbsp; <input type="radio" name="pack_active" <cfif pack_active neq "1">checked</cfif>> OFFLINE</td>
			</tr>
			<tr>
				<td class="bg-light"><label>Nb heures</label></td>
				<td><input name="pack_hour" class="form-control" value="#pack_hour#"></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Durée Elearning</label></td>
				<td><input name="pack_duration" class="form-control" value="#pack_duration#"></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Certif</label></td>
				<td><cfselect name="certif_id" class="form-control" query="get_certif" display="certif_name" value="certif_id" selected="#certif_id#"></cfselect></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Certif info</label></td>
				<td><textarea name="pack_certif_info" class="form-control" rows="4">#pack_certif_info#</textarea></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Prix HT</label></td>
				<td><input name="pack_amount_ht" class="form-control" value="#pack_amount_ht#"></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Prix TTC</label></td>
				<td><input name="pack_amount_ttc" class="form-control" value="#pack_amount_ttc#"></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Objectifs</label></td>
				<td><textarea name="pack_objectives" class="form-control" rows="4">#pack_objectives#</textarea></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Résultats</label></td>
				<td><textarea name="pack_results" class="form-control" rows="4">#pack_results#</textarea></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Contenus</label></td>
				<td><textarea name="pack_content" class="form-control" style="min-height:300px !important">#pack_content#</textarea></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Modalit&eacute;s</label></td>
				<td><textarea name="pack_modalites" class="form-control" rows="4">#pack_modalites#</textarea></td>
			</tr>
			<tr>
				<td class="bg-light"><label>Keys</label></td>
				<td><textarea name="pack_keys" class="form-control" rows="4">#pack_keys#</textarea></td>
			</tr>
		</table>
		
		
		<cfif isdefined("pack_id")>
		<input type="hidden" name="pack_id" value="#pack_id#">
		<input type="hidden" name="act" value="updt">
		<cfelse>
		<input type="hidden" name="act" value="ins">
		</cfif>
		<input type="submit" class="btn btn-success" value="Enregistrer">
		

	</div>

</div>
</cfoutput>
</cfform>

	
<script>
$(document).ready(function() {

	$('.btn_upl_conv').click(function(event) {	

	});
	

});
</script>