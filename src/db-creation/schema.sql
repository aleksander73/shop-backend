DROP TABLE IF EXISTS public.Shop CASCADE;
DROP TABLE IF EXISTS public.Employee CASCADE;
DROP TABLE IF EXISTS public.Product CASCADE;
DROP TABLE IF EXISTS public.Category CASCADE;
DROP TABLE IF EXISTS public.Attribute CASCADE;
DROP TABLE IF EXISTS public.Size CASCADE;
DROP TABLE IF EXISTS public.Colour CASCADE;
DROP TABLE IF EXISTS public.Order CASCADE;
DROP TABLE IF EXISTS public.Customer CASCADE;
DROP TABLE IF EXISTS public.Product_Shop CASCADE;
DROP TABLE IF EXISTS public.Product_Category CASCADE;
DROP TABLE IF EXISTS public.Product_Order CASCADE;

-- ---------------- CREATE SHOP TABLE ----------------

-- DROP TABLE public.Shop;
CREATE TABLE public.Shop (
    location varchar(255) PRIMARY KEY,
    name varchar(255) NOT NULL,
    managerID integer
);

-- ---------------- CREATE EMPLOYEE TABLE ----------------

-- DROP TABLE public.Employee;
CREATE TABLE public.Employee (
    id SERIAL PRIMARY KEY,
    shopLocation varchar(255) NOT NULL
);

-- ---------------- CREATE PRODUCT TABLE ----------------

-- DROP TABLE public.Product;
CREATE TABLE public.Product (
    id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL,
    purchasePrice real NOT NULL,
    sellingPrice real NOT NULL,
    weight real NOT NULL,
    minAmountInStock integer NOT NULL
);

-- Check that we will earn some money by selling the product
ALTER TABLE public.Product ADD CONSTRAINT product_price_check CHECK (purchasePrice < sellingPrice);
-- Check that minAmountInStock > 0
ALTER TABLE public.Product ADD CONSTRAINT product_amount_in_stock_check CHECK (minAmountInStock > 0);

-- ---------------- CREATE CATEGORY TABLE ----------------

-- DROP TABLE public.Category;
CREATE TABLE public.Category (
    id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    parentCategoryID integer
);

-- ---------------- CREATE SIZE TABLE ----------------

-- DROP TABLE public.Size;
CREATE TABLE public.Size (
    value varchar(255) PRIMARY KEY
);

-- ---------------- CREATE COLOUR TABLE ----------------

-- DROP TABLE public.Colour;
CREATE TABLE public.Colour (
    value varchar(255) PRIMARY KEY
);

-- ---------------- CREATE ATTRIBUTE TABLE ----------------

-- DROP TABLE public.Attribute;
CREATE TABLE public.Attribute (
    id SERIAL PRIMARY KEY,
    sizeValue varchar(50),
    colourValue varchar(50)
);

-- Check that at most one is NULL
ALTER TABLE public.Attribute ADD CONSTRAINT attribute_null_check CHECK (sizeValue IS NOT NULL OR colourValue IS NOT NULL);

-- Prevent duplicates (including NULLs in either size or colour)
CREATE UNIQUE INDEX index_size_colour ON public.Attribute (sizeValue, colourValue);
CREATE UNIQUE INDEX index_size_null ON public.Attribute (sizeValue) WHERE colourValue IS NULL;
CREATE UNIQUE INDEX index_null_colour ON public.Attribute (colourValue) WHERE sizeValue IS NULL;

-- ---------------- CREATE CUSTOMER TABLE ----------------

-- DROP TABLE public.Customer;
CREATE TABLE public.Customer (
    id SERIAL PRIMARY KEY
);

-- ---------------- CREATE ORDER TABLE ----------------

-- DROP TABLE public.Order;
CREATE TABLE public.Order (
    id SERIAL PRIMARY KEY,
    date date NOT NULL,
    customerID integer NOT NULL,
    shopLocation varchar(255) NOT NULL
);

-- NO UNIQUE INDEX SINCE THERE CAN BE MADE AN ORDER AT THE SAME DAY AND AT THE SAME SHOP BY A GIVEN CUSTOMER

-- -------------------- ASSOCIATION TABLES --------------------

-- ---------------- CREATE PRODUCT_SHOP TABLE ----------------

-- DROP TABLE public.Product_Shop;
CREATE TABLE public.Product_Shop (
    id SERIAL PRIMARY KEY,
    productID integer NOT NULL,
    shopLocation varchar(255) NOT NULL,
    attributeID integer,
    quantity integer NOT NULL
);

