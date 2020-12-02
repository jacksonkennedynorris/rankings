from bs4 import BeautifulSoup
import urllib3
import re
import copy
import os
import datetime
from datetime import timedelta, date

#********** Choose Sport & Year **********
#Football is 0 
#Men's BB is 1
#Women's BB is 2
index = 0 # Used to switch between sports   
year1 = 1999
year2 = year1 + 1
year_bbk = str(year1) + '-' + str(year2)

#Sports
sports = ['Football',"Boys' Basketball", "Girls' Basketball"]
sports_abb = ['football','bbk','gbk']
url_abb = ['kyfb','kybbk','kygbk']

##Folder
folder = sports_abb[index] + '/' + str(year1)

print("HELLO WORLD")
#### ****** Get HTML ******

if index == 0: # Football

   # General URL text in every week
   if int(year) >= 2007:
       url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + year[2:4] + '?id='
   else:
       url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + year[3:4] + '?id='
   if int(year) == 1998:
       url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb?id='
   
   #Season Start and End Dates
   start_date = datetime.date(int(year),8,21)
   end_date = datetime.date(int(year),12,5)
   season_length = end_date - start_date

   for i in range(season_length.days + 1): # get all calendar dates of the season
       date = start_date + datetime.timedelta(days=i) # Calendar Date (YYYY-MM-DD)
       url = url_pre + str(date) # URL of gameday scoreboard webpage
       req = urllib2.Request(url) 
       req.add_header('User-agent', 'Mozilla 5.10')
       while True:
           try:
               day_html = urllib2.urlopen(req) # Scoreboard Webapage HTML
               break
           except urllib2.HTTPError, detail:
               if detail.errno == 500:
                   time.sleep(1)
                   continue
       day_soup = BeautifulSoup(day_html, 'html.parser')
       table = day_soup.find('table', {"id": "winner_sort"}) # Table HTML
       row_count = len(table.find_all('tr')) # Number of rows in table
       if row_count > 0:
           day = table.find_all('tr')[0].text # Header Row
           week_num = date.isocalendar()[1] - start_date.isocalendar()[1] + 1 # Number week in a season
           if week_num < 10:
               week_num = '0' + str(week_num)
           
           filename = 'HTML_' + sports_abb[index] + "_" + year + "_" + str(week_num) + '.txt'
           f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/HTML/%s' % filename, 'a')                                            
           f.write(day_soup.title.string + '\n')
           f.write(str(day_soup))
           f.close()

# ##else: #Basketball
# ##
# ##    # General URL text in every week
# ##    if int(year) <= 2006:
# ##        url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/' +url_abb[index] + year_bbk[3:4] + '?id='
# ##    else:
# ##        url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/' +url_abb[index] + year_bbk[2:4] + '?id='
# ##
# ##    # Season Start and End Dates
# ##    start_date = datetime.date(year1,11,1)
# ##    end_date = datetime.date(year2,4,1)
# ##    season_length = end_date - start_date
# ##    for i in range(season_length.days + 1): # get all calendar dates of the season
# ##        date = start_date + datetime.timedelta(days=i) # Calendar Date (YYYY-MM-DD)
# ##        url = url_pre + str(date) # URL of gameday scoreboard webpage
# ##        req = urllib2.Request(url)
# ##        req.add_header('User-agent', 'Mozilla 5.10')
# ##        while True:
# ##            try:
# ##                day_html = urllib2.urlopen(req) # Scoreboard Webapage HTML
# ##                break
# ##            except urllib2.HTTPError, detail:
# ##                if detail.errno == 500:
# ##                    time.sleep(1)
# ##                    continue
# ##        day_soup = BeautifulSoup(day_html, 'html.parser')
# ##        table = day_soup.find('table', {"id": "winner_sort"}) # Table HTML
# ##        row_count = len(table.find_all('tr')) # Number of rows in table
# ##        if row_count > 0:
# ##            day = table.find_all('tr')[0].text # Header Row        
# ##            filename = 'HTML_' + sports_abb[index] + "_" + year_bbk + "_" + str(date) + '.txt'
# ##            f = open("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data/" + sports[index] + "/" + year_bbk + '/HTML/%s' % filename, 'w')
# ##            f.write(day_soup.title.string + '\n')
# ##            f.write(str(day_soup))
# ##            f.close()
# ##            
# ##print "HTML check"
# ##
# ##********** Get Game Infos **********

