<cfparam name="sco" default="1">

<cfsilent>

	<cfinvoke component="api/tracking/tracking_post" method="insert_elearning_progress" returnVariable="insert_elearning">
		<cfinvokeargument name="user_id" value="#SESSION.USER_ID#">
		<cfinvokeargument name="module_id" value="#sco#">
	</cfinvoke>

	<cfquery name="get_esession" datasource="#SESSION.BDDSOURCE#">
		SELECT elearning_data FROM lms_elearning_module_user
		WHERE elearning_user_id = #insert_elearning#
	</cfquery>

	<cfquery name="get_modules" datasource="#SESSION.BDDSOURCE#">
		SELECT elearning_module_id, elearning_module_path FROM lms_elearning_module
		WHERE elearning_module_id   = <cfqueryparam cfsqltype="cf_sql_integer" value="#sco#">
	</cfquery>	

</cfsilent>

<!--- <cfdump var="#insert_elearning#">
<cfdump var="#get_esession#"> --->

<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">


<head>
	<cfinclude template="./incl/incl_head.cfm">

	<script>

		window.API_1484_11 = new scormRecup2004();

		// function logTo(m){
		// var obj = document.getElementById("log");
		// obj.innerHTML = obj.innerHTML + m + '<br>';
		// }

		var loc = 1;
		var loc_type = "page";
		var e_prog = 0;
		var e_data = "";
		var e_time = "";
		var e_score = 0;
		var test = "0";

		function insert_progress(){
		    localStorage.setItem("el_adv", "yes")
			// console.log(localStorage);

			// console.log("insert_progress", e_prog, e_data);
			jQuery.ajax({
				url: './api/tracking/tracking_post.cfc?method=update_elearning_progress',
				type: 'POST',
				data: {
					module_id: <cfoutput>#sco#</cfoutput>,
					elearning_user_id: <cfoutput>#insert_elearning#</cfoutput>,
					elearning_completion: e_prog,
					elearning_data: e_data,
					time_elapsed: e_time,
					elearning_score: e_score
				},
				success : function(result, status){
					// console.log(result);
					// alert("inserted");
				},
				error : function(result, status, erreur){
				},
				complete : function(result, status){
				}	
			});

		}

		function scormRecup2004(){

		this.min = 0;
		this.max = 0;
		this.score = -1;
		this._pre_score = -1;

		this._cur_error = 0;
		this._cur_progress = -1;
		this._pre_progress = -1;

		this.Initialize = function() {
			console.log("Initialize")
			sessionStorage.setItem("el_adv", "yes");
			return true;
		}

		this.GetValue = function(k) {
			// console.log("GetValue", k);

			if (k=='cmi.completion_status') {
				return 'incomplete';
			}

			if (k=='cmi.suspend_data') {
				return '<cfoutput>#get_esession.elearning_data#</cfoutput>'
			}
		};

		this.SetValue = function(k,v) {

			console.log("SetValue", k, v)

			if (k =='cmi.progress_measure') {
				test = v;
				this._cur_progress = v;
			}

			if(k=='cmi.score.raw'){
				this.score = parseInt(v);
				e_score = v;
			}

			if(k=='cmi.score.min'){
			this.min = parseInt(v);
			}

			if(k=='cmi.score.max'){
			this.max = parseInt(v);
			}

			if (k=='cmi.suspend_data') {
				e_data = v;
			}

			if(k=='cmi.core.lesson_status'){
				// console.log(v)
				// if(v=='incomplete'){

				// }
				// if(v=='completed'){
				// }
				// if(v=='browsed'){

				// }
			}

			if(k=='cmi.exit'){
			if(v=='time-out'){
			}
			}

			if(k=='cmi.session_time'){
				e_time = v;
			}


		};

		this.Commit = function() {
			console.log("Commit")

			if (this._cur_progress != this._pre_progress) {
				this._pre_progress = this._cur_progress;
				e_prog = this._cur_progress;
				insert_progress();
			}

			
			// return true;
		};

		this.Terminate = function() {
		var ratio = this.score / this.max;
		console.log(this.score + '/' + this.max);
		console.log(ratio);
		console.log("Terminate");
		};

	
		this.GetLastError = function() {
			// console.log("GetLastError");
			return this._cur_error;
		};
		this.GetErrorString = function(e) {
			// console.log("GetErrorString", e);
			this._cur_error = e;
		};
		this.GetDiagnostic = function(e) {
			// console.log("GetErrorString", e)
		};

		}

	</script>

	<style>
		body {
			margin: 0;            /* Reset default margin */
		}
		iframe {
			display: block;       /* iframes are inline by default */
			background: #000;
			border: none;         /* Reset default border */
			height: 100vh;        /* Viewport-relative units */
			width: 100vw;
		}
	</style>
</head>

<!--- <body style="margin:0px !important">

	<cfoutput><iframe src="./assets/scorm/#sco#/ressources/index.html"></iframe></cfoutput>

</body> --->

<body>
				
	<!--- <div class="row"> --->

		<!--- <div id="load_here">

		</div> --->
		<!--- <div id="log" style="color:green;" ></div> --->

		<!--- <iframe src="./assets/scorm/RuntimeBasicCalls_SCORM12/shared/launchpage.html" width="100%" height="800"></iframe> --->
		<!--- <iframe src="./assets/scorm/699_12/ressources/index.html" width="100%" height="800"></iframe> --->
		<cfoutput><iframe src="./assets/scorm/#get_modules.elearning_module_path#/ressources/index.html"></iframe></cfoutput>

	<!--- </div> --->
</body>


<cfinclude template="./incl/incl_scripts.cfm">


<script>
// $(document).ready(function() {

	
// });
</script>

</html>