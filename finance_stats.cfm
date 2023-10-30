<!DOCTYPE html>

<html lang="fr">

<head>
	<cfset view = "screenshot">
	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

	<div class="wrapper">

		<cfinclude template="./incl/incl_sidebar.cfm">

		<div class="main-panel">

			<cfset title_page = "Stats">
			<cfinclude template="./incl/incl_nav.cfm">
			<cfparam name="display" default="#year(now())#">

	
			<cfsilent>
			<cfquery name="get_visio_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(t.tp_status_id) as count_tp_status, s.tp_status_name_fr as status_tp, method_id, t.tp_status_id
				FROM lms_tp t
				LEFT JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
				WHERE method_id = 1 
				<cfif display neq "all">AND year(tp_date_start) = #display#</cfif>
				AND t.tp_status_id <> 5 AND t.tp_status_id <> 6 AND t.tp_status_id <> 7 AND t.tp_status_id <> 9 AND t.tp_status_id <> 10
				GROUP BY t.tp_status_id
				ORDER BY s.tp_status_id
			</cfquery>
			<cfquery name="get_visio_finance" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(o.order_status_id) as count_tp_status, t.method_id, o.order_status_id, s.status_finance_name
				FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				LEFT JOIN order_status_finance s ON s.status_finance_id = o.order_status_id
				WHERE t.method_id = 1 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
				AND o.order_status_id != 8 AND o.order_status_id != 9
				GROUP BY o.order_status_id
				HAVING count_tp_status > 0
				ORDER BY o.order_status_id
			</cfquery>
			<cfquery name="get_visio_all" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as count_all FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				WHERE t.method_id = 1 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
			</cfquery>
			<cfset title_visio = '<i class="fal fa-webcam mr-2"></i> PARCOURS VISIO'>
			
			<cfquery name="get_certif_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(t.tp_status_id) as count_tp_status, s.tp_status_name_fr as status_tp, method_id, t.tp_status_id
				FROM lms_tp t
				LEFT JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
				WHERE method_id = 7 
				<cfif display neq "all">AND year(tp_date_start) = #display#</cfif>
				AND t.tp_status_id <> 5 AND t.tp_status_id <> 6 AND t.tp_status_id <> 7 AND t.tp_status_id <> 9 AND t.tp_status_id <> 10
				GROUP BY t.tp_status_id
				ORDER BY s.tp_status_id
			</cfquery>
			<cfquery name="get_certif_finance" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(o.order_status_id) as count_tp_status, t.method_id, o.order_status_id, s.status_finance_name
				FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				LEFT JOIN order_status_finance s ON s.status_finance_id = o.order_status_id
				WHERE t.method_id = 7 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
				AND o.order_status_id != 8 AND o.order_status_id != 9
				GROUP BY o.order_status_id
				HAVING count_tp_status > 0
				ORDER BY o.order_status_id
			</cfquery>
			<cfquery name="get_certif_all" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as count_all FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				WHERE t.method_id = 7
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
			</cfquery>
			<cfset title_certif = '<i class="fal fa-file-certificate mr-2"></i> CERTIFICATION'>
			
			
			<cfquery name="get_el_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(t.tp_status_id) as count_tp_status, s.tp_status_name_fr as status_tp, method_id, t.tp_status_id
				FROM lms_tp t
				LEFT JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
				WHERE method_id = 3 
				<cfif display neq "all">AND year(tp_date_start) = #display#</cfif>
				AND t.tp_status_id <> 5 AND t.tp_status_id <> 6 AND t.tp_status_id <> 7 AND t.tp_status_id <> 9 AND t.tp_status_id <> 10
				GROUP BY t.tp_status_id
				ORDER BY s.tp_status_id
			</cfquery>
			<cfquery name="get_el_finance" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(o.order_status_id) as count_tp_status, t.method_id, o.order_status_id, s.status_finance_name
				FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				LEFT JOIN order_status_finance s ON s.status_finance_id = o.order_status_id
				WHERE t.method_id = 3 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
				AND o.order_status_id != 8 AND o.order_status_id != 9
				GROUP BY o.order_status_id
				HAVING count_tp_status > 0
				ORDER BY o.order_status_id
			</cfquery>
			<cfquery name="get_el_all" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as count_all FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				WHERE t.method_id = 3
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
			</cfquery>
			<cfset title_el = '<i class="fal fa-laptop mr-2"></i> PARCOURS E-LEARNING'>
			
			
			<cfquery name="get_ftof_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(t.tp_status_id) as count_tp_status, s.tp_status_name_fr as status_tp, method_id, t.tp_status_id
				FROM lms_tp t
				LEFT JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
				WHERE method_id = 2 
				<cfif display neq "all">AND year(tp_date_start) = #display#</cfif>
				AND t.tp_status_id <> 5 AND t.tp_status_id <> 6 AND t.tp_status_id <> 7 AND t.tp_status_id <> 9 AND t.tp_status_id <> 10
				GROUP BY t.tp_status_id
				ORDER BY s.tp_status_id
			</cfquery>
			<cfquery name="get_ftof_finance" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(o.order_status_id) as count_tp_status, t.method_id, o.order_status_id, s.status_finance_name
				FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				LEFT JOIN order_status_finance s ON s.status_finance_id = o.order_status_id
				WHERE t.method_id = 2 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
				AND o.order_status_id != 8 AND o.order_status_id != 9
				GROUP BY o.order_status_id
				HAVING count_tp_status > 0
				ORDER BY o.order_status_id
			</cfquery>
			<cfquery name="get_ftof_all" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as count_all FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				WHERE t.method_id = 2
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
			</cfquery>
			<cfset title_ftof = '<i class="fal fa-eye mr-2"></i> PARCOURS PRÉSENTIEL'>
			

			<cfquery name="get_imm_tp" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(t.tp_status_id) as count_tp_status, s.tp_status_name_fr as status_tp, method_id, t.tp_status_id
				FROM lms_tp t
				LEFT JOIN lms_tpstatus s ON s.tp_status_id = t.tp_status_id
				WHERE method_id = 6 
				<cfif display neq "all">AND year(tp_date_start) = #display#</cfif>
				AND t.tp_status_id <> 5 AND t.tp_status_id <> 6 AND t.tp_status_id <> 7 AND t.tp_status_id <> 9 AND t.tp_status_id <> 10
				GROUP BY t.tp_status_id
				ORDER BY s.tp_status_id
			</cfquery>
			<cfquery name="get_imm_finance" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(o.order_status_id) as count_tp_status, t.method_id, o.order_status_id, s.status_finance_name
				FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				LEFT JOIN order_status_finance s ON s.status_finance_id = o.order_status_id
				WHERE t.method_id = 6 
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
				AND o.order_status_id != 8 AND o.order_status_id != 9
				GROUP BY o.order_status_id
				HAVING count_tp_status > 0
				ORDER BY o.order_status_id
			</cfquery>
			<cfquery name="get_imm_all" datasource="#SESSION.BDDSOURCE#">
				SELECT COUNT(*) as count_all FROM lms_tp t
				LEFT JOIN orders o ON o.order_id = t.order_id
				WHERE t.method_id = 6
				<cfif display neq "all">AND year(t.tp_date_start) = #display#</cfif>
			</cfquery>
			<cfset title_imm = '<i class="fal fa-rocket mr-2"></i> PARCOURS IMMERSION'>
			

			</cfsilent>

			<div class="content">

				<div class="row" style="margin-top:10px">
					<cfoutput>
					<cfloop from="#year(now())-3#" to="#year(now())#" index="cor">
						<button type="button" class="btn btn-outline-info p-4 <cfif display eq cor>active</cfif>" onclick="location.href='finance_stats.cfm?display=#cor#'">  #cor#  </button>
					</cfloop>
					</cfoutput>
				
				</div>
				
				
				
				<div class="row" style="margin-top:10px">
				
				
		
				
				<!--- <cfset method_list = "visio,certif,el,ftof,imm">	 --->
					
				<cfset method_list = "visio,el,ftof,imm">
				<cfloop list="#method_list#" index="cur_method">	
				<cfoutput>
				<div class="col-md-3">
				<div id="#cur_method#_collapse">	
					<div class="d-grid">
						<button class="btn btn-info btn-block text-center m-0 mt-4" data-toggle="collapse" data-target="###cur_method#" aria-expanded="true" aria-controls="#cur_method#">
							#evaluate('title_#cur_method#')#
						</button>
					</div>
								
					<div id="#cur_method#" class="collapse show p-2 bg-white" data-parent="###cur_method#_collapse">
					
					<cfif display neq "all">
						<div class="row">
							<div class="col-md-12">
								<table class="table table-bordered" rules="all">
								<cfset nb_tp = 0>
								<cfloop query="get_#cur_method#_tp">
								<tr>
									<td>#status_tp#</td>
									<td align="center">#count_tp_status#</td>
									<cfset nb_tp += #count_tp_status#>
									<cfif view neq "screenshot"><td width="100px"><button type="button" class="btn btn-dark btn_list_tps" id="#display#_#method_id#_#tp_status_id#">details</button></td></cfif>
								</tr>
								</cfloop>
								<tr>
									<td><strong>TOTAL</strong></td>
									<td align="center"><strong>#nb_tp#</strong></td>
								</tr>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div width="100%" class="mb-5"><canvas id="chart_#cur_method#"></canvas></div>
							</div>
						</div>
					<!---<cfelse>--->	
					
						<cfif view neq "screenshot">
						<div class="row mt-3">
						
							<div class="col-md-12">
								<table class="table table-bordered mt-3" rules="all">
									<cfloop query="get_#cur_method#_finance">
									<tr>
										<td>#status_finance_name#</td>
										<td align="center">#count_tp_status#</td>
										<td width="100px"><button type="button" class="btn btn-dark btn_list_finance" id="#display#_#method_id#_#order_status_id#">details</button></td>
									</tr>
									</cfloop>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div width="100%" class="mt-3"><canvas id="chart_#cur_method#_f"></canvas></div>
							</div>
						</div>
						</cfif>
				<!---	<cfelse>
						<div class="row">
						
							<div class="col-md-5">
								<table class="table table-bordered mt-3" rules="all">
									<cfloop query="get_visio_finance">
									<tr>
										<td>#status_finance_name#</td>
										<td align="center">#count_tp_status#</td>
										<td width="100px"><button type="button" class="btn btn-dark btn_list_finance" id="#display#_#method_id#_#order_status_id#">details</button></td>
									</tr>
									</cfloop>
								</table>
							</div>
							<div class="col-md-7">
									<div width="100%" class="mt-5"><canvas id="chart_visio_all"></canvas></div>
							</div>
						</div>	--->
					</cfif>
					</div>
				</div>		
				
				</cfoutput>
				</div>
				</cfloop>
				
				</div>
			</div>
		
		
		</div>
	</div>
