use classicmodels;
-- Revenue analysis
SELECT 
    SUM(quantityOrdered * priceEach) AS totalRevenue
FROM 
    OrderDetails;
-- Top 5 Revenue Generating Customers**:
SELECT 
    c.customerNumber,
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) totalRevenue
FROM 
    customers c
JOIN 
    orders o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY    c.customerNumber,
    c.customerName
ORDER BY 
    totalRevenue DESC
LIMIT 5;
-- Top 5 Revenue Generating Products
 select  
   p.productCode,
    p.productName,
    SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode,
    p.productName
ORDER BY 
    totalRevenue DESC
LIMIT 5;
-- profit analysis

select * from orderdetails ;
select * from products;
SELECT 
    od.orderNumber,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS totalProfit,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) / SUM(od.priceEach * od.quantityOrdered) AS profitMargin
FROM 
    orderdetails od
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    od.orderNumber;
  --   Top 5 % Profit Margin Products:
  SELECT 
    p.productCode,
    p.productName,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) / SUM(od.priceEach * od.quantityOrdered) AS profitMargin
FROM 
    products p
JOIN 
    orderdetails od ON p.productCode = od.productCode
GROUP BY 
    p.productCode,
    p.productName
ORDER BY 
    profitMargin DESC
LIMIT 5;
-- Top 5 % Profit Margin Customers:
SELECT 
    c.customerNumber,
    c.customerName,
    SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) / SUM(od.priceEach * od.quantityOrdered) AS profitMargin
FROM 
    customers c
JOIN 
    orders o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails od ON o.orderNumber = od.orderNumber
JOIN 
    products p ON od.productCode = p.productCode
GROUP BY 
    c.customerNumber,
    c.customerName
ORDER BY 
    profitMargin DESC
LIMIT 5;
-- shipping delay analysis
SELECT 
    AVG(DATEDIFF(orderdate, shippeddate)) AS avgShippingDelay
FROM 
    orders;
-- avg delay by city ordered desc   
   SELECT 
    city,
    avg(DATEDIFF(shippedDate, orderDate)) AS avgDelayByCity
FROM 
    orders o join customers c on c.customerNumber=o.customerNumber
    group by city
    order by 2 desc;  
    
 -- Sale analysis
 select ordernumber,sum(priceEach*quantityordered) as totalsale
from orderdetails
group by ordernumber;

select productname,sum(priceEach*quantityordered) as total_sale from products p 
join orderdetails o on p.productcode=o.productcode group by productname order by  total_sale desc;



  