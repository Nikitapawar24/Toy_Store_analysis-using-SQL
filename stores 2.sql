
--Which stores performs well than the last year  

WITH StoreYearlySales AS (
    SELECT 
        st.Store_ID,
        Store_Name,
        YEAR(Date) AS SaleYear,
        SUM(Units * Product_Price) AS TotalRevenue
    FROM Sales S
    JOIN Stores St
        ON S.Store_ID = St.Store_ID
    JOIN Products P
        ON S.Product_ID = P.Product_ID
    GROUP BY 
        St.Store_ID,
        Store_Name,
        YEAR(Date)
),
YearlyComparison AS (
    SELECT 
        S1.Store_ID,
        S1.Store_Name,
        S1.TotalRevenue AS Revenue2022,
        S2.TotalRevenue AS Revenue2023,
        CASE 
            WHEN S2.TotalRevenue > S1.TotalRevenue THEN 'Improved'
            WHEN S2.TotalRevenue = S1.TotalRevenue THEN 'Same'
            ELSE 'Declined'
        END AS Performance
    FROM StoreYearlySales S1
    LEFT JOIN StoreYearlySales S2
        ON S1.Store_ID = S2.Store_ID AND S1.SaleYear = 2022 AND S2.SaleYear = 2023
    WHERE S1.SaleYear = 2022
)
SELECT 
    Store_ID,
    Store_Name,
    Revenue2022,
    Revenue2023,
	(Revenue2023-Revenue2022) as increased_revenue ,
	Performance
FROM YearlyComparison
WHERE Performance = 'Improved'
ORDER BY increased_revenue DESC;