<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_modal.cfm">

<cfinclude template="./incl/incl_scripts_timer.cfm">

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>



<script>
$(document).ready(function() {
	
	$('.btn_list_tps').click(function(event) {		
		event.preventDefault();
		
		var id_temp = $(this).attr("id");
	
		var tmp = id_temp.split("_");
		var yy = tmp[0];
		var mm = tmp[1];
		var ss = tmp[2];
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("liste TP");
		$('#modal_body_lg').load("modal_window_list_tp.cfm?y="+yy+"&method_id="+mm+"&status="+ss);
	});
	
	$('.btn_list_finance').click(function(event) {		
		event.preventDefault();
		
		var id_temp = $(this).attr("id");
	
		var tmp = id_temp.split("_");
		var yy = tmp[0];
		var mm = tmp[1];
		var ss = tmp[2];
		
		$('#window_item_lg').modal({keyboard: true});
		$('#modal_title_lg').text("liste TP");
		$('#modal_body_lg').load("modal_window_list_tp.cfm?y="+yy+"&method_id="+mm+"&status="+ss+"&ord=1");
	});
	
	
});
</script>

<cfset color_1 = 'rgba(107, 208, 152, 0.2)'>
<cfset color_2 = 'rgba(251, 198, 88, 0.2)'>
<cfset color_3 = 'rgba(239, 129, 87, 0.2)'>
<cfset color_4 = 'rgba(251, 0, 0, 0.2)'>
<cfset color_5 = 'rgba(219, 77, 155, 0.2)'>
<cfset color_6 = 'rgba(10, 10, 10, 0.2)'>
<cfset color_7 = 'rgba(0, 0, 250, 0.2)'>
<cfset color_9 = 'rgba(0, 250, 0, 0.2)'>
<cfset color_10 = 'rgba(107, 208, 152, 0.2)'>
<cfset color_11 = 'rgba(187, 105, 255, 0.2)'>

