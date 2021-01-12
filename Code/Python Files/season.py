class Season: 
    def __init__(self, sport, year): 
        self.sport = sport 
        self.year = year
    def get_abbreviation(self): 
        if self.sport == "Football": 
            return "football"
        if self.sport == "Boys Basketball": 
            return "bbk"
        if self.sport == "Girls Basketball": 
            return "gbk"
    def get_date_selections(self): 
        if self.sport == "Football": 
            return "sel_date_fb" + self.get_last_two_of_year()
        if self.sport == "Boys Basketball": 
            return "sel_date_bbk" + self.get_last_two_of_year()
    def get_url_code(self): 
        if self.sport == "Football": 
            return "kyfb"
        if self.sport == "Boys Basketball": 
            return "kybbk"
        if self.sport == "Girls Basketball": 
            return "kygbk"
    def year_string(self): 
        return str(self.year)
    def prev_year(self): 
        return self.year - 1
    def prev_year_string(self): 
        return str(self.year -1)
    def get_url_no_date(self): 
        code = self.get_url_code()
        link = 'https://scoreboard.12dt.com/scoreboard/khsaa/' + code
        if self.sport == "Football": 
            if self.year >= 2007: 
                url_pre = link + str(self.year)[2:4] + '?id='
            elif self.year >=1999:
                url_pre = link + str(self.year)[3:4] + '?id='
            elif self.year == 1998:
                url_pre = link + '?id='
        elif self.sport == "Boys Basketball": 
            if self.year <= 2000: 
                num = self.year % 1991
                url_pre = link + str(num) + '?id='
            elif self.year <= 2007:
                num = self.year%2001
                url_pre = link + str(num) + '?id='
            elif self.year<2011:
                num = self.year%2001
                url_pre = link + "0" + str(num) + "?id="
            else: 
                num = self.year%2001
                url_pre = link + str(num) + "?id="
        return url_pre
    # def get_url_1998(self): 
    #     if self.sport == "Football": 
    #         return 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb?id='
    def get_last_two_of_year(self): 
        if self.sport == "Football": 
            if self.year >= 2010: 
                return str(self.year % 2000)
            elif self.year >= 2007: 
                return '0' + str(self.year % 2000) 
            elif self.year >= 2000: 
                return str(self.year % 2000)
            elif self.year == 1999:
                return str(self.year%1990)
            elif self.year == 1998: 
                return ""
        if self.sport == "Boys Basketball": 
            if self.year <= 2000: 
                return str(self.year%1991)
            elif self.year <= 2007:
                return str(self.year%2001)
            elif self.year <=2010: 
                return "0" + str(self.year%2001)
            return str(self.year%2001)
    def get_year_path(self): 
        return "../MATLAB/" + self.sport + "/Data/" + str(self.year)
    def get_teams_path(self): 
        return "../MATLAB/" + self.sport + "/Teams/" + str(self.year) + "_teams.txt"
    def is_current_season(self): 
        if self.year == 2021: 
            return True 
        return False