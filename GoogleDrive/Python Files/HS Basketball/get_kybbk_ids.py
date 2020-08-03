from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

file_nums = ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19']
team_ids = {} # dictionary of teams and their IDs
team_districts = {} # dictionary of teams and their districts
team_regions = {} # dictionary of teams and their regions

for i in range(len(file_nums)-1):
    team_districts = {}
    team_regions = {}
    region = 0
    print '20' + file_nums[i] + '-' + file_nums[i+1]
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html\Boys' Basketball\gi_20" + file_nums[i] + '-' + file_nums[i+1])
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
    f = open('C:\Users\Will\Desktop\Summer Research 2019\kybbk 1998-2019 ID_region_district/kybbk_20' + file_nums[i] + '-' + file_nums[i+1] + '_IDs_Region_District.txt', 'w')
    for element in sorted(team_districts.keys()):
        f.write(element + '\t' +  str(team_ids[element] + '\t' +  str(team_regions[element]) + '\t' + str(team_districts[element]) + '\n'))
    f.close()

## Pre-200s ##

file_nums2 = ['97','98','99','00']
team_ids2 = {} # dictionary of teams and their ids
team_distsrict2 = {} # dictionary of teams and their districts
team_regions2 = {} # dictionary of teams and their regions

for i in range(1, len(file_nums2)-1):
    team_ids2 = {}
    team_districts2 = {}
    team_regions2 = {}
    region2 = 0
    print '19' + file_nums2[i] + '-' + file_nums2[i+1]
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html\Boys' Basketball\gi_19" + file_nums2[i] + '-' + file_nums2[i+1])
    for subdir, dirs, files in os.walk(directory):
        count = 1       
        for file in files:
            if file.endswith('.txt'):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                tourn_html2 = f.read()
                tourn_soup2 = BeautifulSoup(tourn_html2, 'html.parser')
                
                table2 = tourn_soup2.find('table', {"class": "bracket_table"})
    ##            print table

                font_tags2 = table2.findAll('font', {'face': 'arial,helvetica'})
##                print font_tags2
                
                teams2 = []
                for tag in font_tags2:
                    if tag.find('a') != None:
                        teams2.append(tag.find('a'))
                id_tags2 = [str(element.get('href')).split('/')[-1] for element in teams2]
                teams2 = [str(element.get_text()) for element in teams2]
##                print teams2
##                print id_tags2

                district2 = [] # list of teams in district
                district_ids2 = [] # list of teams in district's IDs
                
                for team in teams2:
                    if team not in district2:
                        district2.append(team)
##                print 'District: ', district2, len(district2)

                for tag in id_tags2:
                    if tag not in district_ids2:
                        district_ids2.append(tag)
##                print district_ids2, len(district_ids2)

                if ((count-1) % 4) == 0:
                    region2 += 1

                for team in district2:
                    team_ids2[team] = district_ids2[district2.index(team)]
##                print team_ids2

                for team in district2:
                    team_regions2[team] = region2

                for team in district2:
                    team_districts2[team] = count
                count +=1
                f.close()

    f = open('C:\Users\Will\Desktop\Summer Research 2019\kybbk 1998-2019 ID_region_district/kybbk_19' + file_nums2[i] + '-' + file_nums2[i+1] + '_IDs_Region_District.txt', 'w')
    for element in sorted(team_districts2.keys()):
        f.write(element + '\t' +  str(team_ids2[element] + '\t' +  str(team_regions2[element]) + '\t' +  str(team_districts2[element]) + '\n'))
    f.close()
    
##team_ids3 = {}
##print '19' + file_nums2[0] + '-' + file_nums2[1]
##directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\district_tourn_html\Boys' Basketball\gi_19" + file_nums2[0] + '-' + file_nums2[1])
##for subdir, dirs, files in os.walk(directory):
##    count = 2       
##    for file in files:
##        if file.endswith('.txt'):
##            print file
##            f = open(os.path.join(subdir,file), 'r')
##            tourn_html3 = f.read()
##            tourn_soup3 = BeautifulSoup(tourn_html2, 'html.parser')
##            
##            table3 = tourn_soup3.find('table', {"class": "bracket_table"})
####            print table
##
##            font_tags3 = table3.findAll('font', {'face': 'arial,helvetica'})
##            teams3 = []
##            for tag in font_tags3:
##                if tag.find('a') != None:
##                    teams3.append(tag.find('a'))
##            teams3 = [element.get_text() for element in teams3]
##
##            district3 = []
##            for team in teams3:
##                if team not in district3:
##                    district3.append(str(team))
####                print 'District: ', district2,
####                print len(district2), '\n'
##
##            for team in district3:
##                team_ids3[team] = count
##            count +=1
##
##            f.close()
##            
####    print len(team_ids3)
####    for team in sorted(team_ids3.keys()):
####        print team, team_ids3[team]
##
##    f = open('C:\Users\Will\Desktop\Summer Research 2019\kybbk 1998-2019 ID_region_district/kybbk_19' + file_nums2[0] + '-' + file_nums2[1] + '_IDs_Region_District.txt', 'w')
##    for element in sorted(team_ids3.keys()):
##        f.write(element + '\t' + str(team_ids3[element]) + '\n')
##    f.close()


    





