<script>
tinymce.init({
	selector:'#lesson_na_needs',
	branding: false,
	contextmenu: "link image imagetools table spellchecker",
	contextmenu_never_use_native: true,
	draggable_modal: false,
	menubar: '',	
	toolbar: 'undo redo | bold italic underline numlist bullist link',
	plugins: "lists,link",
	browser_spellcheck: true,
	paste_data_images: false,
	invalid_elements : "img",
});
</script>

<cfset get_lessonnote = obj_query.oget_lessonnote(l_id="#l_id#")>

<cfset get_tp = obj_tp_get.oget_tp(t_id="#get_lessonnote.tp_id#")>

<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>


<cfset lesson_intro_text = #obj_translater.get_translate_complex('ln_na_lesson_intro_text', formation_id)#>
<cfset lesson_footer_text = #obj_translater.get_translate_complex('ln_na_lesson_footer_text', formation_id)#>

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#lang_temp# as skill_objectives FROM lms_skill
</cfquery>

<cfif get_lessonnote.note_id neq "">

	<cfset u_id = get_lessonnote.user_id>
	
	<cfset user_qpt = get_lessonnote.user_qpt>
	<cfset user_qpt_lock = get_lessonnote.user_qpt_lock>
	
	<cfset lesson_intro = get_lessonnote.lesson_intro>
	
	<cfset na_skill_id = get_lessonnote.ln_skill_id>
	<cfset na_keyword_id = get_lessonnote.ln_keyword_id>
	
	<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
	<cfset lesson_na_improve = get_lessonnote.lesson_na_improve>
	<cfset lesson_na_workon = get_lessonnote.lesson_na_workon>
	
	<cfset lesson_formation = get_lessonnote.formation_name>
	<cfset lesson_footer = get_lessonnote.lesson_footer>
	
<cfelse>
	
	<cfset u_id = get_lessonnote.user_id>
	
	<cfset user_qpt = get_lessonnote.user_qpt>
	<cfset user_qpt_lock = get_lessonnote.user_qpt_lock>
	
	<cfset lesson_intro = lesson_intro_text>
	
	<cfset na_skill_id = get_lessonnote.u_skill_id>
	<cfset na_keyword_id = get_lessonnote.u_keyword_id>
	
	<cfset lesson_na_needs = "">
	<cfset lesson_na_improve = "">
	<cfset lesson_na_workon = "">
	
	<cfset lesson_formation = get_lessonnote.formation_name>
	<cfset lesson_footer = lesson_footer_text>
	
