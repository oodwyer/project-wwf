function MainBoard(ObjH,EventData)
%this function contains the vast majority of the code,
%including plotting the tiles, the callback functions
%for moving and placing tiles, and the wordCheck
%function to calculate points and validity of words 

close all
%close all open figure windows
movingTiles = zeros(16,15);%initialize moving tiles matrix

figure('WindowButtonDownFcn',@ImagePos,...  
    'WindowButtonUpFcn',@setTile,...
    'WindowButtonMotionFcn',@moveTile,'Position',[.3 .3 1500 1500]);

hold on 
%Set up figure and board and dock image 

B=imread('boardpic.jpg');%load the board pic
%setting the axes 
axis equal
axis off
whitebg('blue')%making a blue background
image([0 15],[16 1],B)%plotting the board

D=imread('worddock.png');%loading the doc pictures
D2 = imread('worddock.png');
%plotting the two docks
image([0 7] ,[0 1],D)
image([8 15],[0 1],D2)


%Call on function wordDB to distribute initial tiles
global p1
p1 = [];
global wordData
wordData = [];
%initializing a lot of global variables so they can be
%in all of the sub functions
turn = 0; 
global points 
points = 0;
global p2points 
p2points = 0;
global p3points 
p3points = 0;
global p2
p2 = [];
global p3 
p3 = [];
global turnOver
turnOver = 1;
global skips 
skips = 0;
global winner 
winner = 0;
global points2
points2 = NaN; 

%adding push buttons to skip turn, quit the game, and
%get the rules
uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.65 0 .1 .1],'String','Skip Turn', 'CallBack',@skipTurn)

uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.9 .9 .1 .05],'String','Quit Game','CallBack',@endGame)
uicontrol('Style','Pushbutton','Units','Normalized','Position',[0 .9 .1 .05],'String','Rules','CallBack',@showRules)

%skip turns function
    function skipTurn(~,~) %who wins if the game has turn has been skipped too many times
        if p2points > p3points 
            winner = 1;
        elseif p2points < p3points
            winner = 2;
        else
            winner = 3;
        end
        if turn == 1 || turn == 0
            turn = 2;
            set(b,'String','Player 2 Turn','position',[.315 .11 .2 .05]);
        elseif turn == 2
            turn = 1;
            set(b,'String','Player 1 Turn','position',[.515 .11 .2 .05]);
        end
        skips = skips + 1; %creating a counter for how many times a turn is skipped in a row
        if skips == 3 && (winner == 1 || winner == 2) %if 3 turns have been skipped the game is over and the winner is displayed
            S = annotation('textbox','position',[.25 .25 .5 .3],'String',['Game Over! Player ' num2str(winner) ' wins!'],'BackgroundColor','w','FontSize',30);
            S.HorizontalAlignment = 'center';
            S.VerticalAlignment = 'middle';
        elseif skips == 3 && winner == 3 
            S = annotation('textbox','position',[.25 .4 .5 .3],'String','Game Over! Everybody Wins!','BackgroundColor','w','FontSize',30);
            S.HorizontalAlignment = 'center';
            S.VerticalAlignment = 'middle';
        else
        end
    end

    function endGame(~,~)
        close all
        %when the game ends close all windows
    end

    function showRules(~,~) %places rules in sight when user clicks on button 
         R = annotation('textbox','position',[0 .45 .2 .45],'String','RULES: 1. Player 1 begins by placing two or more letters to form a complete word either vertically or horizontally on spaces on the board. Diagonal words are not allowed. Click the Submit Word button to receive points. 2. After a valid word has been played, refill your dock by clicking the Get New Tiles button. 3. The turn will switch and Player 2 must play a word connected to existing words on the board. The new word must use one of the letters already on the board or must add a letter to it. 4. No tile may be shifted or replaced after it has been played and scored. 5. The game ends when all letters have been drawn and one player uses his or her last tile, or when the Skip Turn button has been used in three consecutive turns. The player will the highest number of points wins.','BackgroundColor','w','FontSize',14);
    end


%Call on function dockPlot to distribute tiles to dock 
% p1Board = dockPlot(p1);
%load all of the tile files
A_tile=imread('A.png');
A2_tile = imread('A.png');
A3_tile = imread('A.png');
A4_tile = imread('A.png');
A5_tile = imread('A.png');
A6_tile = imread('A.png');
A7_tile = imread('A.png');
A8_tile = imread('A.png');
A9_tile = imread('A.png');
B_tile=imread('B.png');
B11_tile = imread('B.png');
C_tile=imread('C.png');
C13_tile = imread('C.png');
D_tile=imread('D.png');
D15_tile = imread('D.png');
D16_tile = imread('D.png');
D17_tile = imread('D.png');
E_tile=imread('E.png');
E19_tile = imread('E.png');
E20_tile = imread('E.png');
E21_tile = imread('E.png');
E22_tile = imread('E.png');
E23_tile = imread('E.png');
E24_tile = imread('E.png');
E25_tile = imread('E.png');
E26_tile = imread('E.png');
E27_tile = imread('E.png');
E28_tile = imread('E.png');
E29_tile = imread('E.png');
F_tile=imread('F.png');
F31_tile = imread('F.png');
G_tile=imread('G.png');
G33_tile=imread('G.png');
G34_tile=imread('G.png');
H_tile=imread('H.png');
H36_tile=imread('H.png');
I_tile=imread('I.png');
I38_tile=imread('I.png');
I39_tile=imread('I.png');
I40_tile=imread('I.png');
I41_tile=imread('I.png');
I42_tile=imread('I.png');
I43_tile=imread('I.png');
I44_tile=imread('I.png');
I45_tile=imread('I.png');
J_tile=imread('J.png');
K_tile=imread('K.png');
L_tile=imread('L.png');
L49_tile=imread('L.png');
L50_tile=imread('L.png');
L51_tile=imread('L.png');
M_tile=imread('M.png');
M53_tile=imread('M.png');
N_tile=imread('N.png');
N55_tile=imread('N.png');
N56_tile=imread('N.png');
N57_tile=imread('N.png');
N58_tile=imread('N.png');
N59_tile=imread('N.png');
O_tile=imread('O.png');
O61_tile=imread('O.png');
O62_tile=imread('O.png');
O63_tile=imread('O.png');
O64_tile=imread('O.png');
O65_tile=imread('O.png');
O66_tile=imread('O.png');
O67_tile=imread('O.png');
P_tile=imread('P.png');
P69_tile=imread('P.png');
Q_tile=imread('Q.png');
R_tile=imread('R.png');
R72_tile=imread('R.png');
R73_tile=imread('R.png');
R74_tile=imread('R.png');
R75_tile=imread('R.png');
R76_tile=imread('R.png');
S_tile=imread('S.png');
S78_tile=imread('S.png');
S79_tile=imread('S.png');
S80_tile=imread('S.png');
T_tile=imread('T.png');
T82_tile=imread('T.png');
T83_tile=imread('T.png');
T84_tile=imread('T.png');
T85_tile=imread('T.png');
T86_tile=imread('T.png');
U_tile=imread('U.png');
U88_tile=imread('U.png');
U89_tile=imread('U.png');
U90_tile=imread('U.png');
V_tile=imread('V.png');
V92_tile=imread('V.png');
W_tile=imread('W.png');
W94_tile=imread('W.png');
X_tile=imread('X.png');
Y_tile=imread('Y.png');
Y97_tile=imread('Y.png');
Z_tile=imread('Z.png');

