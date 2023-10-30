<!DOCTYPE html>

<cfset title_page = "Vocalib">
<html lang="fr">

	<!--- BOOTSTRAP CSS --->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!--- FLAGS CSS --->
<link href="flags.css" rel=stylesheet type="text/css">

<head>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<cfinclude template="./incl/incl_head.cfm">

</head>


<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	
	<div class="main-panel">
			
		<cfinclude template="./incl/incl_nav.cfm">
		
		<div class="content">

			
				<!--- *************************************** CFQUERY *************************************************** --->

                    <cfquery name="get_vocab" datasource="#SESSION.BDDSOURCE#">
                   
                        SELECT * 
                        FROM lms_vocabulary_category vc
						INNER JOIN lms_vocabulary v ON vc.voc_cat_id = v.voc_cat_id
						ORDER BY vc.voc_cat_id ASC
	
                    </cfquery>



					<!--- <cfquery name="get_an_voc_id" datasource="#SESSION.BDDSOURCE#">

					SELECT voc_cat_id, voc_cat_name_fr 
					from lms_vocabulary_category 
					WHERE voc_cat_id ='1'

					</cfquery>

					<cfquery name="get_words_by_id" datasource="#SESSION.BDDSOURCE#">

					SELECT voc_word_fr 
					from lms_vocabulary 
					WHERE voc_category ='Baby'

					</cfquery> --->

					<!--- Test --->

					<!--- <cfquery  name="get_test" datasource="#SESSION.BDDSOURCE#">
						SELECT * 
						FROM lms_vocabulary v 
						INNER JOIN lms_vocabulary_category cv ON v.voc_cat_id = cv.voc_cat_id 
						ORDER BY v.voc_cat_id
					</cfquery> --->
						
					

					<!--- *************************************** CFQUERY *************************************************** --->
			
					<!--- Double cfoutput --->
					<!--- <cfoutput query="get_test" group="voc_cat_id">
						<p>#voc_cat_name_fr#</p> ----------------------------------------
						<cfoutput>
							&nbsp;<p>#voc_word_fr#</p>
						</cfoutput>
					</cfoutput> --->

					<div class="accordion accordion-flush" id="accordionFlushExample">
						<div class="accordion-item">
						  <h2 class="accordion-header" id="flush-headingOne">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
							 <!--- <cfoutput query="get_an_voc_id"> --->
								<strong>Welcome</strong>
							 <!--- </cfoutput> --->
							</button>
						  </h2>
						  <div id="flush-collapseOne" class="accordion-collapse collapsed" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
							<div class="accordion-body"> 
								<!--- <cfoutput query ="get_words_by_id" group="voc_word_fr">
								<br/>#voc_word_fr#
								<a class="btn btn-sm btn-success btn_player"><i class="fad fa-play"></i></a>
								Accents : 
								<img src="./assets/flags/blank.gif" class="flag_xs flag-fr" alt="France" />
								
								<img src="./assets/flags/blank.gif" class="flag_xs flag-de" alt="Allemagne" />

								<img src="./assets/flags/blank.gif" class="flag_xs flag-us" alt="US" />

								<img src="./assets/flags/blank.gif" class="flag_xs flag-ru" alt="Russie" />
							</br>
							</cfoutput> --->
							On this page you will find <cfoutput>#get_vocab.recordcount#</cfoutput> categories you are free to explore,</br> click on a topic and travel across.</br>
							There is thousands of words you can listen to with different languages and accents.
						</div>
						  </div>
						</div>
						<!--- <div class="accordion-item">
						  <h2 class="accordion-header" id="flush-headingTwo">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
							  Catégories
							</button>
						  </h2>
						  <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
							<div class="accordion-body">
								<cfoutput query="get_test" group="voc_cat_id">
									<span class="clickme" data-id="#voc_id#" data-catid="#voc_cat_id#" data-catnamefr=#voc_cat_name_fr#>#voc_cat_name_fr#</br>
									</span>
							  </cfoutput></div>
						  </div>
						</div> --->
						<div class="accordion-item">
						  <h2 class="accordion-header" id="flush-headingThree">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
							  <strong>Categories :</strong>
							</button>
						  </h2>
						  <div id="flush-collapseThree" class="accordion-collapse collapsed" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
							<div class="accordion-body">
								<cfoutput query="get_vocab" group="voc_cat_id">
								
								<span class="clickme" data-catid="#voc_cat_id#">#voc_cat_id# - #voc_cat_name#</br>
								</span>
                                <!--- <cfoutput>
                                    #voc_word_fr#<br>
                                </cfoutput> --->
							</cfoutput>
							</div>
						  </div>
						</div>
					  </div>
					</br>
					  



					<!--- accordion bootstrap --->

				</div>		
			</div>		
			
		</div>	
		
        <cfinclude template="./incl/incl_footer.cfm">
		
		
	</div>
</div>
  

<!--- BOOTSTRAP JS --->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!--- ************ --->

<cfinclude template="./incl/incl_scripts.cfm">
<cfinclude template="./incl/incl_scripts_modal.cfm">

<script>
	


$( document ).ready(function() {

	$('.clickme').click(function(event) {
		event.preventDefault();		
        console.log(event.target.dataset.id);
		$('#window_item_lg').modal('show');
		$('#window_item_lg').modal({keyboard: true});
	    $('#modal_title_lg').text("Vocabulaire");
		$('#modal_body_lg').load("modal_window_project_vocalib2.cfm?voc_cat_id=" + event.target.dataset.catid, function() {});
		console.log('clicked');
		
	});

	// $('.clickme2').click(function(event) {
	// 	event.preventDefault();		
    //     console.log(event.target.dataset.id);
	// 	$('#window_item_xl').modal('show');
	// 	$('#window_item_xl').modal({keyboard: true});
	//     $('#modal_title_xl').text("Vocabulary");
	// 	$('#modal_body_xl').load("modal_window_project_vocalib2.cfm?voc_cat_id=" + event.target.dataset.catid + "&voc_id=" + event.target.dataset.id + "&voc_cat_name_fr=" + event.target.dataset.catnamefr, function() {});
	// 	console.log('clicked');
		
	// });

	// $('.btn1').click(function(event) {
	// 	event.preventDefault();
	// 	console.log('clicked');
	// 	$("#window_item_lg").modal('show');
	// 	$('#window_item_lg').modal({keyboard: true});
	//     $('#modal_title_lg').text("Test modal");
	// 	// $('#modal_body_lg').load("modal_window_project_vocalib.cfm?voc_cat_id=#voc_cat_id#&voc_id=#voc_id#"+voc_cat_id +voc_id, function() {});
	// 	$('#modal_body_lg').load("modal_window_project_vocalib.cfm?voc_cat_id=" + event.target.dataset.catid + "&voc_id=" + event.target.dataset.id, function() {});
		
	// });

	// $('.close').click(function(event) {
	// 	event.preventDefault();
	// 	$("#window_item_lg").modal('hide');
	// 	$("#window_item_xl").modal('hide');
	// });
	
})
// document.ready
</script>
</body>
</html>