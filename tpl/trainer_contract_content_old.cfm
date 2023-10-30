<cfparam name="t_vrate" default="20">
<cfparam name="t_frate" default="25">
<cfparam name="t_company" default="JP LABASE INC.">
<cfparam name="t_address" default="15 Rue des Lilas">
<cfparam name="t_postal" default="33000">
<cfparam name="t_city" default="BORDEAUX">
<cfparam name="t_country" default="FRANCE">
<cfparam name="t_siret" default="123456789">
<cfparam name="t_firstname" default="Jean Pierre">
<cfparam name="t_lastname" default="LABASE">
<cfparam name="t_domain" default="ENGLISH">
<cfparam name="t_bonus" default="YES">
<cfparam name="t_nbh" default="YES">

<cfif t_vrate neq ""><cfset t_vrate = ReplaceNoCase(t_vrate,",",".","ALL")></cfif>
<cfif t_frate neq ""><cfset t_frate = ReplaceNoCase(t_frate,",",".","ALL")></cfif>


<cfset list_domain = "">
-
<cfif findnocase("english", t_domain)><cfset list_domain = listappend(list_domain," ANGLAIS ","/")></cfif>
<cfif findnocase("spanish", t_domain)><cfset list_domain = listappend(list_domain," ESPAGNOL ","/")> </cfif>
<cfif findnocase("italian", t_domain)><cfset list_domain = listappend(list_domain," ITALIEN ","/")> </cfif>
<cfif findnocase("german", t_domain)><cfset list_domain = listappend(list_domain," ALLEMAND ","/")> </cfif>
<cfif findnocase("greek", t_domain)><cfset list_domain = listappend(list_domain," GREC ","/")> </cfif>
<cfif findnocase("dutch", t_domain)><cfset list_domain = listappend(list_domain," N&Eacute;ERLANDAIS ","/")> </cfif>
<cfif findnocase("portuguese", t_domain)><cfset list_domain = listappend(list_domain," PORTUGUAIS ","/")> </cfif>
<cfif findnocase("FLE", t_domain)><cfset list_domain = listappend(list_domain," FRAN&Ccedil;AIS LANGUE &Eacute;TRANG&Egrave;RE ","/")> </cfif>
<cfif findnocase("bureautique", t_domain)><cfset list_domain = listappend(list_domain," BUREAUTIQUE ","/")> </cfif>
<cfif findnocase("translation", t_domain)><cfset list_domain = listappend(list_domain," TRADUCTION ","/")> </cfif>
<cfif findnocase("norwegian", t_domain)><cfset list_domain = listappend(list_domain," NORV&Eacute;GIEN ","/")> </cfif>


<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2>CONTRAT DE PRESTATIONS DE SERVICE EN FORMATION PROFESSIONNELLE</h2>					
						<h2 style="color:#1a0dab">SERVICES CONTRACT</h2>
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
						<h3>ENTRE LES SOUSSIGN&Eacute;S</h3>
						<h3 style="color:#1a0dab">BETWEEN THE UNDERSIGNED</h3>
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
Soci&eacute;t&eacute; immatricul&eacute;e sous le num&eacute;ro de Siret 510 689 649 00034 au RCS de Paris.<br><br>
Repr&eacute;sent&eacute;e par Monsieur Vincent GEST en qualit&eacute; de Pr&eacute;sident.<br>
D&eacute;claration d'activit&eacute; enregistr&eacute;e sous le num&eacute;ro 11 75 46556 75 aupr&egrave;s du Pr&eacute;fet de R&eacute;gion d'&Icirc;le de France.<br>
<br><br>
ci-apr&egrave;s d&eacute;nomm&eacute;e : <strong>WEFIT ou l'OF</strong>
<br>
<span style="color:#1a0dab">below : <strong>WEFIT</strong></span>

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
						<h3>ET</h3>
						<h3 style="color:#1a0dab">AND</h3>
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
<cfoutput>
<strong>#t_company#</strong>
<br>
#t_address#<br>
#t_postal# - #t_city#<br>
#t_country#<br><br>
N&deg; SIRET : #t_siret#<br>
Repr&eacute;sent&eacute;e par #t_firstname# #t_lastname#, dûment habilit&eacute;
<br>
</cfoutput>
<br><br>
ci-apr&egrave;s d&eacute;nomm&eacute;e : <strong>L'INTERVENANT ou LE FORMATEUR</strong>
<br>
<span style="color:#1a0dab">below : <strong>THE TRAINER</strong></span>




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
						WEFIT et l&rsquo;&laquo;Intervenant&raquo; sont &eacute;galement d&eacute;nomm&eacute;s ensemble &laquo; les Parties &raquo;.
						<br>
						<span style="color:#1a0dab">xxx </span>
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
						<h3>IL A &Eacute;T&Eacute; PR&Eacute;ALABLEMENT EXPOS&Eacute; CE QUI SUIT :</h3>
						<h3 style="color:#1a0dab">xxxxx :</h3>
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

