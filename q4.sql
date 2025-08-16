USE streaming_lab2;

DELIMITER $$
DROP PROCEDURE IF EXISTS pr_send_watch_time_report $$
CREATE PROCEDURE pr_send_watch_time_report()
BEGIN
    DECLARE done_flag INT DEFAULT 0;
    DECLARE sid INT;

    -- collector table for combined output
    CREATE TEMPORARY TABLE IF NOT EXISTS report_collect (
        SubscriberID INT,
        SubscriberName VARCHAR(100),
        Title VARCHAR(100),
        WatchTime INT
    );
    TRUNCATE TABLE report_collect;

    DECLARE cur_watchers CURSOR FOR
        SELECT DISTINCT SubscriberID FROM WatchHistory ORDER BY SubscriberID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_flag = 1;

    OPEN cur_watchers;
    watcher_loop: LOOP
        FETCH cur_watchers INTO sid;
        IF done_flag THEN
            LEAVE watcher_loop;
        END IF;
        SELECT CONCAT('SubscriberID: ', sid) AS hdr;
        CALL pr_get_history_for_subscriber(sid);

        
        INSERT INTO report_collect (SubscriberID, SubscriberName, Title, WatchTime)
        SELECT s.SubscriberID, s.SubscriberName, sh.Title, wh.WatchTime
        FROM WatchHistory wh
        JOIN Subscribers s ON s.SubscriberID = wh.SubscriberID
        JOIN Shows sh ON sh.ShowID = wh.ShowID
        WHERE wh.SubscriberID = sid;
    END LOOP;
    CLOSE cur_watchers;
    SELECT * FROM report_collect ORDER BY SubscriberID, Title;

    DROP TEMPORARY TABLE IF EXISTS report_collect;
END $$
DELIMITER ;
CALL pr_send_watch_time_report();
