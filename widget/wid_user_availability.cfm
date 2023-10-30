<cfset listgo = evaluate("SESSION.DAYWEEK_#ucase(SESSION.LANG_CODE)#")>

<cfif isdefined("edit_avail")>
<table class="table table-sm table-condensed table-bordered">
	<tr class="bg-light">
		<th></th>
		<cfoutput>
		<cfset counter = 0>
		<cfloop list="#listgo#" index="cor">
			<cfif (isdefined("remove_day") AND not listfind(remove_day,counter)) OR not isdefined("remove_day")>
				<th><label>#cor#</label></th>
			</cfif>
			<cfset counter++>
		</cfloop>
		</cfoutput>
	</tr>
	<tr>
		<th class="bg-light"><label>7h/12h</label></th>
		<td><input type="checkbox" name="avail_id" value="1" <cfif listfind(avail_id,"1")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="5" <cfif listfind(avail_id,"5")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="9" <cfif listfind(avail_id,"9")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="13" <cfif listfind(avail_id,"13")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="17" <cfif listfind(avail_id,"17")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="21" <cfif listfind(avail_id,"21")>checked</cfif>></td>
		<!--- <td><input type="checkbox" name="avail_id" value="25" <cfif listfind(avail_id,"25")>checked</cfif>></td> --->
	</tr>
	<tr>
		<th class="bg-light"><label>12h/15h</label></th>
		<td><input type="checkbox" name="avail_id" value="2" <cfif listfind(avail_id,"2")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="6" <cfif listfind(avail_id,"6")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="10" <cfif listfind(avail_id,"10")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="14" <cfif listfind(avail_id,"14")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="18" <cfif listfind(avail_id,"18")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="22" <cfif listfind(avail_id,"22")>checked</cfif>></td>
		<!--- <td><input type="checkbox" name="avail_id" value="26" <cfif listfind(avail_id,"26")>checked</cfif>></td> --->
	</tr>
	<tr>
		<th class="bg-light"><label>15h/19h</label></th>
		<td><input type="checkbox" name="avail_id" value="3" <cfif listfind(avail_id,"3")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="7" <cfif listfind(avail_id,"7")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="11" <cfif listfind(avail_id,"11")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="15" <cfif listfind(avail_id,"15")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="19" <cfif listfind(avail_id,"19")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="23" <cfif listfind(avail_id,"23")>checked</cfif>></td>
		<!--- <td><input type="checkbox" name="avail_id" value="27" <cfif listfind(avail_id,"27")>checked</cfif>></td> --->
	</tr>
	<tr>
		<th class="bg-light"><label>19h/22h</label></th>
		<td><input type="checkbox" name="avail_id" value="4" <cfif listfind(avail_id,"4")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="8" <cfif listfind(avail_id,"8")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="12" <cfif listfind(avail_id,"12")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="16" <cfif listfind(avail_id,"16")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="20" <cfif listfind(avail_id,"20")>checked</cfif>></td>
		<td><input type="checkbox" name="avail_id" value="24" <cfif listfind(avail_id,"24")>checked</cfif>></td>
		<!--- <td><input type="checkbox" name="avail_id" value="28" <cfif listfind(avail_id,"28")>checked</cfif>></td> --->
	</tr>
</table>

<cfelseif isdefined("pdf_version")>

<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
	<tr class="bg-light">
		<th></th>
		<cfoutput>
		<cfset counter = 0>
		<cfloop list="#listgo#" index="cor">
			<cfif (isdefined("remove_day") AND not listfind(remove_day,counter)) OR not isdefined("remove_day")>
				<th><label>#cor#</label></th>
			</cfif>
			<cfset counter++>
		</cfloop>
		</cfoutput>
	</tr>
	<tr>
		<th align="center"><label>7h/12h</label></th>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"1")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"5")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"9")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"13")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"17")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"21")>X</cfif></td>
		<!--- <td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"25")>X</cfif></td> --->
	</tr>
	<tr>
		<th align="center"><label>12h/15h</label></th>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"2")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"6")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"10")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"14")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"18")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"22")>X</cfif></td>
		<!--- <td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"26")>X</cfif></td> --->
	</tr>
	<tr>
		<th align="center"><label>15h/19h</label></th>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"3")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"7")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"11")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"15")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"19")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"23")>X</cfif></td>
		<!--- <td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"27")>X</cfif></td> --->
	</tr>
	<tr>
		<th align="center"><label>19h/22h</label></th>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"4")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"8")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"12")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"16")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"20")>X</cfif></td>
		<td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"24")>X</cfif></td>
		<!--- <td align="center" bgcolor="#FFF"><cfif listfind(avail_id,"28")>X</cfif></td> --->
	</tr>
