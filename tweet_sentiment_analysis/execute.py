# First install python twisted before running this script: 
# (Red Hat) sudo yum install python-twisted / (Ubuntu) sudo apt-get install python-twisted
# To run the SentimentAnalysis() function in HP Vertica and insert the analyzed data into the tweet_sentiment table,
# you need some kind of scheduler. One option is to use cron, however cron can only run a script once every minute at its
# max speed. To run SentimentAnalysis() and push the analyzed data into the tweet_sentiment table in an interval shorter than
# once a minute, use this script. This script runs the tweet_update.sh script every second.

#!/usr/bin/python

from twisted.internet import task
from twisted.internet import reactor

timeout = 1.0 # Every second

def tweetUpdate():
    import subprocess
    subprocess.call(['/home/dbadmin/tweet_update.sh'])
    pass

l = task.LoopingCall(tweetUpdate)
l.start(timeout) # Call every second

reactor.run()
