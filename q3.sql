USE streaming_lab2;

DELIMITER $$
DROP PROCEDURE IF EXISTS pr_add_if_missing $$
CREATE PROCEDURE pr_add_if_missing(IN new_name VARCHAR(100))
BEGIN
    DECLARE exists_count INT DEFAULT 0;

    SELECT COUNT(*) INTO exists_count
    FROM Subscribers
    WHERE SubscriberName = new_name;

    IF exists_count = 0 THEN
        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        SELECT COALESCE(MAX(SubscriberID), 0) + 1, new_name, CURDATE()
        FROM Subscribers;
        SELECT CONCAT('Inserted: ', new_name) AS result_note;
    ELSE
        SELECT CONCAT('Already present: ', new_name) AS result_note;
    END IF;
END $$
DELIMITER ;
CALL pr_add_if_missing('Aarav Patel');
SELECT * FROM Subscribers ORDER BY SubscriberID;
