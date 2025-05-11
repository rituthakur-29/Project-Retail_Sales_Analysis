# Retail Sales Analysis SQL Project
## Project Overview
**Project Title:** Retail Sales Analysis
**Level:** Beginner
**Database:** SQL_project_p2

A hands-on SQL project focused on exploring, cleaning, and analyzing retail sales data. It includes database setup, EDA, and targeted business queries, making it ideal for beginners aiming to build practical SQL expertise.

## Objectives
  1. **Database Setup:** Build and populate a retail sales database using the provided data.
  2. **Data Cleaning:** Detect and eliminate records containing missing or null values.
  3. **Exploratory Data Analysis (EDA):** Conduct initial analysis to gain a deeper understanding of the dataset.
  4. **Business Insights:** Leverage SQL queries to address key business questions and extract meaningful insights from the sales data.

## Project Structure
### 1. **Database Setup**
  - Database Creation: Create the SQL_project_p2 database.
  - Table Creation: Build the retail_sales table with fields for transactions, customer details, and sales metrics.

```sql
CREATE DATABASE SQL_project_p2;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. **Data Exploration & Cleaning**
  - Count total records, unique customers, and product categories.
  - Identify and remove records with null values.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. **Data Analysis & Findings**
   
The following SQL queries were developed to address specific business questions and uncover key findings:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05.**
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.**
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    date_format(sale_date, '%Y-%M') = '2022-11'
    AND
    quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY year, month
) as t1
WHERE rank = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).**
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
```

## Findings
  - Customers represent diverse age groups, with major sales in Clothing and Beauty.
  - Premium purchases are evident with transactions exceeding 1000.
  - Monthly sales trends reveal seasonal peaks.
  - Top customers and best-selling categories were identified.


## Reports
  - **Sales Summary:** Total sales, customer demographics, and category performance.
  - **Trend Analysis:** Monthly and shift-wise sales patterns.
  - **Customer Insights:** Top customers and category-specific customer counts.


## Conclusion
This project blends database creation, data cleaning, EDA, and SQL-driven business insights - offering a strong foundation for real-world data analysis. It reveals how SQL can drive smarter decisions through sales trends, customer behaviors, and product insights.

## Author - Rituthakur-29
Part of my growing portfolio, this project showcases the SQL skills needed for data analyst positions. I'd love to hear your feedback or discuss any inquiries - feel free to reach out!

- Linkedln: [**Connect with me professionally**](www.linkedin.com/in/ritut)
Thank you for your support, and I look forward to connecting with you!