p1Board = zeros(16,15);

   function dockPlot1(~,~,p1,p2)
   if turnOver == 1 
   if turn == 0%starting with the turn as zero so it will switch to 1
       %this is only for the first turn everytime after
       %this it will only plot tiles in the dock when
       %turn = 1 or 2
       dock = p1Board(16,1:7) ~= 0;
        lastRow = p1Board(16,1:7);
        p1 = lastRow(dock);%mappin gp1 to where the tiles in the doc are for player 1
        
        dock = p1Board(16,8:15) ~= 0;
        lastRow = p1Board(16,8:15);
        p2 = lastRow(dock);%making p2 player 2 dock
        
        [p1,p2,wordData] = wordDB(p1,p2,wordData);%giving each player tiles 
        set(w,'String',['Tiles remaining:' num2str(length(wordData))])%string that shows how many tiles are left
        j = 1;
        %if a tile is in p1 or p2 dock it is plotted to
        %the corresponding dock location on the board
    for i = 1:length(p1) 
        while p1Board(16,0+j) ~= 0
            j = j+1;
        end
        if p1(i) == 1
            A_tile = image([j-1 j],[1 0],A_tile);
             p1Board(16,0+j) = 1;
        elseif p1(i) == 2
            A2_tile = image([j-1 j],[1 0],A2_tile);
            p1Board(16,0+j) = 2;
        elseif p1(i) == 3
            A3_tile = image([j-1 j],[1 0],A3_tile);
            p1Board(16,0+j) = 3;
        elseif p1(i) == 4
            A4_tile = image([j-1 j],[1 0],A4_tile);
            p1Board(16,0+j) = 4;
        elseif p1(i) == 5
            A5_tile = image([j-1 j],[1 0],A5_tile);
            p1Board(16,0+j) = 5;
        elseif p1(i) == 6
            A6_tile = image([j-1 j],[1 0],A6_tile);
            p1Board(16,0+j) = 6;
        elseif p1(i) == 7
            A7_tile = image([j-1 j],[1 0],A7_tile);
            p1Board(16,0+j) = 7;
       elseif p1(i) == 8
            A8_tile = image([j-1 j],[1 0],A8_tile);
            p1Board(16,0+j) = 8;
        elseif p1(i) == 9
            A9_tile = image([j-1 j],[1 0],A9_tile);
            p1Board(16,0+j) = 9;
        elseif p1(i) == 10
             B_tile = image([j-1 j],[1 0],B_tile);
             p1Board(16,0+j) = 10;
        elseif p1(i) == 11
             B11_tile = image([j-1 j],[1 0],B11_tile);
             p1Board(16,0+j) = 11;
        elseif p1(i) == 12
             C_tile = image([j-1 j],[1 0],C_tile);
             p1Board(16,0+j) = 12;
        elseif p1(i) == 13
             C13_tile = image([j-1 j],[1 0],C13_tile);
             p1Board(16,0+j) = 13;
        elseif p1(i) == 14
            D_tile = image([j-1 j],[1 0],D_tile);
            p1Board(16,0+j) = 14;
        elseif p1(i) == 15
            D15_tile = image([j-1 j],[1 0],D15_tile);
             p1Board(16,0+j) = 15;
        elseif p1(i) == 16
             D16_tile = image([j-1 j],[1 0],D16_tile);
             p1Board(16,0+j) = 16;
        elseif p1(i) == 17
             D17_tile = image([j-1 j],[1 0],D17_tile);
             p1Board(16,0+j) = 17;
        elseif p1(i) == 18
            E_tile = image([j-1 j],[1 0],E_tile);
            p1Board(16,0+j) = 18;
        elseif p1(i) == 19
            E19_tile = image([j-1 j],[1 0],E19_tile);
            p1Board(16,0+j) = 19;    
        elseif p1(i) == 20
             E20_tile = image([j-1 j],[1 0],E20_tile);
             p1Board(16,0+j) = 20;
        elseif p1(i) == 21
             E21_tile = image([j-1 j],[1 0],E21_tile);
             p1Board(16,0+j) = 21;
        elseif p1(i) == 22
             E22_tile = image([j-1 j],[1 0],E22_tile);
             p1Board(16,0+j) = 22;
        elseif p1(i) == 23
            E23_tile = image([j-1 j],[1 0],E23_tile);
            p1Board(16,0+j) = 23;
        elseif p1(i) == 24
            E24_tile = image([j-1 j],[1 0],E24_tile);
             p1Board(16,0+j) = 24;
        elseif p1(i) == 25
             E25_tile = image([j-1 j],[1 0],E25_tile);
             p1Board(16,0+j) = 25;
        elseif p1(i) == 26
             E26_tile = image([j-1 j],[1 0],E26_tile);
             p1Board(16,0+j) = 26;
        elseif p1(i) == 27
            E27_tile = image([j-1 j],[1 0],E27_tile);
            p1Board(16,0+j) = 27;
        elseif p1(i) == 28
             E28_tile = image([j-1 j],[1 0],E28_tile);
             p1Board(16,0+j) = 28;
        elseif p1(i) == 29
             E29_tile = image([j-1 j],[1 0],E29_tile);
             p1Board(16,0+j) = 29;
        elseif p1(i) == 30
             F_tile = image([j-1 j],[1 0],F_tile);
             p1Board(16,0+j) = 30;
        elseif p1(i) == 31
            F31_tile = image([j-1 j],[1 0],F31_tile);
            p1Board(16,0+j) = 31;
        elseif p1(i) == 32
             G_tile = image([j-1 j],[1 0],G_tile);
             p1Board(16,0+j) = 32;
        elseif p1(i) == 33
            G33_tile = image([j-1 j],[1 0],G33_tile);
             p1Board(16,0+j) = 33;
        elseif p1(i) == 34
             G34_tile = image([j-1 j],[1 0],G34_tile);
             p1Board(16,0+j) = 34;
        elseif p1(i) == 35
            H_tile = image([j-1 j],[1 0],H_tile);
            p1Board(16,0+j) = 35;
        elseif p1(i) == 36
            H36_tile = image([j-1 j],[1 0],H36_tile);
            p1Board(16,0+j) = 36;
        elseif p1(i) == 37
            I_tile = image([j-1 j],[1 0],I_tile);
            p1Board(16,0+j) = 37;
        elseif p1(i) == 38
            I38_tile = image([j-1 j],[1 0],I38_tile);
            p1Board(16,0+j) = 38;
        elseif p1(i) == 39
            I39_tile = image([j-1 j],[1 0],I39_tile);
            p1Board(16,0+j) = 39;
        elseif p1(i) == 40
            I40_tile = image([j-1 j],[1 0],I40_tile);
            p1Board(16,0+j) = 40;
        elseif p1(i) == 41
            I41_tile = image([j-1 j],[1 0],I41_tile);
            p1Board(16,0+j) = 41;
       elseif p1(i) == 42
            I42_tile = image([j-1 j],[1 0],I42_tile);
            p1Board(16,0+j) = 42;
        elseif p1(i) == 43
            I43_tile = image([j-1 j],[1 0],I43_tile);
            p1Board(16,0+j) = 43;
        elseif p1(i) == 44
             I44_tile = image([j-1 j],[1 0],I44_tile);
             p1Board(16,0+j) = 44;
        elseif p1(i) == 45
             I45_tile = image([j-1 j],[1 0],I45_tile);
             p1Board(16,0+j) = 45;
        elseif p1(i) == 46
             J_tile = image([j-1 j],[1 0],J_tile);
             p1Board(16,0+j) = 46;
        elseif p1(i) == 47
             K_tile = image([j-1 j],[1 0],K_tile);
             p1Board(16,0+j) = 47;
        elseif p1(i) == 48
            L_tile = image([j-1 j],[1 0],L_tile);
            p1Board(16,0+j) = 48;
        elseif p1(i) == 49
            L49_tile = image([j-1 j],[1 0],L49_tile);
             p1Board(16,0+j) = 49;
        elseif p1(i) == 50
             L50_tile = image([j-1 j],[1 0],L50_tile);
             p1Board(16,0+j) = 50;
        elseif p1(i) == 51
             L51_tile = image([j-1 j],[1 0],L51_tile);
             p1Board(16,0+j) = 51;
        elseif p1(i) == 52
            M_tile = image([j-1 j],[1 0],M_tile);
            p1Board(16,0+j) = 52;
        elseif p1(i) == 53
            M53_tile = image([j-1 j],[1 0],M53_tile);
            p1Board(16,0+j) = 53;    
        elseif p1(i) == 54
             N_tile = image([j-1 j],[1 0],N_tile);
             p1Board(16,0+j) = 54;
        elseif p1(i) == 55
             N55_tile = image([j-1 j],[1 0],N55_tile);
             p1Board(16,0+j) = 55;
        elseif p1(i) == 56
             N56_tile = image([j-1 j],[1 0],N56_tile);
             p1Board(16,0+j) = 56;
        elseif p1(i) == 57
            N57_tile = image([j-1 j],[1 0],N57_tile);
            p1Board(16,0+j) = 57;
        elseif p1(i) == 58
            N58_tile = image([j-1 j],[1 0],N58_tile);
             p1Board(16,0+j) = 58;
        elseif p1(i) == 59
             N59_tile = image([j-1 j],[1 0],N59_tile);
             p1Board(16,0+j) = 59;
        elseif p1(i) == 60
             O_tile = image([j-1 j],[1 0],O_tile);
             p1Board(16,0+j) = 60;
        elseif p1(i) == 61
            O61_tile = image([j-1 j],[1 0],O61_tile);
            p1Board(16,0+j) = 61;
        elseif p1(i) == 62
             O62_tile = image([j-1 j],[1 0],O62_tile);
             p1Board(16,0+j) = 62;
        elseif p1(i) == 63
             O63_tile = image([j-1 j],[1 0],O63_tile);
             p1Board(16,0+j) = 63;
        elseif p1(i) == 64
             O64_tile = image([j-1 j],[1 0],O64_tile);
             p1Board(16,0+j) = 64;
        elseif p1(i) == 65
            O65_tile = image([j-1 j],[1 0],O65_tile);
            p1Board(16,0+j) = 65;
        elseif p1(i) == 66
             O66_tile = image([j-1 j],[1 0],O66_tile);
             p1Board(16,0+j) = 66;
        elseif p1(i) == 67
            O67_tile = image([j-1 j],[1 0],O67_tile);
             p1Board(16,0+j) = 67;
        elseif p1(i) == 68
             P_tile = image([j-1 j],[1 0],P_tile);
             p1Board(16,0+j) = 68;
        elseif p1(i) == 69
            P69_tile = image([j-1 j],[1 0],P69_tile);
            p1Board(16,0+j) = 69; 
        elseif p1(i) == 70
            Q_tile = image([j-1 j],[1 0],Q_tile);
            p1Board(16,0+j) = 70;
        elseif p1(i) == 71
            R_tile = image([j-1 j],[1 0],R_tile);
            p1Board(16,0+j) = 71;
        elseif p1(i) == 72
            R72_tile = image([j-1 j],[1 0],R72_tile);
            p1Board(16,0+j) = 72;
        elseif p1(i) == 73
            R73_tile = image([j-1 j],[1 0],R73_tile);
            p1Board(16,0+j) = 73;
        elseif p1(i) == 74
            R74_tile = image([j-1 j],[1 0],R74_tile);
            p1Board(16,0+j) = 74;
        elseif p1(i) == 75
            R75_tile = image([j-1 j],[1 0],R75_tile);
            p1Board(16,0+j) = 75;
       elseif p1(i) == 76
            R76_tile = image([j-1 j],[1 0],R76_tile);
            p1Board(16,0+j) = 76;
        elseif p1(i) == 77
            S_tile = image([j-1 j],[1 0],S_tile);
            p1Board(16,0+j) = 77;
        elseif p1(i) == 78
             S78_tile = image([j-1 j],[1 0],S78_tile);
             p1Board(16,0+j) = 78;
        elseif p1(i) == 79
             S79_tile = image([j-1 j],[1 0],S79_tile);
             p1Board(16,0+j) = 79;
        elseif p1(i) == 80
             S80_tile = image([j-1 j],[1 0],S80_tile);
             p1Board(16,0+j) = 80;
        elseif p1(i) == 81
             T_tile = image([j-1 j],[1 0],T_tile);
             p1Board(16,0+j) = 81;
        elseif p1(i) == 82
            T82_tile = image([j-1 j],[1 0],T82_tile);
            p1Board(16,0+j) = 82;
        elseif p1(i) == 83
            T83_tile = image([j-1 j],[1 0],T83_tile);
             p1Board(16,0+j) = 83;
        elseif p1(i) == 84
             T84_tile = image([j-1 j],[1 0],T84_tile);
             p1Board(16,0+j) = 84;
        elseif p1(i) == 85
             T85_tile = image([j-1 j],[1 0],T85_tile);
             p1Board(16,0+j) = 85;
        elseif p1(i) == 86
            T86_tile = image([j-1 j],[1 0],T86_tile);
            p1Board(16,0+j) = 86;
        elseif p1(i) == 87
            U_tile = image([j-1 j],[1 0],U_tile);
            p1Board(16,0+j) = 87;    
        elseif p1(i) == 88
             U88_tile = image([j-1 j],[1 0],U88_tile);
             p1Board(16,0+j) = 88;
        elseif p1(i) == 89
             U89_tile = image([j-1 j],[1 0],U89_tile);
             p1Board(16,0+j) = 89;
        elseif p1(i) == 90
             U90_tile = image([j-1 j],[1 0],U90_tile);
             p1Board(16,0+j) = 90;
        elseif p1(i) == 91
            V_tile = image([j-1 j],[1 0],V_tile);
            p1Board(16,0+j) = 91;
        elseif p1(i) == 92
            V92_tile = image([j-1 j],[1 0],V92_tile);
             p1Board(16,0+j) = 92;
        elseif p1(i) == 93
             W_tile = image([j-1 j],[1 0],W_tile);
             p1Board(16,0+j) = 93;
        elseif p1(i) == 94
             W94_tile = image([j-1 j],[1 0],W94_tile);
             p1Board(16,0+j) = 94;
        elseif p1(i) == 95
            X_tile = image([j-1 j],[1 0],X_tile);
            p1Board(16,0+j) = 95;
        elseif p1(i) == 96
             Y_tile = image([j-1 j],[1 0],Y_tile);
             p1Board(16,0+j) = 96;
        elseif p1(i) == 97
             Y97_tile = image([j-1 j],[1 0],Y97_tile);
             p1Board(16,0+j) = 97;
        elseif p1(i) == 98
             Z_tile = image([j-1 j],[1 0],Z_tile);
             p1Board(16,0+j) = 98;
        else
        end
    end
    
    %make a textbox that shows the tiles remaining 
        set(w,'String',['Tiles remaining:' num2str(length(wordData))])
        j = 1;
    for i = 1:length(p2) % repeating what was done previously to get the tiles for player 1 to plot on the board
        while p1Board(16,8+j) ~= 0
            j = j+1;
        end
        if p2(i) == 1
            A_tile = image([7+j 8+j],[1 0],A_tile);
             p1Board(16,8+j) = 1;
        elseif p2(i) == 2
            A2_tile = image([7+j 8+j],[1 0],A2_tile);
            p1Board(16,8+j) = 2;
        elseif p2(i) == 3
            A3_tile = image([7+j 8+j],[1 0],A3_tile);
            p1Board(16,8+j) = 3;
        elseif p2(i) == 4
            A4_tile = image([7+j 8+j],[1 0],A4_tile);
            p1Board(16,8+j) = 4;
        elseif p2(i) == 5
            A5_tile = image([7+j 8+j],[1 0],A5_tile);
            p1Board(16,8+j) = 5;
        elseif p2(i) == 6
            A6_tile = image([7+j 8+j],[1 0],A6_tile);
            p1Board(16,8+j) = 6;
        elseif p2(i) == 7
            A7_tile = image([7+j 8+j],[1 0],A7_tile);
            p1Board(16,8+j) = 7;
       elseif p2(i) == 8
            A8_tile = image([7+j 8+j],[1 0],A8_tile);
            p1Board(16,8+j) = 8;
        elseif p2(i) == 9
            A9_tile = image([7+j 8+j],[1 0],A9_tile);
            p1Board(16,8+j) = 9;
        elseif p2(i) == 10
             B_tile = image([7+j 8+j],[1 0],B_tile);
             p1Board(16,8+j) = 10;
        elseif p2(i) == 11
             B11_tile = image([7+j 8+j],[1 0],B11_tile);
             p1Board(16,8+j) = 11;
        elseif p2(i) == 12
             C_tile = image([7+j 8+j],[1 0],C_tile);
             p1Board(16,8+j) = 12;
        elseif p2(i) == 13
             C13_tile = image([7+j 8+j],[1 0],C13_tile);
             p1Board(16,8+j) = 13;
        elseif p2(i) == 14
            D_tile = image([7+j 8+j],[1 0],D_tile);
            p1Board(16,8+j) = 14;
        elseif p2(i) == 15
            D15_tile = image([7+j 8+j],[1 0],D15_tile);
             p1Board(16,8+j) = 15;
        elseif p2(i) == 16
             D16_tile = image([7+j 8+j],[1 0],D16_tile);
             p1Board(16,8+j) = 16;
        elseif p2(i) == 17
             D17_tile = image([7+j 8+j],[1 0],D17_tile);
             p1Board(16,8+j) = 17;
        elseif p2(i) == 18
            E_tile = image([7+j 8+j],[1 0],E_tile);
            p1Board(16,8+j) = 18;
        elseif p2(i) == 19
            E19_tile = image([7+j 8+j],[1 0],E19_tile);
            p1Board(16,8+j) = 19;    
        elseif p2(i) == 20
             E20_tile = image([7+j 8+j],[1 0],E20_tile);
             p1Board(16,8+j) = 20;
        elseif p2(i) == 21
             E21_tile = image([7+j 8+j],[1 0],E21_tile);
             p1Board(16,8+j) = 21;
        elseif p2(i) == 22
             E22_tile = image([7+j 8+j],[1 0],E22_tile);
             p1Board(16,8+j) = 22;
        elseif p2(i) == 23
            E23_tile = image([7+j 8+j],[1 0],E23_tile);
            p1Board(16,8+j) = 23;
        elseif p2(i) == 24
            E24_tile = image([7+j 8+j],[1 0],E24_tile);
             p1Board(16,8+j) = 24;
        elseif p2(i) == 25
             E25_tile = image([7+j 8+j],[1 0],E25_tile);
             p1Board(16,8+j) = 25;
        elseif p2(i) == 26
             E26_tile = image([7+j 8+j],[1 0],E26_tile);
             p1Board(16,8+j) = 26;
        elseif p2(i) == 27
            E27_tile = image([7+j 8+j],[1 0],E27_tile);
            p1Board(16,8+j) = 27;
        elseif p2(i) == 28
             E28_tile = image([7+j 8+j],[1 0],E28_tile);
             p1Board(16,8+j) = 28;
        elseif p2(i) == 29
             E29_tile = image([7+j 8+j],[1 0],E29_tile);
             p1Board(16,8+j) = 29;
        elseif p2(i) == 30
             F_tile = image([7+j 8+j],[1 0],F_tile);
             p1Board(16,8+j) = 30;
        elseif p2(i) == 31
            F31_tile = image([7+j 8+j],[1 0],F31_tile);
            p1Board(16,8+j) = 31;
        elseif p2(i) == 32
             G_tile = image([7+j 8+j],[1 0],G_tile);
             p1Board(16,8+j) = 32;
        elseif p2(i) == 33
            G33_tile = image([7+j 8+j],[1 0],G33_tile);
             p1Board(16,8+j) = 33;
        elseif p2(i) == 34
             G34_tile = image([7+j 8+j],[1 0],G34_tile);
             p1Board(16,8+j) = 34;
        elseif p2(i) == 35
            H_tile = image([7+j 8+j],[1 0],H_tile);
            p1Board(16,8+j) = 35;
        elseif p2(i) == 36
            H36_tile = image([7+j 8+j],[1 0],H36_tile);
            p1Board(16,8+j) = 36;
        elseif p2(i) == 37
            I_tile = image([7+j 8+j],[1 0],I_tile);
            p1Board(16,8+j) = 37;
        elseif p2(i) == 38
            I38_tile = image([7+j 8+j],[1 0],I38_tile);
            p1Board(16,8+j) = 38;
        elseif p2(i) == 39
            I39_tile = image([7+j 8+j],[1 0],I39_tile);
            p1Board(16,8+j) = 39;
        elseif p2(i) == 40
            I40_tile = image([7+j 8+j],[1 0],I40_tile);
            p1Board(16,8+j) = 40;
        elseif p2(i) == 41
            I41_tile = image([7+j 8+j],[1 0],I41_tile);
            p1Board(16,8+j) = 41;
       elseif p2(i) == 42
            I42_tile = image([7+j 8+j],[1 0],I42_tile);
            p1Board(16,8+j) = 42;
        elseif p2(i) == 43
            I43_tile = image([7+j 8+j],[1 0],I43_tile);
            p1Board(16,8+j) = 43;
        elseif p2(i) == 44
             I44_tile = image([7+j 8+j],[1 0],I44_tile);
             p1Board(16,8+j) = 44;
        elseif p2(i) == 45
             I45_tile = image([7+j 8+j],[1 0],I45_tile);
             p1Board(16,8+j) = 45;
        elseif p2(i) == 46
             J_tile = image([7+j 8+j],[1 0],J_tile);
             p1Board(16,8+j) = 46;
        elseif p2(i) == 47
             K_tile = image([7+j 8+j],[1 0],K_tile);
             p1Board(16,8+j) = 47;
        elseif p2(i) == 48
            L_tile = image([7+j 8+j],[1 0],L_tile);
            p1Board(16,8+j) = 48;
        elseif p2(i) == 49
            L49_tile = image([7+j 8+j],[1 0],L49_tile);
             p1Board(16,8+j) = 49;
        elseif p2(i) == 50
             L50_tile = image([7+j 8+j],[1 0],L50_tile);
             p1Board(16,8+j) = 50;
        elseif p2(i) == 51
             L51_tile = image([7+j 8+j],[1 0],L51_tile);
             p1Board(16,8+j) = 51;
        elseif p2(i) == 52
            M_tile = image([7+j 8+j],[1 0],M_tile);
            p1Board(16,8+j) = 52;
        elseif p2(i) == 53
            M53_tile = image([7+j 8+j],[1 0],M53_tile);
            p1Board(16,8+j) = 53;    
        elseif p2(i) == 54
             N_tile = image([7+j 8+j],[1 0],N_tile);
             p1Board(16,8+j) = 54;
        elseif p2(i) == 55
             N55_tile = image([7+j 8+j],[1 0],N55_tile);
             p1Board(16,8+j) = 55;
        elseif p2(i) == 56
             N56_tile = image([7+j 8+j],[1 0],N56_tile);
             p1Board(16,8+j) = 56;
        elseif p2(i) == 57
            N57_tile = image([7+j 8+j],[1 0],N57_tile);
            p1Board(16,8+j) = 57;
        elseif p2(i) == 58
            N58_tile = image([7+j 8+j],[1 0],N58_tile);
             p1Board(16,8+j) = 58;
        elseif p2(i) == 59
             N59_tile = image([7+j 8+j],[1 0],N59_tile);
             p1Board(16,8+j) = 59;
        elseif p2(i) == 60
             O_tile = image([7+j 8+j],[1 0],O_tile);
             p1Board(16,8+j) = 60;
        elseif p2(i) == 61
            O61_tile = image([7+j 8+j],[1 0],O61_tile);
            p1Board(16,8+j) = 61;
        elseif p2(i) == 62
             O62_tile = image([7+j 8+j],[1 0],O62_tile);
             p1Board(16,8+j) = 62;
        elseif p2(i) == 63
             O63_tile = image([7+j 8+j],[1 0],O63_tile);
             p1Board(16,8+j) = 63;
        elseif p2(i) == 64
             O64_tile = image([7+j 8+j],[1 0],O64_tile);
             p1Board(16,8+j) = 64;
        elseif p2(i) == 65
            O65_tile = image([7+j 8+j],[1 0],O65_tile);
            p1Board(16,8+j) = 65;
        elseif p2(i) == 66
             O66_tile = image([7+j 8+j],[1 0],O66_tile);
             p1Board(16,8+j) = 66;
        elseif p2(i) == 67
            O67_tile = image([7+j 8+j],[1 0],O67_tile);
             p1Board(16,8+j) = 67;
        elseif p2(i) == 68
             P_tile = image([7+j 8+j],[1 0],P_tile);
             p1Board(16,8+j) = 68;
        elseif p2(i) == 69
            P69_tile = image([7+j 8+j],[1 0],P69_tile);
            p1Board(16,8+j) = 69; 
        elseif p2(i) == 70
            Q_tile = image([7+j 8+j],[1 0],Q_tile);
            p1Board(16,8+j) = 70;
        elseif p2(i) == 71
            R_tile = image([7+j 8+j],[1 0],R_tile);
            p1Board(16,8+j) = 71;
        elseif p2(i) == 72
            R72_tile = image([7+j 8+j],[1 0],R72_tile);
            p1Board(16,8+j) = 72;
        elseif p2(i) == 73
            R73_tile = image([7+j 8+j],[1 0],R73_tile);
            p1Board(16,8+j) = 73;
        elseif p2(i) == 74
            R74_tile = image([7+j 8+j],[1 0],R74_tile);
            p1Board(16,8+j) = 74;
        elseif p2(i) == 75
            R75_tile = image([7+j 8+j],[1 0],R75_tile);
            p1Board(16,8+j) = 75;
       elseif p2(i) == 76
            R76_tile = image([7+j 8+j],[1 0],R76_tile);
            p1Board(16,8+j) = 76;
        elseif p2(i) == 77
            S_tile = image([7+j 8+j],[1 0],S_tile);
            p1Board(16,8+j) = 77;
        elseif p2(i) == 78
             S78_tile = image([7+j 8+j],[1 0],S78_tile);
             p1Board(16,8+j) = 78;
        elseif p2(i) == 79
             S79_tile = image([7+j 8+j],[1 0],S79_tile);
             p1Board(16,8+j) = 79;
        elseif p2(i) == 80
             S80_tile = image([7+j 8+j],[1 0],S80_tile);
             p1Board(16,8+j) = 80;
        elseif p2(i) == 81
             T_tile = image([7+j 8+j],[1 0],T_tile);
             p1Board(16,8+j) = 81;
        elseif p2(i) == 82
            T82_tile = image([7+j 8+j],[1 0],T82_tile);
            p1Board(16,8+j) = 82;
        elseif p2(i) == 83
            T83_tile = image([7+j 8+j],[1 0],T83_tile);
             p1Board(16,8+j) = 83;
        elseif p2(i) == 84
             T84_tile = image([7+j 8+j],[1 0],T84_tile);
             p1Board(16,8+j) = 84;
        elseif p2(i) == 85
             T85_tile = image([7+j 8+j],[1 0],T85_tile);
             p1Board(16,8+j) = 85;
        elseif p2(i) == 86
            T86_tile = image([7+j 8+j],[1 0],T86_tile);
            p1Board(16,8+j) = 86;
        elseif p2(i) == 87
            U_tile = image([7+j 8+j],[1 0],U_tile);
            p1Board(16,8+j) = 87;    
        elseif p2(i) == 88
             U88_tile = image([7+j 8+j],[1 0],U88_tile);
             p1Board(16,8+j) = 88;
        elseif p2(i) == 89
             U89_tile = image([7+j 8+j],[1 0],U89_tile);
             p1Board(16,8+j) = 89;
        elseif p2(i) == 90
             U90_tile = image([7+j 8+j],[1 0],U90_tile);
             p1Board(16,8+j) = 90;
        elseif p2(i) == 91
            V_tile = image([7+j 8+j],[1 0],V_tile);
            p1Board(16,8+j) = 91;
        elseif p2(i) == 92
            V92_tile = image([7+j 8+j],[1 0],V92_tile);
             p1Board(16,8+j) = 92;
        elseif p2(i) == 93
             W_tile = image([7+j 8+j],[1 0],W_tile);
             p1Board(16,8+j) = 93;
        elseif p2(i) == 94
             W94_tile = image([7+j 8+j],[1 0],W94_tile);
             p1Board(16,8+j) = 94;
        elseif p2(i) == 95
            X_tile = image([7+j 8+j],[1 0],X_tile);
            p1Board(16,8+j) = 95;
        elseif p2(i) == 96
             Y_tile = image([7+j 8+j],[1 0],Y_tile);
             p1Board(16,8+j) = 96;
        elseif p2(i) == 97
             Y97_tile = image([7+j 8+j],[1 0],Y97_tile);
             p1Board(16,8+j) = 97;
        elseif p2(i) == 98
             Z_tile = image([7+j 8+j],[1 0],Z_tile);
             p1Board(16,8+j) = 98;
        else
        end
    end
    
    
    %if it is player 1 turn
   elseif turn == 1 
        dock = p1Board(16,1:7) ~= 0;
        lastRow = p1Board(16,1:7);
        p1 = lastRow(dock);
        p2 = [];
        [p1,~,wordData] = wordDB(p1,p2,wordData);
        set(w,'String',['Tiles remaining:' num2str(length(wordData))])
        j = 1;
    for i = 1:length(p1) 
        while p1Board(16,0+j) ~= 0
            j = j+1;
        end
        %runs exactly like it did the first time
        %however it is called when turn =1 not 0 this
        %time
        if p1(i) == 1
            A_tile = image([j-1 j],[1 0],A_tile);
             p1Board(16,0+j) = 1;
        elseif p1(i) == 2
            A2_tile = image([j-1 j],[1 0],A2_tile);
            p1Board(16,0+j) = 2;
        elseif p1(i) == 3
            A3_tile = image([j-1 j],[1 0],A3_tile);
            p1Board(16,0+j) = 3;
        elseif p1(i) == 4
            A4_tile = image([j-1 j],[1 0],A4_tile);
            p1Board(16,0+j) = 4;
        elseif p1(i) == 5
            A5_tile = image([j-1 j],[1 0],A5_tile);
            p1Board(16,0+j) = 5;
        elseif p1(i) == 6
            A6_tile = image([j-1 j],[1 0],A6_tile);
            p1Board(16,0+j) = 6;
        elseif p1(i) == 7
            A7_tile = image([j-1 j],[1 0],A7_tile);
            p1Board(16,0+j) = 7;
       elseif p1(i) == 8
            A8_tile = image([j-1 j],[1 0],A8_tile);
            p1Board(16,0+j) = 8;
        elseif p1(i) == 9
            A9_tile = image([j-1 j],[1 0],A9_tile);
            p1Board(16,0+j) = 9;
        elseif p1(i) == 10
             B_tile = image([j-1 j],[1 0],B_tile);
             p1Board(16,0+j) = 10;
        elseif p1(i) == 11
             B11_tile = image([j-1 j],[1 0],B11_tile);
             p1Board(16,0+j) = 11;
        elseif p1(i) == 12
             C_tile = image([j-1 j],[1 0],C_tile);
             p1Board(16,0+j) = 12;
        elseif p1(i) == 13
             C13_tile = image([j-1 j],[1 0],C13_tile);
             p1Board(16,0+j) = 13;
        elseif p1(i) == 14
            D_tile = image([j-1 j],[1 0],D_tile);
            p1Board(16,0+j) = 14;
        elseif p1(i) == 15
            D15_tile = image([j-1 j],[1 0],D15_tile);
             p1Board(16,0+j) = 15;
        elseif p1(i) == 16
             D16_tile = image([j-1 j],[1 0],D16_tile);
             p1Board(16,0+j) = 16;
        elseif p1(i) == 17
             D17_tile = image([j-1 j],[1 0],D17_tile);
             p1Board(16,0+j) = 17;
        elseif p1(i) == 18
            E_tile = image([j-1 j],[1 0],E_tile);
            p1Board(16,0+j) = 18;
        elseif p1(i) == 19
            E19_tile = image([j-1 j],[1 0],E19_tile);
            p1Board(16,0+j) = 19;    
        elseif p1(i) == 20
             E20_tile = image([j-1 j],[1 0],E20_tile);
             p1Board(16,0+j) = 20;
        elseif p1(i) == 21
             E21_tile = image([j-1 j],[1 0],E21_tile);
             p1Board(16,0+j) = 21;
        elseif p1(i) == 22
             E22_tile = image([j-1 j],[1 0],E22_tile);
             p1Board(16,0+j) = 22;
        elseif p1(i) == 23
            E23_tile = image([j-1 j],[1 0],E23_tile);
            p1Board(16,0+j) = 23;
        elseif p1(i) == 24
            E24_tile = image([j-1 j],[1 0],E24_tile);
             p1Board(16,0+j) = 24;
        elseif p1(i) == 25
             E25_tile = image([j-1 j],[1 0],E25_tile);
             p1Board(16,0+j) = 25;
        elseif p1(i) == 26
             E26_tile = image([j-1 j],[1 0],E26_tile);
             p1Board(16,0+j) = 26;
        elseif p1(i) == 27
            E27_tile = image([j-1 j],[1 0],E27_tile);
            p1Board(16,0+j) = 27;
        elseif p1(i) == 28
             E28_tile = image([j-1 j],[1 0],E28_tile);
             p1Board(16,0+j) = 28;
        elseif p1(i) == 29
             E29_tile = image([j-1 j],[1 0],E29_tile);
             p1Board(16,0+j) = 29;
        elseif p1(i) == 30
             F_tile = image([j-1 j],[1 0],F_tile);
             p1Board(16,0+j) = 30;
        elseif p1(i) == 31
            F31_tile = image([j-1 j],[1 0],F31_tile);
            p1Board(16,0+j) = 31;
        elseif p1(i) == 32
             G_tile = image([j-1 j],[1 0],G_tile);
             p1Board(16,0+j) = 32;
        elseif p1(i) == 33
            G33_tile = image([j-1 j],[1 0],G33_tile);
             p1Board(16,0+j) = 33;
        elseif p1(i) == 34
             G34_tile = image([j-1 j],[1 0],G34_tile);
             p1Board(16,0+j) = 34;
        elseif p1(i) == 35
            H_tile = image([j-1 j],[1 0],H_tile);
            p1Board(16,0+j) = 35;
        elseif p1(i) == 36
            H36_tile = image([j-1 j],[1 0],H36_tile);
            p1Board(16,0+j) = 36;
        elseif p1(i) == 37
            I_tile = image([j-1 j],[1 0],I_tile);
            p1Board(16,0+j) = 37;
        elseif p1(i) == 38
            I38_tile = image([j-1 j],[1 0],I38_tile);
            p1Board(16,0+j) = 38;
        elseif p1(i) == 39
            I39_tile = image([j-1 j],[1 0],I39_tile);
            p1Board(16,0+j) = 39;
        elseif p1(i) == 40
            I40_tile = image([j-1 j],[1 0],I40_tile);
            p1Board(16,0+j) = 40;
        elseif p1(i) == 41
            I41_tile = image([j-1 j],[1 0],I41_tile);
            p1Board(16,0+j) = 41;
       elseif p1(i) == 42
            I42_tile = image([j-1 j],[1 0],I42_tile);
            p1Board(16,0+j) = 42;
        elseif p1(i) == 43
            I43_tile = image([j-1 j],[1 0],I43_tile);
            p1Board(16,0+j) = 43;
        elseif p1(i) == 44
             I44_tile = image([j-1 j],[1 0],I44_tile);
             p1Board(16,0+j) = 44;
        elseif p1(i) == 45
             I45_tile = image([j-1 j],[1 0],I45_tile);
             p1Board(16,0+j) = 45;
        elseif p1(i) == 46
             J_tile = image([j-1 j],[1 0],J_tile);
             p1Board(16,0+j) = 46;
        elseif p1(i) == 47
             K_tile = image([j-1 j],[1 0],K_tile);
             p1Board(16,0+j) = 47;
        elseif p1(i) == 48
            L_tile = image([j-1 j],[1 0],L_tile);
            p1Board(16,0+j) = 48;
        elseif p1(i) == 49
            L49_tile = image([j-1 j],[1 0],L49_tile);
             p1Board(16,0+j) = 49;
        elseif p1(i) == 50
             L50_tile = image([j-1 j],[1 0],L50_tile);
             p1Board(16,0+j) = 50;
        elseif p1(i) == 51
             L51_tile = image([j-1 j],[1 0],L51_tile);
             p1Board(16,0+j) = 51;
        elseif p1(i) == 52
            M_tile = image([j-1 j],[1 0],M_tile);
            p1Board(16,0+j) = 52;
        elseif p1(i) == 53
            M53_tile = image([j-1 j],[1 0],M53_tile);
            p1Board(16,0+j) = 53;    
        elseif p1(i) == 54
             N_tile = image([j-1 j],[1 0],N_tile);
             p1Board(16,0+j) = 54;
        elseif p1(i) == 55
             N55_tile = image([j-1 j],[1 0],N55_tile);
             p1Board(16,0+j) = 55;
        elseif p1(i) == 56
             N56_tile = image([j-1 j],[1 0],N56_tile);
             p1Board(16,0+j) = 56;
        elseif p1(i) == 57
            N57_tile = image([j-1 j],[1 0],N57_tile);
            p1Board(16,0+j) = 57;
        elseif p1(i) == 58
            N58_tile = image([j-1 j],[1 0],N58_tile);
             p1Board(16,0+j) = 58;
        elseif p1(i) == 59
             N59_tile = image([j-1 j],[1 0],N59_tile);
             p1Board(16,0+j) = 59;
        elseif p1(i) == 60
             O_tile = image([j-1 j],[1 0],O_tile);
             p1Board(16,0+j) = 60;
        elseif p1(i) == 61
            O61_tile = image([j-1 j],[1 0],O61_tile);
            p1Board(16,0+j) = 61;
        elseif p1(i) == 62
             O62_tile = image([j-1 j],[1 0],O62_tile);
             p1Board(16,0+j) = 62;
        elseif p1(i) == 63
             O63_tile = image([j-1 j],[1 0],O63_tile);
             p1Board(16,0+j) = 63;
        elseif p1(i) == 64
             O64_tile = image([j-1 j],[1 0],O64_tile);
             p1Board(16,0+j) = 64;
        elseif p1(i) == 65
            O65_tile = image([j-1 j],[1 0],O65_tile);
            p1Board(16,0+j) = 65;
        elseif p1(i) == 66
             O66_tile = image([j-1 j],[1 0],O66_tile);
             p1Board(16,0+j) = 66;
        elseif p1(i) == 67
            O67_tile = image([j-1 j],[1 0],O67_tile);
             p1Board(16,0+j) = 67;
        elseif p1(i) == 68
             P_tile = image([j-1 j],[1 0],P_tile);
             p1Board(16,0+j) = 68;
        elseif p1(i) == 69
            P69_tile = image([j-1 j],[1 0],P69_tile);
            p1Board(16,0+j) = 69; 
        elseif p1(i) == 70
            Q_tile = image([j-1 j],[1 0],Q_tile);
            p1Board(16,0+j) = 70;
        elseif p1(i) == 71
            R_tile = image([j-1 j],[1 0],R_tile);
            p1Board(16,0+j) = 71;
        elseif p1(i) == 72
            R72_tile = image([j-1 j],[1 0],R72_tile);
            p1Board(16,0+j) = 72;
        elseif p1(i) == 73
            R73_tile = image([j-1 j],[1 0],R73_tile);
            p1Board(16,0+j) = 73;
        elseif p1(i) == 74
            R74_tile = image([j-1 j],[1 0],R74_tile);
            p1Board(16,0+j) = 74;
        elseif p1(i) == 75
            R75_tile = image([j-1 j],[1 0],R75_tile);
            p1Board(16,0+j) = 75;
       elseif p1(i) == 76
            R76_tile = image([j-1 j],[1 0],R76_tile);
            p1Board(16,0+j) = 76;
        elseif p1(i) == 77
            S_tile = image([j-1 j],[1 0],S_tile);
            p1Board(16,0+j) = 77;
        elseif p1(i) == 78
             S78_tile = image([j-1 j],[1 0],S78_tile);
             p1Board(16,0+j) = 78;
        elseif p1(i) == 79
             S79_tile = image([j-1 j],[1 0],S79_tile);
             p1Board(16,0+j) = 79;
        elseif p1(i) == 80
             S80_tile = image([j-1 j],[1 0],S80_tile);
             p1Board(16,0+j) = 80;
        elseif p1(i) == 81
             T_tile = image([j-1 j],[1 0],T_tile);
             p1Board(16,0+j) = 81;
        elseif p1(i) == 82
            T82_tile = image([j-1 j],[1 0],T82_tile);
            p1Board(16,0+j) = 82;
        elseif p1(i) == 83
            T83_tile = image([j-1 j],[1 0],T83_tile);
             p1Board(16,0+j) = 83;
        elseif p1(i) == 84
             T84_tile = image([j-1 j],[1 0],T84_tile);
             p1Board(16,0+j) = 84;
        elseif p1(i) == 85
             T85_tile = image([j-1 j],[1 0],T85_tile);
             p1Board(16,0+j) = 85;
        elseif p1(i) == 86
            T86_tile = image([j-1 j],[1 0],T86_tile);
            p1Board(16,0+j) = 86;
        elseif p1(i) == 87
            U_tile = image([j-1 j],[1 0],U_tile);
            p1Board(16,0+j) = 87;    
        elseif p1(i) == 88
             U88_tile = image([j-1 j],[1 0],U88_tile);
             p1Board(16,0+j) = 88;
        elseif p1(i) == 89
             U89_tile = image([j-1 j],[1 0],U89_tile);
             p1Board(16,0+j) = 89;
        elseif p1(i) == 90
             U90_tile = image([j-1 j],[1 0],U90_tile);
             p1Board(16,0+j) = 90;
        elseif p1(i) == 91
            V_tile = image([j-1 j],[1 0],V_tile);
            p1Board(16,0+j) = 91;
        elseif p1(i) == 92
            V92_tile = image([j-1 j],[1 0],V92_tile);
             p1Board(16,0+j) = 92;
        elseif p1(i) == 93
             W_tile = image([j-1 j],[1 0],W_tile);
             p1Board(16,0+j) = 93;
        elseif p1(i) == 94
             W94_tile = image([j-1 j],[1 0],W94_tile);
             p1Board(16,0+j) = 94;
        elseif p1(i) == 95
            X_tile = image([j-1 j],[1 0],X_tile);
            p1Board(16,0+j) = 95;
        elseif p1(i) == 96
             Y_tile = image([j-1 j],[1 0],Y_tile);
             p1Board(16,0+j) = 96;
        elseif p1(i) == 97
             Y97_tile = image([j-1 j],[1 0],Y97_tile);
             p1Board(16,0+j) = 97;
        elseif p1(i) == 98
             Z_tile = image([j-1 j],[1 0],Z_tile);
             p1Board(16,0+j) = 98;
        else
        end
    end
            xypos = zeros(15,15);%re making xypos zeros after a turn has been played
            %showing a visual to switch turns
            set(b,'String','Switch turns!')
            
