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

    for option in find_teams.findAll('option'):
        ids.append(option['value'])
        names.append(option.text.split('\n')[0])
    ids = ids[1:]
    for team_id in ids: 
        
        team_url = season.get_url_no_date() + team_id
        html = urlopen(team_url)
        soup = BeautifulSoup(html, 'html.parser')
        team_header = soup.find(class_ = "win_loss_title")

        
        split = team_header.getText().split()
        print(split[1])
    #     all_bold = team_header.find_all('b')

    #     split = team_header.getText().split(':')
    #     index = 0
    #     final = -1
    #     for element in split: 
    #         if "Other Seasons" in element: 
    #             final = index
    #         index = index + 1

    #     print(split)
    #     print(final)


    #     my_split = split[:7]
    #     if "" in my_split: 
    #         my_split.remove("")
        
    #     nickname_identifier = my_split[0]
    #     #print(my_split)
    #     assert nickname_identifier == "Nickname:", "Should be Nickname: , not " + nickname_identifier
    #     nickname = my_split[1][:-6]

    #     coach_identifier = my_split[1][-6:]
    #     assert coach_identifier == "Coach:", "Should be Coach: , not" + coach_identifier
    #     coach_first_name = my_split[2]
    #     coach_last_name = my_split[3][:-6]
        
    #     class_identifier = my_split[3][-6:]
    #     assert class_identifier == "Class:", "Should be Class: , not " + class_identifier
        
    #     if season.year < 2007: 

    #         region_identifier = my_split[4][-7:]
    #         my_class = my_split[4][:-7]
    #         assert region_identifier == "Region:", "Should be Region: , not " + region_identifier
    #         region = my_split[5][0]

    #         district_identifier = my_split[5][1:]
    #         assert district_identifier == "District:", "Should be District: , not " + district_identifier
    #         district = my_split[6][:-5]
    #     elif season.year >= 2007: 
    #         my_class = my_split[4][:-9]
    #         district_identifier = my_split[4][-9:]
    #         assert district_identifier == "District:", "Should be District: , not " + district_identifier 
    #         region = ""
    #         district = my_split[5][:-5]
            
    #     break
    # print(nickname, coach_first_name,coach_last_name,my_class,region,district)
    #print(ids)
    # for option in find_teams.find_all('option'): 
    #     print('value: {}, text: {}'.format(option['value'], option.text))
    #print(ids)

    #     break
    #     names.append(option.getText())
    #     print(names)
    #     break
    #print(find_teams.find_all({'id': 'value'}))
   # print(my_attr)
    # ids = ids[1:]
    # for my_id in ids: 
    #     url = season.get_url_no_date() 
    #     url = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + season.get_last_two_of_year() + '/' + my_id
    #     print(url)
    #     break
    # #print(soup.find(id = 'sel_fb' + season.get_last_two_of_year()))

