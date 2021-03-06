SELECT * 
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT * 
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--SELECT Data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--Looking at Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract Covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%United Kingdom%'
ORDER BY 1,2

--Looking at the Total Cases vs the Population (Country)
--Shows what percentage of the population got Covid
SELECT location, date, population,total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location like '%United Kingdom%'
ORDER BY 1,2

--Show the Total Cases vs the population (Worldwide)
SELECT location, date, population,total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location like '%World%'
ORDER BY 1,2

--Which Countries have the Highest Infection rates compared to the Population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--Showing COUNTRIES with Highest Death Count per Population
--CAST to change data type to INT
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


--Showing CONTINENTS with Highest Death Count per Population
--CAST to change data type to INT
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


--Global Numbers
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as INT)) AS total_deaths, 
SUM(cast(new_deaths AS INT)) /SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
order by 1,2



--Creating View to store data for later visualizations
Create View test1 AS
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
GROUP BY location, population




--Queries to be used in Tableau 

--1.
--Total Death Percentage
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as INT)) AS total_deaths, 
SUM(cast(new_deaths AS INT)) /SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
order by 1,2


--2.
SELECT location, SUM(cast(new_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
AND location NOT IN ('World','European Union', 'International')
GROUP BY location
ORDER BY TotalDeathCount DESC

--3.
--Which Countries have the Highest Infection rates compared to the Population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--4.
SELECT location, population, date, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%states%'
GROUP BY location, population, date
ORDER BY PercentPopulationInfected DESC