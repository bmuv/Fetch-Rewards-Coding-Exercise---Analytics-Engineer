-- Which brand has the most spend among users who were created within the past 6 months?
WITH date_bounds AS (
    SELECT 
        MAX(GREATEST(date_scanned, purchase_date)) AS max_date,
        DATE_SUB(MAX(GREATEST(date_scanned, purchase_date)), INTERVAL 6 MONTH) AS six_months_ago
    FROM Fact_Receipts
)

SELECT 
    db.name AS brand_name,
    SUM(fr.total_spent) AS total_spend
FROM 
    Fact_Receipts fr
JOIN 
    Dim_Users du ON fr.user_id = du.user_id
JOIN 
    Dim_Items di ON fr.item_id = di.item_id
JOIN 
    Dim_Brands db ON di.item_barcode = db.barcode
JOIN 
    date_bounds
WHERE 
    du.created_date >= date_bounds.six_months_ago
    AND du.created_date <= date_bounds.max_date
    AND fr.purchase_date <= date_bounds.max_date
GROUP BY 
    db.brand_id, db.name
ORDER BY 
    total_spend DESC
LIMIT 1;



-- Which brand has the most transactions among users who were created within the past 6 months?
WITH date_bounds AS (
    SELECT 
        MAX(GREATEST(date_scanned, purchase_date)) AS max_date,
        DATE_SUB(MAX(GREATEST(date_scanned, purchase_date)), INTERVAL 6 MONTH) AS six_months_ago
    FROM Fact_Receipts
)

SELECT 
    db.name AS brand_name,
    COUNT(DISTINCT fr.receipt_id) AS transaction_count
FROM 
    Fact_Receipts fr
JOIN 
    Dim_Users du ON fr.user_id = du.user_id
JOIN 
    Dim_Items di ON fr.item_id = di.item_id
JOIN 
    Dim_Brands db ON di.item_barcode = db.barcode
JOIN 
    date_bounds
WHERE 
    du.created_date >= date_bounds.six_months_ago
    AND du.created_date <= date_bounds.max_date
    AND fr.purchase_date <= date_bounds.max_date
GROUP BY 
    db.brand_id, db.name
ORDER BY 
    transaction_count DESC
LIMIT 1;



-- Average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’
SELECT 
    CASE 
        WHEN AVG(CASE WHEN rewards_receipt_status = 'Finished' THEN total_spent END) >
             AVG(CASE WHEN rewards_receipt_status = 'Rejected' THEN total_spent END)
        THEN 'Finished'
        ELSE 'Rejected'
    END AS higher_average_status,
    AVG(CASE WHEN rewards_receipt_status = 'Finished' THEN total_spent END) AS avg_spend_accepted,
    AVG(CASE WHEN rewards_receipt_status = 'Rejected' THEN total_spent END) AS avg_spend_rejected
FROM 
    Fact_Receipts
WHERE 
    rewards_receipt_status IN ('Finished', 'Rejected');



-- Total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’
SELECT 
    CASE 
        WHEN SUM(CASE WHEN rewards_receipt_status = 'Finished' THEN quantity_purchased END) >
             SUM(CASE WHEN rewards_receipt_status = 'Rejected' THEN quantity_purchased END)
        THEN 'Finished'
        ELSE 'Rejected'
    END AS higher_quantity_status,
    SUM(CASE WHEN rewards_receipt_status = 'Finished' THEN quantity_purchased ELSE 0 END) AS total_items_accepted,
    SUM(CASE WHEN rewards_receipt_status = 'Rejected' THEN quantity_purchased ELSE 0 END) AS total_items_rejected
FROM 
    Fact_Receipts
WHERE 
    rewards_receipt_status IN ('Finished', 'Rejected');