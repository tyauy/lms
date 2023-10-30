<cfparam name="invoice_ref" default="0">
<cfparam name="o_md" default="0">
<cfparam name="o_type" default="0">

<cfif o_md neq 0 AND o_type neq 0>

  <cfoutput>
    <iframe width="100%" height="500" src="view_container.cfm?o_md=#o_md#&o_type=#o_type#"></iframe>
  </cfoutput>

  <cfelse>
    <iframe width="100%" height="500" src="./tpl/invoice_view.cfm?invoice_ref=<cfoutput>#invoice_ref#</cfoutput>"></iframe>
</cfif>


<cfabort>

<cfdocument format="pdf">
  <cfoutput>
    #variables.PDFhtml#
  </cfoutput>
</cfdocument>

<cfabort><cfheader name="Content-Disposition" value="inline; filename=#SESSION.BO_ROOT#/admin/conv/CONV_18-2379.pdf">
<cfcontent type="application/pdf">
<cfoutput>#SESSION.BO_ROOT#/admin/conv/CONV_18-2379.pdf</cfoutput>
<cfabort>
<!---<cfoutput>
#o_md#
 // #o_type#
</cfoutput>
---->

