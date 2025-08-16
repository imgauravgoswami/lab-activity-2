USE streaming_lab2;

DELIMITER $$
DROP PROCEDURE IF EXISTS pr_list_subscribers $$
CREATE PROCEDURE pr_list_subscribers()
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE name_buf VARCHAR(100);
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_names (name VARCHAR(100));
    TRUNCATE TABLE temp_names;

    DECLARE cur_sub CURSOR FOR SELECT SubscriberName FROM Subscribers ORDER BY SubscriberID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cur_sub;
    read_loop: LOOP
        FETCH cur_sub INTO name_buf;
        IF finished THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO temp_names VALUES (name_buf);
    END LOOP;
    CLOSE cur_sub;

    SELECT * FROM temp_names;
    DROP TEMPORARY TABLE IF EXISTS temp_names;
END $$
DELIMITER ;

CALL pr_list_subscribers();
