<head>
    <link href="flags.css" rel=stylesheet type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<cfparam name="langue" default="EN">
<cfparam name="accent_id" default="1">
<cfparam name="voc_id" default="">

<cfparam name="formation_id" default="2">

 <!--- Querries --->
 <!--- <cfquery name="get_vocab" datasource="#SESSION.BDDSOURCE#">
                   
    SELECT * 
    FROM lms_vocabulary_category
    INNER JOIN lms_vocabulary ON lms_vocabulary_category.voc_cat_name = lms_vocabulary.voc_category
    ORDER BY `lms_vocabulary_category`.`voc_cat_id` ASC
    

</cfquery> --->

<cfquery name="get_words" datasource="#SESSION.BDDSOURCE#">
SELECT voc_word_fr, voc_word_en, voc_desc_en, voc_word_es,voc_word_de, voc_desc_fr, voc_desc_de, voc_desc_es, voc_id
FROM lms_vocabulary
WHERE voc_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#voc_cat_id#">
</cfquery>

<!--- <cfquery name="get_language" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 1, 0, 0, 0 )#">

    SELECT formation_id, formation_name_#SESSION.LANG_CODE# as language_name, formation_code
    FROM lms_formation WHERE formation_language = 1 AND formation_code = "#langue#" ORDER BY language_name

</cfquery> --->

<cfquery name="get_languages" datasource="#SESSION.BDDSOURCE#" cachedWithin="#createTimeSpan( 1, 0, 0, 0 )#">

    SELECT *
    FROM lms_formation 
    WHERE 
    formation_hiring_open = 1

</cfquery>


<cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">

    SELECT formation_accent_name_fr, formation_accent_id, formation_id,formation_accent_name_en,formation_accent_name_de,formation_accent_name_es 
    FROM lms_formation_accent 
    WHERE formation_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_id#"> 
    AND formation_accent_vocab = "1"
    ORDER BY formation_id
    
</cfquery>

<!--- <cfdump  var="#get_accent#"> --->

<!--- <cfset list_flag = "FR,EN,DE,ES">
<cfset list_formation = "1,2,3,4"> --->

<!--- <cfquery name="get_accent" datasource="#SESSION.BDDSOURCE#">
    SELECT formation_accent_id, formation_accent_name_#SESSION.LANG_CODE# as formation_accent_name FROM `lms_formation_accent` 
    WHERE `formation_id` = <cfqueryparam cfsqltype="cf_sql_integer" value="#formation_teaching_id#">
   
</cfquery> --->

<!--- Fin Querries --->

<!--- Dumps --->

<!--- <p>Formation IDs :</p>
<cfoutput query="get_language">
   <cfdump var = #formation_id#> 
</cfoutput>
</br>
</br>
<p>Matching Accents & Formations :</p>
<cfoutput query="get_accent">
    <cfdump var = #formation_id#>
</cfoutput>
</br>
</br>
<p>Accent Names :</p>
<cfoutput query="get_accent">
    <cfdump var = #formation_accent_name_fr#>
</cfoutput>
</br>
</br>
<p>Accent IDs :</p>
<cfoutput query="get_accent">
    <cfdump var = #formation_accent_id#>
</cfoutput>
</br>
</br>
<p>Formation Names :</p>
<cfoutput query="get_language">
    <cfdump var=#language_name#>
</cfoutput> --->

<!--- Fin Dumps --->

<!--- Listing Words --->

