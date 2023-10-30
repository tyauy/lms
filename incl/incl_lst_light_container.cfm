<style>
.greyed {
	-webkit-filter: grayscale(90%) !important;
	filter: grayscale(90%) !important;
}
</style>

<cfquery name="get_quiz_type" datasource="#SESSION.BDDSOURCE#">
SELECT q.quiz_type 
FROM lms_quiz_user qu
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
</cfquery>
		
<cfquery name="get_total_lst" datasource="#SESSION.BDDSOURCE#">
SELECT lqa.ans_flag, COUNT(lqr.ans_id) as nb
FROM lms_quiz_answer lqa
INNER JOIN lms_quiz_result lqr ON lqa.ans_id = lqr.ans_id
WHERE lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
GROUP BY lqa.ans_flag
</cfquery>

<cfif get_quiz_type.quiz_type eq "lst_sociability">

<cfset TEMP_INT = 0>
<cfset TEMP_EXT = 0>

<cfoutput query="get_total_lst">
<cfif ans_flag eq "INT">
	<cfset TEMP_INT = nb>
<cfelseif ans_flag eq "EXT">
	<cfset TEMP_EXT = nb>
</cfif>
</cfoutput>

<cfset total_social = TEMP_INT+TEMP_EXT>
<cfset TEMP_INT = round(TEMP_INT/total_social*100)>
<cfset TEMP_EXT = round(TEMP_EXT/total_social*100)>
	
<div class="row justify-content-md-center" style="margin-top:25px">									
	<div class="col-md-4">		
		<div class="card">
			<img class="card-img-top <cfif TEMP_INT gt TEMP_EXT><cfelse>greyed</cfif>" src="./assets/img/lst_introvert.jpg">
			<div class="card-body <cfif TEMP_INT gt TEMP_EXT>border border-success<cfelse>border</cfif> p-3 d-flex flex-column">
			
				<div align="center">
					<h5 class="d-inline <cfif TEMP_INT gt TEMP_EXT>text-success<cfelse>text-dark</cfif>"> INTROVERTI</h5><br>
				</div>
							
				<p class="mt-4 mb-4" align="center">
				
				<cfoutput>
				<cfif TEMP_INT gt TEMP_EXT>
				<h1 align="center" class="text-success">#TEMP_INT# %</h1>
				<cfelse>
				<h1 align="center" class="text-dark">#TEMP_INT# %</h1>
				</cfif>
				
				#obj_translater.get_translate_complex('social_introvert_lst')#
				</cfoutput>
				
				
				
				</p>
				
			</div>
		</div>
		
	</div>
	<div class="col-md-4">
		<div class="card">
			<img class="card-img-top <cfif TEMP_INT lt TEMP_EXT><cfelse>greyed</cfif>" src="./assets/img/lst_extrovert.jpg">
			<div class="card-body <cfif TEMP_INT lt TEMP_EXT>border border-success<cfelse>border</cfif> p-3 d-flex flex-column">
				
				<div align="center">
					<h5 class="d-inline <cfif TEMP_INT lt TEMP_EXT>text-success<cfelse>text-dark</cfif>"> EXTRAVERTI</h5><br>
				</div>
							
				<p class="mt-4 mb-4" align="center">
				
				<cfoutput>
				<cfif TEMP_INT lt TEMP_EXT>
				<h1 align="center" class="text-success">#TEMP_EXT# %</h1>			
				<cfelse>
				<h1 align="center" class="text-dark">#TEMP_EXT# %</h1>
				</cfif>
				
				#obj_translater.get_translate_complex('social_extrovert_lst')#
				</cfoutput>
				
				</p>
				
			</div>
		</div>
		
	</div>
</div>

<cfelseif get_quiz_type.quiz_type eq "lst_brain">

<cfset TEMP_LB = 0>
<cfset TEMP_RB = 0>

<cfoutput query="get_total_lst">
<cfif ans_flag eq "LB"> 
	<cfset TEMP_LB = nb>
<cfelseif ans_flag eq "RB">
	<cfset TEMP_RB = nb>
</cfif>
</cfoutput>

<cfset total_brain = TEMP_LB+TEMP_RB>
<cfset TEMP_LB = round(TEMP_LB/total_brain*100)>
<cfset TEMP_RB = round(TEMP_RB/total_brain*100)>


