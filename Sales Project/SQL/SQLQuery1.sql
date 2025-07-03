SELECT * FROM Customers
SELECT * FROM Location
SELECT * FROM Orders
SELECT * FROM Products

-- Total Sales
SELECT 
	ROUND(SUM(Sales),0) AS Total_Sales
FROM Orders

-- Total Profit
SELECT
	ROUND(SUM(profit),0) AS Total_Profit
FROM Orders

-- Average Quantity for each order
SELECT
	AVG(quantity) As Avg_Quantity
FROM Orders;

-- Average Discount
SELECT 
    CONCAT(ROUND(AVG(discount) * 100, 1), '%') AS Average_Discount
FROM Orders;

-- Count of Orders for each ship mode
SELECT
	ship_mode,
	COUNT(ship_mode) AS Order_Count
FROM Orders
GROUP BY ship_mode
ORDER BY Order_Count DESC;

-- Average shipping date days
SELECT
	CONCAT(AVG(DATEDIFF(DAY ,order_date, ship_date)),' Days') AS Avg_Shipping_Date
FROM Orders

-- Count of Orders for each segment type
SELECT
	segment,
	COUNT(segment) AS Order_Count
FROM Orders
GROUP BY segment
ORDER BY Order_Count DESC;

-- Count of Orders for each Year
SELECT
	YEAR(order_date) AS Order_Date,
	COUNT(order_date) AS Order_Count
FROM Orders
GROUP BY YEAR(order_date)
ORDER BY Order_Date DESC;

-- Count of Orders for each Month
SELECT
	DATENAME(MONTH,order_date) AS Order_Date,
	COUNT(order_date) AS Order_Count
FROM Orders
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Order_Count DESC;

-- Count of Orders for each Quarter
SELECT
	DATEPART(QUARTER,order_date) AS Order_Date,
	COUNT(order_date) AS Order_Count
FROM Orders
GROUP BY DATEPART(QUARTER,order_date)
ORDER BY Order_Count DESC;

-- Count of Products for each category
SELECT
	category,
	COUNT(category) AS Product_Counts
FROM Products
GROUP BY category

-- Count of Sub Category for each category
SELECT
    category,
    COUNT(DISTINCT sub_category) AS Sub_Category_Counts
FROM Products
GROUP BY category;

-- Total Sales and total Profit for each Category
SELECT
	p.category,
    ROUND(SUM(o.sales),0) AS Category_Sales,
	ROUND(SUM(o.profit),0) AS Category_Profit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY Category_Profit DESC;

-- Top 10 Sold Products
SELECT TOP 10
    p.product_name,
    p.category,
    ROUND(SUM(o.sales), 0) AS Product_Sales
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name, p.category
ORDER BY Product_Sales DESC;

-- State count for each region
SELECT
	region,
	COUNT(DISTINCT state) AS State_Count
FROM Location
GROUP BY region
ORDER BY State_Count DESC;

-- City count for each State
SELECT
	state,
	COUNT(DISTINCT city) AS City_Count
FROM Location
GROUP BY state
ORDER BY City_Count DESC;

-- Top 10 Statse by Sales
SELECT TOP 10
    region,
    state,
    ROUND(SUM(sales), 0) AS Total_Sales
FROM Location
JOIN Orders ON Location.postal_code = Orders.postal_code
GROUP BY region , state
ORDER BY Total_Sales DESC;

-- Top 10 States by Customers Count
SELECT TOP 10
    region,
    state,
    COUNT(c.customer_id) AS Customer_Count
FROM Location l
JOIN Orders o ON l.postal_code = o.postal_code
JOIN Customers c ON c.customer_id = o.customer_id
GROUP BY state , region
ORDER BY Customer_Count DESC;

-- Top 10 Customers
SELECT TOP 10
    customer_name,
    ROUND(SUM(sales), 0) AS Total_Sales
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY customer_name
ORDER BY Total_Sales DESC;