<div style="text-align: center;">
    <!--- <cfloop list="#list_flag#" index="myflag"> --->
    <cfoutput query="get_languages">
        <img src="./assets/flags/blank.gif" class="flag_xs flag-#lcase(formation_code)# btn_flag" data-id="#formation_id#" data-langue="#lcase(formation_code)#" />
    </cfoutput>
    <!--- </cfloop> --->
    <!--- <img src="./assets/flags/blank.gif" class="flag_xs flag-de" data-langue="DE"   alt="Allemagne" />
    <img src="./assets/flags/blank.gif" class="flag_xs flag-us" data-langue="EN"   alt="US" />
    <img src="./assets/flags/blank.gif" class="flag_xs flag-es" data-langue="ES"   alt="Espagne" /> --->
    </div>
    
    <table class="table">
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col"></th>
            <th scope="col"></th>

            <!--- check "evaluate" de cf / a refacto --->

            <cfoutput query="get_accent">
                <th scope="col">#formation_accent_name_fr#</th>  
                
                <!--- <cfif langue eq "FR">
                <th scope="col">#formation_accent_name_fr#</th>  
                </cfif>
                <cfif langue eq "EN">
                    <th scope="col">#formation_accent_name_en#</th>  
                    </cfif>
                    <cfif langue eq "DE">
                        <th scope="col">#formation_accent_name_en#</th>  
                        </cfif>
                        <cfif langue eq "ES">
                            <th scope="col">#formation_accent_name_en#</th>  
                            </cfif> --->
            </cfoutput>
          </tr>
        </thead>
        <tbody>
          
           
          <cfoutput query="get_words">   
               
          <tr>  
            <td>#voc_id#</td>

            

            <!--- <cfif langue eq "FR">
                <cfset formation_id = 1>
                <td class="toreplace">

                <strong>#voc_word_fr#</strong>
                </td>
                <td>#voc_desc_fr#</td>

                <cfloop query = "get_accent"> 
                <td><a class="btn btn-sm btn-success btn_player" data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#">
                <audio id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#"><source src="./assets/vocab/#formation_id#/#get_accent.formation_accent_id#/#voc_cat_id#/word_#get_words.voc_id#_#formation_id#_#get_accent.formation_accent_id#.mp3" type="audio/mp3"></audio>
                <i data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#" class="fad fa-play"></i></a></td>
                </cfloop>

           </cfif> --->





            <cfif formation_id eq 2>
            <td class="toreplace"><strong>#voc_word_en#</strong></td>
            <td>#voc_desc_en#</td>
            <!--- faire une loop sur la querry qui donne les accents / refacto / utiliser evaluate --->
            <!--- <td> --->
                
                <!--- <a class="btn btn-sm btn-success btn_player" id="player-#voc_id#-#formation_id#-#langue#"> --->
                <!--- <audio class="audio" controls="controls"><source src="./assets/vocab/#formation_id#/5/#voc_cat_id#/word_#voc_id#_#formation_id#_5.mp3" type="audio/mp3"></audio> --->
                <!--- <i class="fad fa-play"></i></a></td> --->
                
            <cfloop query = "get_accent"> 
            <td>	
                <cfif fileexists("#SESSION.BO_ROOT#/assets/vocab/#formation_id#/#get_accent.formation_accent_id#/#voc_cat_id#/word_#get_words.voc_id#_#formation_id#_#get_accent.formation_accent_id#.mp3")>	
                
                <button role="button" class="btn btn-sm btn-success btn_player" data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#">
                    <audio id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#">
                        <source src="./assets/vocab/#formation_id#/#get_accent.formation_accent_id#/#voc_cat_id#/word_#get_words.voc_id#_#formation_id#_#get_accent.formation_accent_id#.mp3" type="audio/mp3">
                    </audio>
                    

                    <!---data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#"--->
                    <!--- <i class="fad fa-play"></i> --->
                    PLAY
                </button>
                
                </cfif>
            </td>
            </cfloop>

            </cfif>
            
            <!--- <td><a class="btn btn-sm btn-success btn_player" id="player">
                <audio class="audio"><source src="./assets/vocab/#formation_id#/10/#voc_cat_id#/word_#voc_id#_#formation_id#_10.mp3" type="audio/mp3"></audio>
                <i class="fad fa-play"></i></a></td>
            
            <td><a class="btn btn-sm btn-success btn_player" id="player">
                <audio class="audio"><source src="./assets/vocab/#formation_id#/15/#voc_cat_id#/word_#voc_id#_#formation_id#_15.mp3" type="audio/mp3"></audio>
                <i class="fad fa-play"></i></a></td> --->
            <!--- check lms_translation dans la bdd pour les TH --->

                <!--- SESSION.BO_ROOT --->

            




            <!--- <cfif langue eq "ES">
                <cfset formation_id = 4>
                <td class="toreplace"><strong>#voc_word_es#</strong></td>
                <td>#voc_desc_es#</td>
                <cfloop query = "get_accent"> 
                    <td><a class="btn btn-sm btn-success btn_player" data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#">
                        <audio id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#"><source src="./assets/vocab/#formation_id#/#get_accent.formation_accent_id#/#voc_cat_id#/word_#get_words.voc_id#_#formation_id#_#get_accent.formation_accent_id#.mp3" type="audio/mp3"></audio>
                        <i data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#" class="fad fa-play"></i></a></td>
                        </cfloop>
                </cfif>




                <cfif langue eq "DE">
                    <cfset formation_id = 3>
                    <td class="toreplace"><strong>#voc_word_de#</strong></td>
                    <td>#voc_desc_de#</td>
                    <cfloop query = "get_accent"> 
                        <td><a class="btn btn-sm btn-success btn_player" data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#">
                            <audio id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#"><source src="./assets/vocab/#formation_id#/#get_accent.formation_accent_id#/#voc_cat_id#/word_#get_words.voc_id#_#formation_id#_#get_accent.formation_accent_id#.mp3" type="audio/mp3"></audio>
                            <i data-id="player-#get_words.voc_id#-#formation_id#-#get_accent.formation_accent_id#-#langue#" class="fad fa-play"></i></a></td>
                            </cfloop>   
                    </cfif> --->
          </tr>
          </cfoutput>
         
        
        </tbody>
        
      </table>	
      

