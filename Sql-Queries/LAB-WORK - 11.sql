--LAB WORK 11

--CHALLENGE 1
--1

DECLARE @SalesOrderID INT = 71774;
-- Check if the SalesOrderID exists
IF NOT EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
BEGIN
    THROW 50000, 'The specified SalesOrderID does not exist.', 1;
END
ELSE
BEGIN
    DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
    DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
    PRINT 'Order deleted successfully.';
END;

--2
DECLARE @SalesOrderID INT = 71775;
BEGIN TRY
    -- Check if the SalesOrderID exists
    IF NOT EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
    BEGIN
        THROW 50000, 'The specified SalesOrderID does not exist.', 1;
    END
    ELSE
    BEGIN
        DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
        DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
        PRINT 'Order deleted successfully.';
    END;
END TRY
BEGIN CATCH
    PRINT 'Error occurred: ' + ERROR_MESSAGE();
END CATCH;


--chanllenge 2
--1
DECLARE @SalesOrderID INT = 71774;
BEGIN TRY
    BEGIN TRANSACTION;  -- Start a transaction

    -- Check if the SalesOrderID exists
    IF NOT EXISTS (SELECT 1 FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
    BEGIN
        THROW 50000, 'The specified SalesOrderID does not exist.', 1;
    END

    -- Delete from SalesOrderDetail
    DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

    -- Simulate an error for testing (comment out in production)
    -- THROW 50001, 'Simulated error for testing purposes.', 1;

    -- Delete from SalesOrderHeader
    DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;

    -- Commit transaction if no errors occurred
    COMMIT TRANSACTION;
    PRINT 'Order deleted successfully.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;  -- Roll back the transaction if an error occurs

    PRINT 'Error occurred: ' + ERROR_MESSAGE();  -- Print the error message
    THROW;  -- Re-throw the error to be handled by the calling application
END CATCH;
