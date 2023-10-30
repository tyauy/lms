<cfparam name="formation_id" default="2">

<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2> FR FR FR FR FR FR SERVICE DELIVERY CONTRACT</h2>					
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<h3>BETWEEN THE UNDERSIGNED</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>	


	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="20" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="center">
					<strong>WEFIT GROUP</strong><br>
					168 rue de la Convention - 75015 PARIS<br>
					Registered under Siret 510 689 649 00034 at the RCS de Paris.<br>
					<br>
					Represented by Mr. Vincent GEST as director<br>
					Declared and registered under 11 75 46556 7with the Prefect of the region Ile de France.<br>
					<br><br>
					Hereafter referred to as : <strong>WEFIT</strong>
					<br>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" align="center" style="padding:0px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<h3>AND</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:10px 20px 10px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="20" bgcolor="#ECECEC">
				<tr>
					<td width="100%" align="center">
						<cfoutput query="get_planner">
						<strong>#user_firstname# #user_name#</strong>
						<br>
						#user_adress_inv#<br>
						#user_postal_inv# - #user_city_inv#<br>
						#country_name#<br><br>
						<br>
						</cfoutput>
						<br><br>
						Hereafter referred to as : : <strong>THE TRAINER</strong>
						<br>

					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td width="100%" align="center" style="padding:60px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="center">
						<h3>THE FOLLOWING CONTRACT IS CONCLUDED :</h3>
					</td>
				</tr>
			</table>
		</td>
	</tr>


	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

						Given, the definition of the following generic terms:<br><br>


						<strong>"WEFIT"</strong> : term relating to the WEFITGROUP SAS contractor who delegates the
						<strong>"TRAINER MISSION"</strong> the private law co-contracting legal person to which the
						<strong>"MISSION"</strong> is assigned: object of the contract as defined in article 1 of this contract	
						<strong>"LEARNER", "LEARNERS"</strong>  : any learner contractually bound to WEFIT by a training agreement or by a support agreement from the OPCO, for which WEFIT entrusts the training to the TRAINER vis this
						<strong>"SERVICE"</strong> contract: service mentioned in the training agreement or the OPCO support agreement between WEFIT and the
						<strong>LEARNER</strong>
					</td>
				</tr>
			</table>
		</td>
	</tr>


	<!--- ARTICLE 1 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 1 : SUBJECT OF THE CONTRACT</h3>
					The service contract is valid for the following: <br><br>
					
					<!--- Here list t_domain ? --->
					- ENGLISH / Videoconference <br><br>

					The TRAINER is set up on the WEFIT platform so that the TRAINER can access all the LEARNERS information relating
					to their training including contact details, needs and length of training.<br>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<!--- ARTICLE 2 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 2 : TRAINERS OBLIGATIONS AND CONDITIONS OF USE</h3>
					The TRAINER commits to the following points: <br><br>
					
					<ul>
						<li>
							Offer the LEARNER a complete training program and update it on the WEFIT LMS platform. Provide a quality
							lesson note for each lesson completed and upload it to the WEFIT LMS platform within 2 working days. 
							The lesson note must follow the guidelines and training given by WEFIT<br>
						</li>
						<li>
							All lesson notes must be updated by midnight on the last working day of the month, regardless when the
							lesson took place, in order for that lesson to be paid on that month's invoice. If the lesson note is not
							completed then the lesson will not be paid.<br>
						</li>
						<li>
							The TRAINER must either use the resources provided by WEFIT or online materials that the TRAINER has
							sourced and WEFIT approved<br>
						</li>
						<li>
							Holidays may be taken as and when required however notice of 3 weeks must be given to WEFIT if the period
							the TRAINER is away exceeds 14 days. In this instance the TRAINERS learners will be given to another
							TRAINER during their absence. The learner may then choose to stay with the original TRAINER or continue with
							the new TRAINER<br>
						</li>
						<li>
							TRAINERS must sign and agree to the Trainer Promise<br>
						</li>
						<li>
							All TRAINERS must create a video and complete their online CV so that it is available on our LMS platform for
							WEFIT clients to view<br>
						</li>
						<li>
							All emails between the TRAINER and the learner must be sent from the TRAINER's WEFIT email account<br>
						</li>
						<li>
							In accordance with our commitment to constant improvement, TRAINERS must attend WEFIT training sessions
							and then apply the relevant techniques to their lessons<br>
						</li>
						<li>
							All TRAINERS must keep their business hours and calendar up to date to ensure that we can match TRAINERS
							to learner availability and that lessons are not canceled unnecessarily<br>
						</li>
					</ul>


					</td>
				</tr>
			</table>
		</td>
	</tr>


	<!--- ARTICLE 3 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 3 : DURATION OF CONTRACT</h3>
					This contract is concluded for a period of twelves months, renewable every 12 months.<br>
					</td>
				</tr>
			</table>
		</td>
	</tr>


	<!--- ARTICLE 4 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 4 : PAYMENT OF FEE</h3>
					In return the TRAINER will receive a fixed hourly remuneration per hour of teaching.<br><br>

					The hourly remuneration for the hours of visio lesson teaching is equal to 21.00 € HT<br><br>

					<ul>
						<li>
							After the TRAINER has been with WEFIT for two years they are eligible for our BONUS scheme, details of which
							will be given on the date they become eligible.<br>
						</li>
						<li>
							The TRAINER will not be paid for lessons that are missed by learners. However, the TRAINER will be offered
							the chance to fill missed lesson slots with other work.<br>
						</li>
						<li>
							The TRAINERS invoice will be paid no later than the 5th of the month, provided that the lessons are
							completed in the LMS system on the last working day of the month.<br>
						</li>
					</ul>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<!--- ARTICLE 5 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 5 : DURATION OF CONTRACT</h3>
					The software and training methods that the WEFIT company entrusts to the TRAINER are strictly confidential. These
					teaching aids and tools in fact constitute WEFIT's know-how. They may not be transmitted, nor disclosed to third
					parties, nor used by the TRAINER for any purpose other than that of the subject of this contract and defined in its
					article 1.<br>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<!--- ARTICLE 6 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 6 : PROTECTION OF PERSONAL DATA</h3>
					For the accomplishment of their MISSION, the TRAINER may be provided by WEFIT with personal data relating to
					LEARNERS, as defined in the EUROPEAN data protection regulations by CNIL. This data is limited to the name, email
					address and telephone number and profession of the LEARNER, for obvious reasons of identification and preparation
					of courses adapted to said LEARNER. The TRAINER undertakes never to disclose to any third party, in any form
					whatsoever, any of the personal data cited, which has been transmitted for the sole purpose of delivering a better
					service. In case of doubt or for any question relating to data protection, the TRAINER can contact WEFIT. <br>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<!--- ARTICLE 7 --->
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

					<h3>ARTICLE 7 : BREACH OF CONTRACT AND TERMS</h3>
					Each of the parties has the right, without prejudice to any other right or remedy, to terminate this service contract by
					giving one month's written notice. During the notice period, the TRAINER undertakes to respect the training schedule
					concluded with WEFIT. The 30 day notice is no longer considered necessary in the event of: <br>
					
					<ul>
						<li>
							Intentional or unintentional breach of WEFIT policies, rules and regulations. <br>
						</li>
						<li>
							Unauthorised disclosure of confidential information, whether related to WEFIT or it's LEARNERS<br>
						</li>
						<li>
							Commission of an act resulting in loss of confidence on the part of WEFIT with regard to the ability of the
							TRAINER to perform the MISSION according to the qualitative requirements of WEFIT. <br>
						</li>
						<li>
							Misuse or serious abuse of WEFIT property, facilities and/or resources participate directly or indirectly, enter
							into and/or enter into personal business agreements involving the products and/or services of WEFIT or the
							products and/or services of competitors of WEFIT intentional or unintentional breach or breach of
							confidentiality of information belonging to WEFIT.<br>
						</li>
					</ul>
					<br>
					If the TRAINER terminates the service contract without respecting the 30 day notice, WEFIT reserves the right to
					deduct from the remaining costs as damages an amount of two hundred and fifty euros (250€). <br>


					In the event of a conflict over the interpretation of this contract, the two parties will refer a case to a competent
					court in Paris <br><br>

					<cfoutput>#lsDateFormat(now(),'dd/mm/yyyy', 'fr')#</cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>

	<tr>
		<td width="100%" style="padding:20px">
				
			<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="8" cellspacing="1">
				<tr>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						<table bgcolor="#FFFFFF" style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left">
									<span style="font-size:13px;"><strong>WEFIT</strong></span><br>
									<span style="font-size:10px"><em>Vincent GEST, Pr&eacute;sident de WEFIT Group</em></span><br>
								
								</td>
							</tr>
							<tr>
								<td align="center">
									<img src="http://winegroup.synten.com/gateway/img/signature_wefit.jpg" align="center"><br><br>
								</td>
							</tr>
						</table>
					</td>
					<td width="4%"></td>
					<td width="48%" style="border:1px solid #ECECEC" valign="top" height="150">
						
						<span style="font-size:13px"><strong>Le FORMATEUR</strong></span><br>
						<span style="font-size:10px"><em>Signature</em></span>
						<br><br>
						<cfif signature_base64 neq "" AND save eq 1>
							<cfimage 
							required 
							action = "writeToBrowser"
							source = #signature_base64#
							format = "png" 
							isBase64= "yes">
						</cfif>
						
					</td>
				</tr>
			</table>
				

		</td>
	</tr>
</table>           

</body>
</html>