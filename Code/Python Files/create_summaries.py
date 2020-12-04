import datetime
from bs4 import BeautifulSoup
from urllib.request import urlopen
import urllib.error
from urllib.error import HTTPError
import re
import copy
import os
import datetime
import time
from datetime import timedelta, date

def create_summaries(season): 
    teams = []
    
    # teams = []
    if season.sport == "Football":
        file_year = str(season.year)
    else:
        file_year = season.year_string + '-' + season.prev_year_string

    directory = os.path.dirname("../MATLAB/" + season.sport + "/Teams")
    #directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\Team Tags/" + sports[index])
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file_year in file:
                f = open(os.path.join(subdir,file), 'r')
                if season.year <= 2004:
                    f.readline()
                for line in f:
                    if season.sport == "Football" and season.year <= 2010:
                        fields = line.split(',')
                    else:
                        fields = line.split('\t')
                    team = fields[0]

                    if team not in teams :
                        teams.append(copy.deepcopy(team))
    teams = sorted(teams)
    directory = os.path.dirname('../MATLAB/' + season.sport + '/Data/' + str(season.year) + "/game_infos")
    #directory = os.path.normpath("C:/Users/Will/Desktop/Summer Research 2019/HS Sports Data/" + sports[index] + "/" + file_year + "/game_infos")
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if season.sport == "Football":
                f = open(os.path.join(subdir, file), 'r')
                week_html = [[x for x in line.rstrip().split('\t')] for line in f]
                week_num = week_html[1]
                days = week_html[2]
                locations = week_html[3]
                wTeams = week_html[4]
                wTeams_id = week_html[5]
                wScores = map(int,week_html[6])
                lTeams = week_html[7]
                lTeams_id = week_html[8]
                lScores = map(int,week_html[9])
                overtimes = map(int,week_html[10])
                game_types = week_html[11]
            else:
                f = open(os.path.join(subdir, file), 'r')
                day_html = [[x for x in line.rstrip().split('\t')] for line in f]
                year = day_html[0][0]
                date = day_html[1][0]
                days = day_html[2]
                locations = day_html[3]
                wTeams = day_html[4]
                wTeams_id = day_html[5]
                wScores = map(int,day_html[6])
                lTeams = day_html[7]
                lTeams_id = day_html[8]
                lScores = map(int,day_html[9])
                overtimes = map(int,day_html[10])
                game_types = day_html[11]

            if season.sport == "Football":
                filename = season.get_abbreviation() + '_' + str(season.year) + "_" + week_num[0]
            else:
                filename = season.get_abbreviation() + '_' + season.year + "_" + date

            f.close()

            # Game Summary Matrix
            w,h = 8, len(wTeams) # set width and height of  matrix
            game_summaries = [[0 for x in range(w)] for y in range(h)]
            print(len(game_summaries))
            print(len(wTeams))
            for i in range(len(game_summaries)): # create matrix of game summaries
                if wTeams[i] in teams:
                    game_summaries[i][0] = teams.index(wTeams[i]) # Winner index
                    
                else:
                    game_summaries[i][0] = -1
                if lTeams[i] in teams:
                    game_summaries[i][1] = teams.index(lTeams[i]) # Loser index
                else:
                    game_summaries[i][1] = -1

                game_summaries[i][2] = wScores[i] # Winning score
                game_summaries[i][3] = lScores[i] # Losing score
                game_summaries[i][4] = game_summaries[i][2] - game_summaries[i][3] # Score diff

                if locations[i] == 'home':
                    game_summaries[i][5] = 1 # Location in terms of winner
                else:
                    game_summaries[i][5] = 0
                if locations[i] == 'neutral':
                    game_summaries[i][5] = 2

                game_summaries[i][6] = overtimes[i] # Overtime
                game_summaries[i][7] = game_types[i] # Game type

            # Write to file
            f = open('../MATLAB/' + season.sport  + '/Data/' + str(sport.year) + '/game_summaries/game_summary_%s.txt' % filename, 'w')
            #f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data/' + sports[index] + '/' + file_year + '/game_summaries/game_summary_%s.txt' % filename, 'w') # write score differentials array to file
            for game in game_summaries:
                for element in game:
                    f.write("%s\t" % element)
                f.write('\n')
            f.close()
    print("Created Game Summaries!")
    return