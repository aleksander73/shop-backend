-- Calculates the total price for an order (including the application of the discount)

-- ----------------------------------------------------------------

-- For data:
--  - orderID = 1

-- Expected result:
--  Total price for the order : 1569.89 : [Discount = 10%]
--  After the discount of 10% -> 1569.89 * 0.9 = 1412.90 [having applied 10% discount]

SELECT ROUND((totalPrice * (CASE WHEN (totalPrice >= 500 AND totalPrice < 1000) THEN 0.95 WHEN (totalPrice < 5000) THEN 0.9 ELSE 0.85 END))::numeric, 2) AS price_after_discount  
FROM (
    SELECT SUM(Product_Order.quantity * Product.sellingPrice) AS totalPrice
    FROM Product_Order
    INNER JOIN Product ON Product_Order.productID = Product.id
    WHERE Product_Order.orderID = 1
) AS t;

-- -------------------------------------------------------------------------------

-- For data:
--  - orderID = 2

-- Expected result:
--  Total price for the order : 5718.64 : [Discount = 15%]
--  After the discount of 10% -> 5718.64 * 0.85 = 4860.84 [having applied 15% discount]

SELECT ROUND((totalPrice * (CASE WHEN (totalPrice >= 500 AND totalPrice < 1000) THEN 0.95 WHEN (totalPrice < 5000) THEN 0.9 ELSE 0.85 END))::numeric, 2) AS price_after_discount  
FROM (
    SELECT SUM(Product_Order.quantity * Product.sellingPrice) AS totalPrice
    FROM Product_Order
    INNER JOIN Product ON Product_Order.productID = Product.id
    WHERE Product_Order.orderID = 2
) AS t;

-- ##########################################################################################################

-- Lists the given product amount in shops in which the product is available

