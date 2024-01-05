-- 1. We want to investigate the height of the waves in some countries
-- You can only compare countries if you take into account their population.

-- Part 1
-- Show for Belgium, France and the Netherlands a ranking (per country) 
-- of the days with the most new cases per 100.000 inhabitants
-- show only the top 5 days per country

/*

report_date	country	cases_per_100000	rank_new_cases
2022-01-26 00:00:00.000	Belgium	652.706782637462	1
2022-01-19 00:00:00.000	Belgium	538.653180876366	2
2022-01-27 00:00:00.000	Belgium	537.392019490863	3
2022-01-21 00:00:00.000	Belgium	523.450609617101	4
2022-01-20 00:00:00.000	Belgium	521.666109153260	5
2022-01-23 00:00:00.000	France	3564.276761093005	1
2022-01-30 00:00:00.000	France	3434.996239659062	2
2022-01-16 00:00:00.000	France	2893.120788049489	3
2022-01-09 00:00:00.000	France	2545.554687154380	4
2022-02-06 00:00:00.000	France	2518.083553300989	5
2022-02-06 00:00:00.000	Netherlands	3565.823769273776	1
2022-01-30 00:00:00.000	Netherlands	3316.695152931959	2
2022-02-13 00:00:00.000	Netherlands	2924.677835711870	3
2022-03-13 00:00:00.000	Netherlands	2551.568490584729	4
2022-01-23 00:00:00.000	Netherlands	2413.638791119572	5

*/


-- Part 2
-- Give the top 10 of countries with more than 1.000.000 inhabitants with the highest number new cases per 100.000 inhabitants

/*

country	max_cases_per_100000	rank_max_cases_per_100000
Slovenia	4661.949021696418	1
Portugal	3946.175085487024	2
Latvia	3702.312804014148	3
Estonia	3622.072539485273	4
Netherlands	3565.823769273776	5
France	3564.276761093005	6
Greece	2323.732793887166	7
Australia	2249.317254839191	8
Spain	2011.214283875953	9
Germany	1905.834292113311	10

*/





-- 2. 
-- Make a ranking (high to low) of countries for the total number of deaths until now relative to the number of inhabitants. 
-- Show the rank number (1,2,3, ...), the country, relative number of deaths

/*

country	(No column name)	rank_deaths
Peru	0.006510	1
Bulgaria	0.005662	2
Bosnia and Herzegovina	0.005057	3
Hungary	0.004896	4
North Macedonia	0.004748	5
Georgia	0.004575	6
Croatia	0.004542	7
Slovenia	0.004450	8
Montenegro	0.004232	9
Czechia	0.004081	10
Latvia	0.003986	11

*/



-- 3.
-- In the press conferences, Sciensano always gives updates on the 
-- weekly average instead of the absolute numbers, to eliminate weekend, ... effects
-- 3.1 Calculate for each day the weekly average of the number of new_cases and new_deaths in Belgium
-- 3.2 Calculate for each day the relative difference with the previous day in Belgium for the weekly average number of new cases
-- 3.3 Give the day with the highest relative difference of weekly average number of new cases in Belgium
-- after 2020-04-01

/*

report_date				new_cases		new_deaths		weekly_avg_new_cases		weekly_avg_new_deaths		weekly_avg_new_cases_previous		relative difference
2022-06-15 00:00:00.000	4395			7				2452.428571					5.571428					1942.000000							0.208131
2020-07-30 00:00:00.000	685				1				454.428571					2.714285					377.285714							0.169757
2021-11-10 00:00:00.000	15262			29				9934.571428					23.142857					8265.428571							0.168013
2020-07-24 00:00:00.000	553				2				262.142857					2.428571					220.285714							0.159673
2022-01-05 00:00:00.000	27604			25				13866.000000				23.142857					11824.000000						0.147266
2022-08-24 00:00:00.000	2754			9				1959.142857					8.857142					1670.857142							0.147148
2023-08-18 00:00:00.000	285				0				149.142857					0.000000					127.285714							0.146551
2023-07-30 00:00:00.000	60				0				47.142857					0.000000					40.285714							0.145454
....
*/




-- 4
-- The main reason for the lockdowns was to prevent the hospital system from collapsing
-- (i.e. too much patients on IC)
-- Give those weeks for which the number of hospitalized patients in Belgium doubled compared to the week before

