<cfparam name="h" default="index">
			
<cfoutput>

<div class="row" style="margin-top:5px">
	<div class="col-md-12">
	
		<!----------------E LEARNING HELP ---------------------->
		<cfif h eq "el">
			
			<h3 class="text-warning mt-0 mb-4" align="center"><small>#obj_translater.get_translate_complex('el_intro_title')#</small></h3>
			
			<p align="left">
			
				<h6 class="text-warning">#obj_translater.get_translate_complex('el_program_title')#</h6>
				
				<div class="media">
				<i class="far fa-folder-open fa-2x text-warning align-self-center mr-3"></i>
				<div class="media-body">
				
				#obj_translater.get_translate_complex('lrn_add_elrn_course')#
				
				</div>
				</div>
				<br>
				
				<h6 class="text-warning">#obj_translater.get_translate_complex('el_contents_title')#</h6>
				
				<table class="table bg-white mt-2" style="margin-bottom:0px !important">
					<tr>	
						<td width="5%">
							<i class="fas fa-book fa-lg text-warning"></i>
						</td>
						<td width="20%">
							<small><strong>#obj_translater.get_translate('table_th_material')#</strong></small>
						</td>
						<td>
							
							#obj_translater.get_translate_complex('elrn_contain_material')#
							
						</td>
					</tr>
					<tr>	
						<td>
							<i class="fas fa-volume-up fa-lg text-warning"></i>
						</td>
						<td>
							<small><strong>#obj_translater.get_translate('table_th_audio')#</strong></small>
						</td>
						<td>
							
							#obj_translater.get_translate_complex('elrn_contain_audios')#
							
						</td>
					</tr>
					<tr>	
						<td>
							<i class="fas fa-video fa-lg text-warning"></i>
						</td>
						<td>
							<small><strong>#obj_translater.get_translate('table_th_video')#</strong></small>
						</td>
						<td>
							
							#obj_translater.get_translate_complex('elrn_contain_video')#
							
						</td>
					</tr>
					<tr>	
						<td>
							<i class="fas fa-tasks fa-lg text-warning"></i>
						</td>
						<td>
							<small><strong>#obj_translater.get_translate('table_th_practical_exercice')#</strong></small>
						</td>
						<td>
							
							#obj_translater.get_translate_complex('elrn_contain_practical_exercice')#
							
						</td>
					</tr>
					<tr>	
						<td>
							<i class="fas fa-clipboard-check fa-lg text-warning"></i>
						</td>
						<td>
							<small><strong>#obj_translater.get_translate('table_th_quiz')#</strong></small>
						</td>
						<td>
						
						#obj_translater.get_translate_complex('elrn_contain_quizz')#
						
						</td>
					</tr>
					<tr>	
						<td>
							<i class="fas fa-comments fa-lg text-warning"></i>
						</td>
						<td>
							<small><strong>#obj_translater.get_translate('table_th_vocab_list')#</strong></small>
						</td>
						<td>
						
						#obj_translater.get_translate_complex('elrn_contain_vocablist')#
						
						</td>
					</tr>
					
				</table>
				
			</p>
			
			
		
		
		
		<!----------------HOMEPAGE HELP ---------------------->
		<cfelseif h eq "index">		
			
				<h3 class="text-warning m-0 font-weight-bold" align="center"><small>#obj_translater.get_translate_complex('homepage_intro_title')#</small></h3>
			
				<p align="left">
				<div class="media">
				<i class="fad fa-webcam fa-2x text-info align-self-center mr-3"></i>
				<div class="media-body">
				
				#obj_translater.get_translate_complex('e-training_explain')#
				
				</div>
				</div>
				<br>
				<div class="media">
				<i class="fad fa-laptop fa-2x text-success align-self-center mr-3"></i>
				<div class="media-body">
				
				#obj_translater.get_translate_complex('e-learning_explain')#
				
				</div>
				</div>				
				<br>
				<div class="media">
				<i class="fad fa-id-card fa-2x text-warning align-self-center mr-3"></i>
				<div class="media-body">
				
				#obj_translater.get_translate_complex('subscription_explain')#
				
				</div>
				</div>
				</p>
			
			
			
			
		<!----------------HOMEPAGE TM HELP ---------------------->
		<cfelseif h eq "tmindex">
			
			<cfif SESSION.LANG_CODE eq "fr">
				<h3 class="text-warning m-0 font-weight-bold" align="center"><small>#obj_translater.get_translate_complex('homepage_intro_title')#</small></h3>
			
				<p align="left">
				<div class="media">
				<i class="fas fa-file-invoice-dollar fa-2x text-info align-self-center mr-3"></i>
				<div class="media-body">
				Le bouton <strong>G&eacute;n&eacute;rer Devis</strong> 
				</div>
				</div>
				<br>
				
				</div>
				</p>
			<cfelseif SESSION.LANG_CODE eq "en">				
			<cfelseif SESSION.LANG_CODE eq "de">				
			<cfelseif SESSION.LANG_CODE eq "es">
			<cfelseif SESSION.LANG_CODE eq "it">
			</cfif>
			
		<!----------------LAUNCH STEP 2 ---------------------->
		<cfelseif h eq "lstep2">
			<cfoutput>
			<h4 class="pt-0 mt-0"><small>#obj_translater.get_translate_complex('course_duration_question')#</small></h4>

			<p>
			#obj_translater.get_translate_complex('course_duration_explain')#
			</p>

			<h4><small>#obj_translater.get_translate_complex('resources_question')#</small></h4>

			<div class="card-deck">
				<div class="card border border-info">
					<div class="card-body">
					<h6 class="text-info">#obj_translater.get_translate('structured_course')#</h6>
					<br>
					#obj_translater.get_translate_complex('needs_structured_course')#
					</div>
				</div>
				<div class="card border border-warning">
					<div class="card-body">
					<h6 class="text-warning">#obj_translater.get_translate('open_lesson')#</h6>
					<br>
					#obj_translater.get_translate_complex('needs_open_lesson_course')#
					</div>
				</div>
				<div class="card border border-success">
					<div class="card-body">
					<h6 class="text-success">#obj_translater.get_translate('workshop')#</h6>
					<br>
					#obj_translater.get_translate_complex('needs_workshop_course')#
					</div>
				</div>
			</div>
			
			<br>
			<br>
			#obj_translater.get_translate_complex('resources_explain')#
			<br>
			<br>
			
			<div align="center">
			<a href="##" role="button" class="btn btn-sm btn-warning" data-dismiss="modal"><i class="fas fa-arrow-right"></i> #obj_translater.get_translate('btn_build_tp')#</a>
			</div>
			</cfoutput>
		<!----------------TP DETAILS SCHEDULER ---------------------->
		<cfelseif h eq "tpbook">
		
		<p>
		<cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_1')#</cfoutput>
		</p>
		
		<p class="mb-0">
		<cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_2')#</cfoutput>
		</p>
		
		<div align="center"><a class="btn btn-info text-white"><i class="fal fa-play"></i> <span><cfoutput>#obj_translater.get_translate('btn_launch_lesson')#</cfoutput></span></a></div>
		
		<p>
		<cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_3')#</cfoutput>
		</p>
		
		<p>
		<cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_4')#</cfoutput>
		</p>
		
		<p>
		<cfoutput>#obj_translater.get_translate_complex('js_modal_text_firstlesson_5')#</cfoutput>
		</p>
			<!--- <div align="center"> --->
			<!--- <a href="##" role="button" class="btn btn-sm btn-warning" data-dismiss="modal"><i class="fas fa-arrow-right"></i> #obj_translater.get_translate('btn_build_tp')#</a> --->
			<!--- </div> --->
		
		</cfif>
	</div>
</div>
</cfoutput>
