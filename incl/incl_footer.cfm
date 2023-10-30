<footer class="footer footer-black footer-white ">
	<div class="container-fluid">
		<div class="row">
			<div class="credits ml-auto">
				<cfoutput>#year(now())#</cfoutput> WEFIT &copy; / LMS Version 2.7
				|
				<a href="common_cgu.cfm?show_info=use"><cfoutput>#obj_translater.get_translate('card_use')#</cfoutput></a>
				|
				<a href="common_cgu.cfm?show_info=policy"><cfoutput>#obj_translater.get_translate('card_policy')#</cfoutput></a>
				|
				<a href="#" class="btn_contact_wefit"><cfoutput>#obj_translater.get_translate('btn_contact_wefit')#</cfoutput></a>
				
			</div>
		</div>
	</div>
</footer>