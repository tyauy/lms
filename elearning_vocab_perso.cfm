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
    <cfparam name="subm" default="vocabulary_perso">
</cfsilent>   

<body>
    <div class="wrapper">
    
	    <cfinclude template="./incl/incl_sidebar.cfm">
	
        <div class="main-panel">
        
            <cfset title_page="<cfoutput>#obj_translater.get_translate('card_#subm#_list')#</cfoutput>">
            <cfinclude template="./incl/incl_nav.cfm">

                
            <div class="content">
                <cfinclude template="./widget/wid_vocab_list_perso.cfm">  
            </div>
        <cfinclude template="./incl/incl_footer.cfm">  
        </div>
        
    </div>  
   
    <cfinclude template="./incl/incl_scripts.cfm">
    <cfinclude template="./incl/incl_scripts_vocab.cfm">

</body>
</html>