<cfset colorbg_1 = 'rgba(107, 208, 152, 1)'>
<cfset colorbg_2 = 'rgba(251, 198, 88, 1)'>
<cfset colorbg_3 = 'rgba(239, 129, 87, 1)'>
<cfset colorbg_4 = 'rgba(251, 0, 0, 1)'>
<cfset colorbg_5 = 'rgba(10, 10, 10, 1)'>
<cfset colorbg_6 = 'rgba(107, 208, 152, 1)'>
<cfset colorbg_7 = 'rgba(0, 0, 250, 1)'>
<cfset colorbg_9 = 'rgba(0, 250, 0, 1)'>
<cfset colorbg_10 = 'rgba(42, 117, 90, 1)'>
<cfset colorbg_11 = 'rgba(187, 105, 255, 1)'>


<script>
<cfoutput>
<cfif display neq "all">
var chart_visio = document.getElementById('chart_visio');
var chart_visio = new Chart(chart_visio, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_visio_tp#">
		'#status_tp#: #round((count_tp_status/get_visio_all.count_all)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_visio_tp#">
			#round((count_tp_status/get_visio_all.count_all)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_visio_tp#">
                '#evaluate("color_#tp_status_id#")#',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_visio_tp#">
                '#evaluate("colorbg_#tp_status_id#")#',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
<cfif view neq "screenshot">
var chart_visio_f = document.getElementById('chart_visio_f');
var chart_visio_f = new Chart(chart_visio_f, {
    type: 'bar',
    data: {
        labels: [
		'#display#'
		],
        datasets: [
		<cfloop query="#get_visio_finance#">		
		<cfoutput>
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_visio_all.count_all)*100)#%',
            ],
			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			#round((count_tp_status/get_visio_all.count_all)*100)#,
			]
        },
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>

