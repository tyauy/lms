<!DOCTYPE html>

<cfparam name="a_company" default="">
<cfparam name="a_address" default="">
<cfparam name="a_zipcode" default="">
<cfparam name="a_city" default="">
<cfparam name="a_country" default="">
<cfparam name="a_ctc" default="">
<cfparam name="f_learner" default="1">
<cfparam name="f_package" default="en_20">
<cfparam name="f_firstname_1" default="">
<cfparam name="f_lastname_1" default="">
<cfparam name="f_certif" default="1">
<!---<cfparam name="a_company" default="">
<cfparam name="a_address" default="">
<cfparam name="a_zipcode" default="">
<cfparam name="a_city" default="">
<cfparam name="a_country" default="">
<cfparam name="a_ctc" default="">--->

<cfif isdefined("lg")>
	<cfif lg eq "de">
		<cfset SESSION.LANG = "3">
		<cfset lang_doc = "de">
	<cfelseif lg eq "en">
		<cfset SESSION.LANG = "2">
		<cfset lang_doc = "en">
	<cfelseif lg eq "fr">
		<cfset SESSION.LANG = "1">
		<cfset lang_doc = "fr">
	</cfif>
<cfelse>
	<cfif find("de",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "3">
		<cfset lang_doc = "de">
	<cfelseif find("fr",CGI.HTTP_ACCEPT_LANGUAGE)>
		<cfset SESSION.LANG = "1">
		<cfset lang_doc = "fr">
	<cfelse>
		<cfset SESSION.LANG = "2">
		<cfset lang_doc = "en">
	</cfif>
</cfif>

<cfoutput><html lang="#lang_doc#"></cfoutput>

<head>
	<cfif not isdefined("SESSION.USER_ID")>
		<cfinclude template="./incl/incl_head_light.cfm">
		<style type="text/css">
		.card {
			border-radius: 2px !important;
			box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
		}
		</style>
	<cfelse>
		<cfinclude template="./incl/incl_head.cfm">
	</cfif>
</head>

<body>


<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">

		<cfset title_page = "Notre offre WE BOOST">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
	  <cfif isdefined("k") AND isdefined("n_id")>
	  
		<cfoutput>
		<div class="alert alert-success" role="alert" align="center">
		Votre devis a correctement &eacute;t&eacute; g&eacute;n&eacute;r&eacute;, vous pouvez le t&eacute;l&eacute;charger et finaliser votre demande de prise en charge.
		<br>
		Merci pour votre confiance.
		<br>
		<a class="btn btn-secondary" href="./admin/temp/DEVIS_#n_id#_#dateformat(now(),'yyyymmdd')#.pdf" target="_blank">T&eacute;l&eacute;charger votre devis</a>
		
		</div>
		</cfoutput>
				
	  </cfif>
			<div class="row">
				<div class="col-md-6 offset-md-1">
				
					<div class="card border-top border-success">
						<div class="card-body">	
							<h5 align="center">Formation linguistique prise en charge &agrave; jusqu'à 100%<br>avec le FNE-Formation (Fonds National de l'Emploi)</h5>
							<div align="center">
							Vous avez s&ucirc;rement entendu parler du dispositif la formation rembours&eacute;e &agrave; 100% pour tous les salari&eacute;s en ch&ocirc;mage partiel mis en place par la DIRECCTE.
							<br>
							<strong>L&rsquo;&Eacute;tat prend en charge jusqu'à 100 % des co&ucirc;ts p&eacute;dagogiques sans plafond horaire</strong>
							<br>
							</div>
							
							<div align="center">
							<h4 class="text-dark font-weight-bold">WEFIT,<br>FORMATION VISIO PREMIUM EN LANGUES &Eacute;TRANG&Egrave;RES</h6>
							<img src="./assets/img/visu_wefit.jpg" align="center" width="400">
							<br>
							<h6 class="text-success font-weight-bold">NOTRE MISSION : CR&Eacute;ER LA FORMATION QUI VOUS &ldquo;FIT&rdquo;</h6>
							<br>
							</div>
						<div class="row justify-content-md-center">
							 <div class="col-md-6">
								<div class="alert alert-success" align="center">
								<strong>Offre WE BOOST : 20/30/40h de formation </strong>
								<br>
								Une formation 100% VISIO<br>avec un large choix de formateurs
								<br>
								<strong>Nous contacter :
								<br><span style="font-size:16px">01 83 62 32 45</span></strong>
								</div>
							</div>
						</div>
						
						</div>
					</div>
					
					<div class="card border-top border-info">
						<div class="card-body">	
							<h5 align="center">Comment effectuer la demande de prise en charge</h5>

									
							<h4 class="d-inline"><span class="badge badge-pill badge-primary">1</span></h4> <h6 class="d-inline">T&eacute;l&eacute;charger et remplir une demande simplifi&eacute;e</h6>
							<p>Un document simplifi&eacute; est &agrave; remplir par vos soins avant d'&ecirc;tre transmis &agrave; la DIRECCTE, il est disponible ici : <a href="./admin/attach/demande_simplifiee_fne_formation.docx" target="_blank">[t&eacute;l&eacute;charger la convention simplifi&eacute;e]</a></p>


							<div class="clearfix mt-2"></div>
							
							<h4 class="d-inline"><span class="badge badge-pill badge-primary">2</span></h4> <h6 class="d-inline">Faire signer une attestation par l'apprenant</h6>
							<p>Une attestation d'acceptation de formation pendant la p&eacute;riode de ch&ocirc;mage est &agrave; remplir par le/la salari&eacute;(e)  : <a href="./admin/attach/attestation_salarie.docx" target="_blank">[t&eacute;l&eacute;charger le mod&egrave;le d'attestation]</a></p>

							
							<h4 class="d-inline"><span class="badge badge-pill badge-primary">3</span></h4> <h6 class="d-inline">Joindre un devis de formation et un programme &agrave; votre dossier</h6>
							<p>
							Vous pouvez obtenir directement votre devis en remplissant le formulaire ci-dessous. Une fois &eacute;dit&eacute;, vous aurez la possibilit&eacute; de le signer en ligne.
							<cfform action="_fne_subscribe_work.cfm" onsubmit="return check_form()" method="post">
							<cfoutput>
							<div class="bg-light p-2">
								<h6>Coordonn&eacute;es</h6>
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">Soci&eacute;t&eacute;*</label>
									<div class="col-sm-9">
										<input class="form-control" type="text" name="a_company" value="#a_company#" placeholder="Soci&eacute;t&eacute;" required="yes">
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Adresse*</label>
									<div class="col-sm-9">
									<input class="form-control" type="text" name="a_address" value="#a_address#" placeholder="Adresse" required="yes">
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">CP / Ville / Pays*</label>
									<div class="col-sm-2">
									<input class="form-control" type="text" name="a_zipcode" value="#a_zipcode#" placeholder="Code Postal" required="yes">
									</div>
									<div class="col-sm-4">
									<input class="form-control" type="text" name="a_city" value="#a_city#" placeholder="Ville" required="yes">
									</div>
									<div class="col-sm-3">
									<input class="form-control" type="text" name="a_country" value="#a_country#" placeholder="Pays" required="yes">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-3 col-form-label">Donneur d'ordre*</label>
									<div class="col-sm-9">
									<input class="form-control" type="text" name="a_ctc" value="#a_ctc#" placeholder="Pr&eacute;nom Nom" required="yes">
									</div>
								</div>
								<h6 class="mt-3">Formation</h6>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Langue*</label>
									<div class="col-sm-9">
										<select name="f_package" class="form-control">
											<option value="en_20" <cfif f_package eq "en_20">selected</cfif>>20h Visio - ANGLAIS [eLearning Essential Inclus]</option>
											<option value="en_30" <cfif f_package eq "en_30">selected</cfif>>30h Visio - ANGLAIS [eLearning Essential Inclus]</option>
											<option value="en_40" <cfif f_package eq "en_40">selected</cfif>>40h Visio - ANGLAIS [eLearning Essential Inclus]</option>
											<option value="de_20" <cfif f_package eq "de_20">selected</cfif>>20h Visio - ALLEMAND [e-Learning Essential Inclus]</option>
											<option value="de_30" <cfif f_package eq "de_30">selected</cfif>>30h Visio - ALLEMAND [e-Learning Essential Inclus]</option>
											<option value="de_40" <cfif f_package eq "de_40">selected</cfif>>40h Visio - ALLEMAND [e-Learning Essential Inclus]</option>
											<option value="es_20" <cfif f_package eq "es_20">selected</cfif>>20h Visio - ESPAGNOL</option>
											<option value="es_30" <cfif f_package eq "es_30">selected</cfif>>30h Visio - ESPAGNOL</option>
											<option value="es_40" <cfif f_package eq "es_40">selected</cfif>>40h Visio - ESPAGNOL</option>
											<option value="it_20" <cfif f_package eq "it_20">selected</cfif>>20h Visio - ITALIEN</option>
											<option value="it_30" <cfif f_package eq "it_30">selected</cfif>>30h Visio - ITALIEN</option>
											<option value="it_40" <cfif f_package eq "it_40">selected</cfif>>40h Visio - ITALIEN</option>
											<option value="fr_20" <cfif f_package eq "fr_20">selected</cfif>>20h Visio - FRAN&Ccedil;AIS (FLE)</option>
											<option value="fr_30" <cfif f_package eq "fr_30">selected</cfif>>30h Visio - FRAN&Ccedil;AIS (FLE)</option>
											<option value="fr_40" <cfif f_package eq "fr_40">selected</cfif>>40h Visio - FRAN&Ccedil;AIS (FLE)</option>
										</select>
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Certification*</label>
									<div class="col-sm-9">
										<label><input type="radio" name="f_certif" value="0" <cfif f_certif eq "0">checked</cfif>> Aucune certification</label>
										<br>
										<label><input type="radio" name="f_certif" value="1" <cfif f_certif eq "1">checked</cfif>> Certification LINGUASKILL ou BRIGHT</label>
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Nombre d'apprenants*</label>
									<div class="col-sm-2">
										<input type="number" min="1" max="20" name="f_learner" id="f_learner" value="#f_learner#" class="form-control" required="yes" validate="integer">
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Début de formation</label>
									<div class="col-sm-9">
									<div class="controls controls-sm">
										<div class="input-group">
											<cfset dateform = dateformat(dateadd('d',7,now()),'dd/mm/yyyy')>
											<input id="f_date_start" name="f_date_start" type="text" class="datepicker form-control" value="#dateform#" />
											<label for="f_date_start" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
										</div>
									</div>
									</div>
								</div>
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Fin de formation</label>
									<div class="col-sm-9">
									<div class="controls controls-sm">
										<div class="input-group">
											<cfset dateto = dateformat(dateadd('m',3,dateform),'dd/mm/yyyy')>
											<input id="f_date_end" name="f_date_end" type="text" class="datepicker form-control" value="#dateto#" />
											<label for="f_date_end" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
										</div>
									</div>
									</div>
								</div>
								<div id="container_learners">
								<cfloop from="1" to="#f_learner#" index="cor">
								<div id="container_learner_#cor#">
								<div class="form-group row mt-1">
									<label class="col-sm-3 col-form-label">Apprenant #cor#</label>
									<div class="col-sm-4">
									<input class="form-control" type="text" name="f_lastname_#cor#" value="#evaluate('f_lastname_#cor#')#" placeholder="Nom #cor#" required="yes">
									</div>
									<div class="col-sm-4">
									<input class="form-control" type="text" name="f_firstname_#cor#" value="#evaluate('f_firstname_#cor#')#" placeholder="Pr&eacute;nom #cor#" required="yes">
									</div>
								</div>
								</div>
								</cfloop>
								</div>
								<cfif isdefined("tracker") AND tracker eq "34D1F91FB2E514B8576FAB1A75A89A6B">
								<input type="hidden" name="tracker" value="#tracker#">
								</cfif>
								<div align="center"><input type="submit" value="G&eacute;n&eacute;rer devis" class="btn btn-info"></div>
							</div>
							
							
							

							<div class="clearfix mt-2"></div>
							<h4 class="d-inline"><span class="badge badge-pill badge-success">4</span></h4> <h6 class="d-inline">Envoyer le dossier</h6>
							<p>Transmettez le dossier &agrave; la DIRECCTE ou &agrave; l'OPCO dont vous d&eacute;pendez (consultez le tableau ci-contre pour savoir &agrave; qui adresser le dossier de demande de formation)</p>

							</cfoutput>
							</cfform>


									
						</div>
					</div>
					
				</div>
			
				<div class="col-md-4">
					<div class="card border-top border-warning">
						<div class="card-body">	
							<h5 align="center">Le FNE par r&eacute;gion</h5>
							<table class="table table-sm" style="font-size:12px">
							<tr>
							<th>R&Eacute;GION</th>
							<th>VOIR</th>
							<th>CONTACTER</th>
							</tr>
							<tr>
								<td>IDF</td>
								<td><a href="http://idf.direccte.gouv.fr/COVID-19-mobilisation-du-FNE-Formation-pour-les-salaries-en-activite-partielle" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>HAUTS DE FRANCE</td>
								<td><a href="http://hauts-de-france.direccte.gouv.fr/Coronavirus-COVID-19-mobilisation-du-FNE-Formation-pour-les-salaries-en" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>NOUVELLE AQUITAINE</td>
								<td><a href="http://nouvelle-aquitaine.direccte.gouv.fr/Salarie-en-activite-partielle-Vous-pouvez-beneficier-une-formation-gratuite" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>PAYS DE LA LOIRE</td>
								<td><a href="http://pays-de-la-loire.direccte.gouv.fr/COVID-19-Aide-a-la-formation-des-salaries-en-periode-de-chomage-partiel" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>OCCITANIE</td>
								<td><a href="http://occitanie.direccte.gouv.fr/Crise-Covid-19-l-Etat-encourage-les-formations-pour-les-salaries-en-activite" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>CORSE</td>
								<td><a href="http://corse.direccte.gouv.fr/Salaries-en-activite-partielle-beneficier-d-une-formation" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>NORMANDIE</td>
								<td><a href="http://normandie.direccte.gouv.fr/Coronavirus-mobilisation-du-FNE-Formation-pour-les-salaries-en-activite" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>BRETAGNE</td>
								<td><a href="http://bretagne.direccte.gouv.fr/Coronavirus-l-Etat-encourage-les-formations-pour-les-salaries-en-activite" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>GRAND EST</td>
								<td><a href="http://grand-est.direccte.gouv.fr/Offre-RH-faites-vous-accompagner" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>BOURGOGNE FRANCHE COMT&Eacute;</td>
								<td><a href="http://bourgogne-franche-comte.direccte.gouv.fr/Aide-a-la-formation-des-salaries-pendant-les-periodes-d-activite-partielle" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>PROVENCE ALPES COTES D'AZUR</td>
								<td><a href="http://paca.direccte.gouv.fr/Covid-19-le-dispositif-FNE-Formation-est-renforce-pour-soutenir-les-entreprises" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>AUVERGNE RHONES ALPES</td>
								<td><a href="http://auvergne-rhone-alpes.direccte.gouv.fr/FNE-FORMATION-Modalites-exceptionnelles-de-mise-en-oeuvre-18779" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>
							<tr>
								<td>CENTRE VAL DE LOIRE</td>
								<td><a href="http://centre-val-de-loire.direccte.gouv.fr/COVID-19-mobilisation-du-FNE-Formation-pour-les-salaries-en-activite-partielle" target="_blank">Voir les modalit&eacute;s</a></td>
								<td>OPCO / DIRECCTE</td>
							</tr>

							</table>

						<small>
						<strong>DIRECCTE :</strong>
						Pour b&eacute;n&eacute;ficier de ce dispositif, les entreprises doivent &eacute;tablir la liste nominative des personnes plac&eacute;es en activit&eacute; partielle et suivant les formations (apr&egrave;s accord &eacute;crit de ces derniers), et se rapprocher de leur Direccte pour &eacute;tablir une convention simplifi&eacute;e qui permettra cette prise en charge.
						<br>
						<strong>OPCO :</strong>
						Pour certaines r&eacute;gions, les dossiers de demande de subvention FNE-Formation sont &agrave; adresser aux op&eacute;rateurs de comp&eacute;tences (OPCO).
						Par cons&eacute;quent, le FNE-Formation ne fera pas l&rsquo;objet d&rsquo;une convention conclue entre la Direccte et une entreprise (par exemple en Ile de France). L&rsquo;entreprise pourra le mettre en &oelig;uvre apr&egrave;s notification de prise en charge par l&rsquo;OPCO. 
						</small>

						</div>
					</div>
					
					<div class="card border-top border-warning">
						<div class="card-body">	
							<h5 align="center">Autres documents utiles</h5>
							Questions / R&eacute;ponses sur le FNE : <a href="./admin/attach/faq_fne_formation.pdf" target="_blank">[T&eacute;l&eacute;charger]</a>
							<br>
							Coordonn&eacute;es DIRECCTE : <a href="./admin/attach/coordonnees_DIRECCTE.pdf" target="_blank">[T&eacute;l&eacute;charger]</a>
							<br>
							Trouver son OPCO : <a href="https://travail-emploi.gouv.fr/ministere/acteurs/partenaires/opco" target="_blank">[Consulter]</a>
							<br>
							
						</div>
					</div>
				</div>
			</div>
	
		</div>
		
		
		
	
	
	
		<footer class="footer footer-black footer-white ">
			<div class="container-fluid">
				<div class="row">
					<nav class="footer-nav">
						<ul>
							<li>
							<a href="https://www.wefitgroup.com" target="_blank">SUPPORT WEFIT</a>
							</li>
						</ul>
					</nav>
					<div class="credits ml-auto">
						<span class="copyright">
						<!---<img src="./sources/<cfoutput>#SESSION.MASTER_ID#</cfoutput>/img/logo_wefit_1line.png" height="25" style="margin-top:2px">--->
						&copy;
						<script>
						<cfoutput>#year(now())#</cfoutput>
						</script> / WEFIT
						</span>
					</div>
				</div>
			</div>
		</footer>


	</div>
	
