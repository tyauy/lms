<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h1><cfoutput>#obj_translater.get_translate('table_th_program')#</cfoutput></h1>					
						<h2><cfoutput>#get_sm.tpmaster_name#</cfoutput></h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	
	<tr>
		<td width="100%" align="center" style="padding:20px">		
							
				<cfset counter = 0>
				<cfoutput query="get_sm" group="module_id">
				<table bgcolor="##ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
					<tr>
						<td colspan="2" align="center">
						<h3 style="margin-top:10px;margin-bottom:5px"><cfif module_id neq "">#ucase(module_name)#</cfif></h3>
						<cfif module_description neq "">
						<p>
						#module_description#
						<p>
						</cfif>
						</td>
					</tr>
					<cfoutput>
					<tr>
						<td width="10%" bgcolor="##FFFFFF">
							<cfif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_code#.jpg")>			
								<img src="../assets/img_material/thumbs/#sessionmaster_code#.jpg" width="50" align="left">
							<cfelseif fileexists("#SESSION.BO_ROOT#/assets/img_material/thumbs/#sessionmaster_id#.jpg")>	
								<img src="../assets/img_material/thumbs/#sessionmaster_id#.jpg" width="50" align="left">
							<cfelse>
								<img src="../assets/img/wefit_lesson.jpg" width="50" align="left">
							</cfif>
						</td>
						<!--- <td width="10%" bgcolor="##FFFFFF"> --->
							<!--- <span style="font-size:12px;">Cours&nbsp;#sessionmaster_rank#</span> --->
						<!--- </td> --->
						<!--- <td width="10%" bgcolor="##FFFFFF"> --->
							<!--- <span style="font-size:12px;">#sessionmaster_schedule_duration# min</span> --->
						<!--- </td> --->
						<td width="70%" bgcolor="##FFFFFF"><!---#sessionmaster_id#--->
							<span style="font-size:12px;"><cfif evaluate("sessionmaster_name_#SESSION.LANG_CODE#") neq "">#evaluate("sessionmaster_name_#SESSION.LANG_CODE#")#<cfelse>#sessionmaster_name#</cfif></span>
							<cfif sessionmaster_id eq "695" OR sessionmaster_id eq "694">
							<br>#evaluate("sessionmaster_description_#SESSION.LANG_CODE#")#
							</cfif>
						</td>
					</tr>
					</cfoutput>
				</table>	
				</cfoutput>
		</td>
	</tr>
								
	
</table>

</body>
</html>