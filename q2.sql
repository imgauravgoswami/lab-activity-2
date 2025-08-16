USE streaming_lab2;

DELIMITER $$
DROP PROCEDURE IF EXISTS pr_get_history_for_subscriber $$
CREATE PROCEDURE pr_get_history_for_subscriber(IN subscriber_idx INT)
BEGIN
    SELECT sh.Title AS Show_Title,
           wh.WatchTime AS Minutes_Watched
    FROM WatchHistory wh
    INNER JOIN Shows sh ON wh.ShowID = sh.ShowID
    WHERE wh.SubscriberID = subscriber_idx
    ORDER BY sh.Title;
END $$
DELIMITER ;
CALL pr_get_history_for_subscriber(2);