WEFIT est un organisme de formation priv&eacute;. Dans le souci de consolider son niveau d'excellence, il doit recourir aux services de formateurs ext&eacute;rieurs de niveau de qualification reconnu.<br>
L'Intervenant a acquis une exp&eacute;rience sp&eacute;cifique dans la formation linguistique et propose des services en ce domaine &agrave; une client&egrave;le compos&eacute;e notamment d'entreprise, OF, d'&eacute;coles ou encore de particuliers.
L'Intervenant rappelle qu'il exerce une activit&eacute; professionnelle principale en dehors de L'OF.<br>
Le pr&eacute;sent contrat a &eacute;t&eacute; conclu en raison de la sp&eacute;cificit&eacute; de la prestation, objet du pr&eacute;sent contrat (ci-apr&egrave;s le &amp;laquo; Contrat &amp;raquo;), et en raison de l'exp&eacute;rience particuli&egrave;re et du savoir-faire sp&eacute;cifique de L'OF. Il comprend tous les &eacute;ventuels engagements des Parties et annule et remplace toutes correspondances, offres ou proposition ant&eacute;rieure &agrave; la signature des pr&eacute;sentes.
<br>
<span style="color:#1a0dab">
xxxxxx
</span>				
					
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
						<h3>CECI EXPOS&Eacute;, IL A &Eacute;T&Eacute; CONVENU ET ARR&Ecirc;T&Eacute; CE QUI SUIT :</h3>
						<h3 style="color:#1a0dab">xxxxx :</h3>
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

