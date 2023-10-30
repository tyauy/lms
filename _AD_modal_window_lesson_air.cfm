<cfparam name="l_id">

<cfinvoke component="api/lesson/lesson_get" method="oget_lesson" returnvariable="get_lesson">
	<cfinvokeargument name="l_id" value="#l_id#">
	<cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
</cfinvoke>

<cfif get_lesson.lesson_redirect neq "">
	<cfset _lesson_redirect = get_lesson.lesson_redirect>
	<cfset _lesson_redirect_key = get_lesson.lesson_redirect_key>
	<cfset _lesson_techno_name = get_lesson.tech_name>
	<cfset _lesson_techno_icon = get_lesson.techno_icon>
<cfelse>
	<cfset get_lesson_tech = obj_query.oget_lesson_default_tech(u_id="#get_lesson.planner_id#")>
	<cfset _lesson_redirect = get_lesson_tech.lesson_redirect>
	<cfset _lesson_redirect_key = get_lesson_tech.lesson_redirect_key>
	<cfset _lesson_techno_name = get_lesson_tech.tech_name>
	<cfset _lesson_techno_icon = get_lesson_tech.techno_icon>
</cfif>

<cfset p_id = get_lesson.planner_id>

<cfinvoke component="api/users/user_get" method="oget_planner" returnvariable="get_planner">
	<cfinvokeargument name="p_id" value="#p_id#">
</cfinvoke>

<cfinvoke component="api/users/user_get" method="oget_user" returnvariable="get_user">
	<cfinvokeargument name="u_id" value="#SESSION.USER_ID#">
</cfinvoke>



<cfoutput>
<div class="card border bg-light p-3"> 
	<div class="d-flex align-items-center">
        <div>
        	<img src="./assets/img/1000_F_287148708_woZEsRUnTO76uMcXDyTCGSiH0PHDR7bD.jpg" width="200">
        </div>
        <div class="ml-2 flex-grow-1">
            <h5 class="mt-0" align="center">
                <div class="spinner-grow text-danger" role="status">
                <span class="sr-only">Loading...</span>
                </div> Session de #get_lesson.lesson_duration# min avec #ucase(get_planner.user_firstname)#
            </h5>
            <p align="center">
				#obj_translater.get_translate('text_launch')#
            </p>
            <div align="center">
				<a class="btn btn-lg btn-red btn_launch_lesson">
					#obj_translater.get_translate('btn_visio_access')#
				</a>
			</div>
		</div>
    </div>

    <p align="center"><small>#obj_translater.get_translate('text_launch_add_blocker')#</small></p>
  
</div>
</cfoutput>

      

<button id="btn_head_1" class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse_item_1" aria-expanded="true" aria-controls="collapse_item_1">
				
    <h6 class="my-1 text-red" align="center">
        <i class="fa-sharp fa-light fa-angle-right"></i> <cfoutput>#obj_translater.get_translate('card_launch_issues')#</cfoutput>
    </h6>
</button>

<div id="collapse_item_1" class="collapse pb-2">

<cfif _lesson_techno_name neq "Google Meet">
<div class="card border bg-light p-3"> 
	<div class="d-flex align-items-center">
		<div>
			<img src="./assets/img/1000_F_473344851_XEEIeLtYKQkGze7QZsMUw46B184ClZWZ.jpg" width="200">
		</div>
		<div class="ml-3 w-75">
			<h5 class="mt-1"><cfoutput>#obj_translater.get_translate('card_launch_issue_1')#</cfoutput></h5>
			<cfset planner_firstname = get_planner.user_firstname>
			<cfset arr = ['planner_firstname']>
			<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
			<p>
				<cfoutput>#obj_translater.get_translate_complex(id_translate="text_launch_issue_1", argv="#argv#")#</cfoutput>
			</p>
			<button class="btn btn-block btn-outline-red cursored btn_launch_ggmeet">
				<i class="fa-brands fa-google"></i>
				<cfoutput>#obj_translater.get_translate_complex(id_translate="btn_launch_ggmeet", argv="#argv#")#</cfoutput>

				<!--- <div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
				
				</div> --->
			</button>

		</div>
		
	</div>
