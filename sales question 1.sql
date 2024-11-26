
--Monthly wise sales trend over the stores, location for both year(2022 & 2023)

SELECT 
    YEAR(Date) AS Year,                      
    datename(month, s.date) AS MonthName,    
    MONTH(Date) AS MonthNumber,              
    Store_Name,                              
    store_location,                                
    SUM(Units * product_price) AS TotalRevenue,     
    SUM(Units) AS TotalUnits                
FROM Sales S
JOIN Stores St
    ON S.Store_ID = St.Store_ID                
JOIN Products P
    ON S.Product_ID = P.Product_ID             
GROUP BY 
    YEAR(Date), 
    MONTH(Date),
    datename(month, s.date),
    Store_Name,
    store_location
ORDER BY 
    Year, 
    MonthNumber, 
    store_location,
	TotalRevenue desc,
    Store_Name;
