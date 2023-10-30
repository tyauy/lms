<!------------FIRST DEFINE THE GROUP ID OF PTs------------------------->
<cfset quiz_user_group_id = get_quiz_id.quiz_user_group_id>
<cfset get_pt = obj_quiz_get.oget_pt(u_id="#u_id#",quiz_user_group_id="#quiz_user_group_id#",feedback=1)>

<!------------GET CODE PT FOR incl_pt_result.cfm ------------------------->
<cfif get_quiz_id.quiz_type eq "qpt_en">
	<cfset cor = "en">
<cfelseif get_quiz_id.quiz_type eq "qpt_de">
	<cfset cor = "de">
<cfelseif get_quiz_id.quiz_type eq "qpt_fr">
	<cfset cor = "fr">
<cfelseif get_quiz_id.quiz_type eq "qpt_es">
	<cfset cor = "es">
<cfelseif get_quiz_id.quiz_type eq "qpt_it">
	<cfset cor = "it">
<cfelseif get_quiz_id.quiz_type eq "qpt_pt">
	<cfset cor = "pt">
<cfelseif get_quiz_id.quiz_type eq "qpt_zh">
	<cfset cor = "zh">
<cfelseif get_quiz_id.quiz_type eq "qpt_ru">
	<cfset cor = "ru">
<cfelseif get_quiz_id.quiz_type eq "qpt_nl">
	<cfset cor = "nl">
</cfif>

<!------------GET PT GLOBAL RESULT------------------------->
<cfquery name="get_result_qpt" datasource="#SESSION.BDDSOURCE#">
SELECT qu.quiz_user_id, qu.quiz_success, qu.pt_type, q.quiz_id, q.quiz_alias, SUM(qr.ans_gain) as score
FROM lms_quiz_result qr
INNER JOIN lms_quiz_user qu ON qu.quiz_user_id = qr.quiz_user_id
INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
WHERE qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
GROUP BY qu.quiz_user_id
ORDER BY quiz_alias
</cfquery>

<!------------CHECK IF AT LEAST SOME RESULTS------------------------->
<cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
SELECT SUM(ans_gain) as score
FROM lms_quiz_result
WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
</cfquery>

<!------------BUILD LISTS------------------------->
<cfset list_qpt_result = "">
<cfset list_qpt_success = "">
<cfset list_qpt_id = "">
<cfset score_qpt = 0>
<cfset pt_type = get_result_qpt.pt_type>

<cfloop query="get_result_qpt">
	<cfset list_qpt_result = listappend(list_qpt_result,score)>
	<cfset list_qpt_success = listappend(list_qpt_success,quiz_success)>
	<cfif score neq "">
	<cfset score_qpt = score_qpt+score>
	<cfelse>
	<cfset score_qpt = score_qpt+0>
	</cfif>
	<cfset list_qpt_id = listappend(list_qpt_id,quiz_id)>
</cfloop>



<!------------DETERMINE LEVEL------------------------->
<cfif listlen(list_qpt_success) eq "1">
	<cfif listgetat(list_qpt_success,1) eq "1">				
	<cfelse>			
		<cfset block_level = "A0">					
	</cfif>
<cfelseif listlen(list_qpt_success) eq "2">
	<cfif listgetat(list_qpt_success,2) eq "1">				
	<cfelse>				
		<cfset block_level = "A1">				
	</cfif>
<cfelseif listlen(list_qpt_success) eq "3">
	<cfif listgetat(list_qpt_success,3) eq "1">				
	<cfelse>			
		<cfset block_level = "A2">				
	</cfif>
<cfelseif listlen(list_qpt_success) eq "4">
	<cfif listgetat(list_qpt_success,4) eq "1">				
	<cfelse>			
		<cfset block_level = "B1">				
	</cfif>
<cfelseif listlen(list_qpt_success) eq "5">
	<cfif listgetat(list_qpt_success,5) eq "0">			
		<cfset block_level = "B2">				
	<cfelseif listgetat(list_qpt_success,5) eq "1">				
		<cfset block_level = "C1">				
	<cfelse>				
		<cfset block_level = "C2">				
	</cfif>
</cfif>