-- --------------------------------------------------------------------------------------------------
-- - @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- - @ I DIDN'T KNOW HOW SPECIFIC I AM TO BE -> SO I MADE 2 DIFFERENT SQL'S                         @
-- - @ * [SQL #1] : FOR EVERY SHOP IT FINDS THE TOTAL QUANTITY OF ANY PRODUCT VARIATION             @
-- - @ * [SQL #2] : FOR EVERY SHOP IT FINDS THE QUANTITY OF PRODUCT WITH GIVEN ATTRIBUTES           @
-- - @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- -------------------------------------------------------------------------------------------------- 

 -- ------------------------------------------------------------

-- [SQL #1] : FOR EVERY SHOP IT FINDS TOTAL QUANTITY OF ANY FALLOUT T-SHIRT 

-- For data:
--  * productID : 11 [Fallout t-shirt]

-- Expected result:
--  * Games Shop : Games Shop Location : 
--      - 0 -   Falout t-shirt - (L - White)
--      - 0 -   Falout t-shirt - (L - Black)
--      - 130 - Falout t-shirt - (XL - White)
--      - 45 -  Falout t-shirt - (XL - Black)
--      - EQUALS IN TOTAL : [175]
--  * Gaming Clothes Shop : Gaming Clothes Shop Location : 
--      - 0 - Falout t-shirt - (S - Red)
--      - 15 - Falout t-shirt - (M - White)
--      - 95 - Falout t-shirt - (L - Blue)
--      - 30 - Falout t-shirt - (XL - White)
--      - 20 - Falout t-shirt - (XL - Black)
--      - EQUALS IN TOTAL : [160]

SELECT Shop.name as ShopName, Shop.location AS AhopLocation, SUM(Product_Shop.quantity) FROM Shop
INNER JOIN Product_Shop ON Shop.location = Product_Shop.shopLocation
WHERE Product_Shop.productID = 11
GROUP BY Shop.Location
ORDER BY Shop.name;

 -- ------------------------------------------------------------

-- [SQL #2] : FOR EVERY SHOP IT FINDS THE QUANTITY OF PRODUCT WITH GIVEN ATTRIBUTES  

-- For data:
--  * productID : 11 [Fallout t-shirt]
--  * size : XL
--  * colour : Black

-- Expected result: [IN EACH SHOP THERE EXISTS ONLY 1 PAIR: PRODUCT_ID + ATTRIBUTES]
--  * Games Shop : Games Shop Location	:
--      - 45 - Falout t-shirt - (XL - Black)
--      - EQUALS IN TOTAL : [45]
--  * Gaming Clothes Shop : Gaming Clothes Shop Location :
--      - 20 - Falout t-shirt - (XL - Black)
--      - EQUALS IN TOTAL : [20]

SELECT Shop.name as ShopName, Shop.location AS AhopLocation, Product_Shop.quantity FROM Shop
INNER JOIN Product_Shop ON Shop.location = Product_Shop.shopLocation
WHERE Product_Shop.productID = 11 AND Product_Shop.attributeID = get_attribute_id('XL', 'Black')
ORDER BY Shop.name;

-- ##########################################################################################################

-- Lists the order's content of a given customer

-- For data:
--  * OrderID : 1 [Order made by Customer #1 in shop "Games Shop"]

-- Expected result:
--  * order #1:
--      - Diablo II	              129.99    x [2]
--      - Diablo II blouse	      199.99    x [3] (XL - Black)
--      - Fallout : New Vegas     189.99    x [1]
--      - Fallout t-shirt         109.99    x [5] (XL - White)

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

-- ----------------------------------------------------------------

-- For data:
--  * OrderID : 2 [Order made by Customer #1 in shop "Games Shop"]

-- Expected result:
--  * order #2:
--      - Amnesia Dark Descent    49.99     x [1]
--      - Battlefield 2	          129.99    x [1]
--      - Call of Duty : MW 2     189       x [1]
--      - Diablo II	              129.99    x [11]
--      - Fallout : New Vegas     189.99    x [20]
--      - Penumbra                39.99     x [3]

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

-- Lists the products sorted by number of times they have been ordered

-- ----------------------------------------------------------------

-- For data:
--  * order #1:
--      - Diablo II	              129.99    x [2]
--      - Diablo II blouse	      189.99    x [3] (XL - Black)
--      - Fallout : New Vegas     189.99    x [1]
--      - Fallout t-shirt         109.99    x [5] (XL - White)
--  * order #2:
--      - Amnesia Dark Descent    49.99     x [1]
--      - Battlefield 2	          129.99    x [1]
--      - Call of Duty : MW 2     189       x [1]
--      - Diablo II	              129.99    x [11]
--      - Fallout : New Vegas     189.99    x [20]
--      - Penumbra                39.99     x [3]

-- Expected result:
--      - Fallout : New Vegas   x [21]
--      - Diablo II             x [13]
--      - Fallout t-shirt       x [5]
--      - Diablo II blouse      x [3]
--      - Penumbra              x [3]
--      - Amnesia Dark Descent  x [1]
--      - Battlefield 2         x [1]
--      - Call of Duty : MW 2   x [1]

SELECT Product.name, SUM(Product_Order.quantity) AS times_ordered FROM Product
INNER JOIN Product_Order ON Product.id = Product_Order.productID
GROUP BY Product.id
ORDER BY times_ordered desc, Product.Name

-- ##########################################################################################################

-- Selects every product 
-- * AVAILABLE at given shop location
-- * ARE NOT IN THE STOCK -> QUANTITY = 0

-- ---------------------------------------

-- For data:
-- * Shop location: "Games Shop Location"

-- Expected result:
-- * Fallout t-shirt - (L - White)
-- * Fallout t-shirt - (L - Black)

SELECT Product.name, Attribute.sizeValue, Attribute.colourValue FROM Product_Shop
INNER JOIN Product ON Product_Shop.productID = Product.id
LEFT JOIN Attribute ON Product_Shop.attributeID = Attribute.id
WHERE Product_Shop.shopLocation = 'Games Shop Location' AND Product_Shop.quantity = 0;

-- ---------------------------------------

-- For data:
-- * Shop location: "Films Shop Location"

-- Expected result:
-- * 2012

SELECT Product.name, Attribute.sizeValue, Attribute.colourValue FROM Product_Shop
INNER JOIN Product ON Product_Shop.productID = Product.id
LEFT JOIN Attribute ON Product_Shop.attributeID = Attribute.id
WHERE Product_Shop.shopLocation = 'Films Shop Location' AND Product_Shop.quantity = 0;

-- ---------------------------------------------------------------------------

-- For data:
-- * Shop location: "Gaming Clothes Shop Location"

-- Expected result:
-- * Fallout t-shirt - (S - Red)

SELECT Product.name, Attribute.sizeValue, Attribute.colourValue FROM Product_Shop
INNER JOIN Product ON Product_Shop.productID = Product.id
LEFT JOIN Attribute ON Product_Shop.attributeID = Attribute.id
WHERE Product_Shop.shopLocation = 'Gaming Clothes Shop Location' AND Product_Shop.quantity = 0;
