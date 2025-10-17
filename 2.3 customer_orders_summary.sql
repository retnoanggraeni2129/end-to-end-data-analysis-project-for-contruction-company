-- --------------------------------------
-- 2) Create View Customer Orders Summary
-- -------------------------------------- 
CREATE VIEW customer_orders_summary AS
SELECT
    c.customer_id,
    c.company_name,
    c.industry,
    po.item,
    COUNT(po.order_id) AS total_orders,
    ROUND(SUM(po.quantity * po.unit_price), 0) AS total_spending,
    MAX(po.order_date) AS last_order_date,
    po.status
FROM
    customers c
LEFT JOIN
    product_orders po ON c.customer_id = po.customer_id
WHERE po.item IS NOT NULL
GROUP BY
    c.customer_id, c.company_name, c.industry, po.item, po.status;