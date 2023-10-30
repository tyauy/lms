

           
    
  <cfinvoke component="api/learner_badges/badges_get" method="getUserModuleStats" returnvariable="getUserModuleStats">
    <cfinvokeargument name="user_id" value="2030">
       
</cfinvoke>
<cfinvoke component="api/learner_badges/badges_get" method="getUserViewIntervals" returnvariable="getUserViewIntervals">
    <cfinvokeargument name="user_id" value="2030">
</cfinvoke>
<cfinvoke component="api/learner_badges/badges_get" method="getWeeklyLogs" returnvariable="get_connect_intervals">
    <cfinvokeargument name="user_id" value="28538">
</cfinvoke>
<cffunction name="get_format_days" output="false" returntype="string">
    <cfargument name="intervalInSeconds" type="numeric" required="yes">
    <cfset var totalMinutes = fix(arguments.intervalInSeconds / 60)>
    <cfset var hours = fix(totalMinutes / 60)>
    <cfset var days = fix(hours / 24)>
    <cfset var remainingHours = hours MOD 24>
    <cfset var result = days & " day(s) " & remainingHours & " hour(s)">
    <cfreturn result>
</cffunction>
 


  

    

<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
    <cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : empty test page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfinclude template="incl/incl_head.cfm">
    <style>
        .star-rating {
            color: #ffc107; /* gold color */
        }
    </style>
