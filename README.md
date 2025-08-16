# lab-activity-2
SQL - Stored Procedures and Cursors
CS6.302 – Software System Development
Lab 2: SQL Stored Procedures and Cursors
Submission File: 2025204014_lab2.ZIP
Student Name: Gaurav Goswami
Roll Number: 2025204014
Submission Date: 16-08-2025

----------------------------------------------------
CONTENT DESCRIPTION
----------------------------------------------------
1. setup.sql
   - Builds the database `streaming_lab2`
   - Defines tables: Shows, Subscribers, WatchHistory
   - Loads sample records provided in the lab instructions

2. q1.sql
   - Procedure: pr_list_subscribers()
   - Demonstrates use of a cursor to go through every subscriber and display their names

3. q2.sql
   - Procedure: pr_get_history_for_subscriber(IN subscriber_idx INT)
   - Lists all shows watched by a given subscriber along with viewing duration

4. q3.sql
   - Procedure: pr_add_if_missing(IN new_name VARCHAR(100))
   - Inserts a new subscriber if they are not already present in the database

5. q4.sql
   - Procedure: pr_send_watch_time_report()
   - Generates a viewing report for all subscribers who have watched at least one show

6. q5.sql
   - Procedure: pr_print_everyone_history()
   - Iterates over all subscribers and shows their complete watch history

----------------------------------------------------
HOW TO RUN THE FILES
----------------------------------------------------
1. Start MySQL Workbench (or any MySQL client) and connect to your local server.

2. First run `setup.sql`:
   - This creates the database and tables and inserts the provided dataset.
   - Ensure the `USE streaming_lab2;` statement is active before running further scripts.

3. Open each question file (`q1.sql` to `q5.sql`) one by one and execute:
   - `q1.sql`: CALL pr_list_subscribers();
   - `q2.sql`: CALL pr_get_history_for_subscriber(1);
   - `q3.sql`: CALL pr_add_if_missing('Test Subscriber');
   - `q4.sql`: CALL pr_send_watch_time_report();
   - `q5.sql`: CALL pr_print_everyone_history();

4. Verify results after each call to confirm procedures are working.

5. Once testing is done, you can remove the database with:
   DROP DATABASE streaming_lab2;

END OF README

