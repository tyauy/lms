<cfparam name="lang" default="fr">
<cfparam name="user_firstname" default="Krystina">
<cfparam name="msel" default="11">
<cfparam name="ysel" default="2022">

<!--- TO REMOVE IN FINAL VERSION !!! --->
<cfinclude template="./incl_nav_beta.cfm">
<!--- !!!! --->


<cfsilent>

	<!--- <cfset email_title = "Bonjour #get_tps.user_contact#"> --->

</cfsilent>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
<head>
	<cfinclude template="incl_email_meta.cfm">
</head>

<body width="100%" style="margin: 0; mso-line-height-rule: exactly; background-color: #FFF;">
    <center style="width: 100%; background-color: #FFF; text-align: left;">
		
		<cfinclude template="incl_email_header.cfm">
				
		<p>Hello <cfoutput>#user_firstname#</cfoutput></p>

		<p>Please find attached your invoice for <strong><cfoutput>#listgetat(SESSION.LISTMONTHS,msel)# #ysel#</cfoutput></strong>. Could you please check if all the information is correct for both the amounts as well and the bank details?</p>

		<p>Please sign it on every page and provide us a clear copy <strong>ASAP</strong>.</p>

		<p>If you have any questions or concerns, please don't hesitate to contact us. </p>

		<p>Thanks a lot in advance ! </p>

		<p>Regards,</p>

		<p><strong>WEFIT TEAM</strong></p>

		------------------------------------------------------------------------------------------------------------------------------------------
		
		<p>Bonjour <cfoutput>#user_firstname#</cfoutput></p>

		<p>Vous trouverez ci-joint votre facture du mois de <strong><cfoutput>#listgetat(SESSION.LISTMONTHS,msel)# #ysel#</cfoutput></strong>.  Pourriez-vous s' assurer que les heures ainsi que vos coordonnées bancaires sont correctes?</p>

		<p>Nous vous prions de signer toutes les pages et de nous retourner la facture signée <strong>ASAP</strong>.</p>

		<p>Nous restons à votre disposition si vous avez des questions ou des informations complémentaires à nous communiquer. </p>

		<p>Vous remerciant par avance ! </p>

		<p>Cordialement,</p>

		<p><strong>WEFIT TEAM</strong></p>
				
			
		<cfinclude template="incl_email_footer.cfm">
		
    </center>
</body>
</html>
