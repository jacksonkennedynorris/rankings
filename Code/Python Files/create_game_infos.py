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

    edit = True  

    html_directory = season.get_year_path() + "/HTML/"
    infos_directory = season.get_year_path() + "/game_infos/"

    if not os.path.exists(infos_directory):  
        os.makedirs(infos_directory)

    #***** QUESTION FOR DR. H  ******
    #Do we want to delete all these files and start anew?
    if edit: 
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
                    #print(td)
                    link = td.find('a')
                    if link != None:
                        win_team = link.get_text()
                    else: 
                        win_team = "Out of State"                   
                    win_team = win_team.replace(',','.')
                if i == 1: 
                    win_score = td.get_text()
                if i == 2: # Calculate losing team and the location 

                    #Calculate the losing team 
                    link = td.find('a')
                    if link != None:
                        lose_team = link.get_text()
                    else: 
                        lose_team = "Out of State"                   
                    lose_team = lose_team.replace(',','.')

                    # Calculate the location 
                    the_text = td.get_text()
                    location = 0 # Default with the home team losing
                    if the_text[:2] == "vs":
                        if "(at" in the_text: 
                            location = 2
                        else: 
                            location = 1
                        
                if i == 3: 
                    lose_score = td.get_text()
                if i == 4: 
                    date_comments = td.get_text()
                i = i + 1
            games.append(win_team + "," + lose_team  + "," + win_score + "," + lose_score + "," + date_comments + ',' + str(location))
        big_array = []
        for game in games: 
            split = game.split(',')
            big_array.append(split)


        # Write to file 
        with open(infos_directory + "game_infos", 'a', newline= '') as csvfile: 
            writer = csv.writer(csvfile)
            location = 0
            for day in big_array:
                ot_flag = "overtime" in day[4] or "Overtime" in day[4]
                
                if ot_flag: 
                    overtime = 1
                else: 
                    overtime = 0

                date_split = file_name.split('_') 
                date = date_split[-1][:-4]

                game = [date,str(day[0]),str(day[1]),day[2],day[3],day[5],day[4],overtime]

                writer.writerow(game)
    print("Created Game Infos!")
    return
