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
import glob 
from datetime import timedelta, date


def change_to_HTML_folder(season): 
        # This function takes a season and creates the data. If there appropriate directories do not exist, 
        # this function creates the directory. 
    os.chdir('../MATLAB/' + season.sport + '/Data')
    if not os.path.exists(str(season.year)):
        os.makedirs(str(season.year))
        os.chdir(str(season.year))
        os.makedirs('game_infos')
        os.makedirs('game_summaries')
        os.makedirs('home_adv')
        os.makedirs('HTML')
        os.chdir('..')
    os.chdir(str(season.year))
    os.chdir('HTML')
    return 

def return_to_python_directory():
    # Returns to python directory
    os.chdir('../../../../../Python Files')
    return

def write_HTML(season):
    #*****   Writes all the HTML to file  ******

    #Season Start and End Dates
    start_date = datetime.date(season.year,8,21)
    end_date = datetime.date(season.year,12,5)
    season_length = end_date - start_date

    change_to_HTML_folder(season)
    files = os.listdir(os.getcwd())
    for f in files: 
        os.remove(f)
    #for file in files: 
    for i in range(season_length.days + 1): # get all calendar dates of the season
        date = start_date + datetime.timedelta(days=i) # Calendar Date (YYYY-MM-DD)
        url = season.get_url_no_date() + str(date) # URL of gameday scoreboard webpage

        while True:
            try:
                day_html = urlopen(url)
                break
            except HTTPError as detail:
                    if detail.code == 500:
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
            filename = 'HTML_' + season.get_abbreviation() + "_" + str(season.year) + "_" + str(week_num) + '.txt'

            ## ** QUESTION FOR DR. H - Is it best practice to delete all the files every single time? 
            # We are using the append method because we are appending all the days of that week 
            f = open(filename, 'a')
            # if not os.path.exists(filename):
            #     f = open(filename, 'w')
            # else: 
            #     f = open(filename, 'a')

            f.write(day_soup.title.string + '\n')
            f.write(str(day_soup))
            f.close()
    return_to_python_directory()
    print('Written HTML to file!')
    return