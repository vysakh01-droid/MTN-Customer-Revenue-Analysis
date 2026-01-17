select * from mtn limit 1

--1.What is the total revenue generated?
SELECT SUM("Total Revenue") AS total_revenue
FROM mtn;

--2.What is the average revenue per customer?
SELECT 
    ROUND(AVG("Total Revenue"), 2) AS avg_revenue_per_customer
FROM mtn;

--3.Revenue by Subscription Plan?
SELECT 
    "Subscription Plan",
    SUM("Total Revenue") AS total_revenue
FROM mtn
GROUP BY "Subscription Plan"
ORDER BY total_revenue DESC;

--4.Which state generates the highest revenue?
SELECT 
    "State",
    SUM("Total Revenue") AS total_revenue
FROM mtn
GROUP BY "State"
ORDER BY total_revenue DESC
LIMIT 5;

--5.What is the customer churn rate (%)?
SELECT 
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE "Customer Churn Status" = 'Churned') 
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM mtn;

--6.Revenue comparison: Churned vs Active customers
SELECT 
    "Customer Churn Status",
    SUM("Total Revenue") AS total_revenue
FROM mtn
GROUP BY "Customer Churn Status";

--7.Average customer tenure by churn status
SELECT 
    "Customer Churn Status",
    ROUND(AVG("Customer Tenure in months"), 1) AS avg_tenure_months
FROM mtn
GROUP BY "Customer Churn Status";

--8.Which subscription plans have highest churn?
SELECT 
    "Subscription Plan",
    COUNT(*) FILTER (WHERE "Customer Churn Status" = 'Churned') AS churned_customers
FROM mtn
GROUP BY "Subscription Plan"
ORDER BY churned_customers DESC

--9.Top 10 high-value customers by revenue?
SELECT 
    "Customer ID",
    "Full Name",
    "Total Revenue"
FROM mtn
ORDER BY "Total Revenue" DESC
LIMIT 10;

--10.Average data usage by subscription plan?
SELECT 
    "Customer Churn Status",
    ROUND(AVG("Satisfaction Rate"), 1) AS avg_satisfaction
FROM mtn
GROUP BY "Customer Churn Status";

--11.Customers with high usage but low satisfaction
SELECT 
    "Customer ID",
    "Full Name",
    "Data Usage",
    "Satisfaction Rate"
FROM mtn
WHERE "Data Usage" > (
    SELECT AVG("Data Usage") FROM mtn
)
AND "Satisfaction Rate" < 3;

--12.Monthly purchase behavior?
SELECT 
    "Subscription Plan",
    ROUND(AVG("Number of Times Purchased"), 1) AS avg_purchases
FROM mtn
GROUP BY "Subscription Plan";

--13.Revenue per state per customer?
SELECT 
    "State",
    ROUND(SUM("Total Revenue") / COUNT(DISTINCT "Customer ID"), 2) AS revenue_per_customer
FROM mtn
GROUP BY "State"
ORDER BY revenue_per_customer DESC;

