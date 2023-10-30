<cfparam name="l_dur" default="30">

<cfset p_id=4785>

<style type="text/css">
.loader{
	/*display:none; */
	background-repeat:no-repeat; 
	background-position:center center; 
	background-image:url('./assets/img/ajax-loader.gif'); 
	min-width:16px; 
	min-height:16px;
}
</style>

<!--- <cfif SESSION.USER_PROFILE eq "learner"> --->
	
<cfif listFindNoCase("CS,SALES,FINANCE,TRAINERMNG", SESSION.USER_PROFILE)>

	<cfset u_id = u_id>
	
<cfelse>
	<cfset u_id = SESSION.USER_ID>
	

</cfif>

<cfif isdefined("p_id")>	
			
	<!----- DATE TREATMENT --->
	<cfif not isdefined("date_select")>
		<cfset date_display = dateformat(now(),'dd/mm/yyyy')>
		<cfset date_select = now()>
		<cfset date_link = dateformat(date_select,'yyyy-mm-dd')>
	<cfelse>	
		<cfset date_display = dateformat(date_select,'dd/mm/yyyy')>
		<cfset date_link = dateformat(date_select,'yyyy-mm-dd')>
	</cfif>

	<!----- GET AVAIL DAY FOR DATEPICKER --->	
	<cfquery name="get_avail_day" datasource="#SESSION.BDDSOURCE#">
	SELECT DISTINCT(DATE_FORMAT(slot_start,'%Y-%m-%d')) as avail_day FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>
	
	<!----- GET AVAIL DAY MAX FOR DATEPICKER --->	
	<cfquery name="get_avail_day_max" datasource="#SESSION.BDDSOURCE#">
	SELECT MAX(DATE_FORMAT(slot_start,'%y-%m-%d')) as avail_day FROM user_slots WHERE planner_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
	</cfquery>
	

	<cfif not isdefined("view")>
		<div class="border p-2 bg-light">
			
			<h6 class="mt-0"><cfoutput>#obj_translater.get_translate('setup_title')#</cfoutput></h6>
			<cfoutput>#obj_translater.get_translate_complex('setup_intro')#</cfoutput>
			<cfif SESSION.USER_PHONE neq ""><cfoutput><br>#obj_translater.get_translate_complex('setup_complement')# #SESSION.USER_PHONE#</cfoutput></cfif>
				
		</div>
	</cfif>
	<cfset provider = SESSION.PROVIDER_ID>
	<div class="row justify-content-center mt-3">
		<div class="col-md-2 col-xs-3">
			<a href="#" class="prev_day form-inline btn btn-sm btn-outline-info" role="button"><i class="fas fa-step-backward"></i></a>
		</div>
		<div class="col-md-8 col-xs-6" align="center">
			<form>
				
				<div class="input-group" style="width:200px;">			
				<input id="date_select" name="date_select" type="text" class="datepicker form-control" value=<cfoutput>#date_display#</cfoutput> />
				<label for="date_select" class="input-group-addon btn btn-info"><i class="fas fa-calendar-alt"></i></label>
				</div>
				
			</form>
		</div>
		<div class="col-md-2 col-xs-3">
			<a href="#" class="next_day form-inline btn btn-sm btn-outline-info" role="button"><i class="fas fa-step-forward"></i></a>
		</div>
	</div>

	

	<br>
