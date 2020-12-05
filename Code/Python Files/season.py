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
        if self.sport == "Football": 
            if self.year >= 2007: 
                url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + str(self.year)[2:4] + '?id='
            elif self.year >=1999:
                url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb' + str(self.year)[3:4] + '?id='
            elif self.year == 1998:
                url_pre = 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb?id='
        return url_pre
    def get_url_1998(self): 
        if self.sport == "Football": 
            return 'https://scoreboard.12dt.com/scoreboard/khsaa/kyfb?id='
    def get_last_two_of_year(self): 
        if self.sport == "Football": 
            if self.year >= 2010: 
                return str(self.year % 2000)
            elif self.year >= 2000: 
                return '0' + str(self.year % 2000) 
            elif self.year == 1999:
                return str(self.year%1900)
            elif self.year == 1998: 
                return ""