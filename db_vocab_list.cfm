<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,4,12">
	<cfinclude template="./incl/incl_secure.cfm">		

	<cfparam name="vcl_id" default="1">
	
	<cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
	SELECT voc_cat_id, voc_cat_name FROM lms_vocabulary_category ORDER BY voc_cat_name
	</cfquery>

	<cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
	SELECT v.voc_id, v.voc_word_en, v.voc_desc_en, vc.voc_cat_name, v.voc_cat_id
	FROM lms_vocabulary v
	INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
	</cfquery>
	
	<cfquery name="get_voc_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_vocabulary_type
	</cfquery>				
	
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
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							Display : 
							<label><input type="checkbox" class="lang_select" id="lang_en" value="en" <cfif listfind(list_lang,"en")>checked</cfif>> <span class="lang-sm" lang="en"></span></label> &nbsp;&nbsp;&nbsp;
							<label><input type="checkbox" class="lang_select" id="lang_fr" value="fr" <cfif listfind(list_lang,"fr")>checked</cfif>> <span class="lang-sm" lang="fr"></span></label> &nbsp;&nbsp;&nbsp;
							<label><input type="checkbox" class="lang_select" id="lang_de" value="de" <cfif listfind(list_lang,"de")>checked</cfif>> <span class="lang-sm" lang="de"></span></label> &nbsp;&nbsp;&nbsp;
							<label><input type="checkbox" class="lang_select" id="lang_es" value="es" <cfif listfind(list_lang,"es")>checked</cfif>> <span class="lang-sm" lang="es"></span></label> &nbsp;&nbsp;&nbsp;
							<label><input type="checkbox" class="lang_select" id="lang_it" value="it" <cfif listfind(list_lang,"it")>checked</cfif>> <span class="lang-sm" lang="it"></span></label> &nbsp;&nbsp;&nbsp;
							
							
							<a href="#" class="btn btn-info pull-right btn_create_vocab">Add vocab list</a>
								
							<br><br>
							
							<select name="voc_cat_id" class="select_voc_cat form-control">								
							<cfoutput query="get_category">
							<option value="#get_category.voc_cat_id#" <cfif isdefined("vcl_id") AND vcl_id eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
							</cfoutput>							
							</select>
							
							
							<br><br>
							
							<cfif isdefined("vcl_id")>
								<cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
								SELECT * FROM lms_vocabulary WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#"> ORDER BY voc_word_en ASC
								</cfquery>
			
								
								
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

								<table class="table table-sm m-0">
			
									
										<cfquery name="get_vocabulary_groups" datasource="#SESSION.BDDSOURCE#">
											SELECT DISTINCT voc_group FROM lms_vocabulary_new
											WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
											ORDER BY voc_group ASC
										</cfquery>
										
										<cfloop query="get_vocabulary_groups">
											<cfquery name="get_vocabulary_new" datasource="#SESSION.BDDSOURCE#">
												SELECT * FROM lms_vocabulary_new 
												WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#vcl_id#">
												AND voc_group = <cfqueryparam cfsqltype="cf_sql_varchar" value="#voc_group#">
												AND formation_code in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#list_lang#" list="yes">)
											</cfquery>
											
											<cfoutput>
											<!--- 	<cfdump var="#get_vocabulary_new#" > --->
												<tr <cfif isdefined("v_id") AND v_id eq voc_id>class="bg-info"</cfif>>
													<cfloop query="get_vocabulary_new">
														<form action="db_updater_resource.cfm" method="post">	
														<cfif get_vocabulary_new.voc_id eq get_vocabulary_new.voc_id>
													  
														
															<cfif get_vocabulary_new.formation_code eq "en">
																<cfset td_color = "ecd9d9">
															<cfelseif get_vocabulary_new.formation_code eq "fr">
																<cfset td_color = "c6cbe1">
															<cfelseif get_vocabulary_new.formation_code eq "de">
																<cfset td_color = "c8d4ca">
															<cfelseif get_vocabulary_new.formation_code eq "es">
																<cfset td_color = "FE5468">
															<cfelseif get_vocabulary_new.formation_code eq "it">
																<cfset td_color = "123C65"></cfif>
														
													   
															<td bgcolor="###td_color#">
																#get_vocabulary_new.voc_id#
																#get_vocabulary_new.voc_group#
																
															</td>
															<td bgcolor="###td_color#">
																<span class="lang-sm" lang="#get_vocabulary_new.formation_code#"></span>
															</td>
															<td bgcolor="###td_color#">
																  <input type="text" name="vocword_#get_vocabulary_new.formation_code#_#get_vocabulary_new.voc_id#" class="form-control form-control-sm p-1" value="#get_vocabulary_new.voc_word#">
															</td>
															<td bgcolor="###td_color#">
																<select name="voctype_#get_vocabulary_new.formation_code#_id" class="form-control form-control-sm">
																<cfloop query="get_voc_type">
																	<option value="#get_voc_type.voc_type_id#" <cfif get_vocabulary_new.voc_type_id eq get_voc_type.voc_type_id>selected</cfif>>#evaluate("voc_type_name_#get_vocabulary_new.formation_code#")#</option>
																</cfloop>
																</select>
															</td>
															<td bgcolor="###td_color#">
																  <input type="text" name="vocdesc_#get_vocabulary_new.formation_code#_#get_vocabulary_new.voc_id#" class="form-control form-control-sm p-1" value="#get_vocabulary_new.voc_desc#">
															</td>
														  
															
														</cfif>
													</cfloop>
													
													
													<td>
														<a class="btn btn-sm btn-danger" href="db_updater_resource.cfm?act=del_voc&voc_group=#get_vocabulary_new.voc_group#&vcl_id=#vcl_id#&list_lang=#list_lang#">DEL</a>
														<a title="button to add or remove vocab from shortlist" class="btn btn-sm btn-primary btn-shortlist" id="shortlist_#get_vocabulary_new.voc_group#" data-is-shortlist="#get_vocabulary_new.voc_is_shortlist#">
															
															<cfif isDefined(get_vocabulary_new.voc_is_shortlist)>
																<i class="fa-solid fa-star"></i>
															<cfelse>
																<i class="fa-light fa-star"></i>
															</cfif>
											
														</a>
													</td>
												
												<td align="center" colspan="10">
													<input type="hidden" name="act" value="updt_voc">
													<input type="hidden" name="list_lang" value="#list_lang#">
													<input type="hidden" name="vcl_id" value="#vcl_id#">
													<input type="hidden" name="voc_group" value="#get_vocabulary_new.voc_group#">
													<!--- <input type="submit" class="btn btn-sm btn-info" value="UPDATE ALL WORDS"> --->
													<input type="submit" class="btn btn-info btn-sm" value="MAJ">
													
													 	
												
												</td>
											
											</tr></cfoutput> </form>
										
										</cfloop>
									
								
								</table>
								







								<br><br>

								<form action="db_updater_resource.cfm" method="post">
								<table class="table table-sm mt-2">
									<tr>
										<cfoutput>
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
											<span class="lang-sm" lang="#cor#"></span>
										</td>
										<td bgcolor="###td_color#">
											  <input type="text" name="voc_word_#cor#" class="form-control form-control-sm p-1">
										</td>
										<td bgcolor="###td_color#">
											<select name="voctype_#cor#_id" class="form-control form-control-sm">
											<cfloop query="get_voc_type">
												<option value="#voc_type_id#">#evaluate("voc_type_name_#cor#")#</option>
											</cfloop>
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
								</form>
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
	lang_code = "";
	
	$('.select_voc_cat').change(function(event) {		
		document.location.href="db_vocab_list.cfm?vcl_id="+$(this).val();	
	});
	
	$('.btn_create_vocab').click(function(event) {	
		event.preventDefault();		
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("Ajouter Vocabulary list");
		$('#modal_body_lg').load("modal_window_ressource.cfm?new_vocab=1", function() {});
	});
	
	$('.lang_select').click(function(event) {	

		var list_lang = [];
		if($('#lang_en').is(":checked")){list_lang.push("en")}
		if($('#lang_fr').is(":checked")){list_lang.push("fr")}
		if($('#lang_de').is(":checked")){list_lang.push("de")}
		if($('#lang_es').is(":checked")){list_lang.push("es")}
		if($('#lang_it').is(":checked")){list_lang.push("it")}

		<cfoutput>
		document.location.href="db_vocab_list.cfm?vcl_id=#vcl_id#&list_lang="+list_lang;
		</cfoutput>
		
	});
	
	
	
});

