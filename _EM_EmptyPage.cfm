<!DOCTYPE html>
<html lang="<cfoutput>#SESSION.LANG_CODE#</cfoutput>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <cfinclude template="incl/incl_head.cfm">
</head>
<cfsilent>


<!---     <cfset secure = "2,5,6,4,12">
    <cfinclude template="./incl/incl_secure.cfm">	 --->
</cfsilent>   

<body>
    <div class="wrapper">
    
	    <cfinclude template="./incl/incl_sidebar.cfm">
	
        <div class="main-panel">
        
            <cfset title_page = "#obj_translater.get_translate('title_page_common_syllabus')# : empty test page">
            <cfinclude template="./incl/incl_nav.cfm">

                
            <div class="content">
                <div class="container mt-5">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Home</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Profile</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="messages-tab" data-toggle="tab" href="#messages" role="tab" aria-controls="messages" aria-selected="false">Messages</a>
                      </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                      <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <p>Home tab content...</p>
                      </div>
                      <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <p>Profile tab content...</p>
                      </div>
                      <div class="tab-pane fade" id="messages" role="tabpanel" aria-labelledby="messages-tab">
                        <p>Messages tab content...</p>
                      </div>
                    </div>
                </div>
            
            </div>
        <cfinclude template="./incl/incl_footer.cfm">  
        </div>
        
    </div>
    <cfinclude template="./incl/incl_scripts.cfm">
    <cfinclude template="./incl/incl_scripts_vocab.cfm">

</body>
</html>