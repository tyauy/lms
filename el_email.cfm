<cfsilent>

    <cfparam name="f_id" default="2">
    
    <cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as formation_name, formation_code, formation_url FROM lms_formation WHERE formation_id IN (2,3)
    </cfquery>
    
</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>

    </style>
</head>


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

                        <div class="nav nav-tabs d-flex justify-content-between">
                            <div class="nav-link border-0 bg-light">
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-3 img_rounded" src="./assets/img/thumb_long_8.jpg" width="90">
                                    </div>
                                    <div align="left">
                                        <h5 style="font-size:18px" class="mb-0">
                                            <cfoutput>#obj_translater.get_translate('tab_email_template')#</cfoutput>
                                        </h5>
                                    </div>
                                </div>
                            </div>

                            <div align="center">
                                <a href="?f_id=2"><img class="mt-2" src="./assets/img_formation/2<cfif f_id neq "2">_nb</cfif>.png" width="45"></a>
                                <a href="?f_id=3"><img class="mt-2" src="./assets/img_formation/3<cfif f_id neq "3">_nb</cfif>.png" width="45"></a>
                            </div>
                                
                        </div>

                        <!--- <div class="nav nav-tabs d-flex justify-content-between" id="nav-tab" role="tablist" align="center">

                            <div class="nav-link bg-white border-0">
                                <div class="d-flex">
                                    <div>
                                        <img class="mr-2 img_rounded" src="./assets/img/thumb_long_5.jpg" width="90">
                                        <h5 class="mr-2 mt-3 d-inline"><cfoutput>#obj_translater.get_translate('title_page_common_wemail')#</cfoutput></h5>
                                    </div>
                                </div>
                            </div>

                            

                        </div> --->

                        <div class="card" style="margin-top:-1px !important">

                            <div class="card-body">

                                <!--- <div class="w-100 mb-3">
                                    <h5 class="d-inline"><i class="fa-thin fa-envelopes  fa-lg mr-1"></i> <cfoutput>#obj_translater.get_translate('title_page_common_wemail')#</cfoutput></h5>
                                    <hr class="border-red mb-1 mt-2">
                                </div> --->

                                <!--- <cfif isdefined("SESSION.ACCESS_EL")>
                                    <div class="pull-right">			
                                    <select class="form-control" onChange="document.location.href='?f_id='+$(this).val()">
                                    <cfoutput query="get_formation">
                                    <option value="#formation_id#" <cfif f_id eq formation_id>selected</cfif>>#formation_name#</option>
                                    </cfoutput>
                                    <select>
                                    </div>
                                </cfif> --->
                                
                                <cfoutput><p style="font-size:18px">#obj_translater.get_translate_complex('intro_mail_template')#</p></cfoutput>
                                
                                <br>
                            
                                <cfif not isdefined("SESSION.ACCESS_EL")>
                                    <cfinclude template="./incl/incl_noaccess.cfm">
                                <cfelse>
                                        
                                    <cfquery name="get_wemail" datasource="#SESSION.BDDSOURCE#">
                                    SELECT w.wemail_id, w.wemail_category, w.wemail_subcategory, w.wemail_category_clean, w.wemail_subject, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category) as nb, (SELECT count(wemail_id) FROM lms_wemail w2 WHERE w2.wemail_category = w.wemail_category AND wemail_sample_1 IS NOT NULL) as nb_notnull FROM lms_wemail w WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#f_id#"> ORDER BY w.wemail_category, w.wemail_subcategory, w.wemail_subject 
                                    </cfquery>
                                
                                    <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_wemail_search')#</cfoutput></h5>
                                    <hr class="mt-0 border-red">
                                    
                                    <form id="form-global_search" name="global_search" class="mt-2">
                                        <div class="typeahead__container">
                                            <div class="typeahead__field">
                                                <div class="typeahead__query">
                                                    <input class="js_typeahead_wemail" name="wemail[query]" type="search" placeholder="<cfoutput>#obj_translater.get_translate('search')#</cfoutput>" autocomplete="off">
                                                </div>
                                                <div class="typeahead__button">
                                                    <button type="submit">
                                                        <i class="typeahead__search-icon"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    
                                    <br><br>

                                    <h5 class="mb-2 text-dark" style="font-size:22px"><cfoutput>#obj_translater.get_translate('card_wemail_category')#</cfoutput></h5>
                                    <hr class="mt-0 border-red">

                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="tree mt-2" id="tree_wemail1">
                                                <ul style="padding:0px">	
                                                    <cfif f_id eq "2">
                                                        <cfset startrow = "1">
                                                        <cfset maxrows = "16">
                                                    <cfelseif f_id eq "3">
                                                        <cfset startrow = "1">
                                                        <cfset maxrows = "8">
                                                    </cfif>
                                                    <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                        <li>
                                                            <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                            
                                                            <ul>
                                                            <cfif wemail_subcategory neq "">
                                                                <cfoutput group="wemail_subcategory">
                                                                    <li style="display:none"> <span>#wemail_subcategory#</span>
                                                                        <ul>
                                                                            <cfoutput group="wemail_subject">
                                                                                <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                            </cfoutput>
                                                                        </ul>													
                                                                    </li>
                                                                </cfoutput>
                                                            <cfelse>											
                                                                <cfoutput group="wemail_subject">
                                                                    <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                </cfoutput>
                                                            </cfif>
                                                            
                                                            </ul>
                                                        </li>
                                                    </cfoutput>
                                                    
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="tree mt-2" id="tree_wemail2">
                                                <ul style="padding:0px">	
                                                    <cfif f_id eq "2">
                                                        <cfset startrow = "190">
                                                        <cfset maxrows = "16">
                                                    <cfelseif f_id eq "3">
                                                        <cfset startrow = "36">
                                                        <cfset maxrows = "8">
                                                    </cfif>
                                                    <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                        <li>
                                                            <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                            
                                                            <ul>
                                                            <cfif wemail_subcategory neq "">
                                                                <cfoutput group="wemail_subcategory">
                                                                    <li style="display:none"> <span>#wemail_subcategory#</span>
                                                                        <ul>
                                                                            <cfoutput group="wemail_subject">
                                                                                <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                            </cfoutput>
                                                                        </ul>													
                                                                    </li>
                                                                </cfoutput>
                                                            <cfelse>											
                                                                <cfoutput group="wemail_subject">
                                                                    <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                </cfoutput>
                                                            </cfif>
                                                            
                                                            </ul>
                                                        </li>
                                                    </cfoutput>
                                                
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="tree mt-2" id="tree_wemail3">
                                                <ul style="padding:0px">	
                                                    <cfif f_id eq "2">
                                                        <cfset startrow = "380">
                                                        <cfset maxrows = "16">
                                                    <cfelseif f_id eq "3">
                                                        <cfset startrow = "73">
                                                        <cfset maxrows = "8">
                                                    </cfif>
                                                    <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                        <li>
                                                            <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                            
                                                            <ul>
                                                            <cfif wemail_subcategory neq "">
                                                                <cfoutput group="wemail_subcategory">
                                                                    <li style="display:none"> <span>#wemail_subcategory#</span>
                                                                        <ul>
                                                                            <cfoutput group="wemail_subject">
                                                                                <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                            </cfoutput>
                                                                        </ul>													
                                                                    </li>
                                                                </cfoutput>
                                                            <cfelse>											
                                                                <cfoutput group="wemail_subject">
                                                                    <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                </cfoutput>
                                                            </cfif>
                                                            
                                                            </ul>
                                                        </li>
                                                    </cfoutput>
                                                    
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="tree mt-2" id="tree_wemail4">
                                                <ul style="padding:0px">	
                                                    <cfif f_id eq "2">
                                                        <cfset startrow = "897">
                                                        <cfset maxrows = "50">
                                                    <cfelseif f_id eq "3">
                                                        <cfset startrow = "97">
                                                        <cfset maxrows = "8">
                                                    </cfif>
                                                    <cfoutput query="get_wemail" group="wemail_category" startrow="#startrow#" maxrows="#maxrows#">
                                                        <li>
                                                            <span class="btn-xs"><i class="fas fa-plus-circle"></i> <strong>#wemail_category# [#nb#]</strong></span>
                                                            
                                                            <ul>
                                                            <cfif wemail_subcategory neq "">
                                                                <cfoutput group="wemail_subcategory">
                                                                    <li style="display:none"> <span>#wemail_subcategory#</span>
                                                                        <ul>
                                                                            <cfoutput group="wemail_subject">
                                                                                <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                            </cfoutput>
                                                                        </ul>													
                                                                    </li>
                                                                </cfoutput>
                                                            <cfelse>											
                                                                <cfoutput group="wemail_subject">
                                                                    <li style="display:none"> <span class="btn_view_wemail" id="w_#wemail_id#">#wemail_subject#</span></li>
                                                                </cfoutput>
                                                            </cfif>
                                                            
                                                            </ul>
                                                        </li>
                                                    </cfoutput>
                                                    
                                                </ul>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </cfif>

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
        
