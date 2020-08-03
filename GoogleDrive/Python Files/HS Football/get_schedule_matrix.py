from bs4 import BeautifulSoup
import urllib2
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
                aClass = fields[2]
##                district = fields[3]

                if team not in teams:
                    teams.append(copy.deepcopy(team))
                if teamId not in  teamIds:
                    teamIds.append(copy.deepcopy(teamId))

            keys = {} # dictionary of Team Ids
            for i in range(len(teams)):
                keys[teams[i]] = teamIds[i]
            f.close()

week_files = []

directory = os.path.normpath("C:/Users/Will/Desktop/Summer Research 2019/HS Sports Data/Football/"+ year +"/game_info")
for subdir, dirs, files in os.walk(directory):
    for file in files:
        week_files.append(file)

for file in week_files[-1:]:
    print file
    f = open(os.path.join(directory, file), 'r')
    week_html = [[x for x in line.rstrip().split('\t')] for line in f]
##    year = week_html[0]
    week_num = week_html[1]
    days = week_html[2]
    locations = week_html[3]
    wTeams = week_html[4]
    wTeams_id = week_html[5]
##    wScores = map(int,week_html[6])
    lTeams = week_html[7]
    lTeams_id = week_html[8]
##    lScores = map(int,week_html[9])
##    overtimes = map(int,week_html[10])

    # Kentucky Only Arrays
    locations_ky = []
    days_ky = []
    wTeams_ky = []
    lTeams_ky = []
    wScores_ky = []
    lScores_ky = []
    wTeamIds_ky = []
    lTeamIds_ky = []
    overtimes_ky = []
            
    # Kentucky Only Games
    for i in range(0,len(wTeams)):
        if (wTeams[i] in keys) and (lTeams[i] in keys):
            locations_ky.append(locations[i])
            days_ky.append(days[i])
            wTeams_ky.append(wTeams[i])
            lTeams_ky.append(lTeams[i])
##            wScores_ky.append(wScores[i])
##            lScores_ky.append(lScores[i])
            wTeamIds_ky.append(wTeams_id[i])
            lTeamIds_ky.append(lTeams_id[i])
##            overtimes_ky.append(overtimes[i])

    # Create matrix of games   
    key_list = sorted(keys.keys()) # list of keys and values
    val_list = sorted(keys.values())          
    w,h = len(keys), len(wTeams_ky) # set width and height of  matrix
    schedule = [[0 for x in range(w)] for y in range(h)]
    for i in range(0,len(schedule)): # create matrix of winners and losers
        j = key_list.index(wTeams_ky[i])
        if locations[i] == 'away':
            schedule[i][j] = -1
            j = key_list.index(lTeams_ky[i])
            schedule[i][j] = 1
        if locations[i] == 'home':
            j = key_list.index(wTeams_ky[i])
            schedule[i][j] = 1
            j = key_list.index(lTeams_ky[i])
            schedule[i][j] = -1
        if locations[i] == 'neutral':
            j = key_list.index(wTeams_ky[i])
            k = key_list.index(lTeams_ky[i])
            if j < k:
                schedule[i][j] = 1
                schedule[i][k] = -1
            else:
                schedule[i][j] = -1
                schedule[i][k] = 1          

    w2,h2 = 1,len(wTeams_ky) # set width and height of  matrix
    neutrals =  [[0 for x in range(w2)] for y in range(h2)]
    for i in range(len(neutrals)):
        if locations[i] == 'neutral':
            neutrals[i][0] = 1        
    
    # Write to file
    filename = year + "_" + week_num[0]
    f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/schedule_matrices/schedule_matrix_%s.txt' % filename, 'w') 
    for game in schedule:
        for element in game:
            f.write("%s\t" % element)
        f.write('\n')
    f.close()

    f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/neutrals/neutral_vector_%s.txt' % filename, 'w')
    for game in neutrals:
        for element in game:
            f.write("%s\t" % element)
        f.write('\n')
    f.close()


            
