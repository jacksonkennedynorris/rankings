
from season import Season 
from create_game_infos import *
from write_HTML import write_HTML 
from create_team_tags import * 
from find_team_data import * 

def main(): 
        #**** Choose year   ******
    for year in range(2020,2021):

        #**** Choose Sport  ******
        league = "Football"  # league = "Boys Basketball"   # league = "Girls Basketball"   

        #**** Create Instance *****
        season = Season(league,year)
        #Check if year path exists 
        if not os.path.exists(season.get_year_path()):
            os.makedirs(season.get_year_path())
            
        #**** Write HTML to File
        write_HTML(season)

        #**** Create Game Infos
        create_game_infos(season)

        #**** Create Team Tags 
        #create_team_tags(season)

        #**** Find Team Data
        #find_team_data(season)
        print("Year: ", year)

main() 

