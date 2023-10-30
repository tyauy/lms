<cfsilent>

<cfset email_title = "Notation Cours">
<cfset email_subtitle = "Lesson #dateformat(get_lesson.lesson_start,'dd mmm yyyy')# - #timeformat(get_lesson.lesson_start,'HH:mm')# avec #get_lesson.trainer_firstname#">

<cfset btn_href = "https://lms.wefitgroup.com/common_tp_details.cfm?t_id=#get_lesson.tp_id#&u_id=#get_lesson.user_id#">
<cfset btn_lms = "GO TO TP">
<cfset th_detail = "DETAILS">
<cfset th_title = "Lesson">
<cfset th_note_support = "Support">
<cfset th_note_teaching = "Formateur">
<cfset th_note_techno = "Technique">
<cfset th_note_description = "Comments">	


</cfsilent>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
	<cfinclude template="incl_email_meta.cfm">
</head>

<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: #FFF;">
    <center style="width: 100%; background-color: #FFF; text-align: left;">
		
	<cfinclude template="incl_email_header.cfm">
			
			<!-- 1 Column Text + Button : BEGIN -->
            <tr>
                <td style="background-color: #ffffff;">
                    <table role="presentation" cellspacing="0" cellpadding="0" border="0" width="100%" style="background-color: #ffffff;">
                        <tr>
                            <td style="padding: 20px 30px 20px 30px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                                <h1 style="margin: 0 0 10px; font-size: 24px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_title#</cfoutput></h1>
								<h4 style="margin: 0 0 10px; font-size: 16px; line-height: 125%; color: #333333; font-weight: normal; text-align:center"><cfoutput>#email_subtitle#</cfoutput></h4>
								<p style="margin: 0 0 10px;">
									<table width="100%" cellpadding="5">
										<tr>
											<th bgcolor="#F3F3F3"><cfoutput>#th_detail#</cfoutput></th>
										</tr>
									</table>
									<table width="100%" cellpadding="5">
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_title#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfoutput>#get_lesson.sessionmaster_name#</cfoutput>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_note_support#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfif isdefined("note_support") AND note_support neq ""><cfoutput>#note_support#/5</cfoutput><cfelse>N/C</cfif>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_note_teaching#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfif isdefined("note_teaching") AND note_teaching neq ""><cfoutput>#note_teaching#/5</cfoutput><cfelse>N/C</cfif>
											</td>
										</tr>
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_note_techno#</cfoutput></td>
											<td width="75%" style="background-color: #FFF; font-size: 13px;">
											<cfif isdefined("note_techno") AND note_techno neq ""><cfoutput>#note_techno#/5</cfoutput><cfelse>N/C</cfif>
											</td>
										</tr>										
										<tr>
											<td width="25%" style="background-color: #F3F3F3; font-size: 13px;"><cfoutput>#th_note_description#</cfoutput></td>
											<td style="background-color: #FFF; font-size: 13px;">
											<cfif isdefined("note_description")><cfoutput>#note_description#</cfoutput><cfelse>N/C</cfif>
											</td>
										</tr>
									</table>
								</p>
							</td>
                        </tr>
						<tr>
                            <td style="padding: 0 40px 40px; font-family: sans-serif; font-size: 15px; line-height: 140%; color: #555555;">
                                <!-- Button : BEGIN -->
                                <table role="presentation" cellspacing="0" cellpadding="0" border="0" align="center" style="margin: auto;">
                                    <tr>
                                        <td class="button-td button-td-primary" style="border-radius: 4px; background: #87222F;">

										     <a class="button-a button-a-primary" href="<cfoutput>#btn_href#</cfoutput>" style="background: #87222F; border: 1px solid #87222F; font-family: sans-serif; font-size: 15px; line-height: 15px; text-decoration: none; padding: 13px 17px; display: block; border-radius: 4px;"><span class="button-link" style="color:#ffffff"><cfoutput>#btn_lms#</cfoutput></span></a>

										</td>
                                    </tr>
                                </table>
                                <!-- Button : END -->
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- 1 Column Text + Button : END -->
		
		<cfinclude template="incl_email_footer.cfm">
		
    </center>
</body>
</html>