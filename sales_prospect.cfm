<!DOCTYPE html>

<cfsilent>

<!--- <cfparam name="msel" default="#month(now())#">
<cfif SESSION.LANG_CODE neq "fr">
	<cfset mlongsel = listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),msel)>
<cfelse>
	<cfset mlongsel = listgetat(SESSION.LISTMONTHS,msel)>
</cfif>
<cfset msel = listgetat(SESSION.LISTMONTHS_CODE,msel)>
<cfparam name="ysel" default="#year(now())#">
<cfparam name="tselect" default="#ysel#-#msel#"> --->


<cfparam name="t_id" default="9">
<cfparam name="st_id" default="5">

<cfquery name="get_account_type" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_type WHERE type_id = 9
</cfquery>

<cfquery name="get_account_status" datasource="#SESSION.BDDSOURCE#">
SELECT status_id, status_name FROM account_status where status_id > 4 UNION SELECT 0 as status_id, "NR" as status_name FROM account_status
</cfquery>

</cfsilent>
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Prospection WEFIT">
		<cfinclude template="./incl/incl_nav.cfm">
				
		<div class="content">
	  	
			<!--- <cfif isdefined("e")>
			<div class="alert alert-danger" role="alert">
				<div class="text-center"><em>Un utilisateur existe d&eacute;j&agrave; avec l'adresse email utilis&eacute;e.</em></div>
			</div>
			<cfelseif isdefined("k") AND k eq "1">
			<div class="alert alert-success" role="alert">
				<div class="text-center"><em>L'email a correctement été envoyé.</em></div>
			</div>
			</cfif> --->
		
			<cfform action="sales_prospect.cfm">
			<div class="row">
			
				<div class="col-md-2">
				
                    <h6>Type Account</h6>									
                    <cfoutput query="get_account_type">
                    <a href="sales_prospect.cfm?t_id=#type_id#" class="btn btn-sm <cfif t_id eq type_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;#type_name#</a>
                    </cfoutput>

				</div>

                <!--- <div class="col-md-10">
				
                    <h6>Status</h6>	
                    <cfoutput query="get_account_status">
                    <a href="sales_prospect.cfm?st_id=#status_id#" class="btn btn-sm <cfif st_id eq status_id>btn-warning active<cfelse>btn-info</cfif>"><i class="fas fa-users"></i>&nbsp;#status_name#</a>
                    </cfoutput>
                    
				</div> --->

			
				<!--- <div class="col-md-4">
					<h6 class="card-title">Période : <cfoutput>#mlongsel# #ysel#</cfoutput></h6>
					<div class="form-row">

						<div class="col">
							<select class="form-control" name="msel">

								<cfloop from="1" to="12" index="m">
									<cfoutput>
										<cfif SESSION.LANG_CODE neq "fr">
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(evaluate("SESSION.LISTMONTHS_#SESSION.LANG_CODE#"),m)#</option>
										<cfelse>
											<option value="#m#" <cfif msel eq m>selected="selected"</cfif>>#listgetat(SESSION.LISTMONTHS,m)#</option>
										</cfif>


									</cfoutput>
								</cfloop>
							</select>
						</div>

						<div class="col">

							<select class="form-control" name="ysel">
								<cfloop from="2019" to="#year(now())#" index="y">
									<cfoutput>
										<option value="#y#" <cfif ysel eq y>selected="selected"</cfif>>#y#</option>
									</cfoutput>
								</cfloop>
							</select>
							
						</div>
						
						<div class="col">
							<cfoutput>
							<input type="hidden" name="o_by" value="#o_by#">
							<input type="hidden" name="pf_id" value="#pf_id#">
							</cfoutput>
							<input type="submit" value="GO" class="btn btn-sm btn-info">
							<cfoutput><a href="cs_learners.cfm?pf_id=#pf_id#" class="btn btn-sm btn-warning">#obj_translater.get_translate('btn_trainer_thismonth')#</a></cfoutput>
						</div>

					</div>
				
				</div> --->
				
					
				
				
			</div>
			</cfform>
			
			<div class="row mt-4">
                
				<div class="col-md-12">
                    
                    <div class="card">

                        <div class="card-body">

                            <ul class="nav nav-tabs" id="order_list" role="tablist">
                                <cfoutput query="get_account_status">
                                    
                                <cfset "get_account_#status_id#" = obj_account_get.get_account(t_id="#t_id#",st_id="#status_id#")>

                                <li class="nav-item">
                                    <a href="##s_#status_id#" class="nav-link <cfif st_id eq status_id>active</cfif>" role="tab" data-toggle="tab">
                                        #status_name# <cfif evaluate("get_account_#status_id#").recordcount neq "0"><div class="badge badge-info">#evaluate("get_account_#status_id#").recordcount#</div></cfif>
                                    </a>
                                </li>
                                </cfoutput>
                            </ul>
        
                            <div class="tab-content">
                                <cfoutput query="get_account_status">
                                <div role="tabpanel" class="tab-pane fade <cfif st_id eq status_id>active show</cfif>" id="s_#status_id#">
                                    <!--- <cfdump var="#get_account#"> --->

                                    <br>

                                    <table class="table">
                                        <tr class="bg-light">
                                            <td width="30%">Account</a></td>
                                            <td width="30%">Group</a></td>
                                            <td width="10%"></td>
                                            <td width="10%"></td>
                                            <td width="15%" align="right" class="font-weight-bold">
                                            Feedback
                                            </td>
                                        </tr>

                                        <cfloop query="get_account_#status_id#">
                                            <cfif status_id eq get_account_status.status_id>
                
                                                <!--- #status_id# -- 
                                                <br> --->
                                            <cfset get_todo = obj_task_get.oget_count_log(a_id="#account_id#",category="TO DO")>
                                            <cfset get_feedback = obj_task_get.oget_count_log(a_id="#account_id#",category="FEEDBACK")>
        
                                            <tr>
                                                    <!--- <td>#account_id#</td> --->
                                                <td width="30%"><a href="crm_account_edit.cfm?a_id=#account_id#">#account_name#</a></td>
                                                <td width="30%"><a href="crm_account_edit.cfm?a_id=#account_id#">#group_name#</a></td>
                                                <td width="10%"><span class="badge text-white" style="background-color:###account_manager_color#;">#account_manager#</span></td>
                                                <td width="10%"><span class="badge text-white bg-#type_css#">#type_name#</span></td>
                                                <td width="15%" align="right" class="font-weight-bold">
                                                    <a class="btn btn-sm btn-warning btn_view_log_account" id="a_#account_id#" href="##"><i class="fal fa-book" aria-hidden="true"></i> #get_todo.nb#</a>
                                                    <a class="btn btn-sm btn-info btn_view_log_account" id="a_#account_id#" href="##"><i class="fal fa-edit" aria-hidden="true"></i> #get_feedback.nb#</a>
                                                </td>
                                            </tr>
                                            </cfif>
                                        </cfloop>
                                    </table>

                                </div>
                                </cfoutput>
                            </div>	

                        </div>

                    </div>
						
				</div>
			</div>
			
		</div>
      
<cfinclude template="./incl/incl_footer.cfm">
	  
	</div>
</div>
  
  
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">


<script>


$(document).ready(function() {
	
	$('.btn_view_log_account').click(function(event) {	
		event.preventDefault();		
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var a_id = idtemp[1];	
		$('#window_item_xl').modal({keyboard: true});
		$('#modal_title_xl').text("Follow-Up");
		$('#modal_body_xl').load("modal_window_log.cfm?a_id="+a_id, function() {});
	});

})

</script>


</body>
</html>