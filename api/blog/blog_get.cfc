<cfcomponent>

    <cffunction name="oget_blog" access="remote" returntype="query">
        <cfargument name="blog_post_id" type="any" required="no">
        <cfargument name="blog_cat_id" type="any" required="no">
        <cfargument name="limit" type="any" required="no">

        <cfquery name="get_blog" datasource="#SESSION.BDDSOURCE#">
        SELECT blog_post_id, blog_post_date, blog_post_title_#SESSION.LANG_CODE# as blog_post_title, blog_post_abstract_#SESSION.LANG_CODE# as blog_post_abstract, blog_post_content_#SESSION.LANG_CODE# as blog_post_content 
        FROM blog_post 
        <cfif isdefined("blog_post_id")>WHERE blog_post_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#blog_post_id#"></cfif>
        <cfif isdefined("blog_cat_id")>WHERE blog_cat_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#blog_cat_id#"></cfif>
        ORDER BY blog_post_date DESC 
        <cfif isdefined("limit")>LIMIT #limit#</cfif>
        </cfquery>

        <cfreturn get_blog>

    </cffunction>

</cfcomponent>