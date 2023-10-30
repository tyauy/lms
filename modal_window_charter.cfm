<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="10">
				<tr>
					<td width="100%" align="left">

<cfoutput>#obj_translater.get_translate_complex('intro_charter')#</cfoutput>
	
					</td>
				</tr>
			</table>

			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="8" cellspacing="1">		
				<tr>
					<td width="180">
						<span style="font-size:12px;">
						
						<cfoutput>#obj_translater.get_translate('table_th_learner')#</cfoutput>
						
						</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>#SESSION.USER_NAME#</cfoutput></span>
					</td>
				</tr>	
				<!---<tr>
					<td width="180">
						<span style="font-size:12px;">Soci&eacute;t&eacute;</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>#SESSION.ACCOUNT_NAME#</cfoutput></span>
					</td>
				</tr>		
				<tr>
					<td>
						<span style="font-size:12px;">Intitul&eacute; de la formation</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>#t_ch#</cfoutput></span>
					</td>
				</tr>	
				<cfif isdefined("l_ch")>
				<tr>
					<td>
						<span style="font-size:12px;">Langue</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>#l_ch#</cfoutput></span>
					</td>
				</tr>
				</cfif>
				<tr>
					<td>
						<span style="font-size:12px;">P&eacute;riode</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>Du #dateformat(df_ch,'dd/mm/yyyy')# au #dateformat(dt_ch,'dd/mm/yyyy')#</cfoutput></span>
					</td>
				</tr>	
				<cfif c_ch neq "0">
				<tr>
					<td width="180">
						<span style="font-size:12px;">Certification</span>
					</td>
					<td bgcolor="#FFFFFF">
						<span style="font-size:12px;"><cfoutput>#c_ch#</cfoutput></span>
					</td>
				</tr>
				</cfif>--->
							
			</table>	
		</td>
	</tr>
	
	
	
	
	<tr>
		<td>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; margin-top:30px" width="100%" cellpadding="8" cellspacing="1" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="left">

<cfoutput>
<strong>#obj_translater.get_translate('lrn_charter_title')#</strong><br><br>
#obj_translater.get_translate_complex('lrn_charter')#
</cfoutput>



					</td>
				</tr>
			</table>
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:13px; margin-top:30px" width="100%" cellpadding="8" cellspacing="1" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="left">

<cfoutput>
<strong>#obj_translater.get_translate('wefit_charter_title')#</strong><br><br>
#obj_translater.get_translate_complex('wefit_charter')#
</cfoutput>




					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr>
		<td align="center"><br><a href="updater_learner.cfm?updt_chart=1" class="btn btn-outline-info"><cfoutput>#obj_translater.get_translate_complex('accept_charter')#</cfoutput></a></td>
	</tr>
	
</table>
