<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,12">
<cfinclude template="./incl/incl_secure.cfm">


<cfparam name="f_id" default="2">
<cfparam name="provider_id" default="1">
<cfparam name="pack_active" default="1">

<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
SELECT formation_id, formation_name_fr as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN(1,2,3,4,5,9,12,13,6,8)
</cfquery>		

<cfset __text_about = obj_translater.get_translate('text_about')>
<cfset __lesson = obj_translater.get_translate('lesson')>

<cfset __tooltip_material = obj_translater.get_translate('tooltip_material')>
<cfset __tooltip_audio_content = obj_translater.get_translate('tooltip_audio_content')>
<cfset __tooltip_video_content = obj_translater.get_translate('tooltip_video_content')>
<cfset __tooltip_quiz_content = obj_translater.get_translate('tooltip_quiz_content')>


</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>
.collapsing {
    -webkit-transition: none;
    transition: none;
    display: none;
}
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">

		<cfset title_page = "Catalogue de formation">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			<div class="row">
				<div class="col-md-12">
				
					<cfif isdefined("k")>
					<div class="alert alert-success">Modifications effectuées</div>
					</cfif>	

					<div class="row">
						<cfoutput>
						<div class="col-md-2">
							<div class="btn-group">
							<a class="btn <cfif provider_id eq "1">btn-info<cfelse>btn-outline-info</cfif>" href="db_tppack_list.cfm?provider_id=1&pack_active=#pack_active#">
								WEFIT GROUP
							</a>
							<a class="btn btn-info <cfif provider_id eq "3">btn-info<cfelse>btn-outline-info</cfif>" href="db_tppack_list.cfm?provider_id=3&pack_active=#pack_active#">
								WEFIT FRANCE
							</a>
							</div>
						</div>
						<div class="col-md-2">
							<div class="btn-group">
							<a class="btn <cfif pack_active eq "1">btn-info<cfelse>btn-outline-info</cfif>" href="db_tppack_list.cfm?pack_active=1&provider_id=#provider_id#">
								PACKS ONLINE
							</a>
							<a class="btn btn-info <cfif pack_active eq "0">btn-info<cfelse>btn-outline-info</cfif>" href="db_tppack_list.cfm?pack_active=0&provider_id=#provider_id#">
								PACK SUSPENDED
							</a>
							</div>
						</div>
						
						</cfoutput>
					</div>
					
					
					<ul class="nav nav-tabs" id="tp_list" role="tablist">
						<cfoutput query="get_formation">
						<li class="nav-item">		
						<a href="##f_#formation_id#" id="form_#formation_id#" class="nav-link <cfif f_id eq formation_id>active</cfif>" role="tab" data-toggle="tab">
						#obj_lms.get_formation_icon(formation_code,formation_name)#
						</a>
						</li>
						</cfoutput>
					</ul>

					<div class="tab-content">
						<cfloop query="get_formation">
						<div role="tabpanel" class="tab-pane <cfif f_id eq get_formation.formation_id>active show</cfif>" id="f_<cfoutput>#get_formation.formation_id#</cfoutput>" style="margin-top:15px;">
					
							
		
							<cfquery name="get_formation_pack" datasource="#SESSION.BDDSOURCE#">
							SELECT fc.*, c.certif_name,  c.certif_alias, c.rncp_info
							FROM lms_formation_pack fc
							INNER JOIN lms_list_certification c ON fc.certif_id = c.certif_id
							WHERE fc.formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation.formation_id#"> 
							AND pack_active = <cfqueryparam cfsqltype="cf_sql_integer" value="#pack_active#"> 
							AND provider_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#provider_id#"> 
							ORDER BY certif_id, method_id, pack_hour
							</cfquery>
	
								
								
									<table class="table table-bordered bg-white">
										<tr class="bg-light">
											<td>ID</td>
											<td>Status</td>
											<td>Hour</span></td>
											<td>Visio</td>
											<td>EL</td>
											<td>IMM</td>
											<td>Certif</td>
											<td>RNCP</td>
											<td>Intitulé</td>
											<td>Action</td>
										</tr>
										<cfoutput query="get_formation_pack" group="pack_id">
										<tr>
											<td>#pack_id#</td>
											<td><cfif pack_active eq "1"><span class="badge badge-pill badge-success">Active</span><cfelse><span class="badge badge-pill badge-secondary">Suspended</span></cfif></td>
											<td><span class="badge badge-pill badge-success" style="font-size:12px">#numberformat(pack_hour,'____')# H</span></td>
											<td><cfif listfind(method_id,1)><i class="fa-light fa-camera-web"></i></cfif></td>
											<td><cfif listfind(method_id,3)><i class="fa-light fa-laptop"></i></cfif></td>
											<td><cfif listfind(method_id,6)><i class="fa-light fa-earth-europe"></i></cfif></td>
											<td><span class="text-dark" style="font-size:14px"><img src="https://lms.wefitgroup.com/assets/img_certif/#certif_id#.png" width="80"></span></td>
											<td>#rncp_info#</td>
											<td>#pack_name#</td>
											<td>
												<div class="btn-group">
												<a class="btn btn-sm btn-primary" data-toggle="collapse" href="##tppack_#pack_id#" role="button" aria-expanded="false" aria-controls="tppack_#pack_id#"><i class="fa-light fa-eye"></i></a>
												<a class="btn btn-sm btn-primary pack_edit" id="pack_#pack_id#" href="##"><i class="fa-light fa-edit"></i></a>
												<a class="btn btn-sm btn-primary" id="pack_#pack_id#" target="_blank" href="https://www.moncompteformation.gouv.fr/espace-prive/html/##/formation/recherche/51068964900034_#pack_id#_FWF/51068964900034_#pack_id#_AFWF">CPF</a>
												</div>
											</td>
										</tr>
										<tr class="collapse" id="tppack_#pack_id#">
											<td colspan="10">
												<table class="table table-sm mt-2">
															
													<tr>
														<td class="bg-light" width="12%">
															Heures (VISIO)
														</td>
														<td>
														#numberformat(pack_hour,'____')#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Durée (EL)
														</td>
														<td>
														<strong>#pack_duration#</strong>
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Certif
														</td>
														<td>
															<span class="text-dark" style="font-size:14px"><img src="https://lms.wefitgroup.com/assets/img_certif/#certif_id#.png" width="100"></span>
                                						</td>
													</tr>
													<tr>
														<td class="bg-light">
															RNCP
														</td>
														<td>
														#rncp_info#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Certif info
														</td>
														<td>
														#pack_certif_info#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Prix HT
														</td>
														<td>
														#numberformat(pack_amount_ht,'____')# &euro;
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Prix TTC
														</td>
														<td>
														#numberformat(pack_amount_ttc,'____')# &euro;
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Les points forts de la formation
														</td>
														<td>
														#pack_keys#
														</td>
													</tr>
													<tr>
														<td class="bg-light" width="10%">
															Objectif de la formation
														</td>
														<td>
														#pack_objectives#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Résultats attendus
														</td>
														<td>
														#pack_results#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Contenu de la formation
														</td>
														<td>
														#pack_content#
														</td>
													</tr>
													<tr>
														<td class="bg-light">
															Modalités
														</td>
														<td>
														#pack_modalites#
														</td>
													</tr>
												</table>

											</td>
										</tr>
										
										</cfoutput>

									</table>
					
						</div>
						</cfloop>
						
					</div>
					
					
						
					
				</div>
			</div>
		</div>
			
		
	</div>
	
	
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$(document).ready(function() {
	
	$('.pack_edit').click(function(event) {		
	event.preventDefault();		
	var idtemp = $(this).attr("id");
	var idtemp = idtemp.split("_");
	var pack_id = idtemp[1];
	
	$('#window_item_xl').modal({keyboard: true});
	$('#modal_title_xl').text("Editer Pack formation");
	$('#modal_body_xl').load("modal_window_pack.cfm?pack_id="+pack_id, function() {});

	});
			
})
</script>

</body>
</html>