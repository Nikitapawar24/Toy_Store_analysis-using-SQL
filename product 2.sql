
--Is there any seasonality between the last three half yearly sales counted with the 
--max(date) of sales.

WITH MaxDate AS (
    SELECT MAX(Date) AS MaxSalesDate FROM Sales
),
HalfYearlySales AS (
    SELECT 
        CASE 
            WHEN MONTH(S.Date) BETWEEN 1 AND 6 THEN 'H1'
            WHEN MONTH(S.Date) BETWEEN 7 AND 12 THEN 'H2'
        END AS HalfYear,
        YEAR(S.Date) AS SaleYear,
        SUM(S.Units * P.Product_Price) AS TotalRevenue
    FROM Sales S
    JOIN Products P
        ON S.Product_ID = P.Product_ID
    WHERE S.Date >= DATEADD(YEAR, -1, (SELECT MaxSalesDate FROM MaxDate))
    GROUP BY 
        CASE 
            WHEN MONTH(S.Date) BETWEEN 1 AND 6 THEN 'H1'
            WHEN MONTH(S.Date) BETWEEN 7 AND 12 THEN 'H2'
        END,
        YEAR(S.Date)
),
RankedHalfYears AS (
    SELECT 
        SaleYear,
        HalfYear,
        TotalRevenue,
        RANK() OVER (ORDER BY SaleYear DESC, HalfYear DESC) AS Rank
    FROM HalfYearlySales
)
SELECT 
    SaleYear,
    HalfYear,
    TotalRevenue
FROM RankedHalfYears
WHERE Rank <= 3
ORDER BY SaleYear DESC, HalfYear DESC;
