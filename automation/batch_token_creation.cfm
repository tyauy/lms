
<cfset list_token = "4ENLW-626FA,
QHJRW-WN48S,
JE32B-MJFWS,
Q3SYW-4ENHG,
MQG21-SP8TF,
HGQS8-Q2CK3,
KUSPM-K6D67,
6J1LE-DMDTW,
Q4ARY-RBATF,
RC865-UA66F,
Z4XX6-GU8EQ,
XSC43-V4XV3,
DGWA7-1VMDY,
KHPPW-S1MP7,
PRNBH-ABW6U,
AJXZT-YHNG7,
37JWC-ZRV1R,
G2YS3-MF45S,
XJJJU-Z4TX6,
QQUBH-SEL64,
MDQU1-TEUHJ,
32JCK-NX1G4,
XTAEW-NPUQ2,
TS4PU-WT327,
ADKWQ-DWZTP,
RSH6Z-KQZ6X,
3ZC2E-EH5Z4,
15FPU-7VFJP,
JBHR7-HMUTD,
7VR6M-A3LPG,
DLQLS-F3QLV,
ZGN3N-1J4X4,
WD7NV-NY7NP,
3A7D6-E2Z6R,
T4NVJ-HDSGD,
55S31-LDDPP,
FRZA4-GATAY,
6BVER-LB1UN,
ZN4E2-TKTRW,
BVLXP-HNHXH,
U3Z1C-HXUXY,
UY81L-T6WWY,
GS16Y-E2YYF,
4XPQN-GEB6D,
VGY4T-TRXQQ,
TJ8XK-ZLYQ4,
YP27D-JWDTD,
H3E5X-YBM24,
86QFU-QFQ1A,
1FFKL-5KC55,
D1QD8-VPDBZ,
TSURC-VRJYN,
48M26-W6JTP,
AZRDY-L4JY4,
88M6E-4GMZ5,
CXJSC-AXTGL,
T3BTM-V5D88,
EM5DS-1VZQ5,
NFBJX-YQR5J,
DUXE6-YBVCV,
CT8GY-QM6Z6,
1GDLG-LYVCV,
DKD3J-ULLBB,
ARLLG-J1CQV,
QECB1-MTUPX,
8BJR4-6YTMU,
78QFG-UFL1U,
EGSSY-RYU86,
P7ZCF-ZJNND,
6XPV3-RX5M7

">

<cfoutput>
<cfloop list="#list_token#" index="cor">
<cfquery name="insert" datasource="#SESSION.BDDSOURCE#">
INSERT INTO lms_list_token
(
certif_id,
token_creation,
token_code<!---,
group_id--->
)
VALUES
(
    26,
now(),
'#trim(cor)#'<!---,
340--->
)

</cfquery>

</cfloop>
</cfoutput>

OK