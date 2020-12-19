import random 


def get_special(num_special, my_list): 
    specials = [] 
    while num_special > 0: 
        index = random.randint(0,len(my_list) - 1)
        while my_list[index] in specials: 
            index = random.randint(0, len(my_list)-1)
        specials.append(my_list[index])
        num_special = num_special - 1 
    return specials

def del_function(member, actives, recruits):
    if member in actives: 
        actives.remove(member)
    elif member in recruits: 
        recruits.remove(member)
    return

def main(): 
        
    ## FIGURE OUT WHO'S PLAYING 
    actives = ['George', 'Tim', 'McCallum','Jnor','James','Will','Lucas']
    recruits = ['Sam', 'Dylan','Melvin','Ashton','A','B','C'] 
    already_been_mafia = []
    mafia_pool = actives + already_been_mafia
    ## HOW MANY RECRUITS DO WE WANT AS MAFIA?  
    num_recruits_mafia = 2
    ## OTHER RULES
    num_detectives = 1
    num_medics = 1

    #Compute
    number_of_players = len(actives) + len(recruits)
    num_mafia = number_of_players // 3
    num_actives_mafia = num_mafia - num_recruits_mafia

    mafia = []
    ## Figure out who the recruit mafia are
    recruits_mafia = get_special(num_recruits_mafia, recruits)
    actives_mafia = get_special(num_actives_mafia, mafia_pool)
    mafia = recruits_mafia + actives_mafia 
    for member in mafia: 
        del_function(member,actives,recruits)

    print("")
    print("There are " + str(num_mafia) + " Mafia in this game. They are: ")
    for elem in mafia: 
        print(elem)
    print("")

    total_players = actives + recruits 
    total_det_or_med = recruits + recruits + recruits + recruits + actives
    print("There is/are " + str(num_detectives) + " Detective(s) in this game. They are: ")
    detectives = get_special(num_detectives, total_det_or_med)

    for detective in detectives: 
        print(detective)
        del_function(detective,actives,recruits)
    print("")

    print("There is/are " + str(num_medics) + " Medic(s) in this game. They are: ")
    total_det_or_med = recruits + recruits + recruits + recruits + actives
    medics = get_special(num_medics, total_det_or_med)

    while medics in detectives: 
        medics = get_special(num_medics, total_det_or_med)
    for medic in medics: 
        print(medic) 
        del_function(detective,actives,recruits)
    print("")
   
    villagers = []
    for person in actives + recruits: 
        if person not in mafia and person not in detectives and person not in medics: 
            villagers.append(person)
    print("There is/are " + str(len(villagers)) + " Villagers in this game. They are: ") 
    for villager in villagers: 
        print(villager)
    print("")

main() 
