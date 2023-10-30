<cfsilent>

    <cfparam name="t_id">
    <cfparam name="l_id" default="0">

    <cfif l_id eq "">
        <cfset l_id = 0>
    </cfif>

    <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")>

    <cfset a_id = get_tp.account_id neq "" ? get_tp.account_id : 0>
    
    <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact,
        a.account_name, u.account_id,
        <cfif l_id neq 0>
            la.subscribed, la.lesson_signed, la.lesson_signed_trainer,
        </cfif>
        tpu.is_group_leader,
        t.method_id
        FROM lms_tp t 
        INNER JOIN lms_tpuser tpu ON t.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
        INNER JOIN user u ON u.user_id = tpu.user_id
        INNER JOIN account a ON a.account_id = u.account_id
        <cfif l_id neq 0>
            LEFT JOIN lms_lesson2_attendance la ON la.user_id = u.user_id AND la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
        </cfif>
        WHERE tpu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
    </cfquery>

    <cfset list_user = "">
    <cfoutput query="get_user">
        <cfset list_user = listappend(list_user,user_id)>
    </cfoutput>

    <cfquery name="get_all_account" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 0, 0, 0, 0 )#">
        SELECT account_name, account_id FROM account a ORDER BY account_name ASC
    </cfquery>
    
    <!--- <cfset get_learner_account = obj_query.oget_learner(pf_id="3,4,7,9,5,12",ust_id="1,2,3,4,6",list_account="#get_user.account_id#",o_by="profile_id")> --->

        <cfif get_tp.tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = get_tp.tp_scheduled></cfif>
        <cfif get_tp.tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = get_tp.tp_inprogress></cfif>
        <cfif get_tp.tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = get_tp.tp_cancelled></cfif>
        <cfif get_tp.tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = get_tp.tp_missed></cfif>
        <cfif get_tp.tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = get_tp.tp_completed></cfif>
        
        <cfif get_tp.tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = get_tp.tp_duration></cfif>
        <cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
        
        <cfset tp_done_go = tp_completed_go+tp_inprogress_go>

        <cfif get_tp.tp_skill_id neq "">
        <cfquery name="get_skill" datasource="#SESSION.BDDSOURCE#">
        SELECT skill_id, skill_name_#SESSION.LANG_CODE# as skill_name, skill_icon FROM lms_skill WHERE skill_id IN (#get_tp.tp_skill_id#)
        </cfquery>
    </cfif>
        

    <cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>

</cfsilent>

<!--- <style>
    .user_attended{
        background:green;
    }
</style> --->
    
