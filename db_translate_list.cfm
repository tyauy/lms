<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,4,12">
	<cfinclude template="./incl/incl_secure.cfm">		
	
	<cfparam name="t_type" default="0">
	<cfparam name="t_cat" default="short">
	<cfparam name="display_tls" default="missing">


	<cfquery name="get_translation" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM lms_translation 
	WHERE translation_cat = <cfqueryparam cfsqltype="cf_sql_varchar" value = "#t_cat#">
	<cfif t_type neq "0">
	AND translation_type = <cfqueryparam cfsqltype="cf_sql_varchar" value = "#t_type#">
	</cfif>
	<cfif display_tls eq "missing">
	AND 
	(
		(translation_string_fr IS NULL OR translation_string_fr = "")
		OR (translation_string_en IS NULL OR translation_string_en = "")
		OR (translation_string_de IS NULL OR translation_string_de = "")
		OR (translation_string_es IS NULL OR translation_string_es = "")
		OR (translation_string_it IS NULL OR translation_string_it = "")
	)
	</cfif>
	ORDER BY translation_id DESC
	</cfquery>	
	
	<cfquery name="get_translation_type" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT(translation_type) as translation_type FROM lms_translation ORDER BY translation_type ASC
	</cfquery>
	
	<cfif not isdefined("list_lang") OR list_lang eq "">
		<cfset list_lang = "en">
	</cfif>
	
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
	





<!--- <cfset test = serializeJSON(get_translation)> --->
<!--- <cfset test2 = > --->
<!--- <cfset test4 = serializeJSON(get_translation,"struct")> --->
<!--- <cfdump var="#myStruct2.data#"> --->
<!--- <cfdump var="#myStruct2.data.TRANSLATION_CODE#"> --->
<!--- <cfset myStruct = deserializeJSON(test)> --->
<!--- <cfset myStruct2 = deserializeJSON(test2)> --->
<!--- <cfset myStruct4 = deserializeJSON(test4)> --->
<!--- <cfdump var="#myStruct.data#"> --->



<!--- <cfoutput>#structFind(myStruct.data, "sidemenu_trainer_settings")#</cfoutput> --->


<!--- using dot notation --->
<!--- <cfif StructKeyExists(myStruct, "myKey")> --->
    <!--- <cfoutput> #mystruct.myKey#</cfoutput><br> --->
<!--- </cfif> --->

<!--- or using access notation --->
<!--- <cfif StructKeyExists(myStruct, LastName)> --->
    <!--- <cfoutput>#LastName#: #mystruct[LastName]#</cfoutput><br> --->
<!--- </cfif> --->

<!--- <cfoutput>#StructKeyExists(myStruct.data,translation_id)#</cfoutput> --->

<!--- <cfdump var="#myStruct.data#"> --->

<!--- <cfdump var="#myStruct.data[4]#"> --->

<!--- <cfdump var="#myStruct#"> --->

