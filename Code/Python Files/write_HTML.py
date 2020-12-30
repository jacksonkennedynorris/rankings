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


def use_HTML_folder(season):
        # This function takes a season and creates the data. If there appropriate directories do not exist,
        # this function creates the directory.
    if not os.path.exists(season.get_year_path() + "/HTML"):  
        os.makedirs(season.get_year_path() + "/HTML")
    
    date_array = []
    for file_name in os.listdir(season.get_year_path() + "/HTML"): 
        date_array.append(file_name[-14:-4])

    return date_array

def return_to_python_directory():
    # Returns to python directory
    os.chdir('../../../../../Python Files')
    return
def get_date_string(season, original): 
    #This function takes the table and converts it into the proper date format
    date_dictionary = {
        "January": "01",
        "February": "02", 
        "March": "03", 
        "April": "04", 
        "May": "05", 
        "June": "06", 
        "July": "07", 
        "August": "08", 
        "September": "09", 
        "October": "10", 
        "November": "11", 
        "December": "12"
    }
    split = original.split()
    month = date_dictionary[split[1]]

    if len(split[2]) == 2: 
        date = "0" + split[2][:-1]
    else: 
        date = split[2][:-1] 
    new_string = str(season.year) + "-" + month + "-" + date
    return new_string

def write_HTML(season):
    #*****   Writes all the HTML to file  ******

    date_from_files = use_HTML_folder(season)
        
    url = season.get_url_no_date()

    while True:
        try:
            day_html = urlopen(url)
            break
        except HTTPError as detail:
            if detail.code == 500:
                time.sleep(1)
                continue
    soup = BeautifulSoup(day_html, 'html.parser')
    my_string = str("sel_date_fb" + season.get_last_two_of_year())
    list_of_dates = soup.find(id = my_string)

    split = list_of_dates.getText().split()

    shorter = split[2:]
    date_array = []
    for i in range(len(shorter)):
        if i%4 == 0:
            day = shorter[i]
        if i%4 == 1:
            month = shorter[i]
        if i%4 == 2:
            date = shorter[i]
        if i%4 == 3:
            year = shorter[i]
            date_array.append(day + ' ' + month + ' ' +date + ' ' + year)

    # #Season Start and End Dates

    # create_empty_HTML_folder(season)

    for date in date_array: # get all calendar dates of the season
        #date = start_date + datetime.timedelta(days=i) # Calendar Date (YYYY-MM-DD)
         
        date_string = get_date_string(season, date)
        
        if date_string not in date_from_files: 
            # print(os.listdir(season.get_year_path() + "/HTML"))
            # if date_string
            url = season.get_url_no_date() + date_string # URL of gameday scoreboard webpage
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
            day = table.find_all('tr')[0].text # Header Row

            filename = 'HTML_' + season.get_abbreviation() + "_" + date_string + '.txt'

            # ** QUESTION FOR DR. H - Is it best practice to delete all the files every single time?
            f = open(season.get_year_path() + '/HTML/' + filename, 'w')

            f.write(day_soup.title.string + '\n')
            f.write(str(day_soup))
            f.close()

    print('Written HTML to file!')
    return