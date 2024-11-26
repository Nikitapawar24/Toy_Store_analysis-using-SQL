
--High demanded product among all locations as per the sales.

WITH ProductSales AS (
    SELECT 
        P.Product_ID,
        P.Product_Name,
        SUM(S.Units) AS TotalUnitsSold,
        SUM(S.Units * P.Product_Price) AS TotalRevenue,
        COUNT(DISTINCT St.Store_Location) AS LocationsCovered
    FROM Sales S
    JOIN Products P
        ON S.Product_ID = P.Product_ID
    JOIN Stores St
        ON S.Store_ID = St.Store_ID
    GROUP BY 
        P.Product_ID, 
        P.Product_Name
)
SELECT 
    Product_ID,
    Product_Name,
    TotalUnitsSold,
    TotalRevenue,
    LocationsCovered
FROM ProductSales
ORDER BY 
    TotalUnitsSold DESC,
    TotalRevenue DESC;


