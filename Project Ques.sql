
-- My Analysis & Findings
SELECT * FROM retail_sales;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    date_format(sale_date, '%Y-%M') = '2022-11'
    AND
    quantity >= 4;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT Category, SUM(Total_sale) as Total_Sales
FROM retail_sales
Group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT Category, ROUND(AVG(age),2) as Cust_age
FROM retail_sales
WHERE Category='Beauty'
Group by Category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT Category,gender, count(transaction_id) as Total_trans
FROM retail_sales
Group by Category,gender
order by Category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT Year, Month, Avg_Sale from 
	(SELECT extract(Year from Sale_date) as Year, extract(Month from Sale_date) as Month, ROUND(AVG(total_sale),2) as Avg_Sale,
RANK() OVER(partition by extract(Year from Sale_date) ORDER BY AVG(total_sale) DESC) as x FROM retail_sales
Group by Year, Month) as T1
WHERE x= 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT Customer_id, SUM(Total_sale) as Total_sales
FROM Retail_sales
GROUP BY Customer_id
ORDER BY Total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT Category, COUNT(DISTINCT customer_id) as Unique_cust
FROM retail_sales
GROUP BY Category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS
(SELECT *, 
	CASE 
		WHEN EXTRACT(Hour from Sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(Hour from Sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
    END as Shift
FROM retail_sales
)
SELECT Shift, Count(*) as Total_Orders
FROM hourly_sale
Group by Shift;
