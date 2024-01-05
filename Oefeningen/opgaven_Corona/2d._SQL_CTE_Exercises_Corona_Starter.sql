-- 1. Give the names of all countries for which a larger percentage of people was vaccinated (not fully vaccinated) than for Belgium on 1 april 2021
--country	percentage_people_vaccinated
--Austria	0.142731363855
--Bahrain	0.296061591436
--Barbados	0.221526686779
--Bhutan	0.557554814719
--Canada	0.138320243613
--Chile	0.361848064282

-- procent mensen gevaccineerd in belgie 1 april
select CovidData.country,
       report_date,
       cast(people_vaccinated as numeric) / population as percentage_vac_bel,
       people_vaccinated,
       population
from CovidData
         inner join Countries C on C.iso_code = CovidData.iso_code
where C.country = 'Belgium'
  and report_date = cast('1 april 2021' as date)

-- procent mensen gevaccineerd in alle landen op 1 april
select CovidData.country,
       report_date,
       cast(people_vaccinated as numeric) / population as percentage_vac_country,
       people_vaccinated,
       population
from CovidData
         inner join Countries C on C.iso_code = CovidData.iso_code
where report_date = cast('1 april 2021' as date)


select conty.country,
       conty.percentage_vac_country,
       bel.percentage_vac_bel
from (select CovidData.country,
             report_date,
             cast(people_vaccinated as numeric) / population as percentage_vac_country,
             people_vaccinated,
             population
      from CovidData
               inner join Countries C on C.iso_code = CovidData.iso_code
      where report_date = cast('1 april 2021' as date)) as conty
         left join (select CovidData.country,
                           report_date,
                           cast(people_vaccinated as numeric) / population as percentage_vac_bel,
                           people_vaccinated,
                           population
                    from CovidData
                             inner join Countries C on C.iso_code = CovidData.iso_code
                    where C.country = 'Belgium'
                      and report_date = cast('1 april 2021' as date)) as bel on conty.report_date = bel.report_date
where conty.percentage_vac_country > bel.percentage_vac_bel


-- 2. Give for each month the percentage of fully vaccinated people in Belgium at the end of the month

/*
month	year	(No column name)
12	2020	0.00%
1	2021	0.24%
2	2021	2.95%
3	2021	4.90%
4	2021	7.56%
5	2021	19.24%
6	2021	35.23%
7	2021	59.64%
8	2021	70.52%
9	2021	72.86%
10	2021	74.15%
11	2021	75.11%
12	2021	75.90%
1	2022	76.42%
2	2022	78.15%
3	2022	78.57%
4	2022	78.62%
5	2022	78.66%
6	2022	78.69%
7	2022	78.71%
8	2022	78.73%
*/

-- fully vaccinated per maand belgie
select year(report_date) as jaar, month(report_date) as maand, max(people_fully_vaccinated) as vaccinaties, iso_code
from CovidData cd
where cd.iso_code = 'BEL'
group by year(report_date), month(report_date), iso_code

-- populatie belgie en iso code
select population, iso_code
from Countries
where iso_code = 'BEL'


-- alle waarden na join
select *
from (select year(report_date)            as jaar,
             month(report_date)           as maand,
             max(people_fully_vaccinated) as vaccinaties,
             iso_code
      from CovidData cd
      where cd.iso_code = 'BEL'
      group by year(report_date), month(report_date), iso_code) as monthly
         left join (select population, iso_code
                    from Countries
                    where iso_code = 'BEL') as bel on monthly.iso_code = bel.iso_code

-- jaar, maand en procent
select jaar, maand, round((cast(vaccinaties as numeric) / population) * 100, 2) as procent
from (select year(report_date)            as jaar,
             month(report_date)           as maand,
             max(people_fully_vaccinated) as vaccinaties,
             iso_code
      from CovidData cd
      where cd.iso_code = 'BEL'
      group by year(report_date), month(report_date), iso_code) as monthly
         left join (select population, iso_code
                    from Countries
                    where iso_code = 'BEL') as bel on monthly.iso_code = bel.iso_code

