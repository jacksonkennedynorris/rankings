
from bs4 import BeautifulSoup 
from urllib.request import urlopen
import urllib.error
from urllib.error import HTTPError
import os
import csv 


def create_team_tags(season): 
    team_tags_dir = season.get_year_path() + "/team_tags/"
    if not os.path.exists(team_tags_dir):  
        os.makedirs(team_tags_dir)
    for file_name in os.listdir(team_tags_dir): 
        os.remove(os.path.join(team_tags_dir,file_name))

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
    
    soup = soup.find(class_ = 'latest_stats_table')
    soup = soup.find('tr')
    my_text = soup.getText()[:-1]
    my_text = my_text.split('\n')
    time = 0 

    get_region(season)
    
    # with open(team_tags_dir + str(season.year) + "_Team_Tags", 'a') as csvfile: 
    #     writer = csv.writer(csvfile)
    #     i = 0 
    #     for line in my_text: 
    #         writer.writerow([line],regions[i])
    #         i = i+1
    # print("Created Team Tags!")


def get_region(season):
    print("HERE")
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
    names = names[1:]
    regions = []
    print(ids)
    print(names)
    assert len(ids) == len(names)
    # for team_id in ids: 
    #     print(team_id)
        
    #     team_url = season.get_url_no_date() + team_id
    #     html = urlopen(team_url)
    #     soup = BeautifulSoup(html, 'html.parser')
    #     team_header = soup.find(class_ = "win_loss_title")

        
    #     split = team_header.getText().split()
    #     if split[1] == "'Records'":
    #         regions.append("N/a")
    #         print("N/a")
    #     else:
    #         regions.append(split[1])
    #         print(split[1])
        
    return  #regions
