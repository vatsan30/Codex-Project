Create database marketing;

select * from marketing.dim_repondents;

1) Who Prefers Energy drink more?
select gender, count(*) as respondents_count
from marketing.dim_repondents
group by gender
order by respondents_count desc;

2) Which Age group preders Energy dring?
select age, count(*) as respondents_count
from marketing.dim_repondents
group by age
order by respondents_count desc;

3) Which type of marketing reaches the youth (15-30)?
select fs.marketing_channels, count(*) as market_response
from marketing.fact_survey_responses fs
join marketing.dim_repondents dr
on fs.Respondent_ID = dr.Respondent_ID
where dr.age in ("19-30" , "15-18")
group by fs.marketing_channels
order by market_response desc;

4) What are the preferred ingredients of Energy drink from respondents?
select Ingredients_expected, count(*) as preferred_ingredient_count
from marketing.fact_survey_responses
group by Ingredients_expected
order by preferred_ingredient_count desc;

5) What packaging preferences do respondents have for Energy drinks?
select Packaging_preference, count(*) as preferred_packaging_count
from marketing.fact_survey_responses
group by Packaging_preference
order by preferred_packaging_count desc;

6) Who are the current market leaders?
select current_brands, count(*) as current_brands_count
from marketing.fact_survey_responses
group by current_brands
order by current_brands_count desc;

7) What are the Primary reasons consumers prefer those brands over ours?
select Reasons_for_choosing_brands, count(*) as reason_for_choosing_brands_count
from marketing.fact_survey_responses
group by Reasons_for_choosing_brands
order by reason_for_choosing_brands_count desc;

8) Which marketing channel can be used to reach more customers?
select fs.marketing_channels, count(*) as market_response, age
from marketing.fact_survey_responses fs
join marketing.dim_repondents dr
on fs.Respondent_ID = dr.Respondent_ID
group by fs.marketing_channels, age
order by market_response desc;

select marketing_channels, count(*) as market_response
from marketing.fact_survey_responses 
group by marketing_channels
order by market_response desc;

9) How effective are different marketing strategies and channels in reaching customers? 
select marketing_channels, count(*) as market_response,
SUM(CASE WHEN Heard_before = 'Yes' THEN 1 ELSE 0 END) as heard_count,
SUM(CASE WHEN Tried_before = 'Yes' THEN 1 ELSE 0 END) as tried_count
from marketing.fact_survey_responses
group by marketing_channels
order by market_response desc;

10) What do people think about our brand? (overall rating) 
with cte as 
(select Brand_perception, count(*) as respondent_count 
from marketing.fact_survey_responses
where Heard_before = 'Yes'
group by Brand_perception), 
total as 
(select count(*) as total_heard
from marketing.fact_survey_responses
where Heard_before = 'Yes')
select
c.Brand_perception,
c.respondent_count,
round((c.respondent_count * 100) / t.total_heard , 1) as percentage
from cte c, total t
order by percentage desc;

11) Which cities do we need to focus more on? 
select c.city, c.tier, count(*) as respondent_count,
sum(case when s.heard_before = 'Yes' then 1 else 0 end) as awarness,
round(sum(case when s.heard_before = 'Yes' then 1 else 0 end )*100 / count(*), 1) as awarness_pct_in_city
from marketing.fact_survey_responses s
join marketing.dim_repondents r
on s.respondent_id = r.respondent_id
join marketing.dim_cities c
on c.city_id = r.city_id
group by c.city, c.tier
order by respondent_count desc;

12) Where do respondents prefer to purchase energy drinks? 
select Purchase_location, count(*) as respondent_count
from marketing.fact_survey_responses
group by Purchase_location
order by respondent_count desc;

13) What are the typical consumption situations for energy drinks among respondents? 
select Typical_consumption_situations, count(*) as respondent_count
from marketing.fact_survey_responses
group by Typical_consumption_situations
order by respondent_count desc;

14) What factors influence respondents purchase decisions, such as price range and limited edition packaging? 
select Price_range, count(*) as respondent_count
from marketing.fact_survey_responses
group by Price_range
order by respondent_count desc;

select Limited_edition_packaging, count(*) as respondent_count
from marketing.fact_survey_responses
group by Limited_edition_packaging
order by respondent_count desc;

15) What immediate improvements can we bring to the product?
select Improvements_desired, count(*) as respondent_count
from marketing.fact_survey_responses
group by Improvements_desired
order by respondent_count desc;

select Ingredients_expected, count(*) as respondent_count
from marketing.fact_survey_responses
group by Ingredients_expected
order by respondent_count desc;

16) What should be the ideal price of our product? 
select Price_range, count(*) as respondent_count
from marketing.fact_survey_responses
group by Price_range
order by respondent_count desc;

