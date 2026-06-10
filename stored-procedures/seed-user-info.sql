DELIMITER $$
DROP PROCEDURE IF EXISTS CreateAndSeedUserInfo $$
CREATE PROCEDURE CreateAndSeedUserInfo()
BEGIN
DECLARE I INT DEFAULT 1;
DECLARE max_rows INT DEFAULT 5000000;
DECLARE batch_size INT DEFAULT 10000;
SET @drop_query = "DROP TABLE IF EXIST userinfo;";
PREPARE stmt_drop FROM @drop_query;
EXECUTE stmt_drop;

SET @create_query = "
    CREATE TABLE userinfo (
        id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
        name            VARCHAR(64) NOT NULL DEFAULT '',
        email           VARCHAR(64) NOT NULL DEFAULT '',
        password        VARCHAR(64) NOT NULL DEFAULT '',
        dob             DATE DEFAULT NULL,
        address         VARCHAR(255) NOT NULL DEFAULT '',
        city            VARCHAR(64) NOT NULL DEFAULT '',
        state_id        SMALLINT UNSIGNED NOT NULL DEFAULT '0',
        zip             VARCHAR(8) NOT NULL DEFAULT '',
        country_id      SMALLINT UNSIGNED NOT NULL DEFAULT '0',
        account_type    VARCHAR(32) NOT NULL DEFAULT '',
        closest_airport VARCHAR(3) NOT NULL DEFAULT '',
        PRIMARY KEY (id)
    );";
    
    PREPARE stmt_create FROM @create_query;
    EXECUTE stmt_create;
    DEALLOCATE PREPARE stmt_create;
SET AUTOCOMMIT = 0;
SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;
WHILE I < max_rows DO 
INSERT INTO userinfo (
            name, email, password, dob, address, city, 
            state_id, zip, country_id, account_type, closest_airport
        ) VALUES (
            CONCAT('User_', i),
            CONCAT('user', i, '@example.com'),
            SHA2(CONCAT('pass_', i), 256), 
            DATE_ADD('1970-01-01', INTERVAL FLOOR(RAND() * 18000) DAY), 
            CONCAT(FLOOR(RAND() * 9999), ' Main St'),
            'Tech City',
            FLOOR(1 + RAND() * 50), 
            LPAD(FLOOR(RAND() * 99999), 5, '0'),
            FLOOR(1 + RAND() * 200), 
            IF(RAND() > 0.5, 'premium', 'standard'),
            ELT(FLOOR(1 + RAND() * 5), 'JFK', 'LAX', 'ORD', 'DXB', 'LHR')
        );
        
	IF mod(i,batch_size) = 0 THEN 
    COMMIT ;
END IF;
SET I = I+1;
END WHILE;
COMMIT;
SET AUTOCOMMIT = 1;
    SET FOREIGN_KEY_CHECKS = 1;
    SET UNIQUE_CHECKS = 1;
END$$

DELIMITER ;