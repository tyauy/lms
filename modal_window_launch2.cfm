<cfparam name="view" default="param_tp">

<cfset u_id = SESSION.USER_ID>
<cfset t_id = SESSION.TP_ID>
<cfset a_id = SESSION.ACCOUNT_ID>
<cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>	
<cfset f_id = get_tp.formation_id>
<cfset f_code = get_tp.formation_code>	
<cfset tp_master_hour = get_tp.tp_duration/60>		
<cfset tp_orientation_select = get_tp.tp_orientation_id>
<cfset tp_interest_select = get_tp.tp_interest_id>
<cfset tp_function_select = get_tp.tp_function_id>

<cfif isdefined("SESSION.USER_QPT_#ucase(f_code)#")>
	<cfset u_level = evaluate("SESSION.USER_QPT_#ucase(f_code)#")>
	<cfset u_level_letter = mid(u_level,1,1)>
<cfelse>
	<cfset u_level = "N/A">
	<cfset u_level_letter = "N/A">
</cfif>

<cfif u_level_letter eq "A">
	<cfset level_css = "success">
<cfelseif u_level_letter eq "B">
	<cfset level_css = "info">
<cfelseif u_level_letter eq "C">
	<cfset level_css = "danger">
<cfelse>
	<cfset level_css = "info">
</cfif>

<cfif view eq "param_tp">
	
<cfsilent>

	<cfset tp_master_hour = get_tp.tp_duration/60>

	<cfif tp_master_hour eq "5" OR tp_master_hour eq "10" OR tp_master_hour eq "15" OR tp_master_hour eq "20" OR tp_master_hour eq "25" OR tp_master_hour eq "30">
		<cfset tp_prefilled_compliant = "1">
	</cfif>

	<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
	SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_objectives_#SESSION.LANG_CODE# as skill_objectives, skill_icon FROM lms_skill WHERE skill_id <= 4 ORDER BY FIELD(skill_id,1,3,2,4)
	</cfquery>
		
	<cfquery name="get_tptype" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_type_id, tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tp_type_explain_#SESSION.LANG_CODE# as tp_type_explain, tp_type_tooltip_#SESSION.LANG_CODE# as tp_type_tooltip, tp_type_css, tp_type_img, tp_type_minute FROM lms_tptype 
	<cfif f_code eq "en" OR f_code eq "de">
		<cfif isdefined("tp_prefilled_compliant")>
			WHERE tp_type_id = 1 OR tp_type_id = 2 OR tp_type_id = 3 ORDER BY FIELD(tp_type_id,3,1,2)
		<cfelse>
			WHERE tp_type_id = 3 OR tp_type_id = 2 ORDER BY FIELD(tp_type_id,3,2)
		</cfif>
	<cfelse>
		WHERE tp_type_id = 3
	</cfif>
	</cfquery>

	<cfquery name="get_tpformula" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_formula_id, tp_formula_name_#SESSION.LANG_CODE# as tp_formula_name, tp_formula_desc_#SESSION.LANG_CODE# as tp_formula_desc, tp_formula_css, tp_formula_img, tp_formula_nbcourse FROM lms_tpformula
	</cfquery>
	
	<cfquery name="get_tpsupport" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_support_id, tp_support_name_#SESSION.LANG_CODE# as tp_support_name, tp_support_desc_#SESSION.LANG_CODE# as tp_support_desc, tp_support_css, tp_support_img FROM lms_tpsupport
	<cfif f_code neq "en" AND f_code neq "de">
	WHERE tp_support_id <> 1
	</cfif>
	</cfquery>
	
	<cfquery name="get_tporientation" datasource="#SESSION.BDDSOURCE#">
	SELECT tp_orientation_id, tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc, tp_orientation_src, tp_orientation_css FROM lms_tporientation
	</cfquery>

	<cfquery name="get_prefilled_available" datasource="#SESSION.BDDSOURCE#">
		SELECT tp.tpmaster_id FROM lms_tpmaster2 tp 
		INNER JOIN lms_tpmastercor2 tc ON tc.tpmaster_id = tp.tpmaster_id 
		INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = tc.sessionmaster_id 
		WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">
		AND tp.tpmaster_prebuilt = 1
		AND sm.sessionmaster_online_visio = 1
		
		AND tp.tpmaster_level like '%#u_level_letter#%'

		AND tp.tpmaster_hour = <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_master_hour#">

		GROUP BY tc.tpmaster_id, tc.sessionmaster_rank, tc.sessionmaster_id
	</cfquery>


