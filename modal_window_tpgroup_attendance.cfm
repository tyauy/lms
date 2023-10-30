<cfsilent>

    <cfparam name="t_id" type="integer">
    <cfparam name="l_id" type="integer">

    <!--- <cfset get_tp = obj_tp_get.oget_tp(t_id="#t_id#")> --->

    <cfquery name="get_lesson" datasource="#SESSION.BDDSOURCE#">	
		SELECT l.lesson_start
        FROM lms_lesson2 l
        WHERE l.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
    </cfquery>

    
    <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact,
        a.account_name, u.account_id,
        la.subscribed, la.lesson_signed, la.lesson_signed_trainer,
        t.method_id
        FROM lms_tp t 
        INNER JOIN lms_tpuser tpu ON t.tp_id = tpu.tp_id AND tpu.tpuser_active = 1
        INNER JOIN user u ON u.user_id = tpu.user_id
        INNER JOIN account a ON a.account_id = u.account_id
        LEFT JOIN lms_lesson2_attendance la ON la.user_id = u.user_id AND la.lesson_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#l_id#">
        WHERE tpu.tp_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
    </cfquery>

    <cfset list_user = "">
    <cfoutput query="get_user">
        <cfset list_user = listappend(list_user,user_id)>
    </cfoutput>
    
    <cfset get_learner_account = obj_query.oget_learner(pf_id="100",ust_id="1,2,3,4",list_account="#get_user.account_id#",o_by="name")>

</cfsilent>

<style>
</style>
    
<div class="row mt-3">

    <table class="table table-bordered">						
        <tr class="bg-light">
            <td><strong>ID</strong></td>
            <td><strong>LEARNER</strong></td>
            <td><strong>ACCOUNT</strong></td>
            <td><strong>SUBSCRIBED</strong></td>
            <td><strong>STATUS</strong></td>
            <td><strong>DATE</strong></td>
            <td><strong></strong></td>
        </tr>
        
        
        
        <cfoutput query="get_user">
            
            <tr <cfif lesson_signed eq 1 OR lesson_signed_trainer eq 1>style="background: ##93ff86;"</cfif>>
                <td>
                    #obj_lms.get_thumb(user_id="#user_id#", size="30")#
                </td>
                <td>
                    <h6><a href="common_learner_account.cfm?u_id=#user_id#">#user_contact#</a></h6>
                </td>
                <td>
                    [#account_name#]
                </td>
                <td>
                    #subscribed#
                </td>
                <td>
                    <cfif lesson_signed eq 1>
                        YES
                    <cfelse>
                        <select id="att_select_#user_id#" class="form-control form-control-sm att_select" name="_att">
                            <option value="1" <cfif lesson_signed_trainer eq 1>selected </cfif>>Yes</option>
                            <option value="0" <cfif lesson_signed_trainer neq 1>selected </cfif>>No</option>
                        </select>
                    </cfif>
                   
                </td>
                <td>
                    #get_lesson.lesson_start#
                </td>
                <td>
                    #obj_lms.get_learner_signature(l_id="#l_id#", u_id="#user_id#", size="80")#
                </td>
            </tr>						
            </cfoutput>
        
        
    </table>


</div>


<script>
$(document).ready(function() {

	// $('#form_learner_add').submit(function(event) {

	// 	event.preventDefault();
	// 	$.ajax({
	// 		url : './api/tp/tp_post.cfc?method=updt_tplearner',
	// 		method : 'GET',
	// 		data: $('#form_learner_add').serialize(),
	// 		contentType: false,
	// 		cache      : false,
	// 		processData: false,

	// 		success : function(result, status) {
	// 			$('#modal_body_xl').empty();
	// 			$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
	// 		}

	// 	})

	// })


    // $('.btn_unbind_learner').click(function(event) {	
    //     event.preventDefault();
    //     if(confirm("Are you sure ?"))
    //     {
    //         var idtemp = $(this).attr("id");
    //         var idtemp = idtemp.split("_");
    //         var t_id = idtemp[1];
    //         var u_id = idtemp[2];

    //         $.ajax({
    //             url : './api/tp/tp_post.cfc?method=updt_tplearner',
    //             method : 'POST',
    //             data: { t_id: t_id, u_id: u_id },

    //             success : function(result, status) {
    //                 $('#modal_body_xl').empty();
	// 				$('#modal_body_xl').load("modal_window_tpgroup.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
    //             }

    //         })

    //     }
    // })

    $('.att_select').change(function(){
		var idtemp = $(this).attr("id");
        var idtemp = idtemp.split("_");
        var u_id = idtemp[2];

        console.log(u_id, $(this).val())

        $.ajax({
                url : './api/tp/tp_post.cfc?method=updt_tplearner_attendance',
                method : 'GET',
                data: 'l_id=<cfoutput>#l_id#</cfoutput>&u_id='+u_id+'&att='+$(this).val(),
                contentType: false,
                cache      : false,
                processData: false,

                success : function(result, status) {
                    $('#modal_body_xl').empty();
					$('#modal_body_xl').load("modal_window_tpgroup_attendance.cfm?t_id="+<cfoutput>#t_id#+"&l_id="+#l_id#</cfoutput>, function() {})
                }

            })
	})



})

</script>
