<cfsilent>

	<!------ INITIALIZE NEW QUIZ -------->
	<cfif isdefined("quiz_id") AND isdefined("new_quiz")>

		<cfif isdefined("del_quiz")>
			<cfset temp = obj_lms.remove_quiz_results(quiz_id="#quiz_id#",u_id="#SESSION.USER_ID#")>
		</cfif>
		
		<cfquery name="get_current" datasource="#SESSION.BDDSOURCE#">
		SELECT qq.qu_id FROM lms_quiz_question qq
		INNER JOIN lms_quiz_cor qc ON qc.qu_id = qq.qu_id
		WHERE qc.qu_ranking = 1 AND qc.quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
		</cfquery>

		<cfquery name="quiz_ins" datasource="#SESSION.BDDSOURCE#" result="insert_quiz">
		INSERT INTO lms_quiz_user (
		user_id,
		quiz_id,
		quiz_user_start,
		current_qu_id,
		current_visited
		<cfif isdefined("tp_id")>
		, tp_id
		</cfif>
		<cfif isdefined("pt_type")>
		, pt_type
		</cfif>
		<cfif isdefined("pt_speed")>
		, pt_speed
		</cfif>
		<cfif isdefined("quiz_user_group_id")>
		, quiz_user_group_id
		</cfif>
		)
		VALUES
		(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">,
		<cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#get_current.qu_id#">,
		0
		<cfif isdefined("tp_id")>
		, <cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">
		</cfif>
		<cfif isdefined("pt_type")>
		, <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
		</cfif>
		<cfif isdefined("pt_speed")>
		, <cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_speed#">
		</cfif>
		<cfif isdefined("quiz_user_group_id")>
		, <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_group_id#">
		</cfif>
		)
		</cfquery>

		<!--- <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
		SELECT MAX(quiz_user_id) as id FROM lms_quiz_user
		</cfquery> --->

		<cfset quiz_user_id = insert_quiz.generatedkey>
		<cfset current_qu = insert_quiz.generatedkey>

		<cfif not isdefined("quiz_user_group_id")>
			<cfquery name="updt_quiz" datasource="#SESSION.BDDSOURCE#">
				UPDATE lms_quiz_user SET quiz_user_group_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> WHERE quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">
			</cfquery>

			<cfquery name="get_formation" datasource="#SESSION.BDDSOURCE#">
				SELECT quiz_formation_id FROM lms_quiz WHERE quiz_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_id#">
			</cfquery>

			<!--- TODO mettre  quiz_formation_id,  --->
			<cfquery name="quiz_ins" datasource="#SESSION.BDDSOURCE#" result="insert_quiz">
				INSERT INTO lms_quiz_user_score (
				quiz_user_group_id,
				quiz_formation_id,
				user_id
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#get_formation.quiz_formation_id#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
				)
			</cfquery>

			<cfif isdefined("tp_id") AND isdefined("pt_type")>
				<cfquery name="updt" datasource="#SESSION.BDDSOURCE#">
					INSERT INTO `lms_quiz_user_tp`(`tp_id`, `quiz_user_group_id`, `type`) 
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_integer" value="#tp_id#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#pt_type#">
						)
				</cfquery>
			</cfif>
			
		</cfif>

	</cfif>

	<cfquery name="get_quiz" datasource="#SESSION.BDDSOURCE#">
        SELECT q.quiz_id, q.quiz_type, q.quiz_name, qu.current_qu_id, qu.current_visited, qu.quiz_user_start,
		(SELECT COUNT(qu_id) AS lms_quiz_question FROM lms_quiz_cor WHERE quiz_id = q.quiz_id) as quiz_nbqu
        FROM lms_quiz_user qu 
        INNER JOIN lms_quiz q ON qu.quiz_id = q.quiz_id
        WHERE qu.quiz_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#quiz_user_id#"> AND qu.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
    </cfquery>
	
	<cfset global_timer = dateDiff("n",  get_quiz.quiz_user_start, now())>
</cfsilent>

			


<!-------- ADD A NO ANSWER ALERT ------------>
<!--- <div id="window_item" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal-title-sm" class="modal-title"><cfoutput>#obj_translater.get_translate('alert_warning')#</cfoutput></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal-body-sm" class="modal-body">
			<cfoutput>#obj_translater.get_translate('alert_no_answer')#</cfoutput>
			</div>
        </div>
    </div>
</div> --->
    <div id="quiz_container_play_test">
        <!--- <cfinclude template="/incl/incl_quiz_play.cfm"> --->
    </div>



<script>
$(document).ready(function() {
	
	for(i=0; i<100; i++)
	{
		window.clearInterval(i);
	}

    var counter_global = <cfoutput>#global_timer#</cfoutput>;
    var w_bar_global = 100;
    var w_second_global = 100/counter_global;
	<cfoutput>
    var interval_global_#quiz_user_id# = setInterval(function() {
        counter_global--;	
        w_bar_global = w_bar_global-w_second_global;
        jQuery('##countdown_global_#quiz_user_id# ##sec_global_#quiz_user_id#').html(counter_global);
        $("##p_bar_global_#quiz_user_id#").css("width",w_bar_global+"%")
        if (counter_global == 0) {
            clearInterval(interval_global_#quiz_user_id#);
            ok_submit_global = -1;
            $("##question").submit();
            $('##send_go').prop("disabled",true);
        }
    }, 1000);
	</cfoutput>


    load_quiz(<cfoutput>#quiz_user_id#</cfoutput>, 0, 1)

    
    function load_quiz(quiz_user_id, end_quiz, init) {

        // console.log("yo2_", quiz_user_id)

        if (end_quiz) {
            $('#quiz_container_play_test').empty();	
            $('#quiz_container_play_test').load("modal_window_quiz.cfm?quiz_user_id="+quiz_user_id+"&init="+init+"&u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>", function() {
                $("#<cfoutput>question</cfoutput>").off("submit");
                $("#<cfoutput>question</cfoutput>").bind("submit",handler_submit_quiz);
            });
        } else{
            $('#quiz_container_play_test').empty();	
            $('#quiz_container_play_test').load("./incl/incl_quiz_play.cfm?window_origin=div&quiz_user_id="+quiz_user_id, function() {
                $("#question").off("submit");
                $("#question").bind("submit",handler_submit_quiz);
            });
        }
       
    }


        
    var handler_submit_quiz = function(event) {	
        event.preventDefault();
		console.log($(this).serialize());
        $.ajax({				 
            url: './api/quiz/quiz_post.cfc?method=quiz_work',
            type: "POST",
            data:$(this).serialize(),
            datatype : "html",
            success : function(result, statut){
                // console.log(result);
    
                
                var result = $.parseJSON(result);
                // clearInterval(interval);
                // console.log(result["QUIZ_USER_ID"]);
                var quiz_user_id = result["QUIZ_USER_ID"];
                
                if(result.hasOwnProperty("end_quiz"))
                {
                    load_quiz(quiz_user_id, 1, 0)
                }
                else
                {
                    load_quiz(quiz_user_id, 0, 0)
                }
    
                
               
            }
        });
    };
});
</script>


	
	
</body>
</html>