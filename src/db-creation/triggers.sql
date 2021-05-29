-- Trigger function
-- Alerts the employee when the amount of a specific product in shop is less than minimum amount in the stock allowed
CREATE OR REPLACE FUNCTION check_quantity_available_on_product_sold() RETURNS TRIGGER
AS $$ 
    DECLARE
        minAmountInStock integer;
        quantityOfProduct integer;
        productName text;
    BEGIN
        -- get minimum amount in stock required
        minAmountInStock := (
            SELECT Product.minAmountInStock 
            FROM Product 
            WHERE Product.id = OLD.productID
        );
        -- get total amount of a given product (not including attributes) in the stock of a given shop
        quantityOfProduct := (
                SELECT SUM(Product_Shop.quantity) 
                FROM Product_Shop 
                WHERE Product_Shop.productID = OLD.productID 
                AND Product_Shop.shopLocation = OLD.shopLocation
        );
        productName := (SELECT Product.name FROM Product WHERE Product.id = OLD.productID);

        -- ----------------------------------------

        IF quantityOfProduct < minAmountInStock THEN
            RAISE WARNING 'Current amount (%) of product "%" (productID = %) in shop "%" is less than minimum amount in stock allowed % !', quantityOfProduct, productName, OLD.productID, OLD.shopLocation, minAmountInStock;
        END IF;

        RETURN NULL;
    END;
$$ 
LANGUAGE plpgsql;

-- ----------------------------------------------------

DROP TRIGGER IF EXISTS check_quantity_available_of_product on public.Product_Shop;

CREATE TRIGGER check_quantity_available_of_product
AFTER UPDATE ON public.Product_Shop
FOR EACH ROW
WHEN (OLD.quantity IS DISTINCT FROM NEW.quantity)
EXECUTE PROCEDURE check_quantity_available_on_product_sold();
