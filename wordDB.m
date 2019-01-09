function [p1,p2,wordData] = wordDB(p1,p2,wordData)
%grabs tiles from wordData to refill dock, outputs the
%wordData database, p1 tiles and p2 tiles to be put in
%dock, referenced each turn 

if length(p1) == 0 %for first turn or when dock is completely empty 
wordData = [1:98];

for i = 1:7
p = randi(98-i-1,1); %generates tiles for user 1 
p1 = [p1 wordData(p)]; %grabs these numbers from wordData 
wordData(p) = [];
end

for i = 1:7 
p = randi(length(wordData),1); %generates tiles for p2
p2 = [p2 wordData(p)];
wordData(p) = []; %removes tiles from wordData so they cannot be used later 
end

else
    lettersInHand = length(p1); %if p1 or p2 needs less than 7 tiles 
    if lettersInHand < 7
        r = 7- (lettersInHand); %calculates how many tiles needed
        p1 = [];
        for i = 1:r
        p1AddOns = randi(length(wordData),1);
        p1 = [p1 wordData(p1AddOns)];
        wordData(p1AddOns) = []; %removes tiles from wordData
        end
    end

    if isempty(wordData) == 1
        disp('There are no tiles left!')
    end
end
end


    
