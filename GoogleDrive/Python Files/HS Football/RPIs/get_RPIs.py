from bs4 import BeautifulSoup
import StringIO
import re
import copy
import os

year = '2019'
teams = []
teamIds = []

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\Team Tags\Football")
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if year in file:
            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f:
                fields = line.split('\t')
                team = fields[0]
                teamId = fields[1]
##                aClass = fields[2]
##                district = fields[3]

                if team not in teams:
                    teams.append(copy.deepcopy(team))
                if teamId not in  teamIds:
                    teamIds.append(copy.deepcopy(teamId))

            keys = {} # dictionary of Team Ids
            for i in range(len(teams)):
                keys[teams[i]] = teamIds[i]
            f.close()
print len(keys)

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\kyfb_class_tables") ## Open and traverses through each file
for subdir, dirs, files in os.walk(directory):
    for file in files:
        print file
        f = open(os.path.join(subdir,file), 'r')
        class_html = f.read()
        class_soup = BeautifulSoup(class_html, 'html.parser')
##        print class_soup

        table = class_soup.find('table', {"id": "win_loss_table"}) #Table HTML
##        print table

        teams = table.findAll('td',{'class':'wl-school'})
        teams = [str(element.get_text()) for element in teams]
##        print teams

        RPIs = table.findAll('td',{'class':'wl_rpi'})
        RPIs = [str(element.get_text()) for element in RPIs]
##        print RPIs

        for i in range(len(teams)):
            keys[teams[i]]= RPIs[i]

# Write to file
f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/RPIs/RPIs_%s.txt' % year, 'w')
for key in sorted(keys):
    f.write(key)
    f.write('\t')
    f.write(keys[key])
    f.write('\n')
f.close()
