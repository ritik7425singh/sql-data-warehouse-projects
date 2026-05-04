CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    -- Declare variables to track timing
    DECLARE @start_time DATETIME, @end_time DATETIME;
    DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;
    
    -- Capture start time for the entire process
    SET @batch_start_time = GETDATE(); 
    
    PRINT '================================================';
    PRINT 'Loading Bronze Layer';
    PRINT '================================================';

    -- ===================================================================
    -- 1. CRM Tables Load
    -- ===================================================================
    
    -- Table: crm_cust_info
    SET @start_time = GETDATE(); -- Start individual timer
    PRINT '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    PRINT '>> Inserting Data Into: bronze.crm_cust_info';
    BULK INSERT bronze.crm_cust_info
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE(); -- End individual timer
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Table: crm_prd_info
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Table: crm_sales_details
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- ===================================================================
    -- 2. ERP Tables Load
    -- ===================================================================

    -- Table: erp_loc_a101
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_loc_a101;
    BULK INSERT bronze.erp_loc_a101
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Table: erp_cust_az12
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_cust_az12;
    BULK INSERT bronze.erp_cust_az12
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Table: erp_px_cat_g1v2
    SET @start_time = GETDATE();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'C:\Users\Ritik Singh\Downloads\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    SET @end_time = GETDATE();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

    -- Final Batch Timing
    SET @batch_end_time = GETDATE();
    PRINT '================================================';
    PRINT 'Bronze Load Completed';
    PRINT 'Total Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
    PRINT '================================================';
END;
