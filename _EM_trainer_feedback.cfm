<!DOCTYPE html>


<cfsilent>

<cfset secure = "2,4,5,12">
<cfinclude template="./incl/incl_secure.cfm">	

<cfparam name="g_id" default="0">
<cfparam name="t_id" default="0">
<cfparam name="f_id" default="0">
<cfparam name="url.lg" default="en">


<cfquery name="get_perso_count" datasource="#SESSION.BDDSOURCE#">
    SELECT 
        pi.perso_name_#url.lg# as perso_name, up.personality_id,
        COUNT(DISTINCT up.perso_giver_id) as num_attributions_perso
    FROM user_personality up
    INNER JOIN user_personality_index pi ON pi.perso_id = up.personality_id
    WHERE up.user_id = #SESSION.USER_ID#
    GROUP BY up.personality_id
</cfquery>

<cfquery name="get_badge_counts" datasource="#SESSION.BDDSOURCE#">
    SELECT 
        b.badge_name_#url.lg# as badge_name, b.badge_id,
        COUNT(DISTINCT ba.badge_learner_id) as num_attributions
    FROM lms_badge_attribution ba
    INNER JOIN lms_badge_index b ON b.badge_id = ba.badge_id
    WHERE ba.badge_trainer_id = #SESSION.USER_ID#
    GROUP BY ba.badge_id
</cfquery>

<cfquery name="get_notation" datasource="#SESSION.BDDSOURCE#">
    SELECT 
    r.rating_id, u.user_id, u.user_firstname, u.user_name,
    u2.user_id as trainer_id, u2.user_firstname as trainer_firstname,
    sm.sessionmaster_name,
    a.account_name, a.account_id,
    l.lesson_start,
    f.formation_id,
    AVG(r.rating_support) as avg_rating_support,
    AVG(r.rating_techno) as avg_rating_techno,
    AVG(r.rating_teaching) as avg_rating_teaching


    FROM lms_rating r

    INNER JOIN user u ON u.user_id = r.user_id
    INNER JOIN user u2 ON u2.user_id = r.trainer_id

    INNER JOIN account a ON a.account_id = u.account_id

    INNER JOIN lms_lesson2 l ON r.lesson_id = l.lesson_id
    INNER JOIN lms_tpsession s ON s.session_id = l.session_id
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id

    left join user_teaching t on u2.user_id=t.user_id
    INNER JOIN lms_formation f ON f.formation_id = t.formation_id 

    WHERE u2.user_id = #SESSION.USER_ID#
    GROUP BY u.user_id

    ORDER BY rating_id DESC limit 500

</cfquery>


<cfquery name="get_avg_notation" datasource="#SESSION.BDDSOURCE#">
    SELECT 
    u2.user_id as trainer_id, u2.user_firstname as trainer_firstname,
    AVG(r.rating_support) as avg_rating_support,
    AVG(r.rating_techno) as avg_rating_techno,
    AVG(r.rating_teaching) as avg_rating_teaching

    FROM lms_rating r

    INNER JOIN user u ON u.user_id = r.user_id
    INNER JOIN user u2 ON u2.user_id = r.trainer_id

    INNER JOIN lms_lesson2 l ON r.lesson_id = l.lesson_id
    INNER JOIN lms_tpsession s ON s.session_id = l.session_id
    INNER JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id

    left join user_teaching t on u2.user_id=t.user_id
    INNER JOIN lms_formation f ON f.formation_id = t.formation_id 

    WHERE u2.user_id = 140

    GROUP BY u2.user_id

    ORDER BY avg_rating_support DESC limit 500
</cfquery>


    
</cfsilent> 
	
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>

	<cfinclude template="./incl/incl_head.cfm">
    <script>
