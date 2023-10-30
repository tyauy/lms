<!DOCTYPE html>

<cfsilent>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Mon avis sur WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

			<cfif not isdefined("form_eval")>
			<div class="row">
			
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img_material/5e23a6598e60475af69c5f7e5db71e7b.jpg">
						<div class="card-body" style="min-height:300px">
							<div class="row">
								<div class="col-md-12">
									<h4 class="text-center mt-2">&Eacute;valuation &agrave; chaud</h4>
									<p>
									Vous venez de terminer votre parcours de formation avec WEFIT, prenez un instant pour remplir ce questionnaire.
									<br>
									Il nous aidera &agrave; am&eacute;liorer la qualit&eacute; de nos services et d&eacute;velopper de nouvelles ressources et fonctionnalit&eacute;s
									</p>
									<div class="float-right">
										<a href="_AD_learner_opinion.cfm?form_eval=heval" class="btn btn-sm btn-info">Acc&egrave;s formulaire</a>
									</div>
								</div>
							</div>							
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-4 col-sm-6">
					<div class="card">
						<img class="card-img-top" src="./assets/img_material/af496463f696d10d01fb824bca6f4dec.jpg">
						<div class="card-body" style="min-height:300px">
							<div class="row">
								<div class="col-md-12">					
									<h4 class="text-center mt-2">&Eacute;valuation &agrave; froid</h4>
									<p>
									Il y a quelques temps, vous avez suivi un parcours de formation avec WEFIT.<br>
									Pourriez-vous nous dire avec du recul si nous avons r&eacute;pondu &agrave; vos attentes ? Vous &ecirc;tes-vous senti plus comp&eacute;tent dans la langue travaill&eacute;e ? &Ecirc;tes-vous plus &agrave; l'aise personnellement ou professionnellement ?
									</p>
									<div class="float-right">
										<a href="_AD_learner_opinion.cfm?form_eval=ceval" class="btn btn-sm btn-info">Acc&egrave;s formulaire</a>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>		
			
			</div>
			<cfelse>
			<div class="row">
				<div class="col-lg-8 offset-lg-2 col-md-12">
					<div class="card">						
						<div class="card-body">
							<cfif form_eval eq "heval">
							<div class="row">
								<div class="col-md-12">		
									<div class="media">
										<img src="./assets/img_material/5e23a6598e60475af69c5f7e5db71e7b.jpg" class="rounded float-left mr-3" width="220">	
										<div class="media-body">
										<h5 class="mt-0">&Eacute;valuation &agrave; chaud</h5>
										Votre dernier cours a eu lieu r&eacute;cemment. Nous esp&eacute;rons vivement que WEFIT a pu r&eacute;pondre &agrave; vos attentes ! Merci de prendre quelques instants pour remplir le formulaire suivant.
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-4">
								<div class="col-md-12">							
									<table class="table">
										<tr>
											<th class="text-center" bgcolor="#F3F3F3" colspan="3"><label>1 - VOTRE FORMATION</label></th>
										</tr>
										<tr>
											<td class="bg-light" width="40%">&Ecirc;tes-vous globalement satisfait de votre formation ?</td>
											<td width="20%" align="center">
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
											</td>
											<td>
												<textarea class="form-control" name="ans_1b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="30%"><strong>La formation</strong> a-t-elle r&eacute;pondu &agrave; vos attentes ?</td>
											<td>
												<label><input type="radio" name="ans_2a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_2a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_2b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="30%">Avez-vous trouv&eacute; <strong>votre formateur</strong> suffisamment &agrave; votre &eacute;coute ?</td>
											<td>
												<label><input type="radio" name="ans_3a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_3a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_3b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="30%"><strong>Les ressources</strong> (type de cours, th&egrave;mes) utilis&eacute;es pendant vos le&ccedil;ons ont-elles &eacute;t&eacute; en ad&eacute;quation avec vos besoins ?</td>
											<td>
												<label><input type="radio" name="ans_4a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_4a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_4b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<th class="text-center" bgcolor="#F3F3F3" colspan="3"><label>2 - NOS OUTILS</label></th>
										</tr>
										<tr>
											<td class="bg-light" width="40%">Avez-vous &eacute;t&eacute; satisfait de notre plateforme d'apprentissage WEFIT (celle sur laquelle vous &ecirc;tes en ce moment ;) ?</td>
											<td>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
											</td>
											<td>
												<textarea class="form-control" name="ans_5b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light" width="40%">Avez-vous &eacute;t&eacute; satisfait de l'outil de visio-conf&eacute;rence <strong>Adobe Connect</strong> ?</td>
											<td>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
											</td>
											<td>
												<textarea class="form-control" name="ans_6b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<th class="text-center" bgcolor="#F3F3F3" colspan="3"><label>3 - NOTRE SUPPORT CLIENT</label></th>
										</tr>
										<tr>
											<td class="bg-light" width="40%">Avez-vous &eacute;t&eacute; satisfait de l'assistance de notre service client tout au long de votre formation ?</td>
											<td>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-info fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
												<span class="float-left"><h4 class="mt-0 mb-0"><i class="text-secondary fa fa-star"></i></h4></span>
											</td>
											<td>
												<textarea class="form-control" name="ans_7b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<th class="text-center" bgcolor="#F3F3F3" colspan="3"><label>4 - VOS SUGGESTIONS</label></th>
										</tr>
										<tr>
											<td class="bg-light">Quelles sont vos suggestions quant &agrave; l&rsquo;am&eacute;lioration de nos formats de cours ?</td>
											<td colspan="2">
											<textarea class="form-control" name="ans_8"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Souhaitez-vous nous faire part de remarques ou recommandations afin d'am&eacute;liorer notre service, et r&eacute;pondre au mieux &agrave; vos attentes ?</td>
											<td colspan="2">
											<textarea class="form-control" name="ans_10"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center"><input type="submit" value="Envoyer" class="btn btn-info"></td>
										</tr>
									</table>
								</div>
							</div>
							<cfelseif form_eval eq "ceval">
							<div class="row">
								<div class="col-md-12">		
									<div class="media">
										<img src="./assets/img_material/1d7053b0d22b017e88b6c63734a0615e.jpg" class="rounded float-left mr-3" width="220">	
										<div class="media-body">
										<h5 class="mt-0">&Eacute;valuation &agrave; froid</h5>
										Vous avez maintenant le recul n&eacute;cessaire pour juger de la pertinence de votre formation. Merci de prendre quelques instants pour remplir le formulaire suivant.
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-4">
								<div class="col-md-12">							
									<table class="table">
										<tr>
											<td class="bg-light" width="40%">La formation WEFIT a-t-elle r&eacute;pondu &agrave; vos attentes ?</td>
											<td>
												<label><input type="radio" name="ans_1a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_1a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_1b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Avez-vous pu mettre en pratique les comp&eacute;tences acquises lors de votre formation ?</td>
											<td>
												<label><input type="radio" name="ans_2a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_2a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_2b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Consid&eacute;rez-vous que votre formation vous a permis d&rsquo;am&eacute;liorer la qualit&eacute; ou l&rsquo;efficacit&eacute; de votre travail ? </td>
											<td>
												<label><input type="radio" name="ans_3a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_3a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_3b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Diriez-vous que votre formation vous a permis de d&eacute;velopper de nouvelles comp&eacute;tences ?</td>
											<td>
												<label><input type="radio" name="ans_4a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_4a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_4b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Quels ont &eacute;t&eacute; les points forts de votre formation ?</td>
											<td colspan="2">
												<textarea class="form-control" name="ans_5" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Quels ont &eacute;t&eacute; les points faibles de votre formation ?</td>
											<td colspan="2">
												<textarea class="form-control" name="ans_6" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td class="bg-light">Votre formation a-t-elle r&eacute;pondu aux objectifs que vous vous &eacute;tiez fix&eacute;s ?</td>
											<td>
												<label><input type="radio" name="ans_7a" value="1"> OUI</label> &nbsp;&nbsp;
												<label><input type="radio" name="ans_7a" value="0"> NON</label>
											</td>
											<td>
												<textarea class="form-control" name="ans_7b" placeholder="Pr&eacute;cisez"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="3" align="center"><input type="submit" value="Envoyer" class="btn btn-info"></td>
										</tr>
									</table>
								</div>
							</div>
							
							</cfif>
						</div>
					</div>
				</div>
			
			</div>
			</cfif>
			
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

</body>
</html>