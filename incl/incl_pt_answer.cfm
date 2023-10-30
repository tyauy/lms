<cfif isdefined("show_result") AND show_result eq "answer_analysis">
    <div class="table table-responsive-sm">


        <table class="table table-sm">
            <tr class="bg-light">
                <th>
                <cfoutput>#obj_translater.get_translate('table_th_num')#</cfoutput>
                </th>
                <th>
                <cfoutput>#obj_translater.get_translate('table_th_competence')#</cfoutput>
                </th>
                <th>
                <cfoutput>#obj_translater.get_translate('table_th_question')#</cfoutput>
                </th>
                <th width="40%">
                <cfoutput>#obj_translater.get_translate('table_th_answer_analyse')#</cfoutput>
                </th>
            </tr>
            <cfset counter = 0>
            <cfloop query="get_question">
            <cfset counter ++>
            <cfif counter/2 eq round(counter/2)><cfset color_tr = "F2F2F2"><cfelse><cfset color_tr = "FFFFFF"></cfif>
            <tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
                <!---<td><cfoutput>#get_question.qu_id#</cfoutput></td>--->
                <td><cfoutput>#get_question.qu_ranking#</cfoutput></td>
                <td>
                    <cfoutput>
                    <cfif get_question.qu_category_id eq 1>
                        <i class="fal fa-spell-check" title="#get_question.category_name#"></i>
                    <cfelseif get_question.qu_category_id eq 2>
                        <i class="fal fa-book-open" title="#get_question.category_name#"></i>
                    <cfelseif get_question.qu_category_id eq 3>
                        <i class="fal fa-books fa-lg" aria-hidden="true" title="#get_question.category_name#"></i>
                    <cfelseif get_question.qu_category_id eq 4>
                        <i class="fal fa-head-side-headphones fa-lg" aria-hidden="true" title="#get_question.category_name#"></i>
                    <cfelseif get_question.qu_category_id eq 5>
                        <i class="fal fa-books fa-lg" aria-hidden="true" title="#get_question.category_name#"></i>
                    </cfif>
                    </cfoutput>
                </td>
                <td>
                    
                
                    
                <cfif get_question.material_id neq "">
    
                    <cfoutput>
                    <cfloop list="#get_question.material_id#" index="cor">
                        <cfquery name="get_material" datasource="#SESSION.BDDSOURCE#">
                        SELECT ma.material_url, ma.material_type FROM lms_material ma WHERE material_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#cor#"> 
                        </cfquery>
                        
                        <cfif get_material.material_type eq "image">
                            <p>
                                <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#">
                            </p>
                        <cfelseif get_material.material_type eq "audio">
                            <p>
                            <audio controls="controls">
                              <source src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#" type="audio/mp3" />
                              #obj_translater.get_translate('alert_not_compatible')#
                            </audio>
                            </p>
                        <cfelse>
                        
                            <cfif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.jpg")>
                            <p>
                                <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.jpg">
                            </p>
                            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.png")>
                            <p>
                                <img src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.png">
                            </p>
                            <cfelseif fileexists("#SESSION.BO_ROOT#/assets/materials/#get_material.material_url#.mp3")>
                            <p>
                            <audio controls="controls">
                              <source src="#SESSION.BO_ROOT_URL#/assets/materials/#get_material.material_url#.mp3" type="audio/mp3" />
                              #obj_translater.get_translate('alert_not_compatible')#
                            </audio>
                            </p>
                            </cfif>
                        
                        </cfif>
                    </cfloop>
                    </cfoutput>
                    </cfif>	
                    
                <cfoutput>
                
                <cfif get_question.qu_text neq "">
                <div class="border pt-2 pr-2 pl-2">#get_question.qu_text#</div>
                <br>
                </cfif>
                <cfif get_question.qu_header neq "">
                #get_question.qu_header#
                </cfif> 
                </cfoutput>
                
                </td>
                <td>
    
                <cfquery name="get_sub" datasource="#SESSION.BDDSOURCE#">
                SELECT COUNT(DISTINCT(sub_id)) as nbsub
                FROM lms_quiz_answer
                WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#">
                </cfquery>
                
                    <table class="table table-bordered table-sm">
                    <cfloop from="1" to="#get_sub.nbsub#" index="sub_id">	
                        <tr bgcolor="<cfoutput>###color_tr#"</cfoutput>">
                        
                            <cfquery name="get_result" datasource="#SESSION.BDDSOURCE#">
                            SELECT lqr.ans_text, lqr.iscorrect, lqa.ans_text as ans_given, lqr.ans_gain, lqa.ans_flag
                            FROM lms_quiz_result lqr
                            LEFT JOIN lms_quiz_answer lqa ON lqa.ans_id = lqr.ans_id
                            WHERE lqr.qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND lqr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> <!---AND lqr.sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">---> ORDER BY result_id
                            </cfquery>
                            
                            <td width="40%">
                                <!--- <cfdump var="#get_result#"> --->
                            <small><span class="label label-success"><cfoutput>#obj_translater.get_translate('table_th_your_answer')#</cfoutput></span></small><br>
                            <cfoutput query="get_result">
                            <cfif iscorrect eq "1"><i class="fad fa-check-circle" style="color:##1ca823"></i><cfelse><i class="fad fa-minus-circle" style="color:##FF0000"></i></cfif> #ans_text# #ans_given#
                            <br></cfoutput>
                            </td>
                            
                            <cfquery name="get_answer" datasource="#SESSION.BDDSOURCE#">
                            SELECT ans_text, sub_id
                            FROM lms_quiz_answer
                            WHERE qu_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qu_id#"> AND ans_iscorrect = "1" AND sub_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#sub_id#">
                            </cfquery>
                            
                            <td width="50%">
                                
                            <small><span class="label label-success"><cfoutput>#obj_translater.get_translate('table_th_good_answer')#</cfoutput></span></small><br>
                            <cfset list_ok = "">
                            <cfoutput query="get_answer">
                            <cfset list_ok = listappend(list_ok," #ans_text# ","/")>
                            </cfoutput>
                            <cfoutput><i class="fad fa-check"></i> #list_ok#</cfoutput>
                            </td>

                        </tr>
                    
                    </cfloop>	
                    </table>
                
                </td>
                <!---<td>
                <cfif sessionmaster_id neq "">
                <cfquery name="get_session_suggest" datasource="#SESSION.BDDSOURCE#">
                SELECT sessionmaster_id, sessionmaster_name FROM lms_tpsessionmaster s WHERE sessionmaster_id IN (#get_question.sessionmaster_id#) 
                </cfquery>
                <cfoutput query="get_session_suggest">
                <a href="" class="btn btn-xs btn-default">#sessionmaster_name#</a>
                </cfoutput>
                </cfif>
                    
                </td>--->
            </tr>
            </cfloop>
        </table>
        </div>
        
    <cfelseif isdefined("show_result") AND show_result eq "chart">
    
        <cfoutput><canvas id="pt_result_#get_quiz_id.quiz_id#"></canvas></cfoutput>


        <cfquery name="get_max_score" datasource="#SESSION.BDDSOURCE#">
        SELECT qq.qu_category, qq.qu_category_id, SUM(ans_gain) as total_max_score FROM lms_quiz_answer qa
        INNER JOIN lms_quiz_question qq ON qq.qu_id = qa.qu_id
        INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
        WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#">
        GROUP BY qu_category_id
        ORDER BY qu_category_id
        </cfquery>
    
        <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
        SELECT qq.qu_category_id, SUM(ans_gain) as total_quiz_score FROM lms_quiz_result qr
        INNER JOIN lms_quiz_question qq ON qq.qu_id = qr.qu_id
        INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
        WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_quiz_id.quiz_id#"> AND qr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#isdefined("get_quiz_id.quiz_user_id") ? get_quiz_id.quiz_user_id : quiz_user_id#">
        GROUP BY qu_category_id
        ORDER BY qu_category_id
        </cfquery>
    
        <cfset list_max_score = "">
        <cfset list_quiz_score = "">
        <cfset list_quiz_maxfinal = "">
    
        <cfoutput query="get_max_score">
    
            <cfset list_max_score = listappend(list_max_score,total_max_score)>
            
        </cfoutput>
    
        <cfoutput query="get_quiz_score">
    
            <cfset valgo = listgetat(list_max_score,currentrow)>
            <!---<cfset temp = valgo-total_quiz_score>--->
            <cfif total_quiz_score neq "" AND total_quiz_score neq "0">
                <cfset temp2 = round((total_quiz_score/valgo)*100)>
                <cfset temp3 = 100-temp2>
            <cfelse>
                <cfset temp2 = 0>
                <cfset temp3 = 100>
            </cfif>
            
            
            <!---<cfset list_quiz_score = listappend(list_quiz_score,total_quiz_score)>
            <cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp)>--->
            <cfset list_quiz_score = listappend(list_quiz_score,temp2)>
            <cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp3)>
            
        </cfoutput>
    <!--- <cfoutput>total_quiz_score = #list_quiz_score#	</cfoutput> --->
    
        <script>
    
            <cfoutput>var barChartData_#get_quiz_id.quiz_id# = {</cfoutput>
            labels: [
            <cfoutput query="get_max_score">
            <cfif qu_category_id eq 1>
                <cfif listlen(list_quiz_score) gte currentrow>'#obj_translater.get_translate('js_grammar')# (#listgetat(list_quiz_score,currentrow)#%)',</cfif>
            <cfelseif qu_category_id eq 4>
                <cfif listlen(list_quiz_score) gte currentrow>'#obj_translater.get_translate('js_oral')# (#listgetat(list_quiz_score,currentrow)#%)',</cfif>
            <cfelseif qu_category_id eq 3>
                <cfif listlen(list_quiz_score) gte currentrow>'#obj_translater.get_translate('js_writing')# (#listgetat(list_quiz_score,currentrow)#%)',</cfif>
            <cfelseif qu_category_id eq 2>
                <cfif listlen(list_quiz_score) gte currentrow>'#obj_translater.get_translate('js_vocabulary')# (#listgetat(list_quiz_score,currentrow)#%)',</cfif>
            <cfelseif qu_category_id eq 5>
                <cfif listlen(list_quiz_score) gte currentrow>'#obj_translater.get_translate('js_comprehension')# (#listgetat(list_quiz_score,currentrow)#%)',</cfif>
            </cfif>
            </cfoutput>],
            datasets: [{
                label: 'Dataset 1',
                backgroundColor: '#6BD097',
                stack: 'Stack 0',
                data: [
                    <cfoutput>#list_quiz_score#</cfoutput>
                ]
            }, {
                label: 'Dataset 2',
                backgroundColor: '#EF8158',
                stack: 'Stack 0',
                data: [
                    <cfoutput>#list_quiz_maxfinal#</cfoutput>
                ]
            }]
        };
        <cfoutput>var go_bar_#get_quiz_id.quiz_id# = new Chart(pt_result_#get_quiz_id.quiz_id#, {</cfoutput>
            type: 'horizontalBar',
            data: <cfoutput>barChartData_#get_quiz_id.quiz_id#</cfoutput>,
            options: {
                title: {
                    /*display: true,
                    text: 'R\351partition par comp\351tence'*/
                },
                tooltips: {
                    mode: 'index',
                    intersect: false
                },
                responsive: true,
                scales: {
                    xAxes: [{
                        stacked: true,
                    }],
                    yAxes: [{
                        stacked: true
                    }]
                },
                legend: {
                    display:false
                }
                }
            });
        </script>

    <cfelseif isdefined("show_result") AND show_result eq "chart_progress">

        <cfquery name="get_max_score" datasource="#SESSION.BDDSOURCE#">
        SELECT qq.qu_category, qq.qu_category_id, SUM(ans_gain) as total_max_score FROM lms_quiz_answer qa
        INNER JOIN lms_quiz_question qq ON qq.qu_id = qa.qu_id
        INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
        WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#isdefined("get_quiz_id.quiz_id") ? get_quiz_id.quiz_id : quiz_id#">
        GROUP BY qu_category_id
        ORDER BY qu_category_id
        </cfquery>
    
        <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
        SELECT qq.qu_category_id, SUM(ans_gain) as total_quiz_score FROM lms_quiz_result qr
        INNER JOIN lms_quiz_question qq ON qq.qu_id = qr.qu_id
        INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
        WHERE qr.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#isdefined("get_quiz_id.quiz_user_id") ? get_quiz_id.quiz_user_id : quiz_user_id#">
        GROUP BY qu_category_id
        ORDER BY qu_category_id
        </cfquery>
    
        <!--- <cfdump var="#get_quiz_score#"> --->
        <cfset list_max_score = "">
        <cfset list_quiz_score = "">
        <cfset list_quiz_maxfinal = "">
    
        <cfoutput query="get_max_score">    
            <cfset list_max_score = listappend(list_max_score,total_max_score)>            
        </cfoutput>
    
        <!--- <cfoutput> list_max_score -- #list_max_score#</cfoutput> --->

        <cfoutput query="get_quiz_score">
    
            <cfset valgo = listgetat(list_max_score,currentrow)>
            <!---<cfset temp = valgo-total_quiz_score>--->
            <cfif total_quiz_score neq "" AND total_quiz_score neq "0">
                <cfset temp2 = round((total_quiz_score/valgo)*100)>
                <cfset temp3 = 100-temp2>
            <cfelse>
                <cfset temp2 = 0>
                <cfset temp3 = 100>
            </cfif>
            
            
            <!---<cfset list_quiz_score = listappend(list_quiz_score,total_quiz_score)>
            <cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp)>--->
            <cfset list_quiz_score = listappend(list_quiz_score,temp2)>
            <cfset list_quiz_maxfinal = listappend(list_quiz_maxfinal,temp3)>
            
        </cfoutput>
        
        <!--- <cfoutput> list_quiz_score -- #list_quiz_score#</cfoutput>
        <cfoutput> list_quiz_maxfinal -- #list_quiz_maxfinal#</cfoutput>
        <cfoutput>quiz_user_id - #quiz_user_id#</cfoutput> --->

         <table style="min-width:600px">
            <cfoutput query="get_max_score">
            <cfif listlen(list_quiz_score) gte currentrow> 
            <tr>
                <td width="250">
                    <cfif qu_category_id eq 1>
                        #obj_translater.get_translate('js_grammar')# (#listgetat(list_quiz_score,currentrow)#%)
                    <cfelseif qu_category_id eq 4>
                        #obj_translater.get_translate('js_oral')# (#listgetat(list_quiz_score,currentrow)#%)
                    <cfelseif qu_category_id eq 3>
                        #obj_translater.get_translate('js_writing')# (#listgetat(list_quiz_score,currentrow)#%)
                    <cfelseif qu_category_id eq 2>
                        #obj_translater.get_translate('js_vocabulary')# (#listgetat(list_quiz_score,currentrow)#%)
                    <cfelseif qu_category_id eq 5>
                        #obj_translater.get_translate('js_comprehension')# (#listgetat(list_quiz_score,currentrow)#%)
                    </cfif>
                </td>
                <td width="350">

                    <div class="progress">
                    <div class="progress-bar bg-success" role="progressbar" style="width:#listgetat(list_quiz_score,currentrow)#%" aria-valuenow="#listgetat(list_quiz_score,currentrow)#" aria-valuemin="0" aria-valuemax="100"></div>
                    <!--- <div class="progress-bar bg-secondary" role="progressbar" style="width:#100-listgetat(list_quiz_score,currentrow)#%" aria-valuenow="#100-listgetat(list_quiz_score,currentrow)#" aria-valuemin="0" aria-valuemax="100"></div> --->
                    </div>


                </td>
            </tr>
            </cfif>
        </cfoutput>
    </table>    
        

            
    </cfif>