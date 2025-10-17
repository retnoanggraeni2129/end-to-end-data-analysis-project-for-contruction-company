CREATE TABLE employees (
	employee_id		INT PRIMARY KEY,
	name			TEXT, 
	role			TEXT, 
	join_date		DATE, 
	end_date		DATE
 );

CREATE TABLE salary_history (
	employee_id		INT,
	salary_effective_date	VARCHAR,
	salary_amount_million	INT
);	

CREATE TABLE monthly_attendance (
    employee_id 	INT,
    attendance_date	VARCHAR(50),
    present_days 	INT,
    absent_days 	INT,
    sick_leave_days INT
);

CREATE TABLE projects (
	project_id			INT PRIMARY KEY, 
	project_name			TEXT, 
	customer_id			INT, 
	start_date			DATE, 
	end_date			DATE,
    budget_million			NUMERIC, 
    status				TEXT
);

CREATE TABLE project_assignments (
	project_id			INT, 
	employee_id			INT
);	

CREATE TABLE project_equipment (
	project_id			INT, 
	equipment_id			INT, 
	assignment_date			DATE
);

CREATE TABLE equipment (
	equipment_id			INT PRIMARY KEY, 
	name				TEXT, 
	purchase_date			DATE, 
	last_maintenance		DATE,
    condition				TEXT,
    supplier_id				INT
);

CREATE TABLE suppliers (
	supplier_id			INT PRIMARY KEY, 
	supplier_name			TEXT, 
	material_type			TEXT, 
	contact_number			TEXT,
    city				TEXT
);

CREATE TABLE customers (
	customer_id			INT PRIMARY KEY, 
	company_name			TEXT, 
	industry			TEXT, 
	contact_person			TEXT, 
	phone				TEXT
);

CREATE TABLE product_orders (
	order_id			INT PRIMARY KEY, 
	customer_id			INT, 
	supplier_id			INT, 
	order_date			DATE, 
	item				TEXT,
    quantity				NUMERIC, 
    unit_price				NUMERIC, 
    status				TEXT				
);

CREATE TABLE internal_projects (
	internal_project_id		INT PRIMARY KEY, 
	project_name			TEXT, 
	employee_id			INT, 
	equipment_id			INT,
    start_date				DATE, 
    end_date				DATE, 
    description				TEXT				
);