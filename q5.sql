USE streaming_lab2;

DELIMITER $$
DROP PROCEDURE IF EXISTS pr_print_everyone_history $$
CREATE PROCEDURE pr_print_everyone_history()
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE sid INT;
    DECLARE sname VARCHAR(100);

    CREATE TEMPORARY TABLE IF NOT EXISTS full_history (
        SubscriberID INT,
        SubscriberName VARCHAR(100),
        Title VARCHAR(100),
        WatchTime INT
    );
    TRUNCATE TABLE full_history;

    DECLARE cur_all CURSOR FOR
        SELECT SubscriberID, SubscriberName FROM Subscribers ORDER BY SubscriberID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cur_all;
    outer_loop: LOOP
        FETCH cur_all INTO sid, sname;
        IF finished THEN
            LEAVE outer_loop;
        END IF;

        
        SELECT CONCAT('History for: ', sname, ' (ID=', sid, ')') AS header_row;
        CALL pr_get_history_for_subscriber(sid);

       
        INSERT INTO full_history (SubscriberID, SubscriberName, Title, WatchTime)
        SELECT s.SubscriberID, s.SubscriberName, sh.Title, wh.WatchTime
        FROM Subscribers s
        LEFT JOIN WatchHistory wh ON s.SubscriberID = wh.SubscriberID
        LEFT JOIN Shows sh ON wh.ShowID = sh.ShowID
        WHERE s.SubscriberID = sid;
    END LOOP;
    CLOSE cur_all;

   
    SELECT * FROM full_history ORDER BY SubscriberID, Title;

    DROP TEMPORARY TABLE IF EXISTS full_history;
END $$
DELIMITER ;
CALL pr_print_everyone_history();
