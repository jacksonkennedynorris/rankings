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

# def contains(short_string, long_string): 
#     for i in range(len(long_string)-len(short_string)): 
#         for j in range(len(short_string)): 
#             if short_string[i+j] == 

def create_game_infos(season):
## Football

   #directory = os.path.normpath("C:\Users\Will\Desktop\Summer Research 2019\HS Sports Data\Football/" + year + "/HTML") ## Open and traverses through each file
    html_directory = season.get_year_path() + "/HTML/"
    infos_directory = season.get_year_path() + "/game_infos/"
    if not os.path.exists(infos_directory):  
        os.makedirs(infos_directory)
   
    #***** QUESTION FOR DR. H  ******
    #Do we want to delete all these files and start anew? 
    for file_name in os.listdir(infos_directory): 
        os.remove(infos_directory + file_name)
    time = 0 

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
                if i == 1: 
                    win_score = td.get_text()
                if i == 2: 
                    lose_team = td.get_text()
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


        
        with open(infos_directory + "game_infos", 'a') as csvfile: 
            fieldnames = ["date","win_team", "lose_team", "win_score", "lose_score", "location", "date_comments","overtime"]
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            if time == 0: 
               writer.writeheader()
            location = 0
            for day in big_array:
                if "(at" in day[1]: 
                    location = 2
                if "at" in day[1]: 
                    location = 0
                if "vs." in day[1]: 
                    location = 1
                string = ""
                split = day[1].split()
                for elements in split[1:]: 
                    string = string + elements + " "
                if "(overtime)" in day[4]: 
                    overtime = 1
                else: 
                    overtime = 0
                writer.writerow({"date": file_name[14:24], "win_team": str(day[0]), "lose_team": str(string[:-1]), "win_score": day[2], "lose_score": day[3], "location": location, "date_comments": day[4], "overtime": overtime})
        time = time + 1
    print("Created Game Infos!")
    return
