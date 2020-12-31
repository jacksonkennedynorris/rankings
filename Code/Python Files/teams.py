class Team: 

    def __init__(self,name,region,id): 
        self.name = name
        self.region = region
        self.id = id
    def get_name(self):
        return self.name
    def get_region(self): 
        return self.region