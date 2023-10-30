<cfset LB = listgetat(user_lst,1)>
<cfset RB = listgetat(user_lst,2)>
<cfset INT = listgetat(user_lst,3)>
<cfset EXT = listgetat(user_lst,4)>
<cfset VNV = listgetat(user_lst,5)>
<cfset K = listgetat(user_lst,6)>
<cfset VV = listgetat(user_lst,7)>
<cfset AV = listgetat(user_lst,8)>

<cfif LB gt RB AND INT gt EXT>
	<cfif LB gte INT>
		<cfset learner_profile = "Conceptual">
	<cfelse>
		<cfset learner_profile = "Analytic">
	</cfif>
<cfelseif LB gt RB AND INT lt EXT>
	<cfif LB gt EXT>
		<cfset learner_profile = "Scholastic">
	<cfelse>
		<cfset learner_profile = "Social">
	</cfif>
<cfelseif LB lt RB AND INT gt EXT>
	<cfif RB gt INT>
		<cfset learner_profile = "Creative">
	<cfelse>
		<cfset learner_profile = "Independant">
	</cfif>
<cfelseif LB lt RB AND INT lt EXT>
	<cfif RB gt EXT>
		<cfset learner_profile = "Applied">
	<cfelse>
		<cfset learner_profile = "Dynamic">
	</cfif>
<cfelse>
	<cfset learner_profile = "Neutral">
</cfif>

<!---- Left Brain,Right Brain,Introvert,Extrovert,Sensory perception,Visual non-verbal,Kinesthetic,Visual-verbal,Audio-verbal --->


<cfif lst_display eq "radar">
<!---<cfif user_lst neq "">--->
<!---<cfoutput><canvas id="lst_radar_#SESSION.USER_ID#" width="150" height="150"></canvas></cfoutput>
<script>
<cfoutput>var lst_radar = document.getElementById("lst_radar_#SESSION.USER_ID#");</cfoutput>

var data = {
    labels: ["Left Brain", "Auditory Verbal", "Extrovert", "Kinaesthetic", "Right Brain", "Visual Non Verbal", "Introvert", "Verbal Visual"],
    datasets: [
        {
            label: "Results",
            backgroundColor: "rgba(179,181,198,0.2)",
            borderColor: "rgba(179,181,198,1)",
            pointBackgroundColor: "rgba(179,181,198,1)",
            pointBorderColor: "#fff",
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderColor: "rgba(179,181,198,1)",
            data: [<cfoutput>#user_lst#</cfoutput>]
        }
    ]
};

var myRadarChart = new Chart(lst_radar, {
    type: 'radar',
    data: data
});
</script>	--->
<!---</cfif>--->
<div class="p-3 mb-2 bg-light text-dark">
<cfoutput>
	<strong>#obj_translater.get_translate('brain_dominance')#</strong><br>
	#obj_translater.get_translate('left_brain')# : #LB# %<br>
	#obj_translater.get_translate('right_brain')# : #RB# %<br>
	<strong>#obj_translater.get_translate('card_socialization')#</strong><br>
	#obj_translater.get_translate('introvert')# : #INT# %<br>
	#obj_translater.get_translate('extrovert')# : #EXT# %<br>
	<strong>#obj_translater.get_translate('sensory_perception')#</strong><br>
	#obj_translater.get_translate('perception_visual_nv')# : #VNV# %<br>
	#obj_translater.get_translate('perception_kinesthetic')# : #K# %<br>
	#obj_translater.get_translate('perception_visual_verbal')# : #VV# %<br>
	#obj_translater.get_translate('perception_audio_verbal')# : #AV# %<br>
</cfoutput>
</div>

<cfelseif lst_display eq "radar_txt">


<!---COMPLEX
<cfoutput>
<cfif learner_profile eq "Social">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_social_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_social')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_social')#</em>
<cfelseif learner_profile eq "Dynamic">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_dynamic_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_dynamic')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_dynamic')#</em>
<cfelseif learner_profile eq "Independant">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_independant_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_independant')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_independant')#</em>
<cfelseif learner_profile eq "Applied">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_applied_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_applied')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_applied')#</em>
<cfelseif learner_profile eq "Conceptual">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_conceptual_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_conceptual')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_conceptual')#</em>
<cfelseif learner_profile eq "Scholastic">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_scholastic_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_scholastic')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_scholastic')#</em>
<cfelseif learner_profile eq "Creative">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_creative_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_creative')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_creative')#</em>
<cfelseif learner_profile eq "Analytic">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_analytic_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_analytic')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_analytic')#</em>
<cfelseif learner_profile eq "Neutral">
	<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_neutral_lrn')#</span></h4>
	#obj_translater.get_translate_complex('lst_lrn_profile_neutral')#
	<em>#obj_translater.get_translate_complex('summary_lrn_profile_neutral')#</em>
