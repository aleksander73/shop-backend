-- ----------------------------------------------------------------------------

INSERT INTO public.Shop(name, location) VALUES ('Games Shop', 'Games Shop Location');
INSERT INTO public.Shop(name, location) VALUES ('Films Shop', 'Films Shop Location');
INSERT INTO public.Shop(name, location) VALUES ('Gaming Clothes Shop', 'Gaming Clothes Shop Location');

-- ----------------------------------------------------------------------------

INSERT INTO public.Employee(shopLocation) VALUES('Games Shop Location'); -- ID = 1
INSERT INTO public.Employee(shopLocation) VALUES('Games Shop Location'); -- ID = 2
INSERT INTO public.Employee(shopLocation) VALUES('Games Shop Location'); -- ID = 3

INSERT INTO public.Employee(shopLocation) VALUES('Films Shop Location'); -- ID = 4
INSERT INTO public.Employee(shopLocation) VALUES('Films Shop Location'); -- ID = 5

INSERT INTO public.Employee(shopLocation) VALUES('Gaming Clothes Shop Location'); -- ID = 6
INSERT INTO public.Employee(shopLocation) VALUES('Gaming Clothes Shop Location'); -- ID = 7
INSERT INTO public.Employee(shopLocation) VALUES('Gaming Clothes Shop Location'); -- ID = 8
INSERT INTO public.Employee(shopLocation) VALUES('Gaming Clothes Shop Location'); -- ID = 9

-- ----------------------------------------------------------------------------

UPDATE public.Shop SET managerID = 3 WHERE location = 'Games Shop Location';
UPDATE public.Shop SET managerID = 4 WHERE location = 'Films Shop Location';
UPDATE public.Shop SET managerID = 7 WHERE location = 'Gaming Clothes Shop Location';

-- ----------------------------------------------------------------------------

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock) -- ID = 1
VALUES('Fallout : New Vegas', 'Fallout : New Vegas Description', 150.15, 189.99, 0.5, 30);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 2
VALUES('Bioshock Infinite', 'Bioshock Infinite Description', 200.55, 259.99, 0.45, 40);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 3
VALUES('Amnesia Dark Descent', 'Amnesia Dark Descent Description', 30.05, 49.99, 0.45, 50);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 4
VALUES('Penumbra', 'Penumbra Description', 20.50, 39.99, 0.5, 20);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 5
VALUES('Diablo II', 'Diablo II Description', 100.70, 129.99, 0.7, 25);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 6
VALUES('Call of Duty : Modern Warfare 2', 'Call of Duty : Modern Warfare 2 Description', 140.95, 189.00, 0.4, 20);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 7
VALUES('Battlefield 2', 'Battlefield 2 Description', 80.20, 129.99, 0.35, 45);

-- -----------------------------

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 8
VALUES('2012', '2012 Description', 200.40, 229.99, 0.6, 35);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 9
VALUES('Private Ryan', 'Private Ryan Description', 100.20, 139.99, 0.5, 25);

-- -----------------------------

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 10
VALUES('Funny Bioshock socks', 'Funny Bioshock socks Description', 10.00, 13.99, 0.2, 600);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 11
VALUES('Fallout t-shirt', 'Fallout t-shirt Description', 80.80, 109.99, 1.2, 125);

INSERT INTO public.Product(name, description, purchasePrice, sellingPrice, weight, minAmountInStock)  -- ID = 12
VALUES('Diablo II blouse', 'Diablo II blouse Description', 130.30, 199.99, 1.5, 105);

-- ----------------------------------------------------------------------------

INSERT INTO public.Category(name) VALUES('Entertainment'); -- ID = 1
INSERT INTO public.Category(name) VALUES('Clothes'); -- ID = 2

INSERT INTO public.Category(name, parentcategoryid) VALUES('Games', 1); -- ID = 3
INSERT INTO public.Category(name, parentcategoryid) VALUES('Films', 1); -- ID = 4

