DELIMITER $$

DROP PROCEDURE IF EXISTS CreateAndSeedUserInfo$$

CREATE PROCEDURE CreateAndSeedUserInfo()
BEGIN
    -- 1. Declare iteration control variables
    DECLARE i INT DEFAULT 1;
    DECLARE total_rows INT DEFAULT 5000000;
    DECLARE batch_size INT DEFAULT 10000;
    
    -- 2. Performance Tuning: Optimize session settings for massive data loading
    SET max_execution_time = 0;         -- Prevent script timeout
    SET FOREIGN_KEY_CHECKS = 0;         -- Disable constraint checking during insertion
    SET UNIQUE_CHECKS = 0;              -- Disable uniqueness checking during insertion
    SET AUTOCOMMIT = 0;                 -- Handle transactions manually in batches

    -- 3. Dynamic DDL: Fresh start for the table
    DROP TABLE IF EXISTS userinfo;
    
    CREATE TABLE userinfo (
        id INT UNSIGNED NOT NULL AUTO_INCREMENT,
        name VARCHAR(64) NOT NULL DEFAULT '',
        email VARCHAR(128) NOT NULL DEFAULT '',
        password VARCHAR(64) NOT NULL DEFAULT '',
        dob DATE NOT NULL,
        address VARCHAR(255) NOT NULL DEFAULT '',
        city VARCHAR(64) NOT NULL DEFAULT '',
        state_id INT UNSIGNED NOT NULL DEFAULT 0,
        zip VARCHAR(10) NOT NULL DEFAULT '',
        country_id INT UNSIGNED NOT NULL DEFAULT 1,
        account_type VARCHAR(20) NOT NULL DEFAULT 'standard',
        closest_airport VARCHAR(3) NOT NULL DEFAULT 'LAX',
        PRIMARY KEY (id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    -- 4. The Seeding Loop
    WHILE i <= total_rows DO
        
        -- Insert a synthetic user profile
        INSERT INTO userinfo (name, email, password, dob, address, city, state_id, zip, account_type, closest_airport)
        VALUES (
            ELT(FLOOR(1 + RAND() * 5), 'Alice', 'Bob', 'Charlie', 'David', 'Eva'),
            CONCAT('user', i, '@example.com'),
            SHA2(CONCAT('password_secret_', i), 256), -- Simulating hashed passwords
            DATE_ADD('1970-01-01', INTERVAL FLOOR(RAND() * 18250) DAY), -- Random DOB over 50 years
            CONCAT(FLOOR(100 + RAND() * 8900), ' Main St'),
            ELT(FLOOR(1 + RAND() * 4), 'Tech City', 'Metroville', 'Gotham', 'Star City'),
            FLOOR(1 + RAND() * 50), -- Random state_id (1-50) for low-cardinality skewing
            LPAD(FLOOR(RAND() * 99999), 5, '0'),
            ELT(FLOOR(1 + RAND() * 3), 'standard', 'premium', 'trial'),
            ELT(FLOOR(1 + RAND() * 5), 'LAX', 'JFK', 'ORD', 'SFO', 'DXB')
        );

        -- 5. Batch Commit trigger
        IF MOD(i, batch_size) = 0 THEN
            COMMIT; -- Flush 10,000 records out of memory to disk
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Commit any remaining records if total_rows isn't perfectly divisible by batch_size
    COMMIT;

    -- 6. Re-enable safety checks after execution is complete
    SET FOREIGN_KEY_CHECKS = 1;
    SET UNIQUE_CHECKS = 1;
    SET AUTOCOMMIT = 1;

END$$

DELIMITER ;