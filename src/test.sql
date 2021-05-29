-- test function : product_exists(productID) : boolean
SELECT product_exists(1); -- (true)
SELECT product_exists(10000000); -- (false)

-- ##########################################################################################################

-- test function : get_attribute_id(size, colour) : integer
SELECT get_attribute_id('M', 'White'); -- (4)
SELECT get_attribute_id(NULL, 'Black'); -- (5)
SELECT get_attribute_id('S', NULL); -- (NULL)
SELECT get_attribute_id(NULL, NULL); -- (error) parameters cannot be NULL

-- ##########################################################################################################

-- test function : list_products_by_amount_sold_in_period(date, date) : table

-- Only one order was made in period <'05-06-2017', '06-06-2017'> - order #1
SELECT * FROM list_products_by_amount_sold_in_period('05-06-2017', '06-06-2017');

-- Only one order was made in period <'08-06-2017', '12-06-2017'> - order #2
SELECT * FROM list_products_by_amount_sold_in_period('08-06-2017', '12-06-2017');

-- no orders made in period <'07-06-2017', '09-06-2017'>
SELECT * FROM list_products_by_amount_sold_in_period('07-06-2017', '09-06-2017');

-- Two orders made in period <'05-06-2017', '12-06-2017'> - order #1 and order #2
SELECT * FROM list_products_by_amount_sold_in_period('05-06-2017', '12-06-2017');

-- list order #1 (made: 05-06-2017)
SELECT 
    Product.name AS name, 
    Product.sellingPrice AS price_for_unit, 
    Product_Order.quantity AS quantity, 
    Attribute.sizeValue AS size, 
    Attribute.colourValue AS colour 
FROM Product_Order
INNER JOIN Product ON Product_Order.productID = Product.id
LEFT JOIN Attribute ON Product_Order.attributeID = Attribute.id
WHERE Product_Order.orderID = 1
ORDER BY Product.name;

-- list order #2 (made: 12-06-2017)
SELECT 
    Product.name AS name, 
    Product.sellingPrice AS price_for_unit, 
    Product_Order.quantity AS quantity, 
    Attribute.sizeValue AS size, 
    Attribute.colourValue AS colour 
FROM Product_Order
INNER JOIN Product ON Product_Order.productID = Product.id
LEFT JOIN Attribute ON Product_Order.attributeID = Attribute.id
WHERE Product_Order.orderID = 2
ORDER BY Product.name;

-- ##########################################################################################################

-- test function : list_products_by_profit_in_period(date, date) : table

-- Only one order was made in period <'05-06-2017', '06-06-2017'> - order #1
SELECT * FROM list_products_by_profit_in_period('05-06-2017', '06-06-2017');

-- Only one order was made in period <'08-06-2017', '12-06-2017'> - order #2
SELECT * FROM list_products_by_profit_in_period('08-06-2017', '12-06-2017');

-- no orders made in period <'07-06-2017', '09-06-2017'>
SELECT * FROM list_products_by_profit_in_period('07-06-2017', '09-06-2017');

-- Two orders made in period <'05-06-2017', '12-06-2017'> - order #1 and order #2
SELECT * FROM list_products_by_profit_in_period('05-06-2017', '12-06-2017');

-- list order #1 (made: 05-06-2017)
SELECT 
    Product.name AS name, 
    Product.sellingPrice AS price_for_unit, 
    Product_Order.quantity AS quantity, 
    Attribute.sizeValue AS size, 
    Attribute.colourValue AS colour 
FROM Product_Order
INNER JOIN Product ON Product_Order.productID = Product.id
LEFT JOIN Attribute ON Product_Order.attributeID = Attribute.id
WHERE Product_Order.orderID = 1
ORDER BY Product.name;

-- list order #2 (made: 12-06-2017)
SELECT 
    Product.name AS name, 
    Product.sellingPrice AS price_for_unit, 
    Product_Order.quantity AS quantity, 
    Attribute.sizeValue AS size, 
    Attribute.colourValue AS colour 
FROM Product_Order
INNER JOIN Product ON Product_Order.productID = Product.id
LEFT JOIN Attribute ON Product_Order.attributeID = Attribute.id
WHERE Product_Order.orderID = 2
ORDER BY Product.name;

-- ##########################################################################################################

-- test function : product_available(productID, size, colour) : boolean
SELECT product_available(11, 'M', 'White'); -- T-shirt (true)
SELECT product_available(11, 'M', 'Blue'); -- T-shirt (false) [combination doesn't exist anywhere]
SELECT product_available(12, 'L', 'Blue'); -- Blouse (false) [combination exists but not in Blouses]

SELECT product_available(10, NULL, 'White'); -- Socks (true)
SELECT product_available(10, NULL, 'Red'); -- Socks (false)

SELECT product_available(10000, 'S', 'White'); -- (error) product doesn't exist

SELECT product_available(1, NULL, NULL); -- (error) parameters cannot be NULL

-- ##########################################################################################################

-- test trigger : check_quantity_available_of_product

-- For data:
--  * Shop : "Games Shop Locaiton"
--      * [Fallout t-shirts there]
--          - 0 x (L - White)
--          - 0 x (L - Black)
--          - 130 x (XL - White)
--          - 45 x (XL - Black)

-- so total amount is 175
-- minAmountInStock for Fallout t-shirts is 125

-- So we buy some T-thirts (XL - White) resulting in amount = 125 [Total (170) > 125 allowed]
UPDATE Product_Shop SET quantity = 125 WHERE productID = 11 AND attributeID = 9 AND shopLocation = 'Games Shop Location';

-- Then we buy some T-thirts (XL - White) resulting in amount = 80 [Total (125) >= 125 allowed] [HERE WE ARE CLOSE TO THE WARNING]
UPDATE Product_Shop SET quantity = 80 WHERE productID = 11 AND attributeID = 9 AND shopLocation = 'Games Shop Location';

-- Then we buy some T-thirts (XL - White) resulting in amount = 124 [Total (124) < 125 allowed] [WARNING POPS UP]
UPDATE Product_Shop SET quantity = 79 WHERE productID = 11 AND attributeID = 9 AND shopLocation = 'Games Shop Location';

-- bring back the amount to original
UPDATE Product_Shop SET quantity = 130 WHERE productID = 11 AND attributeID = 9 AND shopLocation = 'Games Shop Location';
