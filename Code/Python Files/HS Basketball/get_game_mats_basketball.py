from bs4 import BeautifulSoup
import urllib2
import StringIO
import re
import copy
import os

filenames = ['kybbk','kygbk']
sports = ["Boys' Basketball", "Girls' Basketball"]
sport_index = 1
teams, teamIds = [], []
year_nums = ['1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019']

for i in range(len(year_nums)-1):
    year1 = year_nums[i]
    year2 = year_nums[i+1]
    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019/" + filenames[sport_index] + " 1998-2019 ID_region_district")
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith(filenames[sport_index] + '_' + year1):
                print file
                f = open(os.path.join(subdir,file), 'r')
                for line in f:
                    fields = line.split('\t')
                    team = fields[0]
                    teamId = fields[1]
                    region = fields[2]
                    district = fields[3]

                    if team not in teams :
                        teams.append(copy.deepcopy(team))
                    if teamId not in  teamIds:
                        teamIds.append(copy.deepcopy(teamId))
                        
                keys = {} # dictionary of Team Ids
                for i in range(len(teams)):
                    keys[teams[i]] = teamIds[i]                
##                print len(sorted(keys))                    
                f.close()

    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\game_info/" + sports[sport_index] + '/' + year1 + '-' + year2)
    for subdir, dirs, files in os.walk(directory):
        for file in files:
            if file.startswith('game_info'):
##                print file
                f = open(os.path.join(subdir, file), 'r')
                week_html = [[x for x in line.rstrip().split('\t')] for line in f]
                year_html = week_html[0]
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
                        wScores_ky.append(wScores[i])
                        lScores_ky.append(lScores[i])
                        wTeamIds_ky.append(wTeams_id[i])
                        lTeamIds_ky.append(lTeams_id[i])
                        overtimes_ky.append(overtimes[i])
                # Out-of-State Only Arrays
                locations_os = []
                days_os = []
                wTeams_os = []
                lTeams_os = []
                wScores_os = []
                lScores_os = []
                wTeamIds_os = []
                lTeamIds_os = []
                overtimes_os = []

                # Out-of-State only games
                for i in range(0,len(wTeams)):
                    if (wTeams[i] not in keys) or (lTeams[i] not in keys):
                        locations_os.append(locations[i])
                        days_os.append(days[i])
                        wTeams_os.append(wTeams[i])
                        lTeams_os.append(lTeams[i])
                        wScores_os.append(wScores[i])
                        lScores_os.append(lScores[i])
                        wTeamIds_os.append(wTeams_id[i])
                        lTeamIds_os.append(lTeams_id[i])
                        overtimes_os.append(overtimes[i])
                
    ##            print '1:', len(wTeams)
    ##            print '2:', len(wTeams_ky)
    ##            print '3:', len(wTeams_os)
    ##            print '\n'

                filename = year1 + '-' + year2 + "_" + week_num[0]
    ##            print filename

                score_diff = [""] * len(wScores_ky)
                for i in range(len(wScores_ky)):
                    score_diff[i] = wScores_ky[i] - lScores_ky[i]
                    
    ##            print "Score Diffferential: ", score_diff
    ##            for score in score_diff:
    ##                print score, "\n"
                    
                location_winner = [""] * len(locations_ky)
                for i in range(len(locations_ky)):
                    if locations_ky[i] == 'home':
                        location_winner[i] = 1
                    else:
                        location_winner[i] = 0
                    if locations_ky[i] == 'neutral':
                        location_winner[i] = 2
    ##            print location_winner               
                    
                forfeits = [""] * len(wScores_ky)
                for i in range(len(wScores_ky)):
                    if wScores[i] == 1:
                        forfeits[i] = 1
                    else:
                        forfeits[i] = 0
           
                f.close()

                # Matrix of games   
                key_list = sorted(keys.keys())
                
                w,h = len(keys), len(wTeams_ky) # set width and height of  matrix
                winners = [[0 for x in range(w)] for y in range(h)]
                
                for i in range(0,len(winners)): # create matrix of winners and losers
                    j = key_list.index(wTeams_ky[i])            
                    winners[i][j] = 1
                    j = key_list.index(lTeams_ky[i])
                    winners[i][j] = -1

                # Out-Of-State Matrix
                w2,h2 = len(keys),2 # set width and height of  matrix
                os_records = [[0 for x in range(w2)] for y in range(h2)]

                for i in range(len(wTeams_os)):
                    if wTeams_os[i] in key_list:
                        j = key_list.index(wTeams_os[i])
                        os_records[0][j] = 1
                for i in range(len(lTeams_os)):
                    if lTeams_os[i] in key_list:
                        j = key_list.index(lTeams_os[i])
                        os_records[1][j] = -1
                
                # Write to file
                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/score_diffs/score_diffs_%s.txt' % filename, 'w') # write score differentials array to file
                for score in score_diff:
                    f.write(str(score))
                    f.write("\n")
                f.close()
                
                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/locations/locations_%s.txt' % filename, 'w') # write lcoations array to file
                for location in location_winner:
                    f.write(str(location))
                    f.write("\n")
                f.close()
    
                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/overtimes/overtimes_%s.txt' % filename, 'w') # write overtimes array to file
                for period in overtimes_ky:
                    f.write(str(period))
                    f.write('\n')
                f.close()
    
                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/forfeits/forfeits_%s.txt' % filename, 'w') # write forfeits array to file
                for game in forfeits:
                    f.write(str(game))
                    f.write('\n')
                f.close()

                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/game_matrices/matrix_%s.txt' % filename, 'w') # write game matrices array to file
                for game in winners:
                    for element in game:
                        f.write("%s\t" % element)
                    f.write('\n')
                f.close()
    
                f = open('../../game_info/' + sports[sport_index] + '/' + year1 + '-' + year2 + '/os_records/os_record_%s.txt' % filename, 'w') # write out-of-state array to file
                for element in os_records:
                    for num in element:
                        f.write("%s\t" % num)
                    f.write('\n')
                f.close()
