--Find out the report of Product that which product performs well and contributing most part of sales

WITH ProductSales AS (
    SELECT 
        P.Product_ID,
        P.Product_Name,
        SUM(S.Units * P.Product_Price) AS TotalRevenue, 
        SUM(S.Units) AS TotalUnits                    
    FROM Sales S
    JOIN Products P
        ON S.Product_ID = P.Product_ID                
    GROUP BY 
        P.Product_ID,
        P.Product_Name
)
SELECT 
    PS.Product_ID,
    PS.Product_Name,
    PS.TotalRevenue,
    PS.TotalUnits,
    (PS.TotalRevenue / (SELECT SUM(TotalRevenue) FROM ProductSales)) * 100 AS ContributionPercentage 
FROM ProductSales PS
ORDER BY PS.TotalRevenue DESC;