<h3>ARTICLE 1 : OBJET DU CONTRAT</h3> <h3 style="color:#1a0dab">xxxxx :</h3>		
La convention a pour objet de d&eacute;finir les termes et les conditions de r&eacute;alisation, par l'Intervenant, de la prestation de services (ci-apr&egrave;s la &laquo; Prestation &raquo;) au profit de L'OF.
L'Intervenant s'engage &agrave; fournir &agrave; L'OF une prestation d'enseignement, fond&eacute; sur le partage de son exp&eacute;rience, dont le contenu est le suivant :
• &Eacute;laboration et dispense d'un Enseignement de qualit&eacute; dans la formation linguistique - <cfoutput>#list_domain#</cfoutput>
L'Intervenant aura la charge de l'&eacute;laboration des programmes d'enseignement.
Le nombre d'heures pr&eacute;visionnel d'Enseignement pour assurer la Prestation convenue entre les Parties a &eacute;t&eacute; estim&eacute;e &agrave; <cfoutput>#t_nbh#</cfoutput> heures/semaine pour la dur&eacute;e du Contrat.
Les jours et heures d'intervention seront d&eacute;finis, apr&egrave;s proposition de l'Intervenant, par accord entre l'Intervenant et L'OF (&eacute;laboration d'un calendrier).
<span style="color:#1a0dab">
xxxxxx
</span>				
					
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

					
&Eacute;tant entendu la d&eacute;finition des termes g&eacute;n&eacute;riques suivants :<br><br>
<strong>&quot;WEFIT&quot;</strong> : terme relatif au contractant WEFIT GROUP SAS qui d&eacute;l&egrave;gue la MISSION<br>
<strong>&quot;FORMATEUR&quot;</strong> : la personne morale cocontractante de droit priv&eacute; &agrave; laquelle est d&eacute;volue la MISSION<br>
<strong>&quot;APPRENANT&quot;</strong> : <br>
<strong>&quot;MISSION&quot;</strong> : objet du contrat tel que d&eacute;fini dans l&rsquo;article 1 du pr&eacute;sent contrat<br>
<strong>&quot;CLIENT&quot;, &quot;CLIENTS&quot;</strong> : tout apprenant li&eacute; contractuellement &agrave; WEFIT par une convention de formation, dont WEFIT confie la formation au FORMATEUR via le pr&eacute;sent contrat<br>
<!---<strong>&quot;SERVICE&quot;</strong> : prestation mentionn&eacute;e dans la convention de formation entre WEFIT et le CLIENT<br>--->
<strong>&quot;LMS&quot;</strong> : Learning Management System ou plateforme d'apprentissage. Il s'agit du logiciel qui g&egrave;re le processus d'apprentissage.<br>
				

					<h3>ARTICLE 1 : OBJET DU CONTRAT</h3>
					<br>

Le pr&eacute;sent contrat de services est valable pour la/les mission(s) de formation suivante(s) :<br><br>
<cfoutput>
<cfif t_vrate neq "">
<cfset list_domain = "">
-
<cfif findnocase("english", t_domain)><cfset list_domain = listappend(list_domain," ANGLAIS ","/")></cfif>
<cfif findnocase("spanish", t_domain)><cfset list_domain = listappend(list_domain," ESPAGNOL ","/")> </cfif>
<cfif findnocase("italian", t_domain)><cfset list_domain = listappend(list_domain," ITALIEN ","/")> </cfif>
<cfif findnocase("german", t_domain)><cfset list_domain = listappend(list_domain," ALLEMAND ","/")> </cfif>
<cfif findnocase("greek", t_domain)><cfset list_domain = listappend(list_domain," GREC ","/")> </cfif>
<cfif findnocase("dutch", t_domain)><cfset list_domain = listappend(list_domain," N&Eacute;ERLANDAIS ","/")> </cfif>
<cfif findnocase("portuguese", t_domain)><cfset list_domain = listappend(list_domain," PORTUGUAIS ","/")> </cfif>
<cfif findnocase("FLE", t_domain)><cfset list_domain = listappend(list_domain," FRAN&Ccedil;AIS LANGUE &Eacute;TRANG&Egrave;RE ","/")> </cfif>
<cfif findnocase("bureautique", t_domain)><cfset list_domain = listappend(list_domain," BUREAUTIQUE ","/")> </cfif>
<cfif findnocase("translation", t_domain)><cfset list_domain = listappend(list_domain," TRADUCTION ","/")> </cfif>
<cfif findnocase("norwegian", t_domain)><cfset list_domain = listappend(list_domain," NORV&Eacute;GIEN ","/")> </cfif>
#list_domain#
/ Visioconf&eacute;rence<br>
</cfif>


<cfif t_frate neq "">
<cfset list_domain = "">
- 
<cfif findnocase("english", t_domain)><cfset list_domain = listappend(list_domain," ANGLAIS ","/")></cfif>
<cfif findnocase("spanish", t_domain)><cfset list_domain = listappend(list_domain," ESPAGNOL ","/")> </cfif>
<cfif findnocase("italian", t_domain)><cfset list_domain = listappend(list_domain," ITALIEN ","/")> </cfif>
<cfif findnocase("german", t_domain)><cfset list_domain = listappend(list_domain," ALLEMAND ","/")> </cfif>
<cfif findnocase("greek", t_domain)><cfset list_domain = listappend(list_domain," GREC ","/")> </cfif>
<cfif findnocase("dutch", t_domain)><cfset list_domain = listappend(list_domain," N&Eacute;ERLANDAIS ","/")> </cfif>
<cfif findnocase("portuguese", t_domain)><cfset list_domain = listappend(list_domain," PORTUGUAIS ","/")> </cfif>
<cfif findnocase("FLE", t_domain)><cfset list_domain = listappend(list_domain," FRAN&Ccedil;AIS LANGUE &Eacute;TRANG&Egrave;RE ","/")> </cfif>
<cfif findnocase("bureautique", t_domain)><cfset list_domain = listappend(list_domain," BUREAUTIQUE ","/")> </cfif>
<cfif findnocase("translation", t_domain)><cfset list_domain = listappend(list_domain," TRADUCTION ","/")> </cfif>
<cfif findnocase("norwegian", t_domain)><cfset list_domain = listappend(list_domain," NORV&Eacute;GIEN ","/")> </cfif>
#list_domain#
/ Pr&eacute;sentiel<br>
</cfif>
</cfoutput>
<br>
<br>
Pour chaque action de formation, le FORMATEUR re&ccedil;oit un email d&eacute;taill&eacute; ou une notification comprenant :
<br><br>
<ul>
<li>La m&eacute;thode, la p&eacute;riode et la dur&eacute;e de la MISSION</li>
<li>Les coordonn&eacute;es de l&rsquo;apprenant(e)</li>
<li>Les besoins de l&rsquo;apprenant(e)</li>
</ul>
<br><br>

					</td>
				</tr>
			</table>
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 2 : OBLIGATIONS DU FORMATEUR & CONDITIONS D'UTILISATION</h3>
					<br>
Le FORMATEUR s'engage sur les points suivants, sous peine d'application d'un malus :
<ul>
<li>Suivre la formation dispens&eacute;e par notre Trainer Manager : respect des valeurs de la soci&eacute;t&eacute;, prise en main du <strong>LMS</strong>, connaissance de l'ensemble des contenus de formation mis &agrave; disposition.</li>
<li>Proposer &agrave; l'apprenant un programme de formation complet, et le mettre &agrave; jour dans le <strong>LMS</strong>.</li>
<li>Fournir sous 24 heures un compte rendu de cours qualitatif (&ldquo;lesson note&rdquo;) pour chaque le&ccedil;on effectu&eacute;e en remplissant le formulaire pr&eacute;vu &agrave; cet effet et/ou t&eacute;l&eacute;charger le fichier dans le <strong>LMS</strong></li>
<li>Veiller au bon d&eacute;roulement de la formation des APPRENANTS : planification r&eacute;guli&egrave;re des cours, ajustement de parcours.</li>
<li>Veiller &agrave; ce que les rapports mensuels soit &agrave; jour avant le 30 ou 31 du mois (v&eacute;rification du statut des cours en &quot;Completed"</li>
<li>Respecter la politique d&rsquo;annulation de WEFIT : 6h en visio-conf&eacute;rence / 48h en face &agrave; face</li>
<cfif t_frate neq "">
<li>Pour les cours en pr&eacute;sentiel, &ecirc;tre en charge de la signature de la feuille d'&eacute;margement par le CLIENT.</li>
</cfif>
</ul>

D'autre part, le FORMATEUR a la possibilit&eacute;  :
<ul>
<li>Utiliser ses propres ressources, &agrave; condition d'en informer WEFIT et &eacute;ventuellement de les fournir au CLIENT sous le logo du groupe WEFIT.</li>
<li>Utiliser, s'il le souhaite, les logiciels ou autre instrument de formation que WEFIT lui fournira pour r&eacute;aliser sa MISSION.</li>
</ul>




					
					</td>
				</tr>
			</table>
			
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 3 : DUR&Eacute;E DU CONTRAT</h3>
					<br>
Le pr&eacute;sent contrat est conclu pour une dur&eacute;e de douze mois, en tacite reconduction.
					</td>
				</tr>
			</table>
			
			
			

			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 4 : PAIEMENT DES HONORAIRES</h3>
					<br>
En contrepartie de sa MISSION, le formateur recevra une r&eacute;mun&eacute;ration horaire fixe par heure de cours. 

<cfif t_vrate neq "">
<br><br>
La r&eacute;mun&eacute;ration horaire pour les heures de formation en visio-conf&eacute;rence est &eacute;gale &agrave; <strong><cfoutput>#numberformat(t_vrate,'____.__')#</cfoutput> &euro; HT</strong>
</cfif>

<cfif t_frate neq "">
<br><br>
La r&eacute;mun&eacute;ration horaire pour les heures de formation en face &agrave; face est &eacute;gale &agrave; <strong><cfoutput>#numberformat(t_frate,'____.__')#</cfoutput> &euro; HT</strong> (incluant de fa&ccedil;on d&eacute;finitive les frais de d&eacute;placement, l'&eacute;laboration et l'envoi des documents li&eacute;s &agrave; la formation - cf. ARTICLE 2)
</cfif>

<br><br>

<cfif t_bonus eq "YES">

<h4>R&eacute;mun&eacute;ration compl&eacute;mentaire</h4>

<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">

	<cfif listfind(t_domain,"anglais")>
	<cfif t_vrate neq "">
	<tr>
		<td bgcolor="#FFFFFF" width="25%">
<strong>NA</strong><br>(Needs Assesment / 1er cours)
		</td>
		<td bgcolor="#FFFFFF">
R&eacute;mun&eacute;ration &agrave; hauteur de 30 minutes au taux horaire en vigueur
<cfif t_frate neq "">Pas de Needs Assesment pour les cours de F2F ni pour les cours hors anglais</cfif>
		</td>
	</tr>
	</cfif>
	</cfif>
	
	<cfif t_vrate neq "">
	<tr>
		<td bgcolor="#FFFFFF">
<strong>PTA</strong><br>(Post Training Assessment - Dernier cours)
		</td>
		<td bgcolor="#FFFFFF">
+ 3 &euro; HT pour chaque fin de parcours de formation<br>
<cfif t_frate neq "">Non applicable pour les cours en face &agrave; face</cfif>
		</td>
	</tr>
	</cfif>
	
	<tr>
		<td bgcolor="#FFFFFF">
<strong>OPS MEETING</strong>
		</td>
		<td bgcolor="#FFFFFF">
R&eacute;mun&eacute;ration au taux horaire en vigueur
		</td>
	</tr>
	
	<tr>
		<td bgcolor="#FFFFFF">
<strong>Bonus formation intensive</strong>
		</td>
		<td bgcolor="#FFFFFF">
+ 100 &euro; HT de bonus lorsque le FORMATEUR r&eacute;alise plus de 80 heures de formation sur un mois
		</td>
	</tr>
	
	<cfif t_vrate neq "">
	<tr>
		<td bgcolor="#FFFFFF">
<strong>Bonus de lancement</strong><br>(unique)
		</td>
		<td bgcolor="#FFFFFF">
+ 100 &euro; HT de bonus lorsque le FORMATEUR r&eacute;alise lors du premier mois l'ensemble des missions pr&eacute;vues, tout en respectant les r&egrave;gles administratives, p&eacute;dagogiques et m&eacute;thodologiques de WEFIT
		</td>
	</tr>	
	</cfif>

	<tr>
		<td bgcolor="#FFFFFF">
<strong>Malus</strong>
		</td>
		<td bgcolor="#FFFFFF">
<cfif t_vrate neq "">- 5 &euro; HT pour cours annul&eacute; hors d&eacute;lai<br></cfif>
<cfif t_frate neq "">- 10 &euro; HT pour cours annul&eacute; hors d&eacute;lai</cfif>
		</td>
	</tr>

</table>
<cfelse>

<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr>
		<td bgcolor="#FFFFFF">
<strong>Malus</strong>
		</td>
		<td bgcolor="#FFFFFF">
<cfif t_vrate neq "">- 5 &euro; HT pour cours annul&eacute; hors d&eacute;lai<br></cfif>
<cfif t_frate neq "">- 10 &euro; HT pour cours annul&eacute; hors d&eacute;lai</cfif>
		</td>
	</tr>

</table>

</cfif>
<br><br>
La r&eacute;mun&eacute;ration du FORMATEUR sera vers&eacute;e au plus tard le 5 du mois, <u>&agrave; condition que les cours soient compl&eacute;t&eacute;s dans le syst&egrave;me LMS le 30 ou 31 du mois en cours</u>.

					</td>
				</tr>
			</table>
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 5 - CLAUSE DE CONFIDENTIALIT&Eacute; :</h3>
					<br>
Les logiciels et m&eacute;thodes de formation que la soci&eacute;t&eacute; WEFIT confie au FORMATEUR sont strictement confidentiels. Ces supports et outils p&eacute;dagogiques constituent le savoir-faire de WEFIT. Ils ne peuvent &ecirc;tre transmis, ni divulgu&eacute;s &agrave; des tiers, ni exploit&eacute;s par le FORMATEUR &agrave; une autre fin que celle de l&rsquo;objet du pr&eacute;sent contrat et d&eacute;fini en son article 1.
					</td>
				</tr>
			</table>
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 6 - PROTECTION DES DONN&Eacute;ES PERSONNELLES :</h3>
					<br>
Pour l&rsquo;accomplissement de sa MISSION, le FORMATEUR peut se voir communiquer par WEFIT des donn&eacute;es personnelles relatives aux CLIENTS, telles que d&eacute;finies dans le r&egrave;glement europ&eacute;en de protection des donn&eacute;es et par la CNIL. 
<br>
Ces donn&eacute;es sont limit&eacute;es au nom, au pr&eacute;nom, &agrave; l&rsquo;email et au num&eacute;ro de t&eacute;l&eacute;phone, et &eacute;ventuellement &agrave; l&rsquo;&acirc;ge et &agrave; la profession du CLIENT, pour des raisons &eacute;videntes d&rsquo;identification et de pr&eacute;paration de cours adapt&eacute; audit CLIENT.
<br>
Le FORMATEUR s&rsquo;engage &agrave; ne jamais divulguer &agrave; quelque tiers que ce soit, d&rsquo;aucune forme que ce soit, aucune des donn&eacute;es personnelles cit&eacute;es, qui n&rsquo;ont &eacute;t&eacute; transmises qu&rsquo;&agrave; seule fin de d&eacute;livrer un meilleur Service.
<br>
En cas de doute ou pour toute question relative &agrave; la protection des donn&eacute;es, le FORMATEUR peut solliciter WEFIT.
					</td>
				</tr>
			</table>
	
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-bottom:30px" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					<h3>ARTICLE 7 - RUPTURE DE CONTRAT & MODALIT&Eacute;S:</h3>
					<br>
Chacune des parties a le droit, sans pr&eacute;judice de tout autre droit ou recours, de r&eacute;silier le pr&eacute;sent contrat de services en respectant un pr&eacute;avis &eacute;crit d'un mois.
<br>
Pendant la p&eacute;riode de pr&eacute;avis, le FORMATEUR s'engage &agrave; respecter le planning de formation conclu avec WEFIT.
<br>
Le pr&eacute;avis de 30 jours n&rsquo;est plus jug&eacute; n&eacute;cessaire en cas de:
<ul>
<li>Violation intentionnelle ou non intentionnelle des politiques, r&egrave;gles et r&eacute;glementations de WEFIT</li>
<li>La divulgation non autoris&eacute;e d'informations confidentielles, qu'elles soient li&eacute;es &agrave; WEFIT ou &agrave; ses CLIENTS;</li>
<li>Commission d'un acte entra&icirc;nant une perte de confiance de la part de WEFIT en ce qui concerne la capacit&eacute; du FORMATEUR &agrave; ex&eacute;cuter la MISSION selon les exigences qualitatives de WEFIT</li>
<li>Mauvaise utilisation ou abus grave des biens, installations et / ou ressources de WEFIT</li>
<li>Participer directement ou indirectement, conclure et / ou conclure des accords commerciaux personnels impliquant les produits et / ou services de WEFIT ou les produits et / ou services de concurrents de WEFIT</li>
<li>Violation intentionnelle ou non intentionnelle ou violation de la confidentialit&eacute; des informations appartenant &agrave; WEFIT</li>
</ul>
<br>
Si le FORMATEUR r&eacute;silie le contrat de service sans respecter le pr&eacute;avis de 30 jours, WEFIT se r&eacute;serve le droit de d&eacute;duire des frais restants &agrave; titre de dommages et int&eacute;r&ecirc;ts un montant de deux cent cinquante euros (250,00 &euro;).
					</td>
				</tr>
			</table>
			
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">

<br>
En cas de conflit sur l&rsquo;interpr&eacute;tation du pr&eacute;sent contrat, les deux parties saisiront un tribunal comp&eacute;tent &agrave; Paris. 
<br><br>
Paris, le <cfoutput>#dateformat(now(),'dd/mm/yyyy')#</cfoutput>

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