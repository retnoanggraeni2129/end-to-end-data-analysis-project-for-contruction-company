-- -------------------------------------------
-- 1) Create View Employee Performance Summary
-- -------------------------------------------
CREATE VIEW employee_performance_summary AS
WITH attendance_summary AS (
    SELECT 
        ma.employee_id,
        ma.attendance_date, 
        SUM(ma.present_days) AS total_working_days,
        SUM(ma.absent_days + ma.sick_leave_days) AS total_absent_days
    FROM monthly_attendance ma
    GROUP BY ma.employee_id, ma.attendance_date
),
salary_summary AS (
    SELECT 
        sh.employee_id,
        ROUND(AVG(sh.salary_amount_million * 1000000), 2) AS avg_salary_million,
        MAX(sh.salary_effective_date) AS last_salary_update
    FROM salary_history sh
    GROUP BY sh.employee_id
),
project_summary AS (
    SELECT 
        pa.employee_id,
        COUNT(DISTINCT pa.project_id) AS total_projects_assigned_external
    FROM project_assignments pa
    GROUP BY pa.employee_id
),
internal_project AS (
	SELECT 
		ip.employee_id,
		COUNT(DISTINCT ip.internal_project_id) AS total_projects_assigned_internal
	FROM internal_projects ip  
	GROUP BY ip.employee_id
)
SELECT 
    e.employee_id,
    e.name,
    e.role,
    e.join_date,
    e.end_date,
    a.attendance_date,
    COALESCE(a.total_working_days, 0) AS total_working_days,
    COALESCE(a.total_absent_days, 0) AS total_absent_days,
    COALESCE(s.avg_salary_million, 0) AS avg_salary_million,
    s.last_salary_update,
    COALESCE(p.total_projects_assigned_external, 0) AS total_projects_assigned_external,
    COALESCE(ip.total_projects_assigned_internal, 0) AS total_projects_assigned_internal,
    (COALESCE(p.total_projects_assigned_external, 0) + COALESCE(ip.total_projects_assigned_internal, 0)) AS total_projects_assigned
FROM employees e
LEFT JOIN attendance_summary a ON e.employee_id = a.employee_id
LEFT JOIN salary_summary s ON e.employee_id = s.employee_id
LEFT JOIN project_summary p ON e.employee_id = p.employee_id
LEFT JOIN internal_project ip ON e.employee_id = ip.employee_id;