</cfif>
</cfoutput>
START_RM--->
<cfif learner_profile eq "Social">
<h4><span class="badge badge-pill badge-primary bg-warning">Social Learner</span></h4>
<ul>
<li>The <strong>Social learner</strong> loves to communicate.</li>
<li>You are good with words and can express yourself very well.</li>
<li>You are at ease with people and are energized by them.</li>
<li>Group discussions and debates are great methods that allow you to learn best as your strength lies with listening, speaking, and people. </li>
<li>As you are left-brained, you function well with linear and sequential learning.</li>
<li>On the other hand, the structure shouldn't be too rigid that it dampens your opportunity for exchanging ideas with others.</li>
</ul>
<em>The Social learner is <strong>left-brain</strong> dominant and has an <strong>extroverted</strong> personality. Your results show that you are <cfoutput>#LB#</cfoutput> % left-brain and <cfoutput>#EXT#</cfoutput> % extrovert.</em>

<cfelseif learner_profile eq "Dynamic">

<h4><span class="badge badge-pill badge-primary bg-warning">Dynamic Learner</span></h4>
<ul>
<li>The <strong>Dynamic learner</strong> is activity-oriented. </li>
<li>A combination of action and people make you tick. </li>
<li>You have to be engaged in activity to learn concepts better and if other people can be involved, even better. </li>
<li>You process information from whole to parts and care about the overall coherence and meaning of texts more than the nitty-gritty details of spelling and punctuation.</li> 
<li>Anything hands-on would help you process information better. Activities like group projects and role-play are highly appreciated by the dynamic learner.</li>
</ul>
<em>The Dynamic learner is <strong>right-brain</strong> dominant and has an <strong>extroverted</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#EXT#</cfoutput> % extrovert.</em>

<cfelseif learner_profile eq "Independant">

<h4><span class="badge badge-pill badge-primary bg-warning">Independant Learner</span></h4>
<ul>
<li>The <strong>Independant learner</strong> enjoys solitude as well as observing the environment.</li>
<li>You ponder on such things inwardly, rarely sharing these observations with others.</li>
<li>You absorb information best when it is not in written or oral form hence you like to look around and examine your surroundings.</li>
<li>You appreciate material with illustration more than those with numbers and letters.</li>
<li>You enjoy self-paced learning and can learn best from independent study.</li>
<li>You process information quite randomly and tend to be deductive in thinking. You also can be very agreeable to avoid conflict.</li>
</ul>
<em>The Independant learner is <strong>right-brain</strong> dominant and has an <strong>introverted</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#INT#</cfoutput> % introvert.</em>

<cfelseif learner_profile eq "Applied">

<h4><span class="badge badge-pill badge-primary bg-warning">Applied Learner</span></h4>
<ul>
<li>The <strong>Applied learner</strong> is motivated by action and concreteness.</li>
<li>He learns best by doing things himself as well as by elements he could touch, see, and feel.</li>
<li>He processes information from whole to part making him a highly deductive learner.</li>
<li>He likes socialization but doesn't mind learning on his own if the learning environment offers him concrete materials to manipulate like that of a laboratory.</li>
<li>The applied learner is highly intuitive and usually makes decisions based on gut feel.</li>
</ul>
<em>The Applied learner is <strong>right-brain</strong> dominant and has an <strong>extrovert</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#EXT#</cfoutput> % extrovert.</em>

<cfelseif learner_profile eq "Conceptual">

