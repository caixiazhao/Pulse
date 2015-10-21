# First install python twisted before running this script: sudo yum install python-twisted
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
