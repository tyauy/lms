<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "tm">
<div id="window_item_inactive" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_inactive" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_inactive" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<script>

$(document).ready(function() {

var handle_activity;	
var active_detect = false;
var interval = 5000;
var inactive_timer = 0;
var inactive_persistant = true;

$("body").mousemove(function( event ) {
	active_detect = true; 
	// updt_status("active");
});
$("body").keydown(function( event ) {
	active_detect = true; 
	// updt_status("active");
});


var test_active  = function () {

	$.ajax({
		url : 'updater_tp3.cfc?method=updt_progress',
		type : 'POST',
		success : function(result, statut){
			//console.log(result);
		},
		error : function(resultat, statut, erreur){
			//console.log("pblm");
		},
		complete : function(resultat, statut){

		}
	});
	<cfif isdefined("sm_id") AND isdefined("sm_rec_time")>
	$.ajax({
		url : 'updater_tp3.cfc?method=updt_progress_lesson',
		type : 'POST',
		<cfoutput>
		   data : {sm_id:#sm_id#},
		</cfoutput>
		success : function(result, statut){
			//console.log(result);
		},
		error : function(resultat, statut, erreur){
			//console.log("pblm");
		},
		complete : function(resultat, statut){

		}
	});
	</cfif>
	
	if(active_detect) {
		active_detect = false;
		inactive_timer = 0;
		inactive_persistant = false;
		handle_activity = window.setTimeout(test_active, interval);
	}
	else {
		
		if(inactive_persistant) {
			
			inactive_timer += interval;

			if(inactive_timer >= 600000)
			{
				<cfoutput>
				clearTimeout(handle_activity);
				$('##window_item_inactive').modal({keyboard: false, backdrop:"static" });
				$('##modal_title_inactive').text("#obj_translater.get_translate('js_modal_title_inactive')#");
				$('##modal_body_inactive').load("modal_window_inactive.cfm", function() {});
				</cfoutput>
			
				
			}
			else{
				
				handle_activity = window.setTimeout(test_active, interval);
			}
		}
		else
		{
			
			inactive_persistant = true;			
			handle_activity = window.setTimeout(test_active, interval);
		}
	}
	
}

handle_activity = window.setTimeout(test_active, interval);
	
$("#window_item_inactive").on('hidden.bs.modal', function () {
	handle_activity = window.setTimeout(test_active, interval);
});

});
</script>
</cfif>