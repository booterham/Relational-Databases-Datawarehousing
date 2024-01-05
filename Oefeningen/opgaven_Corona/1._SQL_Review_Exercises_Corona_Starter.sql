-- Always give new columns an appropriate name

-- How many countries can be found in the dataset?
--236
SELECT count(*) AS amount_of_countries
FROM Countries;
-- klopt


-- Give the total population per continent
--continent	TotalPopulation
--Africa	1426160609
--Asia	4721455390
--Europe	745629155
--North America	600323657
--Oceania	45038907
--South America	436816679
SELECT continent, sum(CAST(population AS BIGINT)) AS TotalPopulation
FROM Countries
GROUP BY continent;
-- klopt

-- Which country with more than 1 000 000 inhabitants,
-- has the highest life expectancy?
-- Hong Kong
SELECT country
FROM Countries
where life_expectancy = (SELECT max(life_expectancy) from Countries WHERE population > 1000000);

-- Calculate the average life_expectancy for each continent
-- Take into account the population for each country
--continent	Average life expectancy
--Africa	53,7504029929835
--Asia	70,4684712882567
--Europe	74,8623831769607
--North America	72,7075400107879
--Oceania	63,9352353833348
--South America	76,043031459972

SELECT continent, totalAgesInCountry / sumPopulation AS 'Average life expectancy'
FROM (SELECT continent,
             sum(life_expectancy * CAST(population AS BIGINT)) AS totalAgesInCountry,
             sum(CAST(population AS BIGINT))                   AS sumPopulation
      FROM Countries
      GROUP BY continent) AS prep;
-- klopt

-- Give the country with the highest number of Corona deaths
-- United States	1129589
-- United States	1127152 (if you use total deaths)
SELECT TOP 1 country, total_deaths
FROM CovidData
ORDER BY total_deaths DESC;


-- On which day was 50% of the Belgians fully vaccinated?
-- 2021-07-21
SELECT TOP 1 report_date
FROM CovidData


-- On which day the first Belgian receive a vaccine?
-- 2020-12-28
select top 1 cast(report_date as date)
from CovidData
where country = 'Belgium'
  and total_vaccinations > 0
order by report_date;


-- On which day the first Corona death was reported in Europe?
-- 2020-01-05
select cast(min(report_date) as date)
from (select report_date, Countries.country, total_deaths
      from CovidData
               left join Countries on CovidData.country = Countries.country
      where continent = 'Europe'
        and total_deaths > 0)
         as deaths;


-- What is the estimated total amount of smokers in Belgium?
-- Subtract 2 000 000 children from the total Belgian population
-- 2727798
select ((male_smokers + female_smokers) / 100) * (population - 2000000) as total_smokers, population, country
from Countries
where country = 'Belgium';
-- lijkt alsof het niet klopt maar door na te gaan is dit wel effectief juist

SELECT male_smokers,
       female_smokers,
       population,
       (population - 2000000)                                           AS adjusted_population,
       ((male_smokers + female_smokers) / 100)                          AS smoker_percentage,
       ((male_smokers + female_smokers) / 100) * (population - 2000000) AS total_smokers
FROM Countries
WHERE country = 'Belgium';


-- The first lockdown in Belgium started on 18 march 2020. Give all the data until 21 days afterwards
-- to be able to check if the lockdown had any effect.
select *
from CovidData
where country = 'Belgium'
  and CONVERT(DATE, '18 March 2020', 106) <= report_date
  and report_date <= dateadd(day, 21, CONVERT(DATE, '18 March 2020', 106));

-- In which month (month + year) the number of deaths was the highest in Belgium?
--Reported year	Reported month	Total number of deaths
--2020	4	6651
--2020	11	5186
--2020	12	2834
--2020	5	1703
--2021	1	1670
--2020	10	1502
select [Reported year], [Reported month], sum(new_deaths) as 'Total number of deaths'
from (select year(report_date) as 'Reported year', month(report_date) as 'Reported month', new_deaths
      from CovidData
      where country = 'Belgium') as results_belgium
group by [Reported year], [Reported month]
order by [Total number of deaths] desc;