</table>

<cfelseif isdefined("tiny_version")>

<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:10px" width="100%" cellpadding="0" cellspacing="1">		
	<tr class="bg-light">
		<th style="padding:1px !important; margin:1px !important"></th>
		<cfoutput>
		<cfset counter = 0>
		<cfloop list="#listgo#" index="cor">
			<cfif (isdefined("remove_day") AND not listfind(remove_day,counter)) OR not isdefined("remove_day")>
			<th style="padding:1px !important; margin:1px !important"><label>#cor#</label></th>
			</cfif>
			<cfset counter++>
		</cfloop>
		</cfoutput>
	</tr>
	<tr>
		<th style="padding:1px !important; margin:1px !important" align="center"><label>7h/12h</label></th>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"1")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"5")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"9")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"13")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"17")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"21")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<!--- <td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"25")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td> --->
	</tr>
	<tr>
		<th style="padding:1px !important; margin:1px !important" align="center"><label>12h/15h</label></th>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"2")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"6")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"10")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"14")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"18")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"22")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<!--- <td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"26")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td> --->
	</tr>
	<tr>
		<th style="padding:1px !important; margin:1px !important" align="center"><label>15h/19h</label></th>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"3")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"7")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"11")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"15")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"19")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"23")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<!--- <td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"27")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td> --->
	</tr>
	<tr>
		<th style="padding:1px !important; margin:1px !important" align="center"><label>19h/22h</label></th>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"4")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"8")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"12")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"16")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"20")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"24")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td>
		<!--- <td align="center" bgcolor="#FFF" style="padding:1px !important; margin:1px !important"><cfif listfind(avail_id,"28")><span class="badge badge-pill badge-success">&nbsp;</span></cfif></td> --->
	</tr>
</table>

<cfelse>
<table class="table table-sm table-condensed table-bordered">
	<tr class="bg-light">
		<th></th>
		<cfoutput>
		<cfset counter = 0>
		<cfloop list="#listgo#" index="cor">
			<cfif (isdefined("remove_day") AND not listfind(remove_day,counter)) OR not isdefined("remove_day")>
			<th><label>#cor#</label></th>
			</cfif>
			<cfset counter++>
		</cfloop>
		</cfoutput>
		<th width="1%" rowspan="5">
			<cfif listFindNoCase("LEARNER,CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
			<button class="btn btn-info btn-sm btn_learner_edit_avail my-0"><i class="fas fa-edit"></i></button>
			</cfif>
		</th>
	</tr>
	<tr>
		<th align="center" class="bg-light"><label>7h/12h</label></th>
		<td align="center"><cfif listfind(avail_id,"1")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"5")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"9")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"13")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"17")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"21")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<!--- <td align="center"><cfif listfind(avail_id,"25")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td> --->
	</tr>
	<tr>
		<th align="center" class="bg-light"><label>12h/15h</label></th>
		<td align="center"><cfif listfind(avail_id,"2")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"6")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"10")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"14")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"18")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"22")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<!--- <td align="center"><cfif listfind(avail_id,"26")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td> --->
	</tr>
	<tr>
		<th align="center" class="bg-light"><label>15h/19h</label></th>
		<td align="center"><cfif listfind(avail_id,"3")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"7")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"11")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"15")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"19")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"23")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<!--- <td align="center"><cfif listfind(avail_id,"27")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td> --->
	</tr>
	<tr>
		<th align="center" class="bg-light"><label>19h/22h</label></th>
		<td align="center"><cfif listfind(avail_id,"4")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"8")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"12")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"16")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"20")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<td align="center"><cfif listfind(avail_id,"24")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td>
		<!--- <td align="center"><cfif listfind(avail_id,"28")><small><span class="badge badge-pill badge-success">&nbsp;</span></small></cfif></td> --->
	</tr>
</table>

</cfif>