<!--- <cfdump var="#myStruct2#"> --->

			<div class="row">
					
				<div class="col-md-12">
					
					<div class="card border-top border-info">
					
						<div class="card-body">
							
							<div class="row">
								<div class="col-md-4">

									Display : 
									<br>
									<label><input type="checkbox" class="lang_select" id="lang_en" value="en" <cfif listfind(list_lang,"en")>checked</cfif>> <span class="lang-sm" lang="en"></span></label> &nbsp;&nbsp;&nbsp;
									<label><input type="checkbox" class="lang_select" id="lang_fr" value="fr" <cfif listfind(list_lang,"fr")>checked</cfif>> <span class="lang-sm" lang="fr"></span></label> &nbsp;&nbsp;&nbsp;
									<label><input type="checkbox" class="lang_select" id="lang_de" value="de" <cfif listfind(list_lang,"de")>checked</cfif>> <span class="lang-sm" lang="de"></span></label> &nbsp;&nbsp;&nbsp;
									<label><input type="checkbox" class="lang_select" id="lang_es" value="es" <cfif listfind(list_lang,"es")>checked</cfif>> <span class="lang-sm" lang="es"></span></label> &nbsp;&nbsp;&nbsp;
									<label><input type="checkbox" class="lang_select" id="lang_it" value="it" <cfif listfind(list_lang,"it")>checked</cfif>> <span class="lang-sm" lang="it"></span></label> &nbsp;&nbsp;&nbsp;
									<label><input type="checkbox" class="lang_select" id="lang_zh" value="zh" <cfif listfind(list_lang,"zh")>checked</cfif>> <span class="lang-sm" lang="zh"></span></label> &nbsp;&nbsp;&nbsp;
							
									
								</div>
								<div class="col-md-3">
									Category :
									<br>
									<cfoutput>
									<a href="db_translate_list.cfm?t_cat=short&list_lang=#list_lang#&display_tls=#display_tls#" class="btn btn-sm btn-info <cfif t_cat eq "short">active</cfif>">
									SHORT
									</a>
									<a href="db_translate_list.cfm?t_cat=long&list_lang=#list_lang#&display_tls=#display_tls#" class="btn btn-sm btn-info <cfif t_cat eq "long">active</cfif>">
									COMPLEX
									</a>
									</cfoutput>
								</div>
								<div class="col-md-2">
									Filter :
									<br>
									<cfoutput>
									<a href="db_translate_list.cfm?t_cat=#t_cat#&list_lang=#list_lang#&display_tls=all" class="btn btn-sm btn-info <cfif display_tls eq "all">active</cfif>">
									ALL
									</a>
									<a href="db_translate_list.cfm?t_cat=#t_cat#&list_lang=#list_lang#&display_tls=missing" class="btn btn-sm btn-info <cfif display_tls eq "missing">active</cfif>">
									MISSING
									</a>
									</cfoutput>
								</div>
								<div class="col-md-3">
									Type :

									<cfoutput><select name="" class="form-control" onchange="document.location.href='db_translate_list.cfm?t_cat=#t_cat#&list_lang=#list_lang#&display_tls=#display_tls#&t_type='+$(this).val()"></cfoutput>
										<cfoutput query="get_translation_type">
											<option value="#translation_type#" <cfif t_type eq translation_type>selected</cfif>>#translation_type#</option>
										</cfoutput>
									</select>
								</div>

							</div>


								<br><br>
								
								<table class="table table-sm m-0">
								<cfoutput query="get_translation">	
								<form action="db_updater.cfm" method="post">							
									<tr>									
										<td class="bg-light">
										<a name="t_#translation_id#"></a>
											<small>#translation_id#</small>
										</td>
										<td class="bg-light">
											<small>#translation_code#</small>
										</td>
										<td class="bg-light">
											<small>#translation_type#</small>
										</td>
										<cfloop list="en,fr,de,es,it,zh" index="cor">
										
										<cfif listfind(list_lang,cor)>
										<cfif cor eq "en">
											<cfset td_color = "ecd9d9">
										<cfelseif cor eq "fr">
											<cfset td_color = "c6cbe1">
										<cfelseif cor eq "de">
											<cfset td_color = "c8d4ca">
										<cfelseif cor eq "es">
											<cfset td_color = "e9c5f3">
										<cfelseif cor eq "it">
											<cfset td_color = "123C65">
										<cfelseif cor eq "zh">
											<cfset td_color = "cbe2ed">
										</cfif>
										<td bgcolor="###td_color#">
											<span class="lang-sm" lang="#cor#"></span>
										</td>
										<td bgcolor="###td_color#">
											<cfif t_cat eq "short">
											<input type="text" name="translation_string_#cor#" class="form-control form-control-sm p-1" value="#evaluate('translation_string_#cor#')#">
											<cfelse>
											<textarea name="translation_string_#cor#" cols="100" rows="5" style="width:500px !important; font-size:11px !important">#evaluate('translation_string_#cor#')#</textarea>											
											</cfif>
										</td>
										</cfif>
										</cfloop>
										<td>
											<!--- <a class="btn btn-sm btn-info" href="db_updater_resource.cfm?act=del_voc&voc_id=#voc_id#&vcl_id=#vcl_id#&list_lang=#list_lang#">DEL</a> --->
											<input type="hidden" name="act" value="updt">
											<input type="hidden" name="t_cat" value="#t_cat#">
											<input type="hidden" name="t_type" value="#t_type#">
											<input type="hidden" name="list_lang" value="#list_lang#">
											<input type="hidden" name="translation_id" value="#translation_id#">
											<input type="submit" class="btn btn-info btn-sm" value="MAJ">
										</td>
										
									</tr>
								</form>
								</cfoutput>
								<!--- <cfoutput> --->
									<!--- <tr> --->
										<!--- <td align="center" colspan="10"> --->
											<!--- <input type="hidden" name="act" value="updt_voc"> --->
											<!--- <input type="hidden" name="list_lang" value="#list_lang#"> --->
											<!--- <input type="submit" class="btn btn-sm btn-info" value="UPDATE ALL WORDS"> --->
										<!--- </td> --->
									<!--- </tr> --->
								<!--- </cfoutput> --->
								</table>
								<!--- </cfform> --->
								
								<br><br>

								<!--- <form action="db_updater_resource.cfm" method="post"> --->
								<!--- <table class="table table-sm mt-2"> --->
									<!--- <tr> --->
										<!--- <cfoutput> --->
										<!--- <cfloop list="en,fr,de" index="cor"> --->
										<!--- <cfif listfind(list_lang,cor)> --->
										
										<!--- <cfif cor eq "en"> --->
											<!--- <cfset td_color = "ecd9d9"> --->
										<!--- <cfelseif cor eq "fr"> --->
											<!--- <cfset td_color = "c6cbe1"> --->
										<!--- <cfelseif cor eq "de"> --->
											<!--- <cfset td_color = "c8d4ca"> --->
										<!--- </cfif> --->
										
										
										<!--- <td bgcolor="###td_color#"> --->
											<!--- <span class="lang-sm" lang="#cor#"></span> --->
										<!--- </td> --->
										<!--- <td bgcolor="###td_color#"> --->
											  <!--- <input type="text" name="voc_word_#cor#" class="form-control form-control-sm p-1"> --->
										<!--- </td> --->
										<!--- <td bgcolor="###td_color#"> --->
											<!--- <select name="voc_type_#cor#" class="form-control form-control-sm"> --->
												<!--- <option value="Noun">Noun</option> --->
												<!--- <option value="Verb">Verb</option> --->
												<!--- <option value="Adjective">Adjective</option> --->
												<!--- <option value="Interjection">Interjection</option> --->
												<!--- <option value="Verb Phrase">Verb Phrase</option> --->
												<!--- <option value="Phrase">Phrase</option> --->
												<!--- <option value="Adverb">Adverb</option> --->
												<!--- <option value="" selected>-</option> --->
											<!--- </select> --->
										<!--- </td> --->
										<!--- <td bgcolor="###td_color#"> --->
											  <!--- <input type="text" name="voc_desc_#cor#" class="form-control form-control-sm p-1"> --->
										<!--- </td> --->
										<!--- </cfif> --->
										<!--- </cfloop> --->
										<!--- <td> --->
											<!--- <input type="hidden" name="act" value="ins_voc"> --->
											<!--- <input type="hidden" name="list_lang" value="#list_lang#"> --->
											<!--- <input type="hidden" name="vcl_id" value="#vcl_id#"> --->
											<!--- <input type="submit" class="btn btn-sm btn-info" value="insert"> --->
										<!--- </td> --->
										<!--- </cfoutput> --->
									<!--- </tr> --->
								<!--- </table> --->
								<!--- </form> --->
							
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


	<!--- $('.btn_create_vocab').click(function(event) {	 --->
		<!--- event.preventDefault();		 --->
		
		<!--- $('#window_item_lg').modal({keyboard: true}); --->
		<!--- $('#modal_title_lg').text("Ajouter Vocabulary list"); --->
		<!--- $('#modal_body_lg').load("modal_window_ressource.cfm?new_vocab=1", function() {}); --->
	<!--- }); --->
	
	$('.lang_select').click(function(event) {	

		var list_lang = [];
		if($('#lang_en').is(":checked")){list_lang.push("en")}
		if($('#lang_fr').is(":checked")){list_lang.push("fr")}
		if($('#lang_de').is(":checked")){list_lang.push("de")}
		if($('#lang_es').is(":checked")){list_lang.push("es")}
		if($('#lang_zh').is(":checked")){list_lang.push("zh")}
		if($('#lang_it').is(":checked")){list_lang.push("it")}
		
		<cfoutput>
		document.location.href="db_translate_list.cfm?t_cat=#t_cat#&t_type=#t_type#&display_tls=#display_tls#&list_lang="+list_lang;
		</cfoutput>
		
	});	
	
});

	
	
</script>

</body>
</html>