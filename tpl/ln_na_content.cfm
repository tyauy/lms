<cfswitch expression="#get_lessonnote.formation_id#">
	<cfcase value="1"><cfset lang_temp = "fr"><cfset formation_id = "1"></cfcase>
	<cfcase value="2"><cfset lang_temp = "en"><cfset formation_id = "2"></cfcase>
	<cfcase value="3"><cfset lang_temp = "de"><cfset formation_id = "3"></cfcase>
	<cfcase value="4"><cfset lang_temp = "es"><cfset formation_id = "4"></cfcase>
	<cfcase value="5"><cfset lang_temp = "it"><cfset formation_id = "5"></cfcase>
	<cfdefaultcase><cfset lang_temp = "fr"><cfset formation_id = "1"></cfdefaultcase>
</cfswitch>

<cfset lesson_intro = get_lessonnote.lesson_intro>
<cfset lesson_formation = get_lessonnote.formation_name>
<cfset lesson_footer = get_lessonnote.lesson_footer>

<cfset lesson_na_needs = get_lessonnote.lesson_na_needs>
<cfset lesson_na_improve = get_lessonnote.lesson_na_improve>
<cfset lesson_na_workon = get_lessonnote.lesson_na_workon>
	
<cfset lesson_open_main = get_lessonnote.lesson_open_main>
<cfset lesson_keyword_id = get_lessonnote.ln_keyword_id>
<cfset lesson_grammar_id = get_lessonnote.ln_grammar_id>
<cfset lesson_skill_id = get_lessonnote.ln_skill_id>
<cfset lesson_add_misc = get_lessonnote.lesson_add_misc>
<cfset lesson_feedback = get_lessonnote.lesson_feedback>
<cfset lesson_grammar = get_lessonnote.lesson_grammar>
<cfset lesson_vocabulary = get_lessonnote.lesson_vocabulary>
<cfset lesson_add_vocabulary = get_lessonnote.lesson_add_vocabulary>
<cfset lesson_open_ressources = get_lessonnote.lesson_open_ressources>	

<cfif page eq "1">
<html>
<body style="width:100%; margin:0px; padding:0px">
<cfoutput>
<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2>#obj_translater.get_translate('ln_title_na',formation_id)# <cfif get_result_lst.recordcount neq "0">(1/5)<cfelse>(1/4)</cfif></h2>		
					</td>
				</tr>				
				<tr>				
					<td style="padding:20px" align="center">
						<em style="font-size:13px">#lesson_intro#</em>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<tr>
		<td valign="top" align="center" style="padding:0px 20px 10px 20px">
			
			<table bgcolor="##ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
				<tr>
					<td rowspan="7" width="200" bgcolor="##FFF">
						#obj_lms.get_thumb_session(get_lessonnote.sessionmaster_code,get_lessonnote.sessionmaster_id,200)#
					</td>
				</tr>
				<tr>
					<td width="200">
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_course_title',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;"><strong>#get_lessonnote.sessionmaster_name#</strong></span>
					</td>
				</tr>	
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_trainer',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.planner_firstname#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_learner',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.user_firstname# #get_lessonnote.user_name#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_date',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#dateformat(get_lessonnote..lesson_start,'dd/mm/yyyy')#</span>
					</td>
				</tr>
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_time',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#timeformat(get_lessonnote.lesson_start,'HH:mm')# - #timeformat(get_lessonnote.lesson_end,'HH:mm')#</span>
					</td>
				</tr>							
				<tr>
					<td>
						<span style="font-size:12px;">#obj_translater.get_translate('table_th_duration_short',formation_id)#</span>
					</td>
					<td bgcolor="##FFFFFF">
						<span style="font-size:12px;">#get_lessonnote.lesson_duration# min</span>
					</td>
				</tr>		
			</table>

		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
					
						<h2 align="center" style="color:##871E2C; font-size:16px">#obj_translater.get_translate('ln_title_target_situation',formation_id)#</h2>	
						
						<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							
							<cfif listlen(lesson_skill_id) neq "0">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_want_to',formation_id)#</u></h3>
								<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
								SELECT skill_objectives_#lang_temp# as skill_objectives FROM lms_skill WHERE skill_id IN (#lesson_skill_id#)
								</cfquery>
								<ul>
								<cfloop query="get_skill">
								<li>#get_skill.skill_objectives#</li>
								</cfloop>
								</ul>
								</td>
							</tr>
							</cfif>
							
							<cfif lesson_na_needs neq "">
							<tr>
								<td>
								<h3><u>#obj_translater.get_translate('ln_title_initial',formation_id)#</u></h3>
								#replacenocase(lesson_na_needs,chr(10),"<br>","ALL")#
								</td>
							</tr>			
							
							</cfif>
						
						</table>
											
						
					</td>
				</tr>
				
				
			</table>
		</td>
	</tr>
	
	
