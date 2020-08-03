from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy

year_nums = ['8','9','0','1','2','3','4','5','6','07','08','09','10','11','12','13','14','15','16','17','18']
url_nums = ['10','16','24','32','40','48','56','64','72','80','88','95','104','112','120','128','136','144','153','162','171']
file_nums = ['1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019']

url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kygbk'
url_post1 ='?id=tournament_'
url_post2 = '/tournament_'

for i in range(len(file_nums)-1): # number of years
    for j in range(1,65): # 64 districts
        if j < 10:
            num = '00' + str(j)
            filenum = '0' + str(j)
        else:
            num = '0' + str(j)
            filenum = str(j)
        if i < 2:
            url_post = url_post2
        else:
            url_post = url_post1
            
        year = file_nums[i] + '-' + file_nums[i+1]
        filename = 'district' + filenum + '.txt'
        print year, filename
        
        url = url_pre + year_nums[i] + url_post + url_nums[i] + num
##        print url
        
        req = urllib2.Request(url)
        req.add_header('User-agent', 'Mozilla 5.10')
        tourn_html = urllib2.urlopen(req)
        tourn_soup = BeautifulSoup(tourn_html, 'html.parser')
##        print tourn_soup, '\n'
        
        f = open("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html\Girls' Basketball/" + year + '/%s' % filename, 'w')
        f.write(str(tourn_soup))
        f.close()

