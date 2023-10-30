<!DOCTYPE html>

<cfsilent>

<cfset secure = "3,5,8,12">
<cfinclude template="./incl/incl_secure.cfm">	


<cfparam name="user_status_id" default="4">

<cfquery name="get_trainer" datasource="#SESSION.BDDSOURCE#">
SELECT u.*
FROM user u
WHERE profile_id = <cfqueryparam cfsqltype="cf_sql_integer" value="4">

<cfif user_status_id neq "0">
AND (1 = 2 
<cfloop list="#user_status_id#" index="cor">
OR u.user_status_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cor#">
</cfloop>
)
</cfif>

ORDER BY user_status_id, user_firstname ASC
</cfquery>

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
      
		<cfset title_page = "Formateurs WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  	
			<table class="table table-bordered bg-white">
                <tr>
                    <td>PIC</td>
                    <td>ID</td>
                    <td>Trainer</td>
                    <td width="150">BBB</td>
                    <td width="150">GGMEET</td>
                    <td width="150">ZOOM</td>
                    <td width="150">WHEREBY</td>
                    <td width="150">TEAMS</td>
                    <td>NEW</td>
                </tr>
                <cfoutput query="get_trainer">
                    
                <tr>
                    <td>#obj_lms.get_thumb(user_id="#user_id#", size="50")#</td>
                    <td>#user_id#</td>
                    <td>#user_firstname#</td>
                    <td>
                        <cfset get_techno_solo = obj_query.oget_techno(p_id="#user_id#", techno_id="3")>
                        <br>
                        <cfif get_techno_solo.recordcount neq "0"> 
                            <cfif get_techno_solo.user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif> 
                            <br>"#get_techno_solo.user_techno_link#"
                        </cfif>
                    </td>
                    <td>
                        <cfset get_techno_solo = obj_query.oget_techno(p_id="#user_id#", techno_id="4")>
                        <br>
                        <cfif get_techno_solo.recordcount neq "0"> 
                            <cfif get_techno_solo.user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif> 
                            <br>"#get_techno_solo.user_techno_link#"
                        </cfif>
                   </td>
                    <td>
                        <cfset get_techno_solo = obj_query.oget_techno(p_id="#user_id#", techno_id="6")>
                        <br>
                        <cfif get_techno_solo.recordcount neq "0"> 
                             <cfif get_techno_solo.user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif> 
                            <br>"#get_techno_solo.user_techno_link#"<br>#get_techno_solo.user_techno_key# 
                        </cfif>
                   </td>
                    <td>
                        <cfset get_techno_solo = obj_query.oget_techno(p_id="#user_id#", techno_id="11")>
                        <br>
                        <cfif get_techno_solo.recordcount neq "0"> 
                            <cfif get_techno_solo.user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif> 
                            <br>"#get_techno_solo.user_techno_link#"
                        </cfif>
                    </td>
                    <td>
                        <cfset get_techno_solo = obj_query.oget_techno(p_id="#user_id#", techno_id="5")>
                        <br>
                        <cfif get_techno_solo.recordcount neq "0"> 
                            <cfif get_techno_solo.user_techno_preferred eq "1"><i class="fas fa-star text-warning"></i></cfif>
                            <br>"#get_techno_solo.user_techno_link#"
                        </cfif>
                   </td>
                </tr>
                </cfoutput>



            </table>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script type="text/javascript">
						

$(document).ready(function() {

	
});
</script>
						
</body>
</html>