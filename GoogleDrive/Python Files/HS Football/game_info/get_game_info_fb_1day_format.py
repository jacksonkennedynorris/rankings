from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

year = '2019'

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/" + year + "/HTML") ## Open and traverses through each file
for subdir, dirs, files in os.walk(directory):
    for file in files:
        print file
        f = open(os.path.join(subdir,file), 'r')
        week_html = f.read()
        week_soup = BeautifulSoup(week_html, 'html.parser')
##        print week_soup
        year = week_soup.title.string.split(' ')[0] # grab year from title
##        print year
        week_num = file[-6:-4] # Grab Week Num for filename
##        print week_num, '\n'
        tables = week_soup.findAll('table', {"id": "winner_sort"}) # Grab HTML Tables
##        print table, '\n'
            
        days = []
        locations = []
        neutrals = []
        wTeams = []
        wTeams_ids = []
        wScores= []
        lTeams = []
        lTeams_ids = []
        lScores = []
        overtimes = []

        for i in range(len(tables)):
            days_temp = tables[i].findAll('td', {"class": "date_table_date"}) # grab days in specific week
            days_temp = [str(element.get_text()) for element in days_temp] #array of days in week

            locations_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab location of game
            locations_temp = [str(element.get_text())[:2] for element in locations_temp] # array of 'vs' & 'at'

            neutrals_temp = tables[i].findAll('td', {"class": "loser_team"}) # tags used to find neutral site games 
            neutrals_temp = [str(element.get_text()) for element in neutrals_temp]

            wTeams_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' names
            wTeams_temp = [str(element.get_text()) for element in wTeams_temp] # array of  winning teams

            wTeams_ids_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' ids
            
            wScores_temp = tables[i].findAll('td', {"class": "winner_score"}) # grab winning teams' scores
            wScores_temp = [str(element.get_text()) for element in wScores_temp] # array of winning scores

            lTeams_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names
            lTeams_temp = [str(element.get_text())[3:].split('(at')[0].lstrip().rstrip() for element in lTeams_temp] # array of losing teams

            lTeams_ids_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names

            lScores_temp = tables[i].findAll('td', {"class": "loser_score"}) # grab losing teams' scores
            lScores_temp = [str(element.get_text()) for element in lScores_temp] # array of losing scores

            overtimes_temp = tables[i].findAll('span', {"class": "nobr"}) # finds all span tags in table
            overtimes_temp = [str(element.get_text()) for element in overtimes_temp]
            
            for j in range(len(wTeams_temp)):
                days.append(days_temp[0])
                
                locations.append(locations_temp[j])
                neutrals.append(neutrals_temp[j])
                
                wTeams.append(wTeams_temp[j])
                
                val = str(wTeams_ids_temp[j]).split('"')[1]
                val = val[12:]
                wTeams_ids.append(val)
                
                wScores.append(wScores_temp[j])

                lTeams.append(lTeams_temp[j])

                val = str(lTeams_ids_temp[j]).split('"')[1]
                val = val[11:]
                lTeams_ids.append(val)
                
                lScores.append(lScores_temp[j])

                overtimes.append(overtimes_temp[j])

        for k in range(len(locations)): # changes 'vs' & 'at' to 'home' & 'away'
            if locations[k] == 'vs':
                locations[k] = 'home'
            else:
                locations[k] = 'away'
            if '(at ' in neutrals[k]:
                locations[k] = 'neutral'

        for l in range(len(overtimes)):
            if 'overtime' in str(overtimes[l]) or 'Overtime' in str(overtimes[l]):
                overtimes[l] = 1
            else:
                overtimes[l] = 0
                
##        print year
##        print week_num
##        print days       
##        print locations
##        print wTeams
##        print wTeams_ids
##        print wScores
##        print lTeams
##        print lTeams_ids
##        print lScores
##        print overtimes
##        print len(wTeams), len(wScores)

        f.close()

        # Write to file
        f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/game_info/game_info_%s' % file, 'w')
        f.write(year)
        f.write('\n')
        f.write(week_num)
        f.write('\n')
        for day in days:
            f.write("%s\t" % day)
        f.write('\n')
        for location in locations:
            f.write("%s\t" % location)
        f.write('\n')
        for team in wTeams:
            f.write("%s\t" % team)
        f.write('\n')
        for team in wTeams_ids:
            f.write("%s\t" % team)
        f.write('\n')
        for score in wScores:
            f.write("%s\t" % score)
        f.write('\n')
        for team in lTeams:
            f.write("%s\t" % team)
        f.write('\n')
        for team in lTeams_ids:
            f.write("%s\t" % team)
        f.write('\n')
        for score in lScores:
            f.write("%s\t" % score)
        f.write('\n')
        for overtime in overtimes:
            f.write("%s\t" % overtime)
        f.close()

            


                    
