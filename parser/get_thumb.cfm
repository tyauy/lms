


<cfset list_thumb="972bc1020ed6c8eee34c09101cb15f6d,294e520ec7940b8cfbcb9bde77e8eeab,972e78c304b8d4c1453838f6bcb25758,b4a2efcf34590146e8849ce9e2848055,93e6849a939f89d1feace4145e84ebd2,9995f8674a5c06cbc1acd594f6a91829,4d13ce8461e2fd2740aef8702a2d37c2,ccc9830b2d7f608657b05a3ea71d7cb5,5c24e317c628b91214d66e4848a0eeb8,b492ba900166fd065d012e1762dd3798,62da89e6b2689bfc24f9813eb3fa79fe,4f8efc7d2b96b9d2f6769f0d4eb529ca,376d92e4d6e356ec8673e1b27c3bf250,6975d6b8bd2c1c3bd8ae06194af917b5,6e0a9a0044e17ae657d2d82250842f07,2f653a89dee2f0f1ebbf34321418965f,65c66eab5663f8ee88852b69c32fb732,cd8ff8df10c3a9f6ae0739128eb963d2,1567ba796615b69afce068723af5f558,fcfde5f188dacf2a554cb67d89e57dc3,be9ddacbe8a5b4fafc9053c637bfc57a,032c7282f877b86c74e0a97d0b8bb7e8,48b707532dafc288e3c7aedef1764f92,265502a5dbf163d210aa22d88a822446,66c49c6eb633f14e404c32151270aa3a,29b3bff7d868ff7c25cd94aab29d28a8,9aaefed6606b1a5ee0aa449bd33ca623,d01dfa8621f83289155a3be0970fb0cb,49d90137099c02d3949ed5c9582cc532,c84f5cd26bac3ca54b7088317b56e5a9,e4f2198f2652a2e02bb629dfaef25bd5,4ff5f81f79943d1b495399f98ef6af7d,c631e7b5c26a833889372006e026a603,82bad32f6f188b69d66585349104d23d,52e093dd87ed2474abdf7fe5d91c3d30,6f3d5ef54acd435dd78c2007c8f862dd,cca9188ff92d860cb2a5ae11533d285a">


<cfloop list="#list_thumb#" index="cor">






<cfhttp
    timeout="45"
    throwonerror="false"
    url="https://www.linguahouse.com/linguafiles/md5/#cor#"
    method="get"
    getasbinary="yes"
    result="local.objGet"
>

<cfset myImage = ImageNew(local.objGet.FileContent)>

<cfif (FindNoCase( "200", local.objGet.Statuscode ) AND FindNoCase( "image", local.objGet.Responseheader["Content-Type"]
        ))>   
	  <cfset imageWrite(myImage, "/home/www/winegroup/www/manager/lms3/assets/img_material/#cor#.jpg") />
<cfelse>
     <cfabort>   
</cfif>

</cfloop>