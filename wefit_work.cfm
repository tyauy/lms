<cfparam name="p_id">
<cfparam name="signature_base64">


<!--- <cfdump var="#signature_base64#"> --->


<cfimage 
    required 
    action = "writeToBrowser" 
    width = "180"
    source = #signature_base64#
    format = "png" 
    isBase64= "yes">