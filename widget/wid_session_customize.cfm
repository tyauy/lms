<cfparam name="view" default="custom_main">

<cfset get_session = obj_tp_get.oget_session(t_id="#t_id#", s_id="#s_id#", l_by="yes", g_by="s_id")>
<cfset new_grammar_point = 1>
<!--- <cfinclude template="../modal_window_session_edit.cfm"> --->

<cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
SELECT skill_id, skill_objectives_#SESSION.LANG_CODE# as skill_objectives FROM lms_skill WHERE skill_major = 1
</cfquery>

<cfquery name="get_keyword_cat" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 3 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_keyword_function" datasource="#SESSION.BDDSOURCE#">
    SELECT keyword_cat_id, keyword_cat_name_#SESSION.LANG_CODE# as keyword_cat_name FROM lms_keyword_category WHERE keyword_cat_id = 4 ORDER BY keyword_cat_id ASC
</cfquery>

<cfquery name="get_vocab_list" datasource="#SESSION.BDDSOURCE#">
SELECT voc_cat_id, voc_cat_name_#SESSION.LANG_CODE# as cat_name FROM lms_vocabulary_category WHERE voc_cat_online = 1
AND voc_cat_id NOT IN (SELECT voc_cat_id FROM tracking_vocab WHERE session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">)
<cfif get_session.voc_cat_id neq "">
    AND voc_cat_id NOT IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.voc_cat_id#" list="true">)
</cfif>
</cfquery>

<cfif get_session.voc_cat_id neq "">
<cfquery name="get_default_vocab_list" datasource="#SESSION.BDDSOURCE#">
    SELECT voc_cat_id, voc_cat_name_#SESSION.LANG_CODE# as cat_name FROM lms_vocabulary_category WHERE voc_cat_id IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#get_session.voc_cat_id#" list="true">)
</cfquery>
</cfif>

<cfquery name="get_lesson_vocab_list" datasource="#SESSION.BDDSOURCE#">
    SELECT lvc.voc_cat_id, lvc.voc_cat_name_#SESSION.LANG_CODE# as cat_name 
    FROM tracking_vocab tv
    INNER JOIN lms_vocabulary_category lvc ON lvc.voc_cat_id = tv.voc_cat_id
    WHERE tv.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
</cfquery>

<!--- <cfquery name="get_elearning_session" datasource="#SESSION.BDDSOURCE#">
    SELECT elearning_session_id, elearning_session_name FROM lms_elearning_session
</cfquery>	 --->
<cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
    SELECT em.elearning_module_id, em.elearning_module_path, tsm.sessionmaster_id, tsm.sessionmaster_name, l.level_id, l.level_alias
    FROM lms_elearning_module em
    INNER JOIN lms_elearning_module_cor emc ON emc.elearning_module_id = em.elearning_module_id
    INNER JOIN lms_elearning_module_group emg ON emg.elearning_module_group_id = emc.elearning_module_group_id
    LEFT JOIN lms_tpsessionmaster2 tsm ON tsm.sessionmaster_id = em.sessionmaster_id
    LEFT JOIN lms_level l ON l.level_id = emg.level_id
</cfquery>	


<cfif get_session.skill_id eq "">
    <cfset sk_id = 0>
<cfelse>
    <cfset sk_id = get_session.skill_id>
</cfif>


<cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_general" returnvariable="get_keyword_tracking_general">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_keyword_tracking_business" returnvariable="get_keyword_tracking_business">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_vocab_tracking" returnvariable="get_vocab_tracking">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfinvoke component="api/tracking/tracking_get" method="oget_mapping_tracking" returnvariable="get_mapping_tracking">
    <cfinvokeargument name="s_id" value="#s_id#">
</cfinvoke>

<cfquery name="get_elearning_session_user" datasource="#SESSION.BDDSOURCE#">
    SELECT em.elearning_module_id, tsm.sessionmaster_name
    FROM lms_elearning_module em
    INNER JOIN lms_elearning_session_user esu ON esu.elearning_module_id = em.elearning_module_id
    LEFT JOIN lms_tpsessionmaster2 tsm ON tsm.sessionmaster_id = em.sessionmaster_id
    WHERE esu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
    AND esu.session_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#s_id#">
    AND esu.active = 1
</cfquery>	


<cfset k_id = "">
<cfoutput query="get_keyword_tracking_general">
    <cfset k_id = listappend(k_id,keyword_id)>
</cfoutput>
<cfoutput query="get_keyword_tracking_business">
    <cfset k_id = listappend(k_id,keyword_id)>
</cfoutput>

<cfset m_id = "">
<cfoutput query="get_mapping_tracking">
    <cfset m_id = listappend(m_id,mapping_id)>
</cfoutput>



<ul class="nav nav-tabs" role="tablist">
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_main">active</cfif>" id="main_tab" data-toggle="tab" data-target="#custom_main" type="button" role="tab" aria-controls="custom_main" <cfif view eq "custom_main">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-memo-circle-info"></i><br>
            General
        </button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_language">active</cfif>" id="language_tab" data-toggle="tab" data-target="#custom_language" type="button" role="tab" aria-controls="custom_language" <cfif view eq "custom_language">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-clapperboard-play"></i><br>
            Language Points</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_general">active</cfif>" id="general_tab" data-toggle="tab" data-target="#custom_general" type="button" role="tab" aria-controls="custom_general" <cfif view eq "custom_general">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-calendar-alt"></i><br>
            General English</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_business">active</cfif>" id="business_tab" data-toggle="tab" data-target="#custom_business" type="button" role="tab" aria-controls="custom_business" <cfif view eq "custom_business">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-calendar-alt"></i><br>
            Business English</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_vocab">active</cfif>" id="business_tab" data-toggle="tab" data-target="#custom_vocab" type="button" role="tab" aria-controls="custom_vocab" <cfif view eq "custom_vocab">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-calendar-alt"></i><br>
            Vocab list</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link <cfif view eq "custom_elearning">active</cfif>" id="quiz_tab" data-toggle="tab" data-target="#custom_elearning" type="button" role="tab" aria-controls="custom_elearning" <cfif view eq "custom_elearning">aria-selected="true"<cfelse>aria-selected="false"</cfif>>
            <i class="fa-light fa-calendar-alt"></i><br>
            E-learning</button>
    </li>
</ul>

<!--- MAIN --->
<div class="tab-content">
    <div class="alert alert-success collapse" id="message_ok">
        Changement sauvegarder !
    </div>
    <div class="alert alert-error collapse" id="message_error">
        Oups, il semblerait que n'ayons pas pu prendre en compte vos changements
    </div>



    <div class="tab-pane <cfif view eq "custom_main">show active</cfif> pt-3" id="custom_main" role="tabpanel" aria-labelledby="main_tab">

        <table class="table m-0">
            <tr>
                <td class="bg-light" width="15%">
                    <cfoutput>Rename lesson<span style="color:##FF0000">*</span></cfoutput>
                </td>
                <td>
                    <cfoutput>
                    <input type="text" name="session_name" class="form-control" value="#get_session.session_name#">
                    </cfoutput>
                </td>
            </tr>
            <tr>
                <td class="bg-light" width="15%"><cfoutput>#obj_translater.get_translate('table_th_mini_needs')# <span style="color:##FF0000">*</span></cfoutput></td>
                <td valign="top">
                    <div class="row">
        
                        <div class="col-md-6">
                        <cfoutput query="get_skill" startrow="1" maxrows="#ceiling(get_skill.recordcount/2)#">
                        <label><input type="checkbox" name="skill_id" id="user_needs_learn" value="#skill_id#" <cfif listfind(sk_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>							
                        </cfoutput>
                        </div>
                        
                        <div class="col-md-6">
                        <cfoutput query="get_skill" startrow="#ceiling(get_skill.recordcount/2)+1#" maxrows="#get_skill.recordcount#">
                        <label><input type="checkbox" name="skill_id" id="user_needs_learn" value="#skill_id#" <cfif listfind(sk_id,skill_id)>checked</cfif>> #skill_objectives#</label><br>				
                        </cfoutput>
                        </div>
                        
                    </div>
                    
                </td>
            </tr>
            <tr>
                <td class="bg-light" width="15%">
                    
                    PIÈCE JOINTE<br><small>pdf / doc / docx / ppt / jpg / jpeg / png</small><br><small>3 max</small>
                </td>
                <td valign="top">
                    <div class="row">
        
                        <div class="col-md-6">
                            <table class="table table-sm table-bordered" id="file_holder">
        
                                
                                    
                                
                                    <tbody><tr id="file_none">
                                        <td colspan="2" align="center"><em>Aucun fichier</em></td>
                                    </tr>
                                
                        
                            </tbody></table>
                        </div>
                        
                        <div class="col-md-6">
        
                            <form method="post" id="form_doc" name="form_doc" onsubmit="return submit_form_doc();">
        
                            <table class="table table-sm table-bordered">
            
                                <tbody><tr>
                                    <td>
        
                                        <input type="file" id="doc_attach" class="form-control" name="doc_attach" accept=".pdf,.jpg,.jpeg,.png,.docx,.txt,.doc,.pptx">
        
                                    </td>
                                    <td>
                                        
                                        <input type="hidden" name="dir_go" value="<cfoutput>#SESSION.BO_ROOT#/assets/lessons/#t_id#/#s_id#</cfoutput>">
                                        <input type="submit" class="btn btn-info btn-sm" id="doc_upload_submit" value="upload">
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div class="progress">
                                            <div class="progress-bar progress-bar-animated bg-info" role="progressbar" id="progress_doc" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody></table>
        
                            </form>
        
                        </div>
                        
                    </div>
                    
                </td>
            </tr>
            <tr>
                <td align="center">
                    <button type="button" class="btn btn-sm btn-outline-info btn-success save_general"><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
                </td>
            </tr>
        </table>
    </div>


    <!--- MAPPING --->
    <div class="tab-pane <cfif view eq "custom_language">show active</cfif> pt-3" id="custom_language" role="tabpanel" aria-labelledby="language_tab">

        <cfinclude template="./wid_mapping.cfm">

        <div class="col-md-12"  align="center">
            <button type="button" class="btn btn-sm btn-outline-info btn-success save_mapping"><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
        </div>
    </div>

    <!--- KEYWORD --->
    <div class="tab-pane <cfif view eq "custom_general">show active</cfif> pt-3" id="custom_general" role="tabpanel" aria-labelledby="general_tab">
        <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
            SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_cat.keyword_cat_id#"> ORDER BY keyword_name
        </cfquery>
        
        <cfif get_keyword.recordcount gt 3>
        <div class="row">
            <div class="col-md-4">
            
            <cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>							
            </cfoutput>
            </div>
            
            <div class="col-md-4">
            <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
            </cfoutput>
            </div>
            
            <div class="col-md-4">
            <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
            </cfoutput>
            </div>
            
            <div class="col-md-12" align="center">
                <button type="button" class="btn btn-sm btn-outline-info btn-success save_keyword"><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
            </div>
        </div>
        </cfif>
    </div>

    <div class="tab-pane <cfif view eq "custom_business">show active</cfif> pt-3" id="custom_business" role="tabpanel" aria-labelledby="business_tab">
        <cfquery name="get_keyword" datasource="#SESSION.BDDSOURCE#">
            SELECT k.keyword_id, k.keyword_name_#SESSION.LANG_CODE# as keyword_name FROM lms_keyword2 k WHERE keyword_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_keyword_function.keyword_cat_id#"> AND is_active = 1 ORDER BY keyword_name
        </cfquery>
        
        <cfif get_keyword.recordcount gt 3>
        <div class="row">
            <div class="col-md-4">
            
            <cfoutput query="get_keyword" startrow="1" maxrows="#ceiling(get_keyword.recordcount/3)#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>							
            </cfoutput>
            </div>
            
            <div class="col-md-4">
            <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)+1#" maxrows="#ceiling(get_keyword.recordcount/3)#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
            </cfoutput>
            </div>
            
            <div class="col-md-4">
            <cfoutput query="get_keyword" startrow="#ceiling(get_keyword.recordcount/3)*2+1#" maxrows="#get_keyword.recordcount#">
            <label><input type="checkbox" name="keyword_id" data-kid='#keyword_id#' class="keyword_id" value="#keyword_id#" <cfif listfind(k_id,keyword_id)>checked</cfif>> #keyword_name#</label><br>				
            </cfoutput>
            </div>
            
            <div class="col-md-12" align="center">
                <button type="button" class="btn btn-sm btn-outline-info btn-success save_keyword"><cfoutput>#obj_translater.get_translate('btn_validate')#</cfoutput></button>
            </div>
        </div>
        </cfif>
    </div>

    <!--- VOCAB --->
    <div class="tab-pane <cfif view eq "custom_vocab">show active</cfif> pt-3" id="custom_vocab" role="tabpanel" aria-labelledby="business_tab">

        <table class="table table-sm table-bordered">
            <!--- <tr>
                <td colspan="4" bgcolor="#ECECEC"><strong>Listes</strong></td>
            </tr> --->
            <tr>
                <td colspan="3">
                <select id="new_vocab_list_id" class="form-control">
                <option value="0" selected>--Selectionner--</option>
                <cfoutput query="get_vocab_list">
                <option value="#voc_cat_id#">#cat_name#</option>
                </cfoutput>
                </select>
                </td>
                <td>
                    <button type="button" class="btn btn-sm btn-outline-info btn_add_vocab_list">add</button>
                </td>
            </tr>
            <cfif get_session.voc_cat_id neq "">
            <cfloop query="get_default_vocab_list">
                <tr>
                    <td class="bg-light"><label><cfoutput>#currentrow#</cfoutput></label></td>
                    <td colspan="2">
                    <p><cfoutput>#cat_name#</cfoutput></p>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-outline-info" disabled><i class="fal fa-trash-alt"></i></button>
                        <!--- <button>remove</button> --->
                    </td>
                </tr>
            </cfloop>
            </cfif>
            <cfloop query="get_vocab_tracking">
                <tr>
                    <td class="bg-light"><label><cfoutput>#currentrow#</cfoutput></label></td>
                    <td colspan="2">
                    <p><cfoutput>#voc_cat_name#</cfoutput></p>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-outline-info btn_remove_vl" id="del_vl_<cfoutput>#voc_cat_id#</cfoutput>"><i class="fal fa-trash-alt"></i></button>
                        <!--- <button>remove</button> --->
                    </td>
                </tr>
            </cfloop>
        </table>
    </div>

    <!--- QUIZ --->
    <div class="tab-pane <cfif view eq "custom_elearning">show active</cfif> pt-3" id="custom_elearning" role="tabpanel" aria-labelledby="business_tab">

        <table class="table table-sm table-bordered">
            <!--- <tr>
                <td colspan="4" bgcolor="#ECECEC"><strong>Listes</strong></td>
            </tr> --->
            <tr>
                <td colspan="3">
                <select id="new_elearning_session_id" class="form-control">
                <option value="0" selected>--Selectionner--</option>
                <cfoutput query="get_modules">
                <option value="#elearning_module_id#">#elearning_module_id# - #level_alias# - #sessionmaster_name#</option>
                </cfoutput>
                </select>
                </td>
                <td>
                    <button type="button" class="btn btn-sm btn-outline-info btn_add_elearning_session">add</button>
                </td>
            </tr>
            <cfloop query="get_elearning_session_user">
                <tr>
                    <td class="bg-light"><label><cfoutput>#currentrow#</cfoutput></label></td>
                    <td colspan="2">
                    <p><cfoutput>#sessionmaster_name#</cfoutput></p>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-outline-info del_elearning_session" id="del_vl_<cfoutput>#elearning_module_id#</cfoutput>"><i class="fal fa-trash-alt"></i></button>
                        <!--- <button>remove</button> --->
                    </td>
                </tr>
            </cfloop>
        </table>
    </div>

</div>

<script>
    $(document).ready(function () {
        var _setting = {<cfoutput>
            t_id:'#t_id#',
            s_id:'#s_id#',
            u_id:'#u_id#',
            tab:'#tab#'
        </cfoutput>}

        function submit_form_doc() {
		event.preventDefault();
		
		var fd = new FormData(document.getElementById("form_doc"));

		$.ajax({
			url        : './api/users/user_trainer_post.cfc?method=upload_doc',
			type       : 'POST',
			data       : fd,
			enctype	   : 'multipart/form-data',
			contentType: false,
			cache      : false,
			processData: false,
			xhr        : function ()
			{
				var jqXHR = null;
				if ( window.ActiveXObject )
				{
					jqXHR = new window.ActiveXObject("Microsoft.XMLHTTP");
				}
				else
				{
					jqXHR = new window.XMLHttpRequest();
				}

				//Upload progress
				jqXHR.upload.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with upload progress
						console.log( 'Uploaded percent', percentComplete );
						
						$("#progress_doc").css("width",percentComplete+"%");
					}
				}, false );

				//Download progress
				jqXHR.addEventListener("progress",function(evt)
				{
					if ( evt.lengthComputable )
					{
						var percentComplete = Math.round( (evt.loaded * 100) / evt.total );
						//Do something with download progress
						$("#progress_doc").css("width","100%");
						console.log( 'Downloaded percent', percentComplete );
					}
				}, false );

				return jqXHR;
			},
			success    : function ( data )
			{

				var doc_length = $('#file_holder tr').length;
				const obj = JSON.parse(data);
				// console.log("yeah", data)
				console.log(doc_length)
				console.log(obj)

				setTimeout(function (){

					if (!obj.FILEWASOVERWRITTEN) {
						$("#file_none").empty();
						var new_doc = '<tr id="file_'+ (doc_length + 1) + '"><td colspan="2">';
						new_doc += '<a href="./assets/lessons/<cfoutput>#t_id#/#s_id#</cfoutput>/'+ obj.CLIENTFILE + '" target="_blank">'+ obj.CLIENTFILE + '</a>';
						<!--- <a href="##" onclick="if(confirm('Supprimer le fichier ?')){document.location.href='updater_upload_admin.cfm?doc_delete=#name#&n_doc=#n_doc#&a_id=#a_id#&o_id=#o_id#<cfif isDefined("u_id")>&u_id=#u_id#</cfif><cfif isDefined("ucb")>&ucb=#ucb#</cfif>&from=#from#'}" class="btn pull-right btn-sm btn-danger"><i class="fas fa-times"></i></a> --->
						new_doc += '<a type="button" class="btn pull-right btn-sm btn-danger remove_doc" name="'+ obj.CLIENTFILE + '" id="delete_doc_'+ (doc_length + 1) + '">';
						new_doc += '<i class="fal fa-trash-alt"></i></i></a></td></tr>;';
						$("#file_holder").append(new_doc);

						$(".remove_doc").bind("click",handler_remove);
					}

					if ((doc_length + 1) > 3)  {
						$("#doc_upload_submit").prop("disabled",true);
						$("#doc_attach").prop("disabled",true);
					}
					

					$("#progress_doc").css("width","0%");	
				}, 1000);

			}
		});
			
					
	};


    handler_del_vl = function del_vl(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		v_id = idtemp[2];

		console.log(v_id)
		
		$.ajax({
			url : 'api/tracking/tracking_post.cfc?method=insert_tracking_vocab',
			type : 'POST',
			data : {
				session_id:<cfoutput>#s_id#</cfoutput>, 
                trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
                tracking_status_id: 1,
				vocab_id:v_id
			},				
			success : function(result, status) {
				$('#container_session').empty();
                _setting.view = "custom_vocab";
                $('#container_session').load("./widget/wid_session_customize.cfm",_setting, function() {});
			}
		});
	
	};
	$(".btn_remove_vl").bind("click",handler_del_vl);



    handler_add_vocab_list = function add_vocab_list(){
		event.preventDefault();

		var v_id = $('#new_vocab_list_id').val();
		console.log(v_id)
		
		$.ajax({
			url : 'api/tracking/tracking_post.cfc?method=insert_tracking_vocab',
			type : 'POST',
			data : {
				session_id:<cfoutput>#s_id#</cfoutput>, 
                trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
                tracking_status_id: 1,
				vocab_id:v_id
			},				
			success : function(result, status) {
				$('#container_session').empty();
                _setting.view = "custom_vocab";
                $('#container_session').load("./widget/wid_session_customize.cfm",_setting, function() {});
			}
		});
	
	};
	$(".btn_add_vocab_list").bind("click",handler_add_vocab_list);


    handler_del_elearning_session = function del_elearning_session(){
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		es_id = idtemp[2];

		console.log(es_id)
		
		$.ajax({
			url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
			type : 'POST',
			data : {
				session_id:<cfoutput>#s_id#</cfoutput>, 
                user_id:'<cfoutput>#u_id#</cfoutput>',
				elearning_module_id:es_id
			},				
			success : function(result, status) {
				$('#container_session').empty();
                _setting.view = "custom_elearning";
                $('#container_session').load("./widget/wid_session_customize.cfm",_setting, function() {});
			}
		});
	
	};
	$(".del_elearning_session").bind("click",handler_del_elearning_session);
    
    handler_add_elearning_session = function add_elearning_session(){
		event.preventDefault();

		var es_id = $('#new_elearning_session_id').val();
		console.log(es_id)
		
		$.ajax({
			url : 'api/elearning/elearning_post.cfc?method=elearning_add_module_user',
			type : 'POST',
			data : {
				session_id:<cfoutput>#s_id#</cfoutput>, 
                user_id:'<cfoutput>#u_id#</cfoutput>',
				elearning_module_id:es_id
			},				
			success : function(result, status) {
				$('#container_session').empty();
                _setting.view = "custom_elearning";
                $('#container_session').load("./widget/wid_session_customize.cfm",_setting, function() {});
			}
		});
	
	};
	$(".btn_add_elearning_session").bind("click",handler_add_elearning_session);
    

    $( ".save_keyword" ).click(function(event) {
        var klist = [];
		$.each($("input[class='keyword_id']:checked"), function(){
			klist.push($(this)[0].dataset.kid);
		});

        $.ajax({
            url : 'api/tracking/tracking_post.cfc?method=insert_tracking_keyword',
            type : 'POST',
            data : {
                session_id:<cfoutput>#s_id#</cfoutput>, 
                trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
                tracking_status_id: 1,
                keyword_id: JSON.stringify(klist)
            },				
            success : function(result, status) {
                show_message(result);
            }
        });
    });

    $( ".save_mapping" ).click(function(event) {
        console.log($(".mapping_id").serialize());

        var mlist = [];
		$.each($("input[class='mapping_id']:checked"), function(){
			mlist.push($(this)[0].dataset.mid);
		});

        console.log(mlist)

        $.ajax({
            url : 'api/tracking/tracking_post.cfc?method=insert_tracking_mapping',
            type : 'POST',
            data : {
                session_id:<cfoutput>#s_id#</cfoutput>, 
                trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
                tracking_status_id: 1,
                mapping_id: JSON.stringify(mlist)
            },				
            success : function(result, status) {
                console.log(result)
                show_message(result);
            }
        });
    });


    function show_message(rnum) {
        console.log(rnum);
        if (rnum == 1) {
            $("#message_ok").collapse('show');
            setTimeout(() => {
                $("#message_ok").collapse('hide');
            }, 5000);
        } else {
            $("#message_error").collapse('show');
            setTimeout(() => {
                $("#message_error").collapse('hide');
            }, 5000);
        }
    }

    // $( ".save_general" ).click(function(event) {
    //     console.log($(".keyword_id").serialize());
    //     console.log($(".keyword_id"));

    //     var klist = [];
	// 	$.each($("input[class='keyword_id']:checked"), function(){
	// 		klist.push($(this)[0].dataset.kid);
	// 	});

    //     console.log(klist)
    //     console.log(JSON.stringify(klist))
    //     $.ajax({
    //         url : 'api/tracking/tracking_post.cfc?method=insert_tracking_keyword',
    //         type : 'POST',
    //         data : {
    //             session_id:<cfoutput>#s_id#</cfoutput>, 
    //             trainer_id:'<cfoutput>#get_session.planner_id#</cfoutput>',
    //             tracking_status_id: 1,
    //             keyword_id: JSON.stringify(klist)
    //         },				
    //         success : function(result, status) {
    //             console.log("yes")
    //         }
    //     });
    // });

    })
</script>