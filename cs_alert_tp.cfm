<!DOCTYPE html>

<cfparam name="view" default="nobuilt">

<cfsilent>

	<cfif view eq "tolaunch">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		SUM(s.session_duration) as session_duration,
		s.sessionmaster_id,
		l.lesson_id,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		
		WHERE t.tp_status_id = 1 AND (t.method_id = 1 OR t.method_id = 2)
		GROUP BY t.tp_id
		
		</cfquery>

<cfelseif view eq "tpstop">

	<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
	SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
	f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
	a.account_name, 
	t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
	o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
	lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
	tpd.*,
	tpc.*,
	tpe.*,
	ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
	SUM(s.session_duration) as session_duration,
	s.sessionmaster_id,
	l.lesson_id,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
	(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
	st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
	
	FROM lms_tp t 
	INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
	LEFT JOIN user u ON tpu.user_id = u.user_id

	INNER JOIN user_status st ON st.user_status_id = u.user_status_id
	LEFT JOIN account a ON a.account_id = u.account_id
	INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
	LEFT JOIN orders o ON o.order_id = t.order_id
	LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
	
	LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
	LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
	LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
	LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
	
	LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
	LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
	LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
	LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
	LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
	
	
	WHERE t.tp_status_id = 11 AND (t.method_id = 1 OR t.method_id = 2)
	GROUP BY t.tp_id
	
	</cfquery>


		
	<cfelseif view eq "ptaleft">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		SUM(s.session_duration) as session_duration,
		s.sessionmaster_id,
		l.lesson_id,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		
		GROUP BY t.tp_id
		
		HAVING s.sessionmaster_id = 694 AND t.tp_status_id <> 3 AND l.lesson_id IS NULL
		
		AND tp_duration = session_duration
		
		ORDER BY o.order_id
		
		</cfquery>
		
	<cfelseif view eq "ptascheduled">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		SUM(s.session_duration) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
		s.sessionmaster_id, l.status_id, l.lesson_start
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE s.sessionmaster_id = 694 AND t.tp_status_id <> 3 AND (l.status_id = 1)
		
		GROUP BY t.tp_id
		
		ORDER BY lesson_start
		
		</cfquery>
		
	<cfelseif view eq "nobuilt">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		SUM(s.session_duration) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE t.tp_status_id = 2
		
		
		GROUP BY t.tp_id
        HAVING tp_duration != session_duration
		
		ORDER BY o.order_id
		
		</cfquery>
		
	<cfelseif view eq "noscheduled">	
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		MAX(l.lesson_start) as maxl,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		LEFT JOIN logs lo ON lo.order_id = o.order_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE t.tp_status_id = 2
		
		
		GROUP BY t.tp_id, t.order_id
        HAVING maxl < now()
		
		ORDER BY o.order_id
		
		</cfquery>
		
	
	<cfelseif view eq "noclose">
		
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		s.sessionmaster_id, l.status_id, l.lesson_start,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1	
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id		
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id		
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE s.sessionmaster_id = 694 AND l.lesson_id <> "" AND t.tp_status_id <> 3 AND l.status_id = 5
		
		GROUP BY t.tp_id
		
		ORDER BY o.order_id
		
		</cfquery>
		
	<cfelseif view eq "noclosenoremain">
		
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		s.sessionmaster_id, l.status_id, l.lesson_start,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
		SUM(s.session_duration) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id		
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id		
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE t.tp_status_id = 2 AND (t.method_id = 1 OR t.method_id = 2)
		
		GROUP BY t.tp_id
		
		ORDER BY t.order_id
		
		</cfquery>
		
		
	
	<cfelseif view eq "wrongdate">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		s.sessionmaster_id, l.status_id, l.lesson_start,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id		
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id		
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE (t.tp_status_id = 3 AND t.tp_date_end > now())
		
		GROUP BY t.tp_id
		
		ORDER BY o.order_id
		
		</cfquery>
		
	<cfelseif view eq "notcloseddeadline">
	
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		s.sessionmaster_id, l.status_id, l.lesson_start,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id

		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
		
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id		
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id		
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE ((t.tp_status_id = 1 OR t.tp_status_id = 2 OR t.tp_status_id = 6) AND o.order_end < now() AND o.order_status_id <> 10)
		
		GROUP BY t.tp_id
		
		ORDER BY o.order_id
		
		</cfquery>
		
	<cfelseif view eq "minusremain">
		
		<cfquery name="get_tp" datasource="#SESSION.BDDSOURCE#">	
		SELECT u.user_firstname, u.user_name, u.user_id, CONCAT(u.user_firstname, " ", UCASE(u.user_name)) as user_contact, u.user_needs_duration,
		f.formation_code, f.formation_name_#SESSION.LANG_CODE# as formation_name, f.formation_alias,
		a.account_name, 
		t.*, t.method_id, t.techno_id as tp_techno_id, t.elearning_id as tp_elearning_id, t.certif_id as tp_certif_id,
		o.order_id, o.order_ref, ofi.status_finance_name, ofi.status_finance_css, o.order_start, o.order_end,
		lm.method_name_#SESSION.LANG_CODE# as method_name, lm.method_alias_#SESSION.LANG_CODE# as method_alias, lm.method_scheduler,
		tpd.*,
		tpc.*,
		tpe.*,
		ts.tp_status_name_#SESSION.LANG_CODE# as status_name,
		s.sessionmaster_id, l.status_id, l.lesson_start,
		st.user_status_name_#SESSION.LANG_CODE# as user_status_name, st.user_status_id as user_status_id, st.user_status_css,
		SUM(s.session_duration) as session_duration,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 1) as tp_scheduled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 2) as tp_inprogress,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 3) as tp_cancelled,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 4) as tp_missed,
		(SELECT SUM(lesson_duration) as book FROM lms_lesson2 l WHERE l.tp_id = t.tp_id AND status_id = 5) as tp_completed
		
		FROM lms_tp t 
		INNER JOIN lms_tpuser tpu ON tpu.tp_id = t.tp_id AND tpu.tpuser_active = 1
		LEFT JOIN user u ON tpu.user_id = u.user_id
		
		INNER JOIN user_status st ON st.user_status_id = u.user_status_id
		LEFT JOIN account a ON a.account_id = u.account_id
		INNER JOIN lms_tpstatus ts ON ts.tp_status_id = t.tp_status_id
			
		LEFT JOIN orders o ON o.order_id = t.order_id
		LEFT JOIN order_status_finance ofi ON ofi.status_finance_id = o.order_status_id
		
		LEFT JOIN lms_tpsession s ON s.tp_id = t.tp_id
		LEFT JOIN lms_tpsessionmaster2 sm ON sm.sessionmaster_id = s.sessionmaster_id
		LEFT JOIN lms_tpsession_category c ON c.cat_id = s.cat_id AND c.cat_public = 1
		LEFT JOIN lms_lesson_method lm ON lm.method_id = t.method_id		
		LEFT JOIN lms_lesson2 l ON l.session_id = s.session_id		
		LEFT JOIN lms_formation f ON f.formation_id = t.formation_id
		LEFT JOIN lms_list_destination tpd ON tpd.destination_id = t.destination_id
		LEFT JOIN lms_list_certification tpc ON tpc.certif_id = t.certif_id
		LEFT JOIN lms_list_elearning tpe ON tpe.elearning_id = t.elearning_id
		
		WHERE t.tp_status_id = 2 OR t.tp_status_id = 3 AND (t.method_id = 1 OR t.method_id = 2)
		
		GROUP BY t.tp_id
		
		ORDER BY t.order_id
		
		</cfquery>
		
	</cfif>
	
