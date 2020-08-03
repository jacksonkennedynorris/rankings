from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

#Year
year = '2019'

#Sport
sport = 'football'

# General URL text in every week
url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb19/?id='

# HTML Team Ids
html_ids = ['81696','81578','81581','81550','81548','81584']

# Get Class Rankings HTML
for id in html_ids:
    url = url_pre + id 
    req = urllib2.Request(url) 
    req.add_header('User-agent', 'Mozilla 5.10')
    class_html = urllib2.urlopen(req)
    class_soup = BeautifulSoup(class_html, 'html.parser')
    filename = sport + "_" + year + "_class" + str(html_ids.index(id) + 1) + '.txt'
    print filename
    # Write to File
    f = open('C:\Users\Will\Desktop\Summer Research 2019\kyfb_class_tables/' + year + '/%s' % filename, 'w')
    f.write(class_soup.title.string + '\n')
    f.write(str(class_soup))
    f.close()