<script>
$(document).ready(function() {

    $('#tree_wemail1 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');
        
    $('#tree_wemail1 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });
    
    $('#tree_wemail2 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail2 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });

    
    $('#tree_wemail3 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail3 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });

    $('#tree_wemail4 li:has(ul)').addClass('parent_li').find(' > span').attr('title', 'Collapse this branch');

    $('#tree_wemail4 li.parent_li > span').on('click', function (e) {
        var children = $(this).parent('li.parent_li').find(' > ul > li');
        if (children.is(":visible")) {
            children.hide('fast');
            $(this).attr('title', 'Expand').find(' > i').removeClass('fa-minus-circle').addClass('fa-plus-circle');
        } else {
            children.show('fast');
            $(this).attr('title', 'Collapse').find(' > i').removeClass('fa-plus-circle').addClass('fa-minus-circle');
        }
        e.stopPropagation();
    });


    $('.btn_view_wemail').click(function(event) {
        event.preventDefault();		
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var idt = idtemp[1];	
        $('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("Wemail");
        $('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+idt, function() {});
    });














    
    $.typeahead({
        input: '.js_typeahead_wemail',
        order: "desc",
        minLength: 1,
        maxItem: 15,
        emptyTemplate: 'Pas de resultats pour "{{query}}"',
        /*matcher: function(item) {
            return true
        }*/
        
        dropdownFilter: "<cfoutput>#obj_translater.get_translate('all')#</cfoutput>",	
        
        group: {
            template: "{{group}}"
        },
        
        source: {
            
            <cfoutput query="get_wemail" group="wemail_category">
            #replacenocase(wemail_category_clean,' ','','ALL')# : {
            
                display:"wemail_subject",
                href:"",
                data:[
                    <cfoutput group="wemail_subject">
                    {
                    "wemail_id": #wemail_id#,
                    "wemail_subject": "#wemail_subject#"
                    },
                    </cfoutput>
                ]
            
            },
            </cfoutput>
        },
        callback: {
        
            onClickAfter: function (node, a, item, event) {
        
                event.preventDefault;
                
                $('#window_item_lg').modal({keyboard: true});
                $('#modal_title_lg').text("Email Template");
                $('#modal_body_lg').load("modal_window_wemail.cfm?w_id="+item.wemail_id, function() {});
            
        
            }			
        }
    });

});

</script>

</body>
</html>