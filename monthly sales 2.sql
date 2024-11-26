
-- monthly sales comparison

SELECT 
    YEAR(Date) AS Year,
    datename(month,date) AS MonthName,
    MONTH(Date) AS MonthNumber,          
    SUM(Units * product_Price) AS TotalRevenue, 
    SUM(Units) AS TotalUnits             
FROM Sales S
JOIN Products P
    ON S.Product_ID = P.Product_ID
GROUP BY 
    YEAR(Date), 
    MONTH(Date), 
    datename(month, date)
ORDER BY 
    MonthNumber, 
    Year;