<cfoutput>
<div class="card-deck">
                                        
    <div class="card border mb-3">
        <div class="card-body">
            <h6>#obj_translater.get_translate('table_th_training')#</h6>
            
            <table class="table table-borderless bg-white m-0">
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('table_th_tp')#</td>
                    <td>
                        <h6 class="m-0"><img src="./assets/img/training_#lcase(get_tp.formation_code)#.png" width="30"> #get_tp.tp_type_name# #get_tp..tp_duration/60# H</h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('table_th_rythm')#</td>
                    <td>
                        <cfif get_tp.tp_formula_id neq "">
                            <cfif get_tp.tp_formula_id gt 1>
                                #get_tp.tp_formula_name# #get_tp.tp_formula_nbcourse# #obj_translater.get_translate('lessons')# / #obj_translater.get_translate('week')#
                            <cfelse>
                                #get_tp.tp_formula_name# #get_tp.tp_formula_nbcourse# #obj_translater.get_translate('lesson')# / #obj_translater.get_translate('week')#
                            </cfif>
                        
                        <cfelse>
                        -
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('table_th_type')#</td>
                    <td>
                        <cfif get_tp.tp_orientation_id neq "">
                        #get_tp.tp_orientation_name#
                        <cfelse>
                        -
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <!--- <td class="bg-light">#obj_translater.get_translate('table_th_skills')#</td> --->
                    <td class="bg-light">Skills</td>
                    <td>
                        <cfif get_tp.tp_skill_id neq "">
                        <cfloop query="get_skill">
                        #get_skill.skill_name#
                        </cfloop>
                        <cfelse>
                        -
                        </cfif>
                    </td>
                </tr>
                <tr>
                    <!--- <td class="bg-light">#obj_translater.get_translate('table_th_themes')#</td> --->
                    <td class="bg-light">Themes</td>
                    <td>
                        <cfif get_tp.tp_interest_id neq "" OR get_tp.tp_function_id neq "">
                            <span class="badge badge-pill bg-light border font-weight-normal p-2 cursored btn_read_keyword" id="tpkeyword_#t_id#"><strong>Themes</strong><br>
                                <cfif  get_tp.tp_interest_id neq "" OR  get_tp.tp_function_id neq "">
                                    <i class="fas fa-star text-warning"></i>
                                <cfelse>-</cfif>
                                </span>
                        <cfelse>-</cfif>
                    </td>
                </tr>
            </table>
        </div>
    </div>
        
        
        <!--- <div class="w-100 d-none d-sm-block d-md-block d-lg-block d-xl-none"></div> --->
            
            
        
    <div class="card border mb-3">
        <div class="card-body">
            <h6>#obj_translater.get_translate('table_th_trainers')#</h6>
            <div class="d-flex justify-content-center mt-3">

                <cfloop query="tp_trainer">
                    <a href="##" id="trainer_#planner_id#" class="btn_view_trainer">
                        <h6 class="m-2" align="center">
                        #obj_lms.get_thumb(user_id="#planner_id#",size="70",responsive="yes")#
                        <br>
                        #planner#
                        </h6>
                    </a>
                </cfloop>
            
            </div>
        </div>

        
       
        
    </div>
        
    <div class="card border mb-3">
        <div class="card-body">
            <h6>#obj_translater.get_translate('card_activity')#</h6>
            <table class="table table-borderless bg-white m-0">

                <tr>
                    <td class="bg-light">#obj_translater.get_translate('badge_planned_f_p')#</td>
                    <td>
                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-warning" id="nb_toschedule"><cfif tp_scheduled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_scheduled_go#",unit="min")#<cfelse>-</cfif></span></h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('badge_completed_f_p')#</td>
                    <td>
                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-success" id="nb_completed"><cfif tp_completed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_completed_go#",unit="min")#<cfelse>-</cfif></span></h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('badge_missed_f_p')#</td>
                    <td>
                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_missed"><cfif tp_missed_go neq "0">#obj_lms.get_format_hms(toformat="#tp_missed_go#",unit="min")#<cfelse>-</cfif></span></h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('badge_cancelled_f_p')#</td>
                    <td>
                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-danger" id="nb_cancelled"><cfif tp_cancelled_go neq "0">#obj_lms.get_format_hms(toformat="#tp_cancelled_go#",unit="min")#<cfelse>-</cfif></span></h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">#obj_translater.get_translate('badge_remaining_f_p')#</td>
                    <td>
                        <h6 class="m-0" style="font-size:16px"><span class="badge badge-pill badge-primary" id="nb_remain"><cfif tp_remain_go neq "0">#obj_lms.get_format_hms(toformat="#tp_remain_go#",unit="min")#<cfelse>-</cfif></span></h6>
                    </td>
                </tr>
                <tr>
                    <td class="bg-light">Date limite</td>
                    <td>
                        <cfif get_tp.tp_date_end lte now() AND get_tp.tp_vip eq "0">
                            <h6 class="m-0 text-danger"><i class="fas fa-exclamation-triangle text-danger"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                        <cfelse>
                            <cfif get_tp.tp_date_end lte dateadd("m",2,now())>
                                <h6 class="m-0 text-warning"><i class="fas fa-exclamation-triangle text-warning"></i> #obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                            <cfelse>
                                <h6 class="m-0">#obj_dater.get_dateformat(get_tp.tp_date_end)#</h6>
                            </cfif>
                        </cfif>
                    </td>
                </tr>
                <cfif l_id neq 0 AND listFindNoCase("CS,SALES,FINANCE,TRAINERMNG,TRAINER", SESSION.USER_PROFILE)>
                    <tr>
                        <td class="bg-light">-</td>
                        <td>
                            <span class="btn_show_attendance cursored" id="group_#t_id#_#l_id#" style="font-size:14px"><i class="fal fa-users"></i> Show attendance</span> 
                        </td>
                    </tr>
                </cfif>
            </table>
            
        </div>
    </div>
        
    
