CREATE OR REPLACE FUNCTION product_exists(param_productID integer) RETURNS boolean 
AS $$ 
    DECLARE numberOfRows integer;
    BEGIN
        numberOfRows := (SELECT COUNT(*)::int FROM (
            SELECT * FROM Product WHERE Product.id = param_productID
        ) AS row_count);

        IF numberOfRows = 0 THEN
            return false;
        ELSE
            return true;
        END IF;
    END;
$$ 
LANGUAGE plpgsql;

-- ##########################################################################################################

CREATE OR REPLACE FUNCTION get_attribute_id(param_size text, param_colour text) RETURNS integer 
AS $$ 
    DECLARE 
        attributeId integer;
        attributeSize text;
        attributeColour text;
    BEGIN
        IF param_size IS NULL AND param_colour IS NULL THEN
            RAISE EXCEPTION 'error: parameters cannot be null';
        END IF;

        -- ------------------------------------------------------------

        IF param_size IS NOT NULL AND param_colour IS NOT NULL THEN
            SELECT * INTO attributeId, attributeSize, attributeColour FROM Attribute WHERE param_size = Attribute.sizeValue AND param_colour = Attribute.colourValue;
        ELSEIF param_size IS NULL THEN
           SELECT * INTO attributeId, attributeSize, attributeColour FROM Attribute WHERE Attribute.sizeValue IS NULL AND param_colour = Attribute.colourValue;
        ELSE
           SELECT * INTO attributeId, attributeSize, attributeColour FROM Attribute WHERE param_size = Attribute.sizeValue AND Attribute.colourValue IS NULL;
        END IF;

        -- ------------------------------------------------------------

        return attributeId;
    END;
$$ 
LANGUAGE plpgsql;

-- ##########################################################################################################

-- Both start_date and end_date are inclusive
-- Ignores the products that haven't been bought throughout the whole period [!]
CREATE OR REPLACE FUNCTION list_products_by_amount_sold_in_period(param_start_date date, param_end_date date) 
RETURNS TABLE (
    product_id int, 
    product_name text, 
    quantity_sold_in_period int)
AS $$ 
    BEGIN
        return QUERY 
            SELECT Product.id::int, Product.name::text, SUM(Product_Order.quantity)::int FROM Product
            INNER JOIN Product_Order ON Product.id = Product_Order.productID
            INNER JOIN public.Order ON Product_Order.orderID = public.Order.id
            WHERE public.Order.date >= param_start_date AND public.Order.date <= param_end_date
            GROUP BY Product.id
            ORDER BY quantity_sold_in_period desc;
    END;
$$ 
LANGUAGE plpgsql;

-- ##########################################################################################################

-- Both start_date and end_date are inclusive
-- Ignores the products that haven't been bought throughout the whole period [!]
CREATE OR REPLACE FUNCTION list_products_by_profit_in_period(param_start_date date, param_end_date date) 
RETURNS TABLE (
    product_id int, 
    product_name text, 
    profit_selling_item_in_period real)
AS $$ 
    BEGIN
        return QUERY 
            SELECT Product.id::int, Product.name::text, ROUND(SUM(Product_Order.quantity * (Product.sellingPrice - Product.purchasePrice))::numeric, 2)::real FROM Product
            INNER JOIN Product_Order ON Product.id = Product_Order.productID
            INNER JOIN public.Order ON Product_Order.orderID = public.Order.id
            WHERE public.Order.date >= param_start_date AND public.Order.date <= param_end_date
            GROUP BY Product.id
            ORDER BY profit_selling_item_in_period desc;
    END;
$$ 
LANGUAGE plpgsql;

-- ##########################################################################################################

-- Checks if a given product is OFFERED by any shop in a given combination of size and colour. 
-- [Doesn't check if it is currently available (!) -> (Doesn't check if it is on the shelves in any shop)]
CREATE OR REPLACE FUNCTION product_available(param_productID integer, param_size text, param_colour text) RETURNS boolean 
AS $$ 
    DECLARE 
    numberOfRows integer;
    foundAttributeID integer;
    BEGIN
        IF product_exists(param_productID) IS FALSE THEN
            RAISE EXCEPTION 'error: Product with given ID doesn''t exist';
        END IF;

        foundAttributeID := get_attribute_id(param_size, param_colour);
        IF foundAttributeID IS NULL THEN
            -- if such combination of attributes doesn't exist 
            return false;
        END IF;

        -- ------------------------------------------------------------
        
        numberOfRows := (
            SELECT COUNT(*)::int 
            FROM Product_Shop
            WHERE Product_Shop.productID = param_productID AND Product_Shop.attributeID = foundAttributeID
        );
        
        -- ------------------------------------------------------------

        IF numberOfRows > 0 THEN
            return true;
        ELSE
            return false;
        END IF;
    END;
$$ 
LANGUAGE plpgsql;

-- ##########################################################################################################

CREATE OR REPLACE FUNCTION create_order(param_date date, param_customerID integer, param_shopLocation text, param_productIDs integer[], param_attributeIDs integer[], param_quantities integer[]) 
RETURNS VOID
AS $$ 
    DECLARE
        i integer := 0;
        orderID integer;
    BEGIN

        IF (array_length(productIDs, 1) <> array_length(quantities, 1)) THEN
            RAISE EXCEPTION 'error: parmaters must have matching quantities';
        END IF;

        -- Create the order
        --orderID := 
        INSERT INTO public.Order(date, customerID, shopLocation) VALUES(param_date, param_customerID, param_shopLocation) 
        RETURNING id INTO orderID;

        -- Fill the order
        FOR i in 1 .. array_length(productIDs, 1) LOOP
            INSERT INTO public.Product_Order(productID, orderID, attributeID, quantity)
            VALUES (param_productIDs[i], orderID, param_attributeIDs[i], param_quantities[i]);
        END LOOP;
    END;
$$ 
LANGUAGE plpgsql;
