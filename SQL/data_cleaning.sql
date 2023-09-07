CREATE DATABASE bakery_sales;
USE bakery_sales;
SELECT * FROM bakery;
DESCRIBE bakery;

-- Change the data type of DateTime column to date
SET SQL_SAFE_UPDATES = 0;
UPDATE bakery 
SET DateTime = date(str_to_date(DateTime, '%Y-%m-%d %H:%i:%s'));
ALTER TABLE bakery 
MODIFY COLUMN DateTime DATE;

-- Measures
SELECT COUNT(DISTINCT TransactionNO) AS Total_Transactions,
		COUNT(Items) AS Total_Items_Sold,
        ROUND(COUNT(DISTINCT TransactionNo) / COUNT(DISTINCT DateTime), 0) AS Average_Transactions_Per_Day
FROM bakery;

-- Frequancy Occurances of Pairs of Items
SELECT a.Items AS Item_A, b.Items AS Item_B, COUNT(*) AS Frequancy
FROM bakery a
JOIN bakery b ON a.TransactionNo = b.TransactionNo AND a.Items < b.Items
GROUP BY a.Items, b.Items
ORDER BY Frequancy DESC;

-- Transactions Per Month
SELECT month(DateTime) Month_Number, monthname(DateTime) AS Month_Name, COUNT(DISTINCT TransactionNO) AS Total_Transactions
FROM bakery
GROUP BY Month_Name, month(DateTime)
ORDER BY month(DateTime);

-- Trnasactions Breakdown Across DayPart (Morning - Afternoon - Evening - Night)
SELECT DayPart, COUNT(DISTINCT TransactionNo) AS count
FROM bakery
GROUP BY DayPart
ORDER BY count DESC;

-- Trnasactions Breakdown Across DayType (WeekDay - WeekEnd)
SELECT DayType, COUNT(DISTINCT TransactionNo) AS count
FROM bakery
GROUP BY DayType
ORDER BY count DESC;




