from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

for y in range(2000,2018):
    year1 = str(y) # Years being compared
    year2 = str(y+1)

    list1 = [] # Team lists
    list2 = []

    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\cfb 2000-2018 ID_Conference_Stadium')
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith('cfb_' + year1):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                for line in f:
                    fields = line.split('\t')
                    team = fields[0]
                    if team not in list1:
                        list1.append(copy.deepcopy(team))                    
                f.close()

    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\cfb 2000-2018 ID_Conference_Stadium')
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith('cfb_' + year2):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                for line in f:
                    fields = line.split('\t')
                    team = fields[0]
                    if team not in list2:
                        list2.append(copy.deepcopy(team))                    
                f.close()
##    print year1,len(list1), year2, len(list2)

    # list of common teams
    list3 = []
    for i in range(len(list1)):
        if list1[i] in list2:
            list3.append(list1[i])
##    print len(list3), '\n'

    # Find list of teams not in common set
    sdiff1 = list(set(list1) - set(list3))
    sdiff2 = list(set(list2) - set(list3))
##    print sdiff1, sdiff2

    # Get Game Matrices
    
    # Array of games in each season
    games_played1 = []
    games_played2 = []

    # Dot Product Arrays
    dotP_array1 = []
    dotP_array2 = []

    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year1)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("game_matrix"):
##                print file
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\t')
                    del line[-1]                # remove newline character
                    line = map(int,line)
                    games_played1.append(line)
                f.close()
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\t')
                    del line[-1]                # remove newline character
                    line = map(int,line)                
                    for i in range(len(line)):  # change -1s to 1s in order to calculate dot product
                        line[i] = abs(line[i])
                    dotP_array1.append(line)
                f.close()
                
    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year2)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("game_matrix"):
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\t')
                    del line[-1]                # remove newline character
                    line = map(int,line)
                    games_played2.append(line)
                f.close()
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\t')
                    del line[-1]                # remove newline character
                    line = map(int,line)                
                    for i in range(len(line)):  # change -1s to 1s in order to calculate dot product
                        line[i] = abs(line[i])
                    dotP_array2.append(line)
                f.close()
                
##    print 'Before: '
##    print len(games_played1[0])
##    print len(games_played2[0]), '\n'

    # Remove Excess Teams
    if sdiff1 != []:
        indices = []
        for i in range(len(sdiff1)):
            index = list1.index(sdiff1[i])
            indices.append(index)
        for j in range(len(games_played1)):
            for num in sorted(indices, reverse=True):
                del games_played1[j][num]
                del dotP_array1[j][num]
            
    if sdiff2 != []:
        indices = []
        for i in range(len(sdiff2)):
            index = list2.index(sdiff2[i])
            indices.append(index)
        for j in range(len(games_played2)):
            for num in sorted(indices, reverse=True):
                del games_played2[j][num]
                del dotP_array2[j][num]
                
##    print 'After: '           
##    print len(games_played1[0])           
##    print len(games_played2[0]),'\n'

    # For loop to find matchups played multiple times
    rematches = [] 
    for i in range(len(dotP_array1)):
        vec = dotP_array1[i]
        for j in range(len(dotP_array2)):
            vec2 = dotP_array2[j]
            dot_prod = sum([vec[k]*vec2[k] for k in range(len(vec))])
            if dot_prod == 2:
                rematches.append([i,j])
    ##            for m in range(len(vec)):
    ##                if vec[m] == 1:
    ##                    print m
    ##            print "\n"
                
    print year1, '-', year2, "Total Rematches: ", len(rematches)

    # game info vectors

    ## Locations
    locations_played1 = [] # array of all locations played at throughout the first season
    locations_played2 = []

    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/" + year1)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("locations"):
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\n')
                    line = int(line[0])
                    locations_played1.append(line)
                f.close()
    directory = os.path.normpath('C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/' + year2)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("locations"):
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\n')
                    line = int(line[0])
                    locations_played2.append(line)
                f.close()

    ## Score Diff
    score_diffs1 = [] # array of all locations played at throughout the first season
    score_diffs2 = []

    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/" + year1)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("score_diffs"):
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\n')
                    line = int(line[0])
                    score_diffs1.append(line)
                f.close()
                
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info\College Football/" + year2)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith("score_diffs"):
                f = open(os.path.join(subdir,file), 'r')
                for line in f.readlines():
                    line = line.split('\n')
                    line = int(line[0])
                    score_diffs2.append(line)
                f.close()

   # Get Comparison Arrays
    rematches2 = [] # array of rematches (game matrix)
    rematches3 = [] # array of rematch comparisons

    for matchup in rematches:
        i = matchup[0] # index of game in first year
        j = matchup[1] # index of rematch in second year
        rematches2.append([games_played1[i],games_played2[j]])

        game1 = games_played1[i] # game matrix for first game
        game2 = games_played2[j] # game matrix for rematch
        
        a11 = game1.index(1) # winning team index
        a12 = game1.index(-1) # losing team index
        a21 = game2.index(1)
        a22 = game2.index(-1)
##        print a11, a12

        # Location in terms of lower alphabetical index
        if a11 < a12:
            game_loc1 = locations_played1[i]
        else:
            if locations_played1[i] == 0:
                game_loc1 = 1
            else:
                game_loc1 = 0
        if locations_played1[i] == 2:
            game_loc1 = 2
            
        if a21 < a22:
            game_loc2 = locations_played2[j]
        else:
            if locations_played2[j] == 0:
                game_loc2 = 1
            else:
                game_loc2 = 0
        if locations_played2[j] == 2:
            game_loc2 = 2

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
        score_diff1 = score_diffs1[i]
        score_diff2 = score_diffs2[j]

        # Comparison Arrays
        game1_array = []
        game2_array = []

        game1_array.append(game_loc1)
        game1_array.append(game_winner1)
        game1_array.append(score_diff1)
##        print game1_array
        
        game2_array.append(game_loc2)
        game2_array.append(game_winner2)
        game2_array.append(score_diff2)
##        print game2_array

        rematches3.append([game1_array,game2_array])
##    print rematches3, '\n'

    f = open('C:\Users\Will\Desktop\Summer Research 2019\game_info/College Football/rematches/' + year1 + '_' + year2 + '.txt', 'w')
    for matchup in rematches3:
        for game in matchup:
            for stat in game:
                f.write("%s\t" % stat),
        f.write('\n')
    f.close()
            
            
                
