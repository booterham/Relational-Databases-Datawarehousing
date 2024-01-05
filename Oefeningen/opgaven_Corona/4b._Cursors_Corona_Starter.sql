-- Exercise 1
-- Create the following overview. First give the SQL statement, then use a cursor to get the following layout
/*
Africa
 - Number of countries =         57
 - Total population = 1,426,160,609
Asia
 - Number of countries =         50
 - Total population = 4,721,455,390
Europe
 - Number of countries =         50
 - Total population = 745,629,155
North America
 - Number of countries =         41
 - Total population = 600,323,657
Oceania
 - Number of countries =         24
 - Total population = 45,038,907
South America
 - Number of countries =         14
 - Total population = 436,816,679
*/



-- Exercise 2: Give per continent a list with the 5 countries with the highest number of deaths
-- Step 1: Give a list of all continents. First give the SQL statement, then use a cursor to get the following layout
-- - Africa
-- - Asia
-- - Europe
-- - North America
-- - Oceania
-- - South America

-- Step 2: Give the countries with the highest number of deaths for Africa. First give the SQL statement, then use a cursor to get the following layout
--South Africa     102595
--Tunisia      29423
--Egypt      24830
--Morocco      16297
--Ethiopia       7574

-- Step 3: Combine both cursors to get the following result
/*
- Africa
South Africa     102595
Tunisia      29423
Egypt      24830
Morocco      16297
Ethiopia       7574
 - Asia
India     532027
Indonesia     161918
Iran     146336
China     120896
Turkey     101419
 - Europe
Russia     399999
United Kingdom     229089
Italy     191370
Germany     174979
France     167985
 - North America
United States    1129589
Mexico     334506
Canada      53478
Guatemala      20238
Honduras      11129
 - Oceania
Australia      22887
New Zealand       3294
Fiji        885
Papua New Guinea        679
French Polynesia        649
 - South America
Brazil     704659
Peru     221674
Colombia     142942
Argentina     130472
Chile      65125
*/

-- Step 4: Replace the TOP 5 values by a cte with dense_rank



-- Step 1

-- Step 2

-- Step 3


-- Step 4




-- Exercise 3
-- Make the following, visual overview for the total number of new_cases / 5000 for Belgium for each week starting from 2021-01-01
-- This makes it more clear which are the weeks with a lot of new_cases
-- Use the function REPLICATE to get the x's




/*
	  2021  1 
      2021  2 xx
      2021  3 xx
      2021  4 xx
      2021  5 xxx
      2021  6 xxx
      2021  7 xx
      2021  8 xx
      2021  9 xxx
      2021 10 xxx
      2021 11 xxx
      2021 12 xxxxx
      2021 13 xxxxxx
      2021 14 xxxxxx
      2021 15 xxxxx
      2021 16 xxxx
      2021 17 xxxxx
      2021 18 xxxx
      2021 19 xxxx
      2021 20 xxx
      2021 21 xxx
      2021 22 xx
      2021 23 xx
      2021 24 x
      2021 25 
      2021 26 
      2021 27 
      2021 28 x
      2021 29 x
      2021 30 xx
      2021 31 xx
      2021 32 xx
      2021 33 xx
      2021 34 xx
      2021 35 xx
      2021 36 xx
      2021 37 xx
      2021 38 xx
      2021 39 xx
      2021 40 xx
      2021 41 xx
      2021 42 xxx
      2021 43 xxxxxx
      2021 44 xxxxxxxxxx
      2021 45 xxxxxxxxxx
      2021 46 xxxxxxxxxxxxx
      2021 47 xxxxxxxxxxxxxxxxxxxx
      2021 48 xxxxxxxxxxxxxxxxxxxxxxxx
      2021 49 xxxxxxxxxxxxxxxxxxxxxxxx
      2021 50 xxxxxxxxxxxxxxxxxxx
      2021 51 xxxxxxxxxxxxx
      2021 52 xxxxxxxxx
      2021 53 xxxxxxxxxxx
      2022  1 xxx
      2022  2 xxxxxxxxxxxxxxxxxxxxxxxxxx
      2022  3 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      2022  4 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      2022  5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      2022  6 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      2022  7 xxxxxxxxxxxxxxxxxxxxxxxx
      2022  8 xxxxxxxxxxxxxx
      2022  9 xxxxxxxxx
      2022 10 xxxxxxxx
      2022 11 xxxxxxxxxx
      2022 12 xxxxxxxxxxxxx
      2022 13 xxxxxxxxxxxxxxx
      2022 14 xxxxxxxxxxxxxxx
      2022 15 xxxxxxxxxxxx
      2022 16 xxxxxxxxxxx
      2022 17 xxxxxxxx
      2022 18 xxxxxxx
      2022 19 xxxxxx
      2022 20 xxxxx
      2022 21 xxx
      2022 22 x
      2022 23 xx
      2022 24 xx
      2022 25 xxx
      2022 26 xxxxx
      2022 27 xxxxxxx
      2022 28 xxxxxxxxxx
      2022 29 xxxxxxxxxx
      2022 30 xxxxxx
      2022 31 xxxxxx
      2022 32 xxxx
      2022 33 xxx
      2022 34 xx
      2022 35 xx
      2022 36 xx
      2022 37 xx
      2022 38 xx
      2022 39 xxx
      2022 40 xxx
      2022 41 xxxx
      2022 42 xxx
      2022 43 xx
      2022 44 x
      2022 45 
      2022 46 x
      2022 47 
      2022 48 x
      2022 49 x
      2022 50 x
      2022 51 xx
      2022 52 x
      2022 53 x
      2023  1 
      2023  2 
      2023  3 
      2023  4 
      2023  5 
      2023  6 x
      2023  7 x
      2023  8 x
      2023  9 xx
      2023 10 xx
      2023 11 xx
      2023 12 xx
      2023 13 x
      2023 14 x
      2023 15 
      2023 16 
      2023 17 
      2023 18 
      2023 19 
      2023 20 
      2023 21 
      2023 22 
      2023 23 
      2023 24 
      2023 25 
      2023 26 
      2023 27 
      2023 28 
      2023 29 
      2023 30 
      2023 31 
      2023 32 
      2023 33 
      2023 34 
      2023 35 
      2023 36 
      2023 37
*/



