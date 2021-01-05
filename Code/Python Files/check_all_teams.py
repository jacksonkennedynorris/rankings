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
 
##  This function writes every new team to our team tags if they do not have a region yet. 

## IMPORTANT****** DO NOT CALL THIS FUNCTION UNLESS YOU ALREADY HAVE A TEAM TAGS FILE READY AND ARE CHECKING ALL THE TEAMS ARE THERE!!!!!
def check_all_teams(season): 

    info = season.get_year_path() + "/game_infos/game_infos"
    teams_file = "../MATLAB/" + season.sport + "/Teams/" + str(season.year) + "_teams.txt"
    teams = []
    with open(teams_file, 'r') as csv1: 
        for line in csv1: 
            split = line.split(',')
            teams.append(split[0])

    with open(info, 'r') as csv2: 
        i = 0
        for line in csv2: 
            if i == 0: 
                i = 1 
                continue
            split = line.split(',')
            if split[0] == "\n":
                continue

            win = split[1]
            loss = split[2]

            if win == "Out of State": 
                continue
            else: 
                if win not in teams: 
                    with open(teams_file,'r') as csv_orig:
                        text = csv_orig.read()
                    with open(teams_file,'w') as csv_new:
                        csv_new.write(text)
                        csv_new.write(win + ',NaN')
                        teams.append(win)
                    print("Team " + win + " should be in the teams file for year: " + str(season.year) + " and isn't. ")
                #assert (win in teams), "Team " + win + " should be in the teams file for year: " + str(season.year) + " and isn't. "

            if loss == "Out of State":  
                continue
            else: 
                if loss not in teams: 
                    with open(teams_file,'r') as csv_orig:
                        text = csv_orig.read()
                    with open(teams_file,'w') as csv_new:
                        csv_new.write(text)
                        csv_new.write(loss + ',NaN')
                        teams.append(loss)
                    print("Team " + loss + " should be in the teams file for year: " + str(season.year) + " and isn't. ")
                     # if loss != "Out of State": 
            #     assert (loss in teams), "Team " + loss + " should be in the teams file for year: " + str(season.year) + " and isn't. "



    return 





    