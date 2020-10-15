function [aggregate_wp]= get_aggregate_wp(year,week_num)
%% load the raw ratings
year=num2str(year);

if week_num<10
    week_num=num2str(week_num);
    week_num=strcat('0',week_num);
else
    week_num=num2str(week_num);
end


sport='Football';

masseyFile = strcat(sport,'/',year,'/ratings/masseyRating.txt');
colleyFile = strcat(sport,'/',year,'/ratings/colleyRating.txt');
eloFile = strcat(sport,'/',year,'/ratings/eloRating.txt');

Massey = load(masseyFile);
Colley = load(colleyFile); 
Elo = load(eloFile); 

%% Load schedule and neutral 
scheduleFile=strcat('Football/',year,'/schedule_matrices/schedule_matrix_',year,'_',week_num,'.txt');
schedule=load(scheduleFile);

neutralFile=strcat('Football/',year,'/neutrals/neutral_vector_',year,'_',week_num,'.txt');
neutral_matrix=load(neutralFile);

%Schedule matrix, remove trimble county 
schedule(:,206)=[];

%% Load win percentages 
massey_wp=get_massey_wp(schedule,neutral_matrix,Massey);
colley_wp=get_colley_wp(schedule,neutral_matrix,Colley);
elo_wp=get_elo_wp(schedule,neutral_matrix,Elo);



%% Read in names
pathname=strcat('Football/', year, '/ratings/');

cd(pathname) 
nameMatrix=fopen('nameMatrix.txt','r');

names = textscan(nameMatrix,'%s','Delimiter','%\n','collectoutput',1);

cd ../../..

names=names{1};
    
for i=1:size(schedule,1)
    Hteam{i}=names{find(schedule(i,:)==1)};
    Ateam{i}=names{find(schedule(i,:)==-1)};
end 

HteamVector={};

for i=1:length(neutral_matrix)
    if neutral_matrix(i)==0
        Hteam_withAT=strcat('at'," ",Hteam{i});
        HteamVector(end+1,:)=cellstr({Hteam_withAT});
    else
        HteamVector(end+1,:)=Hteam(i);
    end
end

%% Find Average WP
av_wp=[];

for i=1:length(massey_wp)
    average_wp_equ=(massey_wp(i)+colley_wp(i)+elo_wp(i))/3;
    av_wp=[av_wp;average_wp_equ];
end
%% Total WP Matrix
aggregate_wp=[];


for i=1:length(massey_wp)
    if av_wp(i)>=0.5 && neutral_matrix(i)==0
       aggregate_wp=[aggregate_wp;num2str(av_wp(i)) HteamVector(i) Ateam(i)];
    elseif av_wp(i)<0.5 && neutral_matrix(i)==0
       aggregate_wp=[aggregate_wp; num2str((1-av_wp(i))) Ateam(i) HteamVector(i)];
    elseif av_wp(i)>=0.5 && neutral_matrix(i)==1
       aggregate_wp=[aggregate_wp; num2str(av_wp(i)) HteamVector(i) Ateam(i)];
    elseif av_wp(i)<0.5 && neutral_matrix(i)==1
       aggregate_wp=[aggregate_wp; num2str((1-av_wp(i))) Ateam(i) HteamVector(i)];
    end
    
end


cd('Football/2019/ratings')
writecell(aggregate_wp);
type 'aggregate_wp.txt';

cd ../../..

