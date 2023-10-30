<!DOCTYPE html>

<cfsilent>

<cfset secure = "2,5,6,4,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfquery name="get_sessionmaster" datasource="#SESSION.BDDSOURCE#">
SELECT sm.*, tp.formation_id, tp.tpmaster_id as tpm_id, tp.tpmaster_biglevel
FROM lms_tpsessionmaster2 sm
LEFT JOIN lms_tpmastercor2 tpm ON tpm.sessionmaster_id = sm.sessionmaster_id
LEFT JOIN lms_tpmaster2 tp ON tp.tpmaster_id = tpm.tpmaster_id
WHERE sm.sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
AND tp.tpmaster_prebuilt = 0
</cfquery>

<cfset f_id = get_sessionmaster.formation_id>
<cfset m_id = get_sessionmaster.mapping_id>

<cfswitch expression="#get_sessionmaster.formation_id#">
<cfcase value="1"><cfset lang_temp = "fr"></cfcase>
<cfcase value="2"><cfset lang_temp = "en"></cfcase>
<cfcase value="3"><cfset lang_temp = "de"></cfcase>
<cfcase value="4"><cfset lang_temp = "es"></cfcase>
<cfcase value="5"><cfset lang_temp = "it"></cfcase>
</cfswitch>

<cfquery name="get_module" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpmodulemaster2 WHERE module_level LIKE '%#get_sessionmaster.tpmaster_biglevel#%' ORDER BY module_name
</cfquery>	

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_skill
</cfquery>

<cfquery name="get_grammar_cat" datasource="#SESSION.BDDSOURCE#">
SELECT grammar_cat_id, grammar_cat_name FROM lms_grammar_category WHERE formation_id = #get_sessionmaster.formation_id#
</cfquery>

<cfquery name="get_grammar_level" datasource="#SESSION.BDDSOURCE#">
SELECT DISTINCT(grammar_level) as grammar_level FROM lms_grammar WHERE formation_id = #get_sessionmaster.formation_id#
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
SELECT keyword_cat_id, keyword_cat_name_#lang_temp# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id <> 1 AND keyword_cat_id <> 2
</cfquery>

<cfquery name="get_tp_master" datasource="#SESSION.BDDSOURCE#">
SELECT tpmaster_id, CONCAT(tpmaster_level, " - ", tpmaster_name) as tpmaster_name FROM lms_tpmaster2 
WHERE tpmaster_prebuilt = 0
ORDER BY tpmaster_level
</cfquery>

<cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
SELECT *
FROM lms_material
WHERE sessionmaster_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
</cfquery>

<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
SELECT voc_cat_id, voc_cat_name FROM lms_vocabulary_category ORDER BY voc_cat_name
</cfquery>
	
<cfquery name="get_chapter" datasource="#SESSION.BDDSOURCE#">
SELECT * 
FROM lms_tpchaptermaster2 ch
WHERE ch.sm_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sm_id#">
ORDER BY chapter_rank
</cfquery>

<cfquery name="get_level" datasource="#SESSION.BDDSOURCE#">
SELECT level_id, level_css, level_alias, level_name_#SESSION.LANG_CODE# as level_name FROM lms_level ORDER BY level_alias
</cfquery>
		
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<style>

