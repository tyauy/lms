<!DOCTYPE html>

<cfsilent>

</cfsilent>
	
<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Mes disponibilit&eacute;s">
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">


			<cfset case = "availability">
			<cfinclude template="./incl/incl_nav_trainer.cfm">
			
			<div class="row">
			
				<div class="col-md-12">
					<div class="card">
						<!--<div class="card-header">
							<h5 class="card-title">Ma formation</h5>
							<p class="card-category">Aper&ccedil;u de votre parcours de formation</p>
						</div>--->
						<div class="card-body">
<cfinclude template="./widget/wid_ planner.cfm">
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
	$(function() {
		$("#date_schedule_from").datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			onClose: function( selectedDate ) {
			$( "#date_schedule_to" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$("#date_schedule_to").datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 3,
			onClose: function( selectedDate ) {
			$( "#date_schedule_from" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
		
		$(".select_day").change(function() {
			if($(this).is(':checked'))
			{
				$("#colday_"+$(this).attr("id")).removeClass("bg-disabled");
				$("#colday_"+$(this).attr("id")).addClass("bg-white");
				
				$("#select_am_"+$(this).attr("id")).prop('disabled', false);
				$("#select_pm_"+$(this).attr("id")).prop('disabled', false);
				
				
				/*$("#start_am_"+$(this).attr("id")).prop('disabled', false);
				$("#end_am_"+$(this).attr("id")).prop('disabled', false);*/
			}
			else{
			
			
			
				
				$("#colday_"+$(this).attr("id")).removeClass("bg-white");
				$("#colday_"+$(this).attr("id")).addClass("bg-disabled");
				$("#colam_"+$(this).attr("id")).removeClass("bg-white");
				$("#colam_"+$(this).attr("id")).addClass("bg-disabled");
				$("#colpm_"+$(this).attr("id")).removeClass("bg-white");
				$("#colpm_"+$(this).attr("id")).addClass("bg-disabled");
				
				
				$("#select_am_"+$(this).attr("id")).prop('checked', false);
				$("#select_am_"+$(this).attr("id")).prop('disabled', true);
				$("#select_pm_"+$(this).attr("id")).prop('checked', false);
				$("#select_pm_"+$(this).attr("id")).prop('disabled', true);
				
				$("#start_am_"+$(this).attr("id")).prop('disabled', true);
				$("#end_am_"+$(this).attr("id")).prop('disabled', true);
				
				$("#start_pm_"+$(this).attr("id")).prop('disabled', true);
				$("#end_pm_"+$(this).attr("id")).prop('disabled', true);
				
			}
			
		});
		
		$(".select_am").change(function() {
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);
	
			if($(this).is(':checked'))
			{
				
				$("#colam_"+idtemp).removeClass("bg-disabled");
				$("#colam_"+idtemp).addClass("bg-white");
				$("#start_am_"+idtemp).prop('disabled', false);
				$("#end_am_"+idtemp).prop('disabled', false);
			}
			else{
				$("#colam_"+idtemp).removeClass("bg-white");
				$("#colam_"+idtemp).addClass("bg-disabled");
				$("#start_am_"+idtemp).prop('disabled', true);
				$("#end_am_"+idtemp).prop('disabled', true);
			}
		
		});
		
		$(".select_pm").change(function() {
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.substr(idtemp.lastIndexOf("_")+1,50);
	
			if($(this).is(':checked'))
			{
				$("#colpm_"+idtemp).removeClass("bg-disabled");
				$("#colpm_"+idtemp).addClass("bg-white");
				$("#start_pm_"+idtemp).prop('disabled', false);
				$("#end_pm_"+idtemp).prop('disabled', false);
			}
			else{
				$("#colpm_"+idtemp).removeClass("bg-white");
				$("#colpm_"+idtemp).addClass("bg-disabled");
				$("#start_pm_"+idtemp).prop('disabled', true);
				$("#end_pm_"+idtemp).prop('disabled', true);
			}
		
		});
		
	});
</script>
	
</body>
</html>