<!--- //! <source src="./assets/vocab/#formation_id#/#accent_id#/#voc_cat_id#/word_#voc_id#_#formation_id#_#accent_id#.mp3" type="audio/mp3"> modele  --->


<cfinclude template="./incl/incl_scripts.cfm">
<cfinclude template="./incl/incl_scripts_modal.cfm">

<!--- //! --->
<!--- Au reload besoin que de voc_cat_id + formation_id --->
<!--- Refacto les clicks flags functions en une seule instruction --->
<!--- //! --->

<script>
$( document ).ready(function() {
console.log('modal opened');
// var audioElement = document.createElement('audio');
//         audioElement.setAttribute('src', 'http://www.uscis.gov/files/nativedocuments/Track%2093.mp3');
//         console.log(audioElement.src);
    //    PATH
        // <src="./assets/vocab/#formation_id#/#accent_id#/#voc_cat_id#/word_#voc_id#_#formation_id#_#accent_id#.mp3" type="audio/mp3"></audio></div>



        //audioElement.load()
        // $.get();
        // audioElement.addEventListener("load", function() {
        // audioElement.play();
        // }, true);


$('.btn_player').click(function(event) {
event.preventDefault();
console.log(event.target.dataset.id);
	
	document.getElementById(event.target.dataset.id).play();
    // document.getElementsByClassName('audio')[0].play()
});


$(".btn_flag").click(function(event) {

//console.log("flag fr clicked");
// $('.toreplace').replaceWith('<td class="toreplace">#voc_word_fr#</td>');
    console.log(event.target.dataset.id);
    
    $('#modal_title_lg').text("Vocabulary");
    $('#modal_body_lg').empty();
    <cfoutput>
    $('##modal_body_lg').load("modal_window_project_vocalib2.cfm?voc_cat_id=#voc_cat_id#&formation_id="+event.target.dataset.id, function() {});
    </cfoutput>
    console.log('modal reloaded');

});


<!---

$(".flag-en").click(function(event) {

console.log("flag us clicked");
$('.toreplace').replaceWith('<td class="toreplace">#voc_word_fr#</td>');

    
    $('#modal_title_xl').text("Vocabulary");
    $('#modal_body_xl').empty();
    $('#modal_body_xl').load("<cfoutput>modal_window_project_vocalib2.cfm?voc_cat_id=#voc_cat_id#&voc_id=#voc_id#&voc_cat_name_fr=#voc_cat_name_fr#&langue=" + event.target.dataset.langue + "</cfoutput>", function() {});
    console.log('modal reloaded');

});

$(".flag-es").click(function(event) {

console.log("flag us clicked");
$('.toreplace').replaceWith('<td class="toreplace">#voc_word_fr#</td>');

    
    $('#modal_title_xl').text("Vocabulary");
    $('#modal_body_xl').empty();
    $('#modal_body_xl').load("<cfoutput>modal_window_project_vocalib2.cfm?voc_cat_id=#voc_cat_id#&voc_id=#voc_id#&voc_cat_name_fr=#voc_cat_name_fr#&langue=" + event.target.dataset.langue + "</cfoutput>", function() {});
    console.log('modal reloaded');

});

$(".flag-de").click(function(event) {

console.log("flag us clicked");
$('.toreplace').replaceWith('<td class="toreplace">#voc_word_fr#</td>');

    
    $('#modal_title_xl').text("Vocabulary");
    $('#modal_body_xl').empty();
    $('#modal_body_xl').load("<cfoutput>modal_window_project_vocalib2.cfm?voc_cat_id=#voc_cat_id#&voc_id=#voc_id#&voc_cat_name_fr=#voc_cat_name_fr#&langue=" + event.target.dataset.langue + "</cfoutput>", function() {});
    console.log('modal reloaded');

});

--->


$(".form_update").submit(function( event ) {
		alert($(this).serialize());
		event.preventDefault();
		console.log(event.target); 
    $.ajax({
        url: './api/vocab/projet_vocalib.cfc?method=updt_voc',
		type: 'POST',
		data: $(event.target).serialize(),
        success : function(result, status){

        $('#window_item_lg').modal('show');
		$('#window_item_lg').modal({keyboard: true});
        $('#modal_title_lg').text("Vocabulary");
        $('#modal_body_lg').load("modal_window_project_vocalib.cfm?voc_cat_id=" + event.target.dataset.catid + "&voc_id=" + event.target.dataset.id + "&voc_cat_name_fr=" + event.target.dataset.catnamefr, function() {});


},
error : function(result, status, erreur){
},
complete : function(result, status){
}	
    })
    });


});
</script>
