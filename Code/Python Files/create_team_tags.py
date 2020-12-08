
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
    with open(team_tags_dir + str(season.year) + "_Team_Tags", 'a') as csvfile: 
        fieldname = [str(season.year) + " Teams"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldname)
        if time == 0: 
            writer.writeheader()
            time = time + 1
        for line in my_text: 
            writer.writerow({str(season.year) + " Teams": line})

