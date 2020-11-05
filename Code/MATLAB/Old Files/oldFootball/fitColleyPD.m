function [all_ratings_discrep,all_PD] = fitColleyPD(years)

HFA=0.005;
numWeeks = 20;
sport = 'Football';
all_ratings_discrep=[];
all_PD=[];

%% Iterate through the Game Matrix 
for year= years
    year = num2str(year);
    for week=10:numWeeks
%% Load matrices for old weeks and weeks+1
        [Game,PD,Loc,~,~,~,OofS,Forfeits] = loadingMatrices(year,sport,week);% Input Year, sport, and week length if applicable
        [Name,Region] = getNameAndRegion(year,sport);
        [Game,NewName,Region,OofS] = removeTeamsNoGames(Game,Name,Region,OofS);
        removed_teams = [];
        for i=1:length(Name)
            if ~ismember(NewName,Name(i))
                removed_teams = [removed_teams; i];
            end
            
        end
        [Game,PD,Loc] = removeForfeits(Game,PD,Loc,Forfeits);
        
        colleyRatings=colleyRating(Game,PD,Loc,0.05);

        % Get games from next weeks
        [NewGame,NewPD,NewLoc,~,~,~,~,Forfeits] = loadingMatrices(year,sport,week+1);
        NewGame(:,removed_teams)=[];
        [NewGame,NewPD,NewLoc] = removeForfeits(NewGame,NewPD,NewLoc,Forfeits);
        
        NewGame=NewGame(size(Game,1)+1:end,:);
        if size(NewGame,1)==0
            continue
        end
        NewPD=NewPD(length(PD)+1:end);
        NewLoc=NewLoc(length(Loc)+1:end);
        
        rating_discrep= NewGame * colleyRatings;
        
        numGames=length(NewLoc);
        HFA_adj=zeros(numGames,1);
        for i = 1:numGames
            if NewLoc(i) == 0
                HFA_adj(i) = - HFA;
            elseif NewLoc(i) == 1
                HFA_adj(i) = HFA;
            end
        end
        
        rating_discrep= rating_discrep + HFA_adj;
       
        all_ratings_discrep=[all_ratings_discrep;rating_discrep];
        
        all_PD=[all_PD;NewPD];
 
    end
end


%% Final calculation
%find(all_ratings_discrep<0)

size(all_PD)
size(all_ratings_discrep)

all_PD(find(all_ratings_discrep<0))= -all_PD(find(all_ratings_discrep<0));

all_ratings_discrep=abs(all_ratings_discrep);

scatter(all_ratings_discrep,all_PD);
lsline

polyfit(all_ratings_discrep,all_PD,1);

    


