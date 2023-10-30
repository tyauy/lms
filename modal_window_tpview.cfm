<cfif isdefined("t_id") AND isdefined("u_id")>


<!----- CREATE TP IF TP PREFILLED CHOSEN ---->
<cfif isdefined("tpmaster_id")>

	<cfset obj_tp = createobject("component", "updater_tp")>
	<cfset temp = obj_tp.add_prebuilt(tpmaster_id="#tpmaster_id#",u_id="#u_id#",t_id="#t_id#")>

</cfif>

<form action="updater_form.cfm" method="post" id="tp_form">	
	<div class="row">
		<div class="col-md-12 mt-3">
			
			<img src="./assets/img/qpt_en.jpg" class="mr-4" align="left" width="190">
			
			<p>
			<cfoutput>#obj_translater.get_translate_complex('tpview_intro')#</cfoutput>
			</p>
			
			<div align="center">
				<cfif isdefined("tpmaster_id")>
				<cfoutput><a class="btn btn-link text-red" href="./tpl/tp_container.cfm?tppack_id=#tpmaster_id#" target="_blank"><i class="far fa-file-pdf"></i> #obj_translater.get_translate('btn_download')#</a>	</cfoutput>		
				</cfif>
				<input type="hidden" name="form_type" value="tp_form">
				<button class="btn btn-red" type="submit">
				<i class="fas fa-check"></i> <cfoutput>#obj_translater.get_translate('btn_validate_tpstep')#</cfoutput>
				</button>
			</div>
			
		</div>			
	</div>
</form>

		<cfset get_session = obj_tp_get.oget_session(u_id="#u_id#",t_id="#t_id#")>
		
		<cfset __text_about = obj_translater.get_translate('text_about')>
		<cfset __lesson = obj_translater.get_translate('lesson')>

		<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
		<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
		<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
		<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>
		<cfset __tooltip_add_favourite = obj_translater.get_translate('tooltip_add_favourite')>
		<cfset __tooltip_remove_favourite = obj_translater.get_translate('tooltip_remove_favourite')>

		<cfset __card_keywords = obj_translater.get_translate('card_keywords')>
		<cfset __card_grammar = obj_translater.get_translate('card_grammar')>
		<cfset __btn_details = "Details">
		
		<cfset css="info">					


		<cfoutput query="get_session" group="session_rank">
		<div class="border-top p-3 bg-white">
			<div class="row">
				<div class="col-1">
					#obj_lms.get_thumb_mini_session(sessionmaster_id="#sessionmaster_id#",sessionmaster_code="#sessionmaster_code#",size="100")#
				</div>
				<div class="col-2">
					<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"WS") eq "1">
						<i class="fal fa-book fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#"></i>
					<cfelse>
						<i class="fal fa-book fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_material#" style="color:##ECECEC"></i>
					</cfif>

					<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"audio") eq "1">
						<i class="fal fa-volume-up fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#"></i>
					<cfelse>
						<i class="fal fa-volume-up fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_audio_content#" style="color:##ECECEC"></i>
					</cfif>

					<cfif obj_lms.get_ressource_exists(sessionmaster_ressource,"video") eq "1" OR sessionmaster_ressource neq "">
						<i class="fal fa-film fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#"></i>
					<cfelse>
						<i class="fal fa-film fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_video_content#" style="color:##ECECEC"></i>
					</cfif>

							<!--- <cfif quiz_id neq "" AND quiz_id neq "0"> --->
							<!--- <i class="fal fa-tasks fa-lg text-#css# m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#"></i> --->
							<!--- <cfelse> --->
							<!--- <i class="fal fa-tasks fa-lg m-2" data-toggle="tooltip" data-placement="top" title="#__tooltip_quiz_content#" style="color:##ECECEC"></i> --->
							<!--- </cfif> --->
				</div>
				<div class="col-8">
					<strong>#session_rank# - #sessionmaster_name#</strong>
					<br>
					<small>#sessionmaster_description#</small>
					<!--- <small>#mid(sessionmaster_description,1,120)# [...]</small> --->
					<span class="btn_view_session" id="sm_#sessionmaster_id#">
						<!---<small style="cursor:pointer; font-weight:bold"><strong>[more info]</strong></small>--->
					</span>
					<cfif keyword_id neq "">
					<br>
					<small>#__card_keywords# :</small>
					<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
						SELECT keyword_id as k_id, keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword WHERE keyword_id IN (#keyword_id#)
					</cfquery>
					<cfloop query="get_keyword"><span class="badge badge-pill border">#keyword_name#</span> </cfloop>
					</cfif>
				</div>


				<div class="col-1">

					<a href="##" class="badge badge-pill p-2 badge-info text-white">#session_duration# min</strong></a>

				</div>
				
			</div>
		</div>
		</cfoutput>	

</cfif>		