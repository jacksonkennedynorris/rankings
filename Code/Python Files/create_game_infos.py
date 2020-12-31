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
import csv 
from datetime import timedelta, date
from write_HTML import * 
import os.path
from os import path
from teams import *
def create_game_infos(season):
## Football

    html_directory = season.get_year_path() + "/HTML/"
    infos_directory = season.get_year_path() + "/game_infos/"
    teams_file = season.get_teams_path()
    teams = []
    with open(teams_file, 'r') as f: 
        id = 0
        for line in f: 
            if id == 0:
                id = 1
                continue 
            team_split = line.rstrip('\n').split(',')
            assert len(team_split) == 2, "Should be 2, not " + len(team_split)
            name = team_split[0]
            region = team_split[1]
            team = Team(name,region,id)
            teams.append(team)
            id = id + 1
    num_teams = id 
    #print(teams[0].name, teams[0].region, teams[0].id)
    # for i in range(num_teams-1):
    #     print(teams[i].name,teams[i].region,teams[i].id)
    if not os.path.exists(infos_directory):  
        os.makedirs(infos_directory)

    #***** QUESTION FOR DR. H  ******
    #Do we want to delete all these files and start anew?

    with open(infos_directory + "game_infos", 'w', newline= '') as csvfile:   
        fieldnames = ["date","win_team", "lose_team", "win_score", "lose_score", "location", "date_comments","overtime"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()  

    html_files = os.listdir(html_directory) 
    html_files = sorted(html_files)

    for file_name in html_files: 
        with open(html_directory + file_name, 'rb') as f:
            html = f.read()
        html_soup = BeautifulSoup(html, 'html.parser')

        table = html_soup.findAll('table',{"id": "winner_sort"})
        games = []
        win_team = ""
        win_score = ""
        lose_team = ""
        lose_score = ""
        date_comments = ""
        i = -1
        for tr in table[0].findAll('tr'): 
            if i == -1: 
                i = 0
                continue
            i = 0
            for td in tr.findAll('td'):
                if i == 0: 
                    win_team = td.get_text()
                    win_team = win_team.replace(',','.')
                if i == 1: 
                    win_score = td.get_text()
                if i == 2: 
                    lose_team = td.get_text()
                    lose_team = lose_team.replace(',','.')
                if i == 3:
                    lose_score = td.get_text()
                if i == 4: 
                    date_comments = td.get_text()
                i = i + 1
            games.append(win_team + "," + lose_team  + "," + win_score + "," + lose_score + "," + date_comments)
        big_array = []
        for game in games: 
            split = game.split(',')
            big_array.append(split)


        # Write to file 
        with open(infos_directory + "game_infos", 'a', newline= '') as csvfile: 
            writer = csv.writer(csvfile)
            location = 0
            for day in big_array:
                if "(at" in day[1]: 
                    location = 2
                    index = 0
                    for char in day[1]:
                        if char == ("("): 
                            break
                        index = index + 1
                    day[1] = day[1][:index-1]
                elif "at" == day[1][:2]: #"at" in day[1]: 
                    location = 0
                elif "vs." in day[1]: 
                    location = 1
                string = ""
                ## This is for the INCREDIBLY annoying case that KHSAA doesn't include a space
                try: 
                    if day[1][:3] == "vs.":
                        if day[1][3] != " ": 
                            day[1] = day[1][:3] + " " + day[1][3:]
                except: 
                    pass
                split = day[1].split()
                for elements in split[1:]: 
                    string = string + elements + " "
                if "(overtime)" in day[4]: 
                    overtime = 1
                else: 
                    overtime = 0
                game = [file_name[14:24],str(day[0]),str(string[:-1]),day[2],day[3],location,day[4],overtime]
                
                writer.writerow(game)
                #writer.writerow({"date": file_name[14:24], "win_team": str(day[0]), "lose_team": str(string[:-1]), "win_score": day[2], "lose_score": day[3], "location": location, "date_comments": day[4], "overtime": overtime})
    print("Created Game Infos!")
    return