<!------------GLOBAL RESULT DISPLAY------------------------->
<cfif isdefined("qpt_page") AND qpt_page eq "qpt_score">


	<!--- <h4 class="card-title d-inline"><cfoutput>#obj_translater.get_translate('card_eval_global_results')#</cfoutput></h4>								 --->
    <div class="table table-responsive-sm">
    <table class="table table-bordered mt-3">
        <tr>
            <th width="180" class="bg-light"><cfoutput>#obj_translater.get_translate('table_th_global_level')#</cfoutput></th>
            <td>
                <!--- <cfset get_pt = obj_query.oget_pt(u_id="#u_id#",quiz_user_group_id="#quiz_user_group_id#")>
                <cfset quiz_type = get_pt.quiz_type> --->
                <cfinclude template="../incl/incl_pt_result.cfm">

                <!--- <cfinclude template="../incl/incl_pt_result.cfm"> --->
            </td>
        </tr>
        <cfif isdefined("block_level")>
        <tr>
            <th class="bg-light"><cfoutput>#obj_translater.get_translate('table_th_analyse')#</cfoutput></th>
            <td>
                <!--- <ul>
                    <cfoutput>
                        <li>
                            #get_pt.general_feedback#
                        </li>
                        <li>
                            #get_pt.grammar_feedback#
                        </li>
                        <li>
                            #get_pt.reading_feedback#
                        </li>
                        <li>
                            #get_pt.listening_feedback#
                        </li>
                    </cfoutput>
                </ul> --->
                
                <cfoutput>
                <cfif block_level eq "A0">
                #obj_translater.get_translate_complex('ln_na_level_A0_list')#
                <cfelseif block_level eq "A1">
                #obj_translater.get_translate_complex('ln_na_level_A1_list')#
                <cfelseif block_level eq "A2">
                #obj_translater.get_translate_complex('ln_na_level_A2_list')#
                <cfelseif block_level eq "B1">
                #obj_translater.get_translate_complex('ln_na_level_B1_list')#
                <cfelseif block_level eq "B2">
                #obj_translater.get_translate_complex('ln_na_level_B2_list')#
                <cfelseif block_level eq "C1">
                #obj_translater.get_translate_complex('ln_na_level_C1_list')#
                <cfelseif block_level eq "C2">
                #obj_translater.get_translate_complex('ln_na_level_C2_list')#
                </cfif>
                </cfoutput>
                
            </td>
        </tr>
        </cfif>
        
    </table>
    </div>


