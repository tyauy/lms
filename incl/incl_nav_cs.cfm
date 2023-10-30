<cfparam name="ysel" default="#year(now())#">
<cfparam name="urlgo" default="common_orders_vue.cfm">

<div class="btn-group" role="group">
    <cfoutput>
        <a class="btn <cfif findnocase("cs_index.cfm",cgi.script_name)>btn-danger active<cfelse>btn-outline-danger</cfif>" href="cs_index.cfm">Dashboard</a>
    </cfoutput>
</div>