% Game = [1 -1 0 0 0;
%     1 0 -1 0 0; 
%     1 0 0 -1 0;
%     1 0 0 0 -1;
%     0 1 -1 0 0;
%     0 1 0 -1 0;
%     0 1 0 0 -1;
%     0 0 1 -1 0;
%     0 0 1 0 -1;
%     0 0 0 1 -1;];
% PD = [-45 -3 -31 -45 18 8 20 2 -27 -38];
% PD = PD';
% Loc = [1 1 1 1 0 0 2 0 1 1];


% %     if Y(elem)>0 %%%HERE IS THE ERROR (All the Y's are positive)
%         if Y(elem)>35 %% CALCULATE DIFFERENTIAL HERE
%             differential = 36/72;
%         else
%             differential = Y(elem)/72;
%         end
%         differential = 1/2;
%         W(i) = W(i)+differential;
%         W(j) = W(j)-differential;
% %     else 
%         if Y(elem)<-35 %% CALCULATE DIFFERENTIAL HERE
%             differential = 36/72;
%         else
%             differential = Y(elem)/72;
%         end
%         differential = 1/2;
%         W(i) = W(i)-differential;
%         W(j) = W(j)+differential;
% %     end
% 
% Imass;
% MasseyPoints = [];
% Imass;
% Icoll;
% IElo;
% randTable = table(Imass,Icoll,IElo)
% for elemMass = Imass
%     addMass = length(Imass)+1-elemMass
%     MasseyPoints = [MasseyPoints;addMass];
% end
% MasseyPoints;
% sort(MasseyPoints)
% Icoll
% ColleyPoints = [];
% for elemColl = Icoll
%     addColl = length(Icoll)+1-elemColl
%     ColleyPoints = [ColleyPoints;addColl]
% end
% IElo;
% EloPoints = []
% for elemElo = IElo
%     addElo = length(IElo)+1-elemElo
%     EloPoints = [EloPoints;addElo]
% end
% Iconglomerate = []
% for elem = 1:length(Imass)
%     massLoop = Imass(elem)
%     collLoop = Icoll(elem)
%     eloLoop = IElo(elem)
%     total = massLoop+collLoop+eloLoop;
%     Iconglomerate = [Iconglomerate;total];
% end
% Iconglomerate;
% newTable = table((MasseyPoints),(ColleyPoints),(EloPoints))
% %sort(Iconglomerate)
% % sortColley
% % sortElo




%         PD = [PD;load(pdFiles(i).name)]
%         Loc = [Loc;load(LocFiles(i).name)]



% for week = week_start:week_start+k-1
%     gameFilename = strcat(folderGames, num2str(week), '.txt');
%     PDFilename = strcat(folderPointDiff, num2str(week), '.txt');
%     LocFilename = strcat(folderLoc, num2str(week), '.txt');
%     OTFilename = strcat(folderOvertime, num2str(week), '.txt');
%     Game= [Game;load(gameFilename)];
%     PD= [PD;load(PDFilename)];
%     Loc= [Loc;load(LocFilename)];
%     OT = [OT;load(OTFilename)];



% Region
% 
% newRegionArray = [];
% if isa(RegionArray(1),'double')
%     for elem = 1:length(RegionArray)
%         num2str(RegionArray(elem))
%         newRegionArray(elem) = num2str(RegionArray(elem));
%     end
% end
% 
% newRegionArray
% 
% Region = [];
% for elem = RegionArray
%     number = str2double(elem);
%     Region = [Region;number];
% end

%     if Loc(elem) == 1 && iWL == 1
%      prediction = 1/(1+10^((R2-R1-HFA)/s));
%      R(i) = R(i) + k*(iWL-prediction);
%      R(j) = R(j) + k*(jWL-prediction);
% length(OofS(1,:))
% WorLOS = [];
% for elem = 1:length(Name) 
%     wOS = find(OofS(:,elem)==1);
%     lOS = find(OofS(:,elem)==-1);
%     winOS = length(wOS);
%     lossOS = length(lOS);
%     entry = [winOS,lossOS];
%     WorLOS = [WorLOS;entry];
% end
% WorLOS

% WorL = [];
% for elem = 1:length(Name)
%     w = find(Game(:,elem)==1);
%     l = find(Game(:,elem)==-1);
%     
%     win = length(w);
%     loss = length(l);
%     entry = [win,loss];
%     WorL = [WorL;entry];
% end

% for elem = 1:length(Name) 
%     wTemp = find(OofS(1,elem)==1);
%     lTemp = find(OofS(2,elem)==-1);
%     if wTemp == 1
%     WOS(elem) = WOS(elem)+1;
%     end
%     if lTemp == 1
%     LOS(elem) = LOS(elem)-1;
%     end
% end





% for elem = 1:length(Name) 
%     myIndex = Region(elem) 
%     whichScale = scaledAdj(myIndex) 
%     (1/3)*lastElo(elem) + (2/3)*(1500+whichScale) 
% end
% 
% 
% if firstYear
%     initElo=ones(length(Game(1,:)),1)*1500; %Transpose to be columns
% else
%     initElo = [];
%     for elem = 1:length(Name)
%         if ismember(Name(elem),OldName)
%             index = find(strcmp(OldName,Name(elem)));
%             initElo(elem) = (1/3)*Elo(index);% + (2/3)*1500;
%         else
%             initElo(elem) = 1500;
%         end
%     end
%     initElo = initElo';
% end

% initElo;
% if ~firstYear 
%     for elem = 1:length(initElo)
%         whichRegion = Region(elem);
%         adjustment = scaledAdj(whichRegion);
%         %initElo(elem) = initElo(elem) + (2/3)*1500
%     end
% end
% 
% for elem = 1:length(Region) 
%        whichRegion = Region(elem);
%        if ~isnan(whichRegion)
%            x = scaledAdj(whichRegion);
%        end
% end