INSERT INTO public.Category(name, parentcategoryid) VALUES('Socks', 2); -- ID = 5
INSERT INTO public.Category(name, parentcategoryid) VALUES('Upper body', 2); -- ID = 6

INSERT INTO public.Category(name, parentcategoryid) VALUES('RPG', 3); -- ID = 7
INSERT INTO public.Category(name, parentcategoryid) VALUES('Adventure', 3); -- ID = 8
INSERT INTO public.Category(name, parentcategoryid) VALUES('Action', 3); -- ID = 9
INSERT INTO public.Category(name, parentcategoryid) VALUES('Horror', 3); -- ID = 10

INSERT INTO public.Category(name, parentcategoryid) VALUES('War movie', 4); -- ID = 11
INSERT INTO public.Category(name, parentcategoryid) VALUES('Catastrophic', 4); -- ID = 12

INSERT INTO public.Category(name, parentcategoryid) VALUES('MMORPG', 7); -- ID = 13
INSERT INTO public.Category(name, parentcategoryid) VALUES('cRPG', 7); -- ID = 14
INSERT INTO public.Category(name, parentcategoryid) VALUES('Shooter', 9); -- ID = 15
INSERT INTO public.Category(name, parentcategoryid) VALUES('Survival Horror', 10); -- ID = 16

-- ----------------------------------------------------------------------------

INSERT INTO public.Product_Category(productID, categoryid) VALUES(1, 14); -- Fallout : New Vegas -> cRPG
INSERT INTO public.Product_Category(productID, categoryid) VALUES(2, 15); -- Bioshock Infinite -> Shooter
INSERT INTO public.Product_Category(productID, categoryid) VALUES(3, 16); -- Amnesia Dark Descent -> Survival Horror
INSERT INTO public.Product_Category(productID, categoryid) VALUES(4, 16); -- Penumbra -> Survival Horror
INSERT INTO public.Product_Category(productID, categoryid) VALUES(5, 14); -- Diablo II -> cRPG
INSERT INTO public.Product_Category(productID, categoryid) VALUES(6, 15); -- Call of Duty : Modern Warfare 2 -> Shooter
INSERT INTO public.Product_Category(productID, categoryid) VALUES(7, 15); -- Battlefield 2 -> Shooter

INSERT INTO public.Product_Category(productID, categoryid) VALUES(8, 12); -- 2012 -> Catastrophic
INSERT INTO public.Product_Category(productID, categoryid) VALUES(9, 11); -- Private Ryan -> War movie

INSERT INTO public.Product_Category(productID, categoryid) VALUES(10, 5); -- Funny Bioshock socks -> Socks
INSERT INTO public.Product_Category(productID, categoryid) VALUES(11, 6); -- Fallout t-shirt -> Upper body
INSERT INTO public.Product_Category(productID, categoryid) VALUES(12, 6); -- Diablo II blouse -> Upper body

-- ----------------------------------------------------------------------------

INSERT INTO public.Size VALUES('S');
INSERT INTO public.Size VALUES('M');
INSERT INTO public.Size VALUES('L');
INSERT INTO public.Size VALUES('XL');

-- ----------------------------------------------------------------------------

INSERT INTO public.Colour VALUES('White');
INSERT INTO public.Colour VALUES('Black');
INSERT INTO public.Colour VALUES('Red');
INSERT INTO public.Colour VALUES('Blue');

-- ----------------------------------------------------------------------------

INSERT INTO public.Attribute(sizeValue, colourValue) VALUES(NULL, 'White'); -- ID = 1
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('S', 'Red'); -- ID = 2
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES(NULL, 'Blue'); -- ID = 3
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('M', 'White'); -- ID = 4
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES(NULL, 'Black'); -- ID = 5
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('L', 'White'); -- ID = 6
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('L', 'Black'); -- ID = 7
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('L', 'Blue'); -- ID = 8
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('XL', 'White'); -- ID = 9
INSERT INTO public.Attribute(sizeValue, colourValue) VALUES('XL', 'Black'); -- ID = 10