# ## Football
# if index == 0:
#    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/" + year + "/HTML") ## Open and traverses through each file
#    directory = os.path.dirname('..\MATLAB/Football/Data/' + year + "/HTML")
#    print(directory)
#    for subdir, dirs, files in os.walk(directory):
#        for file in files:
#            f = open(os.path.join(subdir,file), 'r')
#            week_html = f.read()
#            week_soup = BeautifulSoup(week_html, 'html.parser')
#            year = week_soup.title.string.split(' ')[0] # grab year from title
#            week_num = file[-6:-4] # Grab Week Num for filename
#            tables = week_soup.findAll('table', {"id": "winner_sort"}) # Grab HTML Tables
               
#            days = []
#            locations = []
#            neutrals = []
#            wTeams = []
#            wTeams_ids = []
#            wScores= []
#            lTeams = []
#            lTeams_ids = []
#            lScores = []
#            overtimes = []
#            game_types = []

#            for i in range(len(tables)):
#                days_temp = tables[i].findAll('td', {"class": "date_table_date"}) # grab days in specific week
#                days_temp = [str(element.get_text()) for element in days_temp] #array of days in week

#                locations_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab location of game
#                locations_temp = [str(element.get_text())[:2] for element in locations_temp] # array of 'vs' & 'at'

#                neutrals_temp = tables[i].findAll('td', {"class": "loser_team"}) # tags used to find neutral site games 
#                neutrals_temp = [str(element.get_text()) for element in neutrals_temp]

#                wTeams_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' names
#                wTeams_temp = [str(element.get_text()) for element in wTeams_temp] # array of  winning teams

#                wTeams_ids_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' ids
               
#                wScores_temp = tables[i].findAll('td', {"class": "winner_score"}) # grab winning teams' scores
#                wScores_temp = [str(element.get_text()) for element in wScores_temp] # array of winning scores

#                lTeams_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names
#                lTeams_temp = [str(element.get_text())[3:].split('(at')[0].lstrip().rstrip() for element in lTeams_temp] # array of losing teams

#                lTeams_ids_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names

#                lScores_temp = tables[i].findAll('td', {"class": "loser_score"}) # grab losing teams' scores
#                lScores_temp = [str(element.get_text()) for element in lScores_temp] # array of losing scores

#                overtimes_temp = tables[i].findAll('span', {"class": "nobr"}) # finds all span tags in table
#                overtimes_temp = [str(element.get_text()) for element in overtimes_temp]

#                game_types_temp = tables[i].findAll('span', {"class": "nobrx"}) # finds all a tags in table
#                game_types_temp = [str(element.get_text()) for element in game_types_temp]
               
#                for j in range(len(wTeams_temp)):
#                    if wTeams_temp[j] == 'Open' or wScores_temp[j] == '-':
#                        continue
#                    else:
#                        days.append(days_temp[0])
                       
#                        locations.append(locations_temp[j])
#                        neutrals.append(neutrals_temp[j])
                       
#                        wTeams.append(wTeams_temp[j])
                       
#                        val = str(wTeams_ids_temp[j]).split('"')[1]
#                        val = val[12:]
#                        wTeams_ids.append(val)
                       
#                        wScores.append(wScores_temp[j])

#                        lTeams.append(lTeams_temp[j])

#                        val = str(lTeams_ids_temp[j]).split('"')[1]
#                        val = val[11:]
#                        lTeams_ids.append(val)
                       
#                        lScores.append(lScores_temp[j])

#                        overtimes.append(overtimes_temp[j])

#                        game_types.append(game_types_temp[j])

