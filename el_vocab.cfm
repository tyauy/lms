<cfsilent>

    <cfparam name="lang_select_id" default="2">
    <cfparam name="cat_id" default="1">
    <cfparam name="lang_select" default="en">
    <cfparam name="lang_translate" default="fr">
    <cfparam name="subm" default="vocabulary">
    <cfparam name="voc_group" default="47">

    <cfif isDefined("URL.cat_id")>
        <cfset cat_id=URL.cat_id>
     <cfelse>
        <cfset cat_id = RandRange(2, 71)>

     </cfif>
    
    <cfif isDefined("URL.lang_select")>
        <cfset lang_select=URL.lang_select>
     <cfelse>
        <cfset lang_select= "en">
     </cfif>
     
     <cfif isDefined("URL.lang_translate")>
        <cfset lang_translate=URL.lang_translate>
     <cfelse>
        <cfset lang_translate=SESSION.LANG_CODE>
     </cfif>

     <cfif isDefined("URL.lang_select")>
        <cfset lang_select_code=URL.lang_select>
     <cfelse>
        <cfset lang_select_code= "en">
     </cfif>

    <cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
        SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1 ORDER BY voc_cat_name
    </cfquery>

    <cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">
        SELECT formation_accent_name_#lang_select# as formation_accent_name, formation_accent_id
        FROM lms_formation_accent
        WHERE formation_accent_vocab = 1
        AND formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#lang_select_id#">
    </cfquery>

    <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
        SELECT v.voc_id, v.voc_group, v.voc_word, v.voc_desc, v.voc_category, v.formation_code, v.formation_id, voc_cat_id,
        vt.voc_type_name_#lang_select# as voc_type_name
        FROM lms_vocabulary_new v
        LEFT JOIN lms_vocabulary_type vt ON vt.voc_type_id = v.voc_type_id
        WHERE v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cat_id#">
            AND formation_code in ('#lang_select#', '#lang_translate#')
            ORDER BY CASE WHEN formation_code = '#lang_select#' THEN v.voc_word END ASC
    </cfquery>
    
    <cfquery name="get_vocabulary_all" datasource="#SESSION.BDDSOURCE#">
        SELECT v.voc_id, v.voc_word, v.voc_group, v.voc_desc, vc.voc_cat_name_#lang_select# as voc_cat_name, v.voc_cat_id
        FROM lms_vocabulary_new v
        INNER JOIN lms_vocabulary_category vc ON vc.voc_cat_id = v.voc_cat_id
        WHERE voc_cat_online = 1
        AND formation_code in ('#lang_select#')
    </cfquery>
    
</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>
    .highlight{
        background-color: #F8A1A8 !important;
    }
    .sticky-header {
        position: sticky;
        top: 0;
        background-color: inherit;
        z-index: 100;
    }
    .typeahead__container {
    z-index: 101; /* Adjust this value as needed */
    }

    </style>
</head>



<!--- <cfset voc_btn_class = "fal fa-heart-square fa-2x btn_add_uvoc cursored">
<cfif subm eq "vocabulary_perso">
<cfset voc_btn_class = "fal fa-trash-alt fa-lg btn_rm_uvoc cursored">
</cfif> --->



