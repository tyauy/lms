<!DOCTYPE html>

<cfsilent>

	<cfset secure = "2,5,6,12">
	<cfinclude template="./incl/incl_secure.cfm">		


    <cfquery name="get_users" datasource="#SESSION.BDDSOURCE#">
        SELECT u.user_id, u.user_firstname, u.user_alias, up.profile_name, u.user_pref_task_group
        FROM user u 
        INNER JOIN user_profile_cor upc ON upc.user_id = u.user_id
        INNER JOIN user_profile up ON up.profile_id = upc.profile_id  
        AND u.user_status_id = 4
        AND upc.profile_id IN (1,2,5,6,12)  
        GROUP BY u.user_id
    </cfquery>	

<cfset get_task_list_cs = obj_task_get.oget_task_list(category="TO DO")>
        
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">
	
</head>

<style>
.card {
	border-radius: 2px !important;
	box-shadow: 0 2px 7px -4px rgba(0, 0, 0, 0.15) !important;
}
</style>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Calendar Settings">		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
			
            <div class="content">
                <div class="card">
                    <table class="table">
                        <tr>
                            <th>ID</th>
                            <th>Profile</th>
                            <th>Name</th>
                            <th>Alias</th>
                            <th>Default view</th>
                        </tr>
                    
                    <cfloop query="get_users">
                        <tr>
                            <td><cfoutput>#user_id#</cfoutput></td>
                            <td><cfoutput>#profile_name#</cfoutput></td>
                            <td><cfoutput>#user_firstname#</cfoutput></td>
                            <td><cfoutput>#user_alias#</cfoutput></td>
                            <td>
                                <form action="db_updater.cfm">
                                <cfoutput query="get_task_list_cs" group="task_group_alias">				
                                    <!--- <cfquery name="get_task" datasource="#SESSION.BDDSOURCE#">
                                    SELECT 
                                    COUNT(l.log_id) as nb,
                                    tt.task_type_name
                                    FROM logs l
                    
                                    INNER JOIN logs_item li ON li.log_id = l.log_id
                                    INNER JOIN task_type tt ON tt.task_type_id = li.task_type_id
                                    LEFT JOIN user u ON u.user_id = l.user_id
                                    LEFT JOIN user t ON l.to_id = t.user_id
                                    LEFT JOIN user f ON l.from_id = f.user_id
                    
                                    LEFT JOIN account a ON a.account_id = u.account_id
                                    LEFT JOIN account_group g ON g.group_id = a.group_id
                    
                                    LEFT JOIN account al ON al.account_id = l.account_id
                                    LEFT JOIN account_group gl ON gl.group_id = l.group_id
                    
                    
                                    WHERE l.log_remind IS NOT NULL 
                                    AND task_group_alias = <cfqueryparam cfsqltype="cf_sql_varchar" value="#task_group_alias#">
                    
                                    AND date_format(log_remind, "%Y-%m-%d") = '#dateformat(now(),'yyyy-mm-dd')#'
                                    AND log_status IS NULL
                    
                                    GROUP BY tt.task_type_name
                                    </cfquery> --->
                                        <div class="btn-group" role="button">
                                        <button type="button" class="btn btn-sm text-white p-1 m-0" style="background-color:###task_color# !important; font-weight:normal">
                                        <input type="checkbox" class="p-0 m-0" name="user_pref_task_group" value="#task_group#" <cfif listfind(get_users.user_pref_task_group,task_group)>checked</cfif>>
                                        #task_group_alias#
                                        </button>
                                        </div>

                                    </cfoutput>
                                    <input type="submit" value="UPDT" class="btn btn-sm btn-info float-right">
                                    <input type="hidden" name="user_id" value="<cfoutput>#user_id#</cfoutput>">
                                </form>

                            </td>
                        </tr>


                    </cfloop>

                </table>

                </div>
            </div>
		</div>
		
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
$( document ).ready(function() {



});
</script>

</body>
</html>