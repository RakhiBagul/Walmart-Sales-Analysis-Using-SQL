CREATE database walmartt;
use walmartt;


LOAD DATA LOCAL INFILE 'C:/Users/DELL/Downloads/WalmartData.csv'
INTO TABLE WalmartSales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from WalmartSales;


# Q.1--->
# Retrieve all columns for sales made in a specific branch (branch : A)
SELECT * 
FROM WalmartSales 
WHERE Branch = 'A';

# Q.2--->
# Find the total sales for each product line.

SELECT Product_line, SUM(Total) AS total_sales
FROM WalmartSales
GROUP BY Product_line;


# Q.3--->
# List all sales transactions where the payment method was 'Cash'.

SELECT * 
FROM WalmartSales 
WHERE Payment = 'Cash';

# Q.4--->
# Calculate the total gross income generated in each city.

SELECT City, SUM(gross_income) AS total_gross_income
FROM WalmartSales
GROUP BY City;

# Q.5---->
#  Find the average rating given by customers in each branch.

SELECT Branch, AVG(Rating) AS avg_rating
FROM WalmartSales
GROUP BY Branch;

# Q.6--->
# Determine the total quantity of each product line sold

SELECT Product_line, SUM(Quantity) AS total_quantity
FROM WalmartSales
GROUP BY Product_line;

# Q.7--->
#  List the top 5 products by unit price.

SELECT Product_line, Unit_price
FROM WalmartSales
ORDER BY Unit_price DESC
LIMIT 5;

# Q.8----->
# Find sales transactions with a gross margin percentage greater than 30%.

SELECT * 
FROM WalmartSales 
WHERE gross_margin_percentage > 30;


# Q.9---->
#  Retrieve sales transactions that occurred on weekends.

SELECT * 
FROM WalmartSales 
WHERE DAYOFWEEK(STR_TO_DATE(Date, '%d-%m-%Y')) IN (1, 7);

# Q.10------>
# Calculate the total sales and gross income for each month.

SELECT MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month, 
       SUM(Total) AS total_sales, 
       SUM(gross_income) AS total_gross_income
FROM WalmartSales
GROUP BY month;

# Q. 11------------>
#  Find the number of sales transactions that occurred after 6 PM.

SELECT COUNT(*) AS sales_after_6pm
FROM WalmartSales
WHERE TIME(Time) > '18:00:00';


# Q.12--------->
#  List the sales transactions that have a higher total than the average total of all transactions.

SELECT * 
FROM WalmartSales
WHERE Total > (SELECT AVG(Total) FROM WalmartSales);


# Q 13------------>
# Find customers who made more than 5 purchases in a single month.

SELECT Customer_type, MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month, 
       COUNT(*) AS total_purchases
FROM WalmartSales
GROUP BY Customer_type, month
HAVING total_purchases > 5;


# Q.14----------->
# Calculate the cumulative gross income for each branch by date.

SELECT Branch, Date, 
       SUM(gross_income) OVER (PARTITION BY Branch ORDER BY STR_TO_DATE(Date, '%d-%m-%Y')) AS cumulative_gross_income
FROM WalmartSales;


# Q 15-------------->
#  Find the total cogs for each customer type in each city.

SELECT City, Customer_type, SUM(cogs) AS total_cogs
FROM WalmartSales
GROUP BY City, Customer_type;


