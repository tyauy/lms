
<cfinclude template="../incl/incl_scripts_vocab.cfm">

<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>

<cfinvoke component="api/tracking/tracking_get" method="oget_vocab_tracking" returnvariable="get_vocab_tracking">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfparam name="vcid" default="#get_vocab_tracking.voc_cat_id#">

<ul class="nav nav-tabs" role="tablist">
    <cfoutput query="get_vocab_tracking">
        <li class="nav-item" role="presentation">
            <button class="nav-link <cfif vcid eq voc_cat_id>active</cfif>" id="vocab_tab_#voc_cat_id#" data-toggle="tab" data-target="##vocab_#voc_cat_id#" type="button" role="tab" aria-controls="vocab_#voc_cat_id#" <cfif vcid eq voc_cat_id>aria-selected="true"<cfelse>aria-selected="false"</cfif>>
                <i class="fa-light fa-memo-circle-info"></i><br>
                #voc_cat_name#
            </button>
        </li>

    </cfoutput>
    
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="vocab_tab_favorite" data-toggle="tab" data-target="#vocab_favorite" type="button" role="tab" aria-controls="vocab_favorite" aria-selected="false">
            <i class="fa-light fa-heart"></i><br>
            My favourites
        </button>
    </li>
</ul>

<div class="tab-content">
    <cfoutput query="get_vocab_tracking">
    <div class="tab-pane <cfif vcid eq voc_cat_id>show active</cfif> pt-3" id="vocab_#voc_cat_id#" role="tabpanel" aria-labelledby="vocab_tab_#voc_cat_id#">
        <!--- #voc_cat_name# // #voc_cat_id#!!! --->

        <cfset lang_select = get_session.formation_code>
        <cfset lang_translate = "fr">
        <cfset lang_select_code = get_session.formation_code>
        <cfset cat_id = voc_cat_id>
    
        <!--- lang_select = #get_session.formation_code#<br>
        voc_cat_id = #voc_cat_id#<br>
        lang_translate = #get_session.formation_code#<br>
        lang_select_code = #get_session.formation_code#<br> --->

        <cfinclude template="./wid_vocab_list.cfm">
    </div>
    </cfoutput>



    <div class="tab-pane pt-3" id="vocab_favorite" role="tabpanel" aria-labelledby="vocab_tab_favorite">
        <cfset show_favorite = "1">
        <!--- <cfinclude template="./wid_vocab_list.cfm"> --->
    </div>
</div>



