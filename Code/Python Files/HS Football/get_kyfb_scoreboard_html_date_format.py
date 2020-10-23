from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import datetime
from datetime import timedelta, date

#Sport
sport = 'Football'

#Year
year = '2019'

# General URL text in every week
url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb19?id='

#Folder
folder = sport + '/' + year

#Season Start and End Dates
start_date = datetime.date(2019,8,23)
end_date = datetime.date(2019,11,22)
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
        week_num = date.isocalendar()[1] - start_date.isocalendar()[1] + 1 # Number week in a season
##        print 'URL: ', url
##        print 'Date: ', date
##        print 'Week #: ', week_num
        if week_num < 10:
            week_num = '0' + str(week_num)
        
        filename = sport + "_" + year + "_" + str(week_num) + '.txt'
        print filename
        f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/HTML/' + '/%s' % filename, 'a')                                            
        f.write(day_soup.title.string + '\n')
        f.write(str(day_soup))
        f.close()



        
