from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

year = '2019'

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\kyfb_scores") ## Open and traverses through each file
for subdir, dirs, files in os.walk(directory):
    for file in files:
##        print file
        if file.endswith('.txt') and file.startswith('football_' + year):
            print file
            f = open(os.path.join(subdir,file), 'r')
            week_html = f.read()
            week_soup = BeautifulSoup(week_html, 'html.parser')
##            print week_soup

            year = week_soup.title.string.split(' ')[0] # grab year from title
##            print year
            
            week = file.split('_')[2].split('.txt')[0] # grab week code from filename
##            print week

            subtitle = week_soup.find('div', {"class": "subtitle"}).get_text()
            subtitle = subtitle[26:]
            subtitle = subtitle.split(' to')[0]
##            print subtitle

            table = week_soup.find('table', {"id": "winner_sort"})
##            print table

            days_temp = table.findAll('td', {"class": "date_table_date"}) # grab days in specific week
            days_temp = [str(element.get_text()) for element in days_temp] #array of days in week
##            print days_temp

            locations = table.findAll('td', {"class": "loser_team"}) # grab location of game
            locations = [str(element.get_text())[:2] for element in locations] # array of 'vs' & 'at'
##            print locations

            neutrals = table.findAll('td', {"class": "loser_team"}) # tags used to find neutral site games 
            neutrals = [str(element.get_text()) for element in neutrals]
##            print neutrals
            
            for i in range(len(locations)): # changes 'vs' & 'at' to 'home' & 'away'
                if locations[i] == 'vs':
                    locations[i] = 'home'
                else:
                    locations[i] = 'away'
                if '(at ' in neutrals[i]:
                    locations[i] = 'neutral'
##            print locations            

            wTeams = table.findAll('td', {"class": "winner_team"}) # grab winning teams' names
            wTeams = [str(element.get_text()) for element in wTeams] # array of  winning teams
##            print wTeams
            
            wTeams_ids = []
            wTeams_id = table.findAll('td', {"class": "winner_team"}) # grab winning teams' ids
            for i in wTeams_id:
                i = str(i).split('"')[1]
                i = i[12:]
                wTeams_ids.append(i)
##            print wTeams_ids

            wScores = table.findAll('td', {"class": "winner_score"}) # grab winning teams' scores
            wScores = [str(element.get_text()) for element in wScores] # array of winning scores
##            print wScores

            lTeams = table.findAll('td', {"class": "loser_team"}) # grab losing teams' names
            lTeams = [str(element.get_text())[3:].split('(at')[0].lstrip().rstrip() for element in lTeams] # array of losing teams
##            print lTeams

            lScores = table.findAll('td', {"class": "loser_score"}) # grab losing teams' scores
            lScores = [str(element.get_text()) for element in lScores] # array of losing scores
##            print lScores

            lTeams_ids = []
            lTeams_id = table.findAll('td', {"class": "loser_team"}) # grab winning teams' ids
            for i in lTeams_id:
                i = str(i).split('"')[1]
                i = i[11:]#.rstrip('\n')
                lTeams_ids.append(i)
##            print lTeams_ids           
        
            day_tags = table.findAll('td', {'class': re.compile('date_table_date')}) # list of a td tags with dates for week
##            print day_tags

            open_matchW = []
            open_matchL = []

            for i in range(1,len(days_temp)): # find first matchups on each day
                day_tag = day_tags[i]
                day = day_tags[i].text
                wTeam = str(day_tag.findNext('td').text)
                lTeam = str(day_tag.findNext('td').findNext('td').findNext('td').text)[3:].lstrip().rstrip().split('(at')[0].rstrip()
##                print day, wTeam, lTeam
                open_matchW.append(wTeam)
                open_matchL.append(lTeam)

            count = 0 # index of number matchup in list
            days = [] # array of days of every game
            day_count = 0 # index of start matchup to compare
            num = 0 # index of day to append
            
            for team in wTeams:  # array of days of every game
                if len(days_temp) == 1:
                    days.append(days_temp[num])
                else:
                    if (team == open_matchW[day_count] and lTeams[count] == open_matchL[day_count]):
                        day_count += 1
                        num +=1
                    if day_count >= len(open_matchW):
                        day_count = len(open_matchW) - 1
                    days.append(days_temp[num])
                    count +=1
##            print days
                    
            overtimes = table.findAll('span', {"class": "nobr"}) # finds all span tags in table
            overtimes = [str(element.get_text()) for element in overtimes]
##            print overtimes
            
            for i in range(len(overtimes)):
                if 'overtime' in str(overtimes[i]) or 'Overtime' in str(overtimes[i]):
                    overtimes[i] = 1
                else:
                    overtimes[i] = 0
##            print overtimes
                    
            # Duplicate Free Arrays
            locations2 = []
            days2 = []
            wTeams2 = []
            lTeams2 = []
            wScores2 = []
            lScores2 = []
            wTeams_ids2 = []
            lTeams_ids2 = []
            overtimes2 = []

            # Remove Duplicates
            for i in range(len(wTeams)):
                if subtitle not in days[i] and wTeams[i] != 'Open' and wScores[i] != '-':
                    locations2.append(locations[i])
                    days2.append(days[i])
                    wTeams2.append(wTeams[i])
                    lTeams2.append(lTeams[i])
                    wScores2.append(wScores[i])
                    lScores2.append(lScores[i])
                    wTeams_ids2.append(wTeams_ids[i])
                    lTeams_ids2.append(lTeams_ids[i])
                    overtimes2.append(overtimes[i])            

            f.close()

            # Write to file
            f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_' + year + '/game_infos/game_info_%s' % file, 'w')
            f.write(year)
            f.write('\n')
            f.write(week)
            f.write('\n')
            for day in days2:
                f.write("%s\t" % day)
            f.write('\n')
            for location in locations2:
                f.write("%s\t" % location)
            f.write('\n')
            for team in wTeams2:
                f.write("%s\t" % team)
            f.write('\n')
            for team in wTeams_ids2:
                f.write("%s\t" % team)
            f.write('\n')
            for score in wScores2:
                f.write("%s\t" % score)
            f.write('\n')
            for team in lTeams2:
                f.write("%s\t" % team)
            f.write('\n')
            for team in lTeams_ids2:
                f.write("%s\t" % team)
            f.write('\n')
            for score in lScores2:
                f.write("%s\t" % score)
            f.write('\n')
            for overtime in overtimes2:
                f.write("%s\t" % overtime)
            f.close()
            