</head>
<body>
    <cfinclude template="./incl/incl_sidebar.cfm">
    <div class="main-panel">
        <cfinclude template="./incl/incl_nav.cfm">
        <div class="content">
            <div class="container mt-5">
                <h2><a href="https://docs.google.com/presentation/d/1tGAusNixX4V-LDdeo31CKSFu6kFrXPGmbq6OLAdNa1M/edit?usp=sharing">See project detail here</a></h2>

                <div class="row">
                   
                    <!-- Card 1 -->
                    <div class="col-sm-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Consecutive weeks on module / sm activity</h5>
                               
    
                                <table class="table table-striped">
                                  <thead>
                                    <tr>
                                      <th scope="col">Date Logged</th>
                                      <th scope="col">Interval Since Last Log</th>
                                      <th scope="col">Rating</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <cfset prev_date = "">
                                    <cfset prev_week_no = 0>
                                    <cfset consecutive_weeks = 1>
                                    
                                    <cfoutput query="getUserViewIntervals" group="sm_lastview_date">
                                      <cfset current_date = sm_lastview_date>
                                      <cfset current_week_no = datePart("ww", current_date)>
                                
                                      <cfif prev_date neq "" AND current_week_no neq prev_week_no>
                                        <cfif current_week_no - prev_week_no eq 1>
                                          <cfset consecutive_weeks++>
                                        <cfelse>
                                          <cfset consecutive_weeks = 1>
                                        </cfif>
                                      </cfif>
                                
                                      <tr>
                                        <td>#dateformat(current_date, 'dd.mm.yyyy')#</td>
                                        <td>
                                          <cfif view_interval neq "" AND IsNumeric(view_interval)>
                                            #get_format_days(intervalInSeconds=val(view_interval))#
                                          <cfelse>
                                            -
                                          </cfif>
                                        </td>
                                        <td class="star-rating">
                                          <cfif consecutive_weeks eq 2>
                                            *
                                          <cfelseif consecutive_weeks eq 3>
                                            **
                                          <cfelseif consecutive_weeks eq 5>
                                            ***
                                          <cfelseif consecutive_weeks eq 7>
                                            ****
                                          <cfelseif consecutive_weeks gte 9>
                                            *****
                                          </cfif>
                                        </td>
                                      </tr>
                                
                                      <cfset prev_date = current_date>
                                      <cfset prev_week_no = current_week_no>
                                    </cfoutput>
                                  </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div class="col-sm-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">User Stats</h5>
                                <cfoutput query="getUserModuleStats">
                                    <br>
                                    <table class="table bg-white table-bordered m-0">
                                        <tr>
                                            <td width="40%"><i class="fa-light fa-lg fa-clock"></i> Time spent on all SM <!--- <small>#obj_translater.get_translate('table_th_elapsed_time_course')#</small> ---></td>
                                            <td>
                                                <cfif total_elapsed neq "">#obj_lms.get_format_hms(toformat="#total_elapsed#")#<cfelse>-</cfif>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="40%"><i class="fa-light fa-lg fa-user-clock"></i> Last visit<!--- <small>#obj_translater.get_translate('table_th_last_connect_course')#</small> ---></td>
                                            <td>
                                                <cfif last_view_date neq "">
                                                    <cfif SESSION.LANG_CODE eq "de">
                                                        #dateformat(last_view_date,'dd.mm.yyyy')#
                                                    <cfelse>
                                                        #dateformat(last_view_date,'dd/mm/yyyy')#
                                                    </cfif>
                                                <cfelse>-</cfif>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td width="40%"><i class="fa-light fa-lg fa-history"></i> <small>#obj_translater.get_translate('table_th_total_lms')#</small></td>
                                        
                                            <td>
                                                <cfif isdefined("SESSION.USER_ELAPSED") AND SESSION.USER_ELAPSED neq "">
                                                #obj_lms.get_format_hms(toformat="#SESSION.USER_ELAPSED#")#
                                                <cfelse>
                                                -
                                                </cfif>
                                            </td>
                                        </tr>
                                    </table>
                                    </cfoutput>
                            </div>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div class="col-sm-6 mb-4">
                        <div class="card">

                            <cfquery name="get_log_activity" datasource="#SESSION.BDDSOURCE#">
                                SELECT
                                    log_date
                                FROM
                                    logs
                                WHERE 
                                    user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="2030">
                                    AND from_id = <cfqueryparam cfsqltype="cf_sql_integer" value="2030">
                            </cfquery>
                            
                         
                            <div class="card-body">
                                <h5 class="card-title">User Log Activity</h5>
                                <ul class="list-group">
                                    <cfoutput query="get_log_activity">
                                        <li class="list-group-item">#DateFormat(log_date, "dd-mm-yyyy")#</li>
                                    </cfoutput>
                                </ul>
                            </div>
                            
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div class="col-sm-6 mb-4">
                        <div class="card">
                            <cfquery name="get_lesson_planned" datasource="#SESSION.BDDSOURCE#">
                                SELECT
                                    lesson_start
                                FROM
                                    lms_lesson2
                                WHERE 
                                    user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="28538">
                                    AND status_id =1
                            </cfquery>
                            <div class="card-body">
                                <h5 class="card-title">Lesson planned</h5>
                                <ul class="list-group">
                                    <cfoutput query="get_lesson_planned">
                                        <li class="list-group-item">#DateFormat(lesson_start, "dd-mm-yyyy")#</li>
                                    </cfoutput>
                                    <cfdump var="#get_lesson_planned#" >
                                </ul>
                            </div>
                        </div>
                    </div>
                                <!-- Card 5 -->
                    <div class="col-sm-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">User Connect Activity</h5>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th scope="col">Date Co</th>
                                            <th scope="col">Interval Since Last Co</th>
                                            <th scope="col">Rating</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <cfset prev_date_co = "">
                                        <cfset prev_day_no_co = 0>
                                        <cfset consecutive_days_co = 1>
                                        
                                        <cfoutput query="get_connect_intervals" group="connect_date">
                                            <cfset current_date_co = connect_date>
                                            <cfset current_day_no_co = datePart("d", current_date_co)>
                                      
                                            <cfif prev_date_co neq "" AND DateDiff("d", prev_date_co, current_date_co) eq 1>
                                                <cfset consecutive_days_co++>
                                            <cfelseif prev_date_co neq "" AND DateDiff("d", prev_date_co, current_date_co) gt 1>
                                                <cfset consecutive_days_co = 1>
                                            </cfif>
                                      
                                            <tr>
                                                <td>#dateformat(current_date_co, 'dd.mm.yyyy')#</td>
                                                <td>
                                                    <cfif connect_interval neq "" AND IsNumeric(connect_interval)>
                                                        #get_format_days(intervalInSeconds=val(connect_interval))#
                                                    <cfelse>
                                                        -
                                                    </cfif>
                                                </td>
                                                <td class="star-rating">
                                                    <cfif consecutive_days_co eq 2>
                                                        *
                                                    <cfelseif consecutive_days_co eq 3>
                                                        **
                                                    <cfelseif consecutive_days_co eq 4>
                                                        ***
                                                    <cfelseif consecutive_days_co eq 5>
                                                        ****
                                                    <cfelseif consecutive_days_co gte 6>
                                                        *****
                                                    </cfif>
                                                </td>
                                            </tr>
                                      
                                            <cfset prev_date_co = current_date_co>
                                            <cfset prev_day_no_co = current_day_no_co>
                                        </cfoutput>
                                    </tbody>
                                </table>
                                
                                
                                
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <cfinclude template="./incl/incl_footer.cfm">
    </div>
    <cfinclude template="./incl/incl_scripts.cfm">
    <cfinclude template="./incl/incl_scripts_vocab.cfm">
</body>
</html>
