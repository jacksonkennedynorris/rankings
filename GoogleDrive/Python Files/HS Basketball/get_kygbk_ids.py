from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

file_nums = ['1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019']
team_ids = {} # dictionary of teams and their IDs
team_districts = {} # dictionary of teams and their districts
team_regions = {} # dictionary of teams and their regions

for i in range(len(file_nums)-1):
    team_districts = {}
    team_regions = {}
    region = 0
    print file_nums[i] + '-' + file_nums[i+1]
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html\Girls' Basketball/" + file_nums[i] + '-' + file_nums[i+1])
    for subdir, dirs, files in os.walk(directory):
        count = 1        
        for file in files:
            if file.endswith('.txt'):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                tourn_html = f.read()
                tourn_soup = BeautifulSoup(tourn_html, 'html.parser')

                table = tourn_soup.find('table', {"class": "bracket_table"})
##                print table

                font_tags = table.findAll('font', {'face': 'arial,helvetica'})
##                print font_tags
                teams = []
                for tag in font_tags:
                    if tag.find('a') != None:
                        teams.append(tag.find('a'))
                id_tags = [str(element.get('href')).split('/')[-1] for element in teams]
                teams = [element.get_text() for element in teams]

                district = [] # list of teams in district
                district_ids = [] # list of teams in district's IDs
                
                for team in teams:
                    if team not in district:
                        district.append(str(team))
##                print 'District: ', district, len(district)

                for tag in id_tags:
                    if tag not in district_ids:
                        district_ids.append(tag)
##                print district_ids, len(district_ids)

                if ((count-1) % 4) == 0: # update region 
                    region += 1
                
                # assign team's IDs, regions, and districts
                for team in district:
                    team_ids[team] = district_ids[district.index(team)]

                for team in district:
                    team_regions[team] = region

                for team in district:
                    team_districts[team] = count
                count +=1

                f.close()
    f = open('C:\Users\Will\Desktop\Summer Research 2019\kygbk 1998-2019 ID_region_district/kygbk_' + file_nums[i] + '-' + file_nums[i+1] + '_IDs_Region_District.txt', 'w')
    for element in sorted(team_districts.keys()):
        f.write(element + '\t' +  str(team_ids[element] + '\t' +  str(team_regions[element]) + '\t' + str(team_districts[element]) + '\n'))
    f.close()

