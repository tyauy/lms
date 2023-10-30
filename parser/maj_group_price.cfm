<cfquery name="get_group" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM account_group ORDER BY group_id
</cfquery>

<cfoutput query="get_group">
<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO account_group_price
(
group_id,
price_1,
price_2,
price_3,
price_4,
price_5,
price_6,
price_8,
price_9,
price_12,
price_13,
price_reduction
)
VALUES
(


)
</cfquery>

</cfoutput>

