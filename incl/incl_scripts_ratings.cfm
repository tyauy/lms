<style>
.purple{
        fill: #933088; 
		    }
.green{
		fill:#80BB46;
			}
.perso:hover .st0{  
        fill:#933088;
        opacity: 0.5;
            }
.badge:hover .st0{    
        fill:#80BB46;
        opacity: 0.5;
            }
.smiley_img {
    max-height: 70px;
}
.special-checkbox {
    display: inline-block !important; /* Force element to show */
    visibility: visible !important;
    opacity: 1 !important;
}

</style>

<script>
 function toggleSupportRating(checkboxElem) {
    var supportRatingDivs = document.querySelectorAll(".supportRatingSection div");
    for (var i = 0; i < supportRatingDivs.length; i++) {
        supportRatingDivs[i].style.pointerEvents = checkboxElem.checked ? "none" : "";
    }
}
$(document).ready(function(){

    var l_id=<cfif isdefined("l_id")><cfoutput>#l_id#</cfoutput></cfif>
    var note_description ="";

    step_1 = "";
    step_2 = "";
    step_3 = "";

   

    <cfif isDefined("existingpersonality")>
        <cfif existingpersonality.recordCount neq 0 or get_lesson.sessionmaster_id eq "695">
            step_3="1";	
        </cfif>
        <cfif existingBadge.recordCount neq 0>
            step_2="1";
            $('#collapseTwo').prop('disabled', false);
            $('#collapseOne').prop('disabled', false);
            $('#btn_perso').prop('disabled', false);
        </cfif>
        <cfif get_rating.recordCount neq 0 >
            step_1 = "";
            $('#collapseTwo').prop('disabled', false);
            $('#collapseOne').prop('disabled', false);
        </cfif>
    </cfif>

    $('[data-toggle="popover"]').popover({
        trigger: 'focus',
        html: true
    });

    $('[data-toggle="tooltip"]').tooltip({html: true});

    <!-------------------------------------------------->
    <!----------GESTION SMILEYS ------------------------>
    <!-------------------------------------------------->

    $(".techno").mouseout(function(event) {
        for(var i=0;i<=5;i++)
        {if(i <= 5){$("#technoimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
    })

    $(".support").mouseout(function(event) {
        for(var i=0;i<=5;i++)
        {if(i <= 5){$("#supportimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
    })

    $(".teaching").mouseout(function(event) {
        for(var i=0;i<=5;i++)
        {if(i <= 5){$("#teachingimg_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+i+'_nb.svg');}}
    })

    $(".smiley_img").mouseover(function(event) {

        var smile_click = ($(this).attr("id"));
        smile_click = smile_click.split("_");
        smile_click = smile_click["1"];
        var parentName = ($(this).parent().attr('name'));

        for(var i=0;i<=5;i++)
        {
            if(i <= smile_click)
            {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'.svg');}
            else
            {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'_nb.svg');}
        }
    });

    $(".smiley_img").click(function(event) {

        var smile_click = ($(this).attr("id"));
        smile_click = smile_click.split("_");
        smile_click = smile_click["1"];
        var parentName = ($(this).parent().attr('name'));

        var parentId = ($(this).parent().attr('id'));
        var id = ($(this).attr("id"));
        id = id.split("_");
        id = id["1"];
        var inputN =($("input[id='input_"+parentId+"']"));

        $("."+parentName).off('mouseout');

        value=($(inputN).prop("checked", function( i, val ) {
            return !val;
        })) ;
       /*   console.log("this is the svg id before split "+($(this).attr("id")));
                    console.log(parentId);
                  
                    console.log(inputN.attr("value"));  */
        $("."+parentName+ "> img").off('mouseover');

        for(var i=0;i<=5;i++)
        {
            if(i <= smile_click)
            {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'.svg');}
            else
            {$("#"+parentName+"img_"+i).attr('src','https://lms.wefitgroup.com/assets/img_smile/'+smile_click+'_nb.svg');}

        }
        console.log($('#form_global_rating').serialize()); 
       
    });

    <!-------------------------------------------------------->
    <!---STEP 1: INSERT TECH, TEACH, SUPPORT $ DESC RATINGS--->
    <!-------------------------------------------------------->

    $("#tech_btn").click(function(e) {
      /*   console.log($('#form_global_rating').serialize());  */
        e.preventDefault();
        console.log($("#techno").val());
        console.log($("#support").val());
        console.log($("#teaching").val());
        $.ajax({
            url:"./api/ratings/ratings_post.cfc?method=opost_rating_tech",
            type: "POST",
            data : $('#form_global_rating').serialize(),
            success: function(resultat, statut){
            
                if (resultat==="teaching already rated"){ 
                    $('#alert_error_tech').collapse('show');
                    $('#collapseOne').collapse('hide');
                    $('#badge_btn').prop('disabled', false);
                } 
                else { 
                    $('#alert_success_tech').collapse('show');
                    $('#collapseOne').collapse('hide');
                    $('#badge_btn').prop('disabled', false);
                    $('#tech_btn').prop('disabled', true);
                    $('#collapseTwo').toggleClass("show");
                }
            },
            error: function(resultat, statut, erreur){ 
                $('#alert_error_tech').collapse('show');
                $('#badge_btn').prop('disabled', false);
                
            },
            complete : function (resultat, statut){
                step_1 = 1;
               
                // console.log("step 1 :"+step_1);
                if(step_1 == "1" && step_2 == "1" && step_3 == "1")
                {
                    localStorage.setItem("close_modal_success", l_id);
                    console.log('SHOW ' +l_id);
                    window.location.reload(); 
                }
            }
        });
    });


    <!-------------------------------------------------->
    <!---------------STEP 2: BADGES -------------------->
    <!-------------------------------------------------->
    
    <!--------- Img from grey to coloured ON CLICK-------->	
    $("svg.badge").click(function(){
        var badges = [];
        var id = ($(this).attr("id"));
        $("#"+id +" .st0").toggleClass("green");
        var value = ($("#badge_check_"+$(this).attr("id")).prop("checked", function( i, val ) {return !val;}));
    
        $("input[name='badge_input']:checked").each(function () {
            badges.push($(this).val());
            // console.log('Selected value:'+this.value);
            if (badges.length <= 3){
                
            }
            else
            {
                alert("<cfoutput>#encodeForJavascript(obj_translater.get_translate('alert_rating_max_badge'))#</cfoutput>");
                
                $("#"+id +" .st0").removeClass("green");
                let value = ($("#badge_check_"+id).prop("checked", false));
                let removed = badges.pop();
            
                console.log("id removed with pop:"+removed);

            }
        });

    });

       // Handle the submission of the trainer badge form
    
    $("#form_trainer_badges").submit(function(event) {
        event.preventDefault();
        var badges = [];
        
        // Populate the badges array with the values of the checked badge_input checkboxes

        $.each($("input[name='badge_input']:checked"), function(){
            badges.push($(this).val());
        });
        
        // Send a POST request to the server-side script with the badge data and other relevant information
        $.ajax({
            url:"./api/ratings/badges_post.cfc?method=oinsert_Badge",
            method: "POST",
            data: { badges: JSON.stringify(badges), l_id: $("#l_id").val(), u_id: $("#u_id").val(), tr_id: $("#tr_id").val()  },
                
             // Handle the success response from the server
            success: function(resultat, statut){
               
                if (resultat==="2"){ 
                    $('#alert_error_badge').collapse('show');
                    $('#global_btn').prop('disabled', false);
                }
                else { 
                    $('#alert_success_badge').collapse('show');
                    $('#collapseTwo').collapse('hide');
                    $('#badge_btn').prop('disabled', true);
                    $('#btn_perso').prop('disabled', false);
                    $('#collapseThree').toggleClass('show');
                }
            },
            // Handle the error response from the server
            error: function(resultat, statut, erreur){
                $('#alert_error_badge').collapse('show');
                $('#global_btn').prop('disabled', false);
                $('#btn_perso').prop('disabled', false);
                
            },
            // Handle the complete response from the server
            complete : function (resultat, statut){
                step_2 = 1;
                 // Check if all steps (1, 2, and 3) have been completed
                if((step_1 == "1") && (step_2 == "1") && (step_3 == "1"))
                {
                   // Store the value of l_id in the local storage and reload the page
                    localStorage.setItem("close_modal_success", l_id);
                    window.location.reload(); 
                }
            }
        });    
    
    });


    <!-------------------------------------------------->
    <!---------------- PERSO RATING -------------------->
    <!-------------------------------------------------->

   // Handle the selection of trainer personality traits
    $("svg.perso").click(function(){

        var perso = [];
        var id = ($(this).attr("id"));
        $("#"+id +" .st0").toggleClass("purple");
        var value = ($("#perso_check_"+$(this).attr("id")).prop("checked", function( i, val ) {return !val;}));
    
        // Keep track of the number of selected traits
        $("input[name='perso_input']:checked").each(function () {
            perso.push($(this).val());
            // console.log('Selected value:'+this.value);
            if (perso.length <= 3){
                // do nothing
            }
            else
            {
                alert("<cfoutput>#encodeForJavascript(obj_translater.get_translate('alert_rating_max_perso'))#</cfoutput>");
                // remove the last selected trait
                $("#"+id +" .st0").removeClass("purple");
                let value = ($("#perso_check_"+id).prop("checked", false));
                let removed = perso.pop();

            }
        });
    
    });


    <!-------------------------------------------------->
    <!--------STEP 3:Insert PERSO RATING in bdd -------->
    <!-------------------------------------------------->

    // Handle the submission of the trainer personality form
    $("#form_trainer_personality").submit(function(e) {
        e.preventDefault();
        var perso = [];
        // Populate the perso array with the values of the checked perso_input checkboxes
        $.each($("input[name='perso_input']:checked"), function(){
            perso.push($(this).val());
        });

        // Send a POST request to the server-side script with the personality data and other relevant information
        $.ajax({
            url:"./api/ratings/ratings_personality_post.cfc?method=oinsert_personality",
            method: "POST",
            data: { perso: JSON.stringify(perso), l_id: $("#l_id").val(), u_id: $("#u_id").val(), tr_id: $("#tr_id").val(),  },
            success: function(resultat, statut){
                if (resultat==="2"){ 
                    $('#alert_error_perso_section').collapse('show');
                    $('#alert_error_perso').collapse('show');
                   }
                
                else { 
                    $('#alert_success_perso_section').collapse('show');
                    $('#alert_success_perso').collapse('show');
                    $('#collapseThree').collapse('toggle');
                    $('#btn_perso').prop('disabled', true);
                }
            },
            error: function(resultat, statut, erreur){
                $('#alert_error_perso_section').collapse('show');
                $('#alert_error_perso').collapse('show');
                
            },
            complete : function (resultat, statut){
                step_3 = 1;
                if(step_1 == "1" && step_2 == "1" && step_3 == "1")
                {
                    localStorage.setItem("close_modal_success", l_id);
                    window.location.reload(); 
                }
            }
        });	
    });

    <!-------------------------------------------------->
    <!---------------------- SKIP BTN ------------------>
    <!-------------------------------------------------->

    $("#btn_skip_badge").click(function(){
        $('#div_badge').remove();

    });

    $("#btn_skip_perso").click(function(){
        $('#div_perso').remove();
    });
            
 });

</script>