<cfif view neq "screenshot">
var chart_certif = document.getElementById('chart_certif');
var chart_certif = new Chart(chart_certif, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_certif_tp#">
		'#status_tp#: #round((count_tp_status/get_certif_all.count_all)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_certif_tp#">
			#round((count_tp_status/get_certif_all.count_all)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_certif_tp#">
                '#evaluate("color_#tp_status_id#")#',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_certif_tp#">
                '#evaluate("colorbg_#tp_status_id#")#',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
var chart_certif_f = document.getElementById('chart_certif_f');
var chart_certif_f = new Chart(chart_certif_f, {
    type: 'bar',
    data: {
        labels: [
		'#display#'
		],
        datasets: [
		<cfloop query="#get_certif_finance#">		
		<cfoutput>
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_certif_all.count_all)*100)#%',
            ],
			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			#round((count_tp_status/get_certif_all.count_all)*100)#,
			]
        },
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>


var chart_el = document.getElementById('chart_el');
var chart_el = new Chart(chart_el, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_el_tp#">
		'#status_tp#: #round((count_tp_status/get_el_all.count_all)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_el_tp#">
			#round((count_tp_status/get_el_all.count_all)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_el_tp#">
                '#evaluate("color_#tp_status_id#")#',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_el_tp#">
                '#evaluate("colorbg_#tp_status_id#")#',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
<cfif view neq "screenshot">
var chart_el_f = document.getElementById('chart_el_f');
var chart_el_f = new Chart(chart_el_f, {
    type: 'bar',
    data: {
        labels: [
		'#display#'
		],
        datasets: [
		<cfloop query="#get_el_finance#">		
		<cfoutput>
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_el_all.count_all)*100)#%',
            ],
			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			#round((count_tp_status/get_el_all.count_all)*100)#,
			]
        },
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>