</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : #obj_translater.get_translate('title_page_common_materials')#">
		<cfinclude template="./incl/incl_nav.cfm">

			
		<div class="content">
			
			<cfif isdefined("k")>
			
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em>Modifications effectu&eacute;es.</em></div>
			</div>
			
			</cfif>
			<div class="row">
			
				<div class="col-md-12">
				
					<div class="card">	
                        <div class="col bg-light border">
                            <div class="row">
                                <div class="col">
                                    <h6>Level</h6>
                                    <p>
                                        <cfloop query="get_level">
                                            <cfoutput>
                                                <cfif get_sessionmaster.level_id eq get_level.level_id>
                                                    #get_level.level_alias#
                                                </cfif>
                                            </cfoutput>
                                        </cfloop>
                                    </p>
                                </div>
                        
                                <div class="col">
                                    <h6>Category</h6>
                                    <p>
                                        <cfloop query="get_tp_master">
                                            <cfoutput>
                                                <cfif get_sessionmaster.tpm_id eq get_tp_master.tpmaster_id>
                                                    #get_tp_master.tpmaster_name#
                                                </cfif>
                                            </cfoutput>
                                        </cfloop>
                                    </p>
                                </div>
                        
                                <div class="col">
                                    <h6>Module</h6>
                                    <p>
                                        <cfloop query="get_module">
                                            <cfoutput>
                                                <cfif get_sessionmaster.module_id eq get_module.module_id>
                                                    #get_module.module_name#
                                                </cfif>
                                            </cfoutput>
                                        </cfloop>
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        
						<div class="card-body">
                          
							<cfform action="db_updater_syllabus.cfm">
                              
								<div class="row">

									<div class="col">
                                        <div class="bg-light p-2 m-1 border">
                                            <h6>Lesson title</h6>
										
										<br>
                                        <ul class="nav nav-tabs" id="title_list" role="tablist">
                                            <li class="nav-item">        
                                                <a href="#smtitle_0" class="nav-link active" role="tab" data-toggle="tab">
                                                    Default
                                                </a>
                                            </li>
                                            <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <cfoutput>
                                                    <cfset nameValue = evaluate('get_sessionmaster.sessionmaster_name_#lg#')>
                                                    <cfif IsDefined("nameValue") AND nameValue NEQ "">
                                                        <li class="nav-item">        
                                                            <a href="##smtitle_#lg#" class="nav-link" role="tab" data-toggle="tab">                                            
                                                                <span class="lang-sm" lang="#lg#"></span>
                                                            </a>
                                                        </li>
                                                    <cfelse>
                                                        <li class="nav-item" style="background-color: red;">        
                                                            <a href="##smtitle_#lg#" class="nav-link" role="tab" data-toggle="tab">                                            
                                                                <span class="lang-sm" lang="#lg#"></span>
                                                            </a>
                                                        </li>
                                                    </cfif>
                                                </cfoutput>
                                            </cfloop>
                                        </ul>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active show" id="smtitle_0" style="margin-top:15px;">
                                                <cfoutput><input type="text" class="form-control" name="sessionmaster_name" value="#get_sessionmaster.sessionmaster_name#"></cfoutput>
                                            </div>
                                            <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <cfoutput>
                                                    <div role="tabpanel" class="tab-pane" id="smtitle_#lg#" style="margin-top:15px;">
                                                        <input type="text" class="form-control" name="sessionmaster_name_#lg#" value="#evaluate('get_sessionmaster.sessionmaster_name_#lg#')#">
                                                    </div>
                                                </cfoutput>
                                            </cfloop>                                            
                                        </div>
                                        
                                        </div>
                                        <cfoutput query="get_sessionmaster">

                                            <div class="bg-light p-2 m-1 border">
                                                <h6>Main description</h6>
                                                <ul class="nav nav-tabs" id="description_list" role="tablist">
                                                    <li class="nav-item">
                                                        <a href="##smdesc_0" class="nav-link active" role="tab" data-toggle="tab">
                                                            Default
                                                        </a>
                                                    </li>
                                                    <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                        <cfoutput>
                                                            <cfset descValue = evaluate('sessionmaster_description_#lg#')>
                                                            <cfif IsDefined("descValue") AND descValue NEQ "">
                                                                <li class="nav-item">
                                                                    <a href="##smdesc_#lg#" class="nav-link" role="tab" data-toggle="tab">
                                                                        <span class="lang-sm" lang="#lg#"></span>
                                                                    </a>
                                                                </li>
                                                            <cfelse>
                                                                <li class="nav-item" style="background-color: red;">
                                                                    <a href="##smdesc_#lg#" class="nav-link" role="tab" data-toggle="tab">
                                                                        <span class="lang-sm" lang="#lg#"></span>
                                                                    </a>
                                                                </li>
                                                            </cfif>
                                                        </cfoutput>
                                                    </cfloop>
                                                </ul>
                                                <div class="tab-content">
                                                    <div role="tabpanel" class="tab-pane active show" id="smdesc_0" style="margin-top:15px;">
                                                        <textarea name="sessionmaster_description" id="sessionmaster_description" class="form-control" rows="4">#sessionmaster_description#</textarea>
                                                    </div>
                                                    <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                        <cfoutput>
                                                            <div role="tabpanel" class="tab-pane" id="smdesc_#lg#" style="margin-top:15px;">
                                                                <textarea name="sessionmaster_description_#lg#" id="sessionmaster_description_#lg#" class="form-control" rows="4">#evaluate("sessionmaster_description_#lg#")#</textarea>
                                                            </div>
                                                        </cfoutput>
                                                    </cfloop>
                                                </div>
                                            </div>
                                            
                                        <div class="bg-light p-2 m-1 mt-3 border">
                                            <h6>Objectives</h6>
                                        
                                            <ul class="nav nav-tabs" id="objectives_list" role="tablist">
                                                <li class="nav-item">
                                                <a href="##smobj_0" class="nav-link active" role="tab" data-toggle="tab">
                                                Default
                                                </a>
                                                </li>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <li class="nav-item">
                                                <a href="##smobj_#lg#" class="nav-link" role="tab" data-toggle="tab">
                                                <span class="lang-sm" lang="#lg#"></span>
                                                </a>
                                                </li>
                                                </cfloop>
                                            </ul>
                                            <div class="tab-content">
                                                <div role="tabpanel" class="tab-pane active show" id="smobj_0" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_objectives" id="sessionmaster_objectives" class="form-control" rows="3">#sessionmaster_objectives#</textarea>
                                                </div>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <div role="tabpanel" class="tab-pane" id="smobj_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_objectives_#lg#" id="sessionmaster_objectives_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_objectives_#lg#")#</textarea>
                                                </div>
                                                </cfloop>
                                            </div>
                                        
                                        </div>
                                        
                                        
                                        <div class="bg-light p-2 m-1 mt-3 border">
                                            <h6>Grammar</h6>
                                        
                                            <ul class="nav nav-tabs" id="grammar_list" role="tablist">
                                                <li class="nav-item">
                                                <a href="##smgr_0" class="nav-link active" role="tab" data-toggle="tab">
                                                Default
                                                </a>
                                                </li>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <li class="nav-item">
                                                <a href="##smgr_#lg#" class="nav-link" role="tab" data-toggle="tab">
                                                <span class="lang-sm" lang="#lg#"></span>
                                                </a>
                                                </li>
                                                </cfloop>
                                            </ul>
                                            <div class="tab-content">
                                                <div role="tabpanel" class="tab-pane active show" id="smgr_0" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_grammar" id="sessionmaster_grammar" class="form-control" rows="3">#sessionmaster_grammar#</textarea>
                                                </div>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <div role="tabpanel" class="tab-pane" id="smgr_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_grammar_#lg#" id="sessionmaster_grammar_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_grammar_#lg#")#</textarea>
                                                </div>
                                                </cfloop>
                                            </div>
                                        </div>
                                        
                                        <div class="bg-light p-2 m-1 mt-3 border">
                                            <h6>Vocabulary</h6>
                                        
                                            <ul class="nav nav-tabs" id="vocabulary_list" role="tablist">
                                                <li class="nav-item">
                                                <a href="##smvoc_0" class="nav-link active" role="tab" data-toggle="tab">
                                                Default
                                                </a>
                                                </li>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <li class="nav-item">
                                                <a href="##smvoc_#lg#" class="nav-link" role="tab" data-toggle="tab">
                                                <span class="lang-sm" lang="#lg#"></span>
                                                </a>
                                                </li>
                                                </cfloop>
                                            </ul>
                                            <div class="tab-content">
                                                <div role="tabpanel" class="tab-pane active show" id="smvoc_0" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_vocabulary" id="sessionmaster_vocabulary" class="form-control" rows="3">#sessionmaster_vocabulary#</textarea>
                                                </div>
                                                <cfloop list="#SESSION.LIST_LANGUAGES_SHORT#" index="lg">
                                                <div role="tabpanel" class="tab-pane" id="smvoc_<cfoutput>#lg#</cfoutput>" style="margin-top:15px;">
                                                    <textarea name="sessionmaster_vocabulary_#lg#" id="sessionmaster_vocabulary_#lg#" class="form-control" rows="3">#evaluate("sessionmaster_vocabulary_#lg#")#</textarea>
                                                </div>
                                                </cfloop>
                                            </div>
                                        
                                        </div>
                                        
                                </div>
                             </cfoutput>

							<cfoutput>
							<input type="hidden" name="sm_id" value="#sm_id#">
							<input type="hidden" name="updt_sm" value="1">
							</cfoutput>
							<div align="center"><input type="submit" class="btn btn-info" value="Save"></div>
							
							</cfform>
							
							
							
						</div>
					</div>
				</div>			
			</div>
				
		</div>
		
      