%this plots the dock tiles for only player 2 only when
%it is player 2 turn
   elseif turn == 2
       dock = p1Board(16,8:15) ~= 0;
        lastRow = p1Board(16,8:15);
        p2 = lastRow(dock);
        p1 = 1; %hold 
        [p2,~,wordData] = wordDB(p2,p1,wordData);
        set(w,'String',['Tiles remaining:' num2str(length(wordData))])
        j = 1;
    for i = 1:length(p2) 
        while p1Board(16,8+j) ~= 0
            j = j+1;
        end
        if p2(i) == 1
            A_tile = image([7+j 8+j],[1 0],A_tile);
             p1Board(16,8+j) = 1;
        elseif p2(i) == 2
            A2_tile = image([7+j 8+j],[1 0],A2_tile);
            p1Board(16,8+j) = 2;
        elseif p2(i) == 3
            A3_tile = image([7+j 8+j],[1 0],A3_tile);
            p1Board(16,8+j) = 3;
        elseif p2(i) == 4
            A4_tile = image([7+j 8+j],[1 0],A4_tile);
            p1Board(16,8+j) = 4;
        elseif p2(i) == 5
            A5_tile = image([7+j 8+j],[1 0],A5_tile);
            p1Board(16,8+j) = 5;
        elseif p2(i) == 6
            A6_tile = image([7+j 8+j],[1 0],A6_tile);
            p1Board(16,8+j) = 6;
        elseif p2(i) == 7
            A7_tile = image([7+j 8+j],[1 0],A7_tile);
            p1Board(16,8+j) = 7;
       elseif p2(i) == 8
            A8_tile = image([7+j 8+j],[1 0],A8_tile);
            p1Board(16,8+j) = 8;
        elseif p2(i) == 9
            A9_tile = image([7+j 8+j],[1 0],A9_tile);
            p1Board(16,8+j) = 9;
        elseif p2(i) == 10
             B_tile = image([7+j 8+j],[1 0],B_tile);
             p1Board(16,8+j) = 10;
        elseif p2(i) == 11
             B11_tile = image([7+j 8+j],[1 0],B11_tile);
             p1Board(16,8+j) = 11;
        elseif p2(i) == 12
             C_tile = image([7+j 8+j],[1 0],C_tile);
             p1Board(16,8+j) = 12;
        elseif p2(i) == 13
             C13_tile = image([7+j 8+j],[1 0],C13_tile);
             p1Board(16,8+j) = 13;
        elseif p2(i) == 14
            D_tile = image([7+j 8+j],[1 0],D_tile);
            p1Board(16,8+j) = 14;
        elseif p2(i) == 15
            D15_tile = image([7+j 8+j],[1 0],D15_tile);
             p1Board(16,8+j) = 15;
        elseif p2(i) == 16
             D16_tile = image([7+j 8+j],[1 0],D16_tile);
             p1Board(16,8+j) = 16;
        elseif p2(i) == 17
             D17_tile = image([7+j 8+j],[1 0],D17_tile);
             p1Board(16,8+j) = 17;
        elseif p2(i) == 18
            E_tile = image([7+j 8+j],[1 0],E_tile);
            p1Board(16,8+j) = 18;
        elseif p2(i) == 19
            E19_tile = image([7+j 8+j],[1 0],E19_tile);
            p1Board(16,8+j) = 19;    
        elseif p2(i) == 20
             E20_tile = image([7+j 8+j],[1 0],E20_tile);
             p1Board(16,8+j) = 20;
        elseif p2(i) == 21
             E21_tile = image([7+j 8+j],[1 0],E21_tile);
             p1Board(16,8+j) = 21;
        elseif p2(i) == 22
             E22_tile = image([7+j 8+j],[1 0],E22_tile);
             p1Board(16,8+j) = 22;
        elseif p2(i) == 23
            E23_tile = image([7+j 8+j],[1 0],E23_tile);
            p1Board(16,8+j) = 23;
        elseif p2(i) == 24
            E24_tile = image([7+j 8+j],[1 0],E24_tile);
             p1Board(16,8+j) = 24;
        elseif p2(i) == 25
             E25_tile = image([7+j 8+j],[1 0],E25_tile);
             p1Board(16,8+j) = 25;
        elseif p2(i) == 26
             E26_tile = image([7+j 8+j],[1 0],E26_tile);
             p1Board(16,8+j) = 26;
        elseif p2(i) == 27
            E27_tile = image([7+j 8+j],[1 0],E27_tile);
            p1Board(16,8+j) = 27;
        elseif p2(i) == 28
             E28_tile = image([7+j 8+j],[1 0],E28_tile);
             p1Board(16,8+j) = 28;
        elseif p2(i) == 29
             E29_tile = image([7+j 8+j],[1 0],E29_tile);
             p1Board(16,8+j) = 29;
        elseif p2(i) == 30
             F_tile = image([7+j 8+j],[1 0],F_tile);
             p1Board(16,8+j) = 30;
        elseif p2(i) == 31
            F31_tile = image([7+j 8+j],[1 0],F31_tile);
            p1Board(16,8+j) = 31;
        elseif p2(i) == 32
             G_tile = image([7+j 8+j],[1 0],G_tile);
             p1Board(16,8+j) = 32;
        elseif p2(i) == 33
            G33_tile = image([7+j 8+j],[1 0],G33_tile);
             p1Board(16,8+j) = 33;
        elseif p2(i) == 34
             G34_tile = image([7+j 8+j],[1 0],G34_tile);
             p1Board(16,8+j) = 34;
        elseif p2(i) == 35
            H_tile = image([7+j 8+j],[1 0],H_tile);
            p1Board(16,8+j) = 35;
        elseif p2(i) == 36
            H36_tile = image([7+j 8+j],[1 0],H36_tile);
            p1Board(16,8+j) = 36;
        elseif p2(i) == 37
            I_tile = image([7+j 8+j],[1 0],I_tile);
            p1Board(16,8+j) = 37;
        elseif p2(i) == 38
            I38_tile = image([7+j 8+j],[1 0],I38_tile);
            p1Board(16,8+j) = 38;
        elseif p2(i) == 39
            I39_tile = image([7+j 8+j],[1 0],I39_tile);
            p1Board(16,8+j) = 39;
        elseif p2(i) == 40
            I40_tile = image([7+j 8+j],[1 0],I40_tile);
            p1Board(16,8+j) = 40;
        elseif p2(i) == 41
            I41_tile = image([7+j 8+j],[1 0],I41_tile);
            p1Board(16,8+j) = 41;
       elseif p2(i) == 42
            I42_tile = image([7+j 8+j],[1 0],I42_tile);
            p1Board(16,8+j) = 42;
        elseif p2(i) == 43
            I43_tile = image([7+j 8+j],[1 0],I43_tile);
            p1Board(16,8+j) = 43;
        elseif p2(i) == 44
             I44_tile = image([7+j 8+j],[1 0],I44_tile);
             p1Board(16,8+j) = 44;
        elseif p2(i) == 45
             I45_tile = image([7+j 8+j],[1 0],I45_tile);
             p1Board(16,8+j) = 45;
        elseif p2(i) == 46
             J_tile = image([7+j 8+j],[1 0],J_tile);
             p1Board(16,8+j) = 46;
        elseif p2(i) == 47
             K_tile = image([7+j 8+j],[1 0],K_tile);
             p1Board(16,8+j) = 47;
        elseif p2(i) == 48
            L_tile = image([7+j 8+j],[1 0],L_tile);
            p1Board(16,8+j) = 48;
        elseif p2(i) == 49
            L49_tile = image([7+j 8+j],[1 0],L49_tile);
             p1Board(16,8+j) = 49;
        elseif p2(i) == 50
             L50_tile = image([7+j 8+j],[1 0],L50_tile);
             p1Board(16,8+j) = 50;
        elseif p2(i) == 51
             L51_tile = image([7+j 8+j],[1 0],L51_tile);
             p1Board(16,8+j) = 51;
        elseif p2(i) == 52
            M_tile = image([7+j 8+j],[1 0],M_tile);
            p1Board(16,8+j) = 52;
        elseif p2(i) == 53
            M53_tile = image([7+j 8+j],[1 0],M53_tile);
            p1Board(16,8+j) = 53;    
        elseif p2(i) == 54
             N_tile = image([7+j 8+j],[1 0],N_tile);
             p1Board(16,8+j) = 54;
        elseif p2(i) == 55
             N55_tile = image([7+j 8+j],[1 0],N55_tile);
             p1Board(16,8+j) = 55;
        elseif p2(i) == 56
             N56_tile = image([7+j 8+j],[1 0],N56_tile);
             p1Board(16,8+j) = 56;
        elseif p2(i) == 57
            N57_tile = image([7+j 8+j],[1 0],N57_tile);
            p1Board(16,8+j) = 57;
        elseif p2(i) == 58
            N58_tile = image([7+j 8+j],[1 0],N58_tile);
             p1Board(16,8+j) = 58;
        elseif p2(i) == 59
             N59_tile = image([7+j 8+j],[1 0],N59_tile);
             p1Board(16,8+j) = 59;
        elseif p2(i) == 60
             O_tile = image([7+j 8+j],[1 0],O_tile);
             p1Board(16,8+j) = 60;
        elseif p2(i) == 61
            O61_tile = image([7+j 8+j],[1 0],O61_tile);
            p1Board(16,8+j) = 61;
        elseif p2(i) == 62
             O62_tile = image([7+j 8+j],[1 0],O62_tile);
             p1Board(16,8+j) = 62;
        elseif p2(i) == 63
             O63_tile = image([7+j 8+j],[1 0],O63_tile);
             p1Board(16,8+j) = 63;
        elseif p2(i) == 64
             O64_tile = image([7+j 8+j],[1 0],O64_tile);
             p1Board(16,8+j) = 64;
        elseif p2(i) == 65
            O65_tile = image([7+j 8+j],[1 0],O65_tile);
            p1Board(16,8+j) = 65;
        elseif p2(i) == 66
             O66_tile = image([7+j 8+j],[1 0],O66_tile);
             p1Board(16,8+j) = 66;
        elseif p2(i) == 67
            O67_tile = image([7+j 8+j],[1 0],O67_tile);
             p1Board(16,8+j) = 67;
        elseif p2(i) == 68
             P_tile = image([7+j 8+j],[1 0],P_tile);
             p1Board(16,8+j) = 68;
        elseif p2(i) == 69
            P69_tile = image([7+j 8+j],[1 0],P69_tile);
            p1Board(16,8+j) = 69; 
        elseif p2(i) == 70
            Q_tile = image([7+j 8+j],[1 0],Q_tile);
            p1Board(16,8+j) = 70;
        elseif p2(i) == 71
            R_tile = image([7+j 8+j],[1 0],R_tile);
            p1Board(16,8+j) = 71;
        elseif p2(i) == 72
            R72_tile = image([7+j 8+j],[1 0],R72_tile);
            p1Board(16,8+j) = 72;
        elseif p2(i) == 73
            R73_tile = image([7+j 8+j],[1 0],R73_tile);
            p1Board(16,8+j) = 73;
        elseif p2(i) == 74
            R74_tile = image([7+j 8+j],[1 0],R74_tile);
            p1Board(16,8+j) = 74;
        elseif p2(i) == 75
            R75_tile = image([7+j 8+j],[1 0],R75_tile);
            p1Board(16,8+j) = 75;
       elseif p2(i) == 76
            R76_tile = image([7+j 8+j],[1 0],R76_tile);
            p1Board(16,8+j) = 76;
        elseif p2(i) == 77
            S_tile = image([7+j 8+j],[1 0],S_tile);
            p1Board(16,8+j) = 77;
        elseif p2(i) == 78
             S78_tile = image([7+j 8+j],[1 0],S78_tile);
             p1Board(16,8+j) = 78;
        elseif p2(i) == 79
             S79_tile = image([7+j 8+j],[1 0],S79_tile);
             p1Board(16,8+j) = 79;
        elseif p2(i) == 80
             S80_tile = image([7+j 8+j],[1 0],S80_tile);
             p1Board(16,8+j) = 80;
        elseif p2(i) == 81
             T_tile = image([7+j 8+j],[1 0],T_tile);
             p1Board(16,8+j) = 81;
        elseif p2(i) == 82
            T82_tile = image([7+j 8+j],[1 0],T82_tile);
            p1Board(16,8+j) = 82;
        elseif p2(i) == 83
            T83_tile = image([7+j 8+j],[1 0],T83_tile);
             p1Board(16,8+j) = 83;
        elseif p2(i) == 84
             T84_tile = image([7+j 8+j],[1 0],T84_tile);
             p1Board(16,8+j) = 84;
        elseif p2(i) == 85
             T85_tile = image([7+j 8+j],[1 0],T85_tile);
             p1Board(16,8+j) = 85;
        elseif p2(i) == 86
            T86_tile = image([7+j 8+j],[1 0],T86_tile);
            p1Board(16,8+j) = 86;
        elseif p2(i) == 87
            U_tile = image([7+j 8+j],[1 0],U_tile);
            p1Board(16,8+j) = 87;    
        elseif p2(i) == 88
             U88_tile = image([7+j 8+j],[1 0],U88_tile);
             p1Board(16,8+j) = 88;
        elseif p2(i) == 89
             U89_tile = image([7+j 8+j],[1 0],U89_tile);
             p1Board(16,8+j) = 89;
        elseif p2(i) == 90
             U90_tile = image([7+j 8+j],[1 0],U90_tile);
             p1Board(16,8+j) = 90;
        elseif p2(i) == 91
            V_tile = image([7+j 8+j],[1 0],V_tile);
            p1Board(16,8+j) = 91;
        elseif p2(i) == 92
            V92_tile = image([7+j 8+j],[1 0],V92_tile);
             p1Board(16,8+j) = 92;
        elseif p2(i) == 93
             W_tile = image([7+j 8+j],[1 0],W_tile);
             p1Board(16,8+j) = 93;
        elseif p2(i) == 94
             W94_tile = image([7+j 8+j],[1 0],W94_tile);
             p1Board(16,8+j) = 94;
        elseif p2(i) == 95
            X_tile = image([7+j 8+j],[1 0],X_tile);
            p1Board(16,8+j) = 95;
        elseif p2(i) == 96
             Y_tile = image([7+j 8+j],[1 0],Y_tile);
             p1Board(16,8+j) = 96;
        elseif p2(i) == 97
             Y97_tile = image([7+j 8+j],[1 0],Y97_tile);
             p1Board(16,8+j) = 97;
        elseif p2(i) == 98
             Z_tile = image([7+j 8+j],[1 0],Z_tile);
             p1Board(16,8+j) = 98;
        else
        end
    end
   end
   
   
   
   if turn == 0%saying that when the game starts to make player 1 go first
       turn = 1;
       skips = 0;%initializing the number of skips as zero
       xypos = zeros(15,15);%making xy pos zeros
   elseif turn == 1%switching from p1 turn to p2 turn
       turn = 2;
       %plotting a text box that says its player 2's
       %turn
       set(b,'String','Player 2 Turn','position',[.315 .11 .2 .05]);
       xypos = zeros(15,15);
       skips = 0;
   elseif turn == 2 %switching turns from player 2 to player 1
       turn = 1;
       %plotting a text box that says its player 1's
       %turn
       set(b,'String','Player 1 Turn','position',[.515 .11 .2 .05]);
       xypos = zeros(15,15);
       skips = 0;
   end
   else 
        set(b,'String','You must submit a valid word before getting new tiles.')
        b.FontSize = 12;
        if length(wordData) == 0 && (length(p1) == 0 || length(p2) == 0) %if tiles run out and one player's tiles run out 
            %when the game ends and either player 1 or
            %2 wins it will plot a textbox saying who
            %won 
           if winner == 1 || winner == 2
            S = annotation('textbox','position',[.25 .25 .5 .3],'String',['Game Over! Player ' num2str(winner) ' wins!'],'BackgroundColor','w','FontSize',30);
            S.HorizontalAlignment = 'center';
            S.VerticalAlignment = 'middle';
           elseif winner == 3 %if the game is a tie it says its a tie!
            S = annotation('textbox','position',[.25 .4 .5 .3],'String','Game Over! Everybody Wins!','BackgroundColor','w','FontSize',30);
            S.HorizontalAlignment = 'center';
            S.VerticalAlignment = 'middle';
           else
           end
        end
   end
 
   end
    
