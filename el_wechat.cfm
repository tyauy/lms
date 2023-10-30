<cfsilent>

    <cfquery name="get_conversation" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM lms_chat_conversation_feed ccf
        INNER JOIN lms_chat_conversation cc ON cc.conversation_id = ccf.conversation_id
        WHERE cc.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.USER_ID#">
        AND cc.conversation_keep = 1
    </cfquery>

</cfsilent>
    
<cfoutput><html lang="#SESSION.USER_LANG#"></cfoutput>

<head>
    <cfinclude template="./incl/incl_head.cfm">
    <style>
    #chat-container {
        /* position: fixed;
        bottom: 0;
        right: 0;
        max-width: 400px;
        max-height: 500px;
        overflow-y: auto;
        border: 1px solid #ccc;
        border-radius: 10px;
        background: #f8f9fa; */
    }

    .timestamp {
        color: grey;
        font-size: 0.8rem; 
    }
    </style>
</head>


<body>

    <div class="wrapper">
        
        <cfinclude template="./incl/incl_sidebar.cfm">
        
        <div class="main-panel">
          
            <cfset title_page = "*WEFIT LMS*">
            <cfinclude template="./incl/incl_nav.cfm">
    
            <div class="content">

                <cfinclude template="./incl/incl_nav_el.cfm">
                
                <div class="row mt-3">
                    <div class="col-md-12">
                        <nav>
                            <div class="nav nav-tabs" id="nav-tab" role="tablist" align="center">
                                <button class="nav-link active border-0" data-toggle="tab" data-target="#d_new" type="button" role="tab" aria-controls="d_new" aria-selected="true">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_9.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                            <span>Progresser avec</span><br><strong class="text-red">WE*CHAT</strong>
                                            </h5>
                                        </div>
                                    </div>
                                </button>
                                <button class="nav-link border-0" data-toggle="tab" data-target="#d_history" type="button" role="tab" aria-controls="d_history" aria-selected="false">
                                    <div class="d-flex">
                                        <div>
                                            <img class="mr-3 img_rounded" src="./assets/img/thumb_long_2.jpg" width="90">
                                        </div>
                                        <div align="left">
                                            <h5 style="font-size:18px" class="mb-0">
                                            <span>Historique des</span><br><strong class="text-red">CONVERSATIONS</strong>
                                            </h5>
                                        </div>

                                    </div>
                                </button>
                            </div>
                        </nav>

                        <div class="tab-content">

                            <div class="tab-pane fade show active" id="d_new" role="tabpanel">
                                
                                <div class="card" style="margin-top:-1px !important">

                                    <div class="card-body">

                                        <div class="collapse show mb-3" id="txt_intro">
                                            
                                            <h5 class="mb-2 text-info" style="font-size:18px"><strong>BONJOUR, JE SUIS WE*CHAT, VOTRE ASSISTANT VIRTUEL</strong></h5>
                                            <hr class="mt-0 border-info">

                                            <p style="font-size:18px">
                                                Je suis là pour vous aider à progresser dans votre apprentissage. Nous pourrions par exemple pratiquer l'expression écrite, renforcer vos compétences en grammaire ou enrichir votre vocabulaire.
                                                <br><br>
                                                Que souhaitez-vous faire ?
                                            </p>

                                            <div class="d-flex justify-content-center">
                                                <div class="card_module border border-info mr-2 cursored">
                                                    <a class="btn_prompt" id="btn_prompt_1" data-prompt="1">
                                                    <div class="card-body d-flex flex-column bg-light">
                                                        <h6 class="text-center mt-1" style="font-size:16px !important">
                                                            Pratiquer<br>l'expression écrite
                                                        </h6>
                                                    </div>
                                                    </a>
                                                </div>
        
                                                <div class="card_module border border-info mr-2 cursored">
                                                    <a class="btn_prompt" id="btn_prompt_2" data-prompt="2">
                                                    <div class="card-body d-flex flex-column bg-light">
                                                        <h6 class="text-center mt-1" style="font-size:16px !important">
                                                            Renforcer<br>vos compétences en grammaire
                                                        </h6>
                                                    </div>
                                                    </a>
                                                </div>
        
                                                <div class="card_module border border-info mr-2 cursored">
                                                    <a class="btn_prompt" id="btn_prompt_3" data-prompt="3">
                                                    <div class="card-body d-flex flex-column bg-light">
                                                        <h6 class="text-center mt-1" style="font-size:16px !important">
                                                            Enrichir<br>votre vocabulaire
                                                        </h6>
                                                    </div>
                                                    </a>
                                                </div>
        
                                                <div class="card_module border border-info mr-2 cursored">
                                                    <a class="btn_prompt" id="btn_prompt_4" data-prompt="4">
                                                    <div class="card-body d-flex flex-column bg-light">
                                                        <h6 class="text-center mt-1" style="font-size:16px !important">
                                                            Ouvrir<br>une discussion libre
                                                        </h6>
                                                    </div>
                                                    </a>
                                                </div>
            
                                            </div>

                                        </div>

                                        <div class="collapse mb-3" id="txt_chat">

                                            <h5 class="mb-2 text-info" style="font-size:18px"><strong>C'EST A VOUS !</strong></h5>
                                            <hr class="mt-0 border-info">

                                            <div id="chat-container">
                                                <div id="answer-container"> 
                                                    <div id="loading" class="spinner-border text-info collapse" role="status">
                                                        <span class="sr-only">Loading...</span>
                                                    </div>
                                                </div>
                                                <form method="post" id="questionForm">
                                                    <textarea class="form-control border" name="question" id="questionInput"></textarea>
                                                    <input class="btn btn-info" type="submit" value="Ask We*Chat" name="Submit" id="go_form">
                                                </form>
                                            </div>
                                        </div>


                                    </div>

                                </div>

                            </div>

                            <div class="tab-pane fade" id="d_history" role="tabpanel">

                                <div class="card" style="margin-top:-1px !important">

                                    <div class="card-body">
                                                
                                        <div class="d-flex align-items-start">

                                            <div class="nav flex-column nav-pills" role="tablist" aria-orientation="vertical">
                                                <cfoutput query="get_conversation" group="conversation_id">
                                                <button class="btn btn-outline-info nav-link m-0 mb-1 <cfif conversation_id eq "1">active</cfif>" data-toggle="pill" data-target="##d_#conversation_id#" type="button" role="tab" aria-controls="d_#conversation_id#" aria-selected=" <cfif conversation_id eq "1">true<cfelse>false</cfif>">#obj_function.get_dateformat(conversation_date)#</button>
                                                </cfoutput>
                                            </div>
                                        
                                            <div class="tab-content ml-3">
                                                <cfoutput query="get_conversation" group="conversation_id">
                                                <div class="tab-pane fade <cfif conversation_id eq "1">show active</cfif>" id="d_#conversation_id#" role="tabpanel">
                                                    <cfoutput>
                                        
                                                        <div class="d-flex flex-column">
                                                            <div class="p-2 bg-success text-white w-50 mb-2 rounded">
                                                                #prompt_question#
                                                            </div>
                                                            <div class="chat-message">
                                                                <div class="p-2 bg-info text-white w-50 ml-auto mb-2 rounded">
                                                                    #prompt_answer#
                                                                </div>
                                                                <div class="timestamp ml-auto">
                                                                    #timestamp#
                                                                </div>
                                                            </div>
                                                        </div>
                                        
                                                    </cfoutput>
                                                </div>
                                                </cfoutput>
                                            </div>
                                        
                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>


                    </div>

                </div>

            </div>
        
        <cfinclude template="./incl/incl_footer.cfm">
          
        </div>
        
    </div>
      
    <cfinclude template="./incl/incl_scripts.cfm">

    <cfinclude template="./incl/incl_scripts_modal.cfm">

    <cfinclude template="./incl/incl_scripts_param.cfm">
        
