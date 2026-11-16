select * from marketing_AB

--Checking duplicates

select user_id , count(*) as row_count
from marketing_AB
group by user_id
having count(*) >1;

-- No duplicates are there

select * from marketing_AB 
where test_group is null;

-- no nulls in test group

select * from marketing_AB 
where converted is null or total_ads is null or most_ads_day is null or most_ads_hour is null;

-- no nulls in any column

--counting the number of records for each test group
select test_group, count(user_id) as record_count
from marketing_AB
group by test_group;

--counting the number of records for each day
select most_ads_day, count(user_id) as user_count 
from marketing_AB 
group by most_ads_day
order by user_count desc;

--counting the number of records for each hour
select most_ads_hour, count(user_id) as user_count
from marketing_AB
group by most_ads_hour
order by user_count desc;

-- calculating the conversion rate for each test group

select test_group, count(user_id) as total_user,
sum(case when converted = 'False' then 0 else 1 end) as total_conversions,
round(cast(100.00*sum(case when converted = 'False' then 0 else 1 end)/ count(user_id) as float),2) as percent_conversion
from marketing_AB
group by test_group;