
<!DOCTYPE html>
<cfparam name="sco" default="699_scorm"></cfparam>
<html lang="fr">
<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>

<body>
<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formulaire WEFIT">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			
			<div class="row">



                <cfdump var="#cgi#">

                <cfhttp url="https://ipapi.co/#cgi.REMOTE_HOST#/json/" result="response_demo">
                </cfhttp>

                <cfif response_demo.Statuscode eq "200 OK">

                    <cfdump var="#response_demo#">

                    <cfset test = DeserializeJSON(response_demo.Filecontent)>
                    <cfdump var="#test#">

                    <cfif not isDefined("test.error")>

                        hello
                    </cfif>


                </cfif>

                

			</div>
	
		</div>
		


	</div>
	
</div>

</body>


<cfinclude template="./incl/incl_scripts.cfm">


<script>

$(document).ready(function() {

    <!---   <cfset SESSION.rdy_for_tz_check = 1>
    $.ajax({
        url : './components/functions.cfc?method=check_tz',
        type : 'POST',
        data : {
            tz:Intl.DateTimeFormat().resolvedOptions().timeZone
        },
        success : function(result, status) {
            console.log("yes")
        }
    }); --->
	
    navigator.geolocation.getCurrentPosition(position => {
        console.log(position)
        const { latitude, longitude } = position.coords;
        console.log(position.coords)
        // Show a map centered at latitude / longitude.
    });
	
});
</script>

</html>