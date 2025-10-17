-- ----------------------------------------
-- 3) Create View Customer Project Activity
-- ----------------------------------------
CREATE VIEW customer_project_activity AS
SELECT
    c.customer_id,
    c.company_name, 
    p.project_name,
    COUNT(DISTINCT p.project_id) AS total_projects,
    ROUND(SUM(p.budget_million * 1000000), 0) AS average_project_budget,
    MAX(p.status) AS last_project_status,
    AVG(
        CAST(
            (COALESCE(p.end_date, CURRENT_DATE) - p.start_date) AS INT
        )
    ) AS average_project_duration_days,
    MAX(p.start_date) AS last_project_start_date,
    MAX(p.end_date) AS last_project_end_date
FROM
    customers c
LEFT JOIN
    projects p ON c.customer_id = p.customer_id
WHERE p.project_name IS NOT NULL
GROUP BY
    c.customer_id, c.company_name, p.project_name;