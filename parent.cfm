<!DOCTYPE html>

<cfset title_page = "Ratings Project">
<cfset __btn_note = obj_translater.get_translate('btn_note')>
<cfoutput><html lang="#SESSION.LANG_CODE#"></cfoutput>

<head>
<!---------------------------- Make sure user is logged in ------------------------------------->
	<cfif not isdefined("SESSION.USER_ID")>
		<cfinclude template="./incl/incl_head_light.cfm">
	<cfelse>
		<cfinclude template="./incl/incl_head.cfm">
	</cfif>
	
<!---TODO:  //!traits de personnalites: si vous aviez a choisir trois traits de personnalites parmis les suivants, lesquels definissent mieux ce pro --->

<!---------------------------- Set Variables for lessonsession ------------------------------------->

	<cfset u_id = 5765> 
	<cfset l_id = 243460> 
	<cfset t_id =  151>

	<!--- <cfset u_lg = SESSION.LANG_CODE>  --->
	
	
	<!--- <cfdump var=#u_id#> ---> <!--- FIXME: <cfset u_id = SESSION.USER_ID> ---> 
	<!---FIXME: <cfset l_id = URL.lesson_id>--->
	<!--- <cfset get_lesson = obj_query.oget_lesson(l_id="#l_id#",u_id="#SESSION.USER_ID#")>  --->
<!------------------------------------------ Queries --------------------------------------------------------->
 <!---------------------------- Set Trainer for lessonsession //!beware, planner id is trainer id here ------------------------------------->
	<!--- <cfquery name="get_lesson_trainer" datasource="#SESSION.BDDSOURCE#">
		SELECT  l.planner_id as t_id, u.user_id, u.user_firstname as firstname, u.user_name as lastname, l.lesson_id
		FROM lms_lesson2 as l
		LEFT JOIN user as u ON l.user_id = u.user_id
		WHERE
			l.lesson_id = <cfqueryparam value="#l_id#" cfsqltype="cf_sql_integer" />
		AND u.user_id = <cfqueryparam value="#u_id#" cfsqltype="cf_sql_integer" />
	</cfquery>
	<cfset t_id = get_lesson_trainer.t_id>  --->

	<!-------------------------------------------------- End of Queries 	-------------------------------------------------------------->
	<style>
		.emotion-style-globalRating:hover{
			transform: scale(1.3);
			color: green;
		}
	</style>
	<link href="./assets/css/badges.css" rel="stylesheet"/>
	<cfinclude template="./incl/incl_head.cfm">
</head>
<body>
	<div class="wrapper"> 
		<cfinclude template="./incl/incl_sidebar.cfm">
		<div class="main-panel">	
			
				
					
					
			<cfinclude template="./incl/incl_nav.cfm">
			<div class="content">
				<div>Here is how the badges and personality voting system will work.
					There are 5 levels of badges. A trainer gets the first level badge when 5 different learners have voted for them and moves on to the next level once they receive 5 additional votes from different learners for the same badge.
					For personalities, a trainer "acquires" a personality trait once only two learners votes for that trait. However, the amount of votes will show up next to the personality badge.
			 </div>	
				<div class="container-fluid">
					
					<cfinvoke component="api/ratings/badges_get" method="oget_lessontype" returnvariable="get_lesson_type">
						<cfinvokeargument name="l_id" value="#l_id#">
					</cfinvoke>		
									
						<cfif ( !isDefined(get_lesson_type.level))><cfset lesson_level=1> 
						<cfelse> <cfset lesson_level="#get_lesson_type.level#"></cfif> 
						<cfif (!isDefined(get_lesson_type.method))> <cfset  lesson_method=1>
						<cfelse><cfset lesson_method="#get_lesson_type.method#"> </cfif> 
							
						<cfoutput >
						<button class="btn btn-sm btn-outline-info btn_note_lesson" id="l_#l_id#">#__btn_note#<br><i class="fal fa-star fa-2x mt-2"></i></button>				
						</cfoutput>		
				</div>
				<div id="globalRating">
					
					
				</div>
			</div>
		</div>
	</div>
	<div><cfinclude template="./incl/incl_footer.cfm"></div>	
	<cfinclude template="./incl/incl_scripts.cfm">
	<cfinclude template="./incl/incl_scripts_modal.cfm">

	

	<script src="./node_modules/emotion-ratings/dist/emotion-ratings.js"></script>

	<script>
		console.log('You are running jQuery version: ' + $.fn.jquery)
	
			$('.btn_note_lesson').click(function(){
			event.preventDefault();
			var idtemp = $(this).attr("id");
			var idtemp = idtemp.split("_");
			var l_id = idtemp[1];	
			$('#window_item_lg').modal({keyboard: true});
			$('#modal_title_lg').text("Lesson and Trainer Evaluation");		
			$('#modal_body_lg').load("modal_window_ratings.cfm?u_id=<cfoutput>#SESSION.USER_ID#</cfoutput>&t_id=<cfoutput>#t_id#</cfoutput>&level=<cfoutput>#lesson_level#</cfoutput>&method=<cfoutput>#lesson_method#</cfoutput>&l_id="+l_id);
			});


			var emotionsArray = {
			angry: "&#x1F620;",
			disappointed: "&#x1F61E;",
			meh: "&#x1F610;", 
			happy: "&#x1F60A;",
			smile: "&#x1F603;",
			wink: "&#x1F609;",
			laughing: "&#x1F606;",
			good: "&#x1F929;", 
			heart: "&#x2764;",
			crying: "&#x1F622;",
			star: "&#x2B50;",
			
		};
			var emotionsArray = ['crying','disappointed','meh','happy','laughing'];
			$("#globalRating").emotionsRating({
			emotions: emotionsArray,
			// background emoji
			bgEmotion: "happy",
			// size of emoji
  			emotionSize: 30,

			// number of emoji
			count: 5,

			// color of emoji
			// gold, red, blue, green, black, 
			// brown, pink, purple, orange
			color: "pink",

			// initial rating value
			initialRating: 4,

			 // input name
  			inputName: "ratings[]",

			});

	</script>


</body>
</html>