</cfsilent>

<cfset accordion_list = "">

<cfif get_tp.tp_formula_id neq "">
	<cfset accordion_list = listappend(accordion_list,"1")>
</cfif>
<cfif get_tp.tp_session_duration neq "">
	<cfset accordion_list = listappend(accordion_list,"2")>
</cfif>
<cfif get_tp.tp_skill_id neq "">
	<cfset accordion_list = listappend(accordion_list,"3")>
</cfif>
<cfif get_tp.tp_support_id neq "">
	<cfset accordion_list = listappend(accordion_list,"4")>
</cfif>
<cfif get_tp.tp_type_id neq "">
	<cfset accordion_list = listappend(accordion_list,"5")>
</cfif>
<style>
	.noHover{
		pointer-events: none;
	}
</style>
<div class="accordion mt-4" id="accordion_tp">
	
	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_item_1" aria-expanded="true" aria-controls="collapse_item_1">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_formula')#</cfoutput>
				
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"1")>show</cfif>" id="check_1"></i>
				
				</h5>
			</button>

			<div id="collapse_item_1" class="collapse <cfif not listfind(accordion_list,"1")>show</cfif> pb-2" data-parent="#accordion_tp">
			
				<div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_rythm')#</cfoutput>
						</div>
					</div>
				</div>
				
				<form id="form_formula">								
				<div class="card-deck btn-group-toggle" data-toggle="buttons">
					<cfoutput query="get_tpformula">
					<label class="btn btn-lg card p-2 m-2 btn-outline-#tp_formula_css# cursored tp_formula <cfif get_tp.tp_formula_id eq get_tpformula.tp_formula_id>active</cfif>">
						<input type="radio" name="tp_formula_id" class="tp_formula_id" value="#tp_formula_id#" autocomplete="off" <cfif get_tp.tp_formula_id eq get_tpformula.tp_formula_id>checked</cfif>>		
						<img class="card-img-top" src="./assets/img/#tp_formula_img#">
						<div class="card-body px-1">
							<h5 align="center" class="mt-1">#tp_formula_name#</h5>
							<div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
							#tp_formula_desc#
							</div>
						</div>
					</label>
					</cfoutput>
				</div>

				<div align="center">
				<br>
				<cfoutput>
				<input type="hidden" name="t_id" value="#t_id#">
				<button type="button" class="btn btn-lg btn-info tp_formula_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button> 
				</cfoutput>
				</div>
				</form>
			
			</div>
		
		</div>
		
	</div>
	



	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button id="btn_head_2" class="btn btn-link btn-block text-left" <cfif not listfind(accordion_list,"2") AND not listfind(accordion_list,"1")>disabled</cfif> type="button" data-toggle="collapse" data-target="#collapse_item_2" aria-expanded="true" aria-controls="collapse_item_2">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_session_duration')#</cfoutput>
				
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"2")>show</cfif>" id="check_2"></i>
				
				</h5>
			</button>

			<div id="collapse_item_2" class="collapse <cfif not listfind(accordion_list,"2") AND listfind(accordion_list,"1")>show</cfif> pb-2" data-parent="#accordion_tp">
			
				<form id="form_session_duration">
				<div class="alert bg-light text-dark border mt-3" role="alert">
					<div class="media">
						<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('needs_course_duration')#</cfoutput>
						</div>
					</div>
				</div>

				<div class="row justify-content-center">
					<div class="col-lg-4 cols-md-12">
						<cfoutput>
						<div class="card-deck btn-group-toggle" data-toggle="buttons">
							<cfloop list="30,45,60" index="duration">

								<label class="btn btn-lg card p-2 m-2 btn-info cursored tp_session_duration <cfif duration eq get_tp.tp_session_duration>active</cfif>">
									<input type="radio" name="tp_session_duration" class="tp_session_duration" value="#duration#" autocomplete="off" required="yes" <cfif duration eq get_tp.tp_session_duration>checked</cfif>>		
									<div class="card-body px-1">
										<h5 align="center" class="mt-1">#duration##obj_translater.get_translate('short_minute')#</h5>
									</div>
								</label>
								
							</cfloop>
						</div>
						</cfoutput>
					</div>
				</div>

				<div align="center">
				<br>
				<cfoutput>
				<input type="hidden" name="t_id" value="#t_id#">
				<button type="button" class="btn btn-lg btn-info tp_session_duration_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button> 
				</cfoutput>
				</div>
				</form>
			
			</div>
		
		</div>
		
	</div>


	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button id="btn_head_3" class="btn btn-link btn-block text-left" <cfif not listfind(accordion_list,"3") AND not listfind(accordion_list,"2")>disabled</cfif> type="button" data-toggle="collapse" data-target="#collapse_item_3" aria-expanded="true" aria-controls="collapse_item_3">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_objective')#</cfoutput>
				
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"3")>show</cfif>" id="check_3"></i>
				
				</h5>
			</button>

			<div id="collapse_item_3" class="collapse <cfif not listfind(accordion_list,"3") AND listfind(accordion_list,"2")>show</cfif>" data-parent="#accordion_tp">
			
				<div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_skill')#</cfoutput>
						</div>
					</div>
				</div>
				
				<div class="row mb-3">
					
					<div class="col-md-12">
							
						<form id="form_skill">
						<div class="card-deck btn-group-toggle" data-toggle="buttons">
							<label class="btn btn-lg card p-2 m-2 btn-info cursored tp_skill_all <cfif get_tp.tp_skill_id eq "" OR get_tp.tp_skill_id eq "1,2,3,4">active</cfif>" id="tp_skill_all">
							<input type="checkbox" name="skill_id" value="0" autocomplete="off" <cfif get_tp.tp_skill_id eq "" OR get_tp.tp_skill_id eq "1,2,3,4">checked="checked"</cfif>>
								<div class="card-body">
									<div align="center">
									<i class="fal fa-head-side-headphones fa-2x mb-3"></i>&nbsp;
									<i class="fal fa-books fa-2x mb-3"></i>&nbsp;
									<i class="fal fa-comments fa-2x mb-3"></i>&nbsp;
									<i class="fal fa-edit fa-2x mb-3"></i>
									</div>
									<h5 align="center" class="mb-1" style="white-space:normal !important"><cfoutput>#obj_translater.get_translate('btn_global_progression')#</cfoutput></h5>
								</div>
							</label>
							<cfloop query="get_skill">
							<cfoutput>
							<label class="btn card p-2 m-2 btn-info cursored tp_skill <cfif listfind(get_tp.tp_skill_id,get_skill.skill_id)>active</cfif>">
								<input type="checkbox" name="skill_id" class="skill_id" value="#skill_id#" autocomplete="off" <cfif listfind(get_tp.tp_skill_id,get_skill.skill_id)>checked="checked"</cfif>>
								<div class="card-body">
									<div align="center">
									<i class="<cfoutput>#get_skill.skill_icon#</cfoutput> fa-2x mb-3" align="center"></i>
									<h5 align="center" class="mb-1" style="white-space:normal !important; font-size:20px">#get_skill.skill_name#</h5>
									</div>
								</div>
							</label>
							</cfoutput>
							</cfloop>
							
						</div>
						
						<div align="center">
						<br>
						<cfoutput>
						<input type="hidden" name="t_id" value="#t_id#">
						<button type="button" class="btn btn-lg btn-info tp_skill_btn"> #obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button>
						</cfoutput>
						</div>
						</form>
						
					</div>
				
				</div>
				
			</div>
		
		
		</div>
		
	</div>
	
	<div class="card border border-info" style="background-color:#FCFCFC">
	
		<div class="card-header">
		
			<button id="btn_head_4" class="btn btn-link btn-block text-left" <cfif not listfind(accordion_list,"4") AND not listfind(accordion_list,"3")>disabled</cfif> type="button" data-toggle="collapse" data-target="#collapse_item_4" aria-expanded="true" aria-controls="collapse_item_4">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_support')#</cfoutput>
				<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"4")>show</cfif>" id="check_4"></i>
				</h5>
				
			</button>

			<div id="collapse_item_4" class="collapse <cfif not listfind(accordion_list,"4") AND listfind(accordion_list,"3")>show</cfif>" data-parent="#accordion_tp">
			
				<div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
						<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_support')#</cfoutput>
						</div>
					</div>
				</div>
				
				<form id="form_support">
				<div class="card-deck">
					<!--- <label class="btn btn-lg card p-2 m-2 btn-info cursored tp_support_all <cfif get_tp.tp_support_id eq "0" OR get_tp.tp_support_id eq "">active</cfif>" id="tp_support_all"> --->
					<!--- <input type="checkbox" name="tp_support_id" value="0" autocomplete="off" <cfif get_tp.tp_support_id eq "0" OR get_tp.tp_support_id eq "">checked="checked"</cfif>> --->
						<!--- <img class="card-img-top" src="./assets/img/support_all.jpg"> --->
						<!--- <div class="card-body"> --->
							<!--- <h5 align="center" class="mb-1" style="white-space:normal !important">Tout me convient !</h5> --->
						<!--- </div> --->
					<!--- </label> --->
					<cfloop query="get_tpsupport">
					<cfoutput>
					<div class="card p-2 m-2 border tp_support">
						<img class="card-img-top" src="./assets/img/#tp_support_img#" width="120">
						<!--- <input type="checkbox" name="tp_support_id" class="tp_support_id" value="#tp_support_id#" autocomplete="off" <cfif listfind(get_tp.tp_support_id,get_tpsupport.tp_support_id)>checked="checked"</cfif>> --->
						<div class="card-body" align="center">
							<h5 class="mb-1 text-muted" style="white-space:normal !important">#get_tpsupport.tp_support_name#</h5>
							<div class="card-text font-weight-normal text-muted" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
							#tp_support_desc#
							</div>
						</div>
					</div>
					</cfoutput>
					</cfloop>
					
				</div>
				
				<div align="center">
					<cfoutput>
					<input type="hidden" name="t_id" value="#t_id#">
					<!--- ENG --->
					<cfif get_tp.formation_id neq 2>
						<button type="button" class="btn btn-lg btn-info tp_type_btn">#obj_translater.get_translate("btn_understood")# <i class="far fa-chevron-double-right"></i></button>
					<cfelse>
						<button type="button" class="btn btn-lg btn-info tp_support_btn">#obj_translater.get_translate("btn_understood")# <i class="far fa-chevron-double-right"></i></button>
					</cfif>
					</cfoutput>
				</div>
				
				</form>	
					
			</div>
			
		</div>
		
	</div>
	<!---  ENG --->
	<cfif get_tp.formation_id eq 2>

		<div class="card border border-info" style="background-color:#FCFCFC">
		
			<div class="card-header">
			
				<button id="btn_head_5" class="btn btn-link btn-block text-left" <cfif not listfind(accordion_list,"4")>disabled</cfif> type="button" data-toggle="collapse" data-target="#collapse_item_5" aria-expanded="true" aria-controls="collapse_item_5">
					
					<h5 class="my-1 text-info" align="center">
					<cfoutput>#obj_translater.get_translate('accordion_tp_type')#</cfoutput>
					
					<i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"5")>show</cfif>" id="check_4"></i>
					
					</h5>
				</button>

				<div id="collapse_item_5" class="collapse <cfif (not listfind(accordion_list,"5") AND listfind(accordion_list,"4")) OR (isdefined("show_info") AND show_info eq "tp_type")>show</cfif>" data-parent="#accordion_tp">
				
					<cfif f_code eq "en" OR f_code eq "de">
						<div class="alert bg-light text-dark border" role="alert">
							<div class="media">
								<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
								<div class="media-body">
								<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_tp')#</cfoutput>
								</div>
							</div>
						</div>
					</cfif>				
								
					<div class="row mb-3">
					
						<div class="col-md-12">
							<form id="form_type">
							<div class="row btn-group-toggle justify-content-center" data-toggle="buttons">
								
								<cfloop query="get_tptype">
								<cfoutput>
								<div class="col-md-4">
								
									<label class="btn btn-lg card p-2 btn-outline-#get_tptype.tp_type_css# cursored tp_type <cfif get_prefilled_available.recordCount eq 0 and get_tptype.tp_type_id eq 1>noHover
									<cfelseif get_tp.tp_type_id eq get_tptype.tp_type_id>active</cfif>">
										
										<input type="radio" name="tp_type_id" class="tp_type_id" value="#tp_type_id#" autocomplete="off" 
										<cfif get_prefilled_available.recordCount eq 0 and get_tptype.tp_type_id eq 1>disabled
										<cfelseif get_tp.tp_type_id eq get_tptype.tp_type_id>checked</cfif>>

										<img class="card-img-top" src="./assets/img/#get_tptype.tp_type_img#">
										<div class="card-body">
											<div align="center">
												<h5 align="center" class="mb-1" style="white-space:normal !important">#get_tptype.tp_type_name#</h5>
												<div class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
												#get_tptype.tp_type_desc#
												</div>
											</div>
										</div>
									</label>
									<div align="center" class="mt-3">
										<h5 style="font-size:18px"><i class="fal fa-clock"></i> #get_tptype.tp_type_minute# #obj_translater.get_translate('short_minute')#</h5>
										<em>#tp_type_tooltip#</em>
									</div>
								
								</div>
								</cfoutput>
								</cfloop>
							
							</div>
							
							<div align="center">
							<br>
							<cfoutput>
							<input type="hidden" name="t_id" value="#t_id#">
							<button type="button" class="btn btn-lg btn-info tp_type_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button>
							</cfoutput>
							</div>
							</form>
						</div>
						
					</div>
					
					
				</div>
				
			</div>
			
		</div>

	<cfelse>
		<cfoutput>
			<form id="form_type">
				<input type="hidden" name="tp_type_id" value="3">
				<input type="hidden" name="t_id" value="#t_id#">
			</form>
		</cfoutput>
		
	</cfif>
	
	
