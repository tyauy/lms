<script src="../assets/js/core/jquery.min.js"></script>

<link href="../assets/css/bootstrap-4.5.3/bootstrap.min.css" rel="stylesheet" />

<div class="row justify-content-center">

    <div class="col-sm-6">
        <div class="border p-1 bg-light">
        <form action="https://lms.wefitgroup.com/parser/parse_ted.cfm" method="post">
        <h5>Copier coller l'URL  ICI</h5>
            <input type="text" name="urlgo">
            <input type="submit" name="GO">
        </form>
        </div>
    </div>

</div>




<cfif isdefined("urlgo")>

    <!--- <cfset tb64 = tobase64(toencode,"utf-8")>  --->
    <cfhttp url="#urlgo#&language=en" method="get" result="result" charset="utf-8"> 
    <!--- <cfhttpparam type="header" name="Authorization" value="Basic #tb64#"> 
    <cfhttpparam type="body" value="#myStruct#"> --->
                    
    </cfhttp>


    <!--- <cfdump var="#result#"> --->

    <!--- <cfoutput>#result.filecontent#</cfoutput> --->

    <!--- <cfset goresult = reReplace(result.filecontent,'<div[^>]*class="([^"]+)"[^>]*>') --->
    <!--- <cfset goresult = mid(result.filecontent,find(result.filecontent,'<div class="container results" id="browse-results">'),500)> --->
        


        <cfset goresult = mid(result.filecontent,find("<div class='container results' id='browse-results'>",result.filecontent),len(result.filecontent))>
        <cfset goresult = mid(goresult,1,find("<div class='m1'></div>",goresult))>
            
        <cfif goresult neq "">
        <div class="row justify-content-center mt-3">

            <div class="col-sm-9">

                <div class="border p-1 bg-light">

                    <h5>Rentrer le keyword ICI</h5>
                    <input type="text" name="tpmaster_name" id="tpmaster_name">
                    <input type="button" name="btn_hoover" id="btn_hoover" value="Hoover !">
                    <br><br>
                    <cfoutput>#goresult#</cfoutput>

            </div>

        </div>


        </cfif>


        <!--- <cfdump var="#goresult#"> --->





</cfif>


<script>
<cfif isdefined("urlgo") AND isdefined("result")>
$(document).ready(function() {

    $("#btn_hoover").click(function() {

        if($("#tpmaster_name").val() == "")
            {
                alert("pas de KW !")
            }
            else
            {

                $(".col").each(function( index ) {

                    // console.log($("#tpmaster_name").val());

                    var clean_title = $(this).find(".ga-link[lang='en']").text().replace("\n", "");
                    clean_title = clean_title.replace("\n", "");

                    var clean_post = $(this).find(".meta__val").text().replace("\n", "");
                    clean_post = clean_post.replace("\n", "");

                    var clean_href = "https://www.ted.com"+$(this).find(".ga-link").attr('href');

                    var clean_author = $(this).find(".talk-link__speaker").text().replace(" ", "");

                    var tpmaster_name = $("#tpmaster_name").val();
                    
                    var myvid = {
                    "video_name":clean_title,
                    "thumb_url":$(this).find(".thumb__image").attr('src'),
                    "video_href":clean_href,
                    "video_author":clean_author,
                    "video_duration":$(this).find(".thumb__duration").text().replace(" ", ""),
                    "video_posted":clean_post,
                    "tpmaster_name":tpmaster_name
                    };


                    console.log(myvid);


                    $.ajax({				 
                        url: '../api/ted/ted_post.cfc?method=insert_tpsessionmaster',
                        type: "POST",
                        data:myvid,
                        datatype : "html",
                        success : function(result, statut){
                            console.log(result);
                        }
                    });	


                });

            }
    
    })


    

});


</cfif>
</script>


<script src="../assets/js/core/bootstrap.min.js"></script>

