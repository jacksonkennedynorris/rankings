from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy

url_nums = ['23','31','39','47','55','63','71','79','87','95','103','111','119','127','135','143','152','161','170']
year_nums = ['0','1','2','3','4','5','6','07','08','09','10','11','12','13','14','15','16','17','18']
file_nums = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19']

url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kybbk'
url_post ='?id=tournament_'

##for i in range(len(file_nums)-1): # number of years
##    for j in range(1,65): # 64 districts
##        if j < 10:
##            num = '00' + str(j)
##            filenum = '0' + str(j)
##        else:
##            num = '0' + str(j)
##            filenum = str(j)
##        url = url_pre + year_nums[i] + url_post + url_nums[i] + num
####        print url
##        req = urllib2.Request(url)
##        req.add_header('User-agent', 'Mozilla 5.10')
##        tourn_html = urllib2.urlopen(req)
##        tourn_soup = BeautifulSoup(tourn_html, 'html.parser')
####        print tourn_soup, '\n'
##        year = file_nums[i] + '-' + file_nums[i+1]
##        filename = 'district' + filenum + '.txt'
##        print 'gi_20' + year, filename
##        f = open("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html/Boys' Basketball/gi_20"' + year + '/%s' % filename, 'w')
##        f.write(str(tourn_soup))
##        f.close()

url_nums2 = ['1','11','15']
file_nums2 = ['97','98','99','00']

url_pre2 = 'https://scoreboard.12dt.com/scoreboard/khsaa/kybbk'
url_post2 = '/tournament_'

count = 1
              
for i in range(8,10):
    for j in range(1,65):
        if j < 10:
            num = '00' + str(j)
            filenum = '0' + str(j)
        else:
            num = '0' + str(j)
            filenum = str(j)
        url2 = url_pre2 + str(i) + url_post2 + url_nums2[count] + num
##        print url2
        req = urllib2.Request(url2)
        req.add_header('User-agent', 'Mozilla 5.10')
        tourn_html2 = urllib2.urlopen(req)
        tourn_soup2 = BeautifulSoup(tourn_html2, 'html.parser')
##        print tourn_soup2, '\n'
        year2 = file_nums2[count] + '-' + file_nums2[count+1]
        filename = 'district' + filenum + '.txt'
        print '19' + year2, filename
        f = open("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html/Boys' Basketball/gi_19" + year2 + '/%s' % filename, 'w')
        f.write(str(tourn_soup2))
        f.close()
    count +=1

##for i in range(7,8):
##    for j in range(2,65):
##        if j < 10:
##            num = '00' + str(j)
##            filenum = '0' + str(j)
##        else:
##            num = '0' + str(j)
##            filenum = str(j)
##        url2 = url_pre2 + str(i) + url_post2 + num
####        print url2
##        req = urllib2.Request(url2)
##        req.add_header('User-agent', 'Mozilla 5.10')
##        tourn_html2 = urllib2.urlopen(req)
##        tourn_soup2 = BeautifulSoup(tourn_html2, 'html.parser')
####        print tourn_soup2, '\n'
##        year2 = file_nums2[0] + '-' + file_nums2[1]
##        filename = 'district' + filenum + '.txt'
##        print '19' + year2, filename
##        f = open('C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html/gi_19' + year2 + '/%s' % filename, 'w')
##        f.write(str(tourn_soup2))
##        f.close()
