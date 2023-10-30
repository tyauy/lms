<!DOCTYPE html>
<cfparam name="sco" default="699_scorm"></cfparam>
<html lang="fr">

<head>

	<!--- IMPORT --->
	<!--- <link href="./assets/css/bootstrap-4.5.3/bootstrap.min.css" rel="stylesheet" /> --->

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">



	<script>

		window.API = new scormRecup();

		function logTo(m){
		var obj = document.getElementById("log");
		obj.innerHTML = obj.innerHTML + m + '<br>';
		}

		function scormRecup(){

		this.min = 0;
		this.max = 0;
		this.score = 0;

		this.LMSInitialize = function() {
		logTo('LMSInitialize');
		console.log("LMSInitialize")
		}

		this.LMSSetValue = function(k,v) {

			console.log("LMSSetValue", k, v)

		if(k=='cmi.core.score.raw'){
		this.score = parseInt(v);
		logTo('score ' + this.score);

		}

		if(k=='cmi.core.score.min'){
		this.min = parseInt(v);
		}

		if(k=='cmi.core.score.max'){
		this.max = parseInt(v);
		}

		if(k=='cmi.core.lesson_status'){
		if(v=='incomplete'){

		}
		if(v=='completed'){
		logTo('completed');
		}
		if(v=='browsed'){

		}
		}

		if(k=='cmi.core.exit'){
		if(v=='time-out'){
		logTo('time-out');
		}
		}
		if(k=='cmi.core.session_time'){

		}


		};

		this.LMSCommit = function() {
			console.log("LMSCommit")

		};

		this.LMSFinish = function() {
		var ratio = this.score / this.max;
		logTo(this.score + '/' + this.max);
		console.log("LMSFinish")

		};

		this.LMSGetValue = function() {
		};
		this.LMSGetLastError = function() {
		};
		this.LMSGetErrorString = function(e) {
			console.log("GetErrorString", e)
		};
		this.LMSGetDiagnostic = function(e) {
			console.log("GetErrorString", e)
		};

		}

	</script>
</head>

<body>
<div class="wrapper">
    
<!---  --->
	<div id="exampleModal" class="modal">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content">
				<div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <cfoutput><iframe src="./assets/scorm/#sco#/ressources/index.html" width="100%" height="800"></iframe></cfoutput>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
<!---  --->






		<div class="content">
	  
			<a href="##" class="btn btn-sm btn_open_storiz_modal">MODALE </a>
			
			<div id="log" style="color:green;" ></div>

		</div>

	
</div>

</body>


<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>
<script src="./assets/js/plugins/bootstrap-notify.js"></script>


<script>

$(document).ready(function() {

// open on page load
	$('#exampleModal').modal('show');


	$('.btn_open_storiz_modal').click(function(event) {
		event.preventDefault();
		$('#exampleModal').modal('show');
	});


	
});
</script>

</html>