<div class="row justify-content-md-center" style="margin-top:25px">									
	<div class="col-md-4">		
		<div class="card">
			<img class="card-img-top <cfif TEMP_LB gt TEMP_RB><cfelse>greyed</cfif>" src="./assets/img/lst_left.jpg">
			<div class="card-body <cfif TEMP_LB gt TEMP_RB>border border-success<cfelse>border</cfif> p-3 d-flex flex-column">
			
				<div align="center">
					<h5 class="d-inline <cfif TEMP_LB gt TEMP_RB>text-success<cfelse>text-dark</cfif>">HÉMISPHÈRE GAUCHE</h5><br>
				</div>
							
				<p class="mt-4 mb-4" align="center">
				
				<cfoutput>
				<cfif TEMP_LB gt TEMP_RB>
				<h1 align="center" class="text-success">#TEMP_LB# %</h1>
				<cfelse>
				<h1 align="center" class="text-dark">#TEMP_LB# %</h1>
				</cfif>
				</cfoutput>
				
				<cfoutput>
				<h6>#obj_translater.get_translate_complex('brain_process_title')#</h6>
				#obj_translater.get_translate_complex('left_brain_process_lst')#
				<h6>#obj_translater.get_translate_complex('brain_strengths_title')#</h6>
				#obj_translater.get_translate_complex('left_brain_strengths_lst')#
				<h6>#obj_translater.get_translate_complex('brain_learning_title')#</h6>
				#obj_translater.get_translate_complex('left_brain_learning_lst')#
				</cfoutput>
				</p>
				
			</div>
		</div>
		
	</div>
	<div class="col-md-4">
		<div class="card">
			<img class="card-img-top <cfif TEMP_LB lt TEMP_RB><cfelse>greyed</cfif>" src="./assets/img/lst_right.jpg">
			<div class="card-body <cfif TEMP_LB lt TEMP_RB>border border-success<cfelse>border</cfif> p-3 d-flex flex-column">
				
				<div align="center">
					<h5 class="d-inline <cfif TEMP_LB lt TEMP_RB>text-success<cfelse>text-dark</cfif>">HÉMISPHÈRE DROIT</h5><br>
				</div>
							
				<p class="mt-4 mb-4" align="center">
				
				<cfoutput>
				<cfif TEMP_LB lt TEMP_RB>
				<h1 align="center" class="text-success">#TEMP_RB# %</h1>
				<cfelse>
				<h1 align="center" class="text-dark">#TEMP_RB# %</h1>
				</cfif>
				</cfoutput>
				
				<cfoutput>
				<h6>#obj_translater.get_translate_complex('brain_process_title')#</h6>
				#obj_translater.get_translate_complex('right_brain_process_lst')#
				<h6>#obj_translater.get_translate_complex('brain_strengths_title')#</h6>
				#obj_translater.get_translate_complex('right_brain_strengths_lst')#
				<h6>#obj_translater.get_translate_complex('brain_learning_title')#</h6>
				#obj_translater.get_translate_complex('right_brain_learning_lst')#
				</cfoutput>
				</p>
				
			</div>
		</div>
		
	</div>
</div>

<cfelseif get_quiz_type.quiz_type eq "lst_memory">

<cfset TEMP_VNV = 0>
<cfset TEMP_K = 0>
<cfset TEMP_VV = 0>
<cfset TEMP_AV = 0>

<cfoutput query="get_total_lst">
<cfif ans_flag eq "VNV">
	<cfset TEMP_VNV = nb>
<cfelseif ans_flag eq "K">
	<cfset TEMP_K = nb>
<cfelseif ans_flag eq "VV">
	<cfset TEMP_VV = nb>
<cfelseif ans_flag eq "AV">
	<cfset TEMP_AV = nb>
</cfif>
</cfoutput>

<cfset total_sensory = TEMP_VNV+TEMP_K+TEMP_VV+TEMP_AV>

<cfif TEMP_VNV eq "">
	<cfset TEMP_VNV = 0>
<cfelse>
	<cfset TEMP_VNV = round(TEMP_VNV/total_sensory*100)>
</cfif>

<cfif TEMP_K eq "">
	<cfset TEMP_K = 0>
<cfelse>
	<cfset TEMP_K = round(TEMP_K/total_sensory*100)>
</cfif>

<cfif TEMP_VV eq "">
	<cfset TEMP_VV = 0>
<cfelse>
	<cfset TEMP_VV = round(TEMP_VV/total_sensory*100)>
</cfif>

<cfif TEMP_AV eq "">
	<cfset TEMP_AV = 0>
<cfelse>
	<cfset TEMP_AV = round(TEMP_AV/total_sensory*100)>
</cfif>

<cfset list_temp = "#TEMP_VNV#_VNV,#TEMP_K#_K,#TEMP_VV#_VV,#TEMP_AV#_AV">
<cfset list_temp2 = ListSort(list_temp,"TextNoCase","desc")>
<!--- <cfoutput> --->
<!--- list_temp -- #list_temp# --->


<!--- <br> --->

<!--- list_temp2 -- #list_temp2# --->

