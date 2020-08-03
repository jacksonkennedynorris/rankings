from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

for i in range(2000,2019):
    if i > 2015:
        stadiums = {}
        directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb 2000-2018 ID_Conference_Stadium")
        for subdir, dirs, files in os.walk(directory):
            for file in files:
                 if file.startswith('cfb_' + str(i)):
##                     print file
                     f = open(os.path.join(subdir,file), 'r')
                     for line in f:
                         fields = line.split('\t')
                         stadiums[fields[0]] = fields[2].rstrip()
                     stadiums['Massachusetts'] = 'Warren McGuirk Alumni Stadium - Amherst Massachusetts'
##        print stadiums
                         
        weeks, wTeams, wScores, lTeams, lScores, locations = ( [] for i in range(6))         
        directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb_game_tables")
        for subdir, dirs, files in os.walk(directory):
            for file in files:
                 if file.startswith('FBS_games_' + str(i)):
                     print file
                     f = open(os.path.join(subdir,file), 'r')
                     f.readline()
                     for line in f:
##                         print line.rstrip()
                         fields = line.split(',')
                         if ') ' in fields[5]:
                             wTeam = fields[5].split(') ')[1]
                         else:
                             wTeam = fields[5]
                             
                         if ') ' in fields[8]:
                             lTeam = fields[8].split(') ')[1]
                         else:
                             lTeam = fields[8]

                         weeks.append(fields[1])
                         wTeams.append(wTeam)
                         wScores.append(fields[6])
                         lTeams.append(lTeam)
                         lScores.append(fields[9])
                         
                        # Location in terms of the winner
                         if fields[7] == '@':
                             locations.append('away')
                         else:
                             if fields[11].rstrip() == stadiums[wTeam]:
                                 locations.append('home')
                             else:
                                 locations.append('neutral')
    else:
        weeks, wTeams, wScores, lTeams, lScores, locations = ( [] for i in range(6))         
        directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb_game_tables")
        for subdir, dirs, files in os.walk(directory):
            for file in files:
                 if file.startswith('FBS_games_' + str(i)):
                     print file
                     f = open(os.path.join(subdir,file), 'r')
                     f.readline()
                     for line in f:
##                         print line.rstrip()
                         fields = line.split(',')
                         if i == 2013:
                             week = fields[1]
                             wTeam = fields[5]
                             wScore = fields[6]
                             vs = fields[7]
                             lTeam = fields[8]
                             lScore = fields[9]
                             notes = fields[10]
                         if i > 2013:
                             week = fields[1]
                             wTeam = fields[5]
                             wScore = fields[6]
                             vs = fields[7]
                             lTeam = fields[8]
                             lScore = fields[9]
                             notes = fields[11]
                         if i < 2013:
                             week = fields[1]
                             wTeam = fields[4]
                             wScore = fields[5]
                             vs = fields[6]
                             lTeam = fields[7]
                             lScore = fields[8]
                             notes = fields[9]
                             
                         if 'Cancelled' in notes:
                             continue
                            
                         if ') ' in wTeam:
                             wTeam = wTeam.split(') ')[1]
##                         else:
##                             wTeam = fields[5]
                             
                         if ') ' in lTeam:
                             lTeam = lTeam.split(') ')[1]
##                         else:
##                             lTeam = fields[8]

                         weeks.append(week)
                         wTeams.append(wTeam)
                         wScores.append(wScore)
                         lTeams.append(lTeam)
                         lScores.append(lScore)

                         # Location in terms of the winner
                         if vs == '@':
                             locations.append('away')
                         else:
                             if notes.rstrip() != '':
                                 locations.append('neutral')
                             else:
                                 locations.append('home')                                   
    # Write to file
    f = open("C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/" + str(i) + '\game_info_%s' % str(i) + '.txt', 'w')
    f.write(str(i)) # year
    f.write('\n')
    for week in weeks:
        f.write("%s\t" % week)
    f.write('\n')
    for location in locations:
        f.write("%s\t" % location)
    f.write('\n')
    for team in wTeams:
        f.write("%s\t" % team)
    f.write('\n')
    for score in wScores:
        f.write("%s\t" % score)
    f.write('\n')
    for team in lTeams:
        f.write("%s\t" % team)
    f.write('\n')
    for score in lScores:
        f.write("%s\t" % score)
    f.close()
                 
                         
