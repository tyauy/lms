
    



<!--- <cfhttp
url="https://login.microsoftonline.com/common/oauth2/v2.0/authorize?
client_id=3095c082-3869-482c-85c9-74ce5f526c38
&response_type=code
&redirect_uri=http://localhost:8500/dev/lms/_test_azure.cfm
&response_mode=query
&scope=https%3A%2F%2Fgraph.microsoft.com%2Fmail.read
&state=12345
method="GET"
result="res">
</cfhttp>

<cfdump var="#res#"> --->
<cfscript>
    
    
</cfscript>


<!--- <cfset authurlgoogle = "https://accounts.google.com/o/oauth2/auth?" & 
"client_id=#urlEncodedFormat('724018308502-t3c7te785tg0au70okrbaf8ss6m2mloj.apps.googleusercontent.com')#" & 
"&redirect_uri=#urlEncodedFormat('#SESSION.BO_ROOT_URL#/_test_azure.cfm')#" & 
"&scope=https://www.googleapis.com/auth/userinfo.profile&response_type=code" & 
"&state=#urlEncodedFormat("gg_auth")#"> --->

<cfset authurlazure = "https://login.microsoftonline.com/common/oauth2/v2.0/authorize?" & 
"client_id=#urlEncodedFormat('3095c082-3869-482c-85c9-74ce5f526c38')#" & 
"&response_type=id_token%20token" &
"&response_mode=form_post" &
"&scope=openid+profile+email" &
"&redirect_uri=#urlEncodedFormat('#SESSION.BO_ROOT_URL#/_test_azure.cfm')#" & 
"&state=#urlEncodedFormat("azure")#" &
"&nonce=#urlEncodedFormat("azure")#">

<!DOCTYPE html>
<cfparam name="sco" default="699_scorm"></cfparam>
<html lang="fr">
<head>
	<cfinclude template="./incl/incl_head.cfm">
</head>
<!--- Value --->
<!--- e_L8Q~aocwlFpJDPApOdewcjsLumMQ1eXr-duatH --->

<!--- Secret ID --->
<!--- 8b554351-0380-4f08-8eb2-787ea6a1aeb2 --->


<!--- Value --->
<!--- 5bL8Q~WKKoY8CsBr-Fl~OKmX7ciPKedTI~MLJbpb --->

<!--- Secret ID --->
<!--- d00747f7-ab7e-4062-a446-dfa7b0d5a049 --->
<body>
<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
		<cfset title_page = "Formulaire WEFIT">
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
	  
			
			<div class="row">

                <cfif isDefined("gggo") OR isdefined("state")>
                    <!--- <cfoauth
                    type = "Google"
                    clientid = "724018308502-t3c7te785tg0au70okrbaf8ss6m2mloj.apps.googleusercontent.com"
                    secretkey = "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"
                    scope = "email"
                    result = "res"
                    state = "gg_auth"
                    redirecturi = "#SESSION.BO_ROOT_URL#/_test_azure.cfm" > --->
                    
                                    
                    <!--- <cfoauth
                    authEndpoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize'
                    accessTokenEndpoint = 'https://login.microsoftonline.com/common/oauth2/v2.0/token'
                    clientid = "3095c082-3869-482c-85c9-74ce5f526c38"
                    secretkey = "d00747f7-ab7e-4062-a446-dfa7b0d5a049"
                    scope="openid profile email"
                    result = "res"
                    state = "gg_auth"
                    redirecturi = "http://localhost:8500/dev/lms/_test_azure.cfm"> --->
                
                    <!--- <cfdump var="#state#"> --->
                    <!--- <cfdump var="#res#"> --->
                
                </cfif>
                
                <!--- <cfdump var="#cgi#"> --->

                <!--- <cfhttp url="https://ipapi.co/#cgi.REMOTE_HOST#/json/" result="response_demo">
                </cfhttp> --->

                <!--- <form id="form_google_connect" method="post" action="<cfoutput>#SESSION.BO_ROOT_URL#</cfoutput>/_test_azure.cfm"> 
                    <input type="hidden" name="gggo" value="YES">
                    <button type="submit" class="btn btn-default btn-primary">azure Connect</button>
                </form> --->

                <!--- <br>
                <a href="<cfoutput>#authurlgoogle#</cfoutput>">LOGIN GOOGLE!</a> --->
                <br>
                <a href="<cfoutput>#authurlazure#</cfoutput>">LOGIN AZURE!</a>

                <cfdump var="#form#">

                <cfif isDefined("form.ACCESS_TOKEN")>
                    hello
                    <cfhttp url="https://graph.microsoft.com/oidc/userinfo" method="post" result="resultsdfg">
                        <cfhttpparam type="header" name="Content-Type" value="application/json">
                        <cfhttpparam type="header" name="Authorization" value="Bearer #form.ACCESS_TOKEN#">
                        <!--- <cfhttpparam type="body" value='#SerializeJSON({"model": "gpt-3.5-turbo", "messages": messages})#'> --->
                    </cfhttp>
                    <cfdump var="#resultsdfg#">
                    <cfdump var="#DeserializeJSON(resultsdfg.Filecontent)#">
                </cfif>


                <cfform action="cornerstone_connect.cfm" method="post">
                    <input type="hidden" name="test" value='<?xml version="1.0" encoding="utf-8"?><EntityDescriptor xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ID="_a05fc0f4-3677-4ef7-9579-7c49db07217c" entityID="https://fujifilm-pilot.csod.com" xmlns="urn:oasis:names:tc:SAML:2.0:metadata"><IDPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol"><KeyDescriptor use="signing"><KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#"><X509Data><X509Certificate>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</X509Certificate></X509Data></KeyInfo></KeyDescriptor><NameIDFormat>urn:oasis:names:tc:SAML:2.0:nameid-format:unspecified</NameIDFormat><SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://fujifilm-pilot.csod.com/outboundsso.aspx?ou_id=-24500" /><Attribute Name="UserID" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" xmlns="urn:oasis:names:tc:SAML:2.0:assertion" /><Attribute Name="Firstname" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" xmlns="urn:oasis:names:tc:SAML:2.0:assertion" /><Attribute Name="Lastname" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" xmlns="urn:oasis:names:tc:SAML:2.0:assertion" /><Attribute Name="Email" NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:basic" xmlns="urn:oasis:names:tc:SAML:2.0:assertion" /></IDPSSODescriptor></EntityDescriptor>'>
                    <input type="submit" value="GO" class="btn btn-info">
                </cfform>

			</div>
	
		</div>
		


	</div>
	
</div>

</body>


<cfinclude template="./incl/incl_scripts.cfm">


<script>

$(document).ready(function() {


	
});
</script>

</html>