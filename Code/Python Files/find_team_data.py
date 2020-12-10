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


def find_team_data(season): 

    url = season.get_url_no_date()
    while True:
        try:
            html = urlopen(url)
            break
        except HTTPError as detail:
            if detail.code == 500:
                time.sleep(1)
                continue
    soup = BeautifulSoup(html,'html.parser')
    
    find_teams = soup.find(id = 'sel_fb' + season.get_last_two_of_year())
    ids = []
    names = []
    print(find_teams.prettify())
    #print(find_teams.prettify())
    options = find_teams.find('option')
    # for option in find_teams.find_all('option'): 
    #     print('value: {}, text: {}'.format(option['value'], option.text))
    #print(ids)

    #     break
    #     names.append(option.getText())
    #     print(names)
    #     break
    #print(find_teams.find_all({'id': 'value'}))
    
    my_attr = options.attrs
    #print(my_attr)
    # ids = ids[1:]
    # for my_id in ids: 
    #     url = season.get_url_no_date() 
    #     url = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + season.get_last_two_of_year() + '/' + my_id
    #     print(url)
    #     break
    # #print(soup.find(id = 'sel_fb' + season.get_last_two_of_year()))

