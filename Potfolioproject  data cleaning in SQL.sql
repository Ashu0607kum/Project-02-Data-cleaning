
-----Cleaning data in SQL Queries------


 --Standardise Date Format



 Select SaledateConvert,convert(date,saledate)
 from Nashvillehousing;

 Alter Table Nashvillehousing
 Add SaledateConvert date;

 Update Nashvillehousing
 set SaledateConvert = CONVERT(date, saledate)


 --Populate Property Address data

 select *
 From Nashvillehousing
 WHERE PropertyAddress is null
 order by Parcelid


 select  a.parcelID, a.propertyaddress, b.parcelID, b.propertyaddress, ISNULL(a.propertyaddress,b.propertyaddress)
 From PortfolioProject.dbo.NashvilleHousing a
 JOIN PortfolioProject.dbo.NashvilleHousing b
   on a.parcelID= b.parcelID
   AND a.[UniqueID] <> b.[UniqueID]
    WHERE a.PropertyAddress is null

	update a
	set propertyaddress= ISNULL(a.propertyaddress,b.propertyaddress)
	From PortfolioProject.dbo.NashvilleHousing a
 JOIN PortfolioProject.dbo.NashvilleHousing b
   on a.parcelID= b.parcelID
   AND a.[UniqueID] <> b.[UniqueID]


   ---Breaking out Address into individual columms (Address,city, state)

   select propertyaddress
    From PortfolioProject.dbo.NashvilleHousing

	Select 
	SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress) -1) as Address
	,SUBSTRING(propertyaddress, charindex(',',propertyaddress)+1, len(propertyaddress)) as City
	From NashvilleHousing

ALTER TABLE NashvilleHousing
 ADD propertysplitaddres Nvarchar(250);

 Update NashvilleHousing
set propertysplitaddres = SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress) -1)

ALTER TABLE NashvilleHousing
 ADD propertyaddresscity Nvarchar(250);

 Update NashvilleHousing
set propertyaddress = SUBSTRING(propertyaddress, charindex(',',propertyaddress)+1, len(propertyaddress))

select *
from NashvilleHousing;




select ownerAddress
from PortfolioProject.dbo.Nashvillehouse;

select 
PARSENAME(REPLACE(Owneraddress, ',','.'), 3)
,PARSENAME(REPLACE(Owneraddress, ',','.'), 2)
,PARSENAME(REPLACE(Owneraddress, ',','.'), 1)
from PortfolioProject.dbo.Nashvillehousing;

ALTER TABLE NashvilleHousing
 ADD ownersplitaddress Nvarchar(255);

 Update NashvilleHousing
set ownersplitaddress = PARSENAME(REPLACE(Owneraddress, ',','.'), 3)

ALTER TABLE NashvilleHousing
 ADD ownersplitcity Nvarchar(255);

 Update NashvilleHousing
set ownersplitcity = PARSENAME(REPLACE(Owneraddress, ',','.'), 2)

ALTER TABLE NashvilleHousing
 ADD ownersplitstate Nvarchar(255);

 Update NashvilleHousing
set ownersplitstate = PARSENAME(REPLACE(Owneraddress, ',','.'), 1)



----Change Y and N to YES and NO in "SOLD as Vacant" Field--------

select distinct(soldASvacant) COUNT(Soldasvacant)
from PortfolioProject.dbo.Nashvillehousing
group by soldASvacant
order by 2;

select soldasvacant
case when soldasvacant ="Y" then YES
     when soldasvacant = "N" then NO
	 Else soldasvacant
	 End
	  From PortfolioProject.dbo.NashvilleHousing

update Nashvillehousing
set when soldasvacant ="Y" then YES
     when soldasvacant = "N" then NO
	 Else soldasvacant
	 End


	 -----Remove Dublicates----

WithRoundCTE AS(
select *,
ROW NUMBER() OVER(
Partition by parcelID,
           Propertyaddress,
		   SalePrice,
		   SaleDate,
		   LegalRefeence
		   oder by
		   UniqueID
		   ) Row_num
from portfolioproject.dboNashvilleHousing
--order by parcelID
)
Select *
from RoundCTE Where row_num > 1
order by Propertyaddress 

select *
from PortfolioProject.dbo.NashvilleHousing



---Delete Unused colunms----

select *
from PortfolioProject.dbo.NashvilleHousing

Alter table portfolioproject.dbo.Nashvillehousing
Drop column owneraddress,TaxDistrict,Propertyaddress

Alter table portfolioproject.dbo.Nashvillehousing
Drop column saledate












