<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

<cfquery name="get_status_finance" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM order_status_finance
</cfquery>

<!--- <cfset get_order = obj_query.oget_orders(o_id="#o_id#")> --->

<cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
	SELECT order_ref, order_status_id FROM orders WHERE order_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#o_id#">
</cfquery>

<cfset dir_go = "#SESSION.BO_ROOT#">

<cfif isdefined("act") AND act eq "upl_apc">
	<cfset dir_go &= "/admin/apc/">
	<cfset dir_rel = "/admin/apc">
	<cfset n_doc = "APC">
<cfelseif isdefined("act") AND act eq "upl_bdc">
	<cfset dir_go &= "/admin/bdc/">
	<cfset dir_rel = "/admin/bdc">
	<cfset n_doc = "BDC">
<cfelseif isdefined("act") AND act eq "upl_conv">
	<cfset dir_go &= "/admin/conv/">
	<cfset dir_rel = "/admin/conv">
	<cfset n_doc = "CONV">
<cfelseif isdefined("act") AND act eq "upl_avn">
	<cfset dir_go &= "/admin/avn/">
	<cfset dir_rel = "/admin/avn">
	<cfset n_doc = "AVN">
<cfelseif isdefined("act") AND act eq "upl_avn2">
	<cfset dir_go &= "/admin/avn2/">
	<cfset dir_rel = "/admin/avn2">
	<cfset n_doc = "AVN2">
<cfelseif isdefined("act") AND act eq "upl_aff">
	<cfset dir_go &= "/admin/aff/">
	<cfset dir_rel = "/admin/aff">
	<cfset n_doc = "AFF">
<cfelseif isdefined("act") AND act eq "upl_cert">
	<cfset dir_go &= "/admin/cert/">
	<cfset dir_rel = "/admin/cert">
	<cfset n_doc = "CERT">
<cfelseif isdefined("act") AND act eq "upl_cda">
	<cfset dir_go &= "/admin/cda/">
	<cfset dir_rel = "/admin/cda">
	<cfset n_doc = "CDA">
<cfelseif isdefined("act") AND act eq "upl_bf">
	<cfset dir_go &= "/admin/bf/">
	<cfset dir_rel = "/admin/bf">
	<cfset n_doc = "BF">
</cfif>

<cfif isDefined("u_id")>
	<cfset dir_go &= "#u_id#/">
	<cfset dir_rel &= "/#u_id#">
</cfif>
<!--- <cfoutput>#dir_go#</cfoutput> --->

	<cfform action="updater_upload_admin.cfm" enctype="multipart/form-data" method="POST" id="form_ln">
	<table class="table table-sm table-bordered">

		<tr>
			<th class="bg-light" colspan="2">
			<div align="center"><label>PI&Egrave;CE JOINTE</label></div>
			</th>
		</tr>
			
		<cfdirectory directory="#dir_go#" name="dirQuery" action="LIST">
		
		<cfif dirQuery.recordcount eq "0">
			<tr>
				<td colspan="2" align="center"><em>Aucun fichier</em></td>
			</tr>
		<cfelse>
		
			<cfoutput>
			<cfloop query="dirQuery">
			<cfif findnocase("#n_doc#_#get_order.order_ref#",#name#)>
			<tr>
				<th class="bg-light" width="30%">
				<label>Fichier</label>
				</th>
				<td colspan="2">
				<a href="#dir_rel#/#name#" target="_blank">#name#</a>
				<a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a>
				</td>
			</tr>
			</cfif>
			
			</cfloop>
			</cfoutput>
		
		</cfif>

	</table>

	<table class="table table-sm table-bordered">
	
		<tr>
			<th class="bg-light" colspan="2">
			<div align="center"><label>EDITER PI&Egrave;CE JOINTE</label></div>
			</th>
		</tr>
		
		<tr>
			<th class="bg-light" width="30%">
			<label>Pi&egrave;ce jointe</label><br><small>pdf / doc / docx / jpg / jpeg / png</small>
			</th>
			<td colspan="2">
			<input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc">
			</td>
		</tr>
		<!---<tr>
			<th class="bg-light" width="30%">
			<label>Statut finance</label>
			</th>
			<td colspan="2">
			<cfselect class="form-control" name="order_status_id" query="get_status_finance" value="status_finance_id" display="status_finance_name" selected="#get_order.order_status_id#">
			</cfselect>
			</td>
		</tr>--->
	</table>


	<!---<div align="center">
	<br>
	<label><input type="checkbox" name="finalise_doc" id="finalise_doc" class="finalise_doc" value="1" <cfif counter eq "0">disabled</cfif>><cfoutput>#obj_translater.get_translate('modal_ln_finalize')#</cfoutput></label>		
	</div>--->

	<input type="hidden" name="a_id" value="<cfoutput>#a_id#</cfoutput>">
	<input type="hidden" name="o_id" value="<cfoutput>#o_id#</cfoutput>">
	<cfif isDefined("u_id")><input type="hidden" name="u_id" value="<cfoutput>#u_id#</cfoutput>"></cfif>
	<cfif isDefined("ucb")><input type="hidden" name="ucb" value="<cfoutput>#ucb#</cfoutput>"></cfif>
	<input type="hidden" name="from" value="<cfoutput>#from#</cfoutput>">
	<input type="hidden" name="act" value="<cfoutput>#act#</cfoutput>">
	<input type="hidden" name="dir_go" value="<cfoutput>#dir_go#</cfoutput>">
	<input type="hidden" name="dir_rel" value="<cfoutput>#dir_rel#</cfoutput>">
	<input type="hidden" name="n_doc" value="<cfoutput>#n_doc#</cfoutput>">


	<div align="center"><input type="submit" class="btn btn-outline-info" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>

	</cfform>

	<!---<script>
	$("#doc_attach").change(function() {

		if($("#doc_attach").val() != "") {
			$("#finalise_doc").removeAttr("disabled");
		}
		else {
			$("#finalise_doc").attr("disabled", true);
		}

	});
	</script>--->


</cfif>
