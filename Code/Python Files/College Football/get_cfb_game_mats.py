from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

for y in range(2000,2019):
    keys = {}
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\cfb 2000-2018 ID_Conference_Stadium")
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith('cfb_' + str(y)):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                for line in f:
                    fields = line.split('\t')
                    team = fields[0]
                    conf = fields[1].rstrip()

                    keys[team] = conf
##    print len(sorted(keys))
                                 
    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + str(y))
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith('game_info_' + str(y)):
                print file
                f = open(os.path.join(subdir,file), 'r')
                year_info = [[x for x in line.rstrip().split('\t')] for line in f]
                year = year_info[0]
                weeks = year_info[1]
                locations = year_info[2]
                wTeams = year_info[3]
                wScores = map(int,year_info[4])
                lTeams = year_info[5]
                lScores = map(int,year_info[6])

                # FBS Only Arrays
                weeks_FBS = []
                locations_FBS = []
                wTeams_FBS = []
                wScores_FBS = []
                lTeams_FBS = []
                lScores_FBS = []

                # FBS Only Games
                for k in range(len(wTeams)):
                    if (wTeams[k] in keys) and (lTeams[k] in keys):
                        weeks_FBS.append(weeks[k])
                        locations_FBS.append(locations[k])
                        wTeams_FBS.append(wTeams[k])
                        wScores_FBS.append(wScores[k])
                        lTeams_FBS.append(lTeams[k])
                        lScores_FBS.append(lScores[k])

                # FCS Arrays
                weeks_FCS = []
                locations_FCS = []
                wTeams_FCS = []
                wScores_FCS = []
                lTeams_FCS = []
                lScores_FCS = []

                # FCS Games
                for k in range(len(wTeams)):
                    if (wTeams[k] not in keys) or (lTeams[k] not in keys):
                        weeks_FCS.append(weeks[k])
                        locations_FCS.append(locations[k])
                        wTeams_FCS.append(wTeams[k])
                        wScores_FCS.append(wScores[k])
                        lTeams_FCS.append(lTeams[k])
                        lScores_FCS.append(lScores[k])

##                print len(wTeams), len(wTeams_FBS), len(wTeams_FCS)
                        
                # Score Differentials
                score_diff = [""] * len(wScores_FBS)
                for i in range(len(wScores_FBS)):
                    score_diff[i] = wScores_FBS[i] - lScores_FBS[i]

                # Location of game in terms of the winner
                location_winner = [""] * len(locations_FBS)
                for i in range(len(locations_FBS)):
                    if locations_FBS[i] == 'home':
                        location_winner[i] = 1
                    else:
                        location_winner[i] = 0
                    if locations_FBS[i] == 'neutral':
                        location_winner[i] = 2

                f.close()

                # Matrix of games
                key_list = sorted(keys.keys())
                
                w,h = len(keys), len(wTeams_FBS) # set width and height of  matrix
                winners = [[0 for x in range(w)] for y in range(h)]

                for i in range(0,len(winners)): # create matrix of winners and losers
                        j = key_list.index(wTeams_FBS[i])            
                        winners[i][j] = 1
                        j = key_list.index(lTeams_FBS[i])
                        winners[i][j] = -1
                        
                # FCS Matrix
                w2,h2 = len(keys),2 # set width and height of  matrix
                FCS_records = [[0 for x in range(w2)] for y in range(h2)]

                for i in range(len(wTeams_FCS)):
                    if wTeams_FCS[i] in key_list:
                        j = key_list.index(wTeams_FCS[i])
                        FCS_records[0][j] = 1
                for i in range(len(lTeams_FCS)):
                    if lTeams_FCS[i] in key_list:
                        j = key_list.index(lTeams_FCS[i])
                        FCS_records[1][j] = -1    

                # Write to file
                f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year[0] + '/score_diffs_%s.txt' % year[0], 'w') # write score differentials array to file
                for score in score_diff:
                    f.write(str(score))
                    f.write("\n")
                f.close()

                f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year[0] + '/locations_%s.txt' % year[0], 'w') # write locations array to file
                for location in location_winner:
                    f.write(str(location))
                    f.write("\n")
                f.close()

                f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year[0] + '/game_matrix_%s.txt' % year[0], 'w') # write game matrix to file
                for game in winners:
                    for element in game:
                        f.write("%s\t" % element)
                    f.write('\n')
                f.close()

                f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year[0] + '/FCS_record_%s.txt' % year[0], 'w') # write FCS array to file
                for element in FCS_records:
                    for num in element:
                        f.write("%s\t" % num)
                    f.write('\n')
                f.close()
