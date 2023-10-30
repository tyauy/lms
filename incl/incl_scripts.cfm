<!---   CORE JS Files   --->
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>
<script src="./assets/js/plugins/bootstrap-notify.js"></script>

<!--- <script src="./assets/js/plugins/perfect-scrollbar.jquery.min.js"></script> --->

<!--- PAPER DASHBOARD --->
<script src="./assets/js/paper-dashboard.js?v=2.0.0" type="text/javascript"></script>

<!--- STARRR ---->
<script src="./assets/js/starrr/starrr.js"></script>


<!--- FULLCALENDAR & LOCALES--->
<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
<script src="./assets/js/fullcalendar-scheduler-1.9.4/lib/moment.min.js"></script>
<script src="./assets/js/fullcalendar-scheduler-1.9.4/lib/fullcalendar.min.js"></script>
<script src="./assets/js/fullcalendar-scheduler-1.9.4/lib/gcal.min.js"></script>
<script src="./assets/js/fullcalendar-scheduler-1.9.4/lib/jquery-ui.min.js"></script>
<script src="./assets/js/fullcalendar-scheduler-1.9.4/scheduler.min.js"></script>
<cfswitch expression="#SESSION.LANG_CODE#">
<cfcase value="fr"><script src='./assets/js/fullcalendar-3.9.0/locale/fr.js'></script></cfcase>
<cfcase value="en"></cfcase>
<cfcase value="it"><script src='./assets/js/fullcalendar-3.9.0/locale/it.js'></script></cfcase>
<cfcase value="es"><script src='./assets/js/fullcalendar-3.9.0/locale/es.js'></script></cfcase>
<cfcase value="de"><script src='./assets/js/fullcalendar-3.9.0/locale/de.js'></script></cfcase>
<cfdefaultcase></cfdefaultcase>
</cfswitch>

<!--- DATATABLES ---->
<!---<script src="./assets/js/datatables/datatables.min.js"></script>
<script src="./assets/js/datatables/dataTables.buttons.min.js"></script>
<script src="./assets/js/datatables/phoneNumber.js"></script>--->

<!--- DATEPICKER & TIMEPICKER--->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./assets/js/timepicker/timepicker.js"></script>
<cfswitch expression="#SESSION.LANG_CODE#">
<cfcase value="fr"><script src='./assets/js/datepicker/datepicker-fr.js'></script></cfcase>
<cfcase value="en"></cfcase>
<cfcase value="it"><script src='./assets/js/datepicker/datepicker-it.js'></script></cfcase>
<cfcase value="es"><script src='./assets/js/datepicker/datepicker-es.js'></script></cfcase>
<cfcase value="de"><script src='./assets/js/datepicker/datepicker-de.js'></script></cfcase>
</cfswitch>

<!---TYPEAHEAD ---->
<script src="./assets/js/jquery-typeahead-2.10.6/dist/jquery.typeahead.min.js"></script>

<!--- MULTISELECT ---->  
<script src="./assets/js/bootstrap-multiselect-master/dist/js/bootstrap-multiselect.js"></script>

<!--- JSIGNATURE --->
<script src="./assets/js/jsignature/libs/jSignature.min.js"></script>
<script src="./assets/js/jsignature/src/plugins/jSignature.UndoButton.js"></script> 



<!---- TINYMCE --->
<script src="https://cdn.tiny.cloud/1/04mq5ml44h01jab13jjt2aqhugtwm0qeminwt1in6meamk5i/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>

<div id="window_item_ctc" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
			<div class="modal-header">
				<h5 id="modal_title_ctc" class="modal-title"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div id="modal_body_ctc" class="modal-body">
			
			</div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {

	$('.btn_contact_wefit_modal').click(function(event) {

		let go_u = 1;
		let go_o = 1;

		$('#window_item_xl_unclosable').modal('hide');

		$('#window_item_xl_unclosable').on('hidden.bs.modal', function (e) {
			if (go_u) {
				go_u = 0;
				$('#window_item_ctc').modal({keyboard: true});
				$('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
				<cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST">
				// $('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});
				$('#modal_body_ctc').load("modal_window_calendar_cs.cfm", function() {});
				<cfelseif SESSION.USER_PROFILE eq "TRAINER">
				$('#modal_body_ctc').load("modal_window_contact.cfm?view=t", function() {});
				<cfelseif SESSION.USER_PROFILE eq "TM">
				$('#modal_body_ctc').load("modal_window_contact.cfm?view=tm", function() {});
				</cfif>
			}
		});

		$('#window_item_ctc').on('hidden.bs.modal', function (e) {
			if (go_o) {
				go_o = 0;
				$('#window_item_xl_unclosable').modal('show');
			}
		});
	});

	$('.btn_contact_wefit').click(function(event) {	

		$('#window_item_sm').modal('hide');
		$('#window_item_lg').modal('hide');
		$('#window_item_xl').modal('hide');
		$('#window_item_xl_unclosable').modal('hide');

		$('#window_item_ctc').modal({keyboard: true});
		$('#modal_title_ctc').text("<cfoutput>#obj_translater.get_translate('js_modal_contact_wefit')#</cfoutput>");
		<cfif SESSION.USER_PROFILE eq "LEARNER" OR SESSION.USER_PROFILE eq "GUEST" OR SESSION.USER_PROFILE eq "TEST">
		$('#modal_body_ctc').load("modal_window_contact.cfm?view=l", function() {});
		<cfelseif SESSION.USER_PROFILE eq "TRAINER">
		$('#modal_body_ctc').load("modal_window_contact.cfm?view=t", function() {});
		<cfelseif SESSION.USER_PROFILE eq "TM">
		$('#modal_body_ctc').load("modal_window_contact.cfm?view=tm", function() {});
		</cfif>		
	});
	
	$('.btn_help').click(function(event) {		
		event.preventDefault();
		var idtemp = $(this).attr("id");
		var idtemp = idtemp.split("_");
		var idtemp = idtemp[1];
				
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("<cfoutput>#obj_translater.get_translate('js_modal_title_help')#</cfoutput>");
		$('#modal_body_lg').load("modal_window_help.cfm?h="+idtemp, function() {});
		
	});
	
});
</script>