<h4><span class="badge badge-pill badge-primary bg-warning">Conceptual</span></h4>
<ul>
<li>The <strong>Conceptual learner</strong> thrives with abstract information. You could arrive at a conclusion by just being given the bit by bit parts of a whole.</li>
<li>This is the classical way to learn, &quot;inductively&quot;, in which you are at ease.</li>
<li>You are logical and have a good sense of time. You tend to learn better through written materials so articles and texts could help you best.</li>
<li>To augment a lecture, the main points must be written down for you to see.</li>
<li>Reading and writing help you process information better as well as sequence and order so it won't come as a surprise that the conceptual learner is a list maker and relies on a daily planner.</li>
</ul>
<em>The Conceptual learner is <strong>left-brain</strong> dominant and has an <strong>introverted</strong> personality. Your results show that you are <cfoutput>#LB#</cfoutput> % left-brain and <cfoutput>#INT#</cfoutput> % introvert.</em>

<cfelseif learner_profile eq "Scholastic">

<h4><span class="badge badge-pill badge-primary bg-warning">Scholastic</span></h4>
<ul>
<li>As a <strong>scholastic learner</strong>, you truly are in your element when learning.</li>
<li>Your dominant characteristics match the elements of typical scholarly learning. These elements are: focus on linear and sequential learning reminiscent of syllabuses and lesson plans; focus on symbolic information such as numbers and letters and focus on an apt dose of socialization acquired through lectures and discussions.</li>
<li>All these make the scholastic learner very comfortable with learning as the usual set-up for learning is congruent to your strengths.
</ul>
<em>The Scholastic learner is <strong>left-brain</strong> dominant and has an <strong>extroverted</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#INT#</cfoutput> % introvert.</em>

<cfelseif learner_profile eq "Creative">

<h4><span class="badge badge-pill badge-primary bg-warning">Creative</span></h4>
<ul>
<li>The <strong>Creative learner</strong> is highly artistic.</li>
<li>The creative learner is highly artistic. You process information best when they are illustrated in visual form like pictures, graphs, drawings. You are quite sensitive to colour and are very much in touch with your emotions.</li> 
<li>You are totally non-linear in your approach to work or activity making you jump from one task to the next.</li>
<li>You can appreciate learning with others but would prefer doing things on your own.</li>
<li>You could benefit from tasks that involve producing a creative output.</li>
</ul>
<em>The Creative learner is <strong>right-brain</strong> dominant and has an <strong>introverted</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#INT#</cfoutput> % introvert.</em>

<cfelseif learner_profile eq "Analytic">

<h4><span class="badge badge-pill badge-primary bg-warning">Analytic</span></h4>
<ul>
<li>As an <strong>Analytic learner</strong>, you are self-sufficient when it comes to learning.</li>
<li>You appreciate silence and solitude in your learning environment.</li>
<li>You are very reality-based and make decisions based on reason.</li>
<li>You can run pieces of information in your mind and arrive at a conclusion without verbalizing anything.</li>
<li>On the other hand, a bit of written supplement could help you process the information.</li>
<li>You thrive on individual work involving reading and writing such as analyzing articles and reacting to them in essay form.</li>
</ul>
<em>The Analytic learner is <strong>left-brain</strong> dominant and has an <strong>introverted</strong> personality. Your results show that you are <cfoutput>#RB#</cfoutput> % right-brain and <cfoutput>#INT#</cfoutput> % introvert.</em>


<cfelseif learner_profile eq "Neutral">

<h4><span class="badge badge-pill badge-primary bg-warning">Neutral</span></h4>
<ul>
<li>The <strong>Neutral learner</strong> can learn with almost any teaching style.</li>
<li>You can thrive well in lectures, researches, videos, even games!</li>
<li>You will be able to absorb information whether you are alone or in a group, whether you are dealing with numbers, letters or images.</li>
<li>You may be seen as the ideal learner as any technique might work for you. On the other hand, since you have no real preference or tendency, you also might find it hard to get involved in the whole learning experience.</li>
</ul>
<em>The neutral learner isn&rsquo;t dominant in either hemispheres of the brain. Neither does this learner have a stronger tendency towards either introversion or extroversion. Your results show that you are 50% right-brain / 50% left-brain and 50% extrovert / 50% introvert.</em>

</ul>
</cfif>
<!---END_RM--->








<!---</cfif>--->
<cfelseif lst_display eq "brain">
<!---<cfif user_lst neq "">--->
<cfoutput><canvas id="lst_brain_#SESSION.USER_ID#" width="150" height="150"></canvas></cfoutput>