<cfinclude template="./incl/incl_footer.cfm">
	  
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">


<script>
	$('.btn_upl_core').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&core_material=1"</cfoutput>, function() {});
	});
	
	$('.btn_upl_misc').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&misc_material=1"</cfoutput>, function() {});
	});
	
	$('.btn_upl_thumb').click(function(event) {
		event.preventDefault();
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Upload ressource");
		$('#modal_body_xl').load(<cfoutput>"modal_window_ressource_upload.cfm?sm_id=#sm_id#&thumb_material=1"</cfoutput>, function() {});
	});
</script>


	<script>

	tinymce.init({
	
	selector:'#sessionmaster_ln_grammar,#sessionmaster_ln_vocabulary,.sessionmaster_transcript,#sessionmaster_exercice,.chapter_content',
	branding: false,
	contextmenu: "link image imagetools table spellchecker",
	contextmenu_never_use_native: true,
	draggable_modal: false,
	menubar: '',	
	toolbar: 'undo redo | bold italic underline numlist bullist forecolor link fontsizeselect | alignleft aligncenter alignright alignjustify | table | code',
	plugins: "lists,link,code,table",
	fontsize_formats: '11px 12px 14px'

  
	
	});
	</script>

	
<div id="window_item_xl" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_xl" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_xl" class="modal-body">
			
			</div>
        </div>
    </div>
</div>
	
</body>
</html>