</div>
</cfif>



<div class="card border bg-light p-3"> 
	<div class="d-flex align-items-center">
		<div>
			<img src="./assets/img/1000_F_585259797_NUJFZFd3vyJ3PwlSzmMP9zf4gAQIccgm.jpg" width="200">
		</div>
		<div class="ml-3 w-75">
			<h5 class="mt-1"><cfoutput>#obj_translater.get_translate('card_launch_issue_2')#</cfoutput></h5>
			<p>
				<cfoutput>#obj_translater.get_translate_complex('text_launch_issue_2')#</cfoutput>
			</p>
			<button class="btn btn-block btn-outline-red cursored">
				
				<i class="fa-solid fa-light-emergency-on"></i>

				<cfif get_lesson.provider_id eq "2">
					<cfoutput>#obj_translater.get_translate('btn_launch_contact_fr')#</cfoutput>
				<cfelse>
					<cfoutput>#obj_translater.get_translate('btn_launch_contact_de')#</cfoutput>
				</cfif>
					<!--- <div class="card-text font-weight-normal" align="left" style="white-space:normal !important; font-size:14px !important; line-height:25px !important">
					qdvqdv
					</div> --->
			</button>
		</div>
	</div>
</div>

    <!--- <div align="center">N'hésitez pas à consulter nos FAQ</div> --->

</div>
    
<script>
$(document).ready(function() {
	
	$('.btn_launch_lesson').click(function(event) {
		window.open("<cfoutput>#_lesson_redirect#</cfoutput>");
	})

	$('.btn_launch_ggmeet').click(function(event) {
		window.open("<cfoutput>#_lesson_redirect#</cfoutput>");
	})

})	
</script>

   
                

		<!--- <div class="p-2 w-100">
			<table class="table table-sm w-100 border">		
				<cfif listFindNoCase("TRAINER", SESSION.USER_PROFILE)>	
				<tr>
					<th class="bg-light" width="25%">
						<label>#obj_translater.get_translate('table_th_learner')#</label> 
					</th>
					<td colspan="2">
						<a href="common_learner_account.cfm?u_id=#get_user.user_id#">#get_user.user_firstname# #get_user.user_name#</a>
					</td>
				</tr>
				</cfif>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_trainer')#</label> 
					</th>
					<td colspan="2">
						#obj_lms.get_thumb(user_id="#get_planner.user_id#",size="30")# #UCASE(get_planner.user_firstname)#
					</td>
				</tr>		
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_method')#</label> 
					</th> 
					<td colspan="2">
						#get_lesson.method_name#
					</td>
				</tr>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_date')#</label>
					</th>
					<td colspan="2">
						#obj_function.get_dateformat(get_lesson.lesson_start)# | #TimeFormat(get_lesson.lesson_start, "HH:mm")# - #TimeFormat(get_lesson.lesson_end, "HH:mm")#
					</td>
				</tr>
				<tr>
					<th class="bg-light">
						<label>#obj_translater.get_translate('table_th_duration')#</label>
					</th> 
					<td colspan="2">
						#get_lesson.lesson_duration#min
					</td>
				</tr>
				<cfif _lesson_redirect neq "" AND get_lesson.method_id neq "2">
					<tr>
						<th class="bg-light">
							<label><cfoutput>#obj_translater.get_translate('table_th_techno')#</cfoutput></label>
						</th>
						<td colspan="2">
							<i class="#_lesson_techno_icon#"></i>
							#_lesson_techno_name#
						</td>
					</tr>
				</cfif>
				<cfif _lesson_redirect_key neq "" AND get_lesson.method_id neq "2">
					<tr>
						<th class="bg-light">
							<label><cfoutput>#obj_translater.get_translate('table_th_techno_key')#</cfoutput></label>
						</th>
						<td colspan="2">
							#_lesson_redirect_key#
						</td>
					</tr>
				</cfif>
				
			</table>

		</div> --->

	

		
	

