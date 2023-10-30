<cfcomponent name="getCoupon">
    
 <cfif isdefined("p_id")>
    <cfquery name="get_product" datasource="#SESSION.BDDSOURCE#">
    SELECT p.*, pa.attribute_id, pa.attribute_name, pv.variation_id, 
    pv.variation_name_#SESSION.LANG_CODE# as variation_name, pv.price_unit 
    FROM product p 
    LEFT JOIN product_attribute pa ON pa.product_id = p.product_id
    LEFT JOIN product_variation pv ON pv.attribute_id = pa.attribute_id
    WHERE p.product_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#p_id#">
    </cfquery>
<cfelseif isdefined("c_id")>
    <cfquery name="get_coupon" datasource="#SESSION.BDDSOURCE#">
        SELECT * FROM product_coupon WHERE coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
    </cfquery>
<!---<cfelse>
    <cflocation addtoken="no" url="db_product_list.cfm">--->
</cfif>

<cffunction name="odelete_coupon" access="remote">
    <cfargument name="c_id" required="yes">
    <cfquery name="delete_coupon" datasource="#SESSION.BDDSOURCE#">
DELETE FROM product_coupon
WHERE coupon_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#c_id#">
  
    
</cfquery>
</cffunction>

</cfcomponent>