var chart_ftof = document.getElementById('chart_ftof');
var chart_ftof = new Chart(chart_ftof, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_ftof_tp#">
		'#status_tp#: #round((count_tp_status/get_ftof_all.count_all)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_ftof_tp#">
			#round((count_tp_status/get_ftof_all.count_all)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_ftof_tp#">
                '#evaluate("color_#tp_status_id#")#',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_ftof_tp#">
                '#evaluate("colorbg_#tp_status_id#")#',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
<cfif view neq "screenshot">
var chart_ftof_f = document.getElementById('chart_ftof_f');
var chart_ftof_f = new Chart(chart_ftof_f, {
    type: 'bar',
    data: {
        labels: [
		'#display#'
		],
        datasets: [
		<cfloop query="#get_ftof_finance#">		
		<cfoutput>
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_ftof_all.count_all)*100)#%',
            ],
			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			#round((count_tp_status/get_ftof_all.count_all)*100)#,
			]
        },
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>

var chart_imm = document.getElementById('chart_imm');
var chart_imm = new Chart(chart_imm, {
    type: 'doughnut',	
	data: {
		labels: [
		<cfloop query="#get_imm_tp#">
		'#status_tp#: #round((count_tp_status/get_imm_all.count_all)*100)#%',
		</cfloop>
		],
		datasets: [{
			data: [
			<cfloop query="#get_imm_tp#">
			#round((count_tp_status/get_imm_all.count_all)*100)#,
			</cfloop>
			],
            backgroundColor: [
			<cfloop query="#get_imm_tp#">
                '#evaluate("color_#tp_status_id#")#',                
			</cfloop>
            ],
            borderColor: [
                <cfloop query="#get_imm_tp#">
                '#evaluate("colorbg_#tp_status_id#")#',                
				</cfloop>
            ],
            borderWidth: 1
        }]
    },
	options: {
		responsive:'false'
	}
});
<cfif view neq "screenshot">
var chart_imm_f = document.getElementById('chart_imm_f');
var chart_imm_f = new Chart(chart_imm_f, {
    type: 'bar',
    data: {
        labels: [
		'#display#'
		],
        datasets: [
		<cfloop query="#get_imm_finance#">		
		<cfoutput>
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_imm_all.count_all)*100)#%',
            ],
			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			#round((count_tp_status/get_imm_all.count_all)*100)#,
			]
        },
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>
</cfif>
<cfif display eq "all">
var chart_visio_all = document.getElementById('chart_visio_all');
var chart_visio_all = new Chart(chart_visio_all, {
    type: 'bar',
    data: {
        labels: [
		<cfloop list="#year_list#" index="cur_year">
		'#cur_year#',
		</cfloop>
		],
        datasets: [
		
		<cfloop query="#get_visio_finance#">		
		<cfoutput>
		
		
		{
			label: [
               '#status_finance_name#: #round((count_tp_status/get_visio_all.count_all)*100)#%',
            ],

			backgroundColor:'#evaluate("color_#order_status_id#")#',
            data: [
			<cfloop query="#get_visio_finance#" group="year(tp_date_start)">
			#round((count_tp_status/get_visio_all.count_all)*100)#,
			</cfloop>
			]
        },
		
		</cfoutput>		
		</cfloop>
		]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        }
    }
});
</cfif>
</cfoutput>
</script>

</body>
</html>