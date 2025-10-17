-- ----------------------------------------
-- 5) Create View Equipment Performance
-- ---------------------------------------- 
CREATE VIEW equipment_performance AS
SELECT
    e.equipment_id,
    e.name AS equipment_name,
    e.condition AS equipment_condition,
    e.purchase_date,
    e.last_maintenance,
    COUNT(DISTINCT pe.project_id) AS total_projects_used,
    COUNT(DISTINCT ip.internal_project_id) AS total_internal_projects_used,
    MIN(pe.assignment_date) AS first_used_date,
    MAX(p.end_date) AS last_project_date,
    ROUND(
        AVG(
            CASE 
                WHEN p.start_date IS NOT NULL AND p.end_date IS NOT NULL 
                THEN DATE_PART('day', age(p.end_date, p.start_date))
                ELSE NULL
            END
        )
    ) AS avg_usage_days_per_project,
    ROUND(
        CASE
            WHEN e.last_maintenance IS NOT NULL THEN
                DATE_PART('day', age(CURRENT_DATE, e.last_maintenance))
            ELSE NULL
        END
    ) AS days_since_last_maintenance
FROM
    equipment e
LEFT JOIN
    project_equipment pe ON e.equipment_id = pe.equipment_id
LEFT JOIN
    projects p ON pe.project_id = p.project_id
LEFT JOIN
    internal_projects ip ON e.equipment_id = ip.equipment_id
GROUP BY
    e.equipment_id, e.name, e.condition, e.purchase_date, e.last_maintenance;
