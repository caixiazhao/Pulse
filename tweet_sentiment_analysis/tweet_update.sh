# Save this bash script in a directory where it can access the tweet_update.sql file
# Replace "dbadmin", "password", and "databasename" with the correct values for your environment

/opt/vertica/bin/vsql -U dbadmin -w password -d databasename -f /home/dbadmin/tweet_update.sql > tweet_update.log

# Once this bash script is saved, make it executable by running chmod +x tweet_update.sh
# Next, go on to the execute.py script and install python twisted to run a scheduler for this bash script