</div>



<script>
$(document).ready(function() {

	// $('.btn_contact_wefit').hide();

	<!--------------------------- 1ST ITEM ------------------>	
	$(".tp_formula_btn").click(function(event) {
		event.preventDefault();
		<!--- console.log($('#form_formula').serialize()); --->
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_formula',
			type: 'POST',		
			dataType: 'json',
			data: $('#form_formula').serialize(),
			success : function(resultat, statut){
				<!--- console.log(resultat); --->
				$('#collapse_item_2').collapse('toggle');
				$('#check_1').collapse('show');
				$('#btn_head_2').prop("disabled", false);
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
				<!--- console.log(erreur); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	<!--------------------------- 2ND ITEM ------------------>	
	$(".tp_session_duration_btn").click(function(event) {
		event.preventDefault();
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_session_duration',
			type: 'POST',		
			dataType: 'json',
			data: $('#form_session_duration').serialize(),
			success : function(resultat, statut){
				<!--- console.log(resultat); --->
				$('#collapse_item_3').collapse('toggle');
				$('#check_2').collapse('show');
				$('#btn_head_3').prop("disabled", false);
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
				<!--- console.log(erreur); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})


	skill_id = [];
	<!--------------------------- 3RD ITEM ------------------>	
	$("#tp_skill_all").click(function() {
		
		$(".skill_id").prop("checked",false);
		$(".tp_skill").removeClass("active");			
		$("#tp_skill_all").prop("checked",true);
		skill_id = ["1","2","3","4"];	
		
	})
	$(".tp_skill").change(function() {
	
		skill_id = [];		
		$("#tp_skill_all").removeClass("active");
		$("#tp_skill_all").prop("checked",false);		
		$.each($("input[class='skill_id']:checked"), function(){			
			skill_id.push($(this).val());			
		});
		
	})
	$(".tp_skill_btn").click(function() {
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_skill',
			type: 'GET',		
			dataType: 'json',
			data: "t_id=<cfoutput>#t_id#</cfoutput>&skill_id="+skill_id,
			success : function(resultat, statut){
				<!--- console.log(resultat); --->
				$('#collapse_item_4').collapse('toggle');
				$('#check_3').collapse('show');
				$('#btn_head_4').prop("disabled", false);
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	
	
	
	
	tp_support_id = [];
	<!--------------------------- 4TH ITEM ------------------>	
	/*$("#tp_support_all").click(function() {
		
		$(".tp_support_id").prop("checked",false);
		$(".tp_support").removeClass("active");			
		$("#tp_support_all").prop("checked",true);
		tp_support_id = ["1","2","3","4"];	
		
	})
	$(".tp_support").change(function() {
	
		tp_support_id = [];		
		$("#tp_support_all").removeClass("active");
		$("#tp_support_all").prop("checked",false);		
		$.each($("input[class='tp_support_id']:checked"), function(){			
			tp_support_id.push($(this).val());			
		});
		
	})*/
	$(".tp_support_btn").click(function() {
		
		$.ajax({				 
			 url: 'updater_tp.cfc?method=updt_tp_support', 
			 type: 'GET',		 
			 dataType: 'json', 
			 data: "t_id=<cfoutput>#t_id#</cfoutput>&tp_support_id=1", 
			 success : function(resultat, statut){ 
				$('#collapse_item_5').collapse('toggle');
				$('#check_4').collapse('show');
				$('#btn_head_5').prop("disabled", false);
			 }, 
			 error : function(resultat, statut, erreur){ 
			 }, 
			 complete : function(resultat, statut){ 
			 }	 
		 }); 
	})
	
	
	
	
	
	
	
	<!--------------------------- 5TH ITEM ------------------>	
	$(".tp_type_btn").click(function(event) {
		event.preventDefault();
		let tp_type_id = 3;
		console.log(<cfoutput>#get_tp.formation_id#</cfoutput>, <cfoutput>#get_tp.formation_id#</cfoutput> == 2)
		if (<cfoutput>#get_tp.formation_id#</cfoutput> == 2) { 
			tp_type_id = $("input[class='tp_type_id']:checked").val();
		}
		 
		<!--- return false; --->
		<!--- console.log($('#form_type').serialize()); --->
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_type',
			type: 'GET',
			dataType: 'json',
			data: $('#form_type').serialize(),
			success : function(resultat, statut){
				console.log(resultat);
				$('#check_5').collapse('show');
				
				if (tp_type_id == "1")
				{
					window.location.href="learner_launch_2_prefilled.cfm?tp_choice=prefilled&kw_choice=1";
				}
				else if (tp_type_id == "2")
				{
					window.location.href="learner_launch_2_solo.cfm?tp_choice=prefilled&kw_choice=1";
				}
				else if (tp_type_id == "3")
				{
					window.location.href="learner_launch_2.cfm?tp_choice=collaborative&kw_choice=1";
				}
				 
			},
			error : function(resultat, statut, erreur){
			},
			complete : function(resultat, statut){
			}	
		});
		
		
	})
	
})
</script>




















































<cfelseif view eq "param_themes">

<cfquery name="get_tptype_solo" datasource="#SESSION.BDDSOURCE#">
SELECT tp_type_id, tp_type_name_#SESSION.LANG_CODE# as tp_type_name, tp_type_desc_#SESSION.LANG_CODE# as tp_type_desc, tp_type_explain_#SESSION.LANG_CODE# as tp_type_explain, tp_type_tooltip_#SESSION.LANG_CODE# as tp_type_tooltip, tp_type_css, tp_type_img FROM lms_tptype 
<cfif tp_choice eq "solo">
WHERE tp_type_id = 2
<cfelseif tp_choice eq "collaborative">
WHERE tp_type_id = 3
<cfelseif tp_choice eq "prefilled">
WHERE tp_type_id = 1
</cfif>		
</cfquery>
	
<cfquery name="get_tporientation" datasource="#SESSION.BDDSOURCE#">
SELECT tp_orientation_id, tp_orientation_name_#SESSION.LANG_CODE# as tp_orientation_name, tp_orientation_desc_#SESSION.LANG_CODE# as tp_orientation_desc, tp_orientation_src, tp_orientation_css FROM lms_tporientation WHERE tp_orientation_id < 3
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 OR keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
</cfquery>
	

<!--- <cfset accordion_list = ""> --->

<!--- <cfif get_tp.tp_orientation_id neq ""> --->
	<!--- <cfset accordion_list = listappend(accordion_list,"5")> --->
<!--- </cfif> --->

<!--- <cfif get_tp.tp_function_id neq ""> --->
	<!--- <cfset accordion_list = listappend(accordion_list,"6")> --->
<!--- </cfif> --->
		
<!--- <cfif get_tp.tp_interest_id neq ""> --->
	<!--- <cfset accordion_list = listappend(accordion_list,"6")> --->
<!--- </cfif>		 --->
			
<div class="accordion mt-4" id="accordion_tp">

	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
			
			<button id="btn_head_6" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_item_6" aria-expanded="true" aria-controls="collapse_item_6">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_orientation')#</cfoutput>
				
				<!--- <i class="fas fa-check-circle fa-lg pull-right text-success collapse <cfif listfind(accordion_list,"5")>show</cfif>" id="check_5"></i> --->
				
				</h5>
			</button>

			<div id="collapse_item_6" class="collapse show<!---<cfif not listfind(accordion_list,"5")>show</cfif>--->" data-parent="#accordion_tp">
				
				<div class="alert bg-light text-dark border" role="alert">
					<div class="media">
						<i class="align-self-center fal fa-info-circle fa-3x mr-3"></i>
						<div class="media-body">
						<cfoutput>#get_tptype_solo.tp_type_explain#</cfoutput>
						</div>
					</div>
				</div>
				
				<form id="form_orientation">
				
					<div class="row btn-group-toggle justify-content-center" data-toggle="buttons">
								
						<cfoutput query="get_tporientation">
							<div class="col-lg-4">
							<label class="btn btn-lg card p-2 btn-outline-#tp_orientation_css# cursored tp_orientation <cfif tp_orientation_id eq tp_orientation_select>active</cfif>">
								<input type="radio" name="tp_orientation_id" class="tp_orientation_id" value="#tp_orientation_id#" autocomplete="off" <cfif tp_orientation_id eq tp_orientation_select>checked="checked"</cfif>>
								<img class="card-img-top" src="./assets/img/#tp_orientation_src#">
								<div class="card-body">
									<div align="center">
										<h5 align="center" class="mb-1" style="white-space:normal !important">#tp_orientation_name#</h5>
										<div class="card-text font-weight-normal" align="center" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
										#tp_orientation_desc#
										</div>
									</div>
								</div>
							</label>
						</div>
							
						</cfoutput>
					</div>	
					
					<div align="center">
						<br>
						<cfoutput>
						<input type="hidden" name="t_id" value="#t_id#">
						<button type="button" class="btn btn-lg btn-info tp_orientation_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button>
						</cfoutput>
					</div>
				</form>
					
			</div>
			
		</div>
		
	</div>

	<div class="card border border-info" style="background-color:#FCFCFC">
		
		<div class="card-header">
			
			<button id="btn_head_7" class="btn btn-link btn-block text-left collapsed" disabled type="button" data-toggle="collapse" data-target="#collapse_item_7" aria-expanded="false" aria-controls="collapse_item_7">
				
				<h5 class="my-1 text-info" align="center">
				<cfoutput>#obj_translater.get_translate('accordion_tp_theme')#</cfoutput>
				</h5>
			</button>
			
			<div id="collapse_item_7" class="collapse" data-parent="#accordion_tp">

				<form id="form_kw">			
				<div id="accordion_kw">
				<cfloop query="get_keyword_cat">
					<cfoutput>
					<div id="collapse_#keyword_cat_id#" class="collapse p-2 collapse_kw" data-parent="##accordion_kw">
					</cfoutput>
						
					<cfif get_tp.tp_type_id eq "2">
					<div class="alert bg-light text-dark border" role="alert">
						<div class="media">
							<i class="align-self-center  fal fa-info-circle fa-3x mr-3"></i>
							<div class="media-body">
							<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_theme')#</cfoutput>
							</div>
						</div>
					</div>
					</cfif>
					
					
					<cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
					SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name, k.keyword_obj_#SESSION.LANG_CODE# as keyword_obj
					FROM lms_keyword k 
					WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> 
					GROUP BY keyword_id
					ORDER BY keyword_name
					</cfquery>
					
					<div class="row btn-group-toggle" data-toggle="buttons">
						
						<cfoutput query="get_keyword">
						
						<cfif get_tp.tp_type_id eq "2">
						<cfquery name="get_nb" datasource="#SESSION.BDDSOURCE#">
						SELECT COUNT(DISTINCT(sm.sessionmaster_id)) as nb
						FROM lms_tpsessionmaster2 sm 
						INNER JOIN lms_tpmastercor2 tc ON sm.sessionmaster_id = tc.sessionmaster_id	
						INNER JOIN lms_tpmaster2 tp ON tc.tpmaster_id = tp.tpmaster_id 
						WHERE FIND_IN_SET(#keyword_id#,sm.keyword_id)
						AND tp.tpmaster_level like '%#u_level_letter#%'
						<!--- AND sm.tp_orientation_id = 1 --->
						AND sm.sessionmaster_online_visio = 1
						AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#">  
						</cfquery>
						</cfif>
						
						<!--- <cfset test = randrange(100,118)> --->
							<div class="col-md-3">
							<label class="btn btn-lg card p-2 m-1 btn-info cursored tp_keyword <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>active</cfif>">
								
								<div class="media">
								<cfif get_keyword_cat.keyword_cat_id eq "3">
								<input type="checkbox" name="tp_interest_id" class="tp_interest_id" value="#keyword_id#" autocomplete="off" <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>checked="checked"</cfif>>
								<cfelse>
								<input type="checkbox" name="tp_function_id" class="tp_function_id" value="#keyword_id#" autocomplete="off" <cfif listfind(get_tp.tp_function_id,get_keyword.keyword_id) OR listfind(get_tp.tp_interest_id,get_keyword.keyword_id)>checked="checked"</cfif>>
								</cfif>
									<div class="media-body">
									<h6 align="center" class="mb-1" style="white-space:normal !important"><cfif get_keyword_cat.keyword_cat_id eq "3">#keyword_name#<cfelse>#keyword_name#</cfif></h6>
									<cfif get_tp.tp_type_id eq "2">
									<span class="font-weight-normal">#get_nb.nb# ressources <span class="badge badge-pill badge-info">#u_level_letter#</span></span>
									</cfif>
									</div>
								</div>
								
							</label>
							</div>
						</cfoutput>
					
					</div>		
				
				</div>				
				</cfloop>
				</div>
			
				<cfoutput>
				<div align="center"><button type="button" class="btn btn-lg btn-info tp_keyword_btn">#obj_translater.get_translate("btn_validate")# <i class="far fa-chevron-double-right"></i></button></div>
				</cfoutput>
				
				</form>	
					
			</div>
			
		</div>
		
	</div>

</div>



<script>
$(document).ready(function() {
	
	// $('.btn_contact_wefit').hide();
	// ('.btn_contact_wefit_modal').click(function(event) {	

	// 	let go_u = 1;
	// 	let go_o = 1;

	// 	$('#window_item_xl_unclosable').modal('hide');

	// 	$('#window_item_xl_unclosable').on('hidden.bs.modal', function (e) {
	// 		if (go_u) {
	// 			go_u = 0;
	// 			$('#window_item_ctc').modal({keyboard: true});
	// 			$('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
	// 			<cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST">
	// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});
	// 			<cfelseif SESSION.USER_PROFILE eq "TRAINER">
	// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=t", function() {});
	// 			<cfelseif SESSION.USER_PROFILE eq "TM">
	// 			$('#modal_body_ctc').load("modal_window_contact.cfm?view=tm", function() {});
	// 			</cfif>
	// 		}
	// 	});

	// 	$('#window_item_ctc').on('hidden.bs.modal', function (e) {
	// 		if (go_o) {
	// 			go_o = 0;
	// 			$('#window_item_xl_unclosable').modal('show');
	// 		}
	// 	});
	// });

$('[data-toggle="tooltip"]').tooltip();

	<!--------------------------- 1ST ITEM ------------------>	
	$(".tp_orientation_btn").click(function(event) {
		event.preventDefault();
		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_orientation',
			type: 'POST',		
			dataType: 'json',
			data: $('#form_orientation').serialize(),
			success : function(resultat, statut){
				var tp_orientation_id = resultat;
				console.log(tp_orientation_id);
				if(tp_orientation_id == "1")
				{
					console.log("aff general");
					$("#collapse_3").collapse('toggle');
					$("#collapse_4").collapse('toggle');
				}
				else if(tp_orientation_id == "2")
				{	
					console.log("aff business");
					$("#collapse_4").collapse('toggle');
					$("#collapse_3").collapse('toggle');
				}				
				$('#collapse_item_7').collapse('toggle');
				<!--- $('#check_5').collapse('show'); --->
				$('#btn_head_7').prop("disabled", false);
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
				<!--- console.log(erreur); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	
	tp_interest_id = [];
	tp_function_id = [];
	$.each($("input[class='tp_interest_id']:checked"), function(){			
		tp_interest_id.push($(this).val());			
	});
	$.each($("input[class='tp_function_id']:checked"), function(){			
		tp_function_id.push($(this).val());			
	});
	<!--------------------------- 5th ITEM ------------------>	
	$(".tp_interest_id").change(function() {
		tp_interest_id = [];	
		$.each($("input[class='tp_interest_id']:checked"), function(){			
			tp_interest_id.push($(this).val());			
		});
	})
	$(".tp_function_id").change(function() {
		tp_function_id = [];	
		$.each($("input[class='tp_function_id']:checked"), function(){			
			tp_function_id.push($(this).val());			
		});
	})
	$(".tp_keyword_btn").click(function() {

		$.ajax({				 
			url: 'updater_tp.cfc?method=updt_tp_keyword',
			type: 'GET',		
			dataType: 'json',
			data: "t_id=<cfoutput>#t_id#</cfoutput>&tp_interest_id="+tp_interest_id+"&tp_function_id="+tp_function_id,
			success : function(resultat, statut){
				<!--- console.log(resultat); --->
				<!--- $('#window_item_xl_unclosable').modal('hide'); --->
				<!--- var tp_type_id = $("input[class='tp_type_id']:checked").val(); --->
				<!--- alert(tp_type_id); --->
				
				<cfif tp_choice eq "solo">
					window.location.href="learner_launch_2_solo.cfm";
				<cfelseif tp_choice eq "collaborative">
						window.location.href="learner_launch_3.cfm";
				<cfelseif tp_choice eq "prefilled">
					window.location.href="learner_launch_2_prefilled.cfm";
				</cfif>
				
				
			},
			error : function(resultat, statut, erreur){
				<!--- console.log(resultat); --->
			},
			complete : function(resultat, statut){
				<!--- console.log(resultat); --->
			}	
		});
	})
	
	
	
	
	
})
</script>


</cfif>