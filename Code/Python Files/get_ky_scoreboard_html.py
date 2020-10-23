from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy

url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb19?id=wk'

#Sport
sport = 'football'

#Year
year = '2019'

#Season Start and End Weeks
start_week = 2589
end_week = 2599

#Folder
folder = sport + '/' + year

for week in range(start_week, end_week + 1):
    url = (url_pre + str(week))
    if 'kyfb' in url:
        req = urllib2.Request(url)
        req.add_header('User-agent', 'Mozilla 5.10')
        week_html = urllib2.urlopen(req)
        week_soup = BeautifulSoup(week_html, 'html.parser')
        filename = sport + "_" + year + "_" + str(week) + '.txt'
        print filename
        f = open('C:\Users\Will\Desktop\Summer Research 2019\kyfb_scores/' + year + '/%s' % filename, 'w')
        f.write(week_soup.title.string + '\n')
        f.write(str(week_soup))
        f.close()
