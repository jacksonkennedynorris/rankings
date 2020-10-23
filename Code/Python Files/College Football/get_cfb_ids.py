from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

for i in range(2000,2019):
    keys = {} # Dictionary of teams and their conferences
    name_subs = {'LSU':'Louisiana State','Ole Miss':'Mississippi','Pitt':'Pittsburgh','SMU':'Southern Methodist','UAB':'Alabama-Birmingham','UCF':'Central Florida',
                 'USC':'Southern California', 'UTEP':'Texas-El Paso', 'UTSA':'Texas-San Antonio'}

    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb_game_tables") # Find All Teams in FBS
    for subdir, dirs, files in os.walk(directory):
        for file in files:
             if file.startswith('FBS_teams_' + str(i)):
                 print file
                 f = open(os.path.join(subdir,file), 'r')
                 f.readline()
                 f.readline()
                 for line in f:
                     fields = line.split(',')
                     team = fields[1]
                     conf = fields[2].split(' (')[0]
                     if team in name_subs:
                         team = name_subs[team]
                     keys[team] = conf
                 f.close()

    print '# of FBS Teams: ', len(keys)                 
##    for element in sorted(keys):
##        print 'School:', element, ' Conference:', keys[element]

    if i > 2015:

        stadiums = {} # Dictionary of teams and their stadiums

        directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb_game_tables") # Find teams who lost at least once at home and their stadiums
        for subdir, dirs, files in os.walk(directory):
            for file in files:
                 if file.startswith('FBS_games_' + str(i)):
##                     print file
                     f = open(os.path.join(subdir,file), 'r')
                     f.readline()
                     for line in f:
                         fields = line.split(',')
                         if fields[7] == '@':
                             lTeam = fields[8]
                             loc = fields[11].rstrip()
                             if ') ' in lTeam:
                                 lTeam = lTeam.split(') ')[1]
                             if lTeam in keys:
                                 stadiums[lTeam] = loc
                             else:
                                 continue
                     f.close()

##        print '# of Stadiums: ', len(stadiums)                 
##        for element in sorted(stadiums):
##            print element, '\n', stadiums[element]

        und_home = list(set(keys).difference(set(stadiums))) # Find teams who went undefeated at home
##        print sorted(und_home),
##        print '# of home undefeated teams:', len(und_home)

        stadiums_und = {}
        for team in und_home:
            stadiums_und[team] = []

        directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb_game_tables") # Find home undefeated teams' stadiums
        for subdir, dirs, files in os.walk(directory):
            for file in files:
                if file.startswith('FBS_games_' + str(i)):
                    print file
                    f = open(os.path.join(subdir,file), 'r')
                    f.readline()
                    for line in f:
                        fields = line.split(',')
                        if fields[7] == '@':
                            continue
                        else:
                            wTeam = fields[5]
                            if ') ' in wTeam:
                                 wTeam = wTeam.split(') ')[1]
                            if wTeam in und_home:
                                stadiums_und[wTeam].append(fields[11].rstrip())
                    f.close()

        for team in stadiums_und:
            stadiums_und[team] = max(set(stadiums_und[team]), key=stadiums_und[team].count)
            stadiums[team] = stadiums_und[team]
##            print team, '\n', stadiums_und[team], '\n'

        print '# of Stadiums: ', len(stadiums)                 
##        for element in sorted(stadiums):
##            print element, '\n', stadiums[element]

    f = open('C:\Users\Will\Desktop\Summer Research 2019\cfb 2000-2018 ID_Conference_Stadium\cfb_'  + str(i) +'_ID_Conference_Stadium.txt', 'w') # Write team info to file
    for team in sorted(keys):
        if i > 2015:
            f.write(team + '\t' +  keys[team] + '\t' + stadiums[team] + '\n')
        else:
             f.write(team + '\t' +  keys[team] + '\n')
    f.close()                      