#            for k in range(len(locations)): # changes 'vs' & 'at' to 'home' & 'away'
#                if locations[k] == 'vs':
#                    locations[k] = 'home'
#                else:
#                    locations[k] = 'away'
#                if '(at ' in neutrals[k]:
#                    locations[k] = 'neutral'

#            for l in range(len(overtimes)):
#                if 'overtime' in str(overtimes[l]) or 'Overtime' in str(overtimes[l]):
#                    overtimes[l] = 1
#                else:
#                    overtimes[l] = 0

#            for m in range(len(game_types)):
#                if 'KHSAA Commonwealth Gridiron Bowl' in game_types[m]:
#                    game_types[m] = 1
#                else:
#                    game_types[m] = 0
                   
#            filename = 'game_info_' + sports_abb[index] + "_" + year + "_" + str(week_num) + '.txt'
                   
#            f.close()

#            # Write to file
#            f = open('')
#            f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/' + year + '/game_infos/%s' % filename, 'w')
#            f.write(year)
#            f.write('\n')
#            f.write(week_num)
#            f.write('\n')
#            for day in days:
#                f.write("%s\t" % day)
#            f.write('\n')
#            for location in locations:
#                f.write("%s\t" % location)
#            f.write('\n')
#            for team in wTeams:
#                f.write("%s\t" % team)
#            f.write('\n')
#            for team in wTeams_ids:
#                f.write("%s\t" % team)
#            f.write('\n')
#            for score in wScores:
#                f.write("%s\t" % score)
#            f.write('\n')
#            for team in lTeams:
#                f.write("%s\t" % team)
#            f.write('\n')
#            for team in lTeams_ids:
#                f.write("%s\t" % team)
#            f.write('\n')
#            for score in lScores:
#                f.write("%s\t" % score)
#            f.write('\n')
#            for overtime in overtimes:
#                f.write("%s\t" % overtime)
#            f.write('\n')
#            for game_type in game_types:
#                f.write("%s\t" % game_type)
#            f.close()
           
