<cfif isdefined("voc_cat_id")>


<cfsilent>


    <cfparam name="lang_select_id" default="2">
       
    <cfparam name="LG_TRANSLATE_SELECT" default="fr">
     
    <cfparam name="lang_select" default="en">
    <cfparam name="lang_translate" default="fr">

    <cfparam name="voc_group" default="47">


    <cfquery name="get_vocabulary" datasource="#SESSION.BDDSOURCE#">
    SELECT v.*,
    vtfr.voc_type_name_fr as voc_type_name_fr,
    vten.voc_type_name_en as voc_type_name_en,
    vtde.voc_type_name_de as voc_type_name_de,
    vcat.voc_cat_name_#lang_select# as voc_cat
    
    FROM lms_vocabulary v
    
    LEFT JOIN lms_vocabulary_type vtfr ON vtfr.voc_type_id = v.voc_type_fr_id
    LEFT JOIN lms_vocabulary_type vten ON vten.voc_type_id = v.voc_type_en_id
    LEFT JOIN lms_vocabulary_type vtde ON vtde.voc_type_id = v.voc_type_de_id
    
    LEFT JOIN lms_vocabulary_category vcat ON v.voc_cat_id = vcat.voc_cat_id

    
    WHERE 

    v.voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">

    ORDER BY voc_word_#lang_select#
    </cfquery>


</cfsilent>

<style>
    .my-modal {
    max-height: calc(100vh - 100px);
    overflow-y: auto;
}
body.modal-open {
    overflow: hidden;
}

</style>


<div class="table-responsive my-modal">

								
        <table <cfif lang_translate neq "">class="table table-bordered mt-3"<cfelse>class="table table-bordered mt-3"</cfif>>
            <tr class="bg-light">
                <cfoutput>
                
                <th width="2%"></th>
                <th nowrap><label class="order_choice cursored" id="#lang_select#_0">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate_select#")#</label></th>
                <!--- <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate_select#")#</label></th>
                <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate_select#")#</label></th> --->
                
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
                <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lg_translate#")#</label></th>
                <!--- <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lg_translate#")#</label></th> --->
                <!--- <th><label>#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lg_translate#")#</label></th> --->
                <th>Prononciation</th>
                </cfif>
                </cfloop>
                
                </cfoutput>
            </tr>
            
            <cfoutput query="get_vocabulary">
            <tr id="#SESSION.USER_ID#_#voc_id#">
            
                <cfif lang_select eq "en">
                    <cfset td_color = "ecd9d9">
                <cfelseif lang_select eq "fr">
                    <cfset td_color = "c6cbe1">
                <cfelseif lang_select eq "de">
                    <cfset td_color = "c8d4ca">
                </cfif>
                
                <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    <a name="#voc_id#"></a>
                    <span class="lang-sm" lang="#lang_select#"></span>
                </td>
                <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    <strong>#evaluate('voc_word_#lang_select#')#</strong>
                </td>
                <!--- <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    #evaluate('voc_type_name_#lang_select#')#
                </td>
                <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    #evaluate('voc_desc_#lang_select#')#
                </td> --->
                
                
                <cfloop list="en,fr,de" index="cor">
                <cfif listfind(lang_translate,cor)>
                <cfif cor eq "en">
                    <cfset td_color = "ecd9d9">
                <cfelseif cor eq "fr">
                    <cfset td_color = "c6cbe1">
                <cfelseif cor eq "de">
                    <cfset td_color = "c8d4ca">
                </cfif>
                <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    <span class="lang-sm" lang="#cor#"></span>
                </td>
                <td <cfif isdefined("url.v_id") AND get_vocabulary.voc_id eq v_id>class="bg-info"<cfelse>bgcolor="###td_color#"</cfif>>
                    <strong>#evaluate('voc_word_#cor#')#</strong>
                </td>
                <td>
                    <!--- "https://lms.wefitgroup.com/assets/vocab/2/8/#voc_cat_id#/word_#get_vocabulary.voc_id#_2_8.mp3" --->
                    <cfif fileExists("#SESSION.BO_ROOT#/assets/vocab/2/8/#voc_cat_id#/word_#get_vocabulary.voc_id#_2_8.mp3")>
                            <audio  controls  <!---id="play_#lang_select_id#_#get_accent.formation_accent_id#_#get_vocabulary.voc_group#" onclick="play_audio"--->>
                                <source src="https://lms.wefitgroup.com/assets/vocab/2/8/#voc_cat_id#/word_#get_vocabulary.voc_id#_2_8.mp3" type="audio/mp3">
                            </audio>
                    </cfif>

                </td>

                </cfif>
                </cfloop>
                
                
            </tr>
            </cfoutput>
        </table>
    </div>
    


</cfif>