%initializing global variables for the drag and drop
%functionality to move our tiles
wordInput = [];
% wordInput2 = [];
xypos = zeros(15,15);
xLoc = 0;
yLoc = 0;
xpos = NaN;
ypos = NaN;
xx = 1; %establish 
yy = 1;

%Callback functions
    function ImagePos(varargin) % note varargin
        pos = get(gca,'CurrentPoint'); % get cursor position
%         mapping x and y pos to parts of the position
%         matrix
        xpos = pos(1,1);
        ypos = pos(1,2);
        %saying that if the tiles lie on the board it
        %will move them
        if xpos >= 0 && xpos <= 15 && ypos >= 0 && ypos <= 16
            xx = ceil(xpos);%round up to the top of x
            yy = 17 - ceil(ypos);%flipping the y because our matrix and board are mapped to different directions
            if isempty(p1Board(yy,xx)) == 0 && p1Board(yy,xx) ~= 100 
                movingTiles(yy,xx) = 1; %establishes the tile is under user control 
            end
        end
    end
    %find out if on top of a tile 
    %maybe separate xpos and ypos each row corresponds to tile of
    %userControl 

    function setTile(varargin)
        % Sets user control variable to 0 
        movingTiles = zeros(15,16);
        %snapping the x and y positions of the tiles
        %into place so they map evenly to the squares
        %on the board
        for n=-1:15
        if xLoc>n && xLoc<(n+1)
            xpos = n;
        end
        if yLoc>n && yLoc<(n+1)
            ypos =n;
        end
        end
        if xx <= 16 && xx >= 0 && yy >= 0 && yy<= 16 && xLoc <= 15 && xLoc >= 0 && yLoc <= 15 && yLoc >= 0
            %this updates the positions of the tiles as
            %they are being dragged across the board
            xLoc = xLoc + 1;
            yLoc = 16 - yLoc;
            p1Board(yLoc,xLoc) = p1Board(yy,xx); %updating w new position
            xypos(yLoc,xLoc) = p1Board(yy,xx);
            p1Board(yy,xx) = 0;%once the mouse is no longer dragging over a position it resets that position to zero
            xypos(yy,xx) = 0;
            %xx and yy reflect the current state of
            %where the tiles are
        end
    end
    
    function moveTile(varargin)
        % gets the position of where the tile was moved
        % to
         pos = get(gca,'CurrentPoint');
         %rounding x and y up so they map to the right
         %places
         xLoc = ceil(pos(1,1));
         yLoc = ceil(pos(1,2));
         %if the x and y positions are on the board
         %this sets the positions of the tiles as they
         %are being dragged so you can see where they
         %move with the mouse
         if xLoc >= 0 && xLoc <= 16 && yLoc >= 0 && yLoc <= 16
            if sum(sum(movingTiles)) == 1
                if (p1Board(yy,xx))== 1
                    set(A_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 2
                    set(A2_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 3
                    set(A3_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 4
                    set(A4_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 5
                    set(A5_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 6
                    set(A6_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 7
                    set(A7_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 8
                    set(A8_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 9
                    set(A9_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 10
                    set(B_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 11
                    set(B11_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 12
                    set(C_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 13
                    set(C13_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 14
                    set(D_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 15
                    set(D15_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 16
                    set(D16_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 17
                    set(D17_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 18
                    set(E_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 19
                    set(E19_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 20
                    set(E20_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 21
                    set(E21_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 22
                    set(E22_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 23
                    set(E23_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 24
                    set(E24_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 25
                    set(E25_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 26
                    set(E26_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 27
                    set(E27_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 28
                    set(E28_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 29
                    set(E29_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 30
                    set(F_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 31
                    set(F31_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 32
                    set(G_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 33
                    set(G33_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 34
                    set(G34_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 35
                    set(H_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 36
                    set(H36_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 37
                    set(I_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 38
                    set(I38_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 39
                    set(I39_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 40
                    set(I40_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 41
                    set(I41_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 42
                    set(I42_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 43
                    set(I43_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 44
                    set(I44_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 45
                    set(I45_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 46
                    set(J_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 47
                    set(K_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 48
                    set(L_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 49
                    set(L49_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 50
                    set(L50_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 51
                    set(L51_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 52
                    set(M_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 53
                    set(M53_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 54
                    set(N_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 55
                    set(N55_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 56
                    set(N56_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 57
                    set(N57_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 58
                    set(N58_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 59
                    set(N59_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 60
                    set(O_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 61
                    set(O61_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 62
                    set(O62_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 63
                    set(O63_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 64
                    set(O64_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 65
                    set(O65_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 66
                    set(O66_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 67
                    set(O67_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 68
                    set(P_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 69
                    set(P69_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 70
                    set(Q_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 71
                    set(R_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 72
                    set(R72_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 73
                    set(R73_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 74
                    set(R74_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 75
                    set(R75_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 76
                    set(R76_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 77
                    set(S_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 78
                    set(S78_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 79
                    set(S79_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 80
                    set(S80_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 81
                    set(T_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 82
                    set(T82_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 83
                    set(T83_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 84
                    set(T84_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 85
                    set(T85_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 86
                    set(T86_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 87
                    set(U_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 88
                    set(U88_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 89
                    set(U89_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 90
                    set(U90_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 91
                    set(V_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 92
                    set(V92_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 93
                    set(W_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 94
                    set(W94_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 95
                    set(X_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 96
                    set(Y_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 97
                    set(Y97_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                elseif (p1Board(yy,xx)) == 98
                    set(Z_tile,'XData',[xLoc xLoc+1],'YData',[yLoc+1 yLoc])
                else
                end
            end
        end
    end


%Set up tiles remaining display 
w = annotation('textbox','position',[0 0 .1 .1]);
% updates the numbers of tiles remaining
set(w,'String',['Tiles remaining: ' num2str(length(wordData))],'BackgroundColor','w')
w.FontSize = 24;
%displays the switching from one turn to annother 
b = annotation('textbox','position',[.515 .11 .2 .05],'String','Player 1 Turn','BackgroundColor','w','FontSize',18);

points = 0; %Initialize; should be updated by wordCheck function 
p2points = 0;
p3points = 0;
%Set up points display for player 1 and player 2
c = annotation('textbox','position',[0 .3 .1 .1],'BackgroundColor','w'); %for point total
set(c,'String',['Player 1 Score: ' num2str(p2points)]);
c.FontSize = 24;

e = annotation('textbox','position',[.8 .3 .1 .1],'BackgroundColor','w');
set(e,'String',['Player 2 Score: ' num2str(p3points)]);
e.FontSize = 24;

%Submit button to call on wordCheck function 
uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.42 0.05 .2 .05],'String','Submit Word', 'CallBack',@wordCheck1)

    function points2 = letterCheck(letter)
        
        %This function is used when a tile is on a
        %double letter or triple letter function to
        %check how many points the letter is worth. 
        %mapping each "letter" (number tile that
        %corresponds to a letter being plotted) 
        if letter == 1
            letter = 'a';
        elseif letter == 2
            letter = 'a';
        elseif letter == 3
            letter = 'a';
        elseif letter == 4
            letter = 'a';
        elseif letter == 5
            letter = 'a';
        elseif letter == 6
            letter = 'a';
        elseif letter == 7
            letter = 'a';
       elseif letter == 8
            letter = 'a';
        elseif letter == 9
            letter = 'a';
        elseif letter == 10
             letter = 'b';
        elseif letter == 11
             letter = 'c';
        elseif letter == 12
             letter = 'c';
        elseif letter == 13
             letter = 'c';
        elseif letter == 14
            letter = 'd';
        elseif letter == 15
            letter = 'd';
        elseif letter == 16
             letter = 'd';
        elseif letter == 17
             letter = 'd';
        elseif letter == 18
            letter = 'e';
        elseif letter == 19
            letter = 'e';  
        elseif letter == 20
             letter = 'e';
        elseif letter == 21
             letter = 'e';
        elseif letter == 22
             letter = 'e';
        elseif letter == 23
            letter = 'e';
        elseif letter == 24
            letter = 'e';
        elseif letter == 25
             letter = 'e';
        elseif letter == 26
             letter = 'e';
        elseif letter == 27
            letter = 'e';
        elseif letter == 28
             letter = 'e';
        elseif letter == 29
             letter = 'e';
        elseif letter == 30
             letter = 'f';
        elseif letter == 31
            letter = 'f';
        elseif letter == 32
             letter = 'g';
        elseif letter == 33
            letter = 'g';
        elseif letter == 34
             letter = 'g';
        elseif letter == 35
            letter = 'h';
        elseif letter == 36
            letter = 'h';
        elseif letter == 37
            letter = 'i';
        elseif letter == 38
            letter = 'i';
        elseif letter == 39
            letter = 'i';
        elseif letter == 40
            letter = 'i';
        elseif letter == 41
            letter = 'i';
       elseif letter == 42
            letter = 'i';
        elseif letter == 43
            letter = 'i';
        elseif letter == 44
             letter = 'i';
        elseif letter == 45
             letter = 'i';
        elseif letter == 46
             letter = 'j';
        elseif letter == 47
             letter = 'k';
        elseif letter == 48
            letter = 'l';
        elseif letter == 49
            letter = 'l';
        elseif letter == 50
             letter = 'l';
        elseif letter == 51
             letter = 'l';
        elseif letter == 52
            letter = 'm';
        elseif letter == 53
            letter = 'm';   
        elseif letter == 54
             letter = 'n';
        elseif letter == 55
             letter = 'n';
        elseif letter == 56
             letter = 'n';
        elseif letter == 57
            letter = 'n';
        elseif letter == 58
            letter = 'n';
        elseif letter == 59
             letter = 'n';
        elseif letter == 60
             letter = 'o';
        elseif letter == 61
            letter = 'o';
        elseif letter == 62
             letter = 'o';
        elseif letter == 63
             letter = 'o';
        elseif letter == 64
             letter = 'o';
        elseif letter == 65
            letter = 'o';
        elseif letter == 66
             letter = 'o';
        elseif letter == 67
            letter = 'o';
        elseif letter == 68
             letter = 'p';
        elseif letter == 69
            letter = 'p';
        elseif letter == 70
            letter = 'q';
        elseif letter == 71
            letter = 'r';
        elseif letter == 72
            letter = 'r';
        elseif letter == 73
            letter = 'r';
        elseif letter == 74
            letter = 'r';
        elseif letter == 75
            letter = 'r';
       elseif letter == 76
            letter = 'r';
        elseif letter == 77
            letter = 's';
        elseif letter == 78
             letter = 's';
        elseif letter == 79
             letter = 's';
        elseif letter == 80
             letter = 's';
        elseif letter == 81
             letter = 't';
        elseif letter == 82
            letter = 't';
        elseif letter == 83
            letter = 't';
        elseif letter == 84
             letter = 't';
        elseif letter == 85
             letter = 't';
        elseif letter == 86
            letter = 't';
        elseif letter == 87
            letter = 'u'; 
        elseif letter == 88
             letter = 'u';
        elseif letter == 89
             letter = 'u';
        elseif letter == 90
             letter = 'u';
        elseif letter == 91
            letter = 'v';
        elseif letter == 92
            letter = 'v';
        elseif letter == 93
             letter = 'w';
        elseif letter == 94
             letter = 'w';
        elseif letter == 95
            letter = 'x';
        elseif letter == 96
             letter = 'y';
        elseif letter == 97
             letter = 'y';
        elseif letter == 98
             letter = 'z';
        else
        end
        
            for counter1 = 1:7
                %if letters a e i o s r t are being
                %plotted it says they are worth 1 point
                %when being evaluated
                firstString = 'aeiostr';
                if letter == firstString(counter1)
                    points2 = 1;%updates the points
                end
            end
            for counter2 = 1:4
                %if letters d l u or n are plotted it
                %says they are worth 2 points 
                secondString = 'dlun';
                if letter == secondString(counter2)
                points2 = 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy'; %assigns 3 points to these letters
                if letter == thirdString(counter3)
                points2 = 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp'; %assisn 4 points to these letters
                if letter == fourthString(counter4)
                points2 = 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk'; %assigns five points to these letters
                if letter == fifthString(counter5)
                points2 = 5;
                end
            end
            if  letter == 'x' %assigns 8 points to x
                points2 = 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz'; %assigns 10 points to these letters
                if letter == sixthString(counter5)
                points2 = 10;
                end
            end
        end

    function wordCheck1(ObjH,EventData)
        %This is the main function that is called when
        %"submit word" has been pressed to check
        %whether the word submitted is a valid worth
        %and calculate how many points it is based on
        %the letters, board positions, and surrounding
        %words. 
        
        error = 0; %initialize variables, turns to one if a word is not valid 
        wordChecker = 1; %initialize
        singletest = 0; %initialize 
        originalpoints = 0; %initialize 
        xypos = xypos(1:15,1:15); %gets rid of any mapping in the sixteenth row, which would correspond to the dock
        
        if sum(sum(xypos)) == 0 %no characters submitted
            error = 1;
        end
        
        single = (xypos ~= 0); %for a single letter placed, needs a special case because it must be checked on all sides and points should not be calculated individually
        if sum(sum(single)) == 1 
            for x = 1:15
                if sum(xypos(x,:)) > 0 %calculates starting row 
                    row = x;
                    Hrow = x; %may reference later to check for surrounding words 
                    Vrow = x;
                end
            end
            for y = 1:15
                if sum(xypos(:,y)) > 0 %calculates column the word is in  
                    col = y;
                    Hcol = y;
                    Vcol = y;
                end
            end
            pos = 0;
            singletest = 1; %confirms it is single 
            wordInput = xypos(Hrow,Hcol); %determines wordInput as that position 
        
        elseif error == 0 %goes through this if no error has been found yet 
        wordInput = [];
            pos = 0; %initialize 
        for x = 1:15 %check horizontally if a word is horizontal 
            if sum(xypos(x,:) ~= 0)> 1 %word is horizontal 
                pos = 1; %horizontal indicator 
                row = x; %row it is in
                Hrow = row; %hold for later use
            end
        end

        if pos == 0 %find vertical word starting point 
            for y = 1:15 
                if sum(xypos(:,y) ~= 0) > 1
                    col = y; %column it is in
                    Vcol = col; %hold for later use
                    pos = 2;
                end
            end
        end
        
        finder = 0; %initializes 
        if pos == 1 || pos == 0 %horizontal 
            line = 0;
            for h = 1:15
                Htest = sum(xypos,2); %test if the tiles have been placed down properly
                if Htest(h) ~= 0 
                    line = line + 1; %tiles not all placed in a row 
                end
            end
            if line > 1
                error = 1; %changes error to 1 
                points = 0;
            end
            nn = 0;
          
            while finder == 0 %to find the first row and set as startpos
                nn = nn+1;
                if xypos(row,nn) ~= 0
                    finder = 1;
                    Hcol = nn; %hold for later use
                    startpos = nn; %first column 
                end
            end
                s = 0;
                while xypos(row,startpos+s) ~= 0 
                     wordInput = [wordInput xypos(row,startpos+s)]; %finds all the letters in the word and adds to wordInput
                    s = s+1;
                end
         elseif pos == 2 %vertical 
            line = 0;
            for v = 1:15
                Vtest = sum(xypos); %determines whether the tiles are all placed in one word 
                if Vtest(v) ~= 0
                    line = line + 1;
                end
            end
            if line > 1
                error = 1;
                points = 0;
            end
            nn = 0;
            while finder == 0
                nn = nn+1;
                if xypos(nn,col) ~= 0 
                    finder = 1;
                    Vrow = nn; %hold for later use 
                    startpos = nn; %first row 
                end
            end
                s = 0;
                while xypos(startpos+s, col) ~= 0 && s~= 15 
                    wordInput = [wordInput xypos(startpos+s, col)]; %adds rest of letters in word to wordInput
                    s = s+1;
                end
        else
        end
        else
        end
        
        if error == 0 %this loop maps each of the numbers in wordInput to a letter 
%         if newWord == 1 || newWord == 0
        for p = 1:length(wordInput)
            if wordInput(p) == 1 || wordInput(p) == 2 || wordInput(p)...
                == 3 || wordInput(p) == 4 || wordInput(p) == 5 || wordInput(p)...
                == 6 || wordInput(p) == 6 || wordInput(p) == 7 || wordInput(p)...
                == 8 || wordInput(p) == 9
                wordInput(p) = 'a';
            elseif wordInput(p) == 10 || wordInput(p) == 11
                wordInput(p) = 'b';
            elseif wordInput(p) == 12 || wordInput(p) == 13
                wordInput(p) = 'c';
            elseif wordInput(p) == 14 || wordInput(p) == 15 || wordInput(p)...
                    == 16 || wordInput(p) == 17 
                wordInput(p) = 'd';
            elseif wordInput(p) == 18 || wordInput(p) == 19 || wordInput(p)...
                == 20 || wordInput(p) == 21 || wordInput(p) == 22 || wordInput(p)...
                == 23 || wordInput(p) == 24 || wordInput(p) == 25 || wordInput(p)...
                == 26 || wordInput(p) == 27 || wordInput(p) == 28 || wordInput(p) == 29
                wordInput(p) = 'e';
            elseif wordInput(p) == 30 || wordInput(p) == 31
                wordInput(p) = 'f';
            elseif wordInput(p) == 32 || wordInput(p) == 33 || wordInput(p)...
                    == 34
                wordInput(p) = 'g';
            elseif wordInput(p) == 35 || wordInput(p) == 36
                wordInput(p) = 'h';
            elseif wordInput(p) == 37 || wordInput(p) == 38 || wordInput(p)...
                == 39 || wordInput(p) == 40 || wordInput(p) == 41 || wordInput(p)...
                == 42 || wordInput(p) == 43 || wordInput(p) == 44 || wordInput(p)...
                == 45
                wordInput(p) = 'i';
            elseif wordInput(p) == 46
                wordInput(p) = 'j';
            elseif wordInput(p) == 47
                wordInput(p) = 'k';
            elseif wordInput(p) == 48 || wordInput(p) == 49 || wordInput(p) == 50 || wordInput(p)...
                == 51 
                wordInput(p) = 'l';
            elseif wordInput(p) == 52 || wordInput(p) == 53
                wordInput(p) = 'm';
            elseif wordInput(p) == 54 || wordInput(p) == 55 || wordInput(p)...
                == 56 || wordInput(p) == 57 || wordInput(p) == 58 || wordInput(p)...
                == 59 
                wordInput(p) = 'n';
            elseif wordInput(p) == 60 || wordInput(p) == 61 || wordInput(p)...
                == 62 || wordInput(p) == 63 || wordInput(p) == 64 || wordInput(p)...
                == 65 || wordInput(p) == 66 || wordInput(p) == 67 
                wordInput(p) = 'o';
            elseif wordInput(p) == 68 || wordInput(p) == 69
                wordInput(p) = 'p';
            elseif wordInput(p) == 70
                wordInput(p) = 'q';
            elseif wordInput(p) == 71 || wordInput(p) == 72 || wordInput(p) == 73 || wordInput(p)...
                == 74 || wordInput(p) == 75 || wordInput(p) == 76 
                wordInput(p) = 'r';
            elseif wordInput(p) == 77 || wordInput(p) == 78 || wordInput(p) == 79 || wordInput(p)...
                == 80 
                wordInput(p) = 's';
            elseif wordInput(p) == 81 || wordInput(p) == 82 || wordInput(p) == 83 || wordInput(p)...
                == 84 || wordInput(p) == 85 || wordInput(p) == 86 
                wordInput(p) = 't';
            elseif wordInput(p) == 87 || wordInput(p) == 88 || wordInput(p) == 89 || wordInput(p)...
                == 90 
                wordInput(p) = 'u';
            elseif wordInput(p) == 91 || wordInput(p) == 92
                wordInput(p) = 'v';
            elseif wordInput(p) == 93 || wordInput(p) == 94
                wordInput(p) = 'w';
            elseif wordInput(p) == 95 
                wordInput(p) = 'x';
            elseif wordInput(p) == 96 || wordInput(p) == 97
                wordInput(p) = 'y';
            elseif wordInput(p) == 98
                wordInput(p) = 'z';
            else
            end
        end
       
        if length(wordInput) > 1
        %checks if wordInput is a real word 
        dictionary = fileread('words_alpha.txt'); %downloads text file of all words in English dictionary!
%         wordInput2 = char(wordInput);
%         wordInput = lower(wordInput2) %lowercase
        l = length(wordInput);
        k = strfind(dictionary,wordInput);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) %goes through each of the instances that contains the wordInput and checks whether the entry = the word 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1) %goes through k and checks whether there is a space before and after in the database, checking whether it is an independent word 
                wordChecker = 1; %confirms it is a valid word
            end
        end

        if wordChecker == 0
            points = 0;
        end
        end

        if wordChecker == 1
        points = 0; %initializes points as 0 
        lengthofWord = length(wordInput);
        if lengthofWord > 1
        for counter = 1:lengthofWord  %goes through length of word and maps a point value to each letter in the word
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput(counter) == firstString(counter1)
                    points = points + 1
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end
        originalpoints = points; %keeps track of what points were due to original word's letters
        end
        end
        end
        

        
        pos = 0; %initialize 
        for x = 1:15 %check horizontally if a word is horizontal 
            if sum(xypos(x,:) ~= 0)> 1 %word is horizontal 
                pos = 1; 
                row = x; %row it is in
            end
        end

        if pos == 0 %find vertical word starting point 
            for y = 1:15 
                if sum(xypos(:,y) ~= 0) > 1
                    col = y; %column it is in 
                    pos = 2;
                end
            end
        end

        %key to board matrix; 3 means triple word, 6
        %means triple letter, 2 means double word, 4
        %means double letter
        board = [ 0 0 0 3 0 0 6 0 6 0 0 3 0 0 0;...
                  0 0 4 0 0 2 0 0 0 2 0 0 4 0 0;...
                  0 4 0 0 4 0 0 0 0 0 4 0 0 4 0;...
                  3 0 0 6 0 0 0 2 0 0 0 6 0 0 3;...
                  0 0 4 0 0 0 4 0 4 0 0 0 4 0 0;...
                  0 2 0 0 0 6 0 0 0 6 0 0 0 2 0;...
                  6 0 0 0 4 0 0 0 0 0 4 0 0 0 6;...
                  0 0 0 2 0 0 0 0 0 0 0 2 0 0 0;...
                  6 0 0 0 4 0 0 0 0 0 4 0 0 0 6;...
                  0 2 0 0 0 6 0 0 0 6 0 0 0 2 0;...
                  0 0 4 0 0 0 4 0 4 0 0 0 4 0 0;...
                  3 0 0 6 0 0 0 2 0 0 0 6 0 0 3;...
                  0 4 0 0 4 0 0 0 0 0 4 0 0 4 0;...
                  0 0 4 0 0 2 0 0 0 2 0 0 4 0 0;...
                  0 0 0 3 0 0 6 0 6 0 0 3 0 0 0];

            if pos == 1 || singletest == 1 %word is horizontal or a single letter 
                doubleW = 0; %initializing tracker for double/triple word tiles 
                tripleW = 0; 
                finder = 0;
                n = 0;
                while finder == 0 %to find the first row and set as startpos
                    n = n+1;
                    if xypos(row,n) ~= 0
                        finder = 1;
                        startpos = n;
                    end
                end
                for pts = 1:length(wordInput)
                    if board(row,startpos)== 0
                        startpos = startpos + 1;
                    elseif board(row,startpos) == 4 %DL
                        letter = xypos(row,startpos);
                        points2 = letterCheck(letter); %goes to letter function to calculate point value of that letter
                        points = points + points2;
                        startpos = startpos + 1;
                    elseif board(row,startpos) == 6 %TL 
                        letter = xypos(row,startpos);
                        points2 = letterCheck(letter);
                        points = points + points2*2;
                        startpos = startpos + 1;
                    elseif board(row,startpos) == 2 %DW
                        doubleW = 1;
                    elseif board(row,startpos) == 3 %TW
                        tripleW = 1;
                    else
                    end
                end
                    
            elseif pos == 2 %does the same for a vertical word as above 
                doubleW = 0; %initializing tracker for double/triple word tiles 
                tripleW = 0; 
                finder = 0;
                n = 0;
                while finder == 0 %to find the first row and set as startpos
                    n = n+1;
                    if xypos(n,col) ~= 0
                        finder = 1;
                        startpos = n;
                    end
                end
                for pts = 1:length(wordInput)
                    if board(startpos,col)== 0
                        startpos = startpos + 1;
                    elseif board(startpos,col) == 4 %DL
                        letter = xypos(startpos,col);
                        points2 = letterCheck(letter); %NEED TO WRITE LETTER FUNCTION
                        points = points + points2;
                        startpos = startpos + 1;
                    elseif board(startpos,col) == 6 %TL 
                        letter = xypos(startpos,col);
                        points2 = letterCheck(letter);
                        points = points + points2*2;
                        startpos = startpos + 1;
                    elseif board(startpos,col) == 2 %DW
                        doubleW = 1;
                    elseif board(startpos,col) == 3 %TW
                        tripleW = 1;
                    else
                    end
                end
            
            
            if pts == length(wordInput) %if done calculating points 
                if doubleW == 1
                    points = points * 2; %take total word points and double them
                 elseif tripleW == 1
                    points = points * 3; %triple total word points 
                else
                 end
            end  
            end
            
            %This section of the code then compares the
            %wordInput to surrounding words using the
            %p1Board matrix; Checks for multiple words
            %and calculates surrounding words' points 
       
            if error == 0
            N = zeros(17); 
            N(2:16,2:16) = p1Board(1:15,1:15);
            if pos == 1 || pos == 0 %horizontal word check 
            if N(Hrow+1,Hcol) ~= 0 %word has been added on to another after it 
             j = 0;
             while N(Hrow+1,Hcol-(j+1))~=0 
%                  || (Hcol-j ~= 1) %while there are still continuous letters or reaches beginning
                 j = j+1; %purpose - to find where word begins 
             end
             wordInput2 = N(Hrow+1,Hcol-j:Hcol+1 + (length(wordInput)-1));
            for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        wordInput2 = char(wordInput2);
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
            end
        
        if singletest == 0
         for k = 1:length(wordInput) %word length; checks above and below each of the tiles in the word to check for words 
             if N(Hrow,Hcol+k)~= 0  %adjust to N instead of board, means there is a word above and/or below
                  j = 1;
                while N(Hrow-j,Hcol+k)~=0  %while there are still continuous letters above
                 j = j+1;
                end
                h = 2;
                while N(Hrow+h,Hcol+k) ~= 0  %check downwards 
                    h = h+1;
                end
                wordInput2 = (N(row-j:row+h,Hcol+k));
                    for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        wordInput2 = char(wordInput2);
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
             end
         
                
         end
        end
            
         
         if N(Hrow+1,Hcol+length(wordInput)+1) ~= 0 %if there are letters after the wordInput on the board
             m = 1;
             while N(Hrow+1,Hcol+length(wordInput)+(m+1))~=0 
%                  || (Hcol-m ~= 15) %while there are still continuous letters or reaches beginning
                 m = m+1; %purpose - to find where word begins 
             end
             wordInput2 = N(Hrow+1,Hcol+1:Hcol+m + (length(wordInput)));
             for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
             
         end
            end
        if pos == 2 || pos == 0 %does the same check for vertical words and single letters 
              if N(Vrow,Vcol + 1) ~= 0 %if wordInput is below existing letters 
                  j = 0;
                  while N(Vrow-(j+1),Vcol+1)~= 0 
%                       || (Vrow - j ~= 1)
                      j = j+1; 
                  end
                  wordInput2 = N(Vrow-j:Vrow + length(wordInput), Vcol+1);
           for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        wordInput2 = wordInput2';
        wordInput2 = char(wordInput2);
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
        
              end
             if singletest == 0 
            for k = 1:length(wordInput) %wordlength; checks each letter in word's right and left sides for words
                if N(Vrow+k,Vcol) ~= 0 || N(Vrow + k,Vcol + 2) ~= 0 
                    j = 1;
                    while N(Vrow+k,Vcol-j) ~= 0 
                        j = j+1;
                    end
                    h = 2;
                    while N(Vrow + k,Vcol + h) ~= 0 
                        h = h+1;
                    end
                    wordInput2 = p1Board(Vrow+k,Vcol - j:Vcol + k);
                    for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
                    
                end
            end
             end
           
            if N(Vrow+length(wordInput)+1,Vcol+1) ~= 0 %checks after below word for letters 
                m = 1;
                while N(Vrow+length(wordInput)+(m+1),Vcol+1) ~= 0 
                    m = m+1;
                end
                wordInput2 = N(Vrow+1:Vrow+m+length(wordInput),Vcol +1);
                for p = 1:length(wordInput2)
            if wordInput2(p) == 1 || wordInput2(p) == 2 || wordInput2(p)...
                == 3 || wordInput2(p) == 4 || wordInput2(p) == 5 || wordInput2(p)...
                == 6 || wordInput2(p) == 6 || wordInput2(p) == 7 || wordInput2(p)...
                == 8 || wordInput2(p) == 9
                wordInput2(p) = 'a';
            elseif wordInput2(p) == 10 || wordInput2(p) == 11
                wordInput2(p) = 'b';
            elseif wordInput2(p) == 12 || wordInput2(p) == 13
                wordInput2(p) = 'c';
            elseif wordInput2(p) == 14 || wordInput2(p) == 15 || wordInput2(p)...
                    == 16 || wordInput2(p) == 17 
                wordInput2(p) = 'd';
            elseif wordInput2(p) == 18 || wordInput2(p) == 19 || wordInput2(p)...
                == 20 || wordInput2(p) == 21 || wordInput2(p) == 22 || wordInput2(p)...
                == 23 || wordInput2(p) == 24 || wordInput2(p) == 25 || wordInput2(p)...
                == 26 || wordInput2(p) == 27 || wordInput2(p) == 28 || wordInput2(p) == 29
                wordInput2(p) = 'e';
            elseif wordInput2(p) == 30 || wordInput2(p) == 31
                wordInput2(p) = 'f';
            elseif wordInput2(p) == 32 || wordInput2(p) == 33 || wordInput2(p)...
                    == 34
                wordInput2(p) = 'g';
            elseif wordInput2(p) == 35 || wordInput2(p) == 36
                wordInput2(p) = 'h';
            elseif wordInput2(p) == 37 || wordInput2(p) == 38 || wordInput2(p)...
                == 39 || wordInput2(p) == 40 || wordInput2(p) == 41 || wordInput2(p)...
                == 42 || wordInput2(p) == 43 || wordInput2(p) == 44 || wordInput2(p)...
                == 45
                wordInput2(p) = 'i';
            elseif wordInput2(p) == 46
                wordInput2(p) = 'j';
            elseif wordInput2(p) == 47
                wordInput2(p) = 'k';
            elseif wordInput2(p) == 48 || wordInput2(p) == 49 || wordInput2(p) == 50 || wordInput2(p)...
                == 51 
                wordInput2(p) = 'l';
            elseif wordInput2(p) == 52 || wordInput2(p) == 53
                wordInput2(p) = 'm';
            elseif wordInput2(p) == 54 || wordInput2(p) == 55 || wordInput2(p)...
                == 56 || wordInput2(p) == 57 || wordInput2(p) == 58 || wordInput2(p)...
                == 59 
                wordInput2(p) = 'n';
            elseif wordInput2(p) == 60 || wordInput2(p) == 61 || wordInput2(p)...
                == 62 || wordInput2(p) == 63 || wordInput2(p) == 64 || wordInput2(p)...
                == 65 || wordInput2(p) == 66 || wordInput2(p) == 67 
                wordInput2(p) = 'o';
            elseif wordInput2(p) == 68 || wordInput2(p) == 69
                wordInput2(p) = 'p';
            elseif wordInput2(p) == 70
                wordInput2(p) = 'q';
            elseif wordInput2(p) == 71 || wordInput2(p) == 72 || wordInput2(p) == 73 || wordInput2(p)...
                == 74 || wordInput2(p) == 75 || wordInput2(p) == 76 
                wordInput2(p) = 'r';
            elseif wordInput2(p) == 77 || wordInput2(p) == 78 || wordInput2(p) == 79 || wordInput2(p)...
                == 80 
                wordInput2(p) = 's';
            elseif wordInput2(p) == 81 || wordInput2(p) == 82 || wordInput2(p) == 83 || wordInput2(p)...
                == 84 || wordInput2(p) == 85 || wordInput2(p) == 86 
                wordInput2(p) = 't';
            elseif wordInput2(p) == 87 || wordInput2(p) == 88 || wordInput2(p) == 89 || wordInput2(p)...
                == 90 
                wordInput2(p) = 'u';
            elseif wordInput2(p) == 91 || wordInput2(p) == 92
                wordInput2(p) = 'v';
            elseif wordInput2(p) == 93 || wordInput2(p) == 94
                wordInput2(p) = 'w';
            elseif wordInput2(p) == 95 
                wordInput2(p) = 'x';
            elseif wordInput2(p) == 96 || wordInput2(p) == 97
                wordInput2(p) = 'y';
            elseif wordInput2(p) == 98
                wordInput2(p) = 'z';
            else
            end
        end
       
        %checks if wordInput2 is a real word 
        wordInput2 = wordInput2'; %transposes vertical vector 
        wordInput2 = char(wordInput2); %changes to characters
        dictionary = fileread('words_alpha.txt');
        l = length(wordInput2);
        k = strfind(dictionary,wordInput2);

        %find a way to distinguish spaces
        wordChecker = 0;
        i = 0;
        while wordChecker == 0 && (i ~= length(k)) 
            i = i + 1;
            if (isspace(dictionary(k(i)-1))==1) && (isspace(dictionary(k(i) + l))==1)
                wordChecker = 1;
            end
        end

        if wordChecker == 0
            points = 0;
            error = 1;
        end

        if wordChecker == 1
        lengthofWord = length(wordInput2);
        for counter = 1:lengthofWord 
            for counter1 = 1:7
                firstString = 'aeiostr';
                if wordInput2(counter) == firstString(counter1)
                    points = points + 1;
                end
            end
            for counter2 = 1:4
                secondString = 'dlun';
                if wordInput2(counter) == secondString(counter2)
                points = points + 2; 
                end
            end
            for counter3 = 1:2
                thirdString = 'gy';
                if wordInput2(counter) == thirdString(counter3)
                points = points + 3;
                end
            end
            for counter4 = 1:7
                fourthString = 'fhwbcmp';
                if wordInput2(counter) == fourthString(counter4)
                points = points + 4;
                end
            end
            for counter5 = 1:2 
                fifthString = 'vk';
                if wordInput2(counter) == fifthString(counter5)
                points = points + 5;
                end
            end
            if  wordInput2(counter) == 'x'
                points = points + 8;
            end
            for counter6 = 1:3
                sixthString = 'qjz';
                if wordInput2(counter) == sixthString(counter5)
                points = points + 10;
                end
            end
        end     
        end
                if points == 0
                    error = 1;
                end
            end
        end
            if points ~= originalpoints 
            points = points - originalpoints; %substracts original points is different so as to not double count points for letters used in other words
            end
            
        if error == 1
            points = 0;
        end
            end
    turnOver = 0; %turn is not over unless valid word is submitted 
    if points == 0 %instructs user to submit another word 
        set(b,'String','The word submitted was not a word. Please return your tiles to your dock and then submit another word!')
        b.FontSize = 11;
        xypos = zeros(15,15); %resets xypos to zeros 
        turnOver = 0;
    else
        set(b,'String',['Points: ' num2str(points)]);
        b.FontSize = 18;
        turnOver = 1; %turn can be over
        if turn == 1 %adds to player one or player two's points and updates the visual
        p2points = p2points + points;
        set(c,'String',['Player 1 Score:' num2str(p2points)]); %get points display to update  
        elseif turn == 2
        p3points = p3points + points;
        set(e,'String',['Player 2 Score:' num2str(p3points)]);
        end
    end 
    end

    
   uicontrol('Style','Pushbutton','Units','Normalized','Position',[0.42 0 .2 .05],'String','Get New Tiles', 'CallBack',{@dockPlot1,p1}) %callback button for receiving new tiles 

    
end
