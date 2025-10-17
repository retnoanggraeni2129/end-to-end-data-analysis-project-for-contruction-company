-- ----------------------------------------
-- 4) Create View Supplier Risk Assessment
-- ----------------------------------------
CREATE VIEW supplier_risk_assessment AS
SELECT
    s.supplier_id,
    s.supplier_name,
    s.city,
    s.material_type,
    po.status,
    po.item,
    po.unit_price,
    po.quantity,
    CASE
        WHEN LOWER(po.item) = 'wood' THEN 'm³'
        WHEN LOWER(po.item) = 'bricks' THEN 'pcs'
        WHEN LOWER(po.item) = 'cement' THEN 'bag (50 kg)'
        WHEN LOWER(po.item) = 'cables' THEN 'm'
        WHEN LOWER(po.item) = 'nails' THEN 'kg'
        WHEN LOWER(po.item) = 'steel_bar' THEN 'm'
        WHEN LOWER(po.item) = 'paint' THEN 'L'
        WHEN LOWER(po.item) = 'pipes' THEN 'm'
        ELSE 'unknown unit'
    END AS unit_reference,
    SUM(po.quantity*po.unit_price) AS total_price
FROM
    suppliers s
LEFT JOIN
    product_orders po ON s.supplier_id = po.supplier_id
WHERE po.item is not null    
GROUP BY
    s.supplier_id, s.supplier_name, s.city, s.material_type, po.status, po.item, po.unit_price, po.quantity;