document.addEventListener('DOMContentLoaded', function() {
    let badges = document.querySelectorAll('.svg-object');
    
    badges.forEach(function(badge) {
        let numAttribution = badge.parentElement.getAttribute('data-num-attribution');
        let color;
        
        // Define the color based on the numAttribution
        if (numAttribution < 5) color = '#80BB46'; // Green
        else if (numAttribution <= 15) color = 'blue';
        else if (numAttribution < 50) color = '#933088'; // Purple
        else if (numAttribution < 100) color = 'orange';
        else if (numAttribution >= 500) color = 'red';
        
        badge.addEventListener('load', function() {
            let svgDocument = badge.contentDocument;
            let elements = svgDocument.getElementsByClassName('st0');
            for(let i=0; i < elements.length; i++) {
                elements[i].style.setProperty('fill', color, 'important');
            }
        });
    });
});



         </script>
</head>

<style>
  
    .perso_img .st0{  
            fill:#933088;
          
         
                }
    .perso_img {
            width: 80px; 
            height: auto;
            margin: 1rem;
    }

    .badge_img {
  width: 100px; 
  height: auto;
  margin: 1rem;
}

.svg-object {
  max-width: 100%;
  max-height: 100%;
}

.badge-level-1 .st0 {
  fill: #80BB46; /* Green */
}

.badge-level-2 .st0 {
  fill: blue;
}

.badge-level-3 .st0 {
  fill: #933088; /* Purple */
}

.badge-level-4 .st0 {
  fill: orange;
}

.badge-level-5 .st0 {
  fill: red;
}

    </style>

<body>

  
    
    

    <cfscript>
        // an array to hold the data
         jsonData = [];
    
        // loop over the query results
        for ( i = 1; i <= get_notation.recordCount; i++) {
            // create a struct for each record
             record = {
                "rating_id": get_notation.rating_id[i],
                "rating_techno": get_notation.avg_rating_techno[i],
                "rating_support": get_notation.avg_rating_support[i],
                "rating_teaching": get_notation.avg_rating_teaching[i],
                "user_id": get_notation.user_id[i],
                "user_firstname": get_notation.user_firstname[i],
                "user_name": get_notation.user_name[i],
                "trainer_id": get_notation.trainer_id[i],
                "trainer_firstname": get_notation.trainer_firstname[i]
                
            };
    
            // push the record into the array
            arrayAppend(jsonData, record);
        }
    </cfscript>