</cfif>

	<div class="row">
		<div class="col-md-12">
			<div class="p-1">
				<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="0" class="table-bordered">		
					<tr>
						<td rowspan="7" width="200" bgcolor="#FFF">
							<cfoutput>#obj_lms.get_thumb_session(get_lessonnote.sessionmaster_code,get_lessonnote.sessionmaster_id)#</cfoutput>
						</td>
					</tr>
					<tr>
						<td width="200" class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_course_title',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><strong><cfoutput>#get_lessonnote.sessionmaster_name#</cfoutput></strong></span>
						</td>
					</tr>	
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_trainer',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.planner_firstname#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_learner',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.user_firstname# #get_lessonnote.user_name#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_date',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#dateformat(get_lessonnote.lesson_start,'dd/mm/yyyy')#</cfoutput></span>
						</td>
					</tr>
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_time',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</cfoutput></span>
						</td>
					</tr>							
					<tr>
						<td class="bg-light">
							<span style="font-size:12px;"><cfoutput>#obj_translater.get_translate('table_th_duration_short',formation_id)#</cfoutput></span>
						</td>
						<td bgcolor="#FFFFFF">
							<span style="font-size:12px;"><cfoutput>#get_lessonnote.lesson_duration# m</cfoutput></span>
						</td>
					</tr>		
				</table>
			</div>
		</div>
	</div>
	
	<cfform action="updater_ln.cfm" method="post" id="form_ln">	
	<div class="row">
		<div class="col-md-12 mt-3">
			
		<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_target_situation',formation_id)#</cfoutput></h2>	

		<div class="bg-light p-2 m-1 border">
		
			<h6><cfoutput>#obj_translater.get_translate('ln_title_want_to',formation_id)#</cfoutput> *</h6>
			<em><small><cfoutput>*#obj_translater.get_translate('ln_title_alert_skill',formation_id)#</cfoutput></small></em>
			
			<div class="row mt-2">
					
				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
				<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(na_skill_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>							
				</cfoutput>
				</div>
				
				<div class="col-md-6">
				<cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
				<label><input type="checkbox" name="skill_id" class="skill_id" id="skill_id" value="#skill_id#" <cfif listfind(na_skill_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>				
				</cfoutput>
				</div>
				
			</div>
			
			<br>
			<div align="center" style="color:#FF0000;"><small><strong><cfoutput>#obj_translater.get_translate('ln_warning_image_disabled',formation_id)#</cfoutput></strong></small></div>
			<br>
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_initial',formation_id)#</cfoutput></h6>
			<em><small><cfoutput>#obj_translater.get_translate('ln_title_alert_list',formation_id)#</cfoutput></small></em>
			<p style="margin-top:10px">
			<textarea name="lesson_na_needs" id="lesson_na_needs" class="form-control"><cfoutput>#lesson_na_needs#</cfoutput></textarea>
			</p>
			
		</div>
			
		<br>
		
		<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_strategy_analysis',formation_id)# / #obj_translater.get_translate('ln_title_learner_profile',formation_id)#</cfoutput></h2>	
			
		<div class="bg-light p-2 m-1 border">
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_how',formation_id)#</cfoutput></h6>
			<p style="margin-top:10px">
			<em><cfoutput>#obj_translater.get_translate('ln_title_auto_needs',formation_id)#</cfoutput></em>
			</p>	
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_interests',formation_id)#</cfoutput></h6>
			<p style="margin-top:10px">
			<em><cfoutput>#obj_translater.get_translate('ln_title_auto_needs',formation_id)#</cfoutput></em>
			</p>
			
			<h6><cfoutput>#obj_translater.get_translate('ln_title_level',formation_id)#</cfoutput></h6>
			<em><cfoutput>#obj_translater.get_translate('ln_title_auto_pt',formation_id)#</cfoutput></em>
			<p style="margin-top:10px">
			
			<cfif user_qpt neq "" AND user_qpt_lock eq "1">
			<cfoutput>
			<!---COMPLEX
			<cfif user_qpt eq "A0">
			#obj_translater.get_translate_complex('ln_na_level_A0_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_A0_list', formation_id)#
			<cfelseif user_qpt eq "A1">
			#obj_translater.get_translate_complex('ln_na_level_A1_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_A1_list', formation_id)#
			<cfelseif user_qpt eq "A2">
			#obj_translater.get_translate_complex('ln_na_level_A2_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_A2_list', formation_id)#
			<cfelseif user_qpt eq "B1">
			#obj_translater.get_translate_complex('ln_na_level_B1_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_B1_list', formation_id)#
			<cfelseif user_qpt eq "B2">
			#obj_translater.get_translate_complex('ln_na_level_B2_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_B2_list', formation_id)#
			<cfelseif user_qpt eq "C1">
			#obj_translater.get_translate_complex('ln_na_level_C1_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_C1_list', formation_id)#
			<cfelseif user_qpt eq "C2">
			#obj_translater.get_translate_complex('ln_na_level_C2_intro', formation_id)#
			#obj_translater.get_translate_complex('ln_na_level_C2_list', formation_id)#
			</cfif>
			START_RM--->
			<cfif formation_id eq "1">			
				<cfif user_qpt eq "A0">
					Votre niveau est : <strong>D&eacute;butant</strong><br>
				<cfelseif user_qpt eq "A1">
					Votre niveau est : <strong>#user_qpt# (D&eacute;butant)</strong><br>
					<ul>
					<li>Vous pouvez comprendre et utiliser des expressions famili&egrave;res et quotidiennes ainsi que des &eacute;nonc&eacute;s tr&egrave;s simples qui visent &agrave; satisfaire des besoins concrets.</li>
					<li>Vous pouvez vous pr&eacute;senter ou pr&eacute;senter quelqu'un et poser &agrave; une personne des questions la concernant - par exemple, sur son lieu d'habitation, ses relations, ce qui lui appartient, etc. - et vous pouvez r&eacute;pondre au m&ecirc;me type de questions.</li>
					<li>Vous pouvez communiquer de fa&ccedil;on simple si l'interlocuteur parle lentement et distinctement et se montre coop&eacute;ratif.</li>
					</ul>
				<cfelseif user_qpt eq "A2">
					Votre niveau est : <strong>#user_qpt# (&Eacute;l&eacute;mentaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre des phrases isol&eacute;es et des expressions fr&eacute;quemment utilis&eacute;es en relation avec des domaines imm&eacute;diats de priorit&eacute; (par exemple, informations personnelles et familiales simples, achats, environnement proche, travail).</li>
					<li>Vous pouvez communiquer lors de t&acirc;ches simples et habituelles ne demandant qu'un &eacute;change d'informations simple et direct sur des sujets familiers et habituels.</li>
					<li>Vous pouvez d&eacute;crire avec des moyens simples votre formation, votre environnement imm&eacute;diat et &eacute;voquer des sujets qui correspondent &agrave; des besoins imm&eacute;diats.</li>
					</ul>
				<cfelseif user_qpt eq "B1">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre les points essentiels quand un langage clair et standard est utilis&eacute; et s'il s'agit de choses famili&egrave;res dans le travail, &agrave; l'&eacute;cole, dans les loisirs, etc.</li>
					<li>Vous pouvez vous d&eacute;brouiller dans la plupart des situations rencontr&eacute;es en voyage dans une r&eacute;gion o&ugrave; la langue cible est parl&eacute;e.</li>
					<li>Vous pouvez produire un discours simple et coh&eacute;rent sur des sujets familiers et dans vos domaines d'int&eacute;r&ecirc;t.</li>
					<li>Vous pouvez raconter un &eacute;v&eacute;nement, une exp&eacute;rience ou un r&ecirc;ve, d&eacute;crire un espoir ou un but et exposer bri&egrave;vement des raisons ou explications pour un projet ou une id&eacute;e.</li>
					</ul>
				<cfelseif user_qpt eq "B2">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire sup&eacute;rieur)</strong><br>
					<ul>
					<li>Vous pouvez comprendre le contenu essentiel de sujets concrets ou abstraits dans un texte complexe, y compris une discussion technique dans votre sp&eacute;cialit&eacute;.</li>
					<li>Vous pouvez communiquer avec un degr&eacute; de spontan&eacute;it&eacute; et d'aisance tel qu'une conversation avec un locuteur natif ne comportant de tension ni pour l'un ni pour l'autre.</li>
					<li>Vous pouvez vous exprimer de fa&ccedil;on claire et d&eacute;taill&eacute;e sur une grande gamme de sujets, &eacute;mettre un avis sur un sujet d&rsquo;actualit&eacute; et exposer les avantages et les inconv&eacute;nients de diff&eacute;rentes possibilit&eacute;s.</li>
					</ul>
				<cfelseif user_qpt eq "C1">
					Votre niveau est : <strong>#user_qpt# (Avanc&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre une grande gamme de textes longs et exigeants, ainsi que saisir des significations implicites.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment et couramment sans trop apparemment devoir chercher vos mots.</li>
					<li>Vous pouvez utiliser la langue de fa&ccedil;on efficace et souple dans votre vie sociale, professionnelle ou acad&eacute;mique.</li>
					<li>Vous pouvez vous exprimer sur des sujets complexes de fa&ccedil;on claire et bien structur&eacute;e et manifester votre contr&ocirc;le des outils d'organisation, d'articulation et de coh&eacute;sion du discours.</li>
					</ul>
				<cfelseif user_qpt eq "C2">
					Votre niveau est : <strong>#user_qpt# (Exp&eacute;riment&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre sans effort pratiquement tout ce que vous lisez ou entendez.</li>
					<li>Vous pouvez restituer faits et arguments de diverses sources &eacute;crites et orales en les r&eacute;sumant de fa&ccedil;on coh&eacute;rente.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment, tr&egrave;s couramment et de fa&ccedil;on pr&eacute;cise et pouvez rendre distinctes de fines nuances de sens en rapport avec des sujets complexes.</li>
					</ul>		
				</cfif>
			<cfelseif formation_id eq "2">
				<cfif user_qpt eq "A0">
					Your level is : <strong>Beginner</strong><br>
				<cfelseif user_qpt eq "A1">
					Your level is : <strong>#user_qpt# (Beginner)</strong><br>
					<ul>
					<li>Can understand and use familiar everyday expressions and very basic phrases aimed at the satisfaction of needs of a concrete type.</li>
					<li>Can introduce him/herself and others and can ask and answer questions about personal details such as where he/she lives, people he/she knows and things he/she has.</li>
					<li>Can interact in a simple way provided the other person talks slowly and clearly and is prepared to help.</li>
					</ul>
				<cfelseif user_qpt eq "A2">
					Your level is : <strong>#user_qpt# (Elementary English)</strong><br>
					<ul>
					<li>Can understand sentences and frequently used expressions related to areas of most immediate relevance (e.g. very basic personal and family information, shopping, local geography, employment).</li>
					<li>Can communicate in simple and routine tasks requiring a simple and direct exchange of information on familiar and routine matters.</li>
					<li>Can describe in simple terms aspects of his/her background, immediate environment and matters in areas of immediate need.</li>
					</ul>
				<cfelseif user_qpt eq "B1">
					Your level is : <strong>#user_qpt# (Intermediate English)</strong><br>
					<ul>
					<li>Can understand the main points of clear standard input on familiar matters regularly encountered in work, school, leisure, etc. </li>
					<li>Can deal with most situations likely to arise whilst travelling in an area where the language is spoken.</li>
					<li>Can produce simple connected text on topics which are familiar or of personal interest.</li>
					<li>Can describe experiences and events, dreams, hopes & ambitions and briefly give reasons and explanations for opinions and plans.</li>
					</ul>
				<cfelseif user_qpt eq "B2">
					Your level is : <strong>#user_qpt# (Upper-Intermediate)</strong><br>
					<ul>
					<li>Can understand the main ideas of complex text on both concrete and abstract topics, including technical discussions in his/her field of specialisation.</li>
					<li>Can interact with a degree of fluency and spontaneity that makes regular interaction with native speakers quite possible without strain for either party.</li>
					<li>Can produce clear, detailed text on a wide range of subjects and explain a viewpoint on a topical issue giving the advantages and disadvantages of various options.</li>
					</ul>
				<cfelseif user_qpt eq "C1">
					Your level is : <strong>#user_qpt# (Advanced English)</strong><br>
					<ul>
					<li>Can understand a wide range of demanding, longer texts, and recognise implicit meaning.</li>
					<li>Can express him/herself fluently and spontaneously without much obvious searching for expressions.</li>
					<li>Can use language flexibly and effectively for social, academic and professional purposes.</li>
					<li>Can produce clear, well-structured, detailed text on complex subjects, showing a controlled use of organisational patterns, connectors and cohesive devices.</li>
					</ul>
				<cfelseif user_qpt eq "C2">
					Your level is : <strong>#user_qpt# (Proficiency)</strong><br>
					<ul>
					<li>Can understand with ease virtually everything heard or read.</li>
					<li>Can summarise information from different spoken and written sources, reconstructing arguments and accounts in a coherent presentation.</li>
					<li>Can express him/herself spontaneously, very fluently and precisely, differentiating finer shades of meaning even in more complex situations.</li>
					</ul>		
				</cfif>
			<cfelseif formation_id eq "3">
				<cfif user_qpt eq "A0">
					Your level is : <strong>Beginner</strong><br>
				<cfelseif user_qpt eq "A1">
					Your level is : <strong>#user_qpt# (Beginner)</strong><br>
					<ul>
					<li>Can understand and use familiar everyday expressions and very basic phrases aimed at the satisfaction of needs of a concrete type.</li>
					<li>Can introduce him/herself and others and can ask and answer questions about personal details such as where he/she lives, people he/she knows and things he/she has.</li>
					<li>Can interact in a simple way provided the other person talks slowly and clearly and is prepared to help.</li>
					</ul>
				<cfelseif user_qpt eq "A2">
					Your level is : <strong>#user_qpt# (Elementary English)</strong><br>
					<ul>
					<li>Can understand sentences and frequently used expressions related to areas of most immediate relevance (e.g. very basic personal and family information, shopping, local geography, employment).</li>
					<li>Can communicate in simple and routine tasks requiring a simple and direct exchange of information on familiar and routine matters.</li>
					<li>Can describe in simple terms aspects of his/her background, immediate environment and matters in areas of immediate need.</li>
					</ul>
				<cfelseif user_qpt eq "B1">
					Your level is : <strong>#user_qpt# (Intermediate English)</strong><br>
					<ul>
					<li>Can understand the main points of clear standard input on familiar matters regularly encountered in work, school, leisure, etc. </li>
					<li>Can deal with most situations likely to arise whilst travelling in an area where the language is spoken.</li>
					<li>Can produce simple connected text on topics which are familiar or of personal interest.</li>
					<li>Can describe experiences and events, dreams, hopes & ambitions and briefly give reasons and explanations for opinions and plans.</li>
					</ul>
				<cfelseif user_qpt eq "B2">
					Your level is : <strong>#user_qpt# (Upper-Intermediate)</strong><br>
					<ul>
					<li>Can understand the main ideas of complex text on both concrete and abstract topics, including technical discussions in his/her field of specialisation.</li>
					<li>Can interact with a degree of fluency and spontaneity that makes regular interaction with native speakers quite possible without strain for either party.</li>
					<li>Can produce clear, detailed text on a wide range of subjects and explain a viewpoint on a topical issue giving the advantages and disadvantages of various options.</li>
					</ul>
				<cfelseif user_qpt eq "C1">
					Your level is : <strong>#user_qpt# (Advanced English)</strong><br>
					<ul>
					<li>Can understand a wide range of demanding, longer texts, and recognise implicit meaning.</li>
					<li>Can express him/herself fluently and spontaneously without much obvious searching for expressions.</li>
					<li>Can use language flexibly and effectively for social, academic and professional purposes.</li>
					<li>Can produce clear, well-structured, detailed text on complex subjects, showing a controlled use of organisational patterns, connectors and cohesive devices.</li>
					</ul>
				<cfelseif user_qpt eq "C2">
					Your level is : <strong>#user_qpt# (Proficiency)</strong><br>
					<ul>
					<li>Can understand with ease virtually everything heard or read.</li>
					<li>Can summarise information from different spoken and written sources, reconstructing arguments and accounts in a coherent presentation.</li>
					<li>Can express him/herself spontaneously, very fluently and precisely, differentiating finer shades of meaning even in more complex situations.</li>
					</ul>		
				</cfif>
			<cfelseif formation_id eq "4">
				<cfif user_qpt eq "A0">
					Votre niveau est : <strong>D&eacute;butant</strong><br>
				<cfelseif user_qpt eq "A1">
					Votre niveau est : <strong>#user_qpt# (D&eacute;butant)</strong><br>
					<ul>
					<li>Vous pouvez comprendre et utiliser des expressions famili&egrave;res et quotidiennes ainsi que des &eacute;nonc&eacute;s tr&egrave;s simples qui visent &agrave; satisfaire des besoins concrets.</li>
					<li>Vous pouvez vous pr&eacute;senter ou pr&eacute;senter quelqu'un et poser &agrave; une personne des questions la concernant - par exemple, sur son lieu d'habitation, ses relations, ce qui lui appartient, etc. - et vous pouvez r&eacute;pondre au m&ecirc;me type de questions.</li>
					<li>Vous pouvez communiquer de fa&ccedil;on simple si l'interlocuteur parle lentement et distinctement et se montre coop&eacute;ratif.</li>
					</ul>
				<cfelseif user_qpt eq "A2">
					Votre niveau est : <strong>#user_qpt# (&Eacute;l&eacute;mentaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre des phrases isol&eacute;es et des expressions fr&eacute;quemment utilis&eacute;es en relation avec des domaines imm&eacute;diats de priorit&eacute; (par exemple, informations personnelles et familiales simples, achats, environnement proche, travail).</li>
					<li>Vous pouvez communiquer lors de t&acirc;ches simples et habituelles ne demandant qu'un &eacute;change d'informations simple et direct sur des sujets familiers et habituels.</li>
					<li>Vous pouvez d&eacute;crire avec des moyens simples votre formation, votre environnement imm&eacute;diat et &eacute;voquer des sujets qui correspondent &agrave; des besoins imm&eacute;diats.</li>
					</ul>
				<cfelseif user_qpt eq "B1">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre les points essentiels quand un langage clair et standard est utilis&eacute; et s'il s'agit de choses famili&egrave;res dans le travail, &agrave; l'&eacute;cole, dans les loisirs, etc.</li>
					<li>Vous pouvez vous d&eacute;brouiller dans la plupart des situations rencontr&eacute;es en voyage dans une r&eacute;gion o&ugrave; la langue cible est parl&eacute;e.</li>
					<li>Vous pouvez produire un discours simple et coh&eacute;rent sur des sujets familiers et dans vos domaines d'int&eacute;r&ecirc;t.</li>
					<li>Vous pouvez raconter un &eacute;v&eacute;nement, une exp&eacute;rience ou un r&ecirc;ve, d&eacute;crire un espoir ou un but et exposer bri&egrave;vement des raisons ou explications pour un projet ou une id&eacute;e.</li>
					</ul>
				<cfelseif user_qpt eq "B2">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire sup&eacute;rieur)</strong><br>
					<ul>
					<li>Vous pouvez comprendre le contenu essentiel de sujets concrets ou abstraits dans un texte complexe, y compris une discussion technique dans votre sp&eacute;cialit&eacute;.</li>
					<li>Vous pouvez communiquer avec un degr&eacute; de spontan&eacute;it&eacute; et d'aisance tel qu'une conversation avec un locuteur natif ne comportant de tension ni pour l'un ni pour l'autre.</li>
					<li>Vous pouvez vous exprimer de fa&ccedil;on claire et d&eacute;taill&eacute;e sur une grande gamme de sujets, &eacute;mettre un avis sur un sujet d&rsquo;actualit&eacute; et exposer les avantages et les inconv&eacute;nients de diff&eacute;rentes possibilit&eacute;s.</li>
					</ul>
				<cfelseif user_qpt eq "C1">
					Votre niveau est : <strong>#user_qpt# (Avanc&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre une grande gamme de textes longs et exigeants, ainsi que saisir des significations implicites.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment et couramment sans trop apparemment devoir chercher vos mots.</li>
					<li>Vous pouvez utiliser la langue de fa&ccedil;on efficace et souple dans votre vie sociale, professionnelle ou acad&eacute;mique.</li>
					<li>Vous pouvez vous exprimer sur des sujets complexes de fa&ccedil;on claire et bien structur&eacute;e et manifester votre contr&ocirc;le des outils d'organisation, d'articulation et de coh&eacute;sion du discours.</li>
					</ul>
				<cfelseif user_qpt eq "C2">
					Votre niveau est : <strong>#user_qpt# (Exp&eacute;riment&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre sans effort pratiquement tout ce que vous lisez ou entendez.</li>
					<li>Vous pouvez restituer faits et arguments de diverses sources &eacute;crites et orales en les r&eacute;sumant de fa&ccedil;on coh&eacute;rente.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment, tr&egrave;s couramment et de fa&ccedil;on pr&eacute;cise et pouvez rendre distinctes de fines nuances de sens en rapport avec des sujets complexes.</li>
					</ul>		
				</cfif>
			<cfelseif formation_id eq "5">
				<cfif user_qpt eq "A0">
					Votre niveau est : <strong>D&eacute;butant</strong><br>
				<cfelseif user_qpt eq "A1">
					Votre niveau est : <strong>#user_qpt# (D&eacute;butant)</strong><br>
					<ul>
					<li>Vous pouvez comprendre et utiliser des expressions famili&egrave;res et quotidiennes ainsi que des &eacute;nonc&eacute;s tr&egrave;s simples qui visent &agrave; satisfaire des besoins concrets.</li>
					<li>Vous pouvez vous pr&eacute;senter ou pr&eacute;senter quelqu'un et poser &agrave; une personne des questions la concernant - par exemple, sur son lieu d'habitation, ses relations, ce qui lui appartient, etc. - et vous pouvez r&eacute;pondre au m&ecirc;me type de questions.</li>
					<li>Vous pouvez communiquer de fa&ccedil;on simple si l'interlocuteur parle lentement et distinctement et se montre coop&eacute;ratif.</li>
					</ul>
				<cfelseif user_qpt eq "A2">
					Votre niveau est : <strong>#user_qpt# (&Eacute;l&eacute;mentaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre des phrases isol&eacute;es et des expressions fr&eacute;quemment utilis&eacute;es en relation avec des domaines imm&eacute;diats de priorit&eacute; (par exemple, informations personnelles et familiales simples, achats, environnement proche, travail).</li>
					<li>Vous pouvez communiquer lors de t&acirc;ches simples et habituelles ne demandant qu'un &eacute;change d'informations simple et direct sur des sujets familiers et habituels.</li>
					<li>Vous pouvez d&eacute;crire avec des moyens simples votre formation, votre environnement imm&eacute;diat et &eacute;voquer des sujets qui correspondent &agrave; des besoins imm&eacute;diats.</li>
					</ul>
				<cfelseif user_qpt eq "B1">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire)</strong><br>
					<ul>
					<li>Vous pouvez comprendre les points essentiels quand un langage clair et standard est utilis&eacute; et s'il s'agit de choses famili&egrave;res dans le travail, &agrave; l'&eacute;cole, dans les loisirs, etc.</li>
					<li>Vous pouvez vous d&eacute;brouiller dans la plupart des situations rencontr&eacute;es en voyage dans une r&eacute;gion o&ugrave; la langue cible est parl&eacute;e.</li>
					<li>Vous pouvez produire un discours simple et coh&eacute;rent sur des sujets familiers et dans vos domaines d'int&eacute;r&ecirc;t.</li>
					<li>Vous pouvez raconter un &eacute;v&eacute;nement, une exp&eacute;rience ou un r&ecirc;ve, d&eacute;crire un espoir ou un but et exposer bri&egrave;vement des raisons ou explications pour un projet ou une id&eacute;e.</li>
					</ul>
				<cfelseif user_qpt eq "B2">
					Votre niveau est : <strong>#user_qpt# (Interm&eacute;diaire sup&eacute;rieur)</strong><br>
					<ul>
					<li>Vous pouvez comprendre le contenu essentiel de sujets concrets ou abstraits dans un texte complexe, y compris une discussion technique dans votre sp&eacute;cialit&eacute;.</li>
					<li>Vous pouvez communiquer avec un degr&eacute; de spontan&eacute;it&eacute; et d'aisance tel qu'une conversation avec un locuteur natif ne comportant de tension ni pour l'un ni pour l'autre.</li>
					<li>Vous pouvez vous exprimer de fa&ccedil;on claire et d&eacute;taill&eacute;e sur une grande gamme de sujets, &eacute;mettre un avis sur un sujet d&rsquo;actualit&eacute; et exposer les avantages et les inconv&eacute;nients de diff&eacute;rentes possibilit&eacute;s.</li>
					</ul>
				<cfelseif user_qpt eq "C1">
					Votre niveau est : <strong>#user_qpt# (Avanc&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre une grande gamme de textes longs et exigeants, ainsi que saisir des significations implicites.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment et couramment sans trop apparemment devoir chercher vos mots.</li>
					<li>Vous pouvez utiliser la langue de fa&ccedil;on efficace et souple dans votre vie sociale, professionnelle ou acad&eacute;mique.</li>
					<li>Vous pouvez vous exprimer sur des sujets complexes de fa&ccedil;on claire et bien structur&eacute;e et manifester votre contr&ocirc;le des outils d'organisation, d'articulation et de coh&eacute;sion du discours.</li>
					</ul>
				<cfelseif user_qpt eq "C2">
					Votre niveau est : <strong>#user_qpt# (Exp&eacute;riment&eacute;)</strong><br>
					<ul>
					<li>Vous pouvez comprendre sans effort pratiquement tout ce que vous lisez ou entendez.</li>
					<li>Vous pouvez restituer faits et arguments de diverses sources &eacute;crites et orales en les r&eacute;sumant de fa&ccedil;on coh&eacute;rente.</li>
					<li>Vous pouvez vous exprimer spontan&eacute;ment, tr&egrave;s couramment et de fa&ccedil;on pr&eacute;cise et pouvez rendre distinctes de fines nuances de sens en rapport avec des sujets complexes.</li>
					</ul>		
				</cfif>			
			</cfif>
			<!---END_RM--->
			</cfoutput>
			<cfelse>
				Placement Test not done !
			</cfif>
					
			</p>
				
			
		</div>
		
		<br>
		
		<h2 align="center" style="color:#871E2C; font-size:16px; margin-top:15px; font-weight:bold"><cfoutput>#obj_translater.get_translate('ln_title_training_program',formation_id)#</cfoutput></h2>	
		
		
		<div class="bg-light p-2 m-1 border">
		
		<cfif get_tp.session_duration eq get_tp.tp_duration>
		<em><cfoutput>#obj_translater.get_translate('ln_title_auto_tp',formation_id)#</cfoutput></em>
		<cfelse>
		<cfoutput>
		<div class="alert alert-danger" align="center"><strong>Warning! </strong> Incomplete Training Program</div>
		</cfoutput>
		</cfif>
		
		</div>
		
		
	</div>
	
