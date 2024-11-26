
-- quarterly sales comparison

SELECT 
    YEAR(Date) AS Year,
    CONCAT('Q', DATEPART(QUARTER, Date)) AS Quarter, 
    SUM(Units * product_price) AS TotalRevenue,          
    SUM(Units) AS TotalUnits                        
FROM Sales S
JOIN Products P
    ON S.Product_ID = P.Product_ID                 
GROUP BY 
    YEAR(Date), 
    DATEPART(QUARTER, Date)
ORDER BY 
    Year, 
    Quarter;
