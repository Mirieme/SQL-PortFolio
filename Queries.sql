-- Portfolio Project
-- Import Datewise likelihood of dying due to COVID- Totalcases vs TotalDeath in India
SELECT date, 
total_cases, 
total_deaths
FROM "CovidDeaths" 
WHERE location = 'India';

-- Import Total_deaths of india 
SELECT (max(total_deaths)/AVG(cast(population as integer)))*100
FROM "CovidDeaths"
WHERE location = 'India'; 


-- Modify type of population 
--ALTER TABLE "CovidDeaths" ALTER COLUMN population TYPE character varying USING (NULLIF(population, ''):: bigint)

-- Country with highest death as a % of population 
SELECT location, 
(max(total_deaths)/AVG(cast(population as bigint)))*100 as percentageofdeaths
FROM "CovidDeaths"
GROUP BY location
ORDER BY percentageofdeaths desc;

-- Import Total_cases of india 
SELECT (max(total_cases)/AVG(cast(population as integer)))*100 as total_cases_of_covid_in_india
FROM "CovidDeaths"
WHERE location like '%India%'; 

-- total cases in the whole world
SELECT location,
(max(total_cases)/AVG(cast(population as bigint)))*100 as percentageofcases
FROM "CovidDeaths"
GROUP BY location
ORDER BY percentageofcases desc;

-- Continent with the + total case
SELECT  location,
max(total_cases) as total_cases
FROM "CovidDeaths" where continent is null
GROUP BY location
order by total_cases;

-- Continent with the + total deaths
SELECT location, 
max(total_deaths) as total_deaths
FROM "CovidDeaths" where continent is null
GROUP BY location
order by total_deaths;

--  Daily new cases vs hospitalization vs icu_patients -india
SELECT  date, new_cases as daily_new_cases,
hosp_patients as hospitalizations,
icu_patients 
FROM "CovidDeaths"
where location like '%India%';

-- Country with age>65
SELECT location, aged_65_older
FROM "CovidVaccinations"
where continent is null 
Group by location ;

SELECT "CovidDeaths".location, "CovidVaccinations".aged_65_older 
FROM "CovidDeaths" 
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code  and "CovidDeaths".date = "CovidVaccinations".date;

-- Country with total vaccinated persons
SELECT "CovidDeaths".location as country,
max("CovidVaccinations".people_fully_vaccinated ) as fully_vaccinated
FROM "CovidDeaths"
JOIN "CovidVaccinations" ON "CovidDeaths".iso_code = "CovidVaccinations".iso_code  and "CovidDeaths".date = "CovidVaccinations".date
WHERE "CovidDeaths".continent IS null 
GROUP BY "CovidDeaths".location 
ORDER BY fully_vaccinated desc;


