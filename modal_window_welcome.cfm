<cfif show_info eq "welcome">

	<cfset get_tps = obj_tp_get.oget_tps(u_id="411",st_id="1")>

	<p align="center" style="font-size:18px">
	<!---COMPLEX
	<cfoutput>#obj_translater.get_translate_complex('welcome_intro')#</cfoutput>
	START_RM--->
	<cfif SESSION.LANG_CODE eq "fr">
	Vous &ecirc;tes sur le point de commencer votre formation chez WEFIT,<br>avant toute chose un petit rappel de votre abonnement !
	<cfelseif SESSION.LANG_CODE eq "de">

	<cfelseif SESSION.LANG_CODE eq "en">

	<cfelseif SESSION.LANG_CODE eq "es">

	<cfelseif SESSION.LANG_CODE eq "it">

	</cfif>
	<!---END_RM--->
	</p>

	<table class="table">
		<tr>
			<th class="bg-light">
			<label>Parcours de formation</label>
			</th>
			<th class="bg-light">
			<label>Date limite</label>
			</th>
		</tr>
		<cfoutput query="get_tps">
			<cfif method_id eq "3">
				<cfset access_el = "1">
			<cfelseif method_id eq "2">
				<cfset access_f2f = "1">
			<cfelseif method_id eq "1">
				<cfset access_visio = "1">
			</cfif>
			<tr>
				<td width="35%" style="font-size: 13px;">
				#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#
				</td>
				<td width="65%" style="font-size: 13px;">

				<cfif SESSION.LANG_CODE eq "fr">
				A r&eacute;aliser avant le <cfif order_end neq ""><strong>#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse><strong>#dateformat(tp_date_end,'dd/mm/yyyy')#</strong></cfif>
				<cfelseif SESSION.LANG_CODE eq "en">
				Subscription between <strong>#dateformat(tp_date_start,'yyyy/mm/dd')#</strong> and <strong>#dateformat(tp_date_end,'yyyy/mm/dd')#</strong>
				<cfelseif SESSION.LANG_CODE eq "de">
				Verwendbar von <strong>#dateformat(tp_date_start,'dd.mm.yyyy')#</strong> bis <strong>#dateformat(tp_date_end,'dd.mm.yyyy')#</strong>
				<cfelseif SESSION.LANG_CODE eq "it">
				Verwendbar von <strong>#dateformat(tp_date_start,'dd.mm.yyyy')#</strong> bis <strong>#dateformat(tp_date_end,'dd.mm.yyyy')#</strong>
				<cfelseif SESSION.LANG_CODE eq "es">
				Verwendbar von <strong>#dateformat(tp_date_start,'dd.mm.yyyy')#</strong> bis <strong>#dateformat(tp_date_end,'dd.mm.yyyy')#</strong>
				</cfif>
				</td>
			</tr>
		</cfoutput>
	</table>




	<cfif SESSION.LANG_CODE eq "de">
	<h6>Ihre Verpflichtungen</h6>


	<textarea readonly>
	<ul>
	<li>Um die Finanzierung zu gew&auml;hrleisten, ist es unbedingt erforderlich, dass alle Stunden Ihres Trainings vollendet sind und vor Ablauf des Trainingsende genommen werden. Nach Ablauf der Deadline, werden verbleibenden Stunden automatisch gel&ouml;scht.</li>
	<li>Wenn Ihr Training eine Zertifizierung oder Pr&uuml;fung enth&auml;lt, muss diese innerhalb von maximal 7 Tagen nach dem letzten Kurs bestanden werden.</li>
	<li>Sie k&ouml;nnen Ihre gebuchte Trainingseinheit bis zu 6 Stunden vor Beginn (Videokonferenztraining) sowie 48 Stunden vor Beginn (Pr&auml;senztraining) kostenfrei absagen. Nach Ablauf dieser Fristen, gehen die Stunden verloren.</li>
	<li>Stornierungen werden direkt &uuml;ber Ihren LMS-Kundenzugang vorgenommen (Servicezeiten 24 Stunden am Tag, 7 Tage die Woche). Die Anfrage wird sofort ber&uuml;cksichtigt.</li>
	<li>Stornierungen k&ouml;nnen auch beim Kundenservice vorgenommen werden, allerdings gelten hier die folgenden Servicezeiten: Montag bis Freitag von 8:00 bis 18:00 Uhr.</li>
	<li>Achtung, eine direkt an Ihren Trainer gerichtete E-Mail, ohne dass der Kundenservice in Kopie gesetzt wurde, kann f&uuml;r eine Stornierung leider nicht ber&uuml;cksichtigt werden.</li>
	<li>Nach 3-monatiger Inaktivit&auml;t ohne jegliche Information, werden wir Ihr Training unterbrechen und Ihren Zugang deaktivieren.</li>
	<li>Bei einer l&auml;ngeren, begr&uuml;ndeten Unterbrechung (Krankheit, Elternurlaub usw.) informieren Sie uns bitte, wann Sie Ihr Training fortsetzen k&ouml;nnen. Wir werden Ihren Zugang dementsprechend verl&auml;ngern.</li>
	<li>Wenn Sie eine E-Learning-Lizenz gebucht haben, sind folgende Hinweise zu beachten: Der Zugang startet nach R&uuml;cksprache mit dem Kundenservice und ist f&uuml;r die Anzahl der vorab festgelegen Monate g&uuml;ltig. Er kann weder verl&auml;ngert noch unterbrochen werden.</li>
	</ul>

	</textarea>

	<h6>Unsere Verpflichtungen</h6>
	<ul>
	<li>Unser Kundenservice steht Ihnen von Montag bis Freitag von 8:00 bis 18:00 Uhr ohne Unterbrechung zur Verf&uuml;gung</li>
	<li>Unser Kundenservice begleitet Sie w&auml;hrend Ihres Trainings (Bedarfsanalyse zu Beginn des Trainings, Terminangelegenheiten, Technische Unterst&uuml;tzung, etc.)</li>
	<li>Wir bieten Ihnen die M&ouml;glichkeit, jederzeit den Trainer zu wechseln oder mit mehreren Trainern zeitgleich zu arbeiten.</li>
	<li>Wir bieten ein auf Ihre Bed&uuml;rfnisse zugeschnittenes Programm an und stehen Ihnen f&uuml;r jede Neuorientierung zur Verf&uuml;gung.</li>
	<li>Wir stellen Ihnen jegliches Kursmaterial zur Verf&uuml;gung</li>
	<li>Wir stellen Ihnen im Nachgang einer jeden Trainingseinheit Ihre Lernnotizen zur Verf&uuml;gung.</li>
	</ul>

	<cfelse>

	<div class="card-deck">
		<div class="card border">
			<div class="card-body p-3 d-flex flex-column">
			
				<div align="center">
					<h5 class="d-inline"><i class="fal fa-list fa-lg"></i> Les règles du jeu</h5><br>
				</div>
							
				<p class="mt-3">
				<!---COMPLEX
				<cfoutput>#obj_translater.get_translate_complex('game_rules_intro')#</cfoutput>
				START_RM--->
				En fonction du financement de votre formation, vous avez l'obligation de réaliser votre formation dans son ensemble, et dans le délai imparti. 
				<br><br>
				Il y a également des règles du jeu lorsque vous avez souscrit un abonnement VISIO : nous avons rédigé la charte de l'apprenant, celle-ci contient les règles d'or pour que votre formateur et vous puissiez travailler dans les meilleures conditions.
				<!---END_RM--->
				<br>
				</p>
							
				<div class="m-2 p-2 mt-auto" align="center">
					<cfoutput>
					<input type="checkbox" name="accept_charter" id="accept_charter"> J'accepte la charte de l'apprenant.<br>
					<a target="_blank" href="common_cgu.cfm?show_info=charter">[#obj_translater.get_translate('btn_view_charter')#]</a> 
					</cfoutput>
				</div>
				
			</div>
		</div>
		<div class="card border">
			<div class="card-body p-3 d-flex flex-column">
				<div align="center">
					<h5 class="d-inline"><i class="fal fa-shield-check fa-lg"></i> Conditions d'utilisation</h5><br>
				</div>
							
				<p class="mt-3">
				WEFIT a mis en place une politique de sécurisation de vos données
				</p>
							
				<div class="m-2 p-2 mt-auto" align="center">
					<cfoutput>
					<input type="checkbox" name="accept_policy" id="accept_policy"> J'accepte les conditions d'utilisation de la plateforme WEFIT.<br>
					<a href="common_cgu.cfm?show_info=policy" target="_blank">[#obj_translater.get_translate('btn_view_rules')#]</a> 
					</cfoutput>
				</div>
				
			</div>
		</div>
	</div>


	
	
	<!--- <small> --->
	<!--- <ul> --->
	<!--- <li> --->
	<!--- Si votre formation est financ&eacute;e par un OPCO (Op&eacute;rateur de Comp&eacute;tences), il est imp&eacute;ratif, pour garantir son financement, que toutes les heures de votre formation soient r&eacute;alis&eacute;es, et que votre certification soit effectu&eacute;e (si applicable) avant la fin de p&eacute;riode indiqu&eacute;e sur votre accord de prise en charge. Apr&egrave;s cette date, les heures restant &agrave; effectuer seront automatiquement annul&eacute;es. </li> --->
	<!--- <li> Si votre formation comporte une certification ou un examen, celui-ci est obligatoire, il doit &ecirc;tre pass&eacute; &agrave; la suite du dernier cours dispens&eacute;, dans un d&eacute;lai maximum de 7 jours.</li> --->
	<!--- <li> Vous pouvez annuler votre cours jusqu'&agrave; 6 heures &agrave; l'avance (formation en visioconf&eacute;rence) ou 48 heures &agrave; l'avance (formation en pr&eacute;sentiel). En de&ccedil;&agrave; de ces d&eacute;lais, le cours sera perdu.</li> --->
	<!--- <li> Les annulations s&rsquo;effectuent directement sur votre acc&egrave;s client LMS (service accessible 24h/24h et 7j/7j.) La prise en compte de la demande est imm&eacute;diate.</li> --->
	<!--- <li> Les annulations peuvent &eacute;galement &ecirc;tre effectu&eacute;es aupr&egrave;s du service client (assistance possible uniquement durant les heures travaill&eacute;es : 8h &agrave; 18h du lundi au vendredi)</li> --->
	<!--- <li> Attention, un email adress&eacute; directement &agrave; votre formateur sans que le service client ne soit inclus en copie ne vaut pas pour annulation.</li> --->
	<!--- <li> Au bout de 3 mois d'inactivit&eacute;, malgr&eacute; nos tentatives de relance et sans nouvelles de votre part, nous suspendrons votre formation. </li> --->
	<!--- <li> Pour toute interruption prolong&eacute;e justifi&eacute;e (arr&ecirc;t maladie, cong&eacute; parental, etc.), veuillez nous tenir inform&eacute;s afin que nous anticipions la gestion administrative de votre dossier.</li> --->
	<!--- <li> Dans le cas o&ugrave; vous disposeriez d&rsquo;une licence de e-Learning, votre acc&egrave;s sera d&eacute;compt&eacute; &agrave; partir de la date d&rsquo;activation que vous aurez d&eacute;finie avec le service client. La licence sera valide pour le nombre de mois allou&eacute;. Aucune prolongation ni pause ne sera possible.</li> --->
	<!--- </ul> --->
	<!--- </small> --->
	<!--- </textarea> --->


	<!--- <small> --->
	<!--- <ul> --->
	<!--- <li>Le service client est &agrave; votre &eacute;coute du lundi au vendredi de 8h &agrave; 18h sans interruption.</li> --->
	<!--- <li>Le service client vous suit tout au long de votre formation (appel de qualit&eacute;, analyse des besoins au lancement de votre formation...)</li> --->
	<!--- <li>Nous vous offrons la possibilit&eacute; de changer de formateur &agrave; tout moment, ou de travailler avec plusieurs formateurs.</li> --->
	<!--- <li>Nous vous offrons un programme adapt&eacute; &agrave; vos besoins, et nous restons &agrave; votre &eacute;coute pour toute r&eacute;orientation.</li> --->
	<!--- <li>Nous mettons &agrave; votre disposition des supports de cours et les notes prisent par votre formateur suite &agrave; votre le&ccedil;on.</li> --->
	<!--- </ul> --->
	<!--- </small> --->

	<form action ="updater_form.cfm" id="charter_form">
	<input type="hidden" name="form_type" value="charter_form">
	<div align="center" class="mt-3">
		<button class="btn btn-success btn_accept_policy">
		<i class="fas fa-arrow-right"></i> Commencer ma formation
		</button>
	</div>
	</form>

	</cfif>	

<script>
$(document).ready(function() {

	$('#charter_form').submit(function(event) {

		if($('#accept_policy').prop('checked') != true || $('#accept_charter').prop('checked') != true)
		{
		alert("Veuillez accepter la charte ainsi que les conditions d'utilisation SVP");
		return false;
		}
		else
		{
		return true;
		}
	});
		
})
	
</script>






<cfelseif show_info eq "level">


	<cfform action="learner_launch_1.cfm" method="post" id="form_level">	
		<div class="row">
			<div class="col-md-12 mt-3">
				
	<cfoutput><img src="./assets/img/qpt_#qpt#.jpg" class="mr-4" align="left" width="190"></cfoutput>
			
	<p>
	Vous souhaitez poursuivre la pr&eacute;paration de votre formation sans effectuer votre test d'&eacute;valuation. Pas d'inqui&eacute;tude, vous pourrez &agrave; tout moment le passer une fois l'&eacute;tape de lancement r&eacute;alis&eacute;e.
	</p>
	<p>
	Veuillez cependant nous indiquer votre niveau afin que nous puissions vous proposer les contenus et les formateurs les plus adapat&eacute;s
	</p>
			
			<select class="form-control" name="user_level" id="user_level">
				<option value="0">---Choisir mon niveau---</option>
				<option value="A0">A0 - D&eacute;butant</option>
				<option value="A1">A1 - Faux-d&eacute;butant</option>
				<option value="A2">A2 - Scolaire</option>
				<option value="B1">B1 - Interm&eacute;diaire</option>
				<option value="B2">B2 - Confirm&eacute;</option>
				<option value="C1">C1 - Ma&icirc;trise</option>
				<option value="C2">C2 - Avez-vous besoin de nous ?</option>
			</select>
				
			</div>
			
		</div>
	</cfform>


















<cfelseif show_info eq "techno">

	<cfset get_tps = obj_tp_get.oget_tps(u_id="411",st_id="1")>

	<p align="center" style="font-size:18px">
	<cfif SESSION.LANG_CODE eq "fr">
	Félicitations, toutes les étapes de lancement se sont déroulées correctement.
	<cfelseif SESSION.LANG_CODE eq "de">

	<cfelseif SESSION.LANG_CODE eq "en">

	<cfelseif SESSION.LANG_CODE eq "es">

	<cfelseif SESSION.LANG_CODE eq "it">

	</cfif>
	</p>

	<cfoutput query="get_tps">
	<cfif method_id eq "3">
		<cfset access_el = "1">
	<cfelseif method_id eq "2">
		<cfset access_f2f = "1">
	<cfelseif method_id eq "1">
		<cfset access_visio = "1">
	</cfif>
	</cfoutput>

	<cfif isdefined("access_visio")>

	<br>
	<div class="media">
	<img src="./assets/img/adobeconnect.png" class="mr-3" width="90">

	<div class="media-body">
	<h6>Votre abonnement VISIO avec Adobe Connect</h6>
	Afin de suivre votre formation dans les meilleures conditions, nous utiliserons un outil de classe virtuelle mondialement reconnu. Afin de s'assurer que tout les aspect techniques fonctionnent, les formateurs peuvent également vous joindre par téléphone lors des premiers échanges.

	</div>
	</div>
	<br><br>
	<div class="card-deck">
		<div class="card border">
			<div class="card-body p-3 d-flex flex-column">
						
				<div align="center">
					<h5 class="d-inline"><i class="fal fa-rabbit-fast fa-lg"></i> Version light</h5><br>
				</div>
							
				<p class="mt-3">
				Vous n'avez rien à installer ! Les cours se déroulent directement dans votre navigateur (Chrome, Safari, Firefox, Edge...)
				<br><br>
				Vous pouvez tester et découvrir notre classe virtuelle en cliquant sur le lien ci-dessous.
				<br><br>
				<small>Veuillez vous connecter en "Guest" et entrer l'identifant de votre choix. Vous accéderez à une classe virtuelle de démonstration.</small>
				</p>
							
				<div class="m-2 p-2 mt-auto" align="center">

					<a href="https://meet28852663.adobeconnect.com/testroom/" target="_blank" role="button" class="btn btn-sm btn-info"><i class="far fa-edit"></i> Tester mon matériel</a>
					
				</div>
				
			</div>
		</div>
		
		
		<div class="card border">
			<div class="card-body p-3 d-flex flex-column">
						
				<div align="center">
					<h5 class="d-inline"><i class="fal fa-box-full fa-lg"></i> Version complète</h5><br>
				</div>
							
				<p class="mt-3">
				Vous installez sur votre ordinateur l'application Adobe Connect (rien de compliqué rassurez-vous...)
				<br><br>
				Lors de vos cours, vous bénéficiez d'une expérience optimale en terme d'interactivité, de fiabilité et de rapidité de connexion. Vous pouvez télécharger l'application en cliquant sur le lien suivant.
				</p>
							
				<div class="m-2 p-2 mt-auto" align="center">

					<a href="#" role="button" class="btn btn-sm btn-info"><i class="fas fa-download"></i> Télécharger l'application</a>
					
				</div>
				
			</div>
				
		</div>

	</div>


	<div class="mt-2" align="center">

		<a href="#" role="button" class="btn btn-success"><i class="far fa-calendar-alt"></i> Je réserve mon premier cours</a>
		
	</div>


	</cfif>

	<cfif isdefined("access_el")>
	<h6>VOTRE ABONNEMENT E-LEARNING</h6>
	</cfif>

	<cfif isdefined("access_f2f")>

	</cfif>


<cfelseif show_info eq "tp_trainer">

<div class="mt-2" align="center">

<p>
Quod opera consulta cogitabatur astute, ut hoc insidiarum genere Galli periret avunculus, ne eum ut praepotens acueret in fiduciam exitiosa coeptantem. verum navata est opera diligens hocque dilato Eusebius praepositus cubiculi missus est Cabillona aurum secum perferens, quo per turbulentos seditionum concitores occultius distributo et tumor consenuit militum et salus est in tuto locata praefecti. deinde cibo abunde perlato castra die praedicto sunt mota.
</p>
<p>
Exsistit autem hoc loco quaedam quaestio subdifficilis, num quando amici novi, digni amicitia, veteribus sint anteponendi, ut equis vetulis teneros anteponere solemus. Indigna homine dubitatio! Non enim debent esse amicitiarum sicut aliarum rerum satietates; veterrima quaeque, ut ea vina, quae vetustatem ferunt, esse debet suavissima; verumque illud est, quod dicitur, multos modios salis simul edendos esse, ut amicitiae munus expletum sit.
</p>

	<a href="learner_launch_3.cfm" role="button" class="btn btn-success"><i class="far fa-calendar-alt"></i> Je valide l'étape "Mon parcours"</a>
	
</div>

<cfelseif show_info eq "tp_explain">

<h4 class="mt-1"><small>Pour la création de votre parcours de formation, voici nos options :</small></h4>

<div class="row">
	<div class="col-lg-4 col-sm-12">
		<div class="card border border-info h-75">
			<div class="card-body p-3 d-flex flex-column">
			
				<div align="center">
					<h5 class="d-inline text-info"><i class="fal fa-books fa-lg text-info"></i> Parcours pré-construit</h5><br>
				</div>
							
				<p class="mt-4 mb-4">Fort de son expérience, WEFIT a développé des parcours pré-conçus, rien que pour vous!</p>
				
				<div class="m-2 p-2 mt-auto" align="center">
				<h5 style="font-size:18px"><i class="fal fa-clock"></i> 2 minutes</h5>
				<a href="learner_launch_2.cfm?tp_choice=prefilled" role="button" class="btn btn-sm btn-info" <!----data-dismiss="modal"--->><i class="fas fa-arrow-right"></i> C'est parti !</a>
				</div>
				
			</div>
		</div>
		<p class="text-center text-muted">
		<strong><em>Recommandé pour les apprenants ayant une idée globale de leur programme</em></strong>
		</p>
	</div>
	<div class="col-lg-4 col-sm-12">
		<div class="card border border-warning h-75">
			<div class="card-body p-3 d-flex flex-column">
				<div align="center">
					<h5 class="d-inline text-warning"><i class="fal fa-pencil-ruler fa-lg text-warning"></i> Parcours sur-mesure</h5><br>
				</div>
							
				<p class="mt-4 mb-4">J'accède à la bibliothèque de cours et je construis et/ou complète moi-même mon parcours.</p>
														
				<div class="m-2 p-2 mt-auto" align="center">
				<h5 style="font-size:18px"><i class="fal fa-clock"></i> 10 minutes</h5>
				<a href="#collapse_info" role="button" role="button" class="btn btn-sm btn-warning" data-toggle="collapse"><i class="fas fa-arrow-right"></i> C'est parti !</a>
				</div>
				
			</div>
		</div>
		<p class="text-center text-muted">
		<strong><em>Recommandé pour les apprenants souhaitant maîtriser les paramètres de leur parcours (choix/alternance des cours, durée...)</em></strong>
		</p>
	</div>
	<div class="col-lg-4 col-sm-12">
		<div class="card border border-success h-75">
			<div class="card-body p-3 d-flex flex-column">
			
				<div align="center">
					<h5 class="d-inline text-success"><i class="fal fa-hands-helping fa-lg text-success"></i> Parcours collaboratif</h5><br>
				</div>
					
						
				<p class="mt-4 mb-4">J'attends le premier cours avec mon formateur et nous construisons ensemble mon parcours de formation.</p>
					
				<div class="m-2 p-2 mt-auto" align="center">
				<h5 style="font-size:18px"><i class="fal fa-clock"></i> 0 minute</h5>
				<a href="learner_launch_2.cfm?choice=" role="button" class="btn btn-sm btn-success btn_accept_trainer" <!----data-dismiss="modal"---->><i class="fas fa-arrow-right"></i>  C'est parti !</a>
				</div>
					
				
			</div>
		</div>
		<p class="text-center text-muted">
		<strong><em>Recommandé pour les apprenants souhaitant impliquer davantage leur formateur dans la construction de leur parcours</em></strong>
		</p>
	</div>
</div>

<div class="collapse" id="collapse_info">
	<h4><small>Comment choisir ma durée de cours ?</small></h4>

	<p>
	Pour une formation classique, nous préconisons des cours de 45min à 1h. Il s'agit du meilleur compromis 
	</p>

	<h4><small>Il y a beaucoup de ressources, comment les choisir ?</small></h4>

	<p>
	<strong>Cours structuré</strong>
	<br>
	<strong>Open lesson</strong>
	<br>
	<strong>Workshop</strong>

	<br>
	Les ressources sont proposées en fonction de votre niveau (renseigné précedemment par vos soins ou lors du passage de votre test d'évaluation).
	<br>
	Vous avez la possibilité de choisir des ressources basées bla bla
	</p>
	
	<a href="learner_launch_2.cfm?tp_choice=solo" role="button" class="btn btn-sm btn-warning" <!---data-dismiss="modal"--->><i class="fas fa-arrow-right"></i> Je suis chaud !</a>
	
</div>

<cfelseif show_info eq "tp_remaining">

<h4 class="mt-1"><small>Pour la création de votre parcours de formation, voici nos options :</small></h4>


</cfif>