<script>
<cfoutput>var lst_brain = document.getElementById("lst_brain_#SESSION.USER_ID#");</cfoutput>
var config = {
	type: 'doughnut',
	data: {
		datasets: [{
			data: [
			<cfoutput>#LB#,#RB#,</cfoutput>              
			],
			backgroundColor: [
			"#123c65","#7ca6cf"
			]
		}],
		labels: [
			"Left Brain","Right Brain"
		]
	},
	options: {
		responsive: true,
		legend: false,
		animation: {
			animateScale: true,
			animateRotate: true
		}
	}
};

var myPieChart = new Chart(lst_brain,config);
</script>	
<!---</cfif>--->
<cfelseif lst_display eq "brain_txt">

<cfif listgetat(user_lst,1) gte listgetat(user_lst,2)>
<!---COMPLEX
<cfoutput>
	<span class="badge badge-pill badge-primary" style="background-color:#123C65">#obj_translater.get_translate('left_brain_dominance')#: #LB# %</span>
	<h5>#obj_translater.get_translate_complex('brain_process_title')#</h5>
	#obj_translater.get_translate_complex('left_brain_process_lst')#
	<h5>#obj_translater.get_translate_complex('brain_strengths_title')#</h5>
	#obj_translater.get_translate_complex('left_brain_strengths_lst')#
	<h5>#obj_translater.get_translate_complex('brain_learning_title')#</h5>
	#obj_translater.get_translate_complex('left_brain_learning_lst')#
</cfoutput>
START_RM--->
<span style="background-color:#123C65; padding:2px; font-size:14px">Left Brain dominant : <cfoutput>#LB# %</cfoutput></span>

<h5>How do you process information?</h5>
<ul>
<li>In a linear and sequential manner.</li>
<li>From smaller parts to the bigger whole.</li>
<li>You start with details, arrange these in a logical way then arrive at a conclusion.</li>
</ul>
<h5>What are you strengths?</h5>
<ul>
<li>You are comfortable with math and language because symbols such as letters and numbers are processed in the left side of the brain.</li>
<li>You are logical. You like proof and base your decisions on quantitative measures.</li>
<li>You are comfortable expressing yourself in words. Normally, you don't scramble for words when explaining yourself.</li>
<li>You are reality-based and like rules and guidelines.</li>
</ul>
<h5>In terms of learning:</h5>
<ul>
<li>You don't mind lectures and appreciate discussions.</li>
<li>You value outlines when receiving information as well as when expressing information.</li>
<li>You like to write as well as talk about abstract concepts.</li>
</ul>
<!---END_RM--->
<cfelse>
<!---COMPLEX
<cfoutput>
	<span class="badge badge-pill badge-primary" style="background-color:#123C65">#obj_translater.get_translate('right_brain_dominance')#: #LB# %</span>
	<h5>#obj_translater.get_translate_complex('brain_process_title')#</h5>
	#obj_translater.get_translate_complex('right_brain_process_lst')#
	<h5>#obj_translater.get_translate_complex('brain_strengths_title')#</h5>
	#obj_translater.get_translate_complex('right_brain_strengths_lst')#
	<h5>#obj_translater.get_translate_complex('brain_learning_title')#</h5>
	#obj_translater.get_translate_complex('right_brain_learning_lst')#
</cfoutput>
START_RM--->
<span style="background-color:#7ca6cf; padding:2px; font-size:14px">Right Brain dominant : <cfoutput>#RB# %</cfoutput></span>
<!---<cfif user_lst neq "">--->
<h5>How do you process information?</h5>
<ul>
<li>Randomly-working on more than one task at a time is not a problem.</li>
<li>From the bigger whole to the smaller parts.</li>
<li>You start with the answer, the big picture, then move to the details after.</li>
</ul>
<h5>What are you strengths?</h5>
<ul>
<li>You are good at reading and expressing emotions as these are processed in the right side of the brain.</li>
<li>You are highly intuitive. You rely on gut feel and are normally correct.</li>
<li>You are highly visual so you are great with shapes and designs. You are comfortable expressing yourself using drawings or illustrations.</li>
<li>You are also attuned to music.</li>
<li>You are fantasy-oriented and are very creative.</li>
</ul>
<h5>In terms of learning:</h5>
<ul>
<li>You appreciate visuals and lots of illustrations.</li>
<li>You value manipulatives and concreteness. You like to be able to touch and feel things.</li>
<li>You would rather write down your own dialogue rather than read another one from the books!</li>
</ul>
<!---END_RM--->
</cfif>

