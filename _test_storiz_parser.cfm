<!DOCTYPE html>
<cfparam name="sco" default="699_scorm"></cfparam>
<html lang="fr">
<head>
	<cfinclude template="./incl/incl_head.cfm">

	<script>

		window.API_1484_11 = new scormRecup();

		function logTo(m){
		var obj = document.getElementById("log");
		obj.innerHTML = obj.innerHTML + m + '<br>';
		}

		var loc = 1;
		var loc_type = "page";
		var test = "0";


		function insert_page(){
		
			console.log("insert_page");
			jQuery.ajax({
				url: './api/storiz/storiz_post.cfc?method=insert_storiz_page',
				type: 'POST',
				data: {
					sco: <cfoutput>#sco#</cfoutput>,
					index: loc,
					type: loc_type,
					test: test
				},
				success : function(result, status){
					console.log(result);
					// alert("inserted");
				},
				error : function(result, status, erreur){
				},
				complete : function(result, status){
				}	
			});

		}


		function scormRecup(){

		this.min = 0;
		this.max = 0;
		this.score = -1;
		this._pre_score = -1;

		this._cur_error = 0;
		this._cur_progress = -1;
		this._pre_progress = -1;

		this.Initialize = function() {
		logTo('Initialize');
		console.log("Initialize")
		return true;
		}

		this.GetValue = function(k) {
			console.log("GetValue", k);

			if (k=='cmi.completion_status') {
				return 'incomplete';
			}

			if (k=='cmi.suspend_data') {

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
			logTo('score ' + this.score);
		}

		if(k=='cmi.score.min'){
			this.min = parseInt(v);
		}

		if(k=='cmi.score.max'){
			this.max = parseInt(v);
		}


		if(k=='cmi.exit'){
			if(v=='time-out'){
				logTo('time-out');
			}
		}
		if(k=='cmi.session_time'){

		}


		};

		this.Commit = function() {
			console.log("LMSCommit")

			if (this._cur_progress != this._pre_progress) {
				this._pre_progress = this._cur_progress;

				loc_type = "page";
				if (this.score != this._pre_score) {
					loc_type = "quiz";
					this._pre_score = this.score;
				}
				insert_page();
				loc++;
			}
			
		};

		this.Terminate = function() {
		var ratio = this.score / this.max;
		logTo(this.score + '/' + this.max);
		console.log("Terminate")

		};

		this.GetLastError = function() {
			console.log("GetLastError");
			return this._cur_error;
		};
		this.GetErrorString = function(e) {
			console.log("GetErrorString", e)
			this._cur_error = e;
		};
		this.GetDiagnostic = function(e) {
			console.log("GetDiagnostic", e)
		};

		}

	</script>
</head>

<body>
<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formulaire WEFIT">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			
			<div class="row">

				<!--- <div id="load_here">

				</div> --->
				<div id="log" style="color:green;" ></div>

                    <cfoutput><iframe src="./assets/scorm/#sco#/ressources/index.html" width="100%" height="800"></iframe></cfoutput>


					<!--- <cfoutput><iframe src="./assets/scorm/SequencingPostTestRollup4thEd_SCORM20044thEdition/shared/launchpage.html" width="100%" height="800"></iframe></cfoutput> --->

			</div>
	
		</div>
		


	</div>
	
</div>

</body>


<cfinclude template="./incl/incl_scripts.cfm">


<script>

$(document).ready(function() {
	
	// $('#load_here').load("./assets/storiz/699_scorm/ressources/index.html", function(e) {});


	// window.API_1484_11.on("Initialize", function () {
    //     alert('initialize SCORM');
    // });

	
});
</script>

</html>