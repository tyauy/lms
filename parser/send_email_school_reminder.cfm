
<!--- <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
SELECT u.*, llt.token_id FROM lms_list_token llt 
INNER JOIN lms_list_token_session llts ON llt.token_session_id = llts.token_session_id
INNER JOIN user u ON u.user_id = llt.user_id
WHERE llt.token_status_id = 2 
AND llts.token_session_start < '2022-05-24 16:59:40' AND llts.token_session_end > '2022-05-24 16:59:40' AND llts.token_session_method LIKE 'DISTANCIEL'
</cfquery>

<cfloop query="get_user">

    <cfset subject = "WEFIT | Passage de votre certification">

    <cfset user_create_el = "1">
    <cfset user_email = lcase(trim(user_email))>


    <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_list_token t
    INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
    WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.token_id#">
    </cfquery>

    <cfmail from="WEFIT <service@wefitgroup.com>" to="#user_email#" bcc="amorisset@wefitgroup.com,rremacle@wefitgroup.com" subject="#subject#" type="html" server="localhost">
        <cfset lang = "fr">
        <cfset display_warning = "1">
        <cfinclude template="../email/email_token.cfm">
    </cfmail>
</cfloop> --->

<!--- <cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
    SELECT u.*, llt.token_id FROM lms_list_token llt 
    INNER JOIN lms_list_token_session llts ON llt.token_session_id = llts.token_session_id
    INNER JOIN user u ON u.user_id = llt.user_id
    WHERE llt.token_status_id = 2 
    AND llts.token_session_start < '2022-05-24 16:59:40' AND llts.token_session_end > '2022-05-24 16:59:40' AND llts.token_session_method LIKE 'DISTANCIEL'
    AND u.user_id IN (15928, 15931)
</cfquery>

<cfloop query="get_user">
<cfset subject = "WEFIT | Passage de votre certification">

    <cfset user_create_el = "1">
    <cfset user_email = lcase(trim(user_email))>


    <cfquery name="get_token" datasource="#SESSION.BDDSOURCE#">
    SELECT * FROM lms_list_token t
    INNER JOIN lms_list_certification lc ON lc.certif_id = t.certif_id
    WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.token_id#">
    </cfquery>

    <cfmail from="WEFIT <service@wefitgroup.com>" to="service@wefitgroup.com" bcc="morissetan@gmail.com,amorisset@wefitgroup.com" subject="#subject#" type="html" server="localhost">
        <cfset lang = "fr">
        <cfset display_warning = "1">
        <cfinclude template="../email/email_token.cfm">
    </cfmail>