-- Check that quantity is positive
-- If the quantity is 0 it means that the given shop OFFERS THIS PRODUCT BUT THERE ARE NO PRODUCTS IN THE STOCK
ALTER TABLE public.Product_Shop ADD CONSTRAINT product_shop_quantity_check CHECK (quantity >= 0);
-- Prevent duplicates (including NULLs in attributeID)
CREATE UNIQUE INDEX index_product_shop_null ON public.Product_Shop (productID, shopLocation) WHERE attributeID IS NULL;
CREATE UNIQUE INDEX index_product_shop_attribute ON public.Product_Shop (productID, shopLocation, attributeID);

-- ---------------- CREATE PRODUCT_CATEGORY TABLE ----------------

-- DROP TABLE public.Product_Category;
CREATE TABLE public.Product_Category (
    productID integer NOT NULL,
    categoryID integer NOT NULL,
    PRIMARY KEY(productID, categoryID)
);

-- ---------------- CREATE PRODUCT_ORDER TABLE ----------------

-- DROP TABLE public.Product_Order;
CREATE TABLE public.Product_Order (
    id SERIAL PRIMARY KEY,
    productID integer NOT NULL,
    orderID integer NOT NULL,
    attributeID integer,
    quantity integer NOT NULL
);

-- Check that quantity being ordered is positive
ALTER TABLE public.Product_Order ADD CONSTRAINT product_order_quantity_check CHECK (quantity > 0);
-- Prevent duplicates (including NULLs in attributeID)
CREATE UNIQUE INDEX index_product_order_null ON public.Product_Order (productID, orderID) WHERE attributeID IS NULL;
CREATE UNIQUE INDEX index_product_order_attribute ON public.Product_Order (productID, orderID, attributeID);

-- ---------------------------------------------- CONSTRAINTS [FOREIGN KEYS] ----------------------------------------------

ALTER TABLE public.Shop ADD CONSTRAINT employee_managerID_FK FOREIGN KEY(managerID) REFERENCES public.Employee(id);

ALTER TABLE public.Employee ADD CONSTRAINT employee_shopID_FK FOREIGN KEY(shopLocation) REFERENCES public.Shop(location);

ALTER TABLE public.Category ADD CONSTRAINT category_parentCategoryID_FK FOREIGN KEY(parentCategoryID) REFERENCES public.Category(id);

ALTER TABLE public.Order ADD CONSTRAINT order_customerID_FK FOREIGN KEY(customerID) REFERENCES public.Customer(id);
ALTER TABLE public.Order ADD CONSTRAINT order_shopID_FK FOREIGN KEY(shopLocation) REFERENCES public.Shop(location);

ALTER TABLE public.Attribute ADD CONSTRAINT attribute_sizeValue_FK FOREIGN KEY(sizeValue) REFERENCES public.Size(value);
ALTER TABLE public.Attribute ADD CONSTRAINT attribute_colourValue_FK FOREIGN KEY(colourValue) REFERENCES public.Colour(value);

ALTER TABLE public.Product_Shop ADD CONSTRAINT productShop_productID_FK FOREIGN KEY(productID) REFERENCES public.Product(id);
ALTER TABLE public.Product_Shop ADD CONSTRAINT productShop_shopID_FK FOREIGN KEY(shopLocation) REFERENCES public.Shop(location);
ALTER TABLE public.Product_Shop ADD CONSTRAINT productShop_attributeID_FK FOREIGN KEY(attributeID) REFERENCES public.Attribute(id);

ALTER TABLE public.Product_Category ADD CONSTRAINT productCategory_productID_FK FOREIGN KEY(productID) REFERENCES public.Product(id);
ALTER TABLE public.Product_Category ADD CONSTRAINT productCategory_categoryID_FK FOREIGN KEY(categoryID) REFERENCES public.Category(id);

ALTER TABLE public.Product_Order ADD CONSTRAINT productOrder_productID_FK FOREIGN KEY(productID) REFERENCES public.Product(id);
ALTER TABLE public.Product_Order ADD CONSTRAINT productOrder_orderID_FK FOREIGN KEY(orderID) REFERENCES public.Order(id);
ALTER TABLE public.Product_Shop ADD CONSTRAINT productOrder_attributeID_FK FOREIGN KEY(attributeID) REFERENCES public.Attribute(id);
