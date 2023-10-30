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

<cfif lst_display eq "radar">

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

	<cfif learner_profile eq "Social">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_social_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_social')#
		
		<cfset arr = ['LB', 'EXT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_social",argv="#argv#")#
		
		</cfoutput>
		
	<cfelseif learner_profile eq "Dynamic">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_dynamic_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_dynamic')#
		
		<cfset arr = ['RB', 'EXT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_dynamic",argv="#argv#")#

		</cfoutput>
		
	<cfelseif learner_profile eq "Independant">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_independant_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_independant')#
		
		<cfset arr = ['RB', 'INT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_independant",argv="#argv#")#
		
		</cfoutput>
		
	<cfelseif learner_profile eq "Applied">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_applied_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_applied')#
		
		<cfset arr = ['RB', 'EXT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_applied",argv="#argv#")#
		
		</cfoutput>
		
	<cfelseif learner_profile eq "Conceptual">

		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_conceptual_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_conceptual')#
		
		<cfset arr = ['LB', 'INT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_conceptual",argv="#argv#")#
		
		</cfoutput>
		
		
	<cfelseif learner_profile eq "Scholastic">
	
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_scholastic_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_scholastic')#
		
		<cfset arr = ['LB', 'EXT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_scholastic",argv="#argv#")#
		
		</cfoutput>
		
		
		
	<cfelseif learner_profile eq "Creative">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_creative_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_creative')#
		
		<cfset arr = ['RB', 'INT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_creative",argv="#argv#")#
		
		</cfoutput>
		
		

	<cfelseif learner_profile eq "Analytic">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_analytic_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_analytic')#
		
		<cfset arr = ['LB', 'INT']>
		<cfset argv = arrayMap(arr, function(item){return [item, evaluate(item)]})>
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_analytic", argv="#argv#")#	
		
		</cfoutput>
		
		

	<cfelseif learner_profile eq "Neutral">
		<cfoutput>
		
		<h4><span class="badge badge-pill badge-primary bg-warning mt-0">#obj_translater.get_translate('profile_neutral_lrn')#</span></h4>
		#obj_translater.get_translate_complex('lst_lrn_profile_neutral')#
		#obj_translater.get_translate_complex(id_translate="summary_lrn_profile_neutral")#
		
		</cfoutput>
		
		
	</cfif>



<cfelseif lst_display eq "brain">

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
	
<cfelseif lst_display eq "brain_txt">

	<cfif listgetat(user_lst,1) gte listgetat(user_lst,2)>

		<cfoutput>
		<h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:##123C65">#obj_translater.get_translate('left_brain_dominance')#: #LB# %</span></h4>
		<h6>#obj_translater.get_translate_complex('brain_process_title')#</h6>
		#obj_translater.get_translate_complex('left_brain_process_lst')#
		<h6>#obj_translater.get_translate_complex('brain_strengths_title')#</h6>
		#obj_translater.get_translate_complex('left_brain_strengths_lst')#
		<h6>#obj_translater.get_translate_complex('brain_learning_title')#</h6>
		#obj_translater.get_translate_complex('left_brain_learning_lst')#
		</cfoutput>
		
		<!--- <cfif SESSION.LANG_CODE eq "fr"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#123C65">Left Brain dominant: <cfoutput>#LB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>In a linear and sequential manner.</li> --->
		<!--- <li>From smaller parts to the bigger whole.</li> --->
		<!--- <li>You start with details, arrange these in a logical way then arrive at a conclusion.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are comfortable with math and language because symbols such as letters and numbers are processed in the left side of the brain.</li> --->
		<!--- <li>You are logical. You like proof and base your decisions on quantitative measures.</li> --->
		<!--- <li>You are comfortable expressing yourself in words. Normally, you don't scramble for words when explaining yourself.</li> --->
		<!--- <li>You are reality-based and like rules and guidelines.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You don't mind lectures and appreciate discussions.</li> --->
		<!--- <li>You value outlines when receiving information as well as when expressing information.</li> --->
		<!--- <li>You like to write as well as talk about abstract concepts.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "en"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#123C65">Left Brain dominant: <cfoutput>#LB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>In a linear and sequential manner.</li> --->
		<!--- <li>From smaller parts to the bigger whole.</li> --->
		<!--- <li>You start with details, arrange these in a logical way then arrive at a conclusion.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are comfortable with math and language because symbols such as letters and numbers are processed in the left side of the brain.</li> --->
		<!--- <li>You are logical. You like proof and base your decisions on quantitative measures.</li> --->
		<!--- <li>You are comfortable expressing yourself in words. Normally, you don't scramble for words when explaining yourself.</li> --->
		<!--- <li>You are reality-based and like rules and guidelines.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You don't mind lectures and appreciate discussions.</li> --->
		<!--- <li>You value outlines when receiving information as well as when expressing information.</li> --->
		<!--- <li>You like to write as well as talk about abstract concepts.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "de"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#123C65">Linke Gehirnhälftendominanz: <cfoutput>#LB# %</cfoutput></span></h4> --->
		<!--- <h6>Wie verarbeiten Sie Informationen?</h6> --->
		<!--- <ul> --->
		<!--- <li>In linearer und sequentieller Weise.</li> --->
		<!--- <li>Vom Detail bis hin zum großen Ganzen.</li> --->
		<!--- <li>Sie beginnen mit den Details, ordnen diese logisch an und kommen dann zu einer Schlussfolgerung.</li> --->
		<!--- </ul> --->
		<!--- <h6>Was sind Ihre Stärken?</h6> --->
		<!--- <ul> --->
		<!--- <li>Sie sind mit Mathematik und Sprache vertraut, da Symbole wie Buchstaben und Zahlen auf der linken Seite des Gehirns verarbeitet werden.</li> --->
		<!--- <li>Sie sind logisch denkend. Sie mögen Beweise und stützen Ihre Entscheidungen auf Fakten.</li> --->
		<!--- <li>Sie können sich gut ausdrücken und suchen normalweise nicht lange nach Worten, wenn Sie sich erklären.</li> --->
		<!--- <li>Sie sind realistisch und mögen Regeln und Richtlinien.</li> --->
		<!--- </ul> --->
		<!--- <h6>In Bezug auf das Lernen:</h6> --->
		<!--- <ul> --->
		<!--- <li>Sie haben nichts gegen Vorträge und schätzen Diskussionen.</li> --->
		<!--- <li>Sie legen Wert auf Details und achten sehr auf die Art und Weise einer Informationsübermittlung.</li> --->
		<!--- <li>Sie schreiben und sprechen gerne über abstrakte Konzepte.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "es"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#123C65">Left Brain dominant: <cfoutput>#LB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>In a linear and sequential manner.</li> --->
		<!--- <li>From smaller parts to the bigger whole.</li> --->
		<!--- <li>You start with details, arrange these in a logical way then arrive at a conclusion.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are comfortable with math and language because symbols such as letters and numbers are processed in the left side of the brain.</li> --->
		<!--- <li>You are logical. You like proof and base your decisions on quantitative measures.</li> --->
		<!--- <li>You are comfortable expressing yourself in words. Normally, you don't scramble for words when explaining yourself.</li> --->
		<!--- <li>You are reality-based and like rules and guidelines.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You don't mind lectures and appreciate discussions.</li> --->
		<!--- <li>You value outlines when receiving information as well as when expressing information.</li> --->
		<!--- <li>You like to write as well as talk about abstract concepts.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "it"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#123C65">Left Brain dominant: <cfoutput>#LB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>In a linear and sequential manner.</li> --->
		<!--- <li>From smaller parts to the bigger whole.</li> --->
		<!--- <li>You start with details, arrange these in a logical way then arrive at a conclusion.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are comfortable with math and language because symbols such as letters and numbers are processed in the left side of the brain.</li> --->
		<!--- <li>You are logical. You like proof and base your decisions on quantitative measures.</li> --->
		<!--- <li>You are comfortable expressing yourself in words. Normally, you don't scramble for words when explaining yourself.</li> --->
		<!--- <li>You are reality-based and like rules and guidelines.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You don't mind lectures and appreciate discussions.</li> --->
		<!--- <li>You value outlines when receiving information as well as when expressing information.</li> --->
		<!--- <li>You like to write as well as talk about abstract concepts.</li> --->
		<!--- </ul> --->
		<!--- </cfif> --->

	
	<cfelse>
		<cfoutput>
		<h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:##7ca6cf">#obj_translater.get_translate('right_brain_dominance')#: #RB# %</span></h4>
		<h6>#obj_translater.get_translate_complex('brain_process_title')#</h6>
		#obj_translater.get_translate_complex('right_brain_process_lst')#
		<h6>#obj_translater.get_translate_complex('brain_strengths_title')#</h6>
		#obj_translater.get_translate_complex('right_brain_strengths_lst')#
		<h6>#obj_translater.get_translate_complex('brain_learning_title')#</h6>
		#obj_translater.get_translate_complex('right_brain_learning_lst')#
		</cfoutput>
		
		<!--- <cfif SESSION.LANG_CODE eq "fr"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#7ca6cf">Right Brain dominant: <cfoutput>#RB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>Randomly-working on more than one task at a time is not a problem.</li> --->
		<!--- <li>From the bigger whole to the smaller parts.</li> --->
		<!--- <li>You start with the answer, the big picture, then move to the details after.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are good at reading and expressing emotions as these are processed in the right side of the brain.</li> --->
		<!--- <li>You are highly intuitive. You rely on gut feel and are normally correct.</li> --->
		<!--- <li>You are highly visual so you are great with shapes and designs. You are comfortable expressing yourself using drawings or illustrations.</li> --->
		<!--- <li>You are also attuned to music.</li> --->
		<!--- <li>You are fantasy-oriented and are very creative.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You appreciate visuals and lots of illustrations.</li> --->
		<!--- <li>You value manipulatives and concreteness. You like to be able to touch and feel things.</li> --->
		<!--- <li>You would rather write down your own dialogue than read another one from books!</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "en"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#7ca6cf">Right Brain dominant: <cfoutput>#RB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>Randomly-working on more than one task at a time is not a problem.</li> --->
		<!--- <li>From the bigger whole to the smaller parts.</li> --->
		<!--- <li>You start with the answer, the big picture, then move to the details after.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are good at reading and expressing emotions as these are processed in the right side of the brain.</li> --->
		<!--- <li>You are highly intuitive. You rely on gut feel and are normally correct.</li> --->
		<!--- <li>You are highly visual so you are great with shapes and designs. You are comfortable expressing yourself using drawings or illustrations.</li> --->
		<!--- <li>You are also attuned to music.</li> --->
		<!--- <li>You are fantasy-oriented and are very creative.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You appreciate visuals and lots of illustrations.</li> --->
		<!--- <li>You value manipulatives and concreteness. You like to be able to touch and feel things.</li> --->
		<!--- <li>You would rather write down your own dialogue than read another one from books!</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "de"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#7ca6cf">Rechte Gehirnhälftendominanz:  <cfoutput>#RB# %</cfoutput></span></h4> --->
		<!--- <h6>Wie verarbeiten Sie Informationen?</h6> --->
		<!--- <ul> --->
		<!--- <li>Das Arbeiten an mehr als einer Aufgabe gleichzeitig ist kein Problem.</li> --->
		<!--- <li>Vom großen Ganzen bis hin zu den Details.</li> --->
		<!--- <li>Sie beginnen mit der Antwort, sowie dem Gesamtbild, und gehen anschließend über zu den Details.</li> --->
		<!--- </ul> --->
		<!--- <h6>Was sind deine Stärken?</h6> --->
		<!--- <ul> --->
		<!--- <li>Sie können Emotionen gut lesen und auch ausdrücken, da diese auf der rechten Seite des Gehirns verarbeitet werden.</li> --->
		<!--- <li>Sie sind sehr intuitiv. Sie verlassen sich häufig auf Ihr Bauchgefühl und liegen damit meist richtig.</li> --->
		<!--- <li>Sie sind sehr visuell veranlagt, können also gut mit Formen und Designs umgehen. Es fällt Ihnen nicht schwer sich mit Hilfe von Zeichnungen oder Illustrationen auszudrücken.</li> --->
		<!--- <li>Sie sind positiv zur Musik eingestellt.</li> --->
		<!--- <li>Sie sind fantasievoll und sehr kreativ.</li> --->
		<!--- </ul> --->
		<!--- <h6>In Bezug auf das Lernen:</h6> --->
		<!--- <ul> --->
		<!--- <li>Sie bevorzugen Bilder und Illustrationen.</li> --->
		<!--- <li>Sie legen Wert auf Vollständigkeit und Konkretheit. Sie möchten Dinge berühren und fühlen können.</li> --->
		<!--- <li>Sie schreiben lieber Ihren eigenen Dialog auf, als einen anderen aus den Büchern zu lesen!</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "es"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#7ca6cf">Right Brain dominant: <cfoutput>#RB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>Randomly-working on more than one task at a time is not a problem.</li> --->
		<!--- <li>From the bigger whole to the smaller parts.</li> --->
		<!--- <li>You start with the answer, the big picture, then move to the details after.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are good at reading and expressing emotions as these are processed in the right side of the brain.</li> --->
		<!--- <li>You are highly intuitive. You rely on gut feel and are normally correct.</li> --->
		<!--- <li>You are highly visual so you are great with shapes and designs. You are comfortable expressing yourself using drawings or illustrations.</li> --->
		<!--- <li>You are also attuned to music.</li> --->
		<!--- <li>You are fantasy-oriented and are very creative.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You appreciate visuals and lots of illustrations.</li> --->
		<!--- <li>You value manipulatives and concreteness. You like to be able to touch and feel things.</li> --->
		<!--- <li>You would rather write down your own dialogue than read another one from books!</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "it"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#7ca6cf">Right Brain dominant: <cfoutput>#RB# %</cfoutput></span></h4> --->
		<!--- <h6>How do you process information?</h6> --->
		<!--- <ul> --->
		<!--- <li>Randomly-working on more than one task at a time is not a problem.</li> --->
		<!--- <li>From the bigger whole to the smaller parts.</li> --->
		<!--- <li>You start with the answer, the big picture, then move to the details after.</li> --->
		<!--- </ul> --->
		<!--- <h6>What are you strengths?</h6> --->
		<!--- <ul> --->
		<!--- <li>You are good at reading and expressing emotions as these are processed in the right side of the brain.</li> --->
		<!--- <li>You are highly intuitive. You rely on gut feel and are normally correct.</li> --->
		<!--- <li>You are highly visual so you are great with shapes and designs. You are comfortable expressing yourself using drawings or illustrations.</li> --->
		<!--- <li>You are also attuned to music.</li> --->
		<!--- <li>You are fantasy-oriented and are very creative.</li> --->
		<!--- </ul> --->
		<!--- <h6>In terms of learning:</h6> --->
		<!--- <ul> --->
		<!--- <li>You appreciate visuals and lots of illustrations.</li> --->
		<!--- <li>You value manipulatives and concreteness. You like to be able to touch and feel things.</li> --->
		<!--- <li>You would rather write down your own dialogue than read another one from books!</li> --->
		<!--- </ul> --->
		<!--- </cfif> --->
	
	</cfif>


<cfelseif lst_display eq "social">

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
			legend: false,
			animation: {
				animateScale: true,
				animateRotate: true
			}
		}
	};

	var myPieChart = new Chart(lst_social,config);
	</script>	


<cfelseif lst_display eq "social_txt">

	
	<cfif listgetat(user_lst,3) gte listgetat(user_lst,4)>
	
	<cfoutput>
	<h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:##8eb291">#obj_translater.get_translate('introvert')#: #INT# %</span></h4>
	#obj_translater.get_translate_complex('social_introvert_lst')#
	</cfoutput>
	
		<!--- <cfif SESSION.LANG_CODE eq "fr"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#8eb291">Introvert: <cfoutput>#INT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus inward and get energy from within.</li> --->
		<!--- <li>You don&rsquo;t share personal information easily so usually, you are tagged as shy.</li> --->
		<!--- <li>This doesn&rsquo;t mean you aren&rsquo;t friendly, though. In fact, you could be quite social at times but in smaller groups.</li> --->
		<!--- <li>You don&rsquo;t easily react to situations as you need to process information before reacting. Introverts aren&rsquo;t easily swayed by other&rsquo;s opinions as well.</li> --->
		<!--- <li>Though being alone and doing activities on your own revitalize you, you can focus on meaningful conversations for a long period of time.</li> --->
		<!--- </ul>	 --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "en"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#8eb291">Introvert: <cfoutput>#INT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus inward and get energy from within.</li> --->
		<!--- <li>You don&rsquo;t share personal information easily so usually, you are tagged as shy.</li> --->
		<!--- <li>This doesn&rsquo;t mean you aren&rsquo;t friendly, though. In fact, you could be quite social at times but in smaller groups.</li> --->
		<!--- <li>You don&rsquo;t easily react to situations as you need to process information before reacting. Introverts aren&rsquo;t easily swayed by other&rsquo;s opinions as well.</li> --->
		<!--- <li>Though being alone and doing activities on your own revitalize you, you can focus on meaningful conversations for a long period of time.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "de"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#8eb291">Introvertiert: <cfoutput>#INT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>Sie konzentrieren sich auf Ihre innere Stimme und erhalten die meiste Energie durch Sie selbst.</li> --->
		<!--- <li>Sie geben persönliche Informationen nicht einfach weiter, daher werden Sie oftmals als schüchtern und zurückhaltend eingestuft.</li> --->
		<!--- <li>Das heißt aber nicht, dass Sie nicht freundlich sind. In der Tat könnten Sie sehr sozial sein, Sie fühlen sich aber eher in kleineren Gruppen wohl.</li> --->
		<!--- <li>Sie reagieren nie kopflos auf bestimmte Situationen, da Sie Informationen zunächst verarbeiten und überdenken müssen, bevor Sie reagieren können. Auch haben Sie eine starke Meinung und lassen sich nicht leicht von den Ideen und Argumenten anderer beeinflussen.</li> --->
		<!--- <li>Sie sind gerne alleine und haben kein Problem damit auch diverse Aktivitäten alleine durchzuführen. Sie können sich über einen längeren Zeitraum auf tiefgründige Gespräche einlassen ohne die Konzentration oder Kontrolle zu verlieren.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "es"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#8eb291">Introvert: <cfoutput>#INT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus inward and get energy from within.</li> --->
		<!--- <li>You don&rsquo;t share personal information easily so usually, you are tagged as shy.</li> --->
		<!--- <li>This doesn&rsquo;t mean you aren&rsquo;t friendly, though. In fact, you could be quite social at times but in smaller groups.</li> --->
		<!--- <li>You don&rsquo;t easily react to situations as you need to process information before reacting. Introverts aren&rsquo;t easily swayed by other&rsquo;s opinions as well.</li> --->
		<!--- <li>Though being alone and doing activities on your own revitalize you, you can focus on meaningful conversations for a long period of time.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "it"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#8eb291">Introvert: <cfoutput>#INT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus inward and get energy from within.</li> --->
		<!--- <li>You don&rsquo;t share personal information easily so usually, you are tagged as shy.</li> --->
		<!--- <li>This doesn&rsquo;t mean you aren&rsquo;t friendly, though. In fact, you could be quite social at times but in smaller groups.</li> --->
		<!--- <li>You don&rsquo;t easily react to situations as you need to process information before reacting. Introverts aren&rsquo;t easily swayed by other&rsquo;s opinions as well.</li> --->
		<!--- <li>Though being alone and doing activities on your own revitalize you, you can focus on meaningful conversations for a long period of time.</li> --->
		<!--- </ul> --->
		<!--- </cfif> --->
		
	<cfelse>
		<cfoutput>
		<h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:##2c8834">#obj_translater.get_translate('extrovert')#: #EXT# %</span></h4>
		#obj_translater.get_translate_complex('social_extrovert_lst')#
		</cfoutput>
		<!--- <cfif SESSION.LANG_CODE eq "fr"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#2c8834">Extrovert: <cfoutput>#EXT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus outward and get energy from other people.</li> --->
		<!--- <li>You are in tune with your external environment. You are highly sociable, love crowds, like excitement and are generally gregarious.</li> --->
		<!--- <li>You usually have more-self esteem and are perceived as positive and very enthusiastic.</li> --->
		<!--- <li>Since you get energy from others, you don't normally like to spend time alone.</li> --->
		<!--- <li>You sometimes react too easily to situations without processing the information first. Often, this could be seen as acting without thinking.</li> --->
		<!--- <li>On the other hand, you are great in communicating as you love being with people so you usually thrive in sales positions or in leadership roles.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "en"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#2c8834">Extrovert: <cfoutput>#EXT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus outward and get energy from other people.</li> --->
		<!--- <li>You are in tune with your external environment. You are highly sociable, love crowds, like excitement and are generally gregarious.</li> --->
		<!--- <li>You usually have more-self esteem and are perceived as positive and very enthusiastic.</li> --->
		<!--- <li>Since you get energy from others, you don't normally like to spend time alone.</li> --->
		<!--- <li>You sometimes react too easily to situations without processing the information first. Often, this could be seen as acting without thinking.</li> --->
		<!--- <li>On the other hand, you are great in communicating as you love being with people so you usually thrive in sales positions or in leadership roles.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "de"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#2c8834">Extrovertiert: <cfoutput>#EXT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>Sie konzentrieren sich auf Ihre Umgebung und erhalten Energie von anderen Menschen.</li> --->
		<!--- <li>Sie sind im Einklang mit Ihrer Wirkung auf Ihre Mitmenschen und Ihre Umgebung. Sie sind sehr kontaktfreudig, lieben Menschenmassen, mögen Aufregung und sind im Allgemeinen gesellig.</li> --->
		<!--- <li>Sie haben ein gutes Selbstwertgefühl und werden als positiv und sehr enthusiastisch wahrgenommen.</li> --->
		<!--- <li>Da Sie Ihre Energie von Ihren Mitmenschen erhalten, verbringen Sie normalerweise kaum Zeit allein.</li> --->
		<!--- <li>Sie reagieren manchmal aber zu schnell auf bestimmte Situationen, ohne die Informationen vorerst abzuschätzen und zu verarbeiten. Oft kann dies als Handeln ohne nachdenken angesehen werden.</li> --->
		<!--- <li>Sie können hervorragend kommunizieren, da Sie den Austausch mit anderen Menschen lieben. Personen wie Sie sind oft in Verkaufspositionen oder in Führungspositionen sehr erfolgreich.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "es"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#2c8834">Extrovert: <cfoutput>#EXT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus outward and get energy from other people.</li> --->
		<!--- <li>You are in tune with your external environment. You are highly sociable, love crowds, like excitement and are generally gregarious.</li> --->
		<!--- <li>You usually have more-self esteem and are perceived as positive and very enthusiastic.</li> --->
		<!--- <li>Since you get energy from others, you don't normally like to spend time alone.</li> --->
		<!--- <li>You sometimes react too easily to situations without processing the information first. Often, this could be seen as acting without thinking.</li> --->
		<!--- <li>On the other hand, you are great in communicating as you love being with people so you usually thrive in sales positions or in leadership roles.</li> --->
		<!--- </ul> --->
		
		<!--- <cfelseif SESSION.LANG_CODE eq "it"> --->
		<!--- <h4 class="mt-0"><span class="badge badge-pill badge-primary" style="background-color:#2c8834">Extrovert: <cfoutput>#EXT# %</cfoutput></span></h4> --->
		<!--- <ul> --->
		<!--- <li>You focus outward and get energy from other people.</li> --->
		<!--- <li>You are in tune with your external environment. You are highly sociable, love crowds, like excitement and are generally gregarious.</li> --->
		<!--- <li>You usually have more-self esteem and are perceived as positive and very enthusiastic.</li> --->
		<!--- <li>Since you get energy from others, you don't normally like to spend time alone.</li> --->
		<!--- <li>You sometimes react too easily to situations without processing the information first. Often, this could be seen as acting without thinking.</li> --->
		<!--- <li>On the other hand, you are great in communicating as you love being with people so you usually thrive in sales positions or in leadership roles.</li> --->
		<!--- </ul> --->
		<!--- </cfif> --->
	</cfif>



<cfelseif lst_display eq "sensory">


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

<cfelseif lst_display eq "sensory_txt">

	<cfoutput>
	<cfset txt_vnv = "<p class='mt-2 pl-3'>#obj_translater.get_translate_complex('sensory_vnv')#</p>">
	<cfset txt_k = "<p class='mt-2 pl-3'>#obj_translater.get_translate_complex('sensory_k')#</p>">
	<cfset txt_vv = "<p class='mt-2 pl-3'>#obj_translater.get_translate_complex('sensory_vv')#</p>">
	<cfset txt_av = "<p class='mt-2 pl-3'>#obj_translater.get_translate_complex('sensory_av')#</p>">
	
	<cfset listgo = "#VNV#|VNV|FFA100|#obj_translater.get_translate('perception_visual_nv')#,#K#|K|709A9C|#obj_translater.get_translate('perception_kinesthetic')#,#VV#|VV|B38300|#obj_translater.get_translate('perception_visual_verbal')#,#AV#|AV|80CAFF|#obj_translater.get_translate('perception_audio_verbal')#">
	<cfset listgo = listsort(listgo,"Text","desc")>
	</cfoutput>
	
	<cfloop list="#listgo#" index="cor">
	<cfoutput>
	<cfset val_temp_1 = listgetat(cor,1,"|")>
	<cfset val_temp_2 = listgetat(cor,2,"|")>
	<cfset val_temp_3 = listgetat(cor,3,"|")>
	<cfset val_temp_4 = listgetat(cor,4,"|")>
	<cfset badge_size = "1.#val_temp_1#">
	<cfset badge_size = badge_size*1.5>
	<span class="badge badge-pill badge-primary" style="background-color:###val_temp_3#; font-size:#badge_size#em"><strong>#val_temp_4# : #val_temp_1# %</strong></span> <br>
	#evaluate("txt_#val_temp_2#")#
	</cfoutput>
	</cfloop>
	
	<!--- <cfif SESSION.LANG_CODE eq "fr"> --->
	
		<!--- <cfset txt_vnv = "<p class='mt-2 pl-3'>In a learning context, you will benefit from the use of any material or method which allows you to process information by seeing visuals in non-language form. Pictures, graphs, drawings, maps, photos, color-coded materials and comic strips are very helpful. You would learn best from analyzing a photo, drawing conclusions from graphs, describing, drawing, arranging information through charts, translating words to images and any activity that provides illustrations as stimuli.</p>"> --->
		<!--- <cfset txt_k = "<p class='mt-2 pl-3'>When trying to learn, you will profit from the use of any material or method which allows you to process information while being engaged in activity. Pod casts, articles, comic strips, whiteboard, collaboration page and sticky notes are very helpful. You would learn best by note-taking, illustrating while listening to lecture, role-playing, activities with touch-screen mode, moving around the room while following instructions, visiting real sites, and using the whiteboard.</p>"> --->
		<!--- <cfset txt_vv = "<p class='mt-2 pl-3'>The use of any material or method which allows you to process information by reading is beneficial to you. Articles, reports, summaries, newspapers, magazines, collaboration page, blogs, sticky notes and the whiteboard are very helpful. You would learn best from outlining, reading, dictation, writing down explanations, writing dialogue for comic strips, locating key words and phrases and by blogging.</p>"> --->
		<!--- <cfset txt_av = "<p class='mt-2 pl-3'>It is helpful for you as a learner of this mould to use any material or method which allows you to process information by listening. Podcasts, songs with lyrics, audio programs and text 2 speech documents are very helpful. You would learn best through lectures, oral exercises, discussions, interviews, read aloud activities, recording self while reading, and talking one's way through new information.</p>"> --->
		
		<!--- <cfset listgo = "#VNV#|VNV|FFA100|Visuel / Non verbal,#K#|K|709A9C|Kinésthésique,#VV#|VV|B38300|Visuel / Verbal,#AV#|AV|80CAFF|Audio / Verbal"> --->
		<!--- <cfset listgo = listsort(listgo,"Text","desc")> --->

		<!--- <cfloop list="#listgo#" index="cor"> --->
		<!--- <cfoutput> --->
		<!--- <cfset val_temp_1 = listgetat(cor,1,"|")> --->
		<!--- <cfset val_temp_2 = listgetat(cor,2,"|")> --->
		<!--- <cfset val_temp_3 = listgetat(cor,3,"|")> --->
		<!--- <cfset val_temp_4 = listgetat(cor,4,"|")> --->
		<!--- <cfset badge_size = "1.#val_temp_1#"> --->
		<!--- <cfset badge_size = badge_size*1.5> --->
		<!--- <span class="badge badge-pill badge-primary" style="background-color:###val_temp_3#; font-size:#badge_size#em"><strong>#val_temp_4# : <cfoutput>#val_temp_1# %</cfoutput></strong></span> <br> --->
		<!--- #evaluate("txt_#val_temp_2#")# --->
		<!--- </cfoutput> --->
		<!--- </cfloop> --->
		

	<!--- <cfelseif SESSION.LANG_CODE eq "en"> --->
	
		<!--- <cfset txt_vnv = "<p class='mt-2 pl-3'>In a learning context, you will benefit from the use of any material or method which allows you to process information by seeing visuals in non-language form. Pictures, graphs, drawings, maps, photos, color-coded materials and comic strips are very helpful. You would learn best from analyzing a photo, drawing conclusions from graphs, describing, drawing, arranging information through charts, translating words to images and any activity that provides illustrations as stimuli.</p>"> --->
		<!--- <cfset txt_k = "<p class='mt-2 pl-3'>When trying to learn, you will profit from the use of any material or method which allows you to process information while being engaged in activity. Pod casts, articles, comic strips, whiteboard, collaboration page and sticky notes are very helpful. You would learn best by note-taking, illustrating while listening to lecture, role-playing, activities with touch-screen mode, moving around the room while following instructions, visiting real sites, and using the whiteboard.</p>"> --->
		<!--- <cfset txt_vv = "<p class='mt-2 pl-3'>The use of any material or method which allows you to process information by reading is beneficial to you. Articles, reports, summaries, newspapers, magazines, collaboration page, blogs, sticky notes and the whiteboard are very helpful. You would learn best from outlining, reading, dictation, writing down explanations, writing dialogue for comic strips, locating key words and phrases and by blogging.</p>"> --->
		<!--- <cfset txt_av = "<p class='mt-2 pl-3'>It is helpful for you as a learner of this mould to use any material or method which allows you to process information by listening. Podcasts, songs with lyrics, audio programs and text 2 speech documents are very helpful. You would learn best through lectures, oral exercises, discussions, interviews, read aloud activities, recording self while reading, and talking one's way through new information.</p>"> --->
		
		<!--- <cfset listgo = "#VNV#|VNV|FFA100|Visual/Non-verbal,#K#|K|709A9C|Kinesthetic,#VV#|VV|B38300|Visual/Verbal,#AV#|AV|80CAFF|Audio/Verbal"> --->
		<!--- <cfset listgo = listsort(listgo,"Text","desc")> --->

		<!--- <cfloop list="#listgo#" index="cor"> --->
		<!--- <cfoutput> --->
		<!--- <cfset val_temp_1 = listgetat(cor,1,"|")> --->
		<!--- <cfset val_temp_2 = listgetat(cor,2,"|")> --->
		<!--- <cfset val_temp_3 = listgetat(cor,3,"|")> --->
		<!--- <cfset val_temp_4 = listgetat(cor,4,"|")> --->
		<!--- <cfset badge_size = "1.#val_temp_1#"> --->
		<!--- <cfset badge_size = badge_size*1.5> --->
		<!--- <span class="badge badge-pill badge-primary" style="background-color:###val_temp_3#; font-size:#badge_size#em"><strong>#val_temp_4# : <cfoutput>#val_temp_1# %</cfoutput></strong></span> <br> --->
		<!--- #evaluate("txt_#val_temp_2#")# --->
		<!--- </cfoutput> --->
		<!--- </cfloop> --->
		
	<!--- <cfelseif SESSION.LANG_CODE eq "de"> --->
	
		<!--- <cfset txt_vnv = "<p class='mt-2 pl-3'>In einem Lernkontext profitieren Sie von der Verwendung von Material oder Methoden, mit denen Sie Informationen verarbeiten können, indem Sie Bilder in nichtsprachlicher Form anzeigen. Bilder, Grafiken, Zeichnungen, Karten, Fotos, farbcodierte Materialien und Comics sind sehr hilfreich. Sie lernen am besten, indem Sie ein Foto analysieren, Schlussfolgerungen aus Grafiken ziehen, beschreiben, zeichnen, Informationen in Diagrammen anordnen, Wörter in Bilder übersetzen und alle Aktivitäten ausführen, die Illustrationen als Anregungen liefern.</p>"> --->
		<!--- <cfset txt_k = "<p class='mt-2 pl-3'>Wenn Sie versuchen Neues zu lernen, profitieren Sie von der Verwendung von Material oder Methoden, mit denen Sie Informationen verarbeiten können, während Sie aktiv sind. Podcasts, Artikel, Comics, Whiteboards, Kollaborationsseiten und Haftnotizen sind sehr hilfreich. Sie lernen am besten, indem Sie sich während des Zuhörens Notizen machen, Vorlesungen illustrieren, Rollenspiele spielen, Aktivitäten im Touchscreen-Modus ausführen, sich im Raum bewegen, Anweisungen befolgen, reale Websites besuchen und das Whiteboard verwenden.</p>"> --->
		<!--- <cfset txt_vv = "<p class='mt-2 pl-3'>Die Verwendung von Material oder Methoden, mit denen Sie Informationen durch Lesen verarbeiten können, ist für Sie von Vorteil. Artikel, Berichte, Zusammenfassungen, Zeitungen, Magazine, Kollaborationsseiten, Blogs, Haftnotizen und das Whiteboard sind sehr hilfreich. Sie lernen am besten, indem Sie skizzieren, lesen, diktieren, Erklärungen aufschreiben, Dialoge für Comics schreiben, Schlüsselwörter und -phrasen finden und bloggen.</p>"> --->
		<!--- <cfset txt_av = "<p class='mt-2 pl-3'>Für Sie als Lerner dieser Form ist es hilfreich, jedes Material oder jede Methode zu verwenden, mit der Sie Informationen durch Zuhören verarbeiten können. Podcasts, Songs mit Texten, Audioprogramme und Text 2-Sprachdokumente sind sehr hilfreich. Sie lernen am besten durch Vorträge, mündliche Übungen, Diskussionen, Interviews, Vorlesen von Aktivitäten. Auch das Aufzeichnen des eigenen Gesprochenen, sowie das laute Vorlesen von neuen Informationen, kann große Lernerfolge erzielen.</p>"> --->
		
		<!--- <cfset listgo = "#VNV#|VNV|FFA100|Visuell nonverbal,#K#|K|709A9C|Kinästhetisch,#VV#|VV|B38300|Visuell verbal,#AV#|AV|80CAFF|Auditiv verbal"> --->
		<!--- <cfset listgo = listsort(listgo,"Text","desc")> --->

		<!--- <cfloop list="#listgo#" index="cor"> --->
		<!--- <cfoutput> --->
		<!--- <cfset val_temp_1 = listgetat(cor,1,"|")> --->
		<!--- <cfset val_temp_2 = listgetat(cor,2,"|")> --->
		<!--- <cfset val_temp_3 = listgetat(cor,3,"|")> --->
		<!--- <cfset val_temp_4 = listgetat(cor,4,"|")> --->
		<!--- <cfset badge_size = "1.#val_temp_1#"> --->
		<!--- <cfset badge_size = badge_size*1.5> --->
		<!--- <span class="badge badge-pill badge-primary" style="background-color:###val_temp_3#; font-size:#badge_size#em"><strong>#val_temp_4#: <cfoutput>#val_temp_1# %</cfoutput></strong></span> <br> --->
		<!--- #evaluate("txt_#val_temp_2#")# --->
		<!--- </cfoutput> --->
		<!--- </cfloop> --->


	
	<!--- <cfelseif SESSION.LANG_CODE eq "es"> --->
	<!--- You are visual non-verbal at <span class="badge badge-pill badge-primary" style="background-color:#FFA100; font-size:15px"><strong><cfoutput>#VNV# %</cfoutput></strong></span><br> --->
	<!--- You are <span class="badge badge-pill badge-primary" style="background-color:#709A9C; font-size:15px"><strong><cfoutput>#K# %</cfoutput></strong></span> kinesthetic.<br> --->
	<!--- Results show that you&rsquo;re visual-verbal at <span class="badge badge-pill badge-primary" style="background-color:#B38300; font-size:15px"><strong><cfoutput>#VV# %</cfoutput></strong></span><br> --->
	<!--- Your audio-verbal inclination is <span class="badge badge-pill badge-primary" style="background-color:#80CAFF; font-size:15px"><strong><cfoutput>#AV# %</cfoutput></strong></span><br><br> --->

	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#FFA100">What is a Visual / Non-verbal learner ?</span></h4> --->
	<!--- <p>In a learning context, you will benefit from the use of any material or method which allows you to process information by seeing visuals in non-language form. Pictures, graphs, drawings, maps, photos, color-coded materials and comic strips are very helpful. You would learn best from analyzing a photo, drawing conclusions from graphs, describing, drawing, arranging information through charts, translating words to images and any activity that provides illustrations as stimuli.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#709A9C">What is a Kinesthetic learner ?</span></h4> --->
	<!--- <p>When trying to learn, you will profit from the use of any material or method which allows you to process information while being engaged in activity. Pod casts, articles, comic strips, whiteboard, collaboration page and sticky notes are very helpful. You would learn best by note-taking, illustrating while listening to lecture, role-playing, activities with touch-screen mode, moving around the room while following instructions, visiting real sites, and using the whiteboard.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#B38300">What is a Visual / Verbal learner ?</span></h4> --->
	<!--- <p>The use of any material or method which allows you to process information by reading is beneficial to you. Articles, reports, summaries, newspapers, magazines, collaboration page, blogs, sticky notes and the whiteboard are very helpful. You would learn best from outlining, reading, dictation, writing down explanations, writing dialogue for comic strips, locating key words and phrases and by blogging.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#80CAFF">What is the Auditory / Verbal inclination ?</span></h4> --->
	<!--- <p>It is helpful for you as a learner of this mould to use any material or method which allows you to process information by listening. Podcasts, songs with lyrics, audio programs and text 2 speech documents are very helpful. You would learn best through lectures, oral exercises, discussions, interviews, read aloud activities, recording self while reading, and talking one's way through new information.</p> --->

	<!--- <cfelseif SESSION.LANG_CODE eq "it"> --->
	<!--- You are visual non-verbal at <span class="badge badge-pill badge-primary" style="background-color:#FFA100; font-size:15px"><strong><cfoutput>#VNV# %</cfoutput></strong></span><br> --->
	<!--- You are <span class="badge badge-pill badge-primary" style="background-color:#709A9C; font-size:15px"><strong><cfoutput>#K# %</cfoutput></strong></span> kinesthetic.<br> --->
	<!--- Results show that you&rsquo;re visual-verbal at <span class="badge badge-pill badge-primary" style="background-color:#B38300; font-size:15px"><strong><cfoutput>#VV# %</cfoutput></strong></span><br> --->
	<!--- Your audio-verbal inclination is <span class="badge badge-pill badge-primary" style="background-color:#80CAFF; font-size:15px"><strong><cfoutput>#AV# %</cfoutput></strong></span><br><br> --->

	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#FFA100">What is a Visual / Non-verbal learner ?</span></h4> --->
	<!--- <p>In a learning context, you will benefit from the use of any material or method which allows you to process information by seeing visuals in non-language form. Pictures, graphs, drawings, maps, photos, color-coded materials and comic strips are very helpful. You would learn best from analyzing a photo, drawing conclusions from graphs, describing, drawing, arranging information through charts, translating words to images and any activity that provides illustrations as stimuli.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#709A9C">What is a Kinesthetic learner ?</span></h4> --->
	<!--- <p>When trying to learn, you will profit from the use of any material or method which allows you to process information while being engaged in activity. Pod casts, articles, comic strips, whiteboard, collaboration page and sticky notes are very helpful. You would learn best by note-taking, illustrating while listening to lecture, role-playing, activities with touch-screen mode, moving around the room while following instructions, visiting real sites, and using the whiteboard.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#B38300">What is a Visual / Verbal learner ?</span></h4> --->
	<!--- <p>The use of any material or method which allows you to process information by reading is beneficial to you. Articles, reports, summaries, newspapers, magazines, collaboration page, blogs, sticky notes and the whiteboard are very helpful. You would learn best from outlining, reading, dictation, writing down explanations, writing dialogue for comic strips, locating key words and phrases and by blogging.</p> --->
	<!--- <h4><span class="badge badge-pill badge-primary" style="background-color:#80CAFF">What is the Auditory / Verbal inclination ?</span></h4> --->
	<!--- <p>It is helpful for you as a learner of this mould to use any material or method which allows you to process information by listening. Podcasts, songs with lyrics, audio programs and text 2 speech documents are very helpful. You would learn best through lectures, oral exercises, discussions, interviews, read aloud activities, recording self while reading, and talking one's way through new information.</p> --->

	<!--- </cfif> --->
	
</cfif>


