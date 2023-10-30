<cfparam name="ts_id" default="0">

<cfinclude template="./widget/wid_token_session_form.cfm">

<script>
$(document).ready(function() {

	$("#token_session_start").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}
	});
	
	$("#token_session_end").datepicker({	
		weekStart: 1,
		dateFormat: 'dd/mm/yy',
		onClose: function( selectedDate ) {}	
	});

	$('#submit_session_edit').click(function(){
		event.preventDefault();

		console.log($('#form_session_edit').serialize()); 
		$.ajax({				  
			url: 'api/school/school_post.cfc?method=update_school_session',
			type: 'POST',
			data : $('#form_session_edit').serialize(),
			datatype : "html", 
			success : function(result, status){ 
				console.log(result); 
				window.location.reload(true);
			}, 
			error : function(result, status, error){ 
				/*console.log(resultat);*/ 
			}	 
		});

	})

});

</script>