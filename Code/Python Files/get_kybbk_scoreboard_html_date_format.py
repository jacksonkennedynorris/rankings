from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import datetime
from datetime import timedelta, date

#Sport
sport = 'basketball'

#Year
year = '2019-20'

# General URL text in every week
url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kybbk19?id='

#Folder
folder = sport + '/' + year

#Season Start and End Dates
start_date = datetime.date(2019,12,2)
end_date = datetime.date(2020,2,22)
season_length = end_date - start_date

for i in range(season_length.days + 1): # get all calendar dates of the season
    date = start_date + datetime.timedelta(days=i) # Calendar Date (YYYY-MM-DD)
    url = url_pre + str(date) # URL of gameday scoreboard webpage
    req = urllib2.Request(url) 
    req.add_header('User-agent', 'Mozilla 5.10')
    day_html = urllib2.urlopen(req) # Scoreboard Webapage HTML
    day_soup = BeautifulSoup(day_html, 'html.parser')
    table = day_soup.find('table', {"id": "winner_sort"}) # Table HTML
    row_count = len(table.find_all('tr')) # Number of rows in table
    if row_count > 0:
        day = table.find_all('tr')[0].text # Header Row
##        print 'URL: ', url
##        print 'Date: ', date        
        filename = sport + "_" + year + "_" + str(date) + '.txt'
        print filename
        f = open('C:\Users\Will\Desktop\Summer Research 2019\kybbk_scores/' + year + '/%s' % filename, 'a')
        f.write(day_soup.title.string + '\n')
        f.write(str(day_soup))
        f.close()