navigator.mediaDevices.getUserMedia({audio:true}).then(stream => {handlerFunction(stream)})


	function handlerFunction(stream) {
		rec = new MediaRecorder(stream);
			rec.ondataavailable = e => {
			audioChunks.push(e.data);
			if (rec.state == "inactive"){
				let blob = new Blob(audioChunks,{type:'audio/mpeg-3'});
				<!--- $("#recordedAudio").prop("src",URL.createObjectURL(blob)); --->
				<!--- $("#recordedAudio").prop("controls",true); --->
				<!--- $("#recordedAudio").prop("autoplay",true); --->
				sendData(blob);
			}
		}
	}
	function sendData(blob) {
		var fd = new FormData();
		fd.append('data', blob);
		fd.append('voc_id', voc_id);
		fd.append('lang_code', lang_code);
		//alert(voc_id);
		$.ajax({
			url: "uploader.cfc?method=insert_voc_audio",
			type: "POST",
			data: fd,
			processData: false,
			contentType: false,
			success: function (result) {
				$("#td_"+lang_code+"_"+voc_id).find("audio").remove();
				$("#td_"+lang_code+"_"+voc_id).find("a").remove();
				
				var content_append = '<audio id="play_'+lang_code+'_'+voc_id+'" src="./assets/voc/word_'+lang_code+'_'+voc_id+'.mp3"></audio>';
				content_append += '<a class="btn btn-sm btn-success btn_player" id="btnplay_'+lang_code+'_'+voc_id+'"><i class="fad fa-play"></i></a>'
				$("#td_"+lang_code+"_"+voc_id).prepend(content_append);
											
				$("#btnplay_"+lang_code+"_"+voc_id).bind("click",play_audio);							
				<!--- $("#td_"+voc_id).append('<i class="fad fa-check-circle text-success"></i>'); --->
			}
		})
	}
	
	
	// $(".record").click(function(event) {
	// 	event.preventDefault;
	// 	var idtemp = $(this).attr("id");
	// 	var idtemp = idtemp.split("_");
	// 	lang_code = idtemp[1];
	// 	voc_id = idtemp[2];
	// 	console.log(lang_code);
	// 	$(this).append('<div class="spinner-grow spinner-grow-sm" role="status" id="load_'+voc_id+'">');
	// 	$(this).prop("disabled",true);
	// 	$("#sr_"+lang_code+"_"+voc_id).prop("disabled",false);
	// 	audioChunks = [];
	// 	rec.start();
	// })
		
	// $(".stopRecord").click(function(event) {
	// 	event.preventDefault;	
	// 	var idtemp = $(this).attr("id");
	// 	var idtemp = idtemp.split("_");
	// 	lang_code = idtemp[1];
	// 	voc_id = idtemp[2];
	// 	console.log(lang_code);
	// 	$("#load_"+voc_id).remove();
	// 	$("#r_"+lang_code+"_"+voc_id).prop("disabled",false);
	// 	$(this).prop("disabled",true);
	// 	rec.stop();
	// })
	
	// function play_audio(){
	// 	var idtemp = $(this).attr("id");
	// 	var idtemp = idtemp.split("_");
	// 	lang_code = idtemp[1];
	// 	voc_id = idtemp[2];
	// 	$("#play_"+lang_code+"_"+voc_id).get(0).play();
	
	// }
	// $(".btn_player").bind("click",play_audio);

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
	
	$(".btn-shortlist").click(function(){
    //prevent the default behavior of the click event
    event.preventDefault();
    //get the value of the "data-is-shortlist" attribute from the button that was clicked
    var voc_is_shortlist = $(this).attr("data-is-shortlist");
    // toggle the value of voc_is_shortlist to the opposite
    var new_voc_is_shortlist = voc_is_shortlist == 0 ? 1 : 0;
    //determine the icon to be used based on the value of voc_is_shortlist
    var icon = voc_is_shortlist == 0 ? 'fa-thin fa-star' : 'fa-solid fa-star';
    //get the id of the button that was clicked, and extracting the voc_id from it
    var idtemp = $(this).attr("id");
    var idtemp = idtemp.split("_");
    var voc_group = idtemp[1];	

    //make an ajax call to update the shortlist status
    $.ajax({
        url: "./api/vocab/vocab_post.cfc?method=updateShortList",
        data: {
            voc_group: voc_group
          
        },
        success: function(data){
            //if the call was successful, update the button's icon and data-is-shortlist attribute
            alert("Whatever you wanted to do, it worked, thanks! (Also, Em is awesome)");
            location.href= location.href;
            $(this).attr("data-is-shortlist", new_voc_is_shortlist);
            $(this).html("<i class='"+icon+"'></i>");
        },
        error: function(data){
            //if the call was not successful, display an error message
            alert("Dammit, Em, there was some error *raises fist to the air*!");
        }
    });


});

 


	
	
</script>

</body>
</html>