#### Basketball     
##else:
##    directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data/" + sports[index] + "/" + year_bbk + "/HTML") ## Open and traverses through each file
##    for subdir, dirs, files in os.walk(directory):
##        for file in files:
##            f = open(os.path.join(subdir,file),'r')
##            day_html = f.read()
##            day_soup = BeautifulSoup(day_html, 'html.parser')
##            date = file[-14:-4] # Grab date for filename
##            tables = day_soup.findAll('table', {"id": "winner_sort"}) # Grab HTML Tables
##                
##            days = []
##            locations = []
##            neutrals = []
##            wTeams = []
##            wTeams_ids = []
##            wScores= []
##            lTeams = []
##            lTeams_ids = []
##            lScores = []
##            overtimes = []
##            game_types = []
##
##            for i in range(len(tables)):
##                days_temp = tables[i].findAll('td', {"class": "date_table_date"}) # grab days in specific week
##                days_temp = [str(element.get_text()) for element in days_temp] #array of days in week
##
##                locations_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab location of game
##                locations_temp = [str(element.get_text())[:2] for element in locations_temp] # array of 'vs' & 'at'
##
##                neutrals_temp = tables[i].findAll('td', {"class": "loser_team"}) # tags used to find neutral site games 
##                neutrals_temp = [str(element.get_text()) for element in neutrals_temp]
##
##                wTeams_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' names
##                wTeams_temp = [str(element.get_text()) for element in wTeams_temp] # array of  winning teams
##
##                wTeams_ids_temp = tables[i].findAll('td', {"class": "winner_team"}) # grab winning teams' ids
##                
##                wScores_temp = tables[i].findAll('td', {"class": "winner_score"}) # grab winning teams' scores
##                wScores_temp = [str(element.get_text()) for element in wScores_temp] # array of winning scores
##
##                lTeams_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names
##                lTeams_temp = [str(element.get_text())[3:].split('(at')[0].lstrip().rstrip() for element in lTeams_temp] # array of losing teams
##
##                lTeams_ids_temp = tables[i].findAll('td', {"class": "loser_team"}) # grab losing teams' names
##
##                lScores_temp = tables[i].findAll('td', {"class": "loser_score"}) # grab losing teams' scores
##                lScores_temp = [str(element.get_text()) for element in lScores_temp] # array of losing scores
##
##                overtimes_temp = tables[i].findAll('span', {"class": "nobr"}) # finds all span tags in table
##                overtimes_temp = [str(element.text.encode("utf8")) for element in overtimes_temp]
##
##                game_types_temp = tables[i].findAll('span', {"class": "nobrx"}) # finds all a tags in table
##                game_types_temp = [str(element.text.encode("utf8")) for element in game_types_temp]
##                
##                for j in range(len(wTeams_temp)):
##                    if wTeams_temp[j] == 'Open' or wScores_temp[j] == '-':
##                        continue
##                    else:
##                        days.append(days_temp[0])
##                        
##                        locations.append(locations_temp[j])
##                        neutrals.append(neutrals_temp[j])
##                        
##                        wTeams.append(wTeams_temp[j])
##                        
##                        val = str(wTeams_ids_temp[j]).split('"')[1]
##                        val = val[12:]
##                        wTeams_ids.append(val)
##                        
##                        wScores.append(wScores_temp[j])
##
##                        lTeams.append(lTeams_temp[j])
##
##                        val = str(lTeams_ids_temp[j]).split('"')[1]
##                        val = val[11:]
##                        lTeams_ids.append(val)
##                        
##                        lScores.append(lScores_temp[j])
##
##                        overtimes.append(overtimes_temp[j])
##
##                        game_types.append(game_types_temp[j])
##
##            for k in range(len(locations)): # changes 'vs' & 'at' to 'home' & 'away'
##                if locations[k] == 'vs':
##                    locations[k] = 'home'
##                else:
##                    locations[k] = 'away'
##                if '(at ' in neutrals[k]:
##                    locations[k] = 'neutral'
##
##            for l in range(len(overtimes)):
##                if 'overtime' in str(overtimes[l]) or 'Overtime' in str(overtimes[l]):
##                    overtimes[l] = 1
##                else:
##                    overtimes[l] = 0
##                    
##            for m in range(len(game_types)):
##                if 'Sweet Sixteen' in game_types[m] or 'Sweet 16' in game_types[m]: # State Tournament game
##                    game_types[m] = 3
##                elif 'Region' in game_types[m]: # Region Tournament game
##                    game_types[m] = 2
##                elif 'District' in game_types[m]: # District Tournament game
##                    game_types[m] = 1
##                else:
##                    game_types[m] = 0 # Regular Season game
##                    
##            filename = 'game_info_' + sports_abb[index] + "_" + year_bbk + "_" + date + '.txt'
##
# ##            f.close()                
# ##
# ##            # Write to file
# ##            f = open("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data/" + sports[index] + "/" + year_bbk + "/game_infos/%s" % filename, 'w')
# ##            f.write(year_bbk)
# ##            f.write('\n')
# ##            f.write(date)
# ##            f.write('\n')
# ##            for day in days:
# ##                f.write("%s\t" % day)
# ##            f.write('\n')
# ##            for location in locations:
# ##                f.write("%s\t" % location)
# ##            f.write('\n')
# ##            for team in wTeams:
# ##                f.write("%s\t" % team)
# ##            f.write('\n')
# ##            for team in wTeams_ids:
# ##                f.write("%s\t" % team)
# ##            f.write('\n')
# ##            for score in wScores:
# ##                f.write("%s\t" % score)
# ##            f.write('\n')
# ##            for team in lTeams:
# ##                f.write("%s\t" % team)
# ##            f.write('\n')
# ##            for team in lTeams_ids:
# ##                f.write("%s\t" % team)
# ##            f.write('\n')
# ##            for score in lScores:
# ##                f.write("%s\t" % score)
# ##            f.write('\n')
# ##            for overtime in overtimes:
# ##                f.write("%s\t" % overtime)
# ##            f.write('\n')
# ##            for game_type in game_types:
# ##                f.write("%s\t" % game_type)
# ##            f.close()
# ##
# ##print "Game info check"