<!---</cfif>--->
<cfelseif lst_display eq "social">
<!---<cfif user_lst neq "">--->
<cfoutput><canvas id="lst_social_#SESSION.USER_ID#" width="150" height="150"></canvas></cfoutput>

<script>
<cfoutput>var lst_social = document.getElementById("lst_social_#SESSION.USER_ID#");</cfoutput>

var config = {
	type: 'doughnut',
	data: {
		datasets: [{
			data: [
				<cfoutput>#INT#,#EXT#,</cfoutput>             
			],
			backgroundColor: [
			   "#8eb291","#2c8834"
			]
		}],
		labels: [
		   "Introvert","Extrovert"
		]
	},
	options: {
		responsive: true,
		legend: false /*{
			position: 'top',
		}*/,
		animation: {
			animateScale: true,
			animateRotate: true
		}
	}
};

var myPieChart = new Chart(lst_social,config);
</script>	




<!---</cfif>--->
<cfelseif lst_display eq "social_txt">
<!---<cfif user_lst neq "">--->
<!---COMPLEX
<cfoutput>
<cfif listgetat(user_lst,3) gte listgetat(user_lst,4)>
	<span class="badge badge-pill badge-primary" style="background-color:#8eb291">#obj_translater.get_translate('introvert')#: #INT# %</span>
	#obj_translater.get_translate_complex('social_introvert_lst')#
<cfelse>
	<span class="badge badge-pill badge-primary" style="background-color:#2c8834">#obj_translater.get_translate('extrovert')#: #EXT# %</span>
	#obj_translater.get_translate_complex('social_extrovert_lst')#
</cfif>
</cfoutput>
START_RM--->
<cfif listgetat(user_lst,3) gte listgetat(user_lst,4)>
<span style="background-color:#8eb291; padding:2px; font-size:14px">Introvert : <cfoutput>#INT# %</cfoutput></span>
<ul>
<li>You focus inward and get energy from within.</li>
<li>You don&rsquo;t share personal information easily so usually, you are tagged as shy.</li>
<li>This doesn&rsquo;t mean you aren&rsquo;t friendly, though. In fact, you could be quite social at times but in smaller groups.</li>
<li>You don&rsquo;t easily react to situations as you need to process information before reacting. Introverts aren&rsquo;t easily swayed by other&rsquo;s opinions as well.</li>
<li>Though being alone and doing activities on your own revitalize you, you can focus on meaningful conversations for a long period of time.</li>
</ul>
<cfelse>
<span style="background-color:#8eb291; padding:2px; font-size:14px">Extrovert : <cfoutput>#EXT# %</cfoutput></span>
<ul>
<li>You focus outward and get energy from other people.</li>
<li>You are in tune with your external environment. You are highly sociable, love crowds, like excitement and are generally gregarious.</li>
<li>You usually have more-self esteem and are perceived as positive and very enthusiastic.</li>
<li>Since you get energy from others, you don't normally like to spend time alone.</li>
<li>You sometimes react too easily to situations without processing the information first. Often, this could be seen as acting without thinking.</li>
<li>On the other hand, you are great in communicating as you love being with people so you usually thrive in sales positions or in leadership roles.</li>
</ul>
</cfif>
<!---END_RM--->




<!---</cfif>--->
<cfelseif lst_display eq "sensory">
<!---<cfif user_lst neq "">--->

<cfoutput><canvas id="lst_sensory_#SESSION.USER_ID#" width="150" height="150"></canvas></cfoutput>

<script>
<cfoutput>var lst_sensory = document.getElementById("lst_sensory_#SESSION.USER_ID#");</cfoutput>
var config = {
        type: 'doughnut',
        data: {
            datasets: [{
                data: [
                   <cfoutput>#VNV#,#K#,#VV#,#AV#</cfoutput>
                ],
                backgroundColor: [
                   "#FFA100","#709A9C","#B38300","#80CAFF"
                ],
                label: 'Dataset 1'
            }],
            labels: [
                "Visual / Non-verbal",
                "Kinesthetic",
				"Visual / Verbal",
				"Auditory / Verbal",
            ]
        },
        options: {
            responsive: true,
            legend: false /*{
                position: 'top',
            }*/,
            /*title: {
                display: true,
                text: 'Chart.js Doughnut Chart'
            },*/
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }
    };
	
	