</table>          
</cfoutput>
</body>
</html>
<cfelseif page eq "2">
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_na',formation_id)#</cfoutput> <cfif get_result_lst.recordcount neq "0">(2/5)<cfelse>(2/4)</cfif></h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>		
	<tr>
		<td width="100%" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<td width="100%" align="left">
				
					<cfoutput>
					
					<h2 align="center" style="color:##871E2C; font-size:16px">#obj_translater.get_translate('ln_title_strategy_analysis',formation_id)#</h2>

					<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
					
						<tr>
							<td>
								<h3><u>#ucase(obj_translater.get_translate('ln_title_how',formation_id))#</u></h3>
								
								<cfif listlen(user_needs_course) neq "0">
								<strong>#obj_translater.get_translate('table_th_mini_course_pref',formation_id)#</strong><br>
								<ul>
								<cfloop list="#user_needs_course#" index="cor">
									<cfif cor eq "1"><li>Structural lessons</li></cfif>
									<cfif cor eq "2"><li>Open lessons</li></cfif>
									<cfif cor eq "3"><li>Workshop</li></cfif>
								</cfloop>
								</ul>
								</cfif>
							
								<cfif user_needs_duration neq "">
								<br>
								<strong>#obj_translater.get_translate('table_th_mini_course_duration',formation_id)#</strong><br>
								<ul>
									<li>#user_needs_duration# min</li>
								</ul>
								</cfif>
								
								<cfif user_needs_frequency neq "">
								<br>
								<strong>#obj_translater.get_translate('table_th_mini_course_freq',formation_id)#</strong><br>
								<ul>	
								<cfif user_needs_frequency eq "1"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('day',formation_id)#</li></cfif>
								<cfif user_needs_frequency eq "2"><li>3 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
								<cfif user_needs_frequency eq "3"><li>2 #obj_translater.get_translate('lessons',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
								<cfif user_needs_frequency eq "4"><li>1 #obj_translater.get_translate('lesson',formation_id)# / #obj_translater.get_translate('week',formation_id)#</li></cfif>
								</ul>
								</cfif>
								
								<cfif user_needs_trainer neq "">
								<br>
								<strong>#obj_translater.get_translate('table_th_mini_trainer_franco',formation_id)#</strong><br>
								<ul>
									<cfif user_needs_trainer eq "1"><li>#obj_translater.get_translate('yes',formation_id)#</li></cfif>
									<cfif user_needs_trainer eq "0"><li>#obj_translater.get_translate('no',formation_id)#</li></cfif>
								</ul>
								</cfif>
								
								<cfif user_needs_nbtrainer neq "">
								<br>							
								<strong>#obj_translater.get_translate('table_th_mini_trainer_nb',formation_id)#</strong><br>							
								<ul>
									<cfif user_needs_nbtrainer eq "1"><li>#obj_translater.get_translate('needs_txt_trainer_mono',formation_id)#</li></cfif>
									<cfif user_needs_nbtrainer eq "2"><li>#obj_translater.get_translate('needs_txt_trainer_several',formation_id)#</li></cfif>
								</ul>
								</cfif>
								
							</td>
						</tr>
							
							
					</table>
					
					<br><br>
					<h2 align="center" style="color:##871E2C; font-size:16px">#obj_translater.get_translate('ln_title_learner_profile',formation_id)#</h2>
					
					
					<table bgcolor="##EFEFEF" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
					</cfoutput>
						<tr>
							<td>
							
								
								
								
								<cfif listlen(interest_id) neq "0">
								<h3><u><cfoutput>#obj_translater.get_translate('ln_title_interests',formation_id)#</cfoutput></u></h3>
								<cfquery name="get_keywords" datasource="#SESSION.BDDSOURCE#">
								SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, kc.keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name, kc.keyword_cat_id
								FROM lms_keyword k 
								INNER JOIN lms_keyword_category kc ON k.keyword_cat_id = kc.keyword_cat_id
								WHERE keyword_id IN (#interest_id#) ORDER BY k.keyword_cat_id DESC
								</cfquery>

								<cfoutput query="get_keywords" group="keyword_cat_id">
									<strong>#keyword_cat_name#</strong>
									<br>
									<cfoutput>
									#keyword_name#<br>
									</cfoutput>
								</cfoutput>		
												
								</cfif>
								
								
								<cfoutput>
								
								<cfif user_qpt neq "" AND user_qpt_lock eq "1">
								
								<h3><u>#ucase(obj_translater.get_translate('ln_title_level',formation_id))#</u></h3>
								
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
														
								</cfif>
														
							</td>
							
						</tr>
					</table>
					</cfoutput>
				</td>
			</table>			
		</td>
	</tr>
</table>           

</body>
</html>
<cfelseif page eq "3">
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_na',formation_id)#</cfoutput> <cfif get_result_lst.recordcount neq "0">(3/5)<cfelse>(3/4)</cfif></h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
						<h2 align="center" style="color:#871E2C; font-size:16px">YOUR TRAINING PROGRAM</h2>	
								
						<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; margin-top:20px" width="100%" cellpadding="5" cellspacing="2">		
							<cfoutput query="get_session" group="session_id">
							<tr>
								<td width="50" bgcolor="##FFFFFF">
									<span style="font-size:12px;">#obj_lms.get_thumb_session(sessionmaster_code="#sessionmaster_code#",sessionmaster_id="#sessionmaster_id#",size="50")#</span>
									
								</td>
								<td width="100" bgcolor="##FFFFFF">
									<span style="font-size:12px;">Lesson&nbsp;#session_rank#</span>
								</td>
								<td width="100" bgcolor="##FFFFFF">
									<span style="font-size:12px;">#session_duration#min</span>
								</td>
								<td bgcolor="##FFFFFF">
									<span style="font-size:12px;"><strong>#sessionmaster_name#</strong></span>
								</td>
								<!---<td bgcolor="##FFFFFF">
									<span style="font-size:12px;"><strong>#sessionmaster_description#</strong></span>
								</td>--->
							</tr>
							</cfoutput>
						</table>		

					</td>
				</tr>		
			</table>
		</td>
	</tr>
	
	
</table>           

</body>
</html>

<cfelseif page eq "4">
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
</head>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_na',formation_id)#</cfoutput> <cfif get_result_lst.recordcount neq "0">(4/5)</cfif></h2>
					</td>
				</tr>
			</table>
		</td>
	</tr>		
	
	
	<cfquery name="get_total_lst" datasource="#SESSION.BDDSOURCE#">
	SELECT lqa.ans_flag, COUNT(lqr.ans_id) as nb
	FROM lms_quiz_answer lqa
	INNER JOIN lms_quiz_result lqr ON lqa.ans_id = lqr.ans_id
	WHERE lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
	GROUP BY lqa.ans_flag
	</cfquery>
	
	<cfset TEMP_LB = "0">
	<cfset TEMP_RB = "0">
	<cfset TEMP_INT = "0">
	<cfset TEMP_EXT = "0">
	<cfset TEMP_VNV = "0">
	<cfset TEMP_K = "0">
	<cfset TEMP_VV = "0">
	<cfset TEMP_AV = "0">
	
	<cfoutput query="get_total_lst">
		<cfif ans_flag eq "LB"> 
			<cfset TEMP_LB = nb>
		<cfelseif ans_flag eq "RB">
			<cfset TEMP_RB = nb>
		<cfelseif ans_flag eq "INT">
			<cfset TEMP_INT = nb>
		<cfelseif ans_flag eq "EXT">
			<cfset TEMP_EXT = nb>
		<cfelseif ans_flag eq "VNV">
			<cfset TEMP_VNV = nb>
		<cfelseif ans_flag eq "K">
			<cfset TEMP_K = nb>
		<cfelseif ans_flag eq "VV">
			<cfset TEMP_VV = nb>
		<cfelseif ans_flag eq "AV">
			<cfset TEMP_AV = nb>
		</cfif>
	</cfoutput>
	
	<cfset total_brain = TEMP_LB+TEMP_RB>
	<cfset total_social = TEMP_INT+TEMP_EXT>
	<cfset total_sensory = TEMP_VNV+TEMP_K+TEMP_VV+TEMP_AV>
	
	<cfif TEMP_LB eq "0"><cfset user_lst = "0"><cfelse><cfset user_lst = "#round((TEMP_LB/total_brain)*100)#"></cfif>
	<cfif TEMP_RB eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_RB/total_brain)*100)#"></cfif>
	<cfif TEMP_INT eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_INT/total_social)*100)#"></cfif>	
	<cfif TEMP_EXT eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_EXT/total_social)*100)#"></cfif>
	<cfif TEMP_VNV eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_VNV/total_sensory)*100)#"></cfif>
	<cfif TEMP_K eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_K/total_sensory)*100)#"></cfif>
	<cfif TEMP_VV eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_VV/total_sensory)*100)#"></cfif>
	<cfif TEMP_AV eq "0"><cfset user_lst = user_lst&",0"><cfelse><cfset user_lst = user_lst&",#round((TEMP_AV/total_sensory)*100)#"></cfif>
	

	<tr>
		<td width="100%" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td width="100%" align="left">
						<h2 align="center" style="color:#871E2C; font-size:16px">YOUR LEARNING STYLE</h2>	
								
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="10" cellspacing="0">
							<tr>
								<td bgcolor="#ECECEC" width="250">
								<cfset lst_display = "radar">
								<cfinclude template="../incl/incl_lst_pdf.cfm">
								</td>
								<td>
								<cfset lst_display = "radar_txt">
								<cfinclude template="../incl/incl_lst_pdf.cfm">
								</td>
							</tr>
						</table>
						
						
						
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:15px" width="100%" cellpadding="10" cellspacing="0">
							<tr>
								<td bgcolor="#ECECEC">
								Brain dominance
								</td>
								<td>
								<cfset lst_display = "brain_txt">
								<cfinclude template="../incl/incl_lst_pdf.cfm">
								</td>
							</tr>
						</table>
							
						<cfdocumentitem type="pagebreak" />
						<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px; margin-top:15px" width="100%" cellpadding="10" cellspacing="0">
							<tr>
								<td colspan="2" height="10"></td>
							</tr>
							<tr>
								<td bgcolor="#ECECEC">
								Socialization
								</td>
								<td>
								<cfset lst_display = "social_txt">
								<cfinclude template="../incl/incl_lst_pdf.cfm">
								</td>
							</tr>
							<tr>
								<td colspan="2" height="10"></td>
							</tr>
							<tr>
								<td bgcolor="#ECECEC">
								Sensory Perception
								</td>
								<td>
								<cfset lst_display = "sensory_txt">
								<cfinclude template="../incl/incl_lst_pdf.cfm">
								</td>
							</tr>
							
						</table>
							
	
					</td>
				</tr>		
			</table>
		</td>
	</tr>
	
	