-- ----------------------------------------------------------------------------

-- Shop #1 (sells only games + clothes) [games have no size nor colour]

INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(1, 'Games Shop Location', NULL, 50); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(2, 'Games Shop Location', NULL, 80); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(3, 'Games Shop Location', NULL, 52); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(4, 'Games Shop Location', NULL, 25); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(5, 'Games Shop Location', NULL, 35); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(6, 'Games Shop Location', NULL, 47); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(7, 'Games Shop Location', NULL, 45); -- (no size) + (no colour)

-- "Fallout T-shirt" configurations
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Games Shop Location', 6, 0); -- L + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Games Shop Location', 7, 0); -- L + Black
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Games Shop Location', 9, 130); -- XL + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Games Shop Location', 10, 45); -- XL + Black

-- "Diablo II blouse" configurations
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(12, 'Games Shop Location', 10, 115); -- XL + Black

-- ------------------------------------

-- Shop #2 (sells only films) [films have no size nor colour]

INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(8, 'Films Shop Location', NULL, 0); -- (no size) + (no colour)
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(9, 'Films Shop Location', NULL, 55); -- (no size) + (no colour)

-- ------------------------------------

-- Shop #3 (sells only clothes) [clothes have size and/or colour]

-- "Funny Bioshock socks" configurations
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(10, 'Gaming Clothes Shop Location', 1, 300); -- (no size) + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(10, 'Gaming Clothes Shop Location', 3, 105); -- (no size) + Blue
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(10, 'Gaming Clothes Shop Location', 5, 200); -- (no size) + Black

-- "Fallout T-shirt" configurations
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Gaming Clothes Shop Location', 2, 0); -- S + Red
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Gaming Clothes Shop Location', 4, 15); -- M + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Gaming Clothes Shop Location', 8, 95); -- L + Blue
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Gaming Clothes Shop Location', 9, 30); -- XL + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(11, 'Gaming Clothes Shop Location', 10, 20); -- XL + Black

-- "Diablo II blouse" configurations
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(12, 'Gaming Clothes Shop Location', 6, 10); -- L + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(12, 'Gaming Clothes Shop Location', 7, 50); -- L + Black
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(12, 'Gaming Clothes Shop Location', 9, 55); -- XL + White
INSERT INTO public.Product_Shop(productID, shopLocation, attributeID, quantity) VALUES(12, 'Gaming Clothes Shop Location', 10, 20); -- XL + Black

-- ----------------------------------------------------------------------------

INSERT INTO public.Customer VALUES(1); -- ID = 1
INSERT INTO public.Customer VALUES(2); -- ID = 2
INSERT INTO public.Customer VALUES(3); -- ID = 3
INSERT INTO public.Customer VALUES(4); -- ID = 4

-- ----------------------------------------------------------------------------

INSERT INTO public.Order(date, customerID, shopLocation) VALUES('05-06-2017', 1, 'Games Shop Location');

-- order (Fallout : NV) x 1
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(1, 1, NULL, 1);
-- order (Diablo II) x 2
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(5, 1, NULL, 2);
-- order (Fallout t-shirt) [XL - White] x 5
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(11, 1, 9, 5);
-- order (Diablo II Blouse) [XL - Black] x 3
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(12, 1, 10, 3);

-- ------------------------------------------------

INSERT INTO public.Order(date, customerID, shopLocation) VALUES('12-06-2017', 1, 'Games Shop Location');

-- order (Fallout : NV) x 20
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(1, 2, NULL, 20);
-- order (Amnesia : Dark Descent) x 1
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(3, 2, NULL, 1);
-- order (Penumbra) x 3
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(4, 2, NULL, 3);
-- order (Diablo II) x 11
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(5, 2, NULL, 11);
-- order (Call of Duty : Modern Warfare) x 1
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(6, 2, NULL, 1);
-- order (Battlefield 2) x 1
INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity) VALUES(7, 2, NULL, 1);