<script>
$(document).ready(function() {

    
    $(".btn_prompt").click(function(event) {
        event.preventDefault();
        var prompt_id = $(this).attr("data-prompt");
        
        $('#txt_intro').collapse("hide");
        $('#txt_chat').collapse("show");

        if(prompt_id == 4)
        {

        }
        else if(prompt_id == 1)
        {
            var prompt_go = "Bonjour, je m'appelle Romain, je suis français et j'apprends l'anglais. J'ai un niveau débutant (A2). Je souhaiterai que tu me fasses travailler l'expression écrite.";
            send_go(prompt_go);
        }
        else if(prompt_id == 2)
        {
            var prompt_go = "Bonjour, je m'appelle Romain, je suis français et j'apprends l'anglais. J'ai un niveau débutant (A2). Je souhaiterai que tu me fasses travailler les principaux points de grammaire pour apprendre correctement l'anglais.";
            send_go(prompt_go);
        }
        else if(prompt_id == 3)
        {
            var prompt_go = "Bonjour, je m'appelle Romain, je suis français et j'apprends l'anglais. J'ai un niveau débutant (A2). J'aimerai enrichir mon vocabulaire.";
            send_go(prompt_go);
        }

    });

    function send_go(userQuestion){
        $('#loading').show();
        
        $.ajax({                 
            url: 'api/chat/_tests_post.cfc?method=send_go', 
            type: "POST",
            datatype : "json",
            data: { "question": userQuestion, "user_id": <cfoutput>#SESSION.USER_ID#</cfoutput> },  // Pass data as object.
            success : function(result, statut){
                console.log("Raw result:", result);
                $('#loading').hide();
            // Check if result is a JSON string
            if (typeof result === "string") {
                try {
                    result = JSON.parse(result);
                    console.log("Parsed result:", result);
                } catch (e) {
                    console.error("Could not parse result:", e);
                }
            }
             // Check if result is 0, and if so, show disclaimer
             if (result === 0) {
                    var disclaimer = '<div class="disclaimer">' +
                        '<p>Your data will be kept for pedagogical purposes. Please check the box if you agree to us keeping the data.</p>' +
                        '<input type="checkbox" id="disclaimerCheckbox">' +
                        '<label for="disclaimerCheckbox">I agree</label>' +
                        '</div>';
                    $('#answer-container').append(disclaimer);
                } else {
                    $('#answer-container').append(result.html);
                    $("#questionInput").val(''); 
                }

            // Scroll to the bottom
            $('#chat-container').scrollTop($('#chat-container').prop('scrollHeight'));
            
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error);
                console.error("Status: " + status);
                console.dir(xhr);
            }
        });
    }

    $("#go_form").click(function(event) {
        event.preventDefault();
        var userQuestion = $("#questionInput").val();
        send_go(userQuestion);
        
    });

    // Scroll to the bottom when page loads
    $('#chat-container').scrollTop($('#chat-container').prop('scrollHeight'));
});

</script>

</body>
</html>