</div>
</cfoutput>

<div class="row mt-3">

    <cfoutput query="get_user">

        <div class="col-md-4">
            <div class="card border">
                <div class="card-body <cfif l_id neq 0><cfif lesson_signed eq 1 OR lesson_signed_trainer eq 1>user_attended</cfif></cfif>">

                    <div class="media">
                        #obj_lms.get_thumb(user_id="#user_id#", size="30")#
                        <div class="media-body ml-3">
                            <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
                                <div class="float-right">
                                <a class="btn <cfif is_group_leader eq 1>btn-success<cfelse></cfif> btn-sm btn_leader_learner" id="user_#t_id#_#user_id#"><i class="fa fa-crown" aria-hidden="true"></i></a>
                                <a class="btn btn-warning btn-sm btn_unbind_learner" id="user_#t_id#_#user_id#"><i class="fa fa-times" aria-hidden="true"></i> </a>
                                </div>
                                <h6><a href="common_learner_account.cfm?u_id=#user_id#">#user_contact#</a></h6>
                            <cfelseif SESSION.USER_PROFILE eq "TRAINER">
                                <h6><a href="common_learner_account.cfm?u_id=#user_id#">#user_contact#</a></h6>
                            <cfelse>
                                <h6>#user_contact#</h6>
                            </cfif>
                            
                            [#account_name#]<br>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>

    </cfoutput>
        <cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>
        <div class="col-md-4">
            <div class="card border">
                <div class="card-body">
                    <div class="media">

                        <img src="./assets/img/unknown_male.png" class="rounded-circle " width="30" title="Learner">
                        <div class="media-body ml-3">
                        <h6><a href="#">Ajouter Learner - <cfoutput>#a_id#</cfoutput></a></h6>

                        <!--- <cfdump var="#get_learner_account#"> --->
                        <cfif listFindNoCase("12", get_tp.method_id)>
                            <select name="account_select" id="account_select" class="form-control form-control-sm">
                                <option value="1">Staff</option>
                                <option value="2">Trainers</option>
                            </select>
                        <cfelse>
                            <select name="account_select" id="account_select" class="form-control form-control-sm">
                                <option value="0">---Apprenants sans compte----</option>
                                <cfoutput>
                                <cfloop query="get_all_account">
                                    <option value="#account_id#" class="account-#account_id# font-weight-bold" <cfif account_id eq a_id>selected</cfif>>#account_name#</option>
                                </cfloop>
                                </cfoutput>
                            </select>
                        </cfif>

                        <form class="form-inline" id="form_learner_add">
                            <!--- <select id="learner_select" class="form-control form-control-sm" name="u_id">
                            <option value="0" selected>Sélectionner</option>
                            <cfoutput query="get_learner_account" group="account_id">
                                
                                <cfoutput group="profile_id">
                                    <optgroup label="#profile_name#">
                                        <cfoutput>
                                        <cfif not listFind(list_user,user_id)>
                                            <option value="#user_id#">#ucase(user_name)# #user_firstname#</option>
                                        </cfif>
                                        </cfoutput>
                                    </optgroup>
                                </cfoutput>
                                
                            </cfoutput>
                            </select> --->
                            <div id="container_existing_user">
                                <select id="learner_select" class="learner_select_all form-control form-control-sm" name="u_id">
                                    <!--- <option value="0" selected>Sélectionner</option>
                                    <cfoutput query="get_learner_account">
                                        <option value="#user_id#" <cfif user_id eq u_id>selected</cfif>>#user_firstname# #ucase(user_name)#</option>
                                    </cfoutput> --->
                                </select>
                            </div>
                            <cfoutput><input type="hidden" name="t_id" value="#t_id#"></cfoutput>
                            <input type="submit" class="btn btn-sm btn-success btn_submit_add" value="Add">
                        </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </cfif>




</div>


<script>
$(document).ready(function() {

    function updateuserlist(val_acc_selected){

    // learner_select_all
    $.ajax({
        url: './api/users/user_get.cfc?method=oget_account_user',
        type: 'POST',
        data: { 
            <cfif not listFindNoCase( "12", get_tp.method_id)>
                a_id: val_acc_selected, 
                learner_only: 1
            <cfelse>
                a_id: 326, 
                staff_only: val_acc_selected,
                o_by: "firstname"
            </cfif>
        },
        success: function (result, status) {
            // console.log(result);
            var obj_result = jQuery.parseJSON(result);
            var target = $("#container_existing_user");
            target.empty(); // remove old options

            var el = $("<select></select>")
            el.attr("class", "learner_select_all form-control form-control-sm")
            el.attr("id", "learner_select")
            el.attr("name", "u_id")
            el.append($("<option></option>").attr("value", "0").text("Sélectionner"));

            <cfif not listFindNoCase( "12", get_tp.method_id)>
                obj_result.forEach(element => {
                    el.append($("<option></option>").attr("value", element.USER_ID).text(element.USER_NAME + " " + element.USER_FIRSTNAME ));
                });
            <cfelse>
                obj_result.forEach(element => {
                    el.append($("<option></option>").attr("value", element.USER_ID).text(element.USER_FIRSTNAME + " " + element.USER_NAME));
                });
            </cfif>
            
            target.append(el);

            }
        });
    }


    <cfif not listFindNoCase( "12", get_tp.method_id)>
    updateuserlist(<cfoutput>#a_id#</cfoutput>);
    <cfelse>
    updateuserlist(1);
    </cfif>

    $("#account_select").change(function(event) {

    var val_acc_selected = $(event.target).val();
    updateuserlist(val_acc_selected);

    })



	$('#form_learner_add').submit(function(event) {

		event.preventDefault();
		$.ajax({
			url : './api/tp/tp_post.cfc?method=updt_tplearner',
			method : 'GET',
			data: $('#form_learner_add').serialize(),
			contentType: false,
			cache      : false,
			processData: false,

			success : function(result, status) {
				$('#modal_body_xl').empty();
				$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
			}

		})

	})

    $('.btn_leader_learner').click(function(event) {	
        event.preventDefault();

        var _id = $(this).attr("id");
        var idtemp = _id.split("_");
        var t_id = idtemp[1];
        var u_id = idtemp[2];

        $.ajax({
            url : './api/tp/tp_post.cfc?method=updt_tplearner_leader',
            method : 'POST',
            data: { t_id: t_id, u_id: u_id },

            success : function(result, status) {

                // console.log("success", idtemp, _id);
                $("#" + _id).toggleClass( "btn-success" )
                // $('#modal_body_xl').empty();
                // $('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
            }

        })

    })

    $('.btn_unbind_learner').click(function(event) {	
        event.preventDefault();
        if(confirm("Are you sure ?"))
        {
            var idtemp = $(this).attr("id");
            var idtemp = idtemp.split("_");
            var t_id = idtemp[1];
            var u_id = idtemp[2];

            $.ajax({
                url : './api/tp/tp_post.cfc?method=updt_tplearner',
                method : 'POST',
                data:  { t_id: t_id, u_id: u_id },

                success : function(result, status) {
                    $('#modal_body_xl').empty();
					$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
                }

            })

        }
    })


    $('.btn_show_attendance').click(function(event) {	
        event.preventDefault();
        var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var t_id = idtemp[1];
        var l_id = idtemp[2];
        $('#window_item_xl').modal({keyboard: true});
        $('#modal_title_xl').text("Attendance");
        $('#modal_body_xl').load("modal_window_tpgroup_attendance.cfm?t_id="+t_id+"&l_id="+l_id, function() {});
    });

    



})

</script>