var myPieChart = new Chart(lst_sensory,config);
</script>
<!---</cfif>--->
<cfelseif lst_display eq "sensory_txt">
<!---COMPLEX
	<cfoutput>
	#obj_translater.get_translate_complex('sensory_vnv_intro')# <span style="background-color:#FFA100; padding:2px; font-size:14px"><strong>#VNV# %</strong></span><br>
	#obj_translater.get_translate_complex('sensory_k_intro')# <span style="background-color:#709A9C; padding:2px; font-size:14px"><strong>#K# %</strong></span> kinesthetic.<br>
	#obj_translater.get_translate_complex('sensory_vv_intro')# <span style="background-color:#B38300; padding:2px; font-size:14px"><strong>#VV# %</strong></span><br>
	#obj_translater.get_translate_complex('sensory_av_intro')# <span style="background-color:#80CAFF; padding:2px; font-size:14px"><strong>#AV# %</strong></span><br><br>

	<span style="background-color:#FFA100; padding:2px; font-size:14px">#obj_translater.get_translate_complex('sensory_vnv_title')#</span>
	<p>#obj_translater.get_translate_complex('sensory_vnv')#</p>
	<span style="background-color:#709A9C; padding:2px; font-size:14px">#obj_translater.get_translate_complex('sensory_k_title')#</span>
	<p>#obj_translater.get_translate_complex('sensory_k')#</p>
	<span style="background-color:#B38300; padding:2px; font-size:14px">#obj_translater.get_translate_complex('sensory_vv_title')#</span>
	<p>#obj_translater.get_translate_complex('sensory_vv')#</p>
	<span style="background-color:#80CAFF; padding:2px; font-size:14px">#obj_translater.get_translate_complex('sensory_av_title')#</span>
	<p>#obj_translater.get_translate_complex('sensory_av')#</p>
	</cfoutput>
START_RM--->
You are visual non-verbal at <span style="background-color:#FFA100; padding:2px; font-size:14px"><strong><cfoutput>#VNV# %</cfoutput></strong></span><br>
You are <span style="background-color:#709A9C; padding:2px; font-size:14px"><strong><cfoutput>#K# %</cfoutput></strong></span> kinesthetic.<br>
Results show that you&rsquo;re visual-verbal at <span style="background-color:#B38300; padding:2px; font-size:14px"><strong><cfoutput>#VV# %</cfoutput></strong></span><br>
Your audio-verbal inclination is <span style="background-color:#80CAFF; padding:2px; font-size:14px"><strong><cfoutput>#AV# %</cfoutput></strong></span><br><br>


<span style="background-color:#FFA100; padding:2px; font-size:14px">What is a Visual / Non-verbal learner ?</span>
<p>In a learning context, you will benefit from the use of any material or method which allows you to process information by seeing visuals in non-language form. Pictures, graphs, drawings, maps, photos, color-coded materials and comic strips are very helpful. You would learn best from analyzing a photo, drawing conclusions from graphs, describing, drawing, arranging information through charts, translating words to images and any activity that provides illustrations as stimuli.</p>
<span style="background-color:#709A9C; padding:2px; font-size:14px">What is a Kinesthetic learner ?</span>
<p>When trying to learn, you will profit from the use of any material or method which allows you to process information while being engaged in activity. Pod casts, articles, comic strips, whiteboard, collaboration page and sticky notes are very helpful. You would learn best by note-taking, illustrating while listening to lecture, role-playing, activities with touch-screen mode, moving around the room while following instructions, visiting real sites, and using the whiteboard.</p>
<span style="background-color:#B38300; padding:2px; font-size:14px">What is a Visual / Verbal learner ?</span>
<p>The use of any material or method which allows you to process information by reading is beneficial to you. Articles, reports, summaries, newspapers, magazines, collaboration page, blogs, sticky notes and the whiteboard are very helpful. You would learn best from outlining, reading, dictation, writing down explanations, writing dialogue for comic strips, locating key words and phrases and by blogging.</p>
<span style="background-color:#80CAFF; padding:2px; font-size:14px">What is the Auditory / Verbal inclination ?</span>
<p>It is helpful for you as a learner of this mold to use any material or method which allows you to process information by listening. Podcasts, songs with lyrics, audio programs and text 2 speech documents are very helpful. You would learn best through lectures, oral exercises, discussions, interviews, read aloud activities, recording self while reading, and talking one's way through new information.</p>
<!---</cfif>--->
</cfif>


