<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,4,12">
	<cfinclude template="./incl/incl_secure.cfm">		

	<cfparam name="vcl_id" default="1">
	
	<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
	SELECT voc_cat_id, voc_cat_name FROM lms_vocabulary_category ORDER BY voc_cat_name
	</cfquery>

	<!--- <cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
	SELECT v.voc_id, v.voc_word_en, v.voc_desc_en, vc.voc_cat_name, v.voc_cat_id
	FROM lms_vocabulary v
	INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
	</cfquery> --->
	
	<!--- <cfquery name="get_voc_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_vocabulary_type
	</cfquery>				 --->
	
	<cfif not isdefined("list_lang") OR list_lang eq "">
		<cfset list_lang = "en">
	</cfif>

	<cfset selected_lang = listGetAt(list_lang, 1, ",")>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Vocabulary list">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
			<div class="row">
					
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
						<div class="card-body">
						
					
<!--- <audio id="recordedAudio"></audio> --->
					
							<h5 class="card-title d-inline">Vocab List</h5>
							
							<a href="#" class="btn btn-info pull-right btn_create_vocab">Add vocab list</a>
								
							<br><br>
							
							<select name="voc_cat_id" class="select_voc_cat form-control">								
							<cfoutput query="get_category">
							<option value="#get_category.voc_cat_id#" <cfif isdefined("vcl_id") AND vcl_id eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
							</cfoutput>							
							</select>
							
							
							<br><br>
							
							<cfif isdefined("vcl_id")>
								
								<cfquery name="get_category_solo" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_vocabulary_category WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
								</cfquery>
								
								<cfoutput>
								<form action="db_updater_resource.cfm" method="post">
								<table class="table table-bordered table-sm m-0">
									<tr>
										<td width="50" align="center">Default</td>
										<td><input type="text" class="form-control" name="voc_cat_name" value="#get_category_solo.voc_cat_name#"></td>
										<td width="50">
											ID
										</td>
										<td>
											#get_category_solo.voc_cat_id#
										</td>
										<td>
											<a id='markup-copy' class="btn btn-sm btn-info">Copy List</a>
										</td>
									</tr>
									<tr>
										<td align="center"><span class="lang-sm" lang="fr"></span></td>
										<td><input type="text" class="form-control" name="voc_cat_name_fr" value="#get_category_solo.voc_cat_name_fr#"></td>
										<td rowspan="5" colspan="3">
											<input type="hidden" name="act" value="updt_voc_cat">
											<input type="hidden" name="vcl_id" value="#vcl_id#">
											<input type="submit" class="btn btn-sm btn-info" value="UPDATE LIST NAME">
										</td>
									</tr>
									<tr>
										<td align="center"><span class="lang-sm" lang="en"></span></td>
										<td><input type="text" class="form-control" name="voc_cat_name_en" value="#get_category_solo.voc_cat_name_en#"></td>
									</tr>
									<tr>
										<td align="center"><span class="lang-sm" lang="de"></span></td>
										<td><input type="text" class="form-control" name="voc_cat_name_de" value="#get_category_solo.voc_cat_name_de#"></td>
									</tr>
									<tr>
										<td align="center"><span class="lang-sm" lang="es"></span></td>
										<td><input type="text" class="form-control" name="voc_cat_name_es" value="#get_category_solo.voc_cat_name_es#"></td>
									</tr>
									<tr>
										<td align="center"><span class="lang-sm" lang="it"></span></td>
										<td><input type="text" class="form-control" name="voc_cat_name_it" value="#get_category_solo.voc_cat_name_it#"></td>
									</tr>
									<tr>
										<td align="center">Online</td>
										<td align="left"><input type="checkbox" name="voc_cat_online" value="1" <cfif get_category_solo.voc_cat_online eq "1">checked</cfif>></td>
									</tr>
									
								</table>
								</form>
								</cfoutput>

								<br><br>


								<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
									SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category,
									vt.voc_type_name_#SESSION.LANG_CODE# as voc_type_name
									FROM lms_vocabulary_new v
									LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
									WHERE v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
									AND v.formation_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#SESSION.LANG_CODE#">
									ORDER BY voc_word ASC
								</cfquery>

								<table class="table table-sm m-0">
								<cfoutput query="get_vocabulary">
									<tr>
										<td>
											#voc_id#
										</td>
										<td>
											<span class="lang-sm" lang="#SESSION.LANG_CODE#"></span>
										</td>
										<td>
											#voc_word#
										</td>
										<td>
											#voc_type_name#
										</td>
										<td>
											#voc_desc#
										</td>
										<td>
											<button class="btn btn-info btn_maj_word" data-id="#voc_group#">MAJ</button>
											<!--- <input type="submit" class="btn btn-info btn-sm" value="MAJ"> --->
										</td>
									</tr>
									<!--- <form action="db_updater_resource.cfm" method="post">						
									<tr <cfif isdefined("v_id") AND v_id eq voc_id>class="bg-info"</cfif>>
										<cfloop list="en,fr,de,es,it" index="cor">
										
										<cfif listfind(list_lang,cor)>
										<cfif cor eq "en">
											<cfset td_color = "ecd9d9">
										<cfelseif cor eq "fr">
											<cfset td_color = "c6cbe1">
										<cfelseif cor eq "de">
											<cfset td_color = "c8d4ca">
										<cfelseif cor eq "es">
											<cfset td_color = "FE5468">
										<cfelseif cor eq "it">
											<cfset td_color = "123C65">
										</cfif>
										<td bgcolor="###td_color#">
											#voc_id#
										</td>
										<td bgcolor="###td_color#">
											<span class="lang-sm" lang="#cor#"></span>
										</td>
										<td bgcolor="###td_color#">
											  <input type="text" name="vocword_#cor#_#voc_id#" class="form-control form-control-sm p-1" value="#evaluate('voc_word_#cor#')#">
										</td>
										<td bgcolor="###td_color#">
											<select name="voctype_#cor#_id_#voc_id#" class="form-control form-control-sm">
											<cfloop query="get_voc_type">
												<option value="#voc_type_id#" <cfif evaluate("get_vocabulary.voc_type_#cor#_id") eq voc_type_id>selected</cfif>>#evaluate("voc_type_name_#cor#")#</option>
											</cfloop>
											</select>
										</td>
										<td bgcolor="###td_color#">
											  <input type="text" name="vocdesc_#cor#_#voc_id#" class="form-control form-control-sm p-1" value="#evaluate('voc_desc_#cor#')#">
										</td>
										<td id="td_#cor#_#voc_id#">
											<cfif fileexists("#SESSION.BO_ROOT#/assets/voc/word_#cor#_#voc_id#.mp3")>
											<audio id="play_#cor#_#voc_id#" src="./assets/voc/word_#cor#_#voc_id#.mp3"></audio>
											<a class="btn btn-sm btn-success btn_player" id="btnplay_#cor#_#voc_id#"><i class="fad fa-play"></i></a>
											</cfif>
											<button class="btn btn-sm btn-warning record" id="r_#cor#_#voc_id#">REC</button>
											<button class="btn btn-sm btn-danger stopRecord" id="sr_#cor#_#voc_id#" disabled>Stop<span class="sr-only">Loading...</span></button>
										</td>
										</cfif>
										</cfloop>
										<td>
											<a class="btn btn-sm btn-danger" href="db_updater_resource.cfm?act=del_voc&voc_id=#voc_id#&vcl_id=#vcl_id#&list_lang=#list_lang#">DEL</a>
										</td>
										
										<td align="center" colspan="10">
											<input type="hidden" name="act" value="updt_voc">
											<input type="hidden" name="list_lang" value="#list_lang#">
											<input type="hidden" name="vcl_id" value="#vcl_id#">
											<!--- <input type="submit" class="btn btn-sm btn-info" value="UPDATE ALL WORDS"> --->
											<input type="submit" class="btn btn-info btn-sm" value="MAJ">
										</td>
									</tr>
								</form> --->
								</cfoutput>
								</table>
								
								<br><br>

								<!--- <form action="db_updater_resource.cfm" method="post">
								<table class="table table-sm mt-2">
									<tr>
										<cfoutput>
										<cfloop list="en,fr,de,it" index="cor">
										<cfif listfind(list_lang,cor)>
										
										<cfif cor eq "en">
											<cfset td_color = "ecd9d9">
										<cfelseif cor eq "fr">
											<cfset td_color = "c6cbe1">
										<cfelseif cor eq "de">
											<cfset td_color = "c8d4ca">
										<cfelseif cor eq "es">
											<cfset td_color = "FE5468">
										<cfelseif cor eq "it">
											<cfset td_color = "123C65">
										</cfif>
										
										
										<td bgcolor="###td_color#">
											<span class="lang-sm" lang="#cor#"></span>
										</td>
										<td bgcolor="###td_color#">
											  <input type="text" name="voc_word_#cor#" class="form-control form-control-sm p-1">
										</td>
										<td bgcolor="###td_color#">
											<select name="voc_type_#cor#" class="form-control form-control-sm">
												<option value="Noun">Noun</option>
												<option value="Verb">Verb</option>
												<option value="Adjective">Adjective</option>
												<option value="Interjection">Interjection</option>
												<option value="Verb Phrase">Verb Phrase</option>
												<option value="Phrase">Phrase</option>
												<option value="Adverb">Adverb</option>
												<option value="" selected>-</option>
											</select>
										</td>
										<td bgcolor="###td_color#">
											  <input type="text" name="voc_desc_#cor#" class="form-control form-control-sm p-1">
										</td>
										</cfif>
										</cfloop>
										<td>
											<input type="hidden" name="act" value="ins_voc">
											<input type="hidden" name="list_lang" value="#list_lang#">
											<input type="hidden" name="vcl_id" value="#vcl_id#">
											<input type="submit" class="btn btn-sm btn-info" value="insert">
										</td>
										</cfoutput>
									</tr>
								</table>
								</form> --->
							</cfif>
							
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
$( document ).ready(function() {

	<!--- global vars --->
	voc_id = "";
	
	$('.select_voc_cat').change(function(event) {		
		document.location.href="db_vocab_up.cfm?vcl_id="+$(this).val();	
	});
	
	$('.btn_create_vocab').click(function(event) {	
		event.preventDefault();		
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter Vocabulary list");
		$('#modal_body_lg').load("modal_window_ressource.cfm?new_vocab=1", function() {});
	});
	
	$('.btn_maj_word').click(function(event) {	
		event.preventDefault();		
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Update Voc");
		$('#modal_body_lg').load("modal_window_word.cfm?voc_group=" + event.target.dataset.id, function() {});
	});
	
	$("#markup-copy").click(function(event) {
		event.preventDefault;	

		$.ajax({
            url : './api/vocab/vocab_get.cfc?method=get_word_list',
            type : 'GET',
            data : {vcl_id:<cfoutput>#vcl_id#</cfoutput>, lang: "<cfoutput>#selected_lang#</cfoutput>"},				
            success : function(result, status) {
                // $(".tr_teaching_"+teaching_id+"").remove();
                var obj_result = jQuery.parseJSON(result);
				// console.log(result);

				let txt = "";
				for (let index = 0; index < obj_result.length; index++) {
					const element = obj_result[index];
					txt += element["WORD"].replace(/\([^()]*\)/g, '');
					txt += "\n";
				}

				// console.log(obj_result);
				navigator.clipboard.writeText(txt);
				alert("list copied to clipboard")

            }
        });

	})

	
});
</script>

</body>
</html>