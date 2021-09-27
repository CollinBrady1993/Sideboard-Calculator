maindeck = readcell('maindeck.txt','delimiter',';');
sideboardOptions = readcell('sideboardOptions.txt','delimiter',';');
shift = 0;
opponentArchetypes = circshift(readcell('opponentArchetype.txt','delimiter',';'),shift);

metagameBreakdown = circshift(readmatrix('metagameBreakdown.txt','delimiter',';'),shift);
maindeckScores = circshift(readmatrix('maindeckScores.txt','delimiter',';'),shift);
sideboardScores = circshift(readmatrix('sideboardScores.txt','delimiter',';'),shift);


maindeckInScores = zeros(length(opponentArchetypes),sum(cell2mat(maindeck(:,1))));

a = 1;
for i = 1:length(opponentArchetypes)
    for j = 1:sum(cell2mat(maindeck(:,1)))
        maindeckInScores(i,j) = maindeckScores(i,a);
        %a = a+1;
        if j >= sum(cell2mat(maindeck(1:a,1)))
            a = a + 1;
        end
    %for j = 1:sum(cell2mat(maindeck(:,1)))
        
    end
    a = 1;
end

initialMaindeckMatchupScores = sum(maindeckInScores,2);
currentMaindeckMatchupScores = initialMaindeckMatchupScores;
currentSideboard = cell(15,1);
currentSideboardInScores = -3*ones(length(opponentArchetypes),15);

endCondition = 1;
itterationNum = 1;
cardAdded = 0;
data = zeros(1,1000);
while endCondition && itterationNum < 1000
    data(itterationNum) = sum(metagameBreakdown.*currentMaindeckMatchupScores);
    for i = 1:length(opponentArchetypes)
        for j = 1:length(sideboardOptions)
            for k = 1:length(currentSideboard)
                
                if sideboardScores(i,j) >= currentSideboardInScores(i,k) && ~strcmp(currentSideboard(k),sideboardOptions(j)) && sum(strcmp(sideboardOptions(j),currentSideboard)) < 4
                    
                    potentialSideboard = currentSideboard;
                    potentialSideboard(k) = sideboardOptions(j);
                    potentialSideboardInScores = currentSideboardInScores;
                    potentialSideboardInScores(:,k) = sideboardScores(:,j) - .5*sum(strcmp(sideboardOptions(j),currentSideboard));
                    
                    potentialMaindeck = [maindeckInScores,potentialSideboardInScores];
                    temp = sort(potentialMaindeck,2,'descend');
                    potentialMaindeckMatchupScores = sum(temp(:,1:sum(cell2mat(maindeck(:,1)))),2);
                    
                    %maximize the weighted average
                    %%{
                    if sum(metagameBreakdown.*potentialMaindeckMatchupScores) > sum(metagameBreakdown.*currentMaindeckMatchupScores)
                        cardAdded = 1;
                        currentSideboard = potentialSideboard;
                        currentSideboardInScores = potentialSideboardInScores;
                        currentMaindeckMatchupScores = potentialMaindeckMatchupScores;
                        break
                    end
                end
            end
            if cardAdded
                break
            end
        end
        if cardAdded
            break
        end
    end
    
    if cardAdded == 0
        endCondition = 0;
    else
        cardAdded = 0;
    end
    
    
    itterationNum = itterationNum + 1;
end



