-- Step 1: Add 2 extra columns with the weeknumber and year of each date. Use DATEPART(WEEK,report_date) for the weeknumber
-- Step 2: Calculate the average number of hosp_patients during that week
-- Step 3: Calculate the relative difference between each 2 weeks
-- Step 4: Give those weeks for which the number of hosp_patients rose with 50%
-- You can use IIF(... = 0, NULL, ...) to solve division by zero problem

/*
report_week	report_year	avg_number_hosp_patients	avg_number_hosp_patients_previous_week	relative_change
12			2020		729							53											12.75471698113207547
13			2020		2759						729											2.78463648834019204
14			2020		5161						2759										0.87060529177238129
39			2020		546							351											0.55555555555555555
42			2020		1789						1052										0.70057034220532319
43			2020		3376						1789										0.88708775852431525
44			2020		5813						3376										0.72186018957345971
*/



-- 5
-- Rank the countries per continent based on the percentage of the population that is fully vaccinated. 
-- The ranking shows the countries with the highest percentage of fully vaccinated people at the top and the countries with the lowest percentage at the bottom.
--iso_code	country	continent	percentage fully vaccinated	ranking
--MUS	Mauritius	Africa	83.74%	1
--SYC	Seychelles	Africa	78.00%	2
--RWA	Rwanda	Africa	75.49%	3
--LBR	Liberia	Africa	70.36%	4
--SHN	Saint Helena	Africa	65.38%	5
--MOZ	Mozambique	Africa	64.70%	6
--BWA	Botswana	Africa	63.24%	7


-- 6
-- The Pareto principle, known as the "80-20" rule, says that 20% of the population owns 80% of the wealth. 
-- We are going to investigate whether 80% of the wealth is in 20% of the countries worldwide.
-- Make the overview below to easily check this.
-- wealth_land = population * gdp_per_capita / 1000000 ( /1000000 serves to not make the numbers too large, this does not change the overview)
-- Only those countries whose population is not NULL and the gdp_per_capita is not NULL are included in the overview
-- Note that the countries are sorted in descending order by wealth_land

--country	rijkdom_land	nummer_land	totaal_aantal_landen	cumulatieve_som_rijkdom	totale_rijkdom_wereldwijd	percentage_landen	percentage_rijkdom
--China	2,18285E+07	1	236	21828498	113458210,253098	0.42%	19.24%
--United States	1,834392E+07	2	236	40172416	113458210,253098	0.85%	35.41%
--India	9107710	3	236	49280126	113458210,253098	1.27%	43.43%
--Japan	4834392	4	236	54114517,5	113458210,253098	1.69%	47.70%
--Germany	3770755	5	236	57885272,5	113458210,253098	2.12%	51.02%
--Russia	3583963	6	236	61469235,5	113458210,253098	2.54%	54.18%
--Indonesia	3082514	7	236	64551749,5	113458210,253098	2.97%	56.89%
--Brazil	3036664	8	236	67588413,25	113458210,253098	3.39%	59.57%
--United Kingdom	2683699	9	236	70272112,5	113458210,253098	3.81%	61.94%
--France	2617966	10	236	72890078,75	113458210,253098	4.24%	64.24%
--Mexico	2210471	11	236	75100549,75	113458210,253098	4.66%	66.19%
--Turkey	2144570	12	236	77245119,25	113458210,253098	5.08%	68.08%



-- 7
-- Rank all countries showing from what date in a country 0.1% of the population has already received a booster shot.
-- A ranking is made per continent and for the whole world
-- Sort ascending by date
-- Where is Belgium in Europe and in the world?
--iso_code	country	continent	report_date	ranking_continent	ranking_world
--PRT	Portugal	Europe	2021-02-12 00:00:00.000	1	1
--EST	Estonia	Europe	2021-02-26 00:00:00.000	2	2
--FRA	France	Europe	2021-06-15 00:00:00.000	3	3
--TUR	Turkey	Asia	2021-06-30 00:00:00.000	1	4
--DOM	Dominican Republic	North America	2021-07-05 00:00:00.000	1	5
--ARE	United Arab Emirates	Asia	2021-07-15 00:00:00.000	2	6
--ISR	Israel	Asia	2021-07-31 00:00:00.000	3	7
--THA	Thailand	Asia	2021-08-05 00:00:00.000	4	8
--URY	Uruguay	South America	2021-08-06 00:00:00.000	1	9
--KHM	Cambodia	Asia	2021-08-09 00:00:00.000	5	10

