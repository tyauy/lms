<cfset selectedWords={}>
<cfset selectedDescs={}>

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


<table class="table table-bordered text-center table-pdf">

    <cfoutput>
        <thead>
            <tr class="bg-danger text-light text-center sticky-header">
                <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_word",lg_translate="#lang_select#")#</th>
                <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_nature",lg_translate="#lang_select#")#</th>
                <cfif lang_translate NEQ "">
                    <th class="p-1">#obj_translater.get_translate(id_translate="table_th_translation",lg_translate="#lang_select#")#</th>
                </cfif>
                <th class="p-1">#obj_translater.get_translate(id_translate="table_th_vocab_definition",lg_translate="#lang_select#")#</th>
                <th class="p-1"><i class="fa-light fa-volume"></i></th>
                <th class="p-1">#obj_translater.get_translate(id_translate="tooltip_add_favourite",lg_translate="#lang_select#")#</th>
            </tr>
        </thead>
    </cfoutput>
    <tbody>


    <cfoutput query="get_vocabulary">
        
        <cfif formation_code eq "#lang_select#">
            <cfset selectedWords[voc_group]=voc_word>
            <cfset selectedId[voc_group]=voc_group>
            <cfset selectedDescs[voc_group]=voc_desc>
        </cfif>

        <cfif lang_translate EQ "">
            <tr id="voc_row_#selectedId[voc_group]#">
                <td class="p-1"><strong>#selectedWords[voc_group]#</strong></td>
                <td class="p-1">#voc_type_name#</td>
                <td class="p-1">#selectedDescs[voc_group]#</td>
                <td class="p-1">
                    <cfset comingSoon=false>
                        <!-- Loop over the accents retrieved by the get_accent query -->
                        <cfloop query="get_accent">
                            
                            <cfset fileUrl="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#cat_id#/word_#get_vocabulary.voc_group#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                <cfif fileExists(fileUrl)>
                                    <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#get_vocabulary.voc_group#">
                                        <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#get_vocabulary.voc_group#" onclick="play_audio">
                                            <source src="#fileUrl#" type="audio/mp3">
                                        </audio>
                                        <p class="red">#get_accent.formation_accent_name#</p>
                                    </a>
                                    <cfelse>
                                        <cfset comingSoon=true>
                                </cfif>
                        </cfloop>
                        <cfif comingSoon>
                            More coming soon!
                        </cfif>
                <td class="text-center p-1">
                    <cfif listfind(favorite_list,voc_group)>
                        <i class="fa-sharp fa-solid fa-heart btn_add_uvoc red cursored" id="#SESSION.USER_ID#_#selectedId[voc_group]#"></i>
                    <cfelse>
                        <i class="fa fa-heart-o red btn_add_uvoc cursored" id="#SESSION.USER_ID#_#selectedId[voc_group]#"></i>
                    </cfif>
                </td>
            </tr>
        </cfif>
    </cfoutput>








    <cfoutput query="get_vocabulary">
        <cfif formation_code eq "#lang_translate#">
            
            <tr id="voc_row_#get_vocabulary.voc_group#"<cfif isdefined("v_id") AND get_vocabulary.voc_group eq v_id>class="highlight"</cfif>>
                <td><strong>#selectedWords[voc_group]#</strong></td>
                <td class="p-1">#voc_type_name#</td>
                <td>#voc_word#</td>
                <td>#selectedDescs[voc_group]#</td>
                <td class="p-1">
                    <cfset comingSoon=false>
                        <!-- Loop over the accents retrieved by the get_accent query -->
                        
                        <cfloop query="get_accent">
                            <cfset fileUrl="https://lms.wefitgroup.com/assets/vocab/#lang_select_id#/#get_accent.formation_accent_id#/#cat_id#/word_#get_vocabulary.voc_group#_#lang_select_id#_#get_accent.formation_accent_id#.mp3">
                                <cfif fileExists(fileUrl)>
                                    <a class="btn_player cursored" data-id="btnplay_#lang_select_id#_#get_accent.formation_accent_id#_#get_vocabulary.voc_group#">
                                        <audio id="play_#lang_select_id#_#get_accent.formation_accent_id#_#get_vocabulary.voc_group#" onclick="play_audio">
                                            <source src="#fileUrl#" type="audio/mp3">
                                        </audio>
                                        <p class="red">#get_accent.formation_accent_name#</p>
                                    </a>
                                    <cfelse>
                                        <cfset comingSoon=true>
                                </cfif>
                        </cfloop>
                        <cfif comingSoon>
                            Coming soon!
                        </cfif>
                <td class="text-center p-1">

                <cfif listfind(favorite_list,voc_group)>
                    <i class="fa-sharp fa-solid fa-heart btn_add_uvoc red cursored" id="#SESSION.USER_ID#_#selectedId[voc_group]#"></i>
                <cfelse>
                    <i class="fa fa-heart-o red btn_add_uvoc cursored" id="#SESSION.USER_ID#_#selectedId[voc_group]#"></i>
                </cfif>

                </td>
            </tr>
        </cfif>
    </cfoutput>


    </tbody>
</table>