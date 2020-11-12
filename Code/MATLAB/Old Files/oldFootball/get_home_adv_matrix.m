function ptsWonWOBOs= get_home_adv_matrix(rematchmatrix)
% ptsWon = home team PD first column and away team PD second column
% Added negative sign for if team lost 

ptsWon=[];
for i=1:length(rematchmatrix)
    %If location is different for each game then continue 
    %Loc for game 1 is entry 1 and for game 2 entry 6 per row
    if rematchmatrix(i,1)~=rematchmatrix(i,6)&& rematchmatrix(i,1)~=2 && rematchmatrix(i,6)~=2
        %same team wins both games, G1=home
        if rematchmatrix(i,1)==1 && rematchmatrix(i,2)==1 && rematchmatrix(i,7)==1
            scoreDiff1=rematchmatrix(i,3);
            scoreDiff2=rematchmatrix(i,8);
     
        %if home team loses in G1 and wins while away
        elseif rematchmatrix(i,1)==1 &&rematchmatrix(i,2)==0 &&rematchmatrix(i,7)==1
            scoreDiff1= -rematchmatrix(i,3);
            scoreDiff2=rematchmatrix(i,8);
        
        %if home team wins in G1 and loses while away
        elseif rematchmatrix(i,1)==1 &&rematchmatrix(i,2)==1 &&rematchmatrix(i,7)==0
            scoreDiff1=rematchmatrix(i,3);
            scoreDiff2=-rematchmatrix(i,8);
            
        %same team loses both games, G1=home
        elseif rematchmatrix(i,1)==1&&rematchmatrix(i,2)==0 && rematchmatrix(i,7)==0
            scoreDiff1=-rematchmatrix(i,3);
            scoreDiff2=-rematchmatrix(i,8);
        
        %if away team wins in G1 and loses at home in G2
        elseif rematchmatrix(i,1)==0 &&rematchmatrix(i,2)==1 &&rematchmatrix(i,7)==0
            scoreDiff1=-rematchmatrix(i,3);
            scoreDiff2=rematchmatrix(i,8);
        
        %if away team loses in G1 and wins at home
        elseif rematchmatrix(i,1)==0 &&rematchmatrix(i,2)==0 &&rematchmatrix(i,7)==1
            scoreDiff1=rematchmatrix(i,3);
            scoreDiff2=-rematchmatrix(i,8);
        
        %Same team wins both games, G2=home
        elseif rematchmatrix(i,1)==0 &&rematchmatrix(i,2)==1 &&rematchmatrix(i,7)==1
            scoreDiff1=-rematchmatrix(i,3);
            scoreDiff2=-rematchmatrix(i,8);
         
        %Same team loses both games, G2=home
        elseif rematchmatrix(i,1)==0 &&rematchmatrix(i,2)==0 &&rematchmatrix(i,7)==0
            scoreDiff1=rematchmatrix(i,3);
            scoreDiff2=rematchmatrix(i,8);
        
        end 
        ptsWon=[ptsWon; scoreDiff1 scoreDiff2]; %#ok<AGROW>
    end
end

ptsWonWOBOs=[];
%ptsWon(find(ptsWon>35))=36;
%ptsWon(find(ptsWon<-35))=-36;
for i=1:length(ptsWon)
    if ~(min(ptsWon(i,:))> 35) && ~(max(ptsWon(i,:))<-35)
        ptsWonWOBOs=[ptsWonWOBOs;ptsWon(i,:)]; %#ok<AGROW> 
    end
end
end