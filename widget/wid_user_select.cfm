<!--- <cfdump var="#get_user_account#"> --->


<table class="table table-sm">
    <cfoutput query="get_user_account_tm" group="user_id">
        <tr>
            <td>
                <span class="badge badge-pill text-white bg-#user_status_css#">#user_status_name_fr#</span>			
           </td>
            <td>
            
            </td>
            <td>
                 <cfoutput group="profile_id">
                    <a class="btn btn-sm btn-info p-1" href="#SESSION.BO_ROOT_URL#/index.cfm?user_name=#user_email#&upass=#user_password#" id="sm_#user_id#">#profile_name#</a>
                </cfoutput>
            </td>
            <td></td>
            <td>#user_firstname# #ucase(user_name)#</td>
            <td></td>
            <td></td>
            <td></td>
            <td>#user_email#</td>
            <td align="right">
                <a class="btn btn-sm btn-default btn_update_learner" id="u_#user_id#"><i class="fas fa-edit"></i></a>
                <a class="btn btn-sm btn-default" href="common_learner_account.cfm?u_id=#user_id#" id="u_#user_id#"><i class="fas fa-eye"></i></a>
            <!---<a class="btn btn-sm btn-default btn_del_ctc" href="##" onclick="if(confirm('Souhaitez-vous effacer ce contact ?')){document.location.href='updater_crm.cfm?account_id=#account_id#&contact_id=#contact_id#&del_contact=1'}"><i class="far fa-trash-alt"></i></a>--->
            </td>
        </tr>
        </cfoutput>


</table>