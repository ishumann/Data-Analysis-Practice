/*

Cleaning Data in SQL Queries

*/

Select *
from PortfolioProject..NashvilleHousing




--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDate
from PortfolioProject..NashvilleHousing


-- Method 1: this is not updating the colum..same thing happend with alex 
update NashvilleHousing
SET SaleDate =  Convert(date, SaleDate)


-- Method 2: 

ALTER table NashvilleHousing
ADD SaleDateConv date


update NashvilleHousing
SET SaleDateConv =  Convert(date, SaleDate)



Select SaleDate, SaleDateConv
from PortfolioProject..NashvilleHousing

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
from PortfolioProject..NashvilleHousing
where PropertyAddress is Null
--order by ParcelID

/* logic: populate null PropertyAddress 
with same parcelid's PropertyAddress
must do..self join
*/

select house1.ParcelID,
house1.PropertyAddress, 
house2.ParcelID, 
house2.PropertyAddress, 
isnull(house1.PropertyAddress,house2.PropertyAddress)
from NashvilleHousing house1
join NashvilleHousing house2
on house1.ParcelID = house2.ParcelID
and house1.[UniqueID] <> house2.[UniqueID]
where house1.PropertyAddress is null



update house1
set PropertyAddress = isnull(house1.PropertyAddress,house2.PropertyAddress)
from NashvilleHousing house1
join NashvilleHousing house2
on house1.ParcelID = house2.ParcelID
and house1.[UniqueID] <> house2.[UniqueID]
where house1.PropertyAddress is null


--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
from PortfolioProject..NashvilleHousing
--where PropertyAddress is Null
--order by ParcelID

select
substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1) as Address,
substring(PropertyAddress, charindex(',', PropertyAddress)+1, Len(PropertyAddress)) as Address2
from NashvilleHousing


ALTER TABLE NashvilleHousing 
DROP COLUMN PropertyAddressHouseNo,PropertyAddressCityName;

ALTER table NashvilleHousing
ADD PropertyAddressHouseNo nvarchar(255),
PropertyAddressCityName nvarchar(255)


update NashvilleHousing
SET PropertyAddressHouseNo = substring(PropertyAddress, 1, charindex(',', PropertyAddress) -1),
PropertyAddressCityName = substring(PropertyAddress, charindex(',', PropertyAddress)+1, Len(PropertyAddress))

Select PropertyAddressHouseNo, PropertyAddressCityName
from PortfolioProject..NashvilleHousing

/* Spliting OwnersAdress as well with 
parsename(only works with period. so replace with ,)
parsename does return things backword. so at 1, you will last split.
*/
Select OwnerAddress,
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)

from PortfolioProject.dbo.NashvilleHousing



ALTER table NashvilleHousing
ADD OwnerAddressHouseNo nvarchar(255),
OwnerAddressCity nvarchar(255),
OwnerAddressState nvarchar(255)


update NashvilleHousing
SET OwnerAddressHouseNo = PARSENAME(Replace(OwnerAddress,',','.'),3),
OwnerAddressCity = PARSENAME(Replace(OwnerAddress,',','.'),2),
OwnerAddressState = PARSENAME(Replace(OwnerAddress,',','.'),1)


Select OwnerAddressHouseNo, OwnerAddressCity, OwnerAddressState
from PortfolioProject..NashvilleHousing


--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), count(SoldAsVacant)
from PortfolioProject..NashvilleHousing
group by SoldAsVacant

/*
doing with Case statment
*/

Select SoldAsVacant, 
CASE 
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end
from PortfolioProject..NashvilleHousing


update NashvilleHousing
SET SoldAsVacant =
CASE 
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
else SoldAsVacant
end

Select Distinct(SoldAsVacant), count(SoldAsVacant)
 group by SoldAsVacant
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates
With ROWNumCTE
select *, 
ROW_NUMBER() OVER (PARTITION BY 
ParcelID, 
PropertyAddress, 
SalePrice, 
SaleDate,
LegalReference
ORDER BY
	UniqueID
) row_number
from PortfolioProject..NashvilleHousing
order by  ParcelID
--where row_num > 1


--select * from NashvilleHousing

select *, 
		ROW_NUMBER() OVER (
		PARTITION BY 
		ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate,
		LegalReference
		ORDER BY
			UniqueID
		) as row_number
from PortfolioProject..NashvilleHousing
order by  ParcelID
-- where row_num >1 
/*
where wont work, that in a windows funtion

The WHERE clause in SQL is evaluated before the SELECT 
clause and thus before aliasing happens.
This means that the row_number alias you define in SELECT is not yet available 
when the WHERE clause is being processed.

Breakdown of Query Execution Order in SQL
FROM → The dataset is retrieved.

WHERE → Filtering happens before column selection.

GROUP BY → Grouping occurs (if applicable).

HAVING → Filtering based on aggregated values.

SELECT → Columns (including computed values like ROW_NUMBER()) are selected.

ORDER BY → Sorting happens at the end.

Since row_number is created in the SELECT step, 
it does not exist when the WHERE clause is executed.

Why WITH CTE AS (...) Works?
Using a Common Table Expression (CTE) or a subquery 
allows SQL to:

First compute row_number.

Then use row_number in the WHERE clause in the outer query.
*/



with RowNumCTE AS(
select *, 
		ROW_NUMBER() OVER (
		PARTITION BY 
		ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate,
		LegalReference
		ORDER BY
			UniqueID
		) as row_number
from PortfolioProject..NashvilleHousing
--order by  ParcelID
)
Select *
from RowNumCTE
where row_number > 1
order by PropertyAddress

-- Now deleting duplicates. Caution... 
--dont delate data until someone explicitly say so
-- make table view or store procesure, here just demo


with RowNumCTE AS(
select *, 
		ROW_NUMBER() OVER (
		PARTITION BY 
		ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate,
		LegalReference
		ORDER BY
			UniqueID
		) as row_number
from PortfolioProject..NashvilleHousing
--order by  ParcelID
)
delete
from RowNumCTE
where row_number > 1
---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns(dont delete raw data)
select *
From PortfolioProject..NashvilleHousing


ALter Table PortfolioProject..NashvilleHousing
drop column PropertyAddress, TaxDistrict, OwnerAddress

ALter Table PortfolioProject..NashvilleHousing
drop column SaleDate






-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------