<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "*WEFIT LMS*">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row mt-3">
                    <div class="col-md-12">

                        <div class="nav nav-tabs">
                            
                            <button class="nav-link active border-0" type="button" onclick="document.location.href='el_vocab.cfm?cat_id=<cfoutput>#cat_id#</cfoutput>'"><!---<i class="fa-light fa-spell-check"></i> --->
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-3 img_rounded" src="./assets/img/thumb_long_6.jpg" width="90">
                                    </div>
                                    <div align="left">
                                        <h5 style="font-size:18px" class="mb-0">
                                        <cfoutput>#obj_translater.get_translate('tab_vocab_list')#</cfoutput>
                                        </h5>
                                    </div>
                                </div>
                            </button>
                                
                            <button class="nav-link border-0" type="button" onclick="document.location.href='el_vocab_perso.cfm'">
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-3 img_rounded" src="./assets/img/thumb_long_7.jpg" width="90">
                                    </div>
                                    <div align="left">
                                        <h5 style="font-size:18px" class="mb-0">
                                        <cfoutput>#obj_translater.get_translate('tab_vocab_favorite')#</cfoutput>
                                        </h5>
                                    </div>
                                </div>
                            </button>
                        </div>

                        <div class="card" style="margin-top:-1px !important">

                            <div class="card-body">

                                
                                <!--- <div class="w-100 mb-3">
                                    <h5 class="d-inline"><i class="fa-thin fa-spell-check fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('card_vocabulary_list')#</cfoutput></h5>
                                    <hr class="border-red mb-1 mt-2">
                                </div> --->

                                <cfoutput>
                                    <p style="font-size:18px">#obj_translater.get_translate_complex('intro_vocablist')#</p>
                                </cfoutput>
                                
                                <div class="row">
                                    <div class="col-md-12">

                                        <cfoutput>
                                        <div class="border bg-light p-2 w-100 d-inline-block mb-3">
                                            <div class="row m-2">
                                                <div class="col-4">
                                                    <h6 class="card-title">
                                                        <!--- <i class="fa-thin fa-gears red"></i> --->
                                                        <cfoutput>#obj_translater.get_translate('card_settings')#</cfoutput>
                                                    </h6>
                                                    
                                                    <br>
                                                    <!--- Display the form --->
                                                    <div class="d-inline-block p-2">
                                                        <label for="lang_select" class="mr-sm-2">
                                                            <cfoutput>#obj_translater.get_translate('table_th_lrn_language')#</cfoutput>
                                                        </label>
                                                        <select name="lang_select" id="lang_select" class="border-0 mr-sm-2 text-secondary p-2 lang_select">
                                                            <option value="fr" <cfif lang_select eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput>
                                                            </option>
                                                            <option value="en" <cfif lang_select eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput>
                                                            </option>
                                                            <option value="de" <cfif lang_select eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput>
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <div class="d-inline-block p-2">
                                                        <label for="translate" class="mr-sm-2 text-important">
                                                            <cfoutput>#obj_translater.get_translate('table_th_translation')#</cfoutput>
                                                        </label>
                                                        <select name="translate" id="translate" class="border-0 mr-sm-2 text-secondary p-2 translate">
                                                            <option value="" <cfif lang_translate eq "">selected</cfif>>N/A</option>
                                                            
                                                            <cfif lang_select neq "fr">
                                                                <option value="fr" <cfif lang_translate eq "fr">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_fr')#</cfoutput></option>
                                                            </cfif>
                                                            
                                                            <cfif lang_select neq "en">
                                                                <option value="en" <cfif lang_translate eq "en">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_en')#</cfoutput></option>
                                                            </cfif>
                                                            
                                                            <cfif lang_select neq "de">
                                                                <option value="de" <cfif lang_translate eq "de">selected</cfif>><cfoutput>#obj_translater.get_translate('lang_de')#</cfoutput></option>
                                                            </cfif>
                                                        </select>
                                                    </div>
                                                    
                                                </div>
                                                <div class="col-4">
                                                    <h6 class="card-title">
                                                        <!--- <i class="fa-thin fa-photo-film-music red"></i> --->
                                                        <cfoutput>#obj_translater.get_translate('card_thematic_list')#</cfoutput>
                                                    </h6><br>
                                                    <div class="d-inline-block p-2">
                                                        <select name="category" id="category" class="border-0 mr-sm-2 text-secondary p-2 voc_category">
                                                            <!--- Get the list of categories from the database --->
                                                            <cfloop query="get_category">
                                                                <option value="#get_category.voc_cat_id#" <cfif isdefined("cat_id") AND cat_id eq get_category.voc_cat_id>selected</cfif>>#voc_cat_name#</option>
                                                            </cfloop>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <h6 class="card-title">
                                                        <!--- <i class="fa-thin fa-search red"></i> --->
                                                        <cfoutput>#obj_translater.get_translate('search')#</cfoutput>
                                                    </h6><br>
                                                    <div class="d-inline-block p-2">
                                                        <form id="form-global_search" name="global_search">
                                                            <div class="typeahead__container">
                                                                <div class="typeahead__field">
                                                                    <div class="typeahead__query">
                                                                        <input class="js_typeahead_voc" name="vocabulary[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off"> </input>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </cfoutput>

                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">

                                        <cfoutput><a target="_blank" href="./tpl/el_vocablist_container.cfm?voc_cat_id=#cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#&<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-info float-right"><i class="fad fa-file-pdf btn_export_list" id="export_#cat_id#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
                        
                                        <cfswitch expression="#lang_select_code#">
                                            <cfcase value="en">
                                                <cfset lang_select_id=2>
                                            </cfcase>
                                            <cfcase value="fr">
                                                <cfset lang_select_id=1>
                                            </cfcase>
                                            <cfcase value="de">
                                                <cfset lang_select_id=3>
                                            </cfcase>
                                            <cfdefaultcase>
                                                <cfset lang_select_id=2>
                                            </cfdefaultcase>
                                        </cfswitch>

                                        <!--- Query the database to get the vocabulary list based on the selected language and category --->
                                        <div id="alert-container"></div>
                                        
                                        <div class="table-responsive" style="max-height: 500px;">
                                            
                                            <table class="table table-bordered text-center table-pdf" id="table-pdf">
                                                <cfoutput>
                                                <thead>
                                                    <tr class="bg-red text-light text-center sticky-header">

                                                        <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select#")#</th>
                                                        <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select#")#</th>
                                                        
                                                            <th class="p-1">#obj_translater.get_translate(id_translate="table_th_translation",lg_translate="#lang_select#")#</th>
                                                        
                                                        <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select#")#</th>
                                                        <th class="p-1"><i class="fa-light fa-volume"></i></th>
                                                        <th class="p-1">#obj_translater.get_translate(id_translate="tooltip_add_favourite",lg_translate="#lang_select#")#</th>
                                                    </tr>
                                                </thead>
                                                </cfoutput>

                                                <tbody>

                                                    <cfset vocabData = {}>

                                                    <cfoutput query="get_vocabulary">
                                                        <cfif formation_code eq lang_select>
                                                            <cfif NOT structKeyExists(vocabData, voc_group)>
                                                                <cfset vocabData[voc_group] = {}>
                                                            </cfif>
                                                            <cfset vocabData[voc_group]["lang_select"] = {
                                                                "voc_id" = voc_id,
                                                                "voc_word" = voc_word,
                                                                "voc_desc" = voc_desc,
                                                                "voc_type_name"= voc_type_name,
                                                                "voc_group" = voc_group
                                                            }>
                                                        </cfif>
                                                        
                                                        <cfif formation_code eq lang_translate AND lang_translate NEQ "">
                                                            <cfif NOT structKeyExists(vocabData, voc_group)>
                                                                <cfset vocabData[voc_group] = {}>
                                                            </cfif>
                                                            <cfset vocabData[voc_group]["lang_translate"] = {
                                                                "voc_id" = voc_id,
                                                                "voc_word" = voc_word,
                                                                "voc_desc" = voc_desc,
                                                                "voc_group" = voc_group
                                                            }>
                                                        </cfif>
                                                    </cfoutput>

                                                    <cfset targetVocCatId = cat_id> 

                                                    <cfloop item="vocGroup" collection="#vocabData#">
                                                    
                                                    <cfoutput>
                                                        <tr id="voc_row_#vocabData[vocGroup]["lang_select"]["voc_id"]#"<cfif isdefined("url.v_id") AND vocabData[vocGroup]["lang_select"]["voc_id"] eq v_id>class="highlight"</cfif>>
                                                            <td><strong>#vocabData[vocGroup]["lang_select"]["voc_word"]#</strong> </td>
                                                            <td class="p-1">#vocabData[vocGroup]["lang_select"]["voc_type_name"]#</td>
                                                            <cfif isdefined("lang_translate") AND lang_translate neq ""><td id=#vocabData[vocGroup]["lang_translate"]["voc_id"]#>#vocabData[vocGroup]["lang_translate"]["voc_word"]#</td> 
                                                            <cfelse>
                                                                <td><strong>N/A</strong></td> 
                                                            </cfif>
                                                            <td>#vocabData[vocGroup]["lang_select"]["voc_desc"]#</td>
                                                            <td>
                                                                <cfset fileExistsCount=0>
                                                                <!-- Loop over the accents retrieved by the get_accent query -->
                                                                <cfloop query="get_accent">
                                                                    <cfset fileUrl="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#cat_id#/word_#vocabData[vocGroup]["lang_select"]["voc_id"]#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                                                    <cfset fileUrl2="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#cat_id#/word_#vocabData[vocGroup]["lang_select"]["voc_group"]#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                                                    
                                                                    <cfif fileExists(fileUrl)>
                                                                        <cfset fileExistsCount = fileExistsCount + 1>
                                                                        <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_id"]#">
                                                                            <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_id"]#" onclick="play_audio">
                                                                                <source src="#fileUrl#" type="audio/mp3">
                                                                            </audio>
                                                                            <p class="red">#get_accent.formation_accent_name#</p>
                                                                        </a>
                                                                    <cfelseif fileExists(fileUrl2)>
                                                                        <cfset fileExistsCount = fileExistsCount + 1>
                                                                        <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_group"]#">
                                                                            <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#vocabData[vocGroup]["lang_select"]["voc_group"]#" onclick="play_audio">
                                                                                <source src="#fileUrl2#" type="audio/mp3">
                                                                            </audio>
                                                                            <p class="red">#get_accent.formation_accent_name#</p>
                                                                        </a>
                                                                    </cfif>
                                                                </cfloop>
                                                                <cfif fileExistsCount eq 0>
                                                                    Coming soon!
                                                                </cfif>
                                                            </td>
                                                            
                                                            <td class="text-center p-1">
                                                            <cfsilent>
                                                                <cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">
                                                                SELECT * FROM user_vocablist 
                                                                WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> 
                                                                AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#vocabData[vocGroup]["lang_select"]["voc_group"]#>
                                                                </cfquery>
                                                            </cfsilent>
                                                            <cfif check_uvoc.recordcount neq 0>
                                                                <i class="fa-sharp fa-solid fa-heart btn_add_uvoc red cursored" id="#SESSION.USER_ID#_#vocabData[vocGroup]["lang_select"]["voc_group"]#"></i>
                                                                <cfelse>
                                                                <i class="fa fa-heart-o red btn_add_uvoc cursored" id="#SESSION.USER_ID#_#vocabData[vocGroup]["lang_select"]["voc_group"]#"></i>
                                                            </cfif>
                                                        </td>
                                                        <!---  Keep this for maintenance
                                                        Selected Language ID: #vocabData[vocGroup]["lang_select"]["voc_id"]#<br>
                                                        Selected Language group: #vocabData[vocGroup]["lang_select"]["voc_group"]#<br>
                                                        Selected Language desc: #vocabData[vocGroup]["lang_select"]["voc_desc"]#<br>
                                                        Translated Language Word: #vocabData[vocGroup]["lang_translate"]["voc_word"]#<br>
                                                        Translated Language ID: #vocabData[vocGroup]["lang_translate"]["voc_id"]#<br>
                                                        Translated Language desc: #vocabData[vocGroup]["lang_translate"]["voc_desc"]#<br></tr> --->
                                                    </cfoutput>
                                                        
                                                    </cfloop>
                                                </tbody>
                                            </table>

                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

                
        </div>
        
        <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
        
    </div>
    
      
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">

    <cfinclude template="./incl/incl_scripts_param.cfm">

    <cfinclude template="./incl/incl_scripts_vocab.cfm">
        
