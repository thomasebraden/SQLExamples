select a.install_date,
	a.event_date,
	--a.event_name ,
	a.age ,
	a.app_id ,
	a.user_acquired_source,
	sum(case when a.event_name = 'first_open'then 1 else 0 end) as installs,
	sum(case when a.event_name = 'ad_banner_clicked'then 1 else 0 end) as ad_banner_clicks,
	sum(b.ad_banner_clicked_RPE * a.events)as ad_banner_revenue,
	sum(case when a.event_name = 'search_submit'then 1 else 0 end) as search_submit,
	sum(b.search_submit_RPE * a.events)as search_submit_revenue,
	sum(case when a.event_name = 'sponsored_content_clicked'then 1 else 0 end) as sponsored_content_clicks,
	sum(b.sponsored_content_clicked_RPE * a.events)as sponsored_content_revenue
from case_study_rollup_events a,
	case_study_RPE_table b
where a.app_id = b.app_id and 
	a.event_date = b.event_date
group by a.install_date,
	a.event_date,
	a.event_name ,
	a.age ,
	a.app_id ,
	a.user_acquired_source,
	b.sponsored_content_clicked_RPE 
	;

select *
from case_study_rollup_events csre ;

select --*
sum(a.events)
from case_study_rollup_events a
where a.event_name = 'first_open' 
	and app_id = 'com.home.weather.radar'
	and a.user_acquired_source = 'google'
	and a.install_date = '2020-05-01' ;