</div>



</body>

<cfif not isdefined("SESSION.USER_ID")>
	<cfinclude template="./incl/incl_scripts_light.cfm">
<cfelse>
	<cfinclude template="./incl/incl_scripts.cfm">
</cfif>


<script>
$(function() {
	
	var nb_learner = <cfoutput>#f_learner#</cfoutput>;
	$("#f_learner").change(function() {

		nb_learner = parseInt($(this).val());
		if(nb_learner >= 20)
		{
		nb_learner = "20";
		$(this).val("20");
		}
		var max_value = nb_learner+1;
		//alert(max_value);
		
		for (var i=1; i<=nb_learner; i++) {
		
			if (!$("#container_learner_"+i).length) {
				var to_create = "<div id='container_learner_"+i+"'>";
				to_create = to_create+"<div class='form-group row'>";
				to_create = to_create+"<label class='col-sm-3 col-form-label'>Apprenant "+i+"</label>";
				to_create = to_create+"<div class='col-sm-4'>";
				to_create = to_create+"<input class='form-control' type='text' name='f_lastname_"+i+"' value='' placeholder='Nom "+i+"' required='yes'>";	
				to_create = to_create+"</div>";
				to_create = to_create+"<div class='col-sm-4'>";
				to_create = to_create+"<input class='form-control' type='text' name='f_firstname_"+i+"' value='' placeholder='Pr&eacute;nom "+i+"' required='yes'>";
				to_create = to_create+"</div>";
				to_create = to_create+"</div>";
				to_create = to_create+"</div>";
				$("#container_learners").append(to_create);
				}
			}
			
		for (var j=max_value; j<=20; j++) {
			console.log(j);
			$("#container_learner_"+j).remove();
		
		}

	});
	
	$("#f_date_start").datepicker({
		weekStart: 1,
		minDate:0,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {
			$("#f_date_end").datepicker( "option", "minDate", selectedDate );			
			$("#f_date_end").datepicker("setDate", "+30" );			
			f_date_start = $('#f_date_start').datepicker("getDate");
			f_date_start = moment(f_date_start).format('YYYY-MM-DD');
		}		
	})

	
	$("#f_date_end").datepicker({
	  defaultDate: "+1w",
	  changeMonth: true,
	  dateFormat:"dd/mm/yy",
	  numberOfMonths: 1
	});
	
	

	
})
</script>

</html>