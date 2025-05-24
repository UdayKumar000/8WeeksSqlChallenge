/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
SELECT SUM(m.price) from sales s join menu m ON s.product_id=m.product_id join members m ON m.customer.id=s.customer_id GROUP BY m.customer_id;
-- 2. How many days has each customer visited the restaurant?
SELECT COUNT(days) from (SELECT DISTINCT(order_date) days from sales) AS dorders; 
-- 3. What was the first item from the menu purchased by each customer?
SELECT MIN(order_date) from sales GROUP BY customer_id;
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT MAX(order_date),m.product_name from (SELECT COUNT(order_date),product_name from sales s JOIN menu m ON s.product_name=m.product_name GROUP BY product_id) ;
-- 5. Which item was the most popular for each customer?
SELECT customer_id ,product_id from (SELECT COUNT(order_date) as days ,customer_id,product_id from sales s JOIN members m ON s.customer_id=m.customer_id join menu t ON s.product_id = t.product_id GROUP BY (customer_id,product_id)) as setable where days = MAX(days);
-- 6. Which item was purchased first by the customer after they became a member?
SELECT customer_id,product_id as firstProduct FROM (SELECT order_date ,customer_id ,product_name,join_date FROM sales s JOIN members m ON s.customer_id=m.customer_id JOIN menu me ON s.product_id=me.product_id) as tbl where order_date >= join_date LIMIT 1;
-- 7. Which item was purchased just before the customer became a member?
SELECT customer_id,product_id as firstProduct FROM (SELECT order_date ,customer_id ,product_name,join_date FROM sales s JOIN members m ON s.customer_id=m.customer_id JOIN menu me ON s.product_id=me.product_id) as tbl where order_date < join_date LIMIT 1;
-- 8. What is the total items and amount spent for each member before they became a member?
SELECT customer_id,COUNT(product_id),SUM(price) as firstProduct FROM (SELECT order_date ,customer_id ,product_name,join_date,price FROM sales s JOIN members m ON s.customer_id=m.customer_id JOIN menu me ON s.product_id=me.product_id) as tbl where order_date < join_date GROUP BY customer_id;
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT cusomer_id , SUM(points) FROM (SELECT  price*2,customer_id as poins FROM (SELECT price*10,customer_id from (SELECT customer_id,product_name,price from FROM sales s JOIN members m ON s.customer_id=m.customer_id JOIN menu me ON s.product_id=me.product_id ) as tbl where product_name = "sushi" )as setbl where product_name ="sushi") as ttbl
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
 

-- Example Query:
SELECT
  	product_id,
    product_name,
    price
FROM dannys_diner.menu
ORDER BY price DESC
LIMIT 5;