<script>
$(document).ready(function() {
    $.typeahead({
        input: '.js_typeahead_voc',
        order: "desc",
        minLength: 1,
        maxItem: 15,
        emptyTemplate: 'Pas de resultats pour "{{query}}"',
        dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",
        group: {
            template: "{{group}}"
        },
        source: {

            <cfoutput query = "get_vocabulary_all"
            group = "voc_cat_id" >
            <cfif voc_cat_id neq "35" >
            "#encodeForJavaScript(voc_cat_name)#": {
                display: "voc_word",
                href: "",
                data: [ <cfoutput > {
                    "voc_group": #voc_group#,
                        "voc_id": #voc_id#,
                        "voc_word": "#encodeForJavaScript(trim(voc_word))#",
                        "voc_category": "#encodeForJavaScript(trim(voc_cat_name))#",
                        "voc_cat_id": "#voc_cat_id#"
                    }, </cfoutput>
                ]
            },
            </cfif> </cfoutput>
        },
        callback: {
            onClickAfter: function(node, a, item, event) {
                event.preventDefault; <cfoutput >
                    document.location.href = 'elearning_vocab.cfm?lang_select=#lang_select#&lang_translate=#lang_translate#&cat_id=' + item.voc_cat_id + '&v_id=' + item.voc_id + '##' + item.voc_id; </cfoutput>			
            }
        }
    });
    var urlParams = new URLSearchParams(window.location.search);
    var selectedVocId = urlParams.get('v_id');
    
    if (selectedVocId) {
        var scrollToVocId = 'voc_row_' + selectedVocId;
        var scrollableContainer = $('.table-responsive');
        
        scrollableContainer.scrollTop($('#' + scrollToVocId).offset().top - scrollableContainer.offset().top + scrollableContainer.scrollTop());
    }


});
</script>

</body>
</html>