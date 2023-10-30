<cfparam name="ysel" default="#year(now())#">
<cfparam name="urlgo" default="common_orders_vue.cfm">

<div class="btn-group" role="group">
    <cfoutput>
        <a class="btn <cfif findnocase("sales_index.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="sales_index.cfm?ysel=#ysel#">Dashboard</a>
        <a class="btn <cfif findnocase("sales_report.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="sales_report.cfm?ysel=#ysel#">Reporting</a>
        <a class="btn <cfif findnocase("common_orders_vue.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="common_orders_vue.cfm">Order</a>
    </cfoutput>
</div>
    

<div class="btn-group" role="group">
<cfloop from="2017" to="#year(now())#" index="y">
<cfoutput>
        <a class="btn <cfif ysel eq y>btn-warning active<cfelse>btn-outline-warning</cfif>" href="#urlgo#?ysel=#y#">#y#</a>
</cfoutput>
</cfloop>
</div>


<div class="btn-group" role="group">
    <cfoutput>
        <a class="btn <cfif listContainsNoCase(SESSION.SELECTED_PROVIDER, 1)>btn-info active<cfelse>btn-outline-info</cfif>" href="#urlgo#?ysel=#ysel#&prov_id=1">GROUP</a>
        <a class="btn <cfif listContainsNoCase(SESSION.SELECTED_PROVIDER, 2)>btn-info active<cfelse>btn-outline-info</cfif>" href="#urlgo#?ysel=#ysel#&prov_id=2">GERMANY</a>
        <a class="btn <cfif listContainsNoCase(SESSION.SELECTED_PROVIDER, 3)>btn-info active<cfelse>btn-outline-info</cfif>" href="#urlgo#?ysel=#ysel#&prov_id=3">FRANCE</a>
    </cfoutput>
</div>
    