</cfloop> --->
<cfset list = "MMJKS-ATAPE,JS4SW-ZAY2B,WH4D7-PFLTH,LYVFB-2SPWL,H3Y2G-GYNHE,GUQCV-QSY4Z,SQKZR-TVE14,SEW5A-V5J5V,XVTVB-U1GYG,VASTY-ZWPPH,Q3AXD-LU3XU,688KG-A6KNR,GQ3CM-F8YXG,RT7QP-F47RT,P77DE-SE6NP,CA6MW-MXXKY,FNGHZ-FJFHC,JCF11-EWBZH,N4BQB-B6YJF,668DJ-ZEZU1,HEA44-74X4A,X1VWT-ZWNA2,L3X3V-UGJ3A,8V7NB-C1GUM,8QC5W-TVNYD,QYSTQ-CEZY7,5W3DW-6TE5B,1XV8F-PYGMY,1MLQ4-RZR7M,3HX4U-112EA,CNNYY-V5DDS,PQJ66-B6VPU,A18LS-TAKZ7,MD78E-S5WQX,YR1JP-GLTL6,TQRDH-HJ222,S1Q2D-H63WZ,ELYYR-3CPYE,BVF4P-E6M72,443RM-1PAQQ,7BLWA-YYJWZ,JW5ZM-F6PXP,1KJWC-8KNS3,3F7LU-MQWQ4,BE81T-UMNUE,5CH8C-3GMNW,G644R-LJSQZ,24VWR-BWPJT,6RTDY-SQN6V,J7SFN-MGC3W,PWVTX-6XG4A,YVAM4-DKD57,SJNR2-AME68,8WEYY-BP8PV,KNXUH-2TDJB,FKTLV-4TCEL,UZF43-GD13F,DSF2K-43FPM,1CHTZ-N3NVN,UCWT5-PM54T,WTETE-SMFHB,DVBXL-3GJ84,S42NW-AAUMT,N11W6-6C1M8,WY136-8Z67N,UKN5G-WBA8M,2MX5Q-TQG6K,NJFX4-E2UPG,ECNV8-NB5B1,7BC84-4DVVH,G8GL1-2TNV7,CC5FD-FULWX,2EQAC-BUZVG,MGXSH-GJL4M,SMCUW-2J51D,R2JBJ-CPNBZ,VDW4S-EKTWF,7D781-HP2K1,1T3DV-U8B5B,2A5WB-HTEKN,8LZ3B-U782T,K1WB6-WTBQG,PA85Y-W3X32,54NBP-TF7A3,3BBFF-AH4DG,ENMK3-5P7HC,VZUB5-T686P,QPNTR-2JNVL,HC67U-LJ62Y,P77U7-72MYW,DUFY1-1M3TN,1CDT7-ZX1P8,XZWZM-L8DAL,Z27V3-FVQJJ,M3UAP-7SKVY,FS4RS-XHWDX,AMKNM-WYU2D,VTR5Q-QJNU4,ELSQ7-ZKAAM,W6YGD-G4YVQ,PN4FC-6JJLB,WXMAJ-12NUW,BRYR5-7KMQV,ZGBNM-ETMPG,UASDJ-FZVTP,C642B-W2YDX,PBWNQ-4Z1V1,UGN37-LTN13,1V8YW-5KT8P,27MTL-E352H,UW1HG-RGTXC,WXTEG-7CLCN,X28A1-QCNYG,LS331-T73RX,FHRHN-5MKBA,V7KDY-A6D83,J6K6S-PEG73,L1WFM-R3TSH,MS5QZ-6Z4EH,6NXRG-RPNPK,JNHVT-4VJMK,CKNGW-RWKXU,KSAT2-6X3JT,Y1AB2-3K5P2,E6KYJ-RLQPK,32LQJ-BTT2J,5XM6G-1Y25J,WJKHQ-ZZ5A1,WBNFG-ZCSAA,3JKKB-QMLJH,4S61A-R1N1B,MAPYP-RV1CX,JSPLU-DPJBN,Y2736-T5QHW,YJQ7P-P2WKW,HB1RS-CJJQ3,HKAWW-QNQGF,4KUX8-HVRUK,GLVVQ-K4ABT,MAXE3-VFQ1Z,Y1J8V-LT6EB,NXYR3-DZ1DK,K2URS-3C7ZZ,2ZTGH-63XEV,5NM8A-Z3QL7,DBQ7W-X1N6E,MTH7C-GMYPV,EK8R2-62X2K,3UZCQ-AZRYK,AYFGW-HMBC5,ZTNRC-YKM3H,L8AQW-ML2NQ,A8AXV-MGYEJ,EG6EY-2PGDE,5ZL8R-PCG2Y,P27EZ-6B6GC,CJGMY-666RN,U5TGE-2683P,QQTRS-P8KA3,HNKPY-D2MAH,LN77P-75TZT,LC7K2-Y7CV3,MH223-M5L5Z,XACVM-X546S,7DPHM-LUXVZ,S2SZK-HPWGV,YAVLQ-QVGBS,LGXB1-BZJQJ,CWVM2-YW4W5,T4M18-2PSVP,5WGWC-4BN3L,CADGX-LDULW,LKHSF-RDAFV,RXSK5-5JF1S,L6UCJ-PAQXG,ELFUE-NQDH1,EYBG4-MA63A,E63LC-33FDU,T1EG5-JFQEZ,MQLNL-HTEPU,QLSCA-GHU4B,K31D1-7Y5WY,5AFQR-JEQ5V,BTSZG-5PQVX,FLRPQ-KYSJS,UDN4C-SX5W6,1RR6Q-Q3G17,JWA6F-RQWY3,JY7N5-SFHTB,3RU87-M8YEF,RV3VH-SCJDC,SB5RY-DW187,MEANE-ULKE2,SE3DH-XXZYH,DAV3U-A7AQM,TDJS8-1Z61F,3CAXX-TB7RP,BZGLM-LN8DY,EY5U7-PL2ND,H8J8L-VH1DZ,P8WAN-C8JH2,VKGRV-RAETN,SHFNK-HZ5XT,Z7NH4-EBT63,CWAK2-LF5KJ,7UC8K-KX5KG,TE6CN-KN1KJ,7LP5Z-1KYVM,5S261-GMX82,D6W6D-LMVKF,N2QY6-P5LGJ,5D41L-GJML3,YJXAG-PVEAN,XW6BJ-32VHL,L5MPM-UL54G,FRCNY-HYWJY,3DTZW-QL8TB,VV588-NLUEK,VYPT3-VN6XN,8RXGB-NFNWZ,11PNZ-713CR,VZFRW-6CA5Q,L4VWZ-8WWCL,BMDGY-AT2XA,GUTU6-61GMR,B4BLN-X86TW,7JZ84-MGHSL,64RDH-Z7YKR,YMVR6-R32PD,JKDCC-28PYE,STE32-WQPAN,G4SFN-2DZFE,2LAL5-6ZXBU,PBBCJ-NPWRH,4SUG1-ZCYQ2,23Q6V-2432L,TC525-VF7WX,SS334-68ZJK">

<cfquery name="get_user" datasource="#SESSION.BDDSOURCE#">
    SELECT llt.* FROM lms_list_token llt 
    INNER JOIN lms_list_token_session llts ON llt.token_session_id = llts.token_session_id
    INNER JOIN user u ON u.user_id = llt.user_id
    WHERE llt.token_status_id = 1
    AND llts.account_id = 864
    ORDER BY `llt`.`token_id` ASC
</cfquery>

<cfloop query="get_user">
    <!--- <cfquery name="up" datasource="#SESSION.BDDSOURCE#">
        UPDATE lms_list_token SET 
        token_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#listGetAt(list, get_user.currentRow)#">,
        token_status_id = 1
        WHERE token_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#get_user.token_id#">
    </cfquery> --->
    <p>
        <cfoutput>
           #get_user.token_id# #get_user.token_code# #listGetAt(list, get_user.currentRow)#
        </cfoutput>
    </p>
</cfloop>