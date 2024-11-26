

/*a.Find the sales trend over the different Stores and find the best and least five stores
    as per the performance in one query.*/

WITH RankedStores AS (
    SELECT 
        st.Store_ID,
        Store_Name,
        Store_Location,
        SUM(Units * Product_Price) AS TotalRevenue, 
        SUM(Units) AS TotalUnits,                   
        RANK() OVER (ORDER BY SUM(Units * Product_Price) DESC) AS RevenueRank, 
        RANK() OVER (ORDER BY SUM(Units * Product_Price) ASC) AS RevenueReverseRank            
    FROM Sales S
    JOIN Stores St
        ON S.Store_ID = St.Store_ID                  
    JOIN Products P
        ON S.Product_ID = P.Product_ID               
    GROUP BY 
        st.Store_ID,
        Store_Name,
        Store_Location
)
SELECT 
    CASE 
        WHEN RevenueRank <= 5 THEN 'Top 5 Stores'
        WHEN RevenueReverseRank <= 5 THEN 'Bottom 5 Stores'
        ELSE 'Other Stores'
    END AS StoreCategory,
    Store_ID,
    Store_Name,
    Store_Location,
    TotalRevenue,
    TotalUnits
FROM RankedStores
WHERE RevenueRank <= 5 OR RevenueReverseRank <= 5 
ORDER BY RevenueRank, RevenueReverseRank;





