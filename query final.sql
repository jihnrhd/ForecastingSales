CREATE TABLE public.users(
	id INT,
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	email VARCHAR (50),
	age int,
	gender VARCHAR (10),
	state VARCHAR (50),
	street_address VARCHAR (50),
	postal_code VARCHAR (50),
	city VARCHAR (50),
	country VARCHAR (50),
	latitude FLOAT,
	longitude FLOAT,
	traffic_source VARCHAR (50),
	created_at TIMESTAMP
)
SELECT * FROM users

CREATE TABLE public.products(
	id INT,
	cost FLOAT,
	category text,
	name text,
	brand text,
	retail_price FLOAT,
	department text,
	sku text,
	distribution_center_id INT	
)
SELECT * FROM products

CREATE TABLE public.orders(
	order_id INT,
	user_id INT,
	status VARCHAR (50),
	gender VARCHAR (50),
	created_at TIMESTAMP,
	returned_at TIMESTAMP,
	shipped_at TIMESTAMP,
	delivered_at TIMESTAMP,
	num_of_item INT
)
SELECT * FROM orders

CREATE TABLE public.order_items(
	id INT,
	order_id INT,
	user_id INT,
	product_id INT,
	inventory_item_id INT,
	status VARCHAR (50),
	created_at TIMESTAMP,
	shipped_at TIMESTAMP,
	delivered_at TIMESTAMP,
	returned_at TIMESTAMP,
	sale_price FLOAT
)
SELECT * FROM order_items

CREATE TABLE public.inventory_items(
	id INT,
	product_id INT,
	created_at TIMESTAMP,
	sold_at TIMESTAMP,
	cost FLOAT,
	product_category TEXT,
	product_name TEXT,
	product_brand  TEXT,
	product_retail_price FLOAT,
	product_department VARCHAR (50),
	product_sku VARCHAR (50),
	product_distribution_center_id INT		
)
SELECT * FROM inventory_items

CREATE TABLE public.events(
	id INT,
	user_id INT,
	sequence_number INT,
	session_id  TEXT,
	created_at TIMESTAMP,
	ip_address  TEXT,
	city  TEXT,
	state  TEXT,
	postal_code TEXT,
	browser TEXT,
	traffic_source TEXT,
	uri TEXT,
	event_type TEXT	
)
SELECT * FROM events

CREATE TABLE public.employees(
	Fisrt_Name VARCHAR (50),
	Last_Name VARCHAR (50),
	Gender VARCHAR (10),
	Age FLOAT,
	Length_Service FLOAT,
	Absent_Hours FLOAT,
	distribution_centers_id INT
)
SELECT * FROM employees

CREATE TABLE public.distribution_centers(
	id INT,	
	name VARCHAR (50),	
	latitude FLOAT,	
	longitude FLOAT	
)
SELECT * FROM distribution_centers
SELECT distinct  
	order_items.status,
	count (order_items.order_id) as orderID,
	order_items.sale_price,
	order_items.created_at as order_date,
	products.brand, 
	products.category, 
	products.name as name_product,
	products.cost,
	products.distribution_center_id,
	orders.num_of_item,
	orders.gender,
	distribution_centers.name as name_area,
	distribution_centers.latitude,
	distribution_centers.longitude
from order_items 
left join products 
	on order_items.product_id = products.id
left join orders
	on order_items.product_id = orders.order_id
left join distribution_centers
	on products.distribution_center_id = distribution_centers.id
group by
	order_items.status,
	order_items.sale_price,
	order_items.created_at,
	products.brand, 
	products.category, 
	products.name,
	products.cost,
	products.distribution_center_id,
	orders.num_of_item,
	orders.gender,
	distribution_centers.name,
	distribution_centers.latitude,
	distribution_centers.longitude
order by status, count (order_items.order_id) desc

SELECT   
	order_items.status,
	order_items.order_id as orderID,
	order_items.sale_price,
	order_items.created_at as order_date,
	products.brand, 
	products.category, 
	products.name as name_product,
	products.cost,
	orders.num_of_item,
	orders.gender,
	distribution_centers.name as name_area,
	distribution_centers.latitude,
	distribution_centers.longitude
from order_items 
left join products 
	on order_items.product_id = products.id
left join orders
	on order_items.product_id = orders.order_id
left join distribution_centers
	on products.distribution_center_id = distribution_centers.id
where order_items.status='Complete'
group by
	order_items.status,
	order_items.order_id,
	order_items.sale_price,
	order_items.created_at,
	products.brand, 
	products.category, 
	products.name,
	products.cost,
	orders.num_of_item,
	orders.gender,
	distribution_centers.name,
	distribution_centers.latitude,
	distribution_centers.longitude