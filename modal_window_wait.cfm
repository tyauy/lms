<div class="row" style="margin-top:5px">
	<div class="col-md-12">
		<cfoutput>
		<cfif SESSION.LANG_CODE eq "fr">
			<strong>Vous avez effectu&eacute; les &eacute;tapes pr&eacute;alables au lancement de votre formation et nous vous en remercions !</strong>


			<cfif not isdefined("SESSION.SETUP_SCHEDULED")>
			<br><br>
			Veuillez programmer un rendez-vous de lancement (environ 15 minutes) avec notre &eacute;quipe pour d&eacute;buter votre formation.
			<br><br>
			
			<div align="center"><a href="##" class="btn btn-success btn_meet_wefit"> Prendre rendez-vous</a></div>
			<cfelse>
			<br><br>
			<div class="alert alert-success">Votre rendez-vous de lancement a &eacute;t&eacute; planifi&eacute;. A la suite de ce rendez-vous, vous serez parfaitement autonome pour r&eacute;aliser votre formation.</div>
			
			</cfif>
			<br><br>
			Vous pouvez nous joindre aux coordonn&eacute;es suivantes :
			<br><br>
			<div align="center"><a href="##" class="btn btn-info"> 01 89 16 82 67 <br>service@wefitgroup.com</a></div>
			<br>
			<div align="center"><a href="connect_out.cfm" class="btn btn-sm btn-outline-info">D&eacute;connexion</a></div>
		<cfelseif SESSION.LANG_CODE eq "en">
			<strong>You have reached the first step of your training...</strong>
			<br><br>
			... Congratulations !
			<br><br>
			Please contact our support team to find the best trainer and start your training !
			<br><br>
			You can contact us :
			<br><br>
			<div align="center"><a href="##" class="btn btn-info"> +33 1 89 16 82 67 <br>service@wefitgroup.com</a></div>
			<br>
			<div align="center"><a href="connect_out.cfm" class="btn btn-sm btn-outline-info">Disconnect</a></div>
		<cfelseif SESSION.LANG_CODE eq "de">
			<strong>Sie haben alle notwendigen Schritte vor dem Start Ihres Trainings abgeschlossen &ndash; Vielen Dank.</strong>
			<br><br>
			Bitte kontaktieren Sie nun unseren Kundenservice um Ihren ersten Kurs zu buchen.
			<br><br>
			Nachstehend finden Sie unsere Kontaktinformationen:
			<br><br>
			<div align="center"><a href="##" class="btn btn-info"> +49 7151 2 59 40 54 <br>service@wefitgroup.com</a></div>
			<br>
			<div align="center"><a href="connect_out.cfm" class="btn btn-sm btn-outline-info">Abmelden</a></div>
		<cfelseif SESSION.LANG_CODE eq "es">
		<cfelseif SESSION.LANG_CODE eq "it">
		</cfif>
													
													

		</cfoutput>
	</div>
</div>


<script>

$(document).ready(function() {

	$('.btn_meet_wefit').click(function(event) {
	
		event.preventDefault();		
		$('#modal_body_pw').empty();		
		$('#modal_body_pw').load("modal_window_calendar_cs.cfm", function() {});
	});
	
})
	
</script>
