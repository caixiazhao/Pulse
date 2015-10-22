/** Save the following SQL code in a .sql file somewhere on your local file system
* You set a python scheduler to run this code so that the dt_start and dt_end tables are dropped and recreated with 
* the correct information on which data has been analyzed
*/

-- First, create dt_start to hold information on tweets that have not been analyzed
CREATE TABLE dt_start AS (SELECT max(created_at) dt FROM tweets);

-- The dt_start and dt_end tables are used to keep track of which tweets have been analyzed and which are still in the "queue"
DROP TABLE IF EXISTS dt_end;
CREATE TABLE dt_end AS(SELECT max(created_at) dt FROM tweets);

-- Create a DML query to take the analzed data and insert it into the tweet_sentiment table
INSERT INTO tweet_sentiment(SELECT id, "user.screen_name", SentimentAnalysis(text USING PARAMETERS filterlinks = true, 
filterusermentions = true) OVER(PARTITION BY id, "user.screen_name", text) FROM tweets WHERE lang = 'en' 
AND tweets.created_at > (SELECT dt FROM dt_start) AND tweets.created_at <= (SELECT dt FROM dt_end) ORDER BY attribute);

-- Recreate dt_start with the new values from dt_end
DROP TABLE IF EXISTS dt_start;
CREATE TABLE dt_start AS (SELECT dt FROM dt_end);

-- Release the JVM memory pool
SELECT release_jvm_memory();

