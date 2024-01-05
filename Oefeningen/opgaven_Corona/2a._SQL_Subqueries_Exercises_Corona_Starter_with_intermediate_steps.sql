-- 1. Which country(ies) have the highest value for median_age
-- Japan	48.2

-- Step 1: what is the highest value for median_age
select max(median_age)
from Countries
-- Step 2: what is the corresponding country, i.e. what is the country for which the median_age is the highest value for median_age?
select country, median_age
from Countries
where median_age = (select max(median_age) from Countries);

-- 2. Give for each continent the countries in which the life_expectancy
-- is higher than the average life_expectancy of that continent
--continent	country	life_expectancy
--Africa	Angola	61,15
--Africa	Burundi	61,58
--Africa	Benin	61,77
--Africa	Burkina Faso	61,58
--Africa	Botswana	69,59
--Africa	Cote d'Ivoire	57,78

-- Step 1: make a list of continent, country and life_expectancy for all countries
select continent, country, life_expectancy
from Countries;
-- Step 2: make a list of continent, country and life_expectancy for all countries with life_expectancy > average life_expectancy for the entire world
select continent, country, life_expectancy
from Countries
where life_expectancy > (select round(avg(life_expectancy), 2) as full_avg from Countries)
-- Step 3: make a list of continent, country and life_expectancy for all countries with life_expectancy > average life_expectancy for the continent of the country
select continent, country, life_expectancy
from Countries as c
where life_expectancy >
      (select round(avg(life_expectancy), 2) as full_avg from Countries where c.continent = Countries.continent)

-- snellere methode met full join
select c.continent, c.country, c.life_expectancy
from Countries as c
         full join (select avg(life_expectancy) as avg_cont, continent from Countries group by continent) as Cont
                   on Cont.continent = c.continent
where c.life_expectancy > avg_cont;

-- 3. On which day(s) the highest number of new cases was reported in Belgium?
--report_date	new_cases
--2022-01-26 00:00:00.000	76079
-- attempt zonder steps eerst
select report_date, CovidData.new_cases
from CovidData
         inner join (select max(new_cases) as new_cases
                     from CovidData
                     where country = 'Belgium') as maxcount on CovidData.new_cases = maxcount.new_cases;


-- Step 1: what is the highest number of new_cases for Belgium?
-- Step 2: what is the report_date for which new_cases in Belgium is the highest number of new_cases for Belgium 


-- 4. Which country(ies) was(were) the first to start vaccinations?
--country	report_date
--Latvia	2020-12-04 00:00:00.000
-- zonder steps eerst
select CovidData.country, report_date
from CovidData
         inner join (select min(report_date) as first_date
                     from CovidData
                     where total_vaccinations > 0) as firstday
                    on CovidData.report_date = first_date and CovidData.total_vaccinations > 0;



-- Step 1: what is minimum date for which total_vaccinations > 0
-- Step 2: what is the corresponding country?


-- 5. Assume that all people in Belgium got fully vaccinated from elder to younger.
-- We don't take into account people on priority lists like doctors, nurses, ...
-- On which day all Belgians of 70 or older were fully vaccinated?
-- 2021-05-18
select min(report_date) as datum
from CovidData
where country = 'Belgium'
  and total_vaccinations >= (select aged_70_older * 0.01 * population from Countries where country = 'Belgium')

-- Step 1: Calculate the absolute number of people in Belgium which are 70 year or older. aged_70_older in Belgium = 12.849 => 1494638 Belgians are older than 70
select round(aged_70_older * 0.01 * population, 0)
from Countries
where country = 'Belgium'
-- Step 2: Which is the minimum date on which there are more people fully vaccinated than there are 70+ Belgians


-- 6. On which day(s) the highest number of new deaths (> 0) was reported for each country?
-- Order descending on new_deaths
--country	report_date	new_deaths
--Chile	2022-03-22 00:00:00.000	11447
--Ecuador	2021-07-21 00:00:00.000	8786
--Germany	2020-12-20 00:00:00.000	6460
--India	2021-06-10 00:00:00.000	6148
--Spain	2020-04-05 00:00:00.000	5841
--France	2020-11-22 00:00:00.000	5602
--United States	2021-02-14 00:00:00.000	5061
--Ukraine	2021-11-14 00:00:00.000	4591
--China	2023-01-03 00:00:00.000	4432
--Brazil	2021-04-10 00:00:00.000	4249
select country as Country, new_deaths
from CovidData
         inner join (select country as contrey, max(new_deaths) as max_deaths
                     from CovidData
                     group by country) as max_country_deaths
                    on CovidData.country = max_country_deaths.contrey and new_deaths = max_deaths
order by new_deaths desc

-- Step 1: what is het maximum new deaths per iso_code
-- Step 2: Give a list of country, report_date and new_deaths for which new_deaths is the maximum new_deaths for this country


-- 7. Give for each country the percentage of fully vaccinated people
-- based on the most recent data on the fully vaccinated people for that country
-- Order the results in a descending way
-- You could try to solve this taking into account that - for now - the number of fully vaccinated people is an always increasing number.
-- But once the vaccination campaign is done and old people are dying and new babies are born, it's possible this won't be the case any more.
--Macao	0.923884461578
--Hong Kong	0.908197279079
--Taiwan	0.870232762224
--Uruguay	0.848123580838
--Bangladesh	0.830627757696
select country, cast(people_fully_vaccinated as numeric) / population as percentage_fully_vaccinated
from (select lates_report.iso_code, people_fully_vaccinated, report_date
      from (select iso_code, max(report_date) as last_date
            from CovidData
            group by iso_code) as lates_report
               left join CovidData
                         on lates_report.iso_code = CovidData.iso_code and
                            lates_report.last_date = CovidData.report_date) as latest_vac_stats
         left join Countries on Countries.iso_code = latest_vac_stats.iso_code
