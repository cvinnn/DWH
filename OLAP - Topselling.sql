CREATE VIEW Top5BestSellingProduct AS
    SELECT 
        `p`.`ItemID` AS `ItemID`,
        `p`.`Nama_Product` AS `Nama_Product`,
        `p`.`CategoryID` AS `CategoryID`,
        SUM(`td`.`qty`) AS `TotalQuantitySold`,
        SUM(`td`.`subtotal`) AS `TotalRevenue`
    FROM
        `subsift3_FurniCrafts`.`Product` `p`
        JOIN `subsift3_FurniCrafts`.`transaction_detail` `td` ON `p`.`ItemID` = `td`.`item`
    GROUP BY `p`.`ItemID`, `p`.`Nama_Product`, `p`.`CategoryID`
    ORDER BY `TotalQuantitySold` DESC
    LIMIT 5;