<div class="wrapper">
	
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "#obj_translater.get_translate('title_page_activity_report')#">

		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">

            <div class="col text-center">  
                <h4> Badges </h4>
                    <div class="row justify-content-center"> 

                                <div class="d-flex flex-wrap justify-content-center col-md-10">
                                    <cfoutput query="get_badge_counts">
                                        <div class="p-2">
                                            <cfset badgeLevel = "">
                                            <cfset votesNeeded = 0>
                                            <cfif num_attributions LT 5>
                                                <cfset badgeLevel = "badge-level-1">
                                                <cfset votesNeeded = 5 - num_attributions>
                                            <cfelseif num_attributions LT 15>
                                                <cfset badgeLevel = "badge-level-2">
                                                <cfset votesNeeded = 15 - num_attributions>
                                            <cfelseif num_attributions LT 50>
                                                <cfset badgeLevel = "badge-level-3">
                                                <cfset votesNeeded = 50 - num_attributions>
                                            <cfelseif num_attributions LT 100>
                                                <cfset badgeLevel = "badge-level-4">
                                                <cfset votesNeeded = 100 - num_attributions>
                                            <cfelse>
                                                <cfset badgeLevel = "badge-level-5">
                                                <cfset votesNeeded = 0>
                                            </cfif>
                                        
                                            <div class="badge_img cursored text-center #badgeLevel#" id="badge_#badge_id#" title="#badge_name#" data-num-attribution="#num_attributions#">
                                                <div class="badge_name"><strong>#badge_name#</strong></div>
                                    
                                                <cffile action="read" file="https://lms.wefitgroup.com/assets/img_badge/#badge_id#_G.svg" variable="fileContent">
                                                <cfif isDefined("fileContent") AND len(trim(fileContent)) NEQ 0>
                                                    <cfset key = "badge_" & toString(badge_id)> <!-- Create the key -->
                                                    <cfset badges[key] = fileContent> <!-- Save the SVG content -->
                                                    <cfif structKeyExists(badges, key)> <!-- Check if the key exists in the struct -->
                                                        <!-- Output the SVG directly into the HTML -->
                                                        <div class="svg-object img-fluid"> #badges[key]# </div>
                                                    </cfif>
                                                <cfelse>
                                                    
                                                    <cfoutput>The file could not be read or no content was returned.</cfoutput>
                                                </cfif>
                                                
                                                <div class="badge_name"><strong> #num_attributions#</strong> student(s) gave you this badge</div>
                                                
                                                <cfif votesNeeded GT 0>
                                                    <div class="votes-needed">You need <strong>#votesNeeded#</strong> more vote(s) to reach the next level.</div>
                                                </cfif>
                                            </div>
                                        </div>
                                    </cfoutput>

                                </div>
                    </div>
            </div>
                <div class="col text-center "> 
                <h4> Personnality </h4>
                    <div class="row justify-content-center">
                            <div  class="d-flex flex-wrap justify-content-center col-md-10"> 
                            <cfoutput query="get_perso_count">
                            <div class="perso_img cursored text-center" id="perso_#personality_id#" title="#perso_name#" data-num-attribution="#num_attributions_perso#">
                                            <div class="badge_name"><strong>#perso_name#</strong></div>
                                
                                            <cffile action="read" file="https://lms.wefitgroup.com/assets/img_personality/#personality_id#_G.svg" variable="fileContent">
                                            <cfif isDefined("fileContent") AND len(trim(fileContent)) NEQ 0>
                                                <cfset key = "perso_" & toString(personality_id)> <!-- Create the key -->
                                                <cfset perso[key] = fileContent> <!-- Save the SVG content -->
                                                <cfif structKeyExists(perso, key)> <!-- Check if the key exists in the struct -->
                                                    <!-- Output the SVG directly into the HTML -->
                                                    <div class="svg-object img-fluid"> #perso[key]# </div>
                                                </cfif>
                                            <cfelse>
                                            
                                                <cfoutput>The file could not be read or no content was returned.</cfoutput>
                                            </cfif>
                                            
                                            <div class="badge_name"><strong> #num_attributions_perso#</strong> student(s) voted for this personnality to describe you</div>
                                        
                                        </div>
                            </cfoutput>
                            
                            </div>
                    </div>
                </div>
            <cfoutput>
                <script>
                    var jsonData = #SerializeJSON(jsonData)#;
                </script>
            </cfoutput>
        
    <div class="col text-center">  
     <h4> Ratings </h4>
       
       <div> 
            <cfoutput>
                <div style="display: flex; justify-content: space-around;">
                    <div style="width: 30%;">
                        <canvas id="supportChart"></canvas>
                        <canvas id="supportChartAvg"></canvas>
                    </div>
                    <div style="width: 30%;">
                        <canvas id="teachingChart"></canvas>
                        <canvas id="teachingChartAvg"></canvas>
                    </div>
                    <div style="width: 30%;">
                        <canvas id="technoChart"></canvas>
                        <canvas id="technoChartAvg"></canvas>
                    </div>
                </div>    
            </cfoutput>
        </div>
    </div>
                <cfoutput>
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                    //donought charts
                        var ctxSupportAvg = document.getElementById('supportChartAvg').getContext('2d');
                        var ctxTeachingAvg = document.getElementById('teachingChartAvg').getContext('2d');
                        var ctxTechnoAvg = document.getElementById('technoChartAvg').getContext('2d');
                
                        var avgRatingSupport = #get_avg_notation.avg_rating_support#;
                        var avgRatingTeaching = #get_avg_notation.avg_rating_teaching#;
                        var avgRatingTechno = #get_avg_notation.avg_rating_techno#;
                
                        var supportData = {
                            labels: ['Average Support Ratings'],
                            datasets: [{
                                data: [avgRatingSupport, 5 - avgRatingSupport],
                                backgroundColor: [
                                    'rgba(75, 192, 192, 0.2)',
                                    'rgba(200, 200, 200, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(75, 192, 192, 1)',
                                    'rgba(200, 200, 200, 1)'
                                ],
                                borderWidth: 1
                            }]
                        };
                
                        var teachingData = {
                            labels: ['Average Teaching Ratings'],
                            datasets: [{
                                data: [avgRatingTeaching, 5 - avgRatingTeaching],
                                backgroundColor: [
                                    'rgba(75, 0, 192, 0.2)',
                                    'rgba(200, 200, 200, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(75, 0, 192, 1)',
                                    'rgba(200, 200, 200, 1)'
                                ],
                                borderWidth: 1
                            }]
                        };
                
                        var technoData = {
                            labels: ['Average Techno Ratings'],
                            datasets: [{
                                data: [avgRatingTechno, 5 - avgRatingTechno],
                                backgroundColor: [
                                    'rgba(0, 192, 75, 0.2)',
                                    'rgba(200, 200, 200, 0.2)'
                                ],
                                borderColor: [
                                    'rgba(0, 192, 75, 1)',
                                    'rgba(200, 200, 200, 1)'
                                ],
                                borderWidth: 1
                            }]
                        };
                
                        var options = {
                            cutout: '50%',
                            aspectRatio: 3, // Adjust as needed
                        };

                
                        var supportChart = new Chart(ctxSupportAvg, {
                            type: 'doughnut',
                            data: supportData,
                            options: options
                        });
                
                        var teachingChart = new Chart(ctxTeachingAvg, {
                            type: 'doughnut',
                            data: teachingData,
                            options: options
                        });
                
                        var technoChart = new Chart(ctxTechnoAvg, {
                            type: 'doughnut',
                           
                            data: technoData,
                            options: options
                        });
                 
               
                
            
              // ratings by learners
                    var ctxSupport = document.getElementById('supportChart').getContext('2d');
                    var ctxTeaching = document.getElementById('teachingChart').getContext('2d');
                    var ctxTechno = document.getElementById('technoChart').getContext('2d');
            
                    var chartDataSupport = {
                        labels: jsonData.map(data => data.user_firstname),
                        datasets: [{
                            label: 'Support Ratings by Learner',
                            data: jsonData.map(data => data.rating_support),
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1
                        }]
                    };
            
                    var chartDataTeaching = {
                        labels: jsonData.map(data => data.user_firstname),
                        datasets: [{
                            label: 'Teaching Ratings by Learner',
                            data: jsonData.map(data => data.rating_teaching),
                            backgroundColor: 'rgba(75, 0, 192, 0.2)',
                            borderColor: 'rgba(75, 0, 192, 1)',
                            borderWidth: 1
                        }]
                    };
            
                    var chartDataTechno = {
                        labels: jsonData.map(data => data.user_firstname),
                        datasets: [{
                            label: 'Techno Ratings  by Learner',
                            data: jsonData.map(data => data.rating_techno),
                            backgroundColor: 'rgba(0, 192, 75, 0.2)',
                            borderColor: 'rgba(0, 192, 75, 1)',
                            borderWidth: 1
                        }]
                    };
            
                    var chartOptions = {
                        type: 'bar',
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    max: 5,
                                }
                            }
                        }
                    };
            
                    var supportChart = new Chart(ctxSupport, Object.assign({data: chartDataSupport}, chartOptions));
                    var teachingChart = new Chart(ctxTeaching, Object.assign({data: chartDataTeaching}, chartOptions));
                    var technoChart = new Chart(ctxTechno, Object.assign({data: chartDataTechno}, chartOptions));
                </script>
            </cfoutput>
            
              
        </div>
   
    <cfinclude template="./incl/incl_footer.cfm">
	  
</div>
   </div>
  
<cfinclude template="./incl/incl_scripts.cfm">
</body>
</html>