<!------------ANALYSIS DISPLAY------------------------->
<cfelseif isdefined("qpt_page") AND qpt_page eq "qpt_analysis">

	<!------------------------ GET 5 GENERIC PTs --------------->
	<cfquery name="get_pt_list" datasource="#SESSION.BDDSOURCE#">
	SELECT q.quiz_id, q.quiz_short_name_#SESSION.LANG_CODE# as quiz_short_name, q.quiz_alias
	FROM lms_quiz q
	WHERE q.quiz_type = <cfqueryparam cfsqltype="cf_sql_varchar" value="qpt_#cor#">
	ORDER BY level_id
	</cfquery>

    <!--- <h4 class="card-title d-inline"><cfoutput>#obj_translater.get_translate('btn_results_test')#</cfoutput></h4>	 --->


	<!------------------------ TAB HEADER --------------->
	<ul class="nav nav-tabs mb-3 justify-content-center" id="pills-tab" role="tablist">
		<cfset counter = 0>
		<cfoutput query="get_pt_list">
			<li class="nav-item">
				<cfset counter ++>
				<cfif listlen(list_qpt_success) gte counter>
                    <a class="nav-link <cfif get_quiz_id.quiz_id eq get_pt_list.quiz_id>active</cfif>" id="tab_#quiz_id#" data-toggle="tab" href="##q_#quiz_id#" role="tab" aria-controls="q_#quiz_id#" aria-selected="<cfif get_quiz_id.quiz_id eq get_pt_list.quiz_id>true<cfelse>false</cfif>" style="font-size:16px">
						<cfif listlen(list_qpt_success) gte counter AND listgetat(list_qpt_success,counter) eq "1">
							<i class="fas fa-check-circle text-success"></i> #quiz_alias#
						<cfelse>
							<i class="fas fa-times-circle text-danger"></i> #quiz_alias#
						</cfif>
					</a>
				<cfelse>
					<a class="nav-link disabled" id="tab_#quiz_id#" data-toggle="tab" href="##q_#quiz_id#" role="tab" aria-controls="q_#quiz_id#" aria-selected="false" style="font-size:16px">
						#quiz_alias#
					</a>
				</cfif>
			</li>
		</cfoutput>
	</ul>


	<!------------------------ TAB CONTENT --------------->
	<div class="tab-content">
        <cfset counter2 = 0>        
		<cfloop query="get_pt_list">

            <cfset counter2 ++>

            <cfif listlen(list_qpt_success) gte counter2>

                <cfquery name="get_pt_solo" datasource="#SESSION.BDDSOURCE#">
                SELECT qu.quiz_user_id
                FROM lms_quiz_user qu
                INNER JOIN lms_quiz q ON q.quiz_id = qu.quiz_id
                WHERE qu.quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#"> 
                AND q.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_pt_list.quiz_id#">
                ORDER BY qu.quiz_user_end desc
                </cfquery>

                <!--- <cfdump var="#get_pt_solo#"> --->
                <cfset quiz_user_id = get_pt_solo.quiz_user_id>
            
                <cfquery name="get_question" datasource="#SESSION.BDDSOURCE#">
                SELECT qq.qu_id, qq.qu_text, qq.qu_header, qq.qu_category_id, qc.qu_ranking, qq.sessionmaster_id, qu_category, q.quiz_id, qu.user_id, qq.material_id, qcat.category_#SESSION.LANG_CODE# as category_name, q.quiz_alias, qu.quiz_success
                FROM lms_quiz_question qq
                INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
                INNER JOIN lms_quiz q ON q.quiz_id = qc.quiz_id
                INNER JOIN lms_quiz_user qu ON qu.quiz_id = q.quiz_id
                LEFT JOIN lms_quiz_category qcat ON qcat.category_id = qq.qu_category_id
                WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
                ORDER BY qc.qu_ranking ASC
                </cfquery>
            
                <cfquery name="get_result_score" datasource="#SESSION.BDDSOURCE#">
                SELECT SUM(ans_gain) as score
                FROM lms_quiz_result
                WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
                </cfquery>
            
                <cfquery name="get_quiz_score" datasource="#SESSION.BDDSOURCE#">
                SELECT SUM(ans_gain) as quiz_score
                FROM lms_quiz_answer a 
                INNER JOIN lms_quiz_question qq ON qq.qu_id = a.qu_id
                INNER JOIN lms_quiz_cor qc ON qq.qu_id = qc.qu_id
                WHERE qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_pt_list.quiz_id#">
                </cfquery>
            
                <cfif get_result_score.score neq "">
                    <cfset global_note = round((get_result_score.score/get_quiz_score.quiz_score)*100)>
                <cfelse>
                    <cfset global_note = "0">
                </cfif>
            
                <cfif get_question.quiz_success eq "1">
                    <cfset bg_badge = "success">
                <cfelse>
                    <cfset bg_badge = "danger">
                </cfif>
					
                <div class="tab-pane fade <cfif get_quiz_id.quiz_id eq get_pt_list.quiz_id>show active</cfif>" id="q_<cfoutput>#get_pt_list.quiz_id#</cfoutput>" role="tabpanel" aria-labelledby="tab_<cfoutput>#get_pt_list.quiz_id#</cfoutput>">



                    
                    <cfoutput>  
                        <cfif (listlen(list_qpt_success) eq "1" AND listgetat(list_qpt_success,1) eq "1")
                        OR (listlen(list_qpt_success) eq "2" AND listgetat(list_qpt_success,2) eq "1")
                        OR (listlen(list_qpt_success) eq "3" AND listgetat(list_qpt_success,3) eq "1")
                        OR (listlen(list_qpt_success) eq "4" AND listgetat(list_qpt_success,4) eq "1")>

                            <div class="row justify-content-center mt-5">
                                <div class="col-lg-10">		
                                    <div class="card border border-info no-shadow" align="center">
                                        <div class="card-body" align="center">                  
                                            <cfif listlen(list_qpt_success) eq "1">
                                                <cfif listgetat(list_qpt_success,1) eq "1">
                                                    <cfif cor eq "en">
                                                        <cfset nextquiz_id = "17">
                                                    <cfelseif cor eq "de">
                                                        <cfset nextquiz_id = "1565">
                                                    <cfelseif cor eq "fr">
                                                        <cfset nextquiz_id = "1606">
                                                    <cfelseif cor eq "es">
                                                        <cfset nextquiz_id = "1613">
                                                    <cfelseif cor eq "pt">
                                                        <cfset nextquiz_id = "1628">
                                                    <cfelseif cor eq "it">
                                                        <cfset nextquiz_id = "1761">
                                                    <cfelseif cor eq "ru">
                                                        <cfset nextquiz_id = "1723">
                                                    <cfelseif cor eq "zh">
                                                        <cfset nextquiz_id = "1728">
                                                    <cfelseif cor eq "nl">
                                                        <cfset nextquiz_id = "1751">
                                                    </cfif>
                                                    #obj_translater.get_translate_complex('pt_not_finished')#
                                                    <br><br>
                                                    <!--- <cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
                                                    <form action="quiz.cfm" method="post">
                                                        <cfif isdefined("SESSION.TP_ID")>
                                                            <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                                                        </cfif>
                                                        <input type="hidden" name="pt_speed" value="fpt">
                                                        <input type="hidden" name="pt_type" value="#pt_type#">
                                                        <input type="hidden" name="quiz_user_group_id" value="#quiz_user_group_id#">
                                                        <input type="hidden" name="quiz_id" value="#nextquiz_id#">
                                                        <input type="hidden" name="new_quiz" value="1">
                                                        <button type="submit" class="btn btn-lg btn-info">#obj_translater.get_translate('btn_continue')#  (TEST A2) <i class="fad fa-arrow-right"></i></button>
                                                    </form>
                                                    <!--- </cfif> --->
                                
                                                </cfif>
                                            <cfelseif listlen(list_qpt_success) eq "2">
                                                <cfif listgetat(list_qpt_success,2) eq "1">
                                                    <cfif cor eq "en">
                                                        <cfset nextquiz_id = "9">
                                                    <cfelseif cor eq "de">
                                                        <cfset nextquiz_id = "1566">
                                                    <cfelseif cor eq "fr">
                                                        <cfset nextquiz_id = "1607">
                                                    <cfelseif cor eq "es">
                                                        <cfset nextquiz_id = "1614">
                                                    <cfelseif cor eq "pt">
                                                        <cfset nextquiz_id = "1629">
                                                    <cfelseif cor eq "it">
                                                        <cfset nextquiz_id = "1762">
                                                    <cfelseif cor eq "ru">
                                                        <cfset nextquiz_id = "1724">
                                                    <cfelseif cor eq "zh">
                                                        <cfset nextquiz_id = "1729">
                                                    <cfelseif cor eq "nl">
                                                        <cfset nextquiz_id = "1764">
                                                    </cfif>
                                                    
                                                    #obj_translater.get_translate_complex('pt_not_finished')#
                                                    <br><br>
                                                    <!--- <cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
                                                    <form action="quiz.cfm" method="post">
                                                        <cfif isdefined("SESSION.TP_ID")>
                                                            <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                                                        </cfif>
                                                        <input type="hidden" name="pt_speed" value="fpt">
                                                        <input type="hidden" name="pt_type" value="#pt_type#">
                                                        <input type="hidden" name="quiz_user_group_id" value="#quiz_user_group_id#">
                                                        <input type="hidden" name="quiz_id" value="#nextquiz_id#">
                                                        <input type="hidden" name="new_quiz" value="1">
                                                        <button type="submit" class="btn btn-lg btn-info">#obj_translater.get_translate('btn_continue')#  (TEST B1) <i class="fad fa-arrow-right"></i></button>
                                                    </form>
                                                    <!--- </cfif> --->
                                                </cfif>
                                            <cfelseif listlen(list_qpt_success) eq "3">
                                                <cfif listgetat(list_qpt_success,3) eq "1">
                                                    <cfif cor eq "en">
                                                        <cfset nextquiz_id = "18">
                                                    <cfelseif cor eq "de">
                                                        <cfset nextquiz_id = "1567">
                                                    <cfelseif cor eq "fr">
                                                        <cfset nextquiz_id = "1608">
                                                    <cfelseif cor eq "es">
                                                        <cfset nextquiz_id = "1615">
                                                    <cfelseif cor eq "pt">
                                                        <cfset nextquiz_id = "1630">
                                                    <cfelseif cor eq "it">
                                                        <cfset nextquiz_id = "1763">
                                                    <cfelseif cor eq "ru">
                                                        <cfset nextquiz_id = "1725">
                                                    <cfelseif cor eq "zh">
                                                        <cfset nextquiz_id = "1730">
                                                    <cfelseif cor eq "nl">
                                                        <cfset nextquiz_id = "1753">
                                                    </cfif>
                                                    
                                                    #obj_translater.get_translate_complex('pt_not_finished')#
                                                    <br><br>
                                                    <!--- <cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
                                                    <form action="quiz.cfm" method="post">
                                                        <cfif isdefined("SESSION.TP_ID")>
                                                            <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                                                        </cfif>
                                                        <input type="hidden" name="pt_speed" value="fpt">
                                                        <input type="hidden" name="pt_type" value="#pt_type#">
                                                        <input type="hidden" name="quiz_user_group_id" value="#quiz_user_group_id#">
                                                        <input type="hidden" name="quiz_id" value="#nextquiz_id#">
                                                        <input type="hidden" name="new_quiz" value="1">
                                                        <button type="submit" class="btn btn-lg btn-info">#obj_translater.get_translate('btn_continue')#  (TEST B2) <i class="fad fa-arrow-right"></i></button>
                                                    </form>
                                                    <!--- </cfif> --->
                                                </cfif>
                                            <cfelseif listlen(list_qpt_success) eq "4">
                                                <cfif listgetat(list_qpt_success,4) eq "1">
                                                    <cfif cor eq "en">
                                                        <cfset nextquiz_id = "10">
                                                    <cfelseif cor eq "de">
                                                        <cfset nextquiz_id = "1568">
                                                    <cfelseif cor eq "fr">
                                                        <cfset nextquiz_id = "1609">
                                                    <cfelseif cor eq "es">
                                                        <cfset nextquiz_id = "1616">
                                                    <cfelseif cor eq "pt">
                                                        <cfset nextquiz_id = "1631">
                                                    <cfelseif cor eq "it">
                                                        <cfset nextquiz_id = "1764">
                                                    <cfelseif cor eq "ru">
                                                        <cfset nextquiz_id = "1726">
                                                    <cfelseif cor eq "zh">
                                                        <cfset nextquiz_id = "1731">
                                                    <cfelseif cor eq "nl">
                                                        <cfset nextquiz_id = "1754">
                                                    </cfif>
                                                    
                                                    #obj_translater.get_translate_complex('pt_not_finished')#
                                                    <br><br>
                                                    <!--- <cfif not listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)> --->
                                                    <form action="quiz.cfm" method="post">
                                                        <cfif isdefined("SESSION.TP_ID")>
                                                            <input type="hidden" name="tp_id" value="#SESSION.TP_ID#">
                                                        </cfif>
                                                        <input type="hidden" name="pt_speed" value="fpt">
                                                        <input type="hidden" name="pt_type" value="#pt_type#">
                                                        <input type="hidden" name="quiz_user_group_id" value="#quiz_user_group_id#">
                                                        <input type="hidden" name="quiz_id" value="#nextquiz_id#">
                                                        <input type="hidden" name="new_quiz" value="1">
                                                        <button type="submit" class="btn btn-lg btn-info">#obj_translater.get_translate('btn_continue')#  (TEST C1) <i class="fad fa-arrow-right"></i></button>
                                                    </form>
                                                    <!--- </cfif> --->
                                                </cfif>
                                            </cfif>	
                                        </div>		
                                    </div>
                                </div>
                            </div>
                        </cfif>    			
                    </cfoutput>






				    
                    <table class="table table-bordered mt-3">
                        <tr>
                            <th class="bg-light" width="180">
                                <cfoutput>#obj_translater.get_translate('table_th_score')#</cfoutput>
                            </th>
                            <td>
                                <cfoutput>                                         
                                    #obj_translater.get_translate_complex('show_score_pt')# <span class="badge badge-pill badge-#bg_badge# h5 m-0">#global_note#%</span>
                                </cfoutput>
                            </td>
                        </tr>
                        <tr>										
                            <th class="bg-light" width="180">
                                <cfoutput>#obj_translater.get_translate('table_th_repartition_short')#</cfoutput>
                            </th>
                            <td>
                                <cfset show_result = "chart_progress">
                                <cfinclude template="./incl_pt_answer.cfm">
                            </td>
                        </tr>
                    </table>

					
					<cfset show_result = "answer_analysis">
					<cfinclude template="./incl_pt_answer.cfm">

			    </div>
            
            </cfif>

		</cfloop>
	</div>	
	
</cfif>