<!--- </cfoutput> --->



	<cfset counter = 0>
	<cfloop list="#list_temp2#" index="cor">
	<cfset counter ++>
	<cfset cor2 = listgetat(cor,"2","_")>
	<cfset pc_cor2 = evaluate("TEMP_#cor2#")>
	
	<cfif counter eq "1" OR (counter eq 2 AND isdefined("pc_before") AND pc_before eq pc_cor2)>
		<cfset highlight = 1>
	<cfelse>
		<cfset highlight = 0>
	</cfif>
	<div class="row" style="margin-top:25px">
		<div class="col-md-12">
			<div class="card <cfif highlight eq "1">border border-success<cfelse>border</cfif>">
				<table class="table table-borderless">
				<tr>
				<td align="center" width="30%" <cfif highlight eq "1">class="border-success</cfif>">
				<cfif highlight eq "1"><h3 class="text-success m-0"><cfelse><h5 class="text-dark m-0"></cfif>

				<cfif cor2 eq "AV">
				AUDITIF / VERBAL
				<cfelseif cor2 eq "K">
				KINESTHÉSIQUE
				<cfelseif cor2 eq "VV">
				VISUEL / VERBAL
				<cfelseif cor2 eq "VNV">
				VISUEL / NON VERBAL
				</cfif>

				<br>
				<cfoutput>
				#pc_cor2# %
				</cfoutput>

				<cfif highlight eq "1"></h3><cfelse></h5></cfif>
				<br>
				<div class="progress">
				<div class="progress-bar <cfif highlight eq "1">bg-success<cfelse>bg-secondary</cfif>" role="progressbar" style="width: <cfoutput>#pc_cor2#</cfoutput>%" aria-valuenow="<cfoutput>#pc_cor2#</cfoutput>" aria-valuemin="0" aria-valuemax="100"></div>
				</div>

				</td>
				<td width="40%">
				<strong>Supports de cours conseillés</strong> :<br>
				
				<cfif cor2 eq "AV">
					<h5 style="font-size:17px">
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Podcasts</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Chansons</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Programmes audio</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Lecteurs texte-parole</span>
					</h5>
					<cfoutput>
					
					</cfoutput>
					Vous êtes sensible aux supports vous permettant de traiter l'information en écoutant.
					Vous apprendrez mieux dans les contextes suivants : conférences, exercices oraux, discussions, entretiens, lecture à haute voix...
					
				<cfelseif cor2 eq "K">
				

					<h5 style="font-size:17px">
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Podcasts</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Articles</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Bandes dessinées</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Post-it</span>
					</h5>