</div>

		<cfoutput>
		<cfif get_lessonnote.note_id neq "">
		<input type="hidden" name="updt_ln" value="1">
		<input type="hidden" name="l_id" value="#get_lessonnote.lesson_id#">
		<input type="hidden" name="note_id" value="#get_lessonnote.note_id#">
		<input type="hidden" name="lesson_intro" value="#lesson_intro#">
		<input type="hidden" name="lesson_footer" value="#lesson_footer#">
		<cfelse>
		<input type="hidden" name="ins_ln" value="1">
		<input type="hidden" name="l_id" value="#get_lessonnote.lesson_id#">
		<input type="hidden" name="lesson_intro" value="#lesson_intro#">
		<input type="hidden" name="lesson_footer" value="#lesson_footer#">
		</cfif>
		</cfoutput>
		
		<div align="center">
		<br>
		<label><input type="checkbox" name="finalise_lesson" class="finalise_lesson" value="1"><cfoutput>#obj_translater.get_translate('modal_ln_finalize',formation_id)#</cfoutput></label>		
		</div>
		
		<div align="center"><input type="submit" class="btn btn-success" value="<cfoutput>#obj_translater.get_translate('btn_update')#</cfoutput>"></div>
	
		<script>
		$(document).ready(function() {	
			
			$("#form_ln").submit(function(event) {

				if($(".finalise_lesson").is(':checked'))
				{
					var skill_id = [];
					$.each($("input[id='skill_id']:checked"), function(){
						skill_id.push($(this).val());					
					});	
					
					if(skill_id.length == "0")
					{
					alert("Please select at least one skill.")
					return false;			
					}

					var tofill = "Not enough characters for : ";
					var o = $("#lesson_na_needs").val().length;
					
					if(o<=150)
					{
						if(o<=150){
							tofill = tofill+"\n Feedback - "+o+ " characters (150 needed)";
						}
						alert(tofill);
						return false;
					}

				}
				
			});
			
		});
		</script>

</cfform>