<cfset get_to = obj_task_get.oget_to()>
<cfset list_tab = "learner|user|u_id|cs|u_name">
<cfset u_id = "11747">

<head>
	<cfinclude template="./incl/incl_head.cfm">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.1/Chart.bundle.min.js"></script>
	
	<style>
	.card {
		border-radius: 2px !important;
		box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
	}
	.nav-link {
		color: #999 !important;
	}
	.nav-link.active
	{
		color:#51BCDA !important;
	}
	</style>

</head>


<cfloop list="#list_tab#" index="cor" delimiters=",">
	
    <cfif listgetat(cor,1,'|') eq "group">
    <cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="TO DO",log_status="1",o_by="log_remind")>
    <cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="TO DO",log_status="0",o_by="log_remind")>
    <cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(g_id="#g_id#",category="FEEDBACK",o_by="date_desc")>
    </cfif>
    <cfif listgetat(cor,1,'|') eq "account">
    <cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="TO DO",log_status="1",o_by="log_remind")>
    <cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="TO DO",log_status="0",o_by="log_remind")>
    <cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(a_id="#a_id#",category="FEEDBACK",o_by="date_desc")>
    </cfif>
    <cfif listgetat(cor,1,'|') eq "learner">
    <cfset "get_log_todo_done_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="1",o_by="log_remind")>
    <cfset "get_log_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="TO DO",log_status="0",o_by="log_remind")>
    <cfset "get_log_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_log(u_id="#u_id#",category="FEEDBACK",o_by="date_desc")>
    </cfif>

    <cfset "get_task_list_todo_#listgetat(cor,1,'|')#" = obj_task_get.oget_task_list(task_type="#listgetat(cor,4,'|')#",category="TO DO")>
    <cfset "get_task_list_feedback_#listgetat(cor,1,'|')#" = obj_task_get.oget_task_list(task_type="#listgetat(cor,4,'|')#",category="FEEDBACK")>

</cfloop>

<form id="form_insert_todo">

    <table class="table table-sm table-bordered bg-white">
        
        <tr>
            <td class="bg-light" width="120"><strong>Visibilit&eacute;</strong></td>
            <td colspan="2">
            <label><h5 class="m-0"><input type="checkbox" name="profile_id" checked="checked" value="5"> <span class="badge badge-danger">CS</span></h5></label>&nbsp;&nbsp;&nbsp;
            <label><h5 class="m-0"><input type="checkbox" name="profile_id" value="8"> <span class="badge badge-info">TM</span></h5></label>&nbsp;&nbsp;&nbsp;
            <label><h5 class="m-0"><input type="checkbox" name="profile_id" value="4"> <span class="badge badge-success">T</span></h5></label>
            <!---<label><h5 class="m-0"><input type="checkbox" name="profile_id" value="3"> <span class="badge badge-warning">L</span></h5></label>--->
            </td>
        </tr>
        <tr>
            <td class="bg-light" width="120"><strong>Destinataire</strong></td>
            <td colspan="2">
                <select class="form-control form-control-sm" name="to_id">
                <option value="0">Tous</option>
                <cfoutput query="get_to">
                <option value="#user_id#">#user_firstname#</option>
                </cfoutput>
                </select>
            </td>
        </tr>
        <cfif isdefined("u_id") and u_id neq 0>
        <cfquery name="get_order" datasource="#SESSION.BDDSOURCE#">
        SELECT o.order_id, o.order_ref, os.status_finance_name
        FROM user u
        LEFT JOIN orders o ON o.user_id = u.user_id
        LEFT JOIN order_status_finance os ON os.status_finance_id = o.order_status_id
        WHERE u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#u_id#">
        </cfquery>
        <!--- <tr> --->
            <!--- <td class="bg-light" width="120"><strong>Order</strong></td> --->
            <!--- <td> --->
            <!--- <cfoutput query="get_order"> --->
            <!--- <label><input type="checkbox" name="order_id" value="#order_id#"> #order_ref# <em>(#status_finance_name#)</em> </label><br> --->
            <!--- </cfoutput> --->
            <!--- </td> --->
        <!--- </tr> --->
        </cfif>
        <tr>
            <td class="bg-light"><strong>Catégorie</strong></td>
            <td colspan="2">
            <select class="form-control form-control-sm task_type_id" name="task_type_id">
            <cfoutput query="get_task_list_todo_learner" group="task_group">
            <optgroup label="#task_group_alias#">
            <cfoutput>
            <option value="#task_type_id#">TO DO : #task_type_name#</option>
            </cfoutput>
            </optgroup>
            </cfoutput>		
            </select>
            </td>
        </tr>
        <tr>
            <td class="bg-light"><strong>Description</strong></td>
            <cfoutput>
            <td colspan="2"><textarea name="log_text" id="log_text_todo_#listgetat(cor,1,'|')#" class="form-control"></textarea></td>
            </cfoutput>
        </tr>	
        
        <tr>
            <td class="bg-light"><strong>&Eacute;cheance</strong></td>
            <td width="150">
            <label><input type="checkbox" name="log_remind_ok" id="log_remind_ok" value="1" checked="checked"> Activer pour le</label>
            </td>
            <td>
            <div class="controls">
                <div class="input-group">
                    <cfoutput>
                    <input id="log_remind_create_#listgetat(cor,1,'|')#" name="log_remind" type="text" class="datepicker form-control" value="#dateformat(now(),'dd/mm/yyyy')# 08:00" />
                    <label for="log_remind_create_#listgetat(cor,1,'|')#" class="input-group-addon btn"><i class="fas fa-calendar-alt"></i></label>
                    </cfoutput>
                </div>
            </div>
            </td>
        </tr>
        <tr>
            
            <td colspan="3" align="center">
                <cfoutput>
                
                <cfif listgetat(cor,1,'|') eq "group">
                <input type="hidden" name="g_id" value="#g_id#">
                </cfif>
                <cfif listgetat(cor,1,'|') eq "account">
                <input type="hidden" name="a_id" value="#a_id#">
                </cfif>
                <cfif listgetat(cor,1,'|') eq "learner">
                <input type="hidden" name="u_id" value="#u_id#">
                </cfif>
                <input type="hidden" name="method" value="insert_task">
                <input type="hidden" name="task_category" value="TO DO">
                <input type="submit" value="SAVE TO DO" class="btn btn-sm btn-warning">
                </cfoutput>
            </td>
        </tr>

        
    </table>

</form>

    <cfinclude template="./incl/incl_scripts.cfm">

    
<script>
    $(document).ready(function() {
    
        console.log($('#form_insert_todo').serialize());
        $("#form_insert_todo").submit(function(event) {
            event.preventDefault();

            $.ajax({				 
                url: './api/task_post.cfc?method=insert_task',
                type: 'POST',
                data: $('#form_insert_todo').serialize(),
                success : function(resultat, statut){
                    $('#alert_todo_ok').collapse('show');
                },
                error : function(resultat, statut, erreur){
                },
                complete : function(resultat, statut){
                }	
            });
        })

        
    })
    </script>