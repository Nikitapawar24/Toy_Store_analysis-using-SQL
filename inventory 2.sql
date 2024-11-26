--b. Analyze the Inventory turnover ratio as per the store wise along with avg_inventory 
--   in a comparative report 

WITH InventoryData AS (
    SELECT 
        I.Store_ID,
        St.Store_Name,
        P.Product_ID,
        AVG(I.Stock_On_Hand) AS Avg_Inventory  
    FROM Inventory I
    JOIN Stores St
        ON I.Store_ID = St.Store_ID           
    JOIN Products P
        ON I.Product_ID = P.Product_ID       
    GROUP BY 
        I.Store_ID, 
        St.Store_Name, 
        P.Product_ID
),
COGSData AS (
    SELECT 
        S.Store_ID,
        St.Store_Name,
        SUM(S.Units * P.Product_Cost) AS TotalCOGS 
    FROM Sales S
    JOIN Products P
        ON S.Product_ID = P.Product_ID         
    JOIN Stores St
        ON S.Store_ID = St.Store_ID           
    GROUP BY 
        S.Store_ID, 
        St.Store_Name
)
SELECT 
    COGS.Store_ID,
    COGS.Store_Name,
    COGS.TotalCOGS,
    AVG(Inv.Avg_Inventory) AS Avg_Inventory,               
    CASE 
        WHEN AVG(Inv.Avg_Inventory) = 0 THEN NULL         
        ELSE COGS.TotalCOGS / AVG(Inv.Avg_Inventory)       
    END AS InventoryTurnoverRatio
FROM COGSData COGS
JOIN InventoryData Inv
    ON COGS.Store_ID = Inv.Store_ID                       
GROUP BY 
    COGS.Store_ID, 
    COGS.Store_Name, 
    COGS.TotalCOGS
ORDER BY 
    InventoryTurnoverRatio DESC;                          
