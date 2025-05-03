Select * from 
CovidDeaths
order by 3,4


--Select * from 
--CovidVaccination
--order by 3,4


Select country, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2



-- looking at total cases vs Total Deaths(perecentage/ratio)
-- show the likeyhood of you dying if you contract covid in your country

Select country, date, total_cases, total_deaths, population,
(total_deaths / NULLIF(total_cases, 0)*100) as percentage
From PortfolioProject..CovidDeaths
where country like '%state%'
order by 1,2


-- looking at total cases vs population (perecentage/ratio)
-- show the likeyhood of you contract covid in your country

Select country, MAX(total_cases) as highest, population,
(total_cases / NULLIF(population, 0)*100) as percentage
From PortfolioProject..CovidDeaths
--where country like '%india%'
order by 1,2


-- looking at Countries with Highest Infestion Rate compared to population
Select country, population, 
max(total_cases) as HighestInfectionCount,
max((total_cases/population))*100 as infectionPercentage
from PortfolioProject..CovidDeaths
group by country, population
order by infectionPercentage desc


-- showing Countries with Highest Death Count per Population

Select country, Population, 
Max(total_deaths) as HighestdeathsCount,
Max((total_deaths/population))*100 as deathpercent
From PortfolioP**************************/qwroject..CovidDeaths
group by country, population
order by 1,2


-- by COntinent

select country, MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where country IN ('Asia', 'North America', 'South America', 'Europe', 'Oceania', 'Africa', 'Eurasia')
group by country


-- global Numbers

select sum(total_deaths) as total_deaths,
sum(cast(new_deaths as int)) as total_new_deaths,
sum(cast(new_cases as int)) as total_new_cases,
sum(cast(new_deaths as int))/Sum(new_cases)*100 as new_death_cases_ratio
from PortfolioProject..CovidDeaths
where country IN ('Asia', 'North America', 'South America', 'Europe', 'Oceania', 'Africa', 'Eurasia')
--group by country


Select *
from PortfolioProject..CovidDeaths deaths
Join Portfolioproject..CovidVaccination vac
	on deaths.country = vac.country
	and deaths.date = vac.date


-- Looking at Total Population vs Vaccinations
Select vac.continent, dea.country, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccination vac
on dea.date = vac.date

Select vac.continent, dea.country, dea.date, dea.population, vac.new_vaccinations
from PortfolioProject..CovidDeaths dea
Join Portfolioproject..CovidVaccination vac
	on dea.country = vac.country
	and dea.date = vac.date
where vac.continent is not null and vac.new_vaccinations is not null 
order by 3,2,1



-- Rolling Count


Select vac.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint,vac.new_vaccinations)) over (partition by dea.country order by dea.country, dea.date) as rolling_vaccinations
--, ((rolling_vaccinations/population)*100) as vacc_pop_ratio
from PortfolioProject..CovidDeaths dea
Join Portfolioproject..CovidVaccination vac
	on dea.country = vac.country
	and dea.date = vac.date
where vac.continent is not null 
order by 2,3;

--SELECT country, date, COUNT(*)
--FROM PortfolioProject..CovidVaccination
--GROUP BY country, date
--HAVING COUNT(*) > 1;

--SELECT country, date, COUNT(*)
--FROM PortfolioProject..CovidDeaths
--GROUP BY country, date
--HAVING COUNT(*) > 1;




-- using CTE for finding rolling vaccination vs population ratio


with PopvsVac(Continent, country, date, population,new_vaccinations, rolling_vaccinations) 
as 
(Select vac.continent, dea.country, dea.date, dea.population, vac.new_vaccinations,
sum(convert(bigint,vac.new_vaccinations)) over (partition by dea.country order by dea.country, dea.date) as rolling_vaccinations
--, ((rolling_vaccinations/population)*100) as vacc_pop_ratio
from PortfolioProject..CovidDeaths dea
Join Portfolioproject..CovidVaccination vac
	on dea.country = vac.country
	and dea.date = vac.date
where vac.continent is not null 
) 
select *,(rolling_vaccinations/population)*100 as vacc_pop_ratio
from PopvsVac
order by 2,3

drop table #percentPopVac
--temp Table
Create Table #PercentPopVac (
Continent nvarchar(255),
country nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
rolling_vaccinations numeric,
)

Insert into #PercentPopVac
Select vac.Continent, 
dea.country, 
dea.date, 
dea.population, 
vac.new_vaccinations,
sum(convert(bigint,vac.new_vaccinations)) over (partition by dea.country order by dea.country, dea.date)
as rolling_vaccinations

from PortfolioProject..CovidDeaths dea
Join Portfolioproject..CovidVaccination vac
	on dea.country = vac.country
	and dea.date = vac.date
where vac.continent is not null 

select *,(rolling_vaccinations/population*100) as vacc_pop_ratio
from #PercentPopVac



-- Creating View to store data forz later Visualizations

Create View PercentPopulationVaccinated as
Select vac.Continent, 
dea.country, 
dea.date, 
dea.population, 
vac.new_vaccinations,
sum(convert(bigint,vac.new_vaccinations)) over (partition by dea.country order by dea.country, dea.date)
as rolling_vaccinations

from PortfolioProject..CovidDeaths dea
Join Portfolioproject..CovidVaccination vac
	on dea.country = vac.country
	and dea.date = vac.date
where vac.continent is not null 
--order by 2,3


select *
from PercentPopulationVaccinated