L'apprentissage est facilité par la pratique, l'engagement dans une activité manuelle. 
<br>
Vous apprenez mieux en prenant des notes, en illustrant l'information, en utilisant un tableau blanc, en jouant un rôle, ou toute activité en mode tactile.



				<cfelseif cor2 eq "VV">
					<h5 style="font-size:17px">
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Articles</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Rapports</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Sommaires / Résumés</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Journaux</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Magazines</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Tableau blanc</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Blogs</span>
					</h5>
					Tous les supports vous permettant de traiter les informations par la lecture sont utiles. Vous apprendrez mieux en décrivant, en lisant, en dictant, en rédigeant une synthèse, en écrivant des dialogues, en localisant des mots.
				<cfelseif cor2 eq "VNV">
					<h5 style="font-size:15px">				
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Images</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Graphiques</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Schémas</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Cartes</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Photos</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Légendes</span>
					<span class="badge badge-pill <cfif highlight eq "1">badge-success<cfelse>badge-secondary</cfif>">Bandes dessinées</span>
					</h5>
					Dans un contexte d'apprentissage, le traitement de l'information sera optimal lorsque vous visualisez les supports, sans accompagnement de paroles.  
					<br>
					Vous apprenez mieux en analysant une photo, en tirant des conclusions à partir de graphiques, en décrivant, en dessinant, en organisant des informations, en traduisant des mots en images.
					
				</cfif>
				

				</td>
				</tr>		
				</table>
			</div>
		</div>
	</div>
	<cfset pc_before = evaluate("TEMP_#cor2#")>
	</cfloop>
			
	
	
	
	<!--- <div class="col-md-3"> --->
		<!--- <div class="card"> --->
			<!--- <img class="card-img-top" src="./assets/img/lst_kinesthetic.jpg"> --->
			<!--- <div class="card-body <cfif TEMP_LB lt TEMP_RB>border border-success<cfelse>border</cfif> p-3 d-flex flex-column"> --->
				
				<!--- <div align="center"> --->
					<!--- <h5 class="d-inline <cfif TEMP_LB lt TEMP_RB>text-success<cfelse>text-dark</cfif>"><i class="fal fa-hands-helping fa-lg"></i> KINESTHETIC</h5><br> --->
				<!--- </div> --->
							
				<!--- <p class="mt-4 mb-4" align="center"> --->
				
				<!--- <cfoutput> --->
				<!--- <cfif TEMP_LB lt TEMP_RB> --->
				<!--- <h1 align="center" class="text-success">#TEMP_K# %</h1> --->
				<!--- <cfelse> --->
				<!--- <h1 align="center" class="text-dark">#TEMP_K# %</h1> --->
				<!--- </cfif> --->
				<!--- </cfoutput> --->
				
				<!--- </p> --->
				
			<!--- </div> --->
		<!--- </div> --->
		
	<!--- </div> --->
	<!--- <div class="col-md-3"> --->
		<!--- <div class="card"> --->
			<!--- <img class="card-img-top" src="./assets/img/lst_verbal_visual.jpg"> --->
			<!--- <div class="card-body <cfif TEMP_LB lt TEMP_RB>border border-success<cfelse>border</cfif> p-3 d-flex flex-column"> --->
				
				<!--- <div align="center"> --->
					<!--- <h5 class="d-inline <cfif TEMP_LB lt TEMP_RB>text-success<cfelse>text-dark</cfif>"><i class="fal fa-hands-helping fa-lg"></i> VERBAL VISUAL</h5><br> --->
				<!--- </div> --->
							
				<!--- <p class="mt-4 mb-4" align="center"> --->
				
				<!--- <cfoutput> --->
				<!--- <cfif TEMP_LB lt TEMP_RB> --->
				<!--- <h1 align="center" class="text-success">#TEMP_VV# %</h1> --->
				<!--- <cfelse> --->
				<!--- <h1 align="center" class="text-dark">#TEMP_VV# %</h1> --->
				<!--- </cfif> --->
				<!--- </cfoutput> --->
				
				<!--- </p> --->
				
			<!--- </div> --->
		<!--- </div> --->
		
	<!--- </div> --->
	<!--- <div class="col-md-3"> --->
		<!--- <div class="card"> --->
			<!--- <img class="card-img-top" src="./assets/img/lst_auditory_verbal.jpg"> --->
			<!--- <div class="card-body <cfif TEMP_LB lt TEMP_RB>border border-success<cfelse>border</cfif> p-3 d-flex flex-column"> --->
				
				<!--- <div align="center"> --->
					<!--- <h5 class="d-inline <cfif TEMP_LB lt TEMP_RB>text-success<cfelse>text-dark</cfif>"><i class="fal fa-hands-helping fa-lg"></i> AUDITORY VERBAL</h5><br> --->
				<!--- </div> --->
							
				<!--- <p class="mt-4 mb-4" align="center"> --->
				
				<!--- <cfoutput> --->
				<!--- <cfif TEMP_LB lt TEMP_RB> --->
				<!--- <h1 align="center" class="text-success">#TEMP_AV# %</h1> --->
				<!--- <cfelse> --->
				<!--- <h1 align="center" class="text-dark">#TEMP_AV# %</h1> --->
				<!--- </cfif> --->
				<!--- </cfoutput> --->
				
				<!--- </p> --->
				
			<!--- </div> --->
		<!--- </div> --->
		
	<!--- </div> --->


</cfif>



<!--- <cfset total_brain = TEMP_LB+TEMP_RB> --->
<!--- <cfset total_social = TEMP_INT+TEMP_EXT> --->
<!--- <cfset total_sensory = TEMP_VNV+TEMP_K+TEMP_VV+TEMP_AV> --->

<!--- <cfoutput> --->
<!--- total_brain= #total_brain#<br> --->
<!--- total_social= #total_social#<br> --->
<!--- total_sensory = #total_sensory#<br> --->
<!--- </cfoutput> --->

<!--- <cfabort> --->

<!--- <cfset user_lst = "#round((TEMP_LB/total_brain)*100)#,#round((TEMP_RB/total_brain)*100)#,#round((TEMP_INT/total_social)*100)#,#round((TEMP_EXT/total_social)*100)#,#round((TEMP_VNV/total_sensory)*100)#,#round((TEMP_K/total_sensory)*100)#,#round((TEMP_VV/total_sensory)*100)#,#round((TEMP_AV/total_sensory)*100)#"> --->

<!--- <div class="row mt-2">										 --->
	<!--- <div class="col-md-3">									 --->
	<!--- <cfset lst_display = "radar"> --->
	<!--- <cfinclude template="./incl_lst.cfm"> --->
	<!--- </div> --->
	<!--- <div class="col-md-9"> --->
	<!--- <cfset lst_display = "radar_txt"> --->
	<!--- <cfinclude template="./incl_lst.cfm"> --->
	<!--- </div> --->
<!--- </div> --->


	
