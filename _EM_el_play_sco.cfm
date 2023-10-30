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
    margin: 0;            
    display: flex;       /* Use flexbox to create a two-column layout */
  }
  .column {
    width: 50%;          /* Each column takes up half the width of the body */
    padding: 10px;       /* Add some padding inside each column */
  }
  iframe {
    display: block;      
    background: #000;
    border: none;        
    height: 100vh;       
    width: 100%;         /* Adjust the width to fit within the column */
  }
	</style>
</head>

<body>
				
    <div class="column">
        <!-- SCORM Content -->
        <cfoutput><iframe src="./assets/scorm/#get_modules.elearning_module_path#/ressources/index.html"></iframe></cfoutput>
    </div>
    <div class="column">
        mapping point explanation
    </div>
</body>


<cfinclude template="./incl/incl_scripts.cfm">


<script>
$(document).ready(function() {
	var iframeContent;
    $('iframe').on('load', function() {
        var iframeContent = $(this).contents();

        function checkElement() {
			console.log($(this));
			
            var element = iframeContent.find('.answer-wrong p');
            if (element.length > 0) {
                var fullText = element.text();
                var textToSend = fullText.replace('Map to ', '');
                console.log('Text to send:', textToSend);

                //  AJAX call
                // $.ajax({ 
                //     url: './api/mapping/mapping_get.cfc?method=getMappingSuggestion',
                //     method: 'POST',
                //     data: { text: textToSend },
                //     success: function(response) {
                //         console.log('AJAX response:', response);
                //     }
                // });

            } else {
                console.log('Element not found, retrying...');
                setTimeout(checkElement, 1000);
            }
        }

        checkElement();
        function initializeCheckIconClickListener() {
                var checkIconInterval = setInterval(function() {
                    var iconElement = iframeContent.find('.icon-chevron-right-circle-o');
                    if (iconElement.length > 0) {
                        console.log('Icon element found:', iconElement);

                        // Reinitialize checkElement on click of the <i> element with the class icon-chevron-right-circle-o
							iconElement.off('click').on('click', function() {
								var iframe = $('iframe');
    							iframeContent = $(iframe[0].contentDocument);
							console.log('Icon clicked, reinitializing checkElement...');
							setTimeout(checkElement, 1000);
						});


                        clearInterval(checkIconInterval);  // Clear the interval once the icon is found and the event listener is attached
                    } else {
                        console.log('Icon element not found, retrying...');
                    }
                }, 1000);  // Check for the icon element every 1000 milliseconds
            }
			
			initializeCheckIconClickListener();

    });
});


</script>



</html>