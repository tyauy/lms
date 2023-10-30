<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>

<cfoutput query="get_session">

    <cfparam name="lang_select" default="#formation_code#">
    <cfparam name="lang_translate" default="#formation_code#">
    <cfparam name="lang_select_id" default="#formation_id#">

    #voc_cat_id#
    #lang_translate#

    <cfif voc_cat_id neq "">

    <cfquery name="get_category" datasource="#SESSION.BDDSOURCE#">
    SELECT voc_cat_id, voc_cat_name_#lang_select# as voc_cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value=#voc_cat_id# list="true">) ORDER BY voc_cat_name
    </cfquery>
                
    <div class="row mt-3">
        <div class="col-md-12">
            <cfoutput>
            <table class="table table-borderless">
                <tr>
                    <td width="140">
                        #obj_translater.get_translate('table_th_translation')# :
                    </td>
                    <td>
                        <cfloop list="en,fr,de" index="cor">
                        <cfif cor neq lang_select>
                        <label><input type="radio" name="lang_translate" class="lang_translate" id="lang_#cor#" value="#cor#" <cfif listfind(lang_translate,"#cor#")>checked</cfif>> <span class="lang-sm lang-lbl" lang="#cor#"></span></label> &nbsp;&nbsp;&nbsp;
                        </cfif>
                        </cfloop>
                    </td>
                </tr>
                <tr>
                    <td>
                        #obj_translater.get_translate('btn_el_vocab_list')# :
                    </td>
                    <td>
                        <ul class="nav nav-pills" role="tablist">
                        <cfset counter = 0>
                        <cfloop query="get_category">
                        <li class="nav-item">
                        <cfset counter++>
                        <a class="nav-link <cfif counter eq "1">active</cfif>" data-toggle="pill" href="##collapse_#voc_cat_id#" role="button" aria-expanded="false" aria-controls="collapse_#voc_cat_id#">#voc_cat_name#</a>
                        </cfloop>
                        </li>
                        </ul>
                    </td>
                </tr>
            </table>
            </cfoutput>
        </div>
    </div>
        
    <div class="row mt-2">
        <div class="col-md-12">
            <div id="accordion_voc">			
            
            <cfset counter = 0>
            <cfloop query="get_category">
            <cfset counter++>
            <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
            
            SELECT v.*,
            vtfr.voc_type_name_fr as voc_type_name_fr,
            vten.voc_type_name_en as voc_type_name_en,
            vtde.voc_type_name_de as voc_type_name_de
            
            FROM lms_vocabulary v
            
            LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
            LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
            LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
            
            WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#"> ORDER BY voc_word_#lang_select#
            </cfquery>
            
            
            <div class="collapse <cfif counter eq "1">show active</cfif>" id="collapse_#voc_cat_id#" data-parent="##accordion_voc">
            <cfoutput><a target="_blank" href="./tpl/vocablist_container.cfm?voc_cat_id=#voc_cat_id#&lang_select=#lang_select#&lang_select_id=#lang_select_id#<cfif isdefined("lang_translate")>&lang_translate=#lang_translate#</cfif>" class="btn btn-sm btn-primary float-right"><i class="fad fa-file-pdf btn_export_list" id="export_#voc_cat_id#"></i> #obj_translater.get_translate('btn_export')#</a></cfoutput>
            
            
            <div class="table-responsive">
            <table class="table">
                <tr class="bg-light">
                    <cfoutput>
                    <th width="2%"></th>
                    <th width="16%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select_id#")#</label></th>
                    <th width="10%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select_id#")#</label></th>
                    <th width="20%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select_id#")#</label></th>
                    
                    
                    
                    <cfloop list="en,fr,de" index="cor">
                    <cfif listfind(lang_translate,cor)>
                    <cfif cor eq "en">
                        <cfset lg_translate = "2">
                    <cfelseif cor eq "fr">
                        <cfset lg_translate = "1">
                    <cfelseif cor eq "de">
                        <cfset lg_translate = "3">
                    </cfif>
                    <th width="2%"></th>
                    <th width="16%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate#")#</label></th>
                    <th width="10%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate#")#</label></th>
                    <!--- <th width="20%"><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th> --->
                    </cfif>
                    </cfloop>
                    </cfoutput>
                    <th width="2%"></th>
                </tr>
                    
            <cfloop query="get_vocabulary">
                <tr>
                
                    <cfif lang_select eq "en">
                        <cfset td_color = "ecd9d9">
                    <cfelseif lang_select eq "fr">
                        <cfset td_color = "c6cbe1">
                    <cfelseif lang_select eq "de">
                        <cfset td_color = "c8d4ca">
                    </cfif>
                    
                    <td bgcolor="###td_color#">
                        <span class="lang-sm" lang="#lang_select#"></span>
                    </td>
                    <td bgcolor="###td_color#">
                        <cfif evaluate('voc_word_#lang_select#') neq ""><strong>#evaluate('voc_word_#lang_select#')#<cfelse><em>Coming soon</em></cfif></strong>
                    </td>
                    <td bgcolor="###td_color#">
                        <cfif evaluate('voc_type_name_#lang_select#') neq "">#evaluate('voc_type_name_#lang_select#')#<cfelse><em>Coming soon</em></cfif>
                    </td>
                    <td bgcolor="###td_color#">
                        <cfif evaluate('voc_desc_#lang_select#') neq "">#evaluate('voc_desc_#lang_select#')#<cfelse><em>Coming soon</em></cfif>
                    </td>
                    
                    
                    <cfloop list="en,fr,de" index="cor">
                    <cfif listfind(lang_translate,cor)>
                    <cfif cor eq "en">
                        <cfset td_color = "ecd9d9">
                    <cfelseif cor eq "fr">
                        <cfset td_color = "c6cbe1">
                    <cfelseif cor eq "de">
                        <cfset td_color = "c8d4ca">
                    </cfif>
                    <td bgcolor="###td_color#">
                        <span class="lang-sm" lang="#cor#"></span>
                    </td>
                    <td bgcolor="###td_color#">
                        <strong>#evaluate('voc_word_#cor#')#</strong>
                    </td>
                    <td bgcolor="###td_color#">
                        #evaluate('voc_type_name_#cor#')#
                    </td>
                    <!--- <td bgcolor="###td_color#"> --->
                        <!--- #evaluate('voc_desc_#cor#')# --->
                    <!--- </td> --->
                    </cfif>
                    </cfloop>
                    
                    <td class="bg-white">
                        <cfsilent>
                            <cfquery name="check_uvoc" datasource="#SESSION.BDDSOURCE#">SELECT * FROM user_vocablist WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#SESSION.USER_ID#> AND voc_id = <cfqueryparam cfsqltype="cf_sql_integer" value=#voc_id#></cfquery>
                        </cfsilent>
                        <cfif check_uvoc.recordcount neq 0>
                            <i class="fas fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
                        <cfelse>
                            <i class="fal fa-heart-square fa-2x btn_add_uvoc cursored" id="#SESSION.USER_ID#_#voc_id#"></i>
                        </cfif>
                    </td>
                    
                    
                </tr>
                </cfloop>
            </table>
            </div>
            </div>
            </cfloop>
            
            </div>
        </div>

        </div>
    </cfif>

</cfoutput>