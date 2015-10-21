/*****************************
 * HP Vertica Analytics Platform
 * Copyright (c) 2005 - 2015 Vertica, an HP company
 *****************************/

/**
 * DESCRIPTION
 *
 * This file contains a series of SQL commands that demonstrate
 * the use of HP Vertica Place.
 *
 * This example demonstrates how to configure and use HP Vertica and HP Vertica Pulse to pull in
 * data from Twitter related to European soccer games. Using the HP Social Media Connector, you can
 * extract data from tweets and enter that data into a table in HP Vertica. Then, using HP Vertica Pulse,
 * you run sentiment analysis on the Twitter data to obtain an attribute sentiment score. Ultimately,
 * the sentiment-analyzed data is output to a BI tool so that you can visualize the positive and
 * negative tweets about teams and players in real-time.
 *
 * The goal is to get a comprehensive visualization of who is talking about European soccer, 
 * what specifically are they tweeting about, where the user is in the world, and whether what's
 * being said is positive, negative, or neutral.
 *
 * You need to first install HP Vertica and HP Vertica Pulse before running
 * the commands in this file.
 *
*/

-- Create a tweets table to hold the parsed Twitter data from TweetParser.cpp
CREATE TABLE tweets(id int, created_at TIMESTAMPTZ, "user.name" VARCHAR(144), "user.screen_name" VARCHAR(144), "user.followers_count" INT, text VARCHAR(500), "retweeted_status.retweet_count" INT, "retweeted_status.id" INT, "retweeted_status.favorite_count" INT, "retweeted_status.text" VARCHAR(500), "user.location" VARCHAR(144), "coordinates.coordinates.0" FLOAT, "coordinates.coordinates.1" FLOAT, "entities.hashtags.0.text" VARCHAR(144), "entities.hashtags.1.text" VARCHAR(144), lang VARCHAR(5));

-- Create a tweet sentiment table to hold the sentiment scores for the analyzed tweets
CREATE TABLE tweet_sentiment AS(SELECT id, "user.screen_name", SentimentAnalysis(text USING PARAMETERS filterlinks = true, filterusermentions = true) OVER(PARTITION BY id, "user.screen_name", text) FROM tweets WHERE lang = 'en' ORDER BY attribute);

-- Create a DML query to take the analyzed data and insert it into the tweet sentiment table. This query should be saved as a .sql file somewhere on your local file system
INSERT INTO tweet_sentiment(SELECT id, "user.screen_name", SentimentAnalysis(text USING PARAMETERS filterlinks = true, filterusermentions = true) OVER(PARTITION BY id, "user.screen_name", text) FROM tweets WHERE lang = 'en' AND      tweets.created_at > (SELECT dt FROM dt_start) AND tweets.created_at <= (SELECT dt FROM dt_end) ORDER BY attribute);

-- The dt_start and dt_end tables are used to keep track of which tweets have been analyzed and which are still in the "queue"
CREATE TABLE dt_start AS (SELECT max(created_at) dt FROM tweets);
DROP TABLE IF EXISTS dt_end;
CREATE TABLE dt_end AS(SELECT max(created_at) dt FROM tweets);
DROP TABLE IF EXISTS dt_start;
CREATE TABLE dt_start AS (SELECT dt FROM dt_end);

-- Release the JVM memory pool
SELECT release_jvm_memory();