-- 3. What is the percentage of the total amount of new_cases that died in the following periods in Belgium
-- march 2020 - may 2020 / june 2020 - august 2020 / september 2020 - november 2020 / december 2020 - february 2021 / march 2021 - may 2021 / june 2021 - august 2021
select period, round((cast(sum(new_deaths) as numeric) / sum(new_cases) * 100), 2) as percentage_deats_per_new_case
from (select FORMAT(report_date, 'MMMM yyyy') AS month_and_year,
             case
                 when report_date >= cast('march 2020' as date) and report_date < cast('june 2020' as date)
                     then 'march 2020 - may 2020'
                 when report_date >= cast('june 2020' as date) and report_date < cast('september 2020' as date)
                     then 'june 2020 - august 2020'
                 when report_date >= cast('september 2020' as date) and report_date < cast('december 2020' as date)
                     then 'september 2020 - november 2020'
                 when report_date >= cast('december 2020' as date) and report_date < cast('march 2021' as date)
                     then 'december 2020 - february 2020'
                 when report_date >= cast('march 2021' as date) and report_date < cast('june 2021' as date)
                     then 'march 2021 - may 2021'
                 when report_date >= cast('june 2021' as date) and report_date < cast('august 2021' as date)
                     then 'june 2021 - august 2021'
                 end                          as period,
             new_deaths,
             new_cases
      from CovidData
      where iso_code = 'BEL') as reports_with_period
where period is not null
group by period;


/*
march 2020 - may 2020	16.22%
june 2020 - august 2020	1.59%
september 2020 - november 2020	1.37%
december 2020 - february 2021	2.80%
march 2021 - may 2021	0.99%
june 2021 - august 2021	0.35%
*/


-- 4. Which country(ies) was(were) the first to have 50% of the population fully vaccinated
-- Gibraltar

--- land, procent gevaccineerd (meer dan 50) en report date
select *
from (select Countries.country,
             cast(people_fully_vaccinated as numeric) / population as percentage_vaccinated,
             report_date
      from CovidData
               full join Countries on CovidData.iso_code = Countries.iso_code) as all_countries
where percentage_vaccinated > 0.5

--- eerste dag waarop meer dan 50% gevaccineerd
select min(report_date) as reported_first_day
from (select cast(people_fully_vaccinated as numeric) / population as percentage_vaccinated,
             report_date
      from CovidData
               full join Countries on CovidData.iso_code = Countries.iso_code) as vaccinations
where percentage_vaccinated > 0.5

--- landen die meer dan 50% gevaccineerd hebben op die eerste dag
select country
from (select *
      from (select Countries.country,
                   cast(people_fully_vaccinated as numeric) / population as percentage_vaccinated,
                   report_date
            from CovidData
                     full join Countries on CovidData.iso_code = Countries.iso_code) as all_countries
      where percentage_vaccinated > 0.5) as a
         inner join (select min(report_date) as reported_first_day
                     from (select cast(people_fully_vaccinated as numeric) / population as percentage_vaccinated,
                                  report_date
                           from CovidData
                                    full join Countries on CovidData.iso_code = Countries.iso_code) as vaccinations
                     where percentage_vaccinated > 0.5) as b on a.report_date = b.reported_first_day


-- 5. Give the countries in which a total of more new_cases were identified in the first half of 2021 than in the second half of 2021
--iso_code	continent	country
--AFG	Asia	Afghanistan
--ARE	Asia	United Arab Emirates
--ARG	South America	Argentina
--BFA	Africa	Burkina Faso
--BHR	Asia	Bahrain
--BIH	Europe	Bosnia and Herzegovina

--- reports voor eerste helft 2021
select country, sum(new_cases) as total_cases_first_half
from CovidData
where report_date >= cast('2021' as date)
  and report_date < cast('july 2021' as date)
group by country

--- reports voor tweede helft 2021
select country, sum(new_cases) as total_cases_second_half
from CovidData
where report_date >= cast('july 2021' as date)
  and report_date < cast('2022' as date)
group by country

--- eerste en tweede mergen en enkel houden wanneer first half meer dan second half
select first.country
from (select country, sum(new_cases) as total_cases_first_half
      from CovidData
      where report_date >= cast('2021' as date)
        and report_date < cast('july 2021' as date)
      group by country) as first
         inner join (select country, sum(new_cases) as total_cases_second_half
                     from CovidData
                     where report_date >= cast('july 2021' as date)
                       and report_date < cast('2022' as date)
                     group by country) as second on first.country = second.country
where total_cases_first_half > total_cases_second_half



