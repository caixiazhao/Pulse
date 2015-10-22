HP Vertica Pulse
=====
Copyright 2015 - HP Vertica - Hewlett-Packard Development Company, L.P. The information contained herein is subject to change without notice. HP shall not be liable for technical or editorial errors or omissions contained herein.


Contributing
-------------

IMPORTANT: If you wish to contribute anything to this repository, in order for us to accept your pull request you MUST sign and send a copy of the appropriate Contributor License Agreement to Vertica (contribs@vertica.com):

* license/PersonalCLA.pdf: If you are contributing for yourself
* license/CorporateCLA.pdf: If you are contributing on behalf of your company


Overview
---------

HP Vertica Pulse provides a suite of functions that allow you to analyze and extract the sentiment from English and Spanish language text directly from your HP Vertica database.

This example uses Tableau Desktop for data visualization.

Requirements
-------------

* HP Vertica 7.2.x
* HP Vertica Pulse 7.2.x
* Haven Social Media Connector Package

Building the Example
--------------------

1. Download and install HP Vertica 7.2.x and HP Vertica Pulse 7.2.x

    For detailed installation instructions see:
    * http://my.vertica.com/docs/7.2.x/HTML/index.htm#Authoring/InstallationGuide/Other/InstallationGuide.htm
    * https://my.vertica.com/docs/7.2.x/HTML/index.htm#Authoring/Pulse/InstallingPulseOverview.htm

2. Download and install the Haven Social Media Connector Package (under ETL and Data Ingest) and the HP Vertica QuickStart for Tableau (under BI and Visualization) to get a pre-made HP Vertica Tableau template

    * https://haven.hpwsportal.com/catalog.html#/Home/Show

3. Create a developer Twitter account at dev.twitter.com and create a Twitter app for your data

4. Download a trial version of Tableau Desktop at http://www.tableau.com/products/trial

5. Follow the accompanying SQL and python scripts as well as other files to guide you through the example

6. Output the data collected in your tweet_sentiment table to Tableau Desktop for analysis and visualization