order by percentage_fully_vaccinated desc

-- Take into account that you only use rows with people_fully_vaccinated IS NOT NULL
-- Step 1: calculate the percentage of people fully vaccinated per country
-- Step 2: Instead of getting a lot of rows for each country, retrieve only the 'most recent' row, i.e. the row for which the report_date is as large as possible


-- 8. State the countries where there are percentages of more people smoking than the average for the continent to which the country belongs.
-- Assume that in each country the distribution is men/women = 50/50.
select country, round((female_smokers + male_smokers) / 2, 2) as smokers_in_country
from Countries
         left join (select avg((female_smokers + male_smokers) / 2) as avg_smokers_per_cont, continent
                    from Countries
                    group by continent) as avg_smoking on avg_smoking.continent = Countries.continent
where (female_smokers + male_smokers) / 2 > avg_smokers_per_cont

-- Step 1: Calculate the percentage of people smoking for each country
-- Step 2: Calculate the average percentage of people smoking for a continent
-- Step 3: Keep those rows for which the percentage of people smoking for a country is larger than the average percentage for the continent the country belongs to

--iso_code	country	continent	percentage_smokers
--BFA	Burkina Faso	Africa	12,75
--BWA	Botswana	Africa	20,05
--COG	Congo	Africa	27
--COM	Comoros	Africa	14
--DJI	Djibouti	Africa	13,1
--DZA	Algeria	Africa	15,55
--EGY	Egypt	Africa	25,15


-- 9. List all countries where the percentage of people have been vaccinated at least 1 time on 2021-12-01 is larger than average across that continent
--iso_code	country	continent	Percentage_Vaccinated
--ETH	Ethiopia	Africa	6.57%
--GNQ	Equatorial Guinea	Africa	14.80%
--MWI	Malawi	Africa	5.67%
--TUN	Tunisia	Africa	49.59%
--ZAF	South Africa	Africa	29.01%

-- Step 1: Calculate the percentage of people been vaccinated at least 1 time on 2021-12-01 for each country
select distinct C.iso_code, cast(people_vaccinated as numeric) / population as percentage_vaccinated, continent
from CovidData
         inner join Countries C on C.iso_code = CovidData.iso_code
where report_date = (select cast('2021-12-01' as date))
-- Step 2: What is the average percentage of people been vaccinated at least 1 time on 2021-12-01 for a continent
select avg(percentage_vaccinated) as avg_ppl_vac, continent
from (select distinct C.iso_code, cast(people_vaccinated as numeric) / population as percentage_vaccinated, continent
      from CovidData
               inner join Countries C on C.iso_code = CovidData.iso_code
      where report_date = (select cast('2021-12-01' as date))) as vaccinated_per_country
group by continent
-- Step 3: Keep only those countries for which the percentage is larger than the percentage for the continent they belong to
select iso_code, format(percentage_vaccinated, '0.##%') as Percentage_vaccinated
from (select distinct C.iso_code, cast(people_vaccinated as numeric) / population as percentage_vaccinated, continent
      from CovidData
               inner join Countries C on C.iso_code = CovidData.iso_code
      where report_date = (select cast('2021-12-01' as date))) as vaccinated_per_country
         left join (select avg(percentage_vaccinated) as avg_ppl_vac, continent
                    from (select distinct C.iso_code,
                                          cast(people_vaccinated as numeric) / population as percentage_vaccinated,
                                          continent
                          from CovidData
                                   inner join Countries C on C.iso_code = CovidData.iso_code
                          where report_date = (select cast('2021-12-01' as date))) as vaccinated_per_country
                    group by continent) as vaccinated_per_continent
                   on vaccinated_per_country.continent = vaccinated_per_continent.continent
where vaccinated_per_country.percentage_vaccinated > vaccinated_per_continent.avg_ppl_vac;


-- 10. Give an overview of the cumulative sum of Corona deaths for each country
-- Give country, report_date, new_deaths and the cumulative sum
-- Order by country and report_date
--country	report_date	new_deaths	TotalDeaths
--Afghanistan	2020-01-03 00:00:00.000	0	0
--Afghanistan	2020-01-04 00:00:00.000	0	0
--Afghanistan	2020-01-05 00:00:00.000	0	0
--Afghanistan	2020-01-06 00:00:00.000	0	0
--Afghanistan	2020-01-07 00:00:00.000	0	0
--Afghanistan	2020-01-08 00:00:00.000	0	0
--Afghanistan	2020-01-09 00:00:00.000	0	0

-- Step 1: Copy and paste the example of cumulative sum out of 2a. SQL Advanced Subqueries
-- Step 2: Calculate for each country the cumulative sum of deaths
SELECT iso_code, report_date, new_deaths,
(
	SELECT SUM(new_deaths)
	FROM CovidData
	WHERE country = o.country and report_date <= o.report_date
) As TotalDeaths
FROM CovidData o where country = 'Belgium'
order by report_date



