<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name FROM lms_formation WHERE formation_language = 1 ORDER BY formation_name_fr
</cfquery>


<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>
<cfset session_duration = get_tp.session_duration/60>

<!--- <cfoutput>#session_duration#</cfoutput> --->

<!--- <cfabort> --->

<cfif session_duration neq "5" AND session_duration neq "10" AND session_duration neq "15" AND session_duration neq "20" AND session_duration neq "25" AND session_duration neq "30">

<div class="alert alert-danger">
Durée incompatible
</div>


<cfelse>

<form action="updater_prebuilt.cfm">
<table class="table">
	
<cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
<cfoutput>	
<tr>
<td>		
	<span class="lang-sm" lang="#lg#"></span>
</td>
<td>
	<input type="text" name="tpmaster_name_#lg#" class="form-control">
</td>
</tr>
</cfoutput>
</cfloop>

<tr>
<td>		
Niveau
<td>
<select name="tpmaster_level" class="form-control">
<option value="A1/A2">A1/A2</option>
<option value="B1/B2">B1/B2</option>
<option value="C1">C1</option>
</select>
</td>
</tr>

<!--- <tr> --->
<!--- <td>		 --->
<!--- Language --->
<!--- <td> --->
<!--- <select name="formation_id" class="form-control"> --->
<!--- <cfoutput query="get_formation"> --->

<!--- <option value="#formation_id#">#formation_name#</option> --->
<!--- </cfoutput> --->
<!--- </select> --->
<!--- </td> --->
<!--- </tr> --->



</table>

	<cfoutput>
	<input type="hidden" name="t_id" value="#t_id#">	
	</cfoutput>	
	<button type="submit" class="btn btn-primary">Créer prebuilt</button>
</form>

</cfif>