# ##********* Get Game Summaries **********
# teams = []
# if index == 0:
#     file_year = year
# else:
#     file_year = year_bbk

# directory = os.path.dirname("..\MATLAB/Football/Teams")
# directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\Team Tags/" + sports[index])
# for subdir, dirs, files in os.walk(directory):
#     for file in files:
#         if file_year in file:
#             f = open(os.path.join(subdir,file), 'r')
#             if int(year) <= 2004:
#                 f.readline()
#             for line in f:
#                 if index == 0 and int(year) <= 2010:
#                     fields = line.split(',')
#                 else:
#                     fields = line.split('\t')
#                 team = fields[0]

#                 if team not in teams :
#                     teams.append(copy.deepcopy(team))
# teams = sorted(teams)

# directory = os.path.normpath("C:/Users/Will/Desktop/Summer Research 2019/HS Sports Data/" + sports[index] + "/" + file_year + "/game_infos")
# for subdir, dirs, files in os.walk(directory):
#     for file in files:
#         if index == 0:
#             f = open(os.path.join(subdir, file), 'r')
#             week_html = [[x for x in line.rstrip().split('\t')] for line in f]
#             week_num = week_html[1]
#             days = week_html[2]
#             locations = week_html[3]
#             wTeams = week_html[4]
#             wTeams_id = week_html[5]
#             wScores = map(int,week_html[6])
#             lTeams = week_html[7]
#             lTeams_id = week_html[8]
#             lScores = map(int,week_html[9])
#             overtimes = map(int,week_html[10])
#             game_types = week_html[11]
#         else:
#             f = open(os.path.join(subdir, file), 'r')
#             day_html = [[x for x in line.rstrip().split('\t')] for line in f]
#             year = day_html[0][0]
#             date = day_html[1][0]
#             days = day_html[2]
#             locations = day_html[3]
#             wTeams = day_html[4]
#             wTeams_id = day_html[5]
#             wScores = map(int,day_html[6])
#             lTeams = day_html[7]
#             lTeams_id = day_html[8]
#             lScores = map(int,day_html[9])
#             overtimes = map(int,day_html[10])
#             game_types = day_html[11]

#         if index == 0:
#             filename = sports_abb[index] + '_' + year + "_" + week_num[0]
#         else:
#             filename = sports_abb[index] + '_' + year + "_" + date 
   
#         f.close()

#         # Game Summary Matrix                   
#         w,h = 8, len(wTeams) # set width and height of  matrix
#         game_summaries = [[0 for x in range(w)] for y in range(h)]
        
#         for i in range(len(game_summaries)): # create matrix of game summaries
#             if wTeams[i] in teams:
#                 game_summaries[i][0] = teams.index(wTeams[i]) # Winner index
#             else:
#                 game_summaries[i][0] = -1
#             if lTeams[i] in teams:
#                 game_summaries[i][1] = teams.index(lTeams[i]) # Loser index
#             else:
#                 game_summaries[i][1] = -1
                
#             game_summaries[i][2] = wScores[i] # Winning score
#             game_summaries[i][3] = lScores[i] # Losing score
#             game_summaries[i][4] = game_summaries[i][2] - game_summaries[i][3] # Score diff

#             if locations[i] == 'home':
#                 game_summaries[i][5] = 1 # Location in terms of winner
#             else:
#                 game_summaries[i][5] = 0
#             if locations[i] == 'neutral':
#                 game_summaries[i][5] = 2
                
#             game_summaries[i][6] = overtimes[i] # Overtime
#             game_summaries[i][7] = game_types[i] # Game type
            
#         # Write to file
#         f = open('C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data/' + sports[index] + '/' + file_year + '/game_summaries/game_summary_%s.txt' % filename, 'w') # write score differentials array to file
#         for game in game_summaries:
#             for element in game:
#                 f.write("%s\t" % element)
#             f.write('\n')
#         f.close()
# print "Game Summaries check"
# print 'Done'
            
