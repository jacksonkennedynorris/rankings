
from season import Season 
from create_game_infos import *
from create_summaries import *
from write_HTML import write_HTML 


def main(): 
    #**** Choose year   ******
    year = 2020

    #**** Choose Sport  ******
    league = "Football"  # league = "Boys Basketball"   # league = "Girls Basketball"   

    #**** Create Instance *****
    season = Season(league,year)
    
    #**** Write HTML to File
    write_HTML(season)

    #**** Create Game Infos
    #create_game_infos(season)

    #**** Create Summaries 
    #create_summaries(season)
main() 