</cfsilent>

<html lang="fr">

<head>

	<cfinclude template="./incl/incl_head.cfm">

</head>

<body>

<div class="wrapper">
    
	<cfinclude template="./incl/incl_sidebar.cfm">
	
	<div class="main-panel">
      
	<cfif view eq "tolaunch"><cfset title_page = "CS ALERT : TP TO LAUNCH">
	<cfelseif view eq "tpstop"><cfset title_page = "CS ALERT : TP STOP">
	<cfelseif view eq "nobuilt"><cfset title_page = "CS ALERT : TP IN PROGRESS BUT INCOMPLETED">
	<cfelseif view eq "noscheduled"><cfset title_page = "CS ALERT : TP IN PROGRESS BUT NO SCHEDULED LESSON">
	<cfelseif view eq "noclose"><cfset title_page = "CS ALERT : TP NOT CLOSED BUT PTA DONE">
	<cfelseif view eq "noclosenoremain"><cfset title_page = "CS ALERT : TP NOT CLOSED BUT NO REMAIN CREDITS">
	<cfelseif view eq "wrongdate"><cfset title_page = "CS ALERT : TP FINISHED BUT WRONG END DATE">
	<cfelseif view eq "notcloseddeadline"><cfset title_page = "CS ALERT : TP NOT CLOSED WITH DEADLINE OUTDATED">
	<cfelseif view eq "minusremain"><cfset title_page = "CS ALERT : TP WITH MINUS REMAIN">
	<cfelseif view eq "ptaleft"><cfset title_page = "CS ALERT : 1 PTA LEFT NOT SCHEDULED">
	<cfelseif view eq "ptascheduled"><cfset title_page = "CS ALERT : PTA SCHEDULED"></cfif>			
					
		
		<cfinclude template="./incl/incl_nav.cfm">

		<div class="content">
		
		
		<!---<cfdump var="#get_tp#">--->
				
			<!--- <cfinclude template="./incl/incl_nav_learner.cfm"> --->
			
			<div class="row">	
			
				<div class="col-md-12">
					
					<a href="cs_alert_tp.cfm?view=tolaunch" class="btn p-2 <cfif view eq "tolaunch">btn-info <cfelse>btn-outline-info</cfif>">TP TO LAUNCH</a>
					<a href="cs_alert_tp.cfm?view=tpstop" class="btn p-2 <cfif view eq "tolaunch">btn-info <cfelse>btn-outline-info</cfif>">TP STOP</a>
					<a href="cs_alert_tp.cfm?view=nobuilt" class="btn p-2 <cfif view eq "nobuilt">btn-info <cfelse>btn-outline-info</cfif>">TP NOT BUILT</a>
					<a href="cs_alert_tp.cfm?view=noscheduled" class="btn p-2 <cfif view eq "noscheduled">btn-info <cfelse>btn-outline-info</cfif>">TP WITH NO SCHEDULE</a>
					<a href="cs_alert_tp.cfm?view=noclose" class="btn p-2 <cfif view eq "noclose">btn-info <cfelse>btn-outline-info</cfif>">TP NOT CLOSED / PTA</a>
					<a href="cs_alert_tp.cfm?view=noclosenoremain" class="btn p-2 <cfif view eq "noclosenoremain">btn-info <cfelse>btn-outline-info</cfif>">TP NOT CLOSED / NO REMAIN</a>
					<a href="cs_alert_tp.cfm?view=wrongdate" class="btn p-2 <cfif view eq "wrongdate">btn-info <cfelse>btn-outline-info</cfif>">TP WITH WRONG DATE</a>
					<a href="cs_alert_tp.cfm?view=notcloseddeadline" class="btn p-2 <cfif view eq "notcloseddeadline">btn-info <cfelse>btn-outline-info</cfif>">TP OUTDATED DEADLINE NOT PAID</a>
					<a href="cs_alert_tp.cfm?view=minusremain" class="btn p-2 <cfif view eq "minusremain">btn-info <cfelse>btn-outline-info</cfif>">TP WITH MINUS REMAIN</a>
					<a href="cs_alert_tp.cfm?view=ptascheduled" class="btn p-2 <cfif view eq "ptascheduled">btn-info <cfelse>btn-outline-info</cfif>">TP PTA SCHEDULED</a>
					<!---<a href="cs_alert_tp.cfm?view=ptaleft" class="btn <cfif view eq "ptaleft">btn-info <cfelse>btn-outline-info</cfif>">TP ONLY PTA LEFT</a>--->
					
					
					<div class="card">
						<div class="card-body">
						<table class="table table-sm table-bordered">						
							<tr class="bg-light">
								<!--- <td><strong>ORDER ID</strong></td> --->
								<td><strong>TRAINER</strong></td>
								<td><strong>LEARNER</strong></td>
								<td><strong>COMPTE</strong></td>
								<td><strong>TP NAME</strong></td>
								<td><strong>TP STATUS</strong></td>
								<td><strong>TP END</strong></td>
								<td><strong>HOUR</strong></td>
								<cfif view eq "nobuilt">
								<td><strong>BUILT</strong></td>
								<cfelseif view eq "noscheduled">
								<td><strong>LAST LESSON</strong></td>
								<cfelseif view eq "noclose" OR view eq "ptascheduled">
								<td><strong>PTA DATE</strong></td>
								</cfif>
								<cfif view eq "nobuilt" OR view eq "noscheduled" OR view eq "minusremain">
								<td><strong>REMAINING</strong></td>
								</cfif>
								<cfif view eq "ptaleft">
								<td><strong>INFO</strong></td>
								</cfif>
								<td><strong>DEADLINE</strong></td>
								<td><strong>COMMENTS</strong></td>
							</tr>
							<cfoutput query="get_tp">
							<cfif view eq "nobuilt" OR view eq "noscheduled" OR view eq "noclosenoremain" OR view eq "minusremain">
							<cfif tp_scheduled eq ""><cfset tp_scheduled_go = "0"><cfelse><cfset tp_scheduled_go = tp_scheduled></cfif>
							<cfif tp_inprogress eq ""><cfset tp_inprogress_go = "0"><cfelse><cfset tp_inprogress_go = tp_inprogress></cfif>
							<cfif tp_cancelled eq ""><cfset tp_cancelled_go = "0"><cfelse><cfset tp_cancelled_go = tp_cancelled></cfif>
							<cfif tp_missed eq ""><cfset tp_missed_go = "0"><cfelse><cfset tp_missed_go = tp_missed></cfif>
							<cfif tp_completed eq ""><cfset tp_completed_go = "0"><cfelse><cfset tp_completed_go = tp_completed></cfif>
							<cfif tp_duration eq ""><cfset tp_duration_go = "0"><cfelse><cfset tp_duration_go = tp_duration></cfif>
							<cfset tp_remain_go = tp_duration_go-tp_missed_go-tp_completed_go-tp_scheduled_go-tp_inprogress_go>
							<cfset tp_remain_without_schedule_go = tp_duration_go-tp_missed_go-tp_completed_go>							
							<cfset tp_done_go = tp_completed_go+tp_inprogress_go>
							</cfif>
							<cfif 
							(view eq "noclosenoremain" AND isdefined("tp_remain_without_schedule_go") AND tp_remain_without_schedule_go eq "0") 
							OR (view neq "noclosenoremain" AND view neq "minusremain")
							OR (view eq "minusremain" AND tp_remain_go lt 0)							
							>
							
							<tr>
								<td>
									<!--- <span class="badge badge-pill text-white badge-#status_finance_css#">#order_ref# - #status_finance_name#</span> --->
								</td>
								<td>
									<cfset tp_trainer = obj_tp_get.oget_tp_trainer(t_id="#tp_id#")>
									<cfloop query="tp_trainer">
										#planner#,
									</cfloop>
								</td>
								<td>
									<span class="badge badge-#user_status_css#">#user_status_name#</span>
									<a href="common_learner_account.cfm?u_id=#user_id#">#user_firstname# #user_name#</a>
								</td>
								<td>
									#account_name#
								</td>
								<td>
									<a class="btn btn-sm btn-outline-info m-0 p-0 px-1" href="common_tp_details.cfm?t_id=#tp_id#&u_id=#user_id#">#obj_lms.get_tp_icon(tp_id="#tp_id#",tp_name="#tp_name#",tp_rank="#tp_rank#",formation_code="#formation_code#",method_id="#method_id#",tp_duration="#tp_duration#",elearning_name="#elearning_name#",elearning_duration="#elearning_duration#",certif_name="#certif_name#")#</a>
								</td>
								<td>
									<span class="badge badge-info">#status_name#</span>
								</td>
								<td>
									#dateformat(tp_date_end,'dd/mm/yyyy')#
								</td>
								<td>
									#tp_duration/60#
								</td>
								<cfif view eq "nobuilt">
								<td>
									#session_duration/60#
								</td>
								
								<td>
									#tp_remain_go/60#
								</td>
								
								<cfelseif view eq "noscheduled">
								<td>
									#dateformat(maxl,'dd/mm/yyyy')# - #timeformat(maxl,'HH:mm')#
								</td>
								
								<cfelseif view eq "noclose" OR view eq "ptascheduled">
								<td>
									#dateformat(lesson_start,'dd/mm/yyyy')# - #timeformat(lesson_start,'HH:mm')#
								</td>
								</cfif>
								
								
								<cfif view eq "noscheduled" OR view eq "minusremain">
								<td>
									#tp_remain_go/60#
								</td>
								</cfif>
								<cfif view eq "ptaleft">
								<td>
								#tp_duration# // #session_duration#
								</td>
								</cfif>
								<td>
									<cfif order_end lt now()><strong style="color:##FF0000">#dateformat(order_end,'dd/mm/yyyy')#</strong><cfelse>#dateformat(order_end,'dd/mm/yyyy')#</cfif>
								</td>
			
								<td>
									<button type="button" class="btn btn-outline-info btn-sm btn_view_log" id="l_#user_id#">
									<i class="fas fa-sticky-note"></i> 
									</button>
								</td>
								
								<!---<td width="2%">
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-warning" style="width:54px; padding:2px !important"><i class="far fa-calendar-alt"></i> <cfif tp_scheduled_go neq "0">#obj_lms.get_formath(tp_scheduled_go)#<cfelse>-</cfif> </button>
									</cfif>
								</td>
								<td class="border-0" width="2%">
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-success" style="width:54px; padding:2px !important"><i class="far fa-thumbs-up"></i> <cfif tp_done_go neq "0">#obj_lms.get_formath(tp_done_go)#<cfelse>-</cfif> </button>
									</cfif>
								</td>
								<td class="border-0" width="2%">	
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="far fa-thumbs-down"></i> <cfif tp_missed_go neq "0">#obj_lms.get_formath(tp_missed_go)#<cfelse>-</cfif></button>
									</cfif>
								</td>
								<!---<td class="border-0" width="2%">
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-danger" style="width:54px; padding:2px !important"><i class="fas fa-window-close"></i> <cfif tp_cancelled_go neq "">#obj_lms.get_formath(tp_cancelled_go)#<cfelse>-</cfif> </button>
									</cfif>
								</td>--->
								<td class="border-0" width="2%">	
									<cfif method_scheduler eq "scheduler">
									<button type="button" class="btn btn-sm btn-outline-info" style="width:54px; padding:2px !important"><i class="fas fa-hourglass-half"></i> <cfif tp_remain_go neq "">#obj_lms.get_formath(tp_remain_go)#<cfelse>-</cfif></button>
									</cfif>
								</td>--->
							</tr>	
							</cfif>							
							</cfoutput>
						</table>
						</div>						
					</div>
						
				</div>
				
			</div>
		
	</div>
      
	<cfinclude template="./incl/incl_footer.cfm">
	  
	
</div>

<cfinclude template="./incl/incl_scripts.cfm">

<cfinclude template="./incl/incl_scripts_param.cfm">

<script>
$( document ).ready(function() {

})
</script>

</body>
</html>