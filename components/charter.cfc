<cfcomponent>

	<cffunction name="get_pie_opport" access="public" returntype="any">

	<cfquery name="get_type" datasource="#SESSION.BDDSOURCE#">
	SELECT * FROM task_type WHERE task_group = "opport"
	</cfquery>

	<!---<cfchart  
        scaleFrom=40000 
        scaleTo=100000 
        font="arial" 
        fontSize=16 
        gridLines=4  
        show3D="yes" 
        foregroundcolor="##000066" 
        databackgroundcolor="##FFFFCC" 
        chartwidth="450" 
		 
    > 
 
    <cfchartseries  
        type="pie"  
        query="get_type"  
        valueColumn="100"  
        itemColumn="task_type" 
        seriescolor="##33CC99" 
        paintstyle="shade" 
        /> 
 
</cfchart>--->

	<canvas id="pie" width="200" height="200"></canvas>

	<script>
	var ctx2 = document.getElementById("pie");

	var data = {
		labels: [
			<cfoutput query="get_type">
			"#task_type_name#",
			</cfoutput>
		],
		datasets: [
			{
				data: [300, 50, 100,20],
				backgroundColor: [
					<cfoutput query="get_type">"###task_color#",</cfoutput>
				],
				hoverBackgroundColor: [
					<cfoutput query="get_type">"###task_color#",</cfoutput>
				]
			}]
	};

	var myDoughnutChart = new Chart(ctx2, {
		type: 'doughnut',
		data: data,
		
		options: {
		responsive : true,
		animation:{
			animateScale:true
		}
		}
	});

	</script>     
	
    </cffunction>
	     
</cfcomponent>