<!--- 	<cfoutput>provider:#provider#</cfoutput> --->
	<div id="container_avail" style="min-height:200px">
		

	</div>


	<script>
	$( document ).ready(function() {
	var provider=<cfoutput>#provider#</cfoutput>
	var previousDate = $('#date_select').datepicker("getDate");
	var array_avail = [<cfoutput query="get_avail_day">"#dateformat(avail_day,'d-m-yyyy')#"<cfif recordcount neq currentrow>,</cfif></cfoutput>]
	
		function enableAllTheseDays(date) {
			var sdate = $.datepicker.formatDate( 'd-m-yy', date)
			if($.inArray(sdate, array_avail) != -1) {
				return [true];
			}
			return [false];
		}
		
		<cfoutput>
		$('##container_avail').load("get_slot_cs.cfm?l_dur=#l_dur#&p_id=#p_id#&u_id=#u_id#&date_select=#date_link#", function() {
			$('##container_avail').show("slow");
		});
		</cfoutput>
		
		var options = $.extend(
			{},
			<cfoutput>$.datepicker.regional["#SESSION.LANG_CODE#"]</cfoutput>
		);

	

		$.datepicker.setDefaults(options);

		let frenchHolidays = [];
		fetch("https://date.nager.at/api/v3/PublicHolidays/2023/FR")
        .then((response) => response.json())
        .then((holidays) => {
            frenchHolidays = holidays.map((holiday) => {
                return new Date(holiday.date);
            });
          
        })
        .catch((error) => {
            console.error("Error fetching holiday data:", error);
        });

		// Fetch German holidays
		let germanHolidays = [];
		fetch("https://date.nager.at/api/v3/PublicHolidays/2023/DE")
		.then((response) => response.json())
		.then((holidays) => {
			germanHolidays = holidays.map((holiday) => {
			return new Date(holiday.date);
			});
		})
		.catch((error) => {
			console.error("Error fetching German holiday data:", error);
		});

		function findNextAvailableDay(currentDate, nextDay = true) {
			let newDate = new Date(currentDate);
			do {
				newDate.setDate(newDate.getDate() + (nextDay ? 1 : -1));
			} while (isHoliday(newDate, provider));
			return newDate;
		}

		function isHoliday(date, provider) {
			let isHoliday = false;
			if (parseInt(provider) === 1 || parseInt(provider) === 3 || parseInt(provider) === 2) {
				isHoliday = frenchHolidays.some((holiday) => {
					let holidayDate = new Date(holiday.getFullYear(), holiday.getMonth(), holiday.getDate());
					let currentDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
					return holidayDate.getTime() === currentDate.getTime();
				});
			} else if (parseInt(provider) === 2) {
				isHoliday = germanHolidays.some((holiday) => {
					let holidayDate = new Date(holiday.getFullYear(), holiday.getMonth(), holiday.getDate());
					let currentDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
					return holidayDate.getTime() === currentDate.getTime();
				});
			}
			return isHoliday;
		}


		$('#date_select').datepicker({	
			
			<cfif SESSION.USER_PROFILE eq "learner" OR SESSION.USER_PROFILE eq "test" OR SESSION.USER_PROFILE eq "GUEST">
				minDate:0,
			</cfif>
			
			<!---<cfoutput>maxDate:new Date('#dateformat(get_avail_day_max.avail_day,"yyyy-m-dd")#'),</cfoutput>---->
			defaultDate: "+1w",
			changeMonth: true,
			numberOfMonths: 2,
			firstDay:1,
			dateFormat: 'dd/mm/yy',
			onClose: function(selectedDate) {
				var selectedDateObj = $('#date_select').datepicker("getDate");
				if (isHoliday(selectedDateObj, provider)) {
					alert("Selected date is a holiday. Please choose another date.");
					$('#date_select').datepicker("setDate", previousDate);
				} else {
					previousDate = selectedDateObj;
					var datego = moment(selectedDateObj).format('YYYY-MM-DD');
					
					$('#container_avail').html("<div class='loader'></div>");

					<cfoutput>
					$('##container_avail').load("get_slot_cs.cfm?l_dur=#l_dur#&p_id=#p_id#&u_id=#u_id#&date_select="+datego, function() {
						$('##container_avail').show("slow");
					});
					</cfoutput>
				}
			},
			beforeShowDay: function (date) {
				let sdate = $.datepicker.formatDate("d-m-yy", date);
				let isAvailableDay = $.inArray(sdate, array_avail) !== -1;
				let isHoliday = false;
			// Check provider_id and block the respective holidays

			if (parseInt(provider) === 1 || parseInt(provider) === 3 || parseInt(provider) === 2){

				isHoliday = frenchHolidays.some((holiday) => {
				let holidayDate = new Date(holiday.getFullYear(), holiday.getMonth(), holiday.getDate());
				let currentDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
				return holidayDate.getTime() === currentDate.getTime();
				});

				} else if (parseInt(provider) === 2) {
					isHoliday = germanHolidays.some((holiday) => {
					let holidayDate = new Date(holiday.getFullYear(), holiday.getMonth(), holiday.getDate());
					let currentDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
					return holidayDate.getTime() === currentDate.getTime();
					});
				}
					if (isHoliday) {
						return [false, "holiday", "Holiday"];
					} else if (isAvailableDay) {
						return [true, "", ""];
					} else {
						return [false];
					}

			},
			})
				
			$('.next_day').click(function(e) {
			var dateref = $('#date_select').datepicker("getDate");
			var nextAvailableDate = findNextAvailableDay(dateref, true);
			updateDatepickerAndLoadData(nextAvailableDate);
		});

		$('.prev_day').click(function(e) {
			var dateref = $('#date_select').datepicker("getDate");
			var prevAvailableDate = findNextAvailableDay(dateref, false);
			updateDatepickerAndLoadData(prevAvailableDate);
		});

		function updateDatepickerAndLoadData(date) {
			var datego = moment(date).format('YYYY-MM-DD');
			$('#date_select').datepicker({ dateFormat: 'yy-mm-dd' }).datepicker("setDate", date);
			$('#container_avail').html("<div class='loader'></div>");

			<cfoutput>
			$('##container_avail').load("get_slot_cs.cfm?l_dur=#l_dur#&p_id=#p_id#&u_id=#u_id#&date_select=" + datego, function() {
				$('##container_avail').show("slow");
			});
			</cfoutput>
		}


	})
	</script>

</cfif>