</table>           

</body>
</html>

<cfelseif page eq "5">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="15">		
				<tr>				
					<td style="padding:20px" align="center">
						<em style="font-size:13px"><cfoutput>#get_lessonnote.lesson_footer#</cfoutput></em>
					</td>
				</tr>
			</table>
		</td>
	</tr>		
	
</table>	

<!---
<html>
<body style="width:100%; margin:0px; padding:0px">

<table style="font-family:Arial, Helvetica, sans-serif; font-size:11px;" width="100%" cellpadding="0" cellspacing="0">

	<tr>
		<td width="100%" align="center" style="padding:20px">		
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="15">
				<tr>
					<td width="100%" align="center">
						<h2><cfoutput>#obj_translater.get_translate('ln_title_na',formation_id)#</cfoutput> <cfif get_result_lst.recordcount neq "0">(5/5)<cfelse>(4/4)</cfif></h2>	
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	
	<tr>
		<td width="100%" style="padding:20px 20px 0px 20px">
			<table style="font-family:Arial, Helvetica, sans-serif; font-size:12px;" width="100%" cellpadding="0" cellspacing="0">
				<td width="100%" align="left">
					
					<h2 align="center" style="color:#871E2C; font-size:16px">CONCLUSION</h2>	
					<p style="margin-top:10px">
					
					</p>
				</td>
			</td>		
			
		</td>
	</tr>
	
	<tr>
		<td width="100%" align="center" style="padding:20px 70px 0px 70px">
			<table bgcolor="#ECECEC" style="font-family:Arial, Helvetica, sans-serif; font-size:12px; border:1px solid #ECECEC" width="100%" cellpadding="20" cellspacing="0">
				<tr>
					<td width="60%" align="left">
						<cfoutput>
						#get_lessonnote.planner_firstname#, WEFIT Corporate Trainer<br>
						#dateformat(get_lessonnote.lesson_date,'dd/mm/yyyy')#
						</cfoutput>
					</td>
					<td width="40%" align="left" bgcolor="#FFF">
						<!---#obj_lms.get_trainer_signature(planner_id,180)#--->
						<cfoutput><img src="../assets/user/#get_lessonnote.planner_id#/signature.png" align="center" width="180"></cfoutput>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
</table>           

</body>
</html>--->

</cfif>

