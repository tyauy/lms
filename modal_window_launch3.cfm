<cfset u_id = SESSION.USER_ID>
<cfset t_id = SESSION.TP_ID>

<cfset step = "0">

<cfsilent>
	<cfinclude template="./incl/incl_trainer_list.cfm">
</cfsilent>

<cfset tmp_list = "#listgetat(t_list,1)#,#listgetat(t_list,2)#,#listgetat(t_list,3)#">

<cfset get_planner = obj_user_get.oget_planner(p_list="#tmp_list#")>

<cfset get_trainer = obj_tp_get.oget_tp_trainer(t_id="#t_id#")>

<cfquery name="get_tp_trainer" datasource="#SESSION.BDDSOURCE#">
	SELECT t.tp_id
	FROM lms_tp t 
	inner join lms_tpplanner tpp on tpp.tp_id = t.tp_id AND tpp.active = 1
	WHERE t.tp_id =  <cfqueryparam cfsqltype="cf_sql_integer" value="#t_id#">
</cfquery>


<div>

	<div>
		<img src="./assets/img/header_modal_8.jpg" class="header_rounded_top border-bottom-2 border-red" width="100%">
	</div>

	<div class="p-3">
                
		<h5><cfoutput>#obj_translater.get_translate_complex('alert_launch_title_step_3')#</cfoutput></h5>
		
		<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_step_3')#</cfoutput>

		<!--- <br>


		<div class="media">
			<img class="mr-3 img_rounded" src="./assets/img/lst_kinesthetic.jpg" width="200">
			<div class="media-body">
				<h5 class="mt-0"><cfoutput>#obj_translater.get_translate_complex('alert_launch_title_step_3')#</cfoutput></h5>
				<cfoutput>#obj_translater.get_translate_complex('alert_launch_text_step_3')#</cfoutput>
			</div>
		</div>	 --->

		<div align="center" class="mt-3">
			<cfoutput>
			<div class="row justify-content-center">
				<div class="col-md-12">

					<div class="d-block badge badge-pill border bg-light p-2 pl-0 pr-4 font-weight-normal" style="font-size:100% !important">
						<div class="d-flex justify-content-between">
							<div>
								<img src="./assets/img/<cfif randrange(1,2) eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" width="40">
								<img src="./assets/img/<cfif randrange(1,2) eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" width="40">
								<img src="./assets/img/<cfif randrange(1,2) eq "1">unknown_female.png<cfelse>unknown_male.png</cfif>" width="40">
							</div>
							<div>
								<strong>#obj_translater.get_translate('btn_choose_trainer')#</strong>
								<div class="mt-1">
									#obj_translater.get_translate('limit_trainer_max')#
								</div>
							</div>
							<div class="ml-2">
								<button class="btn btn-block btn-sm btn-info btn_add_trainer mb-0">#obj_translater.get_translate('btn_ichoose')#</button>
							</div>
						</div>
					</div>
				
					<!--- <cfif get_tp_trainer.recordCount eq 0>
					<div class="d-block badge badge-pill border bg-light mt-4 p-2 pl-0 pr-4 font-weight-normal" style="font-size:100% !important">
						<div class="d-flex justify-content-between">
							<div>

								<cfloop query="get_planner">
									#obj_lms.get_thumb(user_id="#get_planner.user_id#",size="40",responsive="yes")#
								</cfloop>
							
							</div>
							<div>
								<strong>#obj_translater.get_translate('btn_whotochoose')#</strong>
								
								<div class="mt-1">
									#obj_translater.get_translate('limit_trainer_choose')#
								</div>
							</div>
							<div class="ml-2">
								<button class="btn btn-block btn-sm btn-info btn_whotochoose mb-0">#obj_translater.get_translate('btn_choose_auto')#</button>
							</div>
						</div>
					</div>
					</cfif> --->

				</div>
			</div>
			</cfoutput>

		</div>


	</div>

</div>

<style>
	.modal { overflow: auto !important; }
</style>

<script>
$(document).ready(function() {

	$('.btn_add_trainer').click(function(event) {
		event.preventDefault();

		<cfif get_trainer.recordCount lt "3">
			$('#window_item_lg').modal('toggle');
			$('#window_item_lg').on('hidden.bs.modal', function (e) {
				$('#window_item_xl').modal({keyboard: true});
				$('#modal_title_xl').text("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_modal_title_choose_trainer'))#</cfoutput>");	
				$('#modal_body_xl').empty();	
				$('#modal_body_xl').load("<cfoutput>modal_window_tptrainer.cfm?t_id=#SESSION.TP_ID#&u_id=#SESSION.USER_ID#&single=1</cfoutput>");

			})
		<cfelse>
			alert("<cfoutput>#encodeForJavaScript(obj_translater.get_translate('js_warning_trainer_max'))#</cfoutput>");
		</cfif>
	});


	$('.btn_whotochoose').click(function(event) {	
		<cfoutput>
		if(confirm("#encodeForJavaScript(obj_translater.get_translate('js_choose_trainer_confirm'))#"))
		{
			<cfloop list="#tmp_list#" index="cor">
				$.ajax({
					url: 'api/tp/tp_post.cfc?method=updt_tptrainer_add',
					type: 'POST',
					data : "t_id=#t_id#&u_id=#u_id#&p_id=#cor#&interne=1", 
					datatype : "html", 
					success : function(result, status){ 
						window.location.reload(true);
					}
				});
			</cfloop>
        }
        </cfoutput>
	})



});
</script>