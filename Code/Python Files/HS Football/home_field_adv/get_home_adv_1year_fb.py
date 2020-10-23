from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

year = '1998'

games_played = [] # array of games in the entire season
dotP_array = [] # array of games in the entire season *ABS Value*

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_" + year)
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if file.startswith("matrix"):
##            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\t')
                del line[-1]                # remove newline character
                line = map(int,line)
                games_played.append(line)
            f.close()
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\t')
                del line[-1]                # remove newline character
                line = map(int,line)                
                for i in range(len(line)):  # change -1s to 1s in order to calculate dot product
                    line[i] = abs(line[i])
                dotP_array.append(line)
            f.close()
            
print len(games_played)
##print len(dotP_array)
##print "Games Played:"
##for game in games_played:
##    print game
##print "Dot Product: "
##for game in dotP_array:
##    print game

# For loop to find matchups played multiple times
rematch_count = 0
rematches = [] 
for i in range(len(dotP_array)):
    vec = dotP_array[i]
    j = i + 1
    for j in range(j,len(dotP_array)):
        vec2 = dotP_array[j]
        dot_prod = sum([vec[k]*vec2[k] for k in range(len(vec))])
        if dot_prod == 2:
            rematch_count +=1
            rematches.append([i,j])
##            for m in range(len(vec)):
##                if vec[m] == 1:
##                    print m
##            print "\n"
            
print "Total Rematches: ", rematch_count

## Location

locations_played = [] # array of all locations played at throughout the season

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_" + year)
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if file.startswith("locations"):
##            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\n')
                line = int(line[0])
                locations_played.append(line)
            f.close()
## print len(locations_played)
            
## Score Diff
score_diffs = [] # array of all score differentials throughout the season

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_" + year)
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if file.startswith("score_diffs"):
##            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\n')
                line = int(line[0])
                score_diffs.append(line)
            f.close()

# Overtimes
overtimes = [] # Overtimes throughout the season

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_" + year)
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if file.startswith("overtimes"):
##            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\n')
                line = int(line[0])
                overtimes.append(line)
            f.close()            

## Forfeits
forfeits = [] # Forfeits throughout the season

directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\Football\gi_" + year)
for subdir, dirs, files in os.walk(directory):
    for file in files:
        if file.startswith("forfeits"):
##            print file
            f = open(os.path.join(subdir,file), 'r')
            for line in f.readlines():
                line = line.split('\n')
                line = int(line[0])
                forfeits.append(line)
            f.close()
            
##print "Rematches array: ", rematches
##print '\n'
rematches2 = [] # array of rematches (game matrix)
rematches3 = [] # array of rematch comparisons

for matchup in rematches:
    i = matchup[0] # index of first game
    j = matchup[1] # index of rematch
    rematches2.append([games_played[i],games_played[j]])
    
    game1 = games_played[i] # game matrix for first game
    game2 = games_played[j] # game matrix for rematch
    
    a11 = game1.index(1) # winning team index
    a12 = game1.index(-1) # losing team index
##    print a11, a12
    a21 = game2.index(1)
    a22 = game2.index(-1)

    # Location in terms of lower alphabetical index
    if a11 < a12:
        game_loc1 = locations_played[i]
    else:
        if locations_played[i] == 0:
            game_loc1 = 1
        else:
            game_loc1 = 0
    if locations_played[i] == 2:
        game_loc1 = 2
        
    if a21 < a22:
        game_loc2 = locations_played[j]
    else:
        if locations_played[j] == 0:
            game_loc2 = 1
        else:
            game_loc2 = 0
    if locations_played[j] == 2:
        game_loc2 = 2
        
##    print game_loc1
##    print "\n"

    # Win in terms of lower alphabetical index
    if a11 < a12:
        game_winner1 = 1
    else:
        game_winner1 = 0
    if a21 < a22:
        game_winner2 = 1
    else:
        game_winner2 = 0

    # Score differential
    score_diff1 = score_diffs[i]
    score_diff2 = score_diffs[j]

    # Overtime
    overtime1 = overtimes[i]
    overtime2 = overtimes[j]

    # Forfeits
    forfeit1 = forfeits[i]
    forfeit2 = forfeits[j]

    # Comparison Arrays
    game1_array = []
    game2_array = []

    game1_array.append(game_loc1)
    game1_array.append(game_winner1)
    game1_array.append(score_diff1)
    game1_array.append(overtime1)
    game1_array.append(forfeit1)
##    print game1_array
    
    game2_array.append(game_loc2)
    game2_array.append(game_winner2)
    game2_array.append(score_diff2)
    game2_array.append(overtime2)
    game2_array.append(forfeit2)
##    print game2_array
##    print '\n'

    rematches3.append([game1_array,game2_array])
    
##print rematches3
##print '\n'

f = open('game_info/Football/gi_' + year + '/home_adv/home_adv_' + year + '.txt', 'w')
for matchup in rematches3:
    for game in matchup:
        for stat in game:
            f.write("%s\t" % stat),
    f.write('\n')
f.close()
