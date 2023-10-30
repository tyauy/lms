
<cfparam name="invoice_ref">
<cfparam name="dwl" default="0">

<cfset dir_go = "/home/www/wnotedev1/admin/inv">

<cftry>

    <cfif dwl eq 1>
        <cfheader name="Content-Disposition" value='attachment; filename="#invoice_ref#.pdf"'>
        <cfcontent type="application/pdf"  deletefile="no" file="#dir_go#/#invoice_ref#.pdf">
    <cfelse>
        <cfcontent type="application/pdf" file="#dir_go#/#invoice_ref#.pdf">
    </cfif>
    

<cfcatch type="any">
    No PDF for invoice : <cfoutput>#invoice_ref#</cfoutput>
</cfcatch>
</cftry>
        
