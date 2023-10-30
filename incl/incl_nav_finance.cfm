<cfparam name="ysel" default="#year(now())#">
<cfparam name="urlgo" default="common_orders_vue.cfm">

<div class="btn-group" role="group">
    <cfoutput>
        <a class="btn <cfif findnocase("finance_index.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="finance_index.cfm">Dashboard</a>
    </cfoutput>
</div>
    

<div class="btn-group" role="group">
<cfloop from="2017" to="#year(now())#" index="y">
<cfoutput>
        <a class="btn <cfif ysel eq y>btn-warning active<cfelse>btn-outline-warning</cfif>" href="#urlgo#?ysel=#y#">#y#</a>
</cfoutput>
</cfloop>
</div>



