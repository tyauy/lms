<cfsilent>

</cfsilent>

<!--------------------------------------------------------------------->
<html>

<body>

	<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellspacing="15">
		<tr>
			<td>
			</td>
		</tr>
		<tr><td><div align="center" style="font-size:17px;"><strong> DETAILS : LESSONS THIS PERIOD </strong></div></td></tr>
		<tr>
			<td>
				<!------ LESSON LISTING ------>
				<div width="100%" align="left" style="line-height: 1.5;">
					<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; background-color: #999999"
						width="100%" cellpadding="5" cellspacing="1">

						<tr align="center" bgcolor="#ECECEC">
							<td><strong>Learner</strong></td>
							<td><strong>Company</strong></td>
							<td><strong>Schedule</strong></td>
							<td><strong>Duration</strong></td>
							<td><strong>Lesson</strong></td>
							<td><strong>Status</strong></td>
							<td><strong>Training Program</strong></td>
						</tr>
						<cfoutput query="get_lessons">
							<tr bgcolor="##FFFFFF">
								<td align="center">#user_firstname# #user_name#</td>
								<td align="center">#account_name#</td>
								<td align="center">#lsDateTimeFormat(lesson_start,'dd/mm/yyyy HH:nn', "fr")#</td>
								<td align="center">#lesson_duration#</td>
								<td align="center"><cfif len(sessionmaster_name) gt "25"> #mid(sessionmaster_name,1,25)# [...] <cfelse> #sessionmaster_name# </cfif></td>
								<td align="center">#status_name#</td>
								<td align="center">#obj_lms.get_tp_text(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</td>
							</tr>
						</cfoutput>
					</table>

				</div>
			</td>
		</tr>
	</table>
</body>

</html>