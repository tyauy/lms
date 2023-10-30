<cfparam name="p_id">
<cfparam name="name">

<cfset dir_go = "/home/www/wnotedev1/admin/contract/#p_id#/">
<cfset pdf_path = "#dir_go#/#name#">


<cfcontent type="application/pdf" file="#pdf_path#">
