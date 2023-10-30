<cfabort>
<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM `LMS-1`.lms_tpsessionmaster2 where sessionmaster_id >= 1562 ORDER BY sessionmaster_id ASC
</cfquery>


<cfoutput query="get_sm">
    <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_elearning_module
    (
    elearning_module_path,
    sessionmaster_id
    )
    VALUES
    (
    #sessionmaster_id#,
    #sessionmaster_id#
    )
    </cfquery>

    <cfquery name="get_max" datasource="#SESSION.BDDSOURCE#">
    SELECT max(elearning_module_id) as id FROM lms_elearning_module
    </cfquery>

    <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
    INSERT INTO lms_elearning_module_cor
    (
    elearning_module_id,
    elearning_module_group_id
    )
    VALUES
    (
    #get_max.id#,
    36
    )
    </cfquery>

</cfoutput>







<!------------------MAPPER ----------------------->
<cfabort>
<cfquery name="get_sm" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 sm
INNER JOIN lms_tpmastercor2 tc ON tc.sessionmaster_id = sm.sessionmaster_id 
INNER JOIN lms_tpmaster2 tp on tp.tpmaster_id = tc.tpmaster_id 
WHERE tc.tpmaster_id = 1343 ORDER BY sm.sessionmaster_id 
</cfquery>
        
    <cfoutput query="get_sm">
    
        <cfloop list="106" index="cor">

            <!--- <cfquery name="get_check" datasource="#SESSION.BDDSOURCE#">
            SELECT * FROM lms_sessionmaster_keywordid_cor WHERE sessionmaster_id = #sessionmaster_id#
            </cfquery>

            <cfif get_check.recordcount eq "0"> --->

                #sessionmaster_id# // aucune info<br>
                <cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
                INSERT INTO lms_sessionmaster_keywordid_cor
                (
                sessionmaster_id,
                keyword_id
                )
                VALUES
                (
                #sessionmaster_id#,
                #cor#
                )
                </cfquery>

            <!--- <cfelse>
                #sessionmaster_id# // y'a du kw<br>
            </cfif> --->
        </cfloop>
    
    
    </cfoutput>



<cfabort>

<cfset list_sm = "1925,
1928,
1930,
1932,
1933,
1938,
1941,
1945,
1952,
1955,
1957,
1960,
1961,
1963,
1965,
1972,
1985,
1989,
1994,
1997,
1999,
2001,
2003,
2004,
2008,
2010,
2013,
2015,
2019,
2025,
2029,
2039,
2040,
2043,
2045,
2046,
2049,
2050,
2058,
2062,
2064,
2069,
2072,
2073,
2081,
2082,
2085,
2102,
2103,
2108,
2115,
2117,
2122,
2123,
2125,
2126,
2127,
2128,
2131,
2134,
2135,
2140,
2141,
2145,
2154,
2159,
2161,
2164,
2167,
2168,
2172,
2174,
2178,
2191,
2197,
2198,
2201,
2202,
2204,
2205,
2207,
2209,
2216,
2218,
2223,
2228,
2230,
2231,
2233,
2235,
2241,
2245,
2248,
2258
">


<cfloop list="#list_sm#" index="cor">
<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_tpmastercor2
(
sessionmaster_id,
tpmaster_id
)
VALUES
(
#cor#,
1344
)
</cfquery>
</cfloop>





<cfabort>








<cfabort>
<!------------------RENAMER ----------------------->
<cfset obj_cleaner = createobject("component", "#SESSION.BO_ROOT_COMPONENT#.cleaner")>

<cfquery name="get_resource" datasource="#SESSION.BDDSOURCE#">
SELECT * FROM lms_tpsessionmaster2 WHERE (sessionmaster_ressource IS NULL OR sessionmaster_ressource = "") AND sessionmaster_id > 1561
</cfquery>

<cfoutput query="get_resource">

    <cfquery name="updt_resource" datasource="#SESSION.BDDSOURCE#">
UPDATE lms_tpsessionmaster2 SET sessionmaster_ressource = '#obj_cleaner.renamego(sessionmaster_name)#' WHERE sessionmaster_id = #sessionmaster_id#
    </cfquery>
<br>
</cfoutput>