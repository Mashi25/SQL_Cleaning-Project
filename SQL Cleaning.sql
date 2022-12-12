/*

Cleaning data in sql queries

*/

select *
From Portfolio_project.dbo.Nashville

--Standardize Date Format
select saledate , convert(date,saledate)
from Portfolio_project..Nashville

--populate property address data

select *
from Portfolio_project.dbo.Nashville
--where property is null
order by parcelid

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a.propertyaddress,b.propertyaddress)
from Portfolio_project.dbo.Nashville a
Join Portfolio_project.dbo.Nashville b
on a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
from
Portfolio_project.dbo.Nashville a
Join Portfolio_project.dbo.Nashville b
on a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

--Breaking out address into individual columns(address,city,state)

select Propertyaddress
from Portfolio_project.dbo.Nashville

select 
substring(propertyaddress,1, CHARINDEX(',', propertyaddress)-1) as address ,
substring(propertyaddress,CHARINDEX(',',propertyaddress)+1,len(propertyaddress)) as address
from Portfolio_project.dbo.Nashville

Alter table Nashville
add propertysplitaddress nvarchar(255);

update nashville
set propertysplitaddress = substring(propertyaddress, 1, charindex(',',propertyaddress) -1)

alter table nashville
add propertysplitcity nvarchar(255);

update nashville
set propertysplitcity = substring(propertyaddress,charindex(',',propertyaddress)+1 , len(propertyaddress))

select *
from Portfolio_project.dbo.Nashville

select owneraddress
from Portfolio_project.dbo.Nashville

select
parsename(Replace(Owneraddress,',','.'),3),
parsename(Replace(Owneraddress,',','.'),2),
parsename(Replace(Owneraddress,',','.'),1)

from Portfolio_project.dbo.Nashville

Alter table Nashville
add propertysplitaddres nvarchar(255);

update nashville
set propertysplitaddres = parsename(Replace(Owneraddress,',','.'),3)

alter table nashville
add propertysplitcity2 nvarchar(255);

update nashville
set propertysplitcity2 = parsename(Replace(Owneraddress,',','.'),2)

alter table nashville
add propertysplitstate nvarchar(255);

update nashville
set propertysplitstate = parsename(Replace(Owneraddress,',','.'),2)

select*
from Nashville


--Changr Y and No to YES and NO
 select distinct(soldasvacant), count(soldasvacant)
 from Portfolio_project.dbo.Nashville
 Group by SoldAsVacant
 order by SoldAsVacant

 select soldasvacant,
 case when soldasvacant = 'Y' THEN 'YES'
 when soldasvacant = 'N' THEN 'NO'
 else soldasvacant
 end
 from Portfolio_project.dbo.Nashville

 with Rownumcte as(
 -- Remove duplicates
 -- use CTE AND  WINDOW function
 select *,
 row_number() over (
 partition by 
 parcelID,
 propertyaddress,
 saleprice,
 saledate,
 legalreference
 order by
 uniqueID) row_num 
 from Portfolio_project.dbo.Nashville
)
 DELETE
 from Rownumcte
 where row_num >1
 --der by Propertyaddress

 Select *
 from Portfolio_project.dbo.Nashville

 --deleting unused columns

 
 Select *
 from Portfolio_project.dbo.Nashville


alter table Portfolio_project.dbo.Nashville
drop column owneraddress, taxdistrict, propertyaddress

alter table Portfolio_project.dbo.Nashville
drop column saledate
  
select